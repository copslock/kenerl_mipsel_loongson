Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 29 Nov 2004 00:50:24 +0000 (GMT)
Received: from iris1.csv.ica.uni-stuttgart.de ([IPv6:::ffff:129.69.118.2]:28451
	"EHLO iris1.csv.ica.uni-stuttgart.de") by linux-mips.org with ESMTP
	id <S8225245AbUK2AuN>; Mon, 29 Nov 2004 00:50:13 +0000
Received: from rembrandt.csv.ica.uni-stuttgart.de ([129.69.118.42])
	by iris1.csv.ica.uni-stuttgart.de with esmtp
	id 1CYZk4-0001al-00; Mon, 29 Nov 2004 01:50:12 +0100
Received: from ica2_ts by rembrandt.csv.ica.uni-stuttgart.de with local (Exim 3.35 #1 (Debian))
	id 1CYZk3-0001yH-00; Mon, 29 Nov 2004 01:50:11 +0100
Date: Mon, 29 Nov 2004 01:50:10 +0100
To: linux-mips@linux-mips.org
Cc: Guido Guenther <agx@sigxcpu.org>
Subject: arcboot patch: Improvements related to better O2 support
Message-ID: <20041129005010.GC6804@rembrandt.csv.ica.uni-stuttgart.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.5.6i
From: Thiemo Seufer <ica2_ts@csv.ica.uni-stuttgart.de>
Return-Path: <ica2_ts@csv.ica.uni-stuttgart.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ica2_ts@csv.ica.uni-stuttgart.de
Precedence: bulk
X-list: linux-mips

Hello All,

this patch against arcboot 0.3.8.4 started as a simple bugfix but grew
unexpectedly in size. The things it changes:

- Add tip32, similiar to tip22 but using ELF instead of ECOFF, and
  with a changed load address at 0x81404000 instead of the previous
  0x88000000. This allows the resulting image to load on machines
  with less than ~140 MB RAM.
- The arcboot loader for ip32 is now also ELF, and loaded at
  0x81404000, previously it overwrote some memory reserved by the
  ROM. (This might explain some weird failure modes). 
- The linker scripts are now more robust against alignment problems.
- The subarch detection at compile time is now more flexible.
- Switch some iterations in the Makefiles from shell to make, this
  improves parallelization of make runs.
- Added a 2.6 version of the ramdisk kernel patch (which recently
  went in the kernel CVS).
- Minor fixes in loader.c: More robust assembly code, changed the
  output from "32-/64-bit" to "ELF32/ELF64" Kernel.
- Minor fixes in tftpload.c: Some compiler warnings, changed output
  for ip32.


Thiemo


diff -urpN arcboot-0.3.8.4.old/Makefile arcboot-0.3.8.4/Makefile
--- arcboot-0.3.8.4.old/Makefile	2004-03-01 13:51:34.000000000 +0100
+++ arcboot-0.3.8.4/Makefile	2004-11-19 03:59:22.000000000 +0100
@@ -1,51 +1,97 @@
 #
 # Copyright 1999 Silicon Graphics, Inc.
 # Copyright 2002-2004 Guido Guenther <agx@sigxcpu.org>
+# Copyright (C) 2004 by Thiemo Seufer
 #  
 
 # default subarch
-SUBARCH=IP22
-
-SUBARCH_INDEP_DIRS=\
-		arclib		\
-		e2fslib/util 	\
-		e2fslib/et 	\
-		e2fslib
+SUBARCH ?= IP22
 
+# these contain subarch independent files
+SUBARCH_INDEP_DIRS=	\
+	arclib		\
+	e2fslib/util 	\
+	e2fslib/et 	\
+	e2fslib		\
+	tip22
 
 # these contain subarch dependent files
-SUBARCH_DIRS=\
-		common		\
-		ext2load	\
-		tip22
-
-all: build-subarch-indep build-subarch
-
-build-subarch:
-	set -e;			      	    \
-	for i in ${SUBARCH_DIRS}; do        \
-		${MAKE} -C $$i SUBARCH=${SUBARCH} all;\
-	done
-
-clean-subarch:
-	set -e;			            \
-	for i in ${SUBARCH_DIRS}; do        \
-		${MAKE} -C $$i clean;       \
-	done
-
-build-subarch-indep:
-	set -e;			      	    \
-	for i in ${SUBARCH_INDEP_DIRS}; do  \
-		${MAKE} -C $$i all;         \
-	done
-
-clean-subarch-indep:
-	set -e;			      	    \
-	for i in ${SUBARCH_INDEP_DIRS}; do  \
-		${MAKE} -C $$i clean;       \
-	done
+SUBARCH_DIRS=		\
+	common		\
+	ext2load
+
+define indep-tgt
+$(foreach sd,$(SUBARCH_INDEP_DIRS),$(1)-subarch-indep-$(sd))
+endef
+
+define dep-tgt
+$(foreach sd,$(SUBARCH_DIRS),$(1)-subarch-dep-$(sd))
+endef
+
+define build-indep-tgt
+$(call indep-tgt,build)
+endef
+
+define build-dep-tgt
+$(call dep-tgt,build)
+endef
+
+define install-indep-tgt
+$(call indep-tgt,install)
+endef
+
+define install-dep-tgt
+$(call dep-tgt,install)
+endef
+
+define clean-indep-tgt
+$(call indep-tgt,clean)
+endef
+
+define clean-dep-tgt
+$(call dep-tgt,clean)
+endef
+
+define submake
+@$(MAKE) -C $(1) SUBARCH=$(SUBARCH) $(2)
+endef
+
+
+all: build
+
+build: build-subarch-indep build-subarch-dep
+build-subarch-indep: $(build-indep-tgt)
+build-subarch-dep: $(build-dep-tgt)
+
+$(build-indep-tgt):
+	$(call submake,$(patsubst build-subarch-indep-%,%,$@),all)
+
+$(build-dep-tgt):
+	$(call submake,$(patsubst build-subarch-dep-%,%,$@),all)
+
+install: install-subarch-indep install-subarch-dep
+install-subarch-indep: $(install-indep-tgt)
+install-subarch-dep: $(install-dep-tgt)
+
+$(install-indep-tgt):
+	$(call submake,$(patsubst install-subarch-indep-%,%,$@),install)
+
+$(install-dep-tgt):
+	$(call submake,$(patsubst install-subarch-dep-%,%,$@),install)
+
+clean: clean-subarch-indep clean-subarch-dep
+clean-subarch-indep: $(clean-indep-tgt)
+clean-subarch-dep: $(clean-dep-tgt)
+
+$(clean-indep-tgt):
+	$(call submake,$(patsubst clean-subarch-indep-%,%,$@),clean)
+
+$(clean-dep-tgt):
+	$(call submake,$(patsubst clean-subarch-dep-%,%,$@),clean)
 
-clean: clean-subarch clean-subarch-indep
 
-.PHONY: build-subarch build-subarch-indep clean-subarch \
-        clean-subarch-indep clean all
+.PHONY: all \
+	build build-subarch-indep build-subarch-dep \
+	$(build-indep-tgt) $(build-dep-tgt) \
+	clean clean-subarch-indep clean-subarch-dep \
+	$(clean-indep-tgt) $(clean-dep-tgt)
diff -urpN arcboot-0.3.8.4.old/arclib/Makefile arcboot-0.3.8.4/arclib/Makefile
--- arcboot-0.3.8.4.old/arclib/Makefile	2002-02-03 23:53:42.000000000 +0100
+++ arcboot-0.3.8.4/arclib/Makefile	2004-11-19 04:11:26.000000000 +0100
@@ -1,8 +1,7 @@
 #
 # Copyright 1999 Silicon Graphics, Inc.
 #
-CFLAGS = -O -Werror -Wall -mno-abicalls -G 0 -fno-pic 
-ASFLAGS= -mno-abicalls -G 0 -fno-pic
+CFLAGS = -O2 -Werror -Wall -mno-abicalls -G 0 -fno-pic
 
 OBJECTS = arc.o	stdio.o stdlib.o string.o
 
@@ -12,5 +11,9 @@ libarc.a:  $(OBJECTS)
 	rm -f $@
 	$(AR) -cr $@ $(OBJECTS)
 
+install: libarc.a
+	install -d ${PREFIX}/${LIBDIR}
+	install -m 644 $< ${PREFIX}/${LIBDIR}
+
 clean:
 	rm -f libarc.a $(OBJECTS)
diff -urpN arcboot-0.3.8.4.old/common/Makefile arcboot-0.3.8.4/common/Makefile
--- arcboot-0.3.8.4.old/common/Makefile	2004-09-25 22:55:26.000000000 +0200
+++ arcboot-0.3.8.4/common/Makefile	2004-11-19 04:07:45.000000000 +0100
@@ -1,3 +1,5 @@
+SUBARCH ?= IP22
+
 CFLAGS = -Wall -O2 -I. -I../arclib -DSUBARCH=${SUBARCH}
 
 TARGETS = print_loadaddr
@@ -10,5 +12,7 @@ all: $(TARGETS)
 $(TARGETS): print_loadaddr.c subarch.h
 	$(HOSTCC) $(HOSTCFLAGS) -o $@ $<
 
+install:
+
 clean:
 	rm -f $(TARGETS) *.a *.o tags
diff -urpN arcboot-0.3.8.4.old/common/print_loadaddr.c arcboot-0.3.8.4/common/print_loadaddr.c
--- arcboot-0.3.8.4.old/common/print_loadaddr.c	2004-09-25 22:56:49.000000000 +0200
+++ arcboot-0.3.8.4/common/print_loadaddr.c	2004-11-10 23:40:09.000000000 +0100
@@ -2,12 +2,29 @@
 
 #include <stdio.h>
 #include <stdint.h>
+#include <strings.h>
 
 #include "subarch.h"
 
-int main()
+int main(int argc, char *argv[])
 {
-	printf("0x%lx\n", kernel_load[SUBARCH].base 
-				+ kernel_load[SUBARCH].reserved);
-	return(0);
+	int subarch = SUBARCH;
+
+	if (argc == 2) {
+		if (!strcasecmp(argv[1], "ip22"))
+			subarch = IP22;
+		else if (!strcasecmp(argv[1], "ip32"))
+			subarch = IP32;
+		else {
+			fprintf(stderr,
+				"Unknown subarchitecture %s requested\n",
+				argv[1]);
+			return 1;
+		}
+	}
+
+	printf("%#08x\n", kernel_load[subarch].base
+	       + kernel_load[subarch].reserved);
+
+	return 0;
 }
diff -urpN arcboot-0.3.8.4.old/common/print_outputformat arcboot-0.3.8.4/common/print_outputformat
--- arcboot-0.3.8.4.old/common/print_outputformat	1970-01-01 01:00:00.000000000 +0100
+++ arcboot-0.3.8.4/common/print_outputformat	2004-11-10 13:31:49.000000000 +0100
@@ -0,0 +1,9 @@
+#!/bin/sh
+
+# default to ecoff
+
+case $1 in
+	ip32 | IP32) echo "elf32-tradbigmips" ;;
+	ip22 | IP22) echo "ecoff-bigmips" ;;
+	*) echo "ecoff-bigmips" ;;
+esac
diff -urpN arcboot-0.3.8.4.old/common/subarch.h arcboot-0.3.8.4/common/subarch.h
--- arcboot-0.3.8.4.old/common/subarch.h	2004-09-25 22:56:17.000000000 +0200
+++ arcboot-0.3.8.4/common/subarch.h	2004-11-19 05:46:42.000000000 +0100
@@ -34,7 +34,7 @@ struct kernel_load_block kernel_load[] =
 	},
 	{ /* IP32 */
 	.base     = 0x80004000,
-	.reserved =   0x800000,
+	.reserved =  0x1400000,
 	},
 };
 
