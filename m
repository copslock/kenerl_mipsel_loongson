Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2004 01:33:04 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:47881 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224914AbUJSAc5>; Tue, 19 Oct 2004 01:32:57 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 4995AE1CB0; Tue, 19 Oct 2004 02:32:17 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 04382-07; Tue, 19 Oct 2004 02:32:17 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 06C26E1C7B; Tue, 19 Oct 2004 02:32:17 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.12.11) with ESMTP id i9J0WboD006713;
	Tue, 19 Oct 2004 02:32:37 +0200
Date: Tue, 19 Oct 2004 01:32:23 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: [PATCH] 2.4: 32-bit/64-bit ELF format selection for building
Message-ID: <Pine.LNX.4.58L.0410190122040.12159@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6095
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

Hello,

 Here's support for selection between 64-bit and 32-bit ELF format for
building for 2.4, complementing the patch for 2.6 I've sent previously.  
This was tested with a couple of DECstation, Malta and SWARM
configurations using a snapshot of GCC 3.5 and a snapshot of binutils
2.15.91 or binutils 2.13.2.1.  This is ready for inclusion as well.

  Maciej

patch-mips-2.4.26-20040809-mips-elf64-4
diff -up --recursive --new-file linux-mips-2.4.26-20040809.macro/Documentation/Configure.help linux-mips-2.4.26-20040809/Documentation/Configure.help
--- linux-mips-2.4.26-20040809.macro/Documentation/Configure.help	2004-04-17 02:56:33.000000000 +0000
+++ linux-mips-2.4.26-20040809/Documentation/Configure.help	2004-10-17 20:45:31.000000000 +0000
@@ -2636,6 +2636,19 @@ CONFIG_CPU_HAS_WB
   machines which require flushing of write buffers in software.  Saying
   Y is the safe option; N may result in kernel malfunction and crashes.
 
+Use 64-bit ELF format for building
+CONFIG_BUILD_ELF64
+  A 64-bit kernel is usually built using the 64-bit ELF binary object
+  format as it's one that allows arbitrary 64-bit constructs.  For
+  kernels that are loaded within the KSEG compatibility segments the
+  32-bit ELF format can optionally be used resulting in a somewhat
+  smaller binary, but this option is not explicitly supported by the
+  toolchain and since binutils 2.14 it does not even work at all.
+
+  Say Y to use the 64-bit format or N to use the 32-bit one.
+
+  If unsure say Y.
+
 Support for large 64-bit configurations
 CONFIG_MIPS_INSANE_LARGE
   MIPS R10000 does support a 44 bit / 16TB address space as opposed to
diff -up --recursive --new-file linux-mips-2.4.26-20040809.macro/arch/mips/Makefile linux-mips-2.4.26-20040809/arch/mips/Makefile
--- linux-mips-2.4.26-20040809.macro/arch/mips/Makefile	2004-06-09 02:57:04.000000000 +0000
+++ linux-mips-2.4.26-20040809/arch/mips/Makefile	2004-10-17 02:13:37.000000000 +0000
@@ -5,7 +5,7 @@
 #
 # Copyright (C) 1994, 1995, 1996 by Ralf Baechle
 # DECStation modifications by Paul M. Antoine, 1996
-# Copyright (C) 2002, 2003  Maciej W. Rozycki
+# Copyright (C) 2002, 2003, 2004  Maciej W. Rozycki
 #
 # This file is included by the global makefile so that you can add your own
 # architecture-specific flags and dependencies. Remember to do have actions
@@ -743,6 +743,11 @@ rom.bin rom.sw: vmlinux
 	$(MAKE) -C arch/$(ARCH)/lasat/image $@
 endif
 
+boot: mips-boot
+
+mips-boot: vmlinux
+	@$(MAKEBOOT) boot
+
 vmlinux.ecoff: vmlinux
 	@$(MAKEBOOT) $@
 
diff -up --recursive --new-file linux-mips-2.4.26-20040809.macro/arch/mips/boot/Makefile linux-mips-2.4.26-20040809/arch/mips/boot/Makefile
--- linux-mips-2.4.26-20040809.macro/arch/mips/boot/Makefile	2003-08-23 02:56:27.000000000 +0000
+++ linux-mips-2.4.26-20040809/arch/mips/boot/Makefile	2004-10-17 21:39:22.000000000 +0000
@@ -4,6 +4,7 @@
 # for more details.
 #
 # Copyright (C) 1995, 1998, 2001 by Ralf Baechle
