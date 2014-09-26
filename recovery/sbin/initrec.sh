#!/sbin/sh

# Check if powerdown charge mode.
getprop ro.bootmode | grep hwcharger
recovery=$?

# Don't start recovery if we're in charge mode. Turn off soft keys light.
if [ $recovery == 0 ] ; then
 start charge
 echo 0 > /sys/class/leds/button-backlight/brightness
 exit 0
fi

# Kill charge
killall charge

# Turn on soft keys light for recovery mode.
echo 80 > /sys/class/leds/button-backlight/brightness
echo 255 > /sys/class/leds/red/brightness
echo 255 > /sys/class/leds/green/brightness

# We haven't exited, start recovery.
/sbin/recovery
