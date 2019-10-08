#!/bin/bash

pvfile='test-pvs.dat'
pvstat='pv-stats.dat'

# 1: number, 2: char, 3: file
pprint ()
{
    n=$1
    c=$2
    f=$3
    for ((i=1;i<=$n;i++)) do
        printf "%s" $c | tee -a $f
    done
    printf "\n" | tee -a $f

}

> ${pvstat}

pprint 70 '-' ${pvstat}
printf "%-28s %18s %22s\n" "NAME" "VAL" "HOST" | tee -a ${pvstat}
pprint 70 '-' ${pvstat}

while read pv
do
    pv_host=$(cainfo $pv 2>/dev/null | grep 'Host' | awk '{print $NF}')
    if [[ $pv_host != '<disconnected>' ]]; then
        pv_val=$(caget $pv | awk '{print $NF}')
        printf "%-28s %18f %22s\n" $pv $pv_val $pv_host | tee -a ${pvstat}
    else
        printf "%-28s %18s %22s\n" $pv 'none' $pv_host | tee -a ${pvstat}
    
    fi
done < ${pvfile}
pprint 70 '-' ${pvstat}
