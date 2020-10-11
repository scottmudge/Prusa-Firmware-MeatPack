#!/bin/bash

################################################################################
# Description:
# Rename all hex files after a firmware build and zip MK2.5S versions
################################################################################

# Constants
SCRIPTDIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
CURRENTDIR="$( pwd )"
TODAY=$(date +'%Y%m%d')
HEXDIR="$DRONE_WORKSPACE/out"    # absolute link

cd "${HEXDIR}"

# Rename MK3S hex file & GET FW
hexfile=$(ls *Build*MK3S-EINSy10a*.hex)
fwbuild=$(echo ${hexfile} | sed 's/^FW//; s/-Build/-B/' | awk -F[-_] '{ printf("%s-%s", $1, $2) }' )
newhexfile=$(echo ${hexfile} | awk -F[-_] -v fwb="$fwbuild" '{ printf("BearFW_Cal_%s_%s-%s", fwb, $6, $7) }' )
echo "${hexfile}  -->  ${newhexfile}"
mv ${hexfile} ${newhexfile}

# Rename and ZIP MK2.5S hex files for Rambo 13a
for hexfile in $(ls *Build*MK25S-RAMBo13a*.hex); do
    newhexfile=$(echo ${hexfile} | awk -F[-_] -v fwb="$fwbuild" '{ printf("BearFW_Cal_%s_%s-%s-%s", fwb, $6, $7, $8) }' )
    echo "${hexfile}  -->  ${newhexfile}"
    mv ${hexfile} ${newhexfile}
done

echo "create zip..."
zip -mq BearFW_Cal_${fwbuild}_MK25S-RAMBo13a.zip *MK25S-RAMBo13a*.hex

# Rename and ZIP MK2.5S hex files for Rambo 10a
for hexfile in $(ls *Build*MK25S-RAMBo10a*.hex); do
    newhexfile=$(echo ${hexfile} | awk -F[-_] -v fwb="$fwbuild" '{ printf("BearFW_Cal_%s_%s-%s-%s", fwb, $6, $7, $8) }' )
    echo "${hexfile}  -->  ${newhexfile}"
    mv ${hexfile} ${newhexfile}
done
echo "create zip..."
zip -mq BearFW_Cal_${fwbuild}_MK25S-RAMBo10a.zip *MK25S-RAMBo10a*.hex

ls *.*

cd "${CURRENTDIR}"
