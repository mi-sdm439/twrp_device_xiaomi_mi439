#!/sbin/sh

LAST_CODENAME_FILE="/cache/last-recovery-codename"

CODENAME_SET=""

set_device_codename() {
	if [ "$CODENAME_SET" ]; then return; fi
	CODENAME_SET="1"

	resetprop "ro.build.product" "$1"
	resetprop "ro.omni.device" "$1"
	resetprop "ro.product.device" "$1"
	for i in odm product system system_ext vendor; do
		resetprop "ro.product.${i}.device" "$1"
	done
}

set_device_model() {
	resetprop "ro.product.model" "$1"
	for i in odm product system system_ext vendor; do
		resetprop "ro.product.${i}.model" "$1"
	done
}

if [ -f "$LAST_CODENAME_FILE" ]; then
	if [ "cat $LAST_CODENAME_FILE || true" ]; then
		set_device_codename "$(cat $LAST_CODENAME_FILE)"
	fi
fi

case "$(cat /sys/firmware/devicetree/base/model)" in
	"PINE QRD")
		set_device_codename "pine"
		set_device_model "Redmi 7A"
		;;
	"Olive QRD")
		set_device_codename "olives"
		set_device_model "Redmi 8 / 8A / 8A Dual"
		setprop "persist.vendor.ctm.disallowed" "true"
		;;
esac

exit 0
