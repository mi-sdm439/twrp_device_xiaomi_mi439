#!/sbin/sh

LAST_CODENAME_FILE="/cache/last-recovery-codename"

set_device_codename() {
	resetprop "ro.build.product" "$1"
	resetprop "ro.omni.device" "$1"
	resetprop "ro.product.device" "$1"
	for i in odm product system system_ext vendor; do
		resetprop "ro.product.${i}.device" "$1"
	done

	if ! [ -f "$LAST_CODENAME_FILE" ] || [ "$(cat $LAST_CODENAME_FILE || true)" != "$1" ]; then
		echo -n "$1" > $LAST_CODENAME_FILE || true
	fi
}
