#!/bin/bash
#
# Fix flash HTML files in REN_HOME/var/flash
#
set -x

CMD="sed -i -- "s/http\\:\\/\\/potato\\.ghostcloud\\.nl\\//https\\:\\/\\/ghostcloud\\.potato\\.com\\//g""
FILE="*.html"
fixENV=""
REN_HOME="$HOME"

#Check Arguments
if [ "$#" -lt 1 ]; then
        printf "No arguments given\n"
        printf "Usage: $0\n"
        printf "$0 -e production -f *.html\n"
        printf "Testing $0 is done with\n\n $0 -d <TESTING LOCATION>\n -d will fill the FLASH_loc variable in the script and skip checking other vars.\n"
        exit 1
fi

# Get requierd vars
while getopts "f:e:d:" opts; do
        case $opts in
                f)
                export FILE="$OPTARG"
                ;;
                e)
                export fixENV="$OPTARG"
                ;;
                d)
                export FLASH_loc="$OPTARG"
                export DEBUG="1"
                ;;
        esac
done

# Check vars
if [[ -z $FLASH_loc ]]; then
        if [[ -z $fixENV ]]; then
                printf "\$fixENV empty, exit"
                exit
        fi

        if [[ -z $FILE ]]; then
                printf "\$FILE empty, exit"
                exit
        fi

        if [[ ! -d "$REN_HOME/$fixENV" ]]; then
                printf "Environment not found in \$HOME"
                exit
        fi

        if [ -z "$DEBUG" -o "$DEBUG" == "0" ]; then
                FLASH_loc="$REN_HOME/$fixENV/var/flash"
        fi

        if [[ ! -d $FLASH_loc ]]; then
                printf "No flash dir. Something else is wrong.."
                exit 2
        fi
fi

printf "Using the following VARS:\n\$FILE=%s\n\$REN_HOME=%s\n\$fixENV=%s\n\$FLASH_loc=%s\n\nContinue?\n" "$FILE" "$REN_HOME" "$fixENV" "$FLASH_loc"
read ANS
if [ $ANS == "y" -o $ANS == "Y" ]; then
        # MAIN #
        cd $FLASH_loc
        if [[ $(pwd) == $FLASH_loc ]]; then
                find . -name "*.html" > /dev/null
                RET="$?"
                if [[ $RET -eq '0' ]]; then
                        printf "Executing $CMD $FILE\n"
                        $CMD $FILE
                else
                        printf "No files found with expression %s" $FILE
                fi
        else
                printf "Something went wrong, we're in $(pwd) now..."
                printf "Manually go to the correct flash location and execute\n%s" $CMD
                exit 3
        fi
else
        printf "User abort\n"
        exit
fi
