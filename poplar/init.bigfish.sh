#!/system/bin/sh
busybox date -s 201501010000.00
QBENABLE=`getprop persist.sys.qb.enable`
case $QBENABLE in
 true)
  ;;
 *)
  setprop sys.insmod.ko 1
  ;;
 esac

#echo 1000000 > /sys/devices/system/cpu/cpu0/cpufreq/scaling_max_freq
#echo interactive > /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
#echo 200000 > /sys/devices/system/cpu/cpufreq/interactive/timer_rate

#DVFS
echo 400000000 > /sys/devices/platform/soc/f9200000.gpu/devfreq/f9200000.gpu/max_freq

echo "\n\nWelcome to HiAndroid\n\n" > /dev/kmsg
LOW_RAM=`getprop ro.config.low_ram`
case $LOW_RAM in
 true)
  echo "\n\nenter low_ram mode\n\n" > /dev/kmsg
  echo 104857600 > /sys/block/zram0/disksize
  mkswap /dev/block/zram0
  swapon /dev/block/zram0
 #modules(memopt): Enable KSM in low ram device
  echo 1 > /sys/kernel/mm/ksm/run
  echo 300 > /sys/kernel/mm/ksm/sleep_millisecs
  ;;
 *)
  ;;
 esac