diff -urpN arcboot-0.3.8.4.old/common/version.h arcboot-0.3.8.4/common/version.h
--- arcboot-0.3.8.4.old/common/version.h	2004-03-01 14:01:26.000000000 +0100
+++ arcboot-0.3.8.4/common/version.h	2004-11-19 05:46:56.000000000 +0100
@@ -1 +1 @@
-#define __ARCSBOOT_VERSION__ "0.3.8"
+#define __ARCSBOOT_VERSION__ "0.3.8.4"
diff -urpN arcboot-0.3.8.4.old/debian/rules arcboot-0.3.8.4/debian/rules
--- arcboot-0.3.8.4.old/debian/rules	2004-09-25 23:47:01.000000000 +0200
+++ arcboot-0.3.8.4/debian/rules	2004-11-19 05:26:05.000000000 +0100
@@ -8,7 +8,12 @@
 realver := $(shell dpkg-parsechangelog | awk -F' ' '/^Version:/ {print $$2}' | awk -F- '{print $$1}')
 
 PREFIX_ARCB=${CURDIR}/debian/arcboot
+BIN_ARCB=usr/sbin
+LIB_ARCB=usr/lib/arcboot
+
 PREFIX_TIP22=${CURDIR}/debian/tip22
+BIN_TIP22=usr/sbin
+LIB_TIP22=usr/lib/tip22
 
 architecture=$(dpkg --print-architecture)
 
@@ -26,12 +31,12 @@ build-stamp:
 	# update the version string
 	echo "#define __ARCSBOOT_VERSION__ \"${realver}\"" > common/version.h
 	# build the package
-	make build-subarch-indep
-	make clean-subarch
-	make SUBARCH=IP32
+	$(MAKE) build-subarch-indep
+	$(MAKE) clean-subarch-dep
+	$(MAKE) SUBARCH=IP32 build-subarch-dep
 	cp ext2load/ext2load arcboot.ip32
-	make clean-subarch
-	make SUBARCH=IP22
+	$(MAKE) clean-subarch-dep
+	$(MAKE) SUBARCH=IP22 build-subarch-dep
 	cp ext2load/ext2load arcboot.ip22
 	touch build-stamp
 
@@ -53,12 +58,13 @@ install: build
 	dh_installdirs
 
 	# install arcboot into debian/arcboot
-	install -m 644 arcboot.ip22 ${PREFIX_ARCB}/usr/lib/arcboot/arcboot.ip22
-	install -m 644 arcboot.ip32 ${PREFIX_ARCB}/usr/lib/arcboot/arcboot.ip32
-	install -m 755 scripts/arcboot ${PREFIX_ARCB}/usr/sbin/arcboot
+	install -m 644 arcboot.ip22 ${PREFIX_ARCB}/${LIB_ARCB}/arcboot.ip22
+	install -m 644 arcboot.ip32 ${PREFIX_ARCB}/${LIB_ARCB}/arcboot.ip32
+	install -m 755 scripts/arcboot ${PREFIX_ARCB}/${BIN_ARCB}/arcboot
 
 	# install tip22 into debian/tip22
-	make PREFIX=${PREFIX_TIP22} -C tip22 install
+	$(MAKE) PREFIX=${PREFIX_TIP22} BINDIR=${BIN_TIP22} LIBDIR=${LIB_TIP22} -C arclib install
+	$(MAKE) PREFIX=${PREFIX_TIP22} BINDIR=${BIN_TIP22} LIBDIR=${LIB_TIP22} -C tip22 install
 
 # Build architecture-independent files here.
 binary-indep: build install
