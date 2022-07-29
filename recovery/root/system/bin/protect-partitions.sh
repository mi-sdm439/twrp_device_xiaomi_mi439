#!/system/bin/sh -e

# Manually Set Variables
BOOTDEVICE="$(getprop ro.boot.bootdevice)"
UNPROTECTED_PARTITIONS_REGEX="^boot$|^dtbo$|^recovery$|^vbmeta$|^cache$|^userdata$|^system$|^vendor$|^cust$|^misc$|^persist$|^splash$|^fs.$|^modemst.$"

# Generated variables
PROTECTED_PARTITIONS="$(ls /dev/block/platform/soc/${BOOTDEVICE}/by-name/|eval grep -vE \"${UNPROTECTED_PARTITIONS_REGEX}\")"

# Make protected partitions read-only
log "Protected partitions: " $PROTECTED_PARTITIONS
for p in $PROTECTED_PARTITIONS; do
    blkroset /dev/block/platform/soc/${BOOTDEVICE}/by-name/${p} || true
done

exit 0
