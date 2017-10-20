#!/usr/local/bin/bash
## create encrypted containers, for use with tcplay
## create hidden volumes; plausible deniability
## use of keyfiles; working on it.
## see man tcplay
## https://wiki.archlinux.org/index.php/Tcplay
## mount volumes after creation with this script, see:
## http://jasonwryan.com/blog/2013/01/10/truecrypt/


user=shiro
runuser -l  "$user" -c 'losetup -f'
loopdev=$(losetup -f)

if [[ $EUID -ne 0 ]]; then
  printf "%s\n" "$0 must be run as root user."
  exit 1
fi

retvalins=$?
   read -p "full path, where volume will be created?  : " tcplaypath
   read -p "name for the volume to create?  : " tcplayname
   read -p "size?, e.g: 10M, 10G  : " tcplaysize
   read -p "hash function? valid options: tcplay -a help , default: whirlpool [ENTER] : " encrypthash
   read -p "block cipher? valid options: tcplay -b help , default: AES-256-XTS [ENTER] : " encryptcipher
   
[[ $retvalins -ne 0 ]]
   mkdir -p "$tcplaypath"
   cd "$tcplaypath"

   fallocate -l "$tcplaysize" "$tcplayname"
   losetup "$loopdev" "$tcplayname"

## prompt user for hidden folder creation, only Y or N are accepted.
while true
do
  read -p "create hidden volume? Y(es) or N(o) : " hide
  case $hide in
   [Y]* )
  break;;
   [N]* )
  break;;		
   * ) printf "What will it be, Y or N ??\n"
  esac
done

    if [[ -z "$encrypthash" ]] || [[ -z "$encryptcipher" ]] && [[ "$hide" == Y ]]; then
      printf "Default cipher & hash & hidden\n"
      tcplay -c -d "$loopdev" -a whirlpool -b AES-256-XTS -g
      elif [[ "$encrypthash" ]] && [[ "$encryptcipher" ]] && [[ "$hide" == Y ]]; then
        printf "You're choice %s\n" "$encrypthash $encryptcipher & hidden."
        tcplay -c -d "$loopdev" -a "$encrypthash" -b "$encryptcipher" -g
        elif [[ -z "$encrypthash" ]] || [[ ! "$encrypthash" ]] || [[ -z "$encryptcipher" ]] || [[ ! "$encryptcipher" ]]  && [[ "$hide" == N ]]; then
          printf "Cipher or hash not found, using default, no hidden.\n"
          tcplay -c -d "$loopdev" -a whirlpool -b AES-256-XTS
          elif [[ "$encrypthash" ]] && [[ "$encryptcipher" ]] && [[ "$hide" == N ]]; then
            printf "You're choice %s\n" "$encrypthash $encryptcipher, no hidden."
            tcplay -c -d "$loopdev" -a "$encrypthash" -b "$encryptcipher"
    fi

   ## map container to loop device
   tcplay -m "$tcplayname" -d "$loopdev"


retvalfsmount=$?
   read -p "file system?, default: ext4 [ENTER] : " tcplayfs
   read -p "mount point?, or exit script? [ENTER] : " tcplaymount
  
[[ $retvalfsmount -ne 0 ]] && exit 0
    if [[ ! "$tcplayfs" ]]; then
      printf "File system not found, using default\n."
      mkfs.ext4 /dev/mapper/"$tcplayname"
    else
      printf "You're choice, formating to %s\n" "$tcplayfs"
      mkfs."$tcplayfs" /dev/mapper/"$tcplayname"
    fi
      if [[ ! "$tcplaymount" ]]; then
        dmsetup remove "$tcplayname"
        losetup -d "$loopdev"
        exit 1
        ## mount options
        ##  ext3, -4, vfat
        else
        if [[ "$tcplayfs" == ext* ]]; then
          mount -o nodev,nosuid /dev/mapper/"$tcplayname" "$tcplaymount"
            elif [[ "$tcplayfs" == vfat ]]; then          
              mount -o nodev,nosuid,uid=1000,gid=100 /dev/mapper/"$tcplayname" "$tcplaymount"
        fi
      fi