+# Copyright (C) 2004  Maciej W. Rozycki
 #
 
 USE_STANDARD_AS_RULE := true
@@ -21,19 +22,23 @@ endif
 # Drop some uninteresting sections in the kernel.
 # This is only relevant for ELF kernels but doesn't hurt a.out
 #
-drop-sections	= .reginfo .mdebug
+drop-sections	= .reginfo .mdebug .comment .note .pdr .options .MIPS.options
 strip-flags	= $(addprefix --remove-section=,$(drop-sections))
 
-all: vmlinux.ecoff vmlinux.srec addinitrd
+VMLINUX = $(TOPDIR)/vmlinux
 
-vmlinux.ecoff:	$(CONFIGURE) elf2ecoff $(TOPDIR)/vmlinux
-	./elf2ecoff $(TOPDIR)/vmlinux vmlinux.ecoff $(E2EFLAGS)
+all:
+
+boot: vmlinux.ecoff vmlinux.srec addinitrd
+
+vmlinux.ecoff:	$(CONFIGURE) elf2ecoff $(VMLINUX)
+	./elf2ecoff $(VMLINUX) vmlinux.ecoff $(E2EFLAGS)
 
 elf2ecoff: elf2ecoff.c
 	$(HOSTCC) -o $@ $^
 
-vmlinux.srec: $(CONFIGURE) $(TOPDIR)/vmlinux
-	$(OBJCOPY) -S -O srec $(strip-flags) $(TOPDIR)/vmlinux vmlinux.srec
+vmlinux.srec: $(CONFIGURE) $(VMLINUX)
+	$(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) vmlinux.srec
 
 addinitrd: addinitrd.c
 	$(HOSTCC) -o $@ $^
@@ -42,15 +47,10 @@ addinitrd: addinitrd.c
 dep:
 
 clean:
-	rm -f vmlinux.ecoff
-	rm -f vmlinux.srec
-	rm -f zImage zImage.tmp
+	rm -f vmlinux.ecoff vmlinux.srec
 
 mrproper:
-	rm -f vmlinux.ecoff
-	rm -f vmlinux.srec
-	rm -f addinitrd
-	rm -f elf2ecoff
+	rm -f vmlinux.ecoff vmlinux.srec addinitrd elf2ecoff
 
 dummy:
 
diff -up --recursive --new-file linux-mips-2.4.26-20040809.macro/arch/mips/config-shared.in linux-mips-2.4.26-20040809/arch/mips/config-shared.in
--- linux-mips-2.4.26-20040809.macro/arch/mips/config-shared.in	2004-06-13 02:57:05.000000000 +0000
+++ linux-mips-2.4.26-20040809/arch/mips/config-shared.in	2004-10-15 00:46:04.000000000 +0000
@@ -739,6 +739,8 @@ else
    fi
 fi
 
+dep_bool 'Use 64-bit ELF format for building' CONFIG_BUILD_ELF64 $CONFIG_MIPS64
+
 if [ "$CONFIG_CPU_LITTLE_ENDIAN" = "n" ]; then
    bool 'Include IRIX binary compatibility' CONFIG_BINFMT_IRIX
 fi
diff -up --recursive --new-file linux-mips-2.4.26-20040809.macro/arch/mips64/Makefile linux-mips-2.4.26-20040809/arch/mips64/Makefile
--- linux-mips-2.4.26-20040809.macro/arch/mips64/Makefile	2004-03-25 03:57:09.000000000 +0000
+++ linux-mips-2.4.26-20040809/arch/mips64/Makefile	2004-10-18 01:20:39.000000000 +0000
@@ -3,7 +3,7 @@
 # License.  See the file "COPYING" in the main directory of this archive
 # for more details.
 #
-# Copyright (C) 2002, 2003  Maciej W. Rozycki
+# Copyright (C) 2002, 2003, 2004  Maciej W. Rozycki
 #
 # This file is included by the global makefile so that you can add your own
 # architecture-specific flags and dependencies. Remember to do have actions
