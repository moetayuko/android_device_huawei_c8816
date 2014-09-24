on=`getprop recovery.log`
runmode=`getprop ro.runmode`
wipe_data=`getprop recovery.wipe_data`

case "$runmode" in
    "factory")
        if [ "$wipe_data" = "1" ]; then
            echo 1 > /sys/module/restart/parameters/download_mode
        else
            case "$on" in
                "on")
                    echo 1 > /sys/module/restart/parameters/download_mode
                    start applogcat
                    start kmsglogcat
                    ;;
                "off")
                    stop applogcat
                    stop kmsglogcat
                    ;;
            esac
       fi
       ;;
esac

