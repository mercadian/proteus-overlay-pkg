all: proteus-overlay

proteus-overlay:
	dtc -O dtb -o sta-led-overlay.dtbo -@ src/sta-led-overlay.dts

install: proteus-overlay
	install -m 0755 sta-led-overlay.dtbo /boot/proteus
	install -m 0755 src/config_proteus_overlay /usr/sbin/
	install -m 0755 src/zzz_config_proteus_overlay /etc/kernel/postinst.d/
	install -m 0755 src/zzz_config_proteus_overlay /etc/kernel/postrm.d/

clean: proteus-overlay
	rm sta-led-overlay.dtbo