@@ -160,7 +160,7 @@ endif
 ifdef CONFIG_MIPS_COBALT
 SUBDIRS		+= arch/mips/cobalt
 CORE_FILES	+= arch/mips/cobalt/cobalt.o
-LOADADDR	:= 0x80080000
+LOADADDR	:= 0xffffffff80080000
 endif
 
 #
@@ -170,7 +170,7 @@ ifdef CONFIG_DECSTATION
 CORE_FILES	+= arch/mips/dec/dec.o
 SUBDIRS		+= arch/mips/dec arch/mips/dec/prom
 LIBS		+= arch/mips/dec/prom/rexlib.a
-LOADADDR	:= 0x80040000
+LOADADDR	:= 0xffffffff80040000
 endif
 
 #
@@ -180,7 +180,7 @@ ifdef CONFIG_MIPS_EV64120
 LIBS		+= arch/mips/gt64120/common/gt64120.o \
 		   arch/mips/gt64120/ev64120/ev64120.o
 SUBDIRS		+= arch/mips/gt64120/common arch/mips/gt64120/ev64120
-LOADADDR	:= 0x80100000
+LOADADDR	:= 0xffffffff80100000
 endif
 
 #
@@ -190,7 +190,7 @@ ifdef CONFIG_MIPS_ATLAS
 LIBS		+= arch/mips/mips-boards/atlas/atlas.o \
 		   arch/mips/mips-boards/generic/mipsboards.o
 SUBDIRS		+= arch/mips/mips-boards/generic arch/mips/mips-boards/atlas
-LOADADDR	:= 0x80100000
+LOADADDR	:= 0xffffffff80100000
 endif
 
 #
@@ -200,7 +200,7 @@ ifdef CONFIG_MIPS_MALTA
 LIBS		+= arch/mips/mips-boards/malta/malta.o \
 		   arch/mips/mips-boards/generic/mipsboards.o
 SUBDIRS		+= arch/mips/mips-boards/malta arch/mips/mips-boards/generic
-LOADADDR	:= 0x80100000
+LOADADDR	:= 0xffffffff80100000
 endif
 
 #
@@ -210,7 +210,7 @@ ifdef CONFIG_MIPS_SEAD
 LIBS		+= arch/mips/mips-boards/sead/sead.o \
 		   arch/mips/mips-boards/generic/mipsboards.o
 SUBDIRS		+= arch/mips/mips-boards/generic arch/mips/mips-boards/sead
-LOADADDR	:= 0x80100000
+LOADADDR	:= 0xffffffff80100000
 endif
 
 #
@@ -222,7 +222,7 @@ ifdef CONFIG_MOMENCO_OCELOT
 CORE_FILES      += arch/mips/gt64120/common/gt64120.o \
 		   arch/mips/gt64120/momenco_ocelot/momenco_ocelot.o
 SUBDIRS		+= arch/mips/gt64120/common arch/mips/gt64120/momenco_ocelot
-LOADADDR	:= 0x80100000
+LOADADDR	:= 0xffffffff80100000
 endif
 
 #
@@ -233,7 +233,7 @@ ifdef CONFIG_MOMENCO_OCELOT_G
 # mips_io_port_base.
 CORE_FILES	+= arch/mips/momentum/ocelot_g/ocelot_g.o
 SUBDIRS		+= arch/mips/momentum/ocelot_g
-LOADADDR	:= 0x80100000
+LOADADDR	:= 0xffffffff80100000
 endif
                                                                                 
 #
@@ -242,16 +242,16 @@ endif
 ifdef CONFIG_MOMENCO_OCELOT_C
 CORE_FILES	+= arch/mips/momentum/ocelot_c/ocelot_c.o
 SUBDIRS		+= arch/mips/momentum/ocelot_c
-LOADADDR	:= 0x80100000
+LOADADDR	:= 0xffffffff80100000
 endif
 
 ifdef CONFIG_MOMENCO_JAGUAR_ATX
 LIBS		+= arch/mips/momentum/jaguar_atx/jaguar_atx.o
 SUBDIRS		+= arch/mips/momentum/jaguar_atx
 ifdef CONFIG_JAGUAR_DMALOW
-LOADADDR	:= 0x88000000
+LOADADDR	:= 0xffffffff88000000
 else
