" remove trailing white space
command Nows :%s/\s\+$//

" remove blank lines
command Nobl :g/^\s*$/d