diff -urpN arcboot-0.3.8.4.old/debian/tip22.manpages arcboot-0.3.8.4/debian/tip22.manpages
--- arcboot-0.3.8.4.old/debian/tip22.manpages	2002-05-09 21:50:16.000000000 +0200
+++ arcboot-0.3.8.4/debian/tip22.manpages	2004-11-19 01:54:50.000000000 +0100
@@ -1 +1,2 @@
 debian/tip22.8
+debian/tip32.8
diff -urpN arcboot-0.3.8.4.old/debian/tip32.8 arcboot-0.3.8.4/debian/tip32.8
--- arcboot-0.3.8.4.old/debian/tip32.8	1970-01-01 01:00:00.000000000 +0100
+++ arcboot-0.3.8.4/debian/tip32.8	2004-11-19 01:55:23.000000000 +0100
@@ -0,0 +1,27 @@
+.TH "TIP32" "8" "17 November 2004" "" ""
+.SH NAME
+tip32 \- create "piggyback" style boot images for SGI/MIPS IP32 machines
+.SH SYNOPSIS
+
+\fB/usr/sbin/tip32\fR <vmlinux> <initrd> <outfile>
+
+.SH "DESCRIPTION"
+.PP
+\fBtip32\fR is used on SGI/MIPS IP32 machines (SGI O2) to embed kernel and
+initial ramdisk into one ELF image which can then be booted by the ARCS PROM.
+This is usually used to create tftp boot images.
+.SH "USAGE"
+.PP
+<vmlinux> is the ELF kernel you want to embed into the bootimage
+.P
+<initrd> is the (optionally gzip compressed) initial ramdisk
+.P
+<outfile> is the resulting tftpboot image
+
+.SH "SEE ALSO"
+.PP
+arcboot(8).
+.SH "AUTHORS"
+Tip32 is an adaption of tip22, which is the equivalent for SGI IP22 machines.
+Tip22 was written by Guido Günther <agx@sigxcpu.org> and borrows heavily
+from arcboot written by Ralf Bächle <ralf@gnu.org> and Guido Günther.
diff -urpN arcboot-0.3.8.4.old/ext2load/Makefile arcboot-0.3.8.4/ext2load/Makefile
--- arcboot-0.3.8.4.old/ext2load/Makefile	2004-09-25 18:20:39.000000000 +0200
+++ arcboot-0.3.8.4/ext2load/Makefile	2004-11-19 05:16:19.000000000 +0100
@@ -2,42 +2,45 @@
 # Copyright 1999 Silicon Graphics, Inc.
 #           2001-04 Guido Guenther <agx@sigxcpu.org>
 #
-EXT2_OBJS = loader.o ext2io.o conffile.o
-LARC_OBJS = larc.o
-OBJECTS = $(EXT2_OBJS) $(LARC_OBJS)
 
-E2FSLIBDIR=../e2fslib
+SUBARCH ?= IP22
+
+COMMONDIR = ../common
+
+E2FSLIBDIR = ../e2fslib
+EXT2LIB = $(E2FSLIBDIR)/libext2fs.a
 
 ARCLIBDIR = ../arclib
 ARCLIB = $(ARCLIBDIR)/libarc.a
 
-COMMONDIR = ../common
-
-EXT2LIB = ../e2fslib/libext2fs.a
+OBJECTS = loader.o ext2io.o conffile.o
+LIBS = $(EXT2LIB) $(ARCLIB)
+TARGETS = ext2load 
 
-CFLAGS = -O -I $(COMMONDIR) -I$(ARCLIBDIR) -I$(E2FSLIBDIR) 	\
+CFLAGS = -O2 -I $(COMMONDIR) -I$(ARCLIBDIR) -I$(E2FSLIBDIR) 	\
          -Wall -mno-abicalls -G 0 -fno-pic			\
 	 -DSUBARCH=${SUBARCH}
 
-ASFLAGS= -mno-abicalls -G 0 -fno-pic
-
 # uncomment for debugging
 #CFLAGS+=-DDEBUG
 
 LD = ld
-LDFLAGS = -N --oformat ecoff-bigmips -T ld.script
-
-TARGETS = ext2load 
+LDFLAGS = -N -T ld.script
 
 all:  $(TARGETS)
 
-ext2load:  $(EXT2_OBJS) $(ARCLIB) ld.script ../common/subarch.h
+ext2load:  $(OBJECTS) $(LIBS) ld.script ../common/subarch.h
 	rm -f $@
-	$(LD) $(LDFLAGS) -o $@ $(EXT2_OBJS) $(EXT2LIB) $(ARCLIB)
+	$(LD) $(LDFLAGS) -o $@ $(OBJECTS) $(LIBS)
+
+ld.script: ld.script.in
+	$(MAKE) -C ../common SUBARCH=$(SUBARCH) print_loadaddr
+	LOADADDR=$$(../common/print_loadaddr $(SUBARCH));	 	\
+	OUTPUTFORMAT=$$(../common/print_outputformat $(SUBARCH));	\
+	sed -e "s/@@LOADADDR@@/$$LOADADDR/"				\
+	-e "s/@@OUTPUTFORMAT@@/$$OUTPUTFORMAT/" <$< >$@
 
-ld.script: ld.script.in ../common/print_loadaddr
-	LOADADDR=$$(../common/print_loadaddr); 	\
-	sed -e "s/@@LOADADDR@@/$$LOADADDR/" <$< >$@
+install:
 
 clean:
 	rm -f $(TARGETS) *.a *.o tags ld.script
diff -urpN arcboot-0.3.8.4.old/ext2load/ld.script.in arcboot-0.3.8.4/ext2load/ld.script.in
--- arcboot-0.3.8.4.old/ext2load/ld.script.in	2004-09-25 23:34:39.000000000 +0200
+++ arcboot-0.3.8.4/ext2load/ld.script.in	2004-11-19 05:17:33.000000000 +0100
@@ -1,3 +1,4 @@
+OUTPUT_FORMAT("@@OUTPUTFORMAT@@")
 OUTPUT_ARCH(mips)
 ENTRY(_start)
 SECTIONS
@@ -6,22 +7,22 @@ SECTIONS
   . = @@LOADADDR@@;
 
   /* Read-only sections, merged into text segment: */
