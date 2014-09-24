#!/system/bin/sh
#usage: chargelog.sh  <interval(sec)> <maxline>

PS_PATH="/sys/class/power_supply/"

#if some node infomation is redundant,the node should be commented
#in this array. 

NODE_NAME=( \
#---------------------------------------
#battery power supply
#---------------------------------------
"battery/capacity" \
#"battery/charge_full_design" \
"battery/charge_type" \
"battery/charging_enabled" \
#"battery/current_max" \
"battery/current_now" \
"battery/health" \
"battery/present" \
#"battery/status" \
#"battery/system_temp_level" \
#"battery/technology" \
"battery/temp" \
#"battery/type" \
"battery/voltage_max_design" \
"battery/voltage_min_design" \
"battery/voltage_now" \
#---------------------------------------
#bms power supply
#---------------------------------------
#"bms/capacity" \
#"bms/charge_full_design" \
#"bms/current_max" \
#"bms/current_now" \
#"bms/present" \
#"bms/type" \
#---------------------------------------
#usb power supply
#---------------------------------------
"usb/current_max" \
"usb/online" \
"usb/present" \
"usb/scope" \
#"usb/type" \
)

sdcard=1
charge_mode=1

#check if system partition has been mounted,
#if no, shell script can not execute. 
#this code block test this case.

id
if [ $? -ne 0 ];then
    exit
fi

#check if powerdown charge mode.
getprop ro.bootmode | grep hwcharger
if [ $? -eq 0 ];then
    echo "---> power down charge mode"
    charge_mode=0
    
    mount | grep /grow
    if [ $? -ne 0 ];then
        echo "---> internal sdcard is not mounted"
        sdcard=0
    fi
    
    mount | grep /data
    if [ $? -ne 0 ];then
        echo "---> mount data dir"
        mount -t ext4 /dev/block/platform/msm_sdcc.1/by-name/userdata /data
    fi
fi

#check log path
cat /data/property/persist.sys.chargelog | grep data
if [ $? -eq 0 ];then
    log_path="/data/chargelog.txt"
else
    cat /data/property/persist.sys.chargelog | grep sdcard
    if [ $? -eq 0 ];then
        log_path="/sdcard/chargelog.txt"
        if [ $sdcard -eq 0 ];then
            mount -t vfat /dev/block/platform/msm_sdcc.1/by-name/grow /sdcard
        fi
    else
        echo "---> disable charge log"
        stop chargelog
        read
    fi
fi

echo "---> log path is $log_path"

#print item name in this loop
cat $log_path | grep time
if [ $? -ne 0 ];then
    echo -n "time " >> $log_path
    for path in ${NODE_NAME[@]}
    do
        echo -n "$path" >> $log_path
        echo -n ' ' >> $log_path
    done
    echo >> $log_path
fi

chmod 777 $log_path

#print item value in this loop
line_no=0

while :
do
    echo -n `date +%H:%M:%S` >> $log_path
    echo -n ' ' >> $log_path

    for path in ${NODE_NAME[@]}
    do
        echo -n `cat "$PS_PATH$path"` >> $log_path
        echo -n ' ' >> $log_path
    done
    
    if [ charge_mode -eq 1 ];then
        echo -n "normal" >> $log_path
    else
        echo -n "powerdown" >> $log_path
    fi
    
    echo >> $log_path
	
    ((line_no++))
    if [ $line_no -eq $2 ];then
        mv $log_path $log_path".old"
        line_no=0
    fi
    sync
    sleep $1
done
