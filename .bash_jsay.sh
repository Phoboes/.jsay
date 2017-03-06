#!/bin/sh

#############################################################################
# For light terminals: call jlism, for dark, pass l as a parameter: jlism l #
#############################################################################

jlism () {
  clear
  win_width="$(tput cols)"

  if [[ $1 = "d" && $win_width -gt 80 ]]; 
    then
    file_line=4
  elif [[ $1 = "d" && $win_width -gt 69 ]]; 
    then
   file_line=3
  elif [[ $1 = "l" && $win_width -gt 96 ]]; 
    then
   file_line=1
  elif [[ $1 = "l" && $win_width -gt 69 ]];
    then
   file_line=2
   else 
    file_line=0
  fi

  #################################
  # Pluck a random line from file.#
  #################################

  FILE=~/.jsay/srctxt/jisms.txt
  # get line count for $FILE (simulate 'wc -l')
  lc=0
  while read -r line; do
   ((lc++))
  done < $FILE
  # get a random number between 1 and $lc
  rnd=$RANDOM
  let "rnd %= $lc"
  ((rnd++))
  # traverse file and find line number $rnd
  i=0
  while read -r line; do
   ((i++))
   [ $i -eq $rnd ] && break
  done < $FILE

  ######################################################
  # Break string on *. Iterate through lines & center. #
  ######################################################

  file_string=$(sed -n "$file_line p" ~/.jsay/srctxt/jedstr.txt)
  IFS="*"
  win_width="$(tput cols)"
  for var in $file_string
    do
      printf "\n%*s" $(( (${#var} + win_width) / 2)) "$var"
  done
  printf "\n"

  ##################################
  # Return string centred in a box #
  ##################################

  lbreak=`printf '%*s' "$win_width" | tr ' ' "-"`
  printf "%*s\n" $(( (${#lbreak} + win_width) / 2)) "$lbreak"
  printf "\n%*s\n" $(( (${#line} + win_width) / 2)) "$line"
  printf "\n%*s\n" $(( (${#lbreak} + win_width) / 2)) "$lbreak"

}