-  .text      :
-  {
-    _ftext = . ;
+  .text : {
+    _ftext = .;
     *(.text)
     *(.rodata*)
   } =0
   _etext = .;
   PROVIDE (etext = .);
 
-  .data    :
-  {
-    _fdata = . ;
+  . = ALIGN(16);
+
+  .data : {
+    _fdata = .;
     *(.data)
     CONSTRUCTORS
   }
-   _gp = . + 0x8000;
+  _gp = ALIGN(16) + 0x7ff0;
   .lit8 : { *(.lit8) }
   .lit4 : { *(.lit4) }
   /* We want the small data sections together, so single-instruction offsets
@@ -30,29 +31,43 @@ SECTIONS
   .sdata : { *(.sdata) }
   PROVIDE (edata = .);
   
-   .sbss : {
+  __bss_start = .;
+  .sbss : {
     *(.sbss)
     *(.scommon)
   }
   .bss : {
-    *(.bss)
+    _fbss = .;
+    *(.dynbss)
+    *(.bss .bss.*)
     *(COMMON)
-   .  = ALIGN(4);
+    /* Align here to ensure that the .bss section occupies space up to
+       _end.  Align after .bss to ensure correct alignment even if the
+       .bss section disappears because there are no input sections.  */
+    . = ALIGN(32 / 8);
   }
+  . = ALIGN(32 / 8);
   __bss_stop = .;
-
+  _end = .;
   PROVIDE (end = .);
 
   /* Sections to be discarded */
-  /DISCARD/ :
-  {
+  /DISCARD/ : {
+        *(.text.exit)
+        *(.data.exit)
+        *(.exitcall.exit)
 	*(.stab)
 	*(.stabstr)
 	*(.pdr)
 	*(.note)
 	*(.reginfo)
+	*(.options)
+	*(.MIPS.options)
         *(.debug*)
+        *(.line)
         *(.mdebug*)
         *(.comment*)
+        *(.gptab*)
+        *(.note)
   }
 }
diff -urpN arcboot-0.3.8.4.old/ext2load/loader.c arcboot-0.3.8.4/ext2load/loader.c
--- arcboot-0.3.8.4.old/ext2load/loader.c	2004-09-25 22:53:52.000000000 +0200
+++ arcboot-0.3.8.4/ext2load/loader.c	2004-11-11 03:03:09.000000000 +0100
@@ -431,13 +431,14 @@ void printCmdLine(int argc, CHAR *argv[]
 void _start64(LONG argc, CHAR * argv[], CHAR * envp[],
 	      unsigned long long *addr)
 {
-	asm volatile (".set mips4\n"
+	asm volatile (".set push\n"
+		      "\t.set mips3\n"
 		      "\t.set noreorder\n"
-		      "\tld $2, 0($7)\n"
-		      "\tj $2\n"
-		      "\tnop\n"
-		      "\t.set noreorder\n"
-		      "\t.set mips0");
+		      "\t.set noat\n"
+		      "\tld $1, 0($7)\n"
+		      "\tjr $1\n"
+		      "\t nop\n"
+		      "\t.set pop");
 }
 
 void _start(LONG argc, CHAR *argv[], CHAR *envp[])
@@ -509,14 +510,14 @@ void _start(LONG argc, CHAR *argv[], CHA
 #endif
 	if( kernel_entry64 ) {
 	    if(is64==0){
-		printf("Starting 32-bit kernel\n\r");
+		printf("Starting ELF32 kernel\n\r");
 		ArcFlushAllCaches();
 		((void (*)(int argc, CHAR * argv[], CHAR * envp[]))
 		    kernel_entry32)(nargc ,nargv, envp);
 	    } else {
-		printf("Starting 64-bit kernel\n\r");
+		printf("Starting ELF64 kernel\n\r");
 		ArcFlushAllCaches();
-		_start64(nargc ,nargv, envp, &kernel_entry64);
+		_start64(nargc, nargv, envp, &kernel_entry64);
 	    }
 	} else {
 		printf("Invalid kernel entry NULL\n\r");
diff -urpN arcboot-0.3.8.4.old/tip22/Makefile arcboot-0.3.8.4/tip22/Makefile
--- arcboot-0.3.8.4.old/tip22/Makefile	2004-03-01 13:33:27.000000000 +0100
+++ arcboot-0.3.8.4/tip22/Makefile	2004-11-19 04:13:51.000000000 +0100
@@ -1,42 +1,63 @@
 #
 # Copyright 2002-2004 Guido Guenther <agx@sigxcpu.org>
 #
-TFTP_OBJS = tftpload.o
+
+OBJECTS = tftpload.$(SUBARCH).o
 
 ARCLIBDIR = ../arclib
 ARCLIB = $(ARCLIBDIR)/libarc.a
 
 COMMONDIR = ../common
 
-CFLAGS = -O -I $(COMMONDIR) -I$(ARCLIBDIR) \
+CFLAGS = -O2 -I $(COMMONDIR) -I$(ARCLIBDIR) \
          -Wall -mno-abicalls -G 0 -fno-pic \
 	 -DSUBARCH=${SUBARCH}
 
-ASFLAGS= -mno-abicalls -G 0 -fno-pic
-LD = ld
-LDFLAGS = -N --oformat ecoff-bigmips -T ld.script
-LD_SCRIPTS = ld.kernel.script ld.ramdisk.script ld.script
-
-LIBDIR=/usr/lib/tip22
-BINDIR=/usr/sbin
-LIBS=${TFTP_OBJS} ${LD_SCRIPTS} ${ARCLIB}
-BINS=tip22
+ASFLAGS = -O2 -mno-abicalls -G 0 -fno-pic
+
+LIBDIR ?= /usr/lib/tip22
+BINDIR ?= /usr/sbin
+LIBS=${ARCLIB}
+BINS=tip22 tip32
+LD_SCRIPTS = ld.kernel.script.$(SUBARCH) ld.ramdisk.script.$(SUBARCH) ld.script.$(SUBARCH)
 
-TARGETS = tftpload.o ld.script
+TARGETS = $(OBJECTS) $(LD_SCRIPTS)
 
 # uncomment for debugging
 #CFLAGS+=-DDEBUG
 
-all:  $(TARGETS)
-
-ld.script: ld.script.in ../common/print_loadaddr
-	LOADADDR=$$(../common/print_loadaddr); 	\
-	sed -e "s/@@LOADADDR@@/$$LOADADDR/" <$< >$@
+all: ${LIBS} ${BINS}
+	@$(MAKE) SUBARCH=IP32 archall
+	@$(MAKE) SUBARCH=IP22 archall
+
+archall: $(TARGETS)
+
+%.$(SUBARCH).o: %.c
+	$(CC) $(CFLAGS) -c -o $@ $<
+
+%.script.$(SUBARCH): %.script.in
+	$(MAKE) -C ../common SUBARCH=$(SUBARCH) print_loadaddr
+	LOADADDR=$$(../common/print_loadaddr $(SUBARCH));	 	\
+	OUTPUTFORMAT=$$(../common/print_outputformat $(SUBARCH));	\
+	sed -e "s/@@LOADADDR@@/$$LOADADDR/"				\
+	-e "s/@@OUTPUTFORMAT@@/$$OUTPUTFORMAT/" <$< >$@
 
 clean:
-	rm -f $(TARGETS) *.a *.o tags
+	@$(MAKE) SUBARCH=IP32 archclean
+	@$(MAKE) SUBARCH=IP22 archclean
+	rm -f *.a *.o tags
+
+archclean:
+	rm -f $(TARGETS)
 
-install: ${LIBS} ${BINS}
-	install -d ${PREFIX}/${LIBDIR} ${PREFIX}/${BINDIR}
-	install -m 644 ${LIBS} ${PREFIX}/${LIBDIR}
+install: all
+	install -d ${PREFIX}/${BINDIR}
 	install -m 755 ${BINS} ${PREFIX}/${BINDIR}
+	@$(MAKE) SUBARCH=IP32 archinstall
+	@$(MAKE) SUBARCH=IP22 archinstall
+
+archinstall:
+	$(foreach tg,$(TARGETS),install -m 644 $(tg) ${PREFIX}/${LIBDIR};)
+
+
+.PHONY: all archall clean archclean install archinstall
diff -urpN arcboot-0.3.8.4.old/tip22/kernel/parse_rd_cmd_line-2.4-2002-05-09.diff arcboot-0.3.8.4/tip22/kernel/parse_rd_cmd_line-2.4-2002-05-09.diff
--- arcboot-0.3.8.4.old/tip22/kernel/parse_rd_cmd_line-2.4-2002-05-09.diff	1970-01-01 01:00:00.000000000 +0100
+++ arcboot-0.3.8.4/tip22/kernel/parse_rd_cmd_line-2.4-2002-05-09.diff	2002-05-09 19:22:47.000000000 +0200
@@ -0,0 +1,88 @@
+Index: arch/mips/kernel/setup.c
+===================================================================
+RCS file: /cvs/linux/arch/mips/kernel/setup.c,v
+retrieving revision 1.96.2.12
+diff -u -u -r1.96.2.12 setup.c
+--- arch/mips/kernel/setup.c	2002/02/15 21:05:48	1.96.2.12
++++ arch/mips/kernel/setup.c	2002/05/09 17:17:59
+@@ -650,6 +650,38 @@
+ 	}
+ }
+ 
++static inline void parse_rd_cmdline(unsigned long* rd_start, unsigned long* rd_end)
++{
++	char c = ' ', *to = command_line, *from = saved_command_line;
++	int len = 0;
++	unsigned long rd_size = 0;
++
++	for (;;) {
++		/*
++		 * "rd_start=0xNNNNNNNN" defines the memory address of an initrd
++		 * "rd_size=0xNN" it's size
++		 */
++		if (c == ' ' && !memcmp(from, "rd_start=", 9)) {
++			if (to != command_line)
++				to--;
++			(*rd_start) = memparse(from + 9, &from);
++		}
++		if (c == ' ' && !memcmp(from, "rd_size=", 8)) {
++			if (to != command_line)
++				to--;
++			rd_size = memparse(from + 8, &from);
++		}
++		c = *(from++);
++		if (!c)
++			break;
++		if (CL_SIZE <= ++len)
++			break;
++		*(to++) = c;
++	}
++	*to = '\0';
++	(*rd_end) = (*rd_start) + rd_size;
++}
++
+ void __init setup_arch(char **cmdline_p)
+ {
+ 	void atlas_setup(void);
+@@ -674,10 +706,7 @@
+ 
+ 	unsigned long bootmap_size;
+ 	unsigned long start_pfn, max_pfn, max_low_pfn, first_usable_pfn;
+-#ifdef CONFIG_BLK_DEV_INITRD
+-	unsigned long tmp;
+-	unsigned long* initrd_header;
+-#endif
++	unsigned long end = &_end;
+ 
+ 	int i;
+ 
+@@ -828,22 +857,18 @@
+ #define MAXMEM_PFN	PFN_DOWN(MAXMEM)
+ 
+ #ifdef CONFIG_BLK_DEV_INITRD
+-	tmp = (((unsigned long)&_end + PAGE_SIZE-1) & PAGE_MASK) - 8; 
+-	if (tmp < (unsigned long)&_end) 
+-		tmp += PAGE_SIZE;
+-	initrd_header = (unsigned long *)tmp;
+-	if (initrd_header[0] == 0x494E5244) {
+-		initrd_start = (unsigned long)&initrd_header[2];
+-		initrd_end = initrd_start + initrd_header[1];
++	parse_rd_cmdline(&initrd_start, &initrd_end);
++	if(initrd_start && initrd_end)
++		end = initrd_end;
++	else {
++		initrd_start = initrd_end = 0;
+ 	}
+-	start_pfn = PFN_UP(__pa((&_end)+(initrd_end - initrd_start) + PAGE_SIZE));
+-#else
++#endif /* CONFIG_BLK_DEV_INITRD */
+ 	/*
+ 	 * Partially used pages are not usable - thus
+ 	 * we are rounding upwards.
+ 	 */
+-	start_pfn = PFN_UP(__pa(&_end));
+-#endif	/* CONFIG_BLK_DEV_INITRD */
++	start_pfn = PFN_UP(__pa(end));
+ 
+ 	/* Find the highest page frame number we have available.  */
+ 	max_pfn = 0;
diff -urpN arcboot-0.3.8.4.old/tip22/kernel/parse_rd_cmd_line-2.6-2004-11-17.diff arcboot-0.3.8.4/tip22/kernel/parse_rd_cmd_line-2.6-2004-11-17.diff
--- arcboot-0.3.8.4.old/tip22/kernel/parse_rd_cmd_line-2.6-2004-11-17.diff	1970-01-01 01:00:00.000000000 +0100
+++ arcboot-0.3.8.4/tip22/kernel/parse_rd_cmd_line-2.6-2004-11-17.diff	2004-11-19 01:46:14.000000000 +0100
@@ -0,0 +1,172 @@
+Index: arch/mips/kernel/setup.c
+===================================================================
+RCS file: /home/cvs/linux/arch/mips/kernel/setup.c,v
+retrieving revision 1.171
+diff -u -p -r1.171 setup.c
+--- arch/mips/kernel/setup.c	28 Jun 2004 21:04:12 -0000	1.171
++++ arch/mips/kernel/setup.c	19 Nov 2004 00:45:23 -0000
+@@ -194,6 +194,68 @@ static inline void parse_cmdline_early(v
+ 	}
+ }
+ 
++static inline int parse_rd_cmdline(unsigned long* rd_start, unsigned long* rd_end)
++{
++	/*
++	 * "rd_start=0xNNNNNNNN" defines the memory address of an initrd
++	 * "rd_size=0xNN" it's size
++	 */
++	unsigned long start = 0;
++	unsigned long size = 0;
++	unsigned long end;
++	char cmd_line[CL_SIZE];
++	char *start_str;
++	char *size_str;
++	char *tmp;
++
++	strcpy(cmd_line, command_line);
++	*command_line = 0;
++	tmp = cmd_line;
++	/* Ignore "rd_start=" strings in other parameters. */
++	start_str = strstr(cmd_line, "rd_start=");
++	if (start_str && start_str != cmd_line && *(start_str - 1) != ' ')
++		start_str = strstr(start_str, " rd_start=");
++	while (start_str) {
++		if (start_str != cmd_line)
++			strncat(command_line, tmp, start_str - tmp);
++		start = memparse(start_str + 9, &start_str);
++		tmp = start_str + 1;
++		start_str = strstr(start_str, " rd_start=");
++	}
++	if (*tmp)
++		strcat(command_line, tmp);
++
++	strcpy(cmd_line, command_line);
++	*command_line = 0;
++	tmp = cmd_line;
++	/* Ignore "rd_size" strings in other parameters. */
++	size_str = strstr(cmd_line, "rd_size=");
++	if (size_str && size_str != cmd_line && *(size_str - 1) != ' ')
++		size_str = strstr(size_str, " rd_size=");
++	while (size_str) {
++		if (size_str != cmd_line)
++			strncat(command_line, tmp, size_str - tmp);
++		size = memparse(size_str + 8, &size_str);
++		tmp = size_str + 1;
++		size_str = strstr(size_str, " rd_size=");
++	}
++	if (*tmp)
++		strcat(command_line, tmp);
++
++#ifdef CONFIG_MIPS64
++	/* HACK: Guess if the sign extension was forgotten */
++	if (start > 0x0000000080000000 && start < 0x00000000ffffffff)
++		start |= 0xffffffff00000000;
++#endif
++
++	end = start + size;
++	if (start && end) {
++		*rd_start = start;
++		*rd_end = end;
++		return 1;
++	}
++	return 0;
++}
+ 
+ #define PFN_UP(x)	(((x) + PAGE_SIZE - 1) >> PAGE_SHIFT)
+ #define PFN_DOWN(x)	((x) >> PAGE_SHIFT)
+@@ -205,30 +267,45 @@ static inline void parse_cmdline_early(v
+ static inline void bootmem_init(void)
+ {
+ 	unsigned long start_pfn;
++	unsigned long reserved_end = (unsigned long)&_end;
+ #ifndef CONFIG_SGI_IP27
+-	unsigned long bootmap_size, max_low_pfn, first_usable_pfn;
++	unsigned long first_usable_pfn;
++	unsigned long bootmap_size;
+ 	int i;
+ #endif
+ #ifdef CONFIG_BLK_DEV_INITRD
+-	unsigned long tmp;
+-	unsigned long *initrd_header;
++	int initrd_reserve_bootmem = 0;
+ 
+-	tmp = (((unsigned long)&_end + PAGE_SIZE-1) & PAGE_MASK) - 8;
+-	if (tmp < (unsigned long)&_end)
+-		tmp += PAGE_SIZE;
+-	initrd_header = (unsigned long *)tmp;
+-	if (initrd_header[0] == 0x494E5244) {
+-		initrd_start = (unsigned long)&initrd_header[2];
+-		initrd_end = initrd_start + initrd_header[1];
++	/* Board specific code should have set up initrd_start and initrd_end */
++ 	ROOT_DEV = Root_RAM0;
++	if (&__rd_start != &__rd_end) {
++		initrd_start = (unsigned long)&__rd_start;
++		initrd_end = (unsigned long)&__rd_end;
++	} else if (parse_rd_cmdline(&initrd_start, &initrd_end)) {
++		reserved_end = max(reserved_end, initrd_end);
++		initrd_reserve_bootmem = 1;
++	} else {
++		unsigned long tmp;
++		unsigned long *initrd_header;
++
++		tmp = ((reserved_end + PAGE_SIZE-1) & PAGE_MASK) - 8;
++		if (tmp < reserved_end)
++			tmp += PAGE_SIZE;
++		initrd_header = (unsigned long *)tmp;
++		if (initrd_header[0] == 0x494E5244) {
++			initrd_start = (unsigned long)&initrd_header[2];
++			initrd_end = initrd_start + initrd_header[1];
++			reserved_end = max(reserved_end, initrd_end);
++			initrd_reserve_bootmem = 1;
++		}
+ 	}
+-	start_pfn = PFN_UP(CPHYSADDR((&_end)+(initrd_end - initrd_start) + PAGE_SIZE));
+-#else
++#endif	/* CONFIG_BLK_DEV_INITRD */
++
+ 	/*
+ 	 * Partially used pages are not usable - thus
+ 	 * we are rounding upwards.
+ 	 */
+-	start_pfn = PFN_UP(CPHYSADDR(&_end));
+-#endif	/* CONFIG_BLK_DEV_INITRD */
++	start_pfn = PFN_UP(CPHYSADDR(reserved_end));
+ 
+ #ifndef CONFIG_SGI_IP27
+ 	/* Find the highest page frame number we have available.  */
+@@ -341,21 +418,14 @@ static inline void bootmem_init(void)
+ 
+ 	/* Reserve the bootmap memory.  */
+ 	reserve_bootmem(PFN_PHYS(first_usable_pfn), bootmap_size);
+-#endif
++#endif /* CONFIG_SGI_IP27 */
+ 
+ #ifdef CONFIG_BLK_DEV_INITRD
+-	/* Board specific code should have set up initrd_start and initrd_end */
+-	ROOT_DEV = Root_RAM0;
+-	if (&__rd_start != &__rd_end) {
+-		initrd_start = (unsigned long)&__rd_start;
+-		initrd_end = (unsigned long)&__rd_end;
+-	}
+ 	initrd_below_start_ok = 1;
+ 	if (initrd_start) {
+ 		unsigned long initrd_size = ((unsigned char *)initrd_end) - ((unsigned char *)initrd_start);
+ 		printk("Initial ramdisk at: 0x%p (%lu bytes)\n",
+-		       (void *)initrd_start,
+-		       initrd_size);
++		       (void *)initrd_start, initrd_size);
+ 
+ 		if (CPHYSADDR(initrd_end) > PFN_PHYS(max_low_pfn)) {
+ 			printk("initrd extends beyond end of memory "
+@@ -363,7 +433,11 @@ static inline void bootmem_init(void)
+ 			       sizeof(long) * 2, CPHYSADDR(initrd_end),
+ 			       sizeof(long) * 2, PFN_PHYS(max_low_pfn));
+ 			initrd_start = initrd_end = 0;
++			initrd_reserve_bootmem = 0;
+ 		}
++
++		if (initrd_reserve_bootmem)
++			reserve_bootmem(CPHYSADDR(initrd_start), initrd_size);
+ 	}
+ #endif /* CONFIG_BLK_DEV_INITRD  */
+ }
diff -urpN arcboot-0.3.8.4.old/tip22/kernel/parse_rd_cmd_line-2002-05-09.diff arcboot-0.3.8.4/tip22/kernel/parse_rd_cmd_line-2002-05-09.diff
--- arcboot-0.3.8.4.old/tip22/kernel/parse_rd_cmd_line-2002-05-09.diff	2002-05-09 19:22:47.000000000 +0200
+++ arcboot-0.3.8.4/tip22/kernel/parse_rd_cmd_line-2002-05-09.diff	1970-01-01 01:00:00.000000000 +0100
@@ -1,88 +0,0 @@
-Index: arch/mips/kernel/setup.c
-===================================================================
-RCS file: /cvs/linux/arch/mips/kernel/setup.c,v
-retrieving revision 1.96.2.12
-diff -u -u -r1.96.2.12 setup.c
---- arch/mips/kernel/setup.c	2002/02/15 21:05:48	1.96.2.12
-+++ arch/mips/kernel/setup.c	2002/05/09 17:17:59
-@@ -650,6 +650,38 @@
- 	}
- }
- 
-+static inline void parse_rd_cmdline(unsigned long* rd_start, unsigned long* rd_end)
-+{
-+	char c = ' ', *to = command_line, *from = saved_command_line;
-+	int len = 0;
-+	unsigned long rd_size = 0;
-+
-+	for (;;) {
-+		/*
-+		 * "rd_start=0xNNNNNNNN" defines the memory address of an initrd
-+		 * "rd_size=0xNN" it's size
-+		 */
-+		if (c == ' ' && !memcmp(from, "rd_start=", 9)) {
-+			if (to != command_line)
-+				to--;
-+			(*rd_start) = memparse(from + 9, &from);
-+		}
-+		if (c == ' ' && !memcmp(from, "rd_size=", 8)) {
-+			if (to != command_line)
-+				to--;
-+			rd_size = memparse(from + 8, &from);
-+		}
-+		c = *(from++);
-+		if (!c)
-+			break;
-+		if (CL_SIZE <= ++len)
-+			break;
-+		*(to++) = c;
-+	}
-+	*to = '\0';
-+	(*rd_end) = (*rd_start) + rd_size;
-+}
-+
- void __init setup_arch(char **cmdline_p)
- {
- 	void atlas_setup(void);
-@@ -674,10 +706,7 @@
- 
- 	unsigned long bootmap_size;
- 	unsigned long start_pfn, max_pfn, max_low_pfn, first_usable_pfn;
--#ifdef CONFIG_BLK_DEV_INITRD
--	unsigned long tmp;
--	unsigned long* initrd_header;
--#endif
-+	unsigned long end = &_end;
- 
- 	int i;
- 
-@@ -828,22 +857,18 @@
- #define MAXMEM_PFN	PFN_DOWN(MAXMEM)
- 
- #ifdef CONFIG_BLK_DEV_INITRD
--	tmp = (((unsigned long)&_end + PAGE_SIZE-1) & PAGE_MASK) - 8; 
--	if (tmp < (unsigned long)&_end) 
--		tmp += PAGE_SIZE;
--	initrd_header = (unsigned long *)tmp;
--	if (initrd_header[0] == 0x494E5244) {
--		initrd_start = (unsigned long)&initrd_header[2];
--		initrd_end = initrd_start + initrd_header[1];
-+	parse_rd_cmdline(&initrd_start, &initrd_end);
-+	if(initrd_start && initrd_end)
-+		end = initrd_end;
-+	else {
-+		initrd_start = initrd_end = 0;
- 	}
--	start_pfn = PFN_UP(__pa((&_end)+(initrd_end - initrd_start) + PAGE_SIZE));
--#else
-+#endif /* CONFIG_BLK_DEV_INITRD */
- 	/*
- 	 * Partially used pages are not usable - thus
- 	 * we are rounding upwards.
- 	 */
--	start_pfn = PFN_UP(__pa(&_end));
--#endif	/* CONFIG_BLK_DEV_INITRD */
-+	start_pfn = PFN_UP(__pa(end));
- 
- 	/* Find the highest page frame number we have available.  */
- 	max_pfn = 0;
diff -urpN arcboot-0.3.8.4.old/tip22/ld.kernel.script arcboot-0.3.8.4/tip22/ld.kernel.script
--- arcboot-0.3.8.4.old/tip22/ld.kernel.script	2002-04-29 22:55:41.000000000 +0200
+++ arcboot-0.3.8.4/tip22/ld.kernel.script	1970-01-01 01:00:00.000000000 +0100
@@ -1,11 +0,0 @@
-OUTPUT_FORMAT("ecoff-bigmips")
-OUTPUT_ARCH(mips)
-SECTIONS
-{
-  .data :
-  {
-        __kernel_start = .;
-        *(.data)
-        __kernel_end = .;
-  }
-}
diff -urpN arcboot-0.3.8.4.old/tip22/ld.kernel.script.in arcboot-0.3.8.4/tip22/ld.kernel.script.in
--- arcboot-0.3.8.4.old/tip22/ld.kernel.script.in	1970-01-01 01:00:00.000000000 +0100
+++ arcboot-0.3.8.4/tip22/ld.kernel.script.in	2004-11-10 13:52:46.000000000 +0100
@@ -0,0 +1,11 @@
+OUTPUT_FORMAT("@@OUTPUTFORMAT@@")
+OUTPUT_ARCH(mips)
+SECTIONS
+{
+  .data :
+  {
+        __kernel_start = .;
+        *(.data)
+        __kernel_end = .;
+  }
+}
diff -urpN arcboot-0.3.8.4.old/tip22/ld.ramdisk.script arcboot-0.3.8.4/tip22/ld.ramdisk.script
--- arcboot-0.3.8.4.old/tip22/ld.ramdisk.script	2002-04-29 22:55:41.000000000 +0200
+++ arcboot-0.3.8.4/tip22/ld.ramdisk.script	1970-01-01 01:00:00.000000000 +0100
@@ -1,11 +0,0 @@
-OUTPUT_FORMAT("ecoff-bigmips")
-OUTPUT_ARCH(mips)
-SECTIONS
-{
-  .data :
-  {
-        __rd_start = .;
-        *(.data)
-        __rd_end = .;
-  }
-}
diff -urpN arcboot-0.3.8.4.old/tip22/ld.ramdisk.script.in arcboot-0.3.8.4/tip22/ld.ramdisk.script.in
--- arcboot-0.3.8.4.old/tip22/ld.ramdisk.script.in	1970-01-01 01:00:00.000000000 +0100
+++ arcboot-0.3.8.4/tip22/ld.ramdisk.script.in	2004-11-10 13:52:46.000000000 +0100
@@ -0,0 +1,11 @@
+OUTPUT_FORMAT("@@OUTPUTFORMAT@@")
+OUTPUT_ARCH(mips)
+SECTIONS
+{
+  .data :
+  {
+        __rd_start = .;
+        *(.data)
+        __rd_end = .;
+  }
+}
diff -urpN arcboot-0.3.8.4.old/tip22/ld.script.in arcboot-0.3.8.4/tip22/ld.script.in
--- arcboot-0.3.8.4.old/tip22/ld.script.in	2004-09-29 10:06:24.000000000 +0200
+++ arcboot-0.3.8.4/tip22/ld.script.in	2004-11-15 17:25:11.000000000 +0100
@@ -1,3 +1,4 @@
+OUTPUT_FORMAT("@@OUTPUTFORMAT@@")
 OUTPUT_ARCH(mips)
 ENTRY(_start)
 SECTIONS
@@ -5,36 +6,58 @@ SECTIONS
   /* XXX: place the loader after the kernel */
   . = @@LOADADDR@@;
 
-  /* merge everything into one segment */
-  .text      :
-  { _ftext = . ;
-    *(.text)
+  /* read-only */
+  _text = .;			/* Text and read-only data */
+  .text : {
+    _ftext = .;
+    *(.text .text.*)
     *(.rodata*)
-   _etext = .;
-   PROVIDE (etext = .);
   } =0
 
-  /* kernel and initrd will go in here */
-  .data :
-  {
-   	_fdata = .;
-   	*(.data)
-   	CONSTRUCTORS
-   	PROVIDE (edata = .);
-  }
+  _etext = .;			/* End of text section */
+  PROVIDE (etext = .);
 
-  .bss       :
-  {
-   *(.bss)
-   *(COMMON)
-   .  = ALIGN(4);
-  _end = . ;
-  PROVIDE (end = .);
+  . = ALIGN(16);
+
+  /* writeable */
+  .data : {
+    _fdata = .;
+    *(.data .data.*)
+  } =0
+
+  _gp = ALIGN(16) + 0x7ff0;
+  .lit8 : { *(.lit8) }
+  .lit4 : { *(.lit4) }
+  /* We want the small data sections together, so single-instruction offsets
+     can access them all, and initialized data all before uninitialized, so
+     we can shorten the on-disk segment size.  */
+  .sdata : { *(.sdata) }
+
+  _edata = .;
+  PROVIDE (edata = .);
+
+  __bss_start = .;
+  .sbss : {
+    *(.sbss)
+    *(.scommon)
   }
+  .bss : {
+    _fbss = .;
+    *(.dynbss)
+    *(.bss .bss.*)
+    *(COMMON)
+    /* Align here to ensure that the .bss section occupies space up to
+       _end.  Align after .bss to ensure correct alignment even if the
+       .bss section disappears because there are no input sections.  */
+    . = ALIGN(32 / 8);
+  }
+  . = ALIGN(32 / 8);
+  __bss_stop = .;
+  _end = .;
+  PROVIDE (end = .);
 
   /* Sections to be discarded */
-  /DISCARD/ :
-  {
+  /DISCARD/ : {
         *(.text.exit)
         *(.data.exit)
         *(.exitcall.exit)
@@ -43,8 +66,13 @@ SECTIONS
 	*(.pdr)
 	*(.note)
 	*(.reginfo)
+	*(.options)
+	*(.MIPS.options)
         *(.debug*)
+        *(.line)
         *(.mdebug*)
         *(.comment*)
+        *(.gptab*)
+        *(.note)
   }
 }
diff -urpN arcboot-0.3.8.4.old/tip22/tftpload.c arcboot-0.3.8.4/tip22/tftpload.c
--- arcboot-0.3.8.4.old/tip22/tftpload.c	2004-03-01 12:24:16.000000000 +0100
+++ arcboot-0.3.8.4/tip22/tftpload.c	2004-11-19 04:33:31.000000000 +0100
@@ -17,12 +17,14 @@
 #include <sys/types.h>
 
 #include <asm/addrspace.h>
-#include "tftpload.h"
 
+#include <version.h>
 #include <subarch.h>
 
 #define ANSI_CLEAR	"\033[2J"
 
+typedef enum { False = 0, True } Boolean;
+
 extern void* __kernel_start;
 extern void* __kernel_end;
 extern void* __rd_start;
@@ -41,7 +43,7 @@ static void Wait(const char *prompt)
 }
 
 
-void Fatal(const CHAR * message, ...)
+static void Fatal(const CHAR * message, ...)
 {
 	va_list ap;
 
@@ -57,7 +59,7 @@ void Fatal(const CHAR * message, ...)
 }
 
 
-void InitMalloc(void)
+static void InitMalloc(void)
 {
 	MEMORYDESCRIPTOR *current = NULL;
 	ULONG stack = (ULONG) & current;
@@ -115,14 +117,14 @@ void InitMalloc(void)
 }
 
 /* convert an offset in the kernel image to an address in the loaded tftpboot image */
-void* offset2addr(unsigned long offset)
+static void* offset2addr(unsigned long offset)
 {
 	void* address = (void*)((ULONG)&(__kernel_start) + offset);
 	return address;
 }
 
 /* copy program segments to the locations the kernel expects */
-ULONG CopyProgramSegments(Elf32_Ehdr * header)
+static ULONG CopyProgramSegments(Elf32_Ehdr * header)
 {
 	int idx;
 	Boolean loaded = False;
@@ -146,7 +148,7 @@ ULONG CopyProgramSegments(Elf32_Ehdr * h
 			    ("Loading program segment %u at 0x%x, size = 0x%x\n\r",
 			     idx + 1, KSEG0ADDR(segment->p_vaddr), segment->p_filesz);
 
-			memcpy( segment->p_vaddr, offset2addr(segment->p_offset), segment->p_filesz);
+			memcpy((void *)segment->p_vaddr, offset2addr(segment->p_offset), segment->p_filesz);
 			/* determine the highest address used by the kernel's memory image */
 			if( kernel_end < segment->p_vaddr + segment->p_memsz ) {
 				kernel_end = segment->p_vaddr + segment->p_memsz;
@@ -176,7 +178,7 @@ ULONG CopyProgramSegments(Elf32_Ehdr * h
 	return kernel_end;
 }
 
-ULONG CopyKernel(ULONG* kernel_end)
+static ULONG CopyKernel(ULONG* kernel_end)
 {
 	Elf32_Ehdr *header = (Elf32_Ehdr*)offset2addr(0L);
 
@@ -208,7 +210,7 @@ ULONG CopyKernel(ULONG* kernel_end)
 	return KSEG0ADDR(header->e_entry);
 }
 
-void copyRamdisk( void* rd_vaddr, void* rd_start, ULONG rd_size)
+static void copyRamdisk(void* rd_vaddr, void* rd_start, ULONG rd_size)
 {
 	memcpy(rd_vaddr, rd_start, rd_size);
 	printf("Copied initrd from 0x%p to 0x%p (0x%lx bytes)\n\r", 
@@ -226,7 +228,11 @@ void _start(LONG argc, CHAR * argv[], CH
 	void (*kernel_entry)(int argc, CHAR * argv[], CHAR * envp[]);
 
 	/* Print identification */
+#if (SUBARCH == IP22)
 	printf(ANSI_CLEAR "\n\rtip22: IP22 Linux tftpboot loader " __ARCSBOOT_VERSION__ "\n\r");
+#elif (SUBARCH == IP32)
+	printf(ANSI_CLEAR "\n\rtip32: IP32 Linux tftpboot loader " __ARCSBOOT_VERSION__ "\n\r");
+#endif
 
 	InitMalloc();
 
@@ -237,7 +243,7 @@ void _start(LONG argc, CHAR * argv[], CH
 	printf("Embedded ramdisk image starts 0x%p, ends 0x%p\n\r", 
 			&__rd_start, &__rd_end);
 #endif
-	kernel_entry = CopyKernel(&kernel_end);
+	kernel_entry = (void (*)(int, CHAR *[], CHAR *[]))CopyKernel(&kernel_end);
 
 	/* align to page boundary */
 	rd_vaddr = (char*)(((kernel_end + PAGE_SIZE) / PAGE_SIZE ) * PAGE_SIZE);
diff -urpN arcboot-0.3.8.4.old/tip22/tftpload.h arcboot-0.3.8.4/tip22/tftpload.h
--- arcboot-0.3.8.4.old/tip22/tftpload.h	2002-09-27 14:04:08.000000000 +0200
+++ arcboot-0.3.8.4/tip22/tftpload.h	1970-01-01 01:00:00.000000000 +0100
@@ -1,14 +0,0 @@
-/*
- * Copyright 2001 Guido Guenther <agx@sigxcpu.org>
- */
-
-#ifndef _TFTPLOAD_H
-#define _TFTPLOAD_H
-
-#include <version.h>
-
-typedef enum { False = 0, True } Boolean;
-
-void Fatal(const CHAR * message, ...);
-
-#endif /* _TFTPLAOD_H */
diff -urpN arcboot-0.3.8.4.old/tip22/tip22 arcboot-0.3.8.4/tip22/tip22
--- arcboot-0.3.8.4.old/tip22/tip22	2003-04-26 17:07:26.000000000 +0200
+++ arcboot-0.3.8.4/tip22/tip22	2004-11-15 22:42:13.000000000 +0100
@@ -1,14 +1,16 @@
 #! /bin/sh -e
 #
-# Merges kernel and ramdisk into one ecoff bootimage
+# Merges kernel and ramdisk into one ECOFF bootimage
 
-LIBDIR=/usr/lib/tip22/
-TIP22=$LIBDIR/tftpload.o
+SUBARCH=IP22
+
+LIBDIR=/usr/lib/tip22
+TIP22=$LIBDIR/tftpload.$SUBARCH.o
 ARCLIB=$LIBDIR/libarc.a
-LD_KERNEL=$LIBDIR/ld.kernel.script
-LD_RAMDISK=$LIBDIR/ld.ramdisk.script
-LD_SCRIPT=$LIBDIR/ld.script
-LDFLAGS="-N --oformat ecoff-bigmips"
+LD_KERNEL=$LIBDIR/ld.kernel.script.$SUBARCH
+LD_RAMDISK=$LIBDIR/ld.ramdisk.script.$SUBARCH
+LD_SCRIPT=$LIBDIR/ld.script.$SUBARCH
+LDFLAGS="-N"
 LD=/usr/bin/ld
 MKTEMP=/bin/mktemp
 
diff -urpN arcboot-0.3.8.4.old/tip22/tip32 arcboot-0.3.8.4/tip22/tip32
--- arcboot-0.3.8.4.old/tip22/tip32	1970-01-01 01:00:00.000000000 +0100
+++ arcboot-0.3.8.4/tip22/tip32	2004-11-15 22:42:13.000000000 +0100
@@ -0,0 +1,51 @@
+#! /bin/sh -e
+#
+# Merges kernel and ramdisk into one ELF bootimage
+
+SUBARCH=IP32
+
+LIBDIR=/usr/lib/tip22
+TIP22=$LIBDIR/tftpload.$SUBARCH.o
+ARCLIB=$LIBDIR/libarc.a
+LD_KERNEL=$LIBDIR/ld.kernel.script.$SUBARCH
+LD_RAMDISK=$LIBDIR/ld.ramdisk.script.$SUBARCH
+LD_SCRIPT=$LIBDIR/ld.script.$SUBARCH
+LDFLAGS="-n"
+LD=/usr/bin/ld
+MKTEMP=/bin/mktemp
+
+usage() {
+    echo "`basename $0` vmlinux initrd outfile"
+    exit 1
+}
+
+if [ "$#" != "3" ]; then
+	usage
+fi
+
+if ! file $2 | grep 'gzip compressed data' > /dev/null 2>&1; then
+	echo "$2 is no gzip compressed ramdisk".
+	usage
+fi
+
+if ! file $1 | grep 'ELF .* MIPS' > /dev/null 2>&1; then
+	echo "$1 is no ELF kernel".
+	usage
+fi
+
+if [ ! -x $MKTEMP ]; then
+	echo "Need mktemp."
+	exit 1
+fi
+
+if ! TMPDIR=`mktemp -d`; then
+	echo "mktemp failed."
+	exit 1
+fi
+
+echo -n "Merging kernel \"$1\" and ramdisk \"$2\" into bootimage \"$3\"..."
+${LD} -T $LD_KERNEL -b binary -o $TMPDIR/kernel.o $1
+${LD} -T $LD_RAMDISK -b binary -o $TMPDIR/ramdisk.o $2
+${LD} -T $LD_SCRIPT ${LDFLAGS} -o $3 ${TIP22} ${ARCLIB} $TMPDIR/kernel.o $TMPDIR/ramdisk.o
+rm -rf $TMPDIR
+echo "done."
