version = $(strip $(shell cat qemu-uae/VERSION.FS))
name = fs-uae-plugin-qemu-uae

DESTDIR =
prefix = /usr/local

all:
	cd qemu-uae && ./configure
	make -C qemu-uae

install: all
	install -D -m 0644 plugin.ini \
	$(DESTDIR)$(prefix)/lib/fs-uae/plugins/qemu-uae/plugin.ini
	install -D qemu-uae/qemu-uae.so \
	$(DESTDIR)$(prefix)/lib/fs-uae/plugins/qemu-uae/$(version)/qemu-uae.so

dist:
	rm -Rf $(name)-$(version)
	mkdir $(name)-$(version)
	cp Makefile $(name)-$(version)
	cp plugin.ini $(name)-$(version)

	mkdir $(name)-$(version)/debian
	cp debian/fs-uae-plugin-qemu-uae.install $(name)-$(version)/debian
	mkdir $(name)-$(version)/debian/source
	cp debian/source/format $(name)-$(version)/debian/source
	cp debian/changelog $(name)-$(version)/debian
	cp debian/compat $(name)-$(version)/debian
	cp debian/copyright $(name)-$(version)/debian
	cp debian/control $(name)-$(version)/debian
	cp debian/rules $(name)-$(version)/debian

	cp -a fs-uae $(name)-$(version)

	cp -a qemu-uae $(name)-$(version)
	rm $(name)-$(version)/qemu-uae/dtc/tests/.gitignore
	rm $(name)-$(version)/qemu-uae/dtc/.gitignore
	rm -Rf $(name)-$(version)/qemu-uae/dtc/.git
	rm $(name)-$(version)/qemu-uae/tests/.gitignore
	rm $(name)-$(version)/qemu-uae/tests/qemu-iotests/.gitignore
	rm $(name)-$(version)/qemu-uae/.gitignore
	rm $(name)-$(version)/qemu-uae/pixman/.gitignore
	rm -Rf $(name)-$(version)/qemu-uae/pixman/.git
	rm -Rf $(name)-$(version)/qemu-uae/.git
	rm $(name)-$(version)/qemu-uae/.gitmodules

	tar Jcf $(name)-$(version).tar.xz $(name)-$(version)
	# rm -Rf $(name)-$(version)

clean:
	make -C qemu-uae clean
