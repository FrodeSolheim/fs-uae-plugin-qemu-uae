version = $(strip $(shell cat VERSION))
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

distdir:
	rm -Rf $(name)-$(version)
	mkdir $(name)-$(version)
	cp Makefile $(name)-$(version)
	cp plugin.ini $(name)-$(version)
	cp README.md $(name)-$(version)
	cp VERSION $(name)-$(version)

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
	rm -f $(name)-$(version)/qemu-uae/dtc/tests/.gitignore
	rm -f $(name)-$(version)/qemu-uae/dtc/.gitignore
	rm -Rf $(name)-$(version)/qemu-uae/dtc/.git
	rm -f $(name)-$(version)/qemu-uae/tests/.gitignore
	rm -f $(name)-$(version)/qemu-uae/tests/qemu-iotests/.gitignore
	rm -f $(name)-$(version)/qemu-uae/.gitignore
	rm -f $(name)-$(version)/qemu-uae/pixman/.gitignore
	rm -Rf $(name)-$(version)/qemu-uae/pixman/.git
	rm -Rf $(name)-$(version)/qemu-uae/.git
	rm -f $(name)-$(version)/qemu-uae/.gitmodules

dist: distdir
	tar Jcf $(name)-$(version).tar.xz $(name)-$(version)
	rm -Rf $(name)-$(version)

deb_version = 0
deb_series = unstable

source-deb: distdir
	test -f $(name)_$(version).orig.tar.xz || tar -cJ --strip-components=1 -f $(name)_$(version).orig.tar.xz $(name)-$(version)
	sed -i "s/$(version)-0) unstable/$(version)-$(deb_version)$(deb_series)) $(deb_series)/g" $(name)-$(version)/debian/changelog
	cd $(name)-$(version) && dpkg-buildpackage -S -us -uc

clean:
	# cd qemu-uae && ./configure
	# make -C qemu-uae clean
