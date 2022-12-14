all: proteus-overlay

proteus-overlay:
	dtc -O dtb -o user-led-overlay.dtbo -@ src/user-led-overlay.dts.preprocessed

install: proteus-overlay
	install -m 0755 user-led-overlay.dtbo /lib/proteus
	cp /lib/proteus/user-led-overlay.dtbo /boot/proteus
	install -m 0755 src/config_proteus_overlay /usr/sbin/
	install -m 0755 src/zzz_config_proteus_overlay /etc/kernel/postinst.d/
	install -m 0755 src/zzz_config_proteus_overlay /etc/kernel/postrm.d/
	/bin/sh -c '/usr/sbin/config_proteus_overlay'

clean: proteus-overlay
	rm user-led-overlay.dtbo