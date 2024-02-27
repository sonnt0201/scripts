#!/bin/bash

# set -x

source status.sh

addr_text="./addr.txt"

info=$(ifconfig)
status=$FAIL
for (( begin=0; begin<${#info}; begin++ )); do
    if [ "${info:begin:8}" = "192.168." ]; then
        for (( len=9; len<=15; len++ )); do
            end=$(( begin+len ))
            if [ "${info:end:1}" = " " ]; then
                # echo "${info:end:1}"

                # get output
                out="${info:begin:len}"
               

                # print to console and text file
                echo "$out"
                echo "$out" > v4addr.txt

                # copy to clipboard
                if ! command -v xclip &> /dev/null; then
                    echo "Error: Cannot copy address to clipboard due to xclip not found. Please install it using: "
                    echo "sudo apt-get install xclip"
            
                else
                     # save to clipboard
                    echo -n "${out}" | xclip -selection clipborad
                    echo "address copied to clipboard."
                fi

                status=$DONE
                break
            fi
        done
        
        if [ "$status" -eq "$DONE" ]; then
            break
        fi
    fi
done