-LOADADDR	:= 0x80100000
+LOADADDR	:= 0xffffffff80100000
 endif
 endif
 
@@ -268,11 +268,11 @@ CORE_FILES	+= arch/mips/sgi-ip22/ip22-ke
 LIBS		+= arch/mips/arc/arclib.a
 SUBDIRS		+= arch/mips/sgi-ip22 arch/mips/arc
 #
-# Set LOADADDR to >= 0x88069000 if you want to leave space for symmon,
-# 0x88004000 for production kernels.  Note that the value must be
+# Set LOADADDR to >= 0xffffffff88069000 if you want to leave space for symmon,
+# 0xffffffff88004000 for production kernels.  Note that the value must be
 # 16kb aligned or the handling of the current variable will break.
 #
-LOADADDR	:= 0x88004000
+LOADADDR	:= 0xffffffff88004000
 endif
 
 #
@@ -287,11 +287,22 @@ SUBDIRS		+= arch/mips/sgi-ip27 arch/mips
 # symmon, 0xc00000000001c000 for production kernels.  Note that the value
 # must be 16kb aligned or the handling of the current variable will break.
 #
-#LOADADDR	:= 0xa80000000001c000
+ifdef CONFIG_BUILD_ELF64
 ifdef CONFIG_MAPPED_KERNEL
-LOADADDR	:= 0xc001c000
+LOADADDR	:= 0xc00000004001c000
+OBJCOPYFLAGS	:= --change-addresses=0x3fffffff80000000
 else
-LOADADDR	:= 0x8001c000
+LOADADDR	:= 0xa80000000001c000
+OBJCOPYFLAGS	:= --change-addresses=0x57ffffff80000000
+endif
+else
+ifdef CONFIG_MAPPED_KERNEL
+LOADADDR	:= 0xffffffffc001c000
+OBJCOPYFLAGS	:= --change-addresses=0xc000000080000000
+else
+LOADADDR	:= 0xffffffff8001c000
+OBJCOPYFLAGS	:= --change-addresses=0xa800000080000000
+endif
 endif
 endif
 
