fs-uae-plugin-qemu-uae
======================

QEMU-UAE Plugin for FS-UAE.

Compiling the Plugin
--------------------

Run "./configure" followed by "make" inside the qemu-uae subdirectory to
create qemu-uae/qemu-uae.so. If you have checked out the git repository, run
./bootstrap first.

Source Tarball
--------------

If you have checked out the git repository, run ./bootstrap to initialize
the qemu-uae submodule. Then you can run "make dist" to create a .tar.xz
source package suitable for distribution (if you have done anything inside
the qemu-uae directory, including running make there, re-run ./bootstrap
to ensure a clean qemu-uae directory before the tarball is created).
