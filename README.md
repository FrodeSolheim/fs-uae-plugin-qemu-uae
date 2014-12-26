fs-uae-plugin-qemu-uae
======================

This is the QEMU-UAE plugin for FS-UAE. If you have checked out the git
repository, you should run "./bootstrap" before doing anything else
(this will pull down and bootstrap the qemu-uae submodule).

Compiling the Plugin
--------------------

Run "make" to create qemu-uae/qemu-uae.so.

Installing the Plugin
---------------------

Run "make install" to install the plugin. You can provide the parameters
prefix and DESTDIR to control where it is installed.

Example:

   make install prefix=/usr DESTDIR=build/temp

Source Tarball
--------------

If you have checked out the git repository, run ./bootstrap to initialize
the qemu-uae submodule. Then you can run "make dist" to create a .tar.xz
source package suitable for distribution.

If you have done anything inside the qemu-uae directory, including running
make, re-run "./bootstrap" to ensure a clean qemu-uae directory before the
tarball is created, otherwise the tarball will be polluted with
unnecessary stuff.