@@ -305,9 +316,9 @@ ifneq ($(CONFIG_SIBYTE_SB1250)$(CONFIG_S
 LIBS		+= arch/mips/sibyte/sb1250/sb1250.o
 SUBDIRS		+= arch/mips/sibyte/sb1250
 ifdef CONFIG_MIPS_UNCACHED
-LOADADDR	:= 0xa0100000
+LOADADDR	:= 0xffffffffa0100000
 else
-LOADADDR	:= 0x80100000
+LOADADDR	:= 0xffffffff80100000
 endif
 endif
 
@@ -334,26 +345,6 @@ LIBS		+= arch/mips/sibyte/cfe/cfe.a
 SUBDIRS		+= arch/mips/sibyte/cfe
 endif
 
-#
-# Some machines like the Indy need 32-bit ELF binaries for booting purposes.
-# Other need ECOFF, so we build a 32-bit ELF binary for them which we then
-# convert to ECOFF using elf2ecoff.
-#
-ifdef CONFIG_BOOT_ELF32
-GCCFLAGS += -Wa,-32 $(call check_gas,-Wa$(comma)-mgp64,)
-LINKFLAGS += -T arch/mips64/ld.script.elf32
-endif
-#
-# The 64-bit ELF tools are pretty broken so at this time we generate 64-bit
-# ELF files from 32-bit files by conversion.
-#
-ifdef CONFIG_BOOT_ELF64
-GCCFLAGS += -Wa,-32 $(call check_gas,-Wa$(comma)-mgp64,)
-LINKFLAGS += -T arch/mips64/ld.script.elf32
-#AS += -64
-#LD += -m elf64bmip
-#LINKFLAGS += -T arch/mips64/ld.script.elf64
-endif
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 32bit-bfd = elf32-tradlittlemips
@@ -363,14 +354,30 @@ else
 64bit-bfd = elf64-tradbigmips
 endif
 
+ifdef CONFIG_BUILD_ELF64
+GCCFLAGS += -Wa,-64
+LOADSCRIPT = arch/mips64/ld.script.elf64
+build-bfd = $(64bit-bfd)
+vmlinux-32 = vmlinux.32
+vmlinux-64 = vmlinux
+else
+GCCFLAGS += $(call check_gcc,-mno-explicit-relocs,)
+GCCFLAGS += -Wa,-32 $(call check_gas,-Wa$(comma)-mgp64,)
+LOADSCRIPT = arch/mips64/ld.script.elf32
+build-bfd = $(32bit-bfd)
+vmlinux-32 = vmlinux
+vmlinux-64 = vmlinux.64
+endif
+
 
 AFLAGS		+= $(GCCFLAGS)
 CFLAGS		+= $(GCCFLAGS)
 
-LD		+= --oformat $(32bit-bfd)
+LD		+= --oformat $(build-bfd)
 
 
-LINKFLAGS += -Ttext $(LOADADDR)
+LINKFLAGS += -T $(LOADSCRIPT) -Ttext $(LOADADDR)
+OBJCOPYFLAGS += --remove-section=.reginfo
 
 HEAD := arch/mips64/kernel/head.o arch/mips64/kernel/init_task.o
 
@@ -378,27 +385,51 @@ SUBDIRS := $(addprefix arch/mips/, tools
 CORE_FILES := arch/mips64/kernel/kernel.o arch/mips64/mm/mm.o $(CORE_FILES)
 LIBS := arch/mips64/lib/lib.a $(LIBS)
 
-MAKEBOOT = $(MAKE) -C arch/$(ARCH)/boot
+MAKEBOOT = $(MAKE) -C arch/$(ARCH)/boot VMLINUX=$(TOPDIR)/$(vmlinux-32)
 
-vmlinux: arch/mips64/ld.script.elf32
 arch/mips64/ld.script.elf32: arch/mips64/ld.script.elf32.S
 	$(CPP) -C -P -I$(HPATH) -imacros $(HPATH)/asm-mips64/sn/mapped_kernel.h -Umips arch/mips64/ld.script.elf32.S > arch/mips64/ld.script.elf32
 
-ifdef CONFIG_MAPPED_KERNEL
-vmlinux.64: vmlinux
-	$(OBJCOPY) -O $(64bit-bfd) --remove-section=.reginfo --change-addresses=0xc000000080000000 $< $@
-else
+vmlinux: $(LOADSCRIPT)
+
+#
+# Some machines like the Indy need 32-bit ELF binaries for booting purposes.
+# Other need ECOFF, so we build a 32-bit ELF binary for them which we then
+# convert to ECOFF using elf2ecoff.
+#
+vmlinux.32: vmlinux
+	$(OBJCOPY) -O $(32bit-bfd) $(OBJCOPYFLAGS) $< $@
+
+#
+# The 64-bit ELF tools are pretty broken so at this time we generate 64-bit
+# ELF files from 32-bit files by conversion.
+#
 vmlinux.64: vmlinux
-	$(OBJCOPY) -O $(64bit-bfd) --remove-section=.reginfo --change-addresses=0xa800000080000000 $< $@
+	$(OBJCOPY) -O $(64bit-bfd) $(OBJCOPYFLAGS) $< $@
+
+ifdef CONFIG_BOOT_ELF32
+boot: $(vmlinux-32)
 endif
 
-vmlinux.ecoff: vmlinux
+ifdef CONFIG_BOOT_ELF64
+boot: $(vmlinux-64)
+endif
+
+boot: mips-boot
+
+mips-boot: $(vmlinux-32)
+	@$(MAKEBOOT) boot
+
+vmlinux.ecoff: $(vmlinux-32)
+	@$(MAKEBOOT) $@
+
+vmlinux.srec: $(vmlinux-32)
 	@$(MAKEBOOT) $@
 
 archclean:
 	@$(MAKEBOOT) clean
 	$(MAKE) -C arch/mips/tools clean
-	rm -f vmlinux.64 arch/$(ARCH)/ld.script.elf32
+	rm -f vmlinux.32 vmlinux.64 arch/$(ARCH)/ld.script.elf32
 
 archmrproper:
 	@$(MAKEBOOT) mrproper
diff -up --recursive --new-file linux-mips-2.4.26-20040809.macro/arch/mips64/boot/Makefile linux-mips-2.4.26-20040809/arch/mips64/boot/Makefile
--- linux-mips-2.4.26-20040809.macro/arch/mips64/boot/Makefile	2003-01-11 03:57:10.000000000 +0000
+++ linux-mips-2.4.26-20040809/arch/mips64/boot/Makefile	2004-10-17 21:39:34.000000000 +0000
@@ -4,6 +4,7 @@
 # for more details.
 #
 # Copyright (C) 1995, 1998, 1999 by Ralf Baechle
+# Copyright (C) 2004  Maciej W. Rozycki
 #
 
 USE_STANDARD_AS_RULE := true
@@ -17,14 +18,28 @@ else
   E2EFLAGS =
 endif
 
-all: vmlinux.ecoff addinitrd
+#
+# Drop some uninteresting sections in the kernel.
+# This is only relevant for ELF kernels but doesn't hurt a.out
+#
+drop-sections	= .reginfo .mdebug .comment .note .pdr .options .MIPS.options
+strip-flags	= $(addprefix --remove-section=,$(drop-sections))
+
+VMLINUX = $(TOPDIR)/vmlinux
 
-vmlinux.ecoff:	$(CONFIGURE) elf2ecoff $(TOPDIR)/vmlinux
-	./elf2ecoff $(TOPDIR)/vmlinux vmlinux.ecoff $(E2EFLAGS)
+all:
+
+boot: vmlinux.ecoff vmlinux.srec addinitrd
+
+vmlinux.ecoff: $(CONFIGURE) elf2ecoff $(VMLINUX)
+	./elf2ecoff $(VMLINUX) vmlinux.ecoff $(E2EFLAGS)
 
 elf2ecoff: $(TOPDIR)/arch/mips/boot/elf2ecoff.c
 	$(HOSTCC) -I$(TOPDIR)/arch/mips/boot -I- -o $@ $^
 
+vmlinux.srec: $(CONFIGURE) $(VMLINUX)
+	$(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) vmlinux.srec
+
 addinitrd: $(TOPDIR)/arch/mips/boot/addinitrd.c
 	$(HOSTCC) -I$(TOPDIR)/arch/mips/boot -I- -o $@ $^
 
@@ -32,10 +47,10 @@ addinitrd: $(TOPDIR)/arch/mips/boot/addi
 dep:
 
 clean:
-	rm -f vmlinux.ecoff
+	rm -f vmlinux.ecoff vmlinux.srec
 
 mrproper:
-	rm -f vmlinux.ecoff addinitrd elf2ecoff
+	rm -f vmlinux.ecoff vmlinux.srec addinitrd elf2ecoff
 
 dummy:
 
diff -up --recursive --new-file linux-mips-2.4.26-20040809.macro/arch/mips64/ld.script.elf32.S linux-mips-2.4.26-20040809/arch/mips64/ld.script.elf32.S
--- linux-mips-2.4.26-20040809.macro/arch/mips64/ld.script.elf32.S	2003-11-01 03:56:54.000000000 +0000
+++ linux-mips-2.4.26-20040809/arch/mips64/ld.script.elf32.S	2003-12-15 21:52:56.000000000 +0000
@@ -55,6 +55,8 @@ SECTIONS
 
   .fini      : { *(.fini)    } =0
   .reginfo : { *(.reginfo) }
+  .options : { *(.options) }
+  .MIPS.options : { *(.MIPS.options) }
   /* Adjust the address for the data segment.  We want to adjust up to
      the same address within the page on the next page up.  It would
      be more correct to do this:
diff -up --recursive --new-file linux-mips-2.4.26-20040809.macro/arch/mips64/ld.script.elf64 linux-mips-2.4.26-20040809/arch/mips64/ld.script.elf64
--- linux-mips-2.4.26-20040809.macro/arch/mips64/ld.script.elf64	2003-11-01 03:56:54.000000000 +0000
+++ linux-mips-2.4.26-20040809/arch/mips64/ld.script.elf64	2003-12-15 21:52:56.000000000 +0000
@@ -64,6 +64,8 @@ SECTIONS
 
   .fini      : { *(.fini)    } =0
   .reginfo : { *(.reginfo) }
+  .options : { *(.options) }
+  .MIPS.options : { *(.MIPS.options) }
   /* Adjust the address for the data segment.  We want to adjust up to
      the same address within the page on the next page up.  It would
      be more correct to do this:
