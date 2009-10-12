Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Oct 2009 18:06:15 +0200 (CEST)
Received: from mail-fx0-f221.google.com ([209.85.220.221]:49891 "EHLO
	mail-fx0-f221.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1492822AbZJLQGI (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 12 Oct 2009 18:06:08 +0200
Received: by fxm21 with SMTP id 21so7351396fxm.33
        for <multiple recipients>; Mon, 12 Oct 2009 09:05:59 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=p95ZSqCA1LdmXB4OLjl4yG07E6CToG8TTvasvuuYlz4=;
        b=OonSio5+WNqY8VHaiirVKYzw2YSbKIMjs4chGqQufbw57BP2TwUcroag/TZQaUINcu
         E9f5bamdMvJ4S/USDzHaReXDSGCih/KY2AG7T7fHGUPLaofgoTjc5PO2hcq0cwza5kRu
         AnG4iWaS/3DdpabwLD9SYpIW3THu1y9UvtqzQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=gwdJEuyTt0LhBa42bch/niUmkVGyG9+0HNqQVcq+/inqAR/SZp2m77sbhKOgC/BYDi
         VNFsP7Sn9GHvbiaWHZjwtPgNFED5QoLrARFFcb8u3hbDKnmsa0v5jvQFeAEGpfEnXght
         VxZwWgatPFJ1fzdGdBgHfwdF7cpwiXGFSGbLk=
Received: by 10.86.164.6 with SMTP id m6mr5400091fge.42.1255363559516;
        Mon, 12 Oct 2009 09:05:59 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id 4sm82147fgg.13.2009.10.12.09.05.52
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 12 Oct 2009 09:05:56 -0700 (PDT)
From:	Wu Zangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
	Manuel Lauss <manuel.lauss@googlemail.com>,
	Wu Zhangjin <wuzhangjin@gmail.com>,
	Alexander Clouter <alex@digriz.org.uk>
Subject: [PATCH -v2] MIPS: add support for gzip/bzip2/lzma compressed kernel images
Date:	Tue, 13 Oct 2009 00:05:46 +0800
Message-Id: <1255363546-10295-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24232
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

From: Wu Zhangjin <wuzhangjin@gmail.com>

This patch will help to generate smaller kernel images for linux-MIPS,

Here is the effect when using lzma:

$ ls -sh vmlinux
7.1M vmlinux
$ ls -sh arch/mips/boot/compressed/vmlinuz
1.5M arch/mips/boot/compressed/vmlinuz

Have tested the 32bit kernel on Qemu/Malta and 64bit kernel on FuLoong
Mini PC. both of them work well. and also, tested by Alexander Clouter
on an AR7 based Linksys WAG54Gv2, and by Manuel Lauss on an Alchemy
board.

This -v2 version incorporate the feedback from Ralf, and add the
following changes:

1. add .ecoff, .bin, .erec format support
2. only enable it and the debug source code for the machines we tested
3. a dozens of fixups and cleanups

and if you want to enable it for your board, please try to select
SYS_SUPPORTS_ZBOOT for it, and if the board have an 16550 compatible
uart, you can select SYS_SUPPORTS_ZBOOT_UART16550 directly. and then
sending the relative patches to Ralf.

Tested-by: Manuel Lauss <manuel.lauss@googlemail.com>
Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig                      |   14 +++
 arch/mips/Makefile                     |   31 ++++++-
 arch/mips/boot/compressed/Makefile     |  100 +++++++++++++++++++++
 arch/mips/boot/compressed/dbg.c        |   37 ++++++++
 arch/mips/boot/compressed/decompress.c |  126 +++++++++++++++++++++++++++
 arch/mips/boot/compressed/dummy.c      |    4 +
 arch/mips/boot/compressed/head.S       |   55 ++++++++++++
 arch/mips/boot/compressed/ld.script    |  150 ++++++++++++++++++++++++++++++++
 arch/mips/boot/compressed/uart-16550.c |   43 +++++++++
 9 files changed, 557 insertions(+), 3 deletions(-)
 create mode 100644 arch/mips/boot/compressed/Makefile
 create mode 100644 arch/mips/boot/compressed/dbg.c
 create mode 100644 arch/mips/boot/compressed/decompress.c
 create mode 100644 arch/mips/boot/compressed/dummy.c
 create mode 100644 arch/mips/boot/compressed/head.S
 create mode 100644 arch/mips/boot/compressed/ld.script
 create mode 100644 arch/mips/boot/compressed/uart-16550.c

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 9da6a52..96bb02d 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -21,6 +21,7 @@ choice
 
 config MACH_ALCHEMY
 	bool "Alchemy processor based machines"
+	select SYS_SUPPORTS_ZBOOT
 
 config AR7
 	bool "Texas Instruments AR7"
@@ -35,6 +36,7 @@ config AR7
 	select SYS_HAS_EARLY_PRINTK
 	select SYS_SUPPORTS_32BIT_KERNEL
 	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_SUPPORTS_ZBOOT_UART16550
 	select GENERIC_GPIO
 	select GCD
 	select VLYNQ
@@ -191,6 +193,7 @@ config LASAT
 
 config MACH_LOONGSON
 	bool "Loongson family of machines"
+	select SYS_SUPPORTS_ZBOOT_UART16550
 	help
 	  This enables the support of Loongson family of machines.
 
@@ -232,6 +235,7 @@ config MIPS_MALTA
 	select SYS_SUPPORTS_MIPS_CMP
 	select SYS_SUPPORTS_MULTITHREADING
 	select SYS_SUPPORTS_SMARTMIPS
+	select SYS_SUPPORTS_ZBOOT
 	help
 	  This enables support for the MIPS Technologies Malta evaluation
 	  board.
@@ -1294,6 +1298,16 @@ config CPU_CAVIUM_OCTEON
 
 endchoice
 
+config SYS_SUPPORTS_ZBOOT
+	bool
+	select HAVE_KERNEL_GZIP
+	select HAVE_KERNEL_BZIP2
+	select HAVE_KERNEL_LZMA
+
+config SYS_SUPPORTS_ZBOOT_UART16550
+	bool
+	select SYS_SUPPORTS_ZBOOT
+
 config CPU_LOONGSON2
 	bool
 	select CPU_SUPPORTS_32BIT_KERNEL
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index d45e596..ccd713d 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -69,6 +69,7 @@ endif
 
 all-$(CONFIG_BOOT_ELF32)	:= $(vmlinux-32)
 all-$(CONFIG_BOOT_ELF64)	:= $(vmlinux-64)
+all-$(CONFIG_SYS_SUPPORTS_ZBOOT)+= vmlinuz
 
 #
 # GCC uses -G 0 -mabicalls -fpic as default.  We don't want PIC in the kernel
@@ -336,7 +337,7 @@ load-$(CONFIG_LEMOTE_YEELOONG2F) +=0xffffffff80200000
 core-$(CONFIG_MIPS_MALTA)	+= arch/mips/mti-malta/
 cflags-$(CONFIG_MIPS_MALTA)	+= -I$(srctree)/arch/mips/include/asm/mach-malta
 load-$(CONFIG_MIPS_MALTA)	+= 0xffffffff80100000
-all-$(CONFIG_MIPS_MALTA)	:= vmlinux.bin
+all-$(CONFIG_MIPS_MALTA)	:= vmlinuz.bin
 
 #
 # MIPS SIM
@@ -586,7 +587,7 @@ load-$(CONFIG_SNI_RM)		+= 0xffffffff80600000
 else
 load-$(CONFIG_SNI_RM)		+= 0xffffffff80030000
 endif
-all-$(CONFIG_SNI_RM)		:= vmlinux.ecoff
+all-$(CONFIG_SNI_RM)		:= vmlinuz.ecoff
 
 #
 # Common TXx9
@@ -704,9 +705,23 @@ vmlinux.64: vmlinux
 	$(OBJCOPY) -O $(64bit-bfd) $(OBJCOPYFLAGS) $< $@
 
 makeboot =$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) $(1)
+makezboot =$(Q)$(MAKE) $(build)=arch/mips/boot/compressed \
+	   VMLINUX_LOAD_ADDRESS=$(load-y) 32bit-bfd=$(32bit-bfd) $(1)
 
 all:	$(all-y)
 
+vmlinuz: vmlinux
+	+@$(call makezboot,$@)
+
+vmlinuz.bin: vmlinux
+	+@$(call makezboot,$@)
+
+vmlinuz.ecoff: vmlinux
+	+@$(call makezboot,$@)
+
+vmlinuz.srec: vmlinux
+	+@$(call makezboot,$@)
+
 vmlinux.bin: $(vmlinux-32)
 	+@$(call makeboot,$@)
 
@@ -731,11 +746,13 @@ endif
 
 install:
 	$(Q)install -D -m 755 vmlinux $(INSTALL_PATH)/vmlinux-$(KERNELRELEASE)
+	$(Q)install -D -m 755 vmlinuz $(INSTALL_PATH)/vmlinuz-$(KERNELRELEASE)
 	$(Q)install -D -m 644 .config $(INSTALL_PATH)/config-$(KERNELRELEASE)
 	$(Q)install -D -m 644 System.map $(INSTALL_PATH)/System.map-$(KERNELRELEASE)
 
 archclean:
 	@$(MAKE) $(clean)=arch/mips/boot
+	@$(MAKE) $(clean)=arch/mips/boot/compressed
 	@$(MAKE) $(clean)=arch/mips/lasat
 
 define archhelp
@@ -743,10 +760,18 @@ define archhelp
 	echo '  vmlinux.ecoff        - ECOFF boot image'
 	echo '  vmlinux.bin          - Raw binary boot image'
 	echo '  vmlinux.srec         - SREC boot image'
+	echo '  vmlinuz              - Compressed boot(zboot) image'
+	echo '  vmlinuz.ecoff        - ECOFF zboot image'
+	echo '  vmlinuz.bin          - Raw binary zboot image'
+	echo '  vmlinuz.srec         - SREC zboot image'
 	echo
 	echo '  These will be default as apropriate for a configured platform.'
 endef
 
 CLEAN_FILES += vmlinux.32 \
 	       vmlinux.64 \
-	       vmlinux.ecoff
+	       vmlinux.ecoff \
+	       vmlinuz \
+	       vmlinuz.ecoff \
+	       vmlinuz.bin \
+	       vmlinuz.srec
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
new file mode 100644
index 0000000..140bd9b
--- /dev/null
+++ b/arch/mips/boot/compressed/Makefile
@@ -0,0 +1,100 @@
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.
+#
+# Adapted for MIPS Pete Popov, Dan Malek
+#
+# Copyright (C) 1994 by Linus Torvalds
+# Adapted for PowerPC by Gary Thomas
+# modified by Cort (cort@cs.nmt.edu)
+#
+# Copyright (C) 2009 Lemote Inc. & DSLab, Lanzhou University
+# Author: Wu Zhangjin <wuzj@lemote.com>
+#
+
+# compressed kernel load addr: VMLINUZ_LOAD_ADDRESS > VMLINUX_LOAD_ADDRESS + VMLINUX_SIZE
+VMLINUX_SIZE := $(shell wc -c $(objtree)/$(KBUILD_IMAGE) 2>/dev/null | cut -d' ' -f1)
+VMLINUX_SIZE := $(shell [ -n "$(VMLINUX_SIZE)" ] && echo $$(($(VMLINUX_SIZE) + (65536 - $(VMLINUX_SIZE) % 65536))))
+VMLINUZ_LOAD_ADDRESS := 0x$(shell [ -n "$(VMLINUX_SIZE)" ] && printf %x $$(($(VMLINUX_LOAD_ADDRESS) + $(VMLINUX_SIZE))))
+
+# set the default size of the mallocing area for decompressing
+BOOT_HEAP_SIZE := 0x400000
+
+KBUILD_CFLAGS := $(LINUXINCLUDE) $(KBUILD_CFLAGS) -D__KERNEL__ \
+	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE) -D"VMLINUX_LOAD_ADDRESS_ULL=$(VMLINUX_LOAD_ADDRESS)ull" \
+
+KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
+	-DKERNEL_ENTRY=0x$(shell $(NM) $(objtree)/$(KBUILD_IMAGE) 2>/dev/null | grep " kernel_entry" | cut -f1 -d \ ) \
+	-DBOOT_HEAP_SIZE=$(BOOT_HEAP_SIZE)
+
+obj-y := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
+
+obj-$(CONFIG_SYS_SUPPORTS_ZBOOT_UART16550) += $(obj)/uart-16550.o
+
+OBJCOPYFLAGS_vmlinux.bin := $(OBJCOPYFLAGS) -O binary -R .comment -S
+$(obj)/vmlinux.bin: $(KBUILD_IMAGE)
+	$(call if_changed,objcopy)
+
+suffix_$(CONFIG_KERNEL_GZIP)  = gz
+suffix_$(CONFIG_KERNEL_BZIP2) = bz2
+suffix_$(CONFIG_KERNEL_LZMA)  = lzma
+tool_$(CONFIG_KERNEL_GZIP)    = gzip
+tool_$(CONFIG_KERNEL_BZIP2)   = bzip2
+tool_$(CONFIG_KERNEL_LZMA)    = lzma
+$(obj)/vmlinux.$(suffix_y): $(obj)/vmlinux.bin
+	$(call if_changed,$(tool_y))
+	$(Q)rm -f $<
+
+$(obj)/piggy.o: $(obj)/vmlinux.$(suffix_y) $(obj)/dummy.o
+	$(Q)$(OBJCOPY) $(OBJCOPYFLAGS) \
+		--add-section=.image=$< \
+		--set-section-flags=.image=contents,alloc,load,readonly,data \
+		$(obj)/dummy.o $@
+	$(Q)rm -f $<
+
+LDFLAGS_vmlinuz := $(LDFLAGS) -Ttext $(VMLINUZ_LOAD_ADDRESS) -T
+vmlinuz: $(src)/ld.script $(obj-y) $(obj)/piggy.o
+	$(call if_changed,ld)
+	$(Q)$(OBJCOPY) $(OBJCOPYFLAGS) -R .comment -R .stab -R .stabstr -R .initrd -R .sysmap $@
+	$(Q)rm -f $(obj)/piggy.o
+
+#
+# Some DECstations need all possible sections of an ECOFF executable
+#
+ifdef CONFIG_MACH_DECSTATION
+  E2EFLAGS = -a
+else
+  E2EFLAGS =
+endif
+
+# elf2ecoff can only handle 32bit image
+
+ifdef CONFIG_32BIT
+	VMLINUZ = vmlinuz
+else
+	VMLINUZ = vmlinuz.32
+endif
+
+vmlinuz.32: vmlinuz
+	$(Q)$(OBJCOPY) -O $(32bit-bfd) $(OBJCOPYFLAGS) $< $@
+
+vmlinuz.ecoff: $(obj)/../elf2ecoff $(VMLINUZ)
+	$(Q)$(obj)/../elf2ecoff $(VMLINUZ) vmlinuz.ecoff $(E2EFLAGS)
+
+$(obj)/../elf2ecoff: $(src)/../elf2ecoff.c
+	$(Q)$(HOSTCC) -o $@ $^
+
+drop-sections	= .reginfo .mdebug .comment .note .pdr .options .MIPS.options
+strip-flags	= $(addprefix --remove-section=,$(drop-sections))
+
+OBJCOPYFLAGS_vmlinuz.bin := $(OBJCOPYFLAGS) -O binary $(strip-flags)
+vmlinuz.bin: vmlinuz
+	$(call if_changed,objcopy)
+
+OBJCOPYFLAGS_vmlinuz.srec := $(OBJCOPYFLAGS) -S -O srec $(strip-flags)
+vmlinuz.srec: vmlinuz
+	$(call if_changed,objcopy)
+
+clean:
+clean-files += *.o \
+	       vmlinu*
diff --git a/arch/mips/boot/compressed/dbg.c b/arch/mips/boot/compressed/dbg.c
new file mode 100644
index 0000000..ff4dc7a
--- /dev/null
+++ b/arch/mips/boot/compressed/dbg.c
@@ -0,0 +1,37 @@
+/*
+ * MIPS-specific debug support for pre-boot environment
+ *
+ * NOTE: putc() is board specific, if your board have a 16550 compatible uart,
+ * please select SYS_SUPPORTS_ZBOOT_UART16550 for your machine. othewise, you
+ * need to implement your own putc().
+ */
+
+#include <linux/init.h>
+#include <linux/types.h>
+
+void __attribute__ ((weak)) putc(char c)
+{
+}
+
+void puts(const char *s)
+{
+	char c;
+	while ((c = *s++) != '\0') {
+		putc(c);
+		if (c == '\n')
+			putc('\r');
+	}
+}
+
+void puthex(unsigned long long val)
+{
+
+	unsigned char buf[10];
+	int i;
+	for (i = 7; i >= 0; i--) {
+		buf[i] = "0123456789ABCDEF"[val & 0x0F];
+		val >>= 4;
+	}
+	buf[8] = '\0';
+	puts(buf);
+}
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
new file mode 100644
index 0000000..67330c2
--- /dev/null
+++ b/arch/mips/boot/compressed/decompress.c
@@ -0,0 +1,126 @@
+/*
+ * Misc. bootloader code for many machines.
+ *
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: Matt Porter <mporter@mvista.com> Derived from
+ * arch/ppc/boot/prep/misc.c
+ *
+ * Copyright (C) 2009 Lemote, Inc. & Institute of Computing Technology
+ * Author: Wu Zhangjin <wuzj@lemote.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/kernel.h>
+
+#include <asm/addrspace.h>
+
+/* These two variables specify the free mem region
+ * that can be used for temporary malloc area
+ */
+unsigned long free_mem_ptr;
+unsigned long free_mem_end_ptr;
+char *zimage_start;
+
+/* The linker tells us where the image is. */
+extern unsigned char __image_begin, __image_end;
+extern unsigned char __ramdisk_begin, __ramdisk_end;
+unsigned long initrd_size;
+
+/* debug interfaces  */
+extern void puts(const char *s);
+extern void puthex(unsigned long long val);
+
+void error(char *x)
+{
+	puts("\n\n");
+	puts(x);
+	puts("\n\n -- System halted");
+
+	while (1)
+		;	/* Halt */
+}
+
+/* activate the code for pre-boot environment */
+#define STATIC static
+
+#ifdef CONFIG_KERNEL_GZIP
+void *memcpy(void *dest, const void *src, size_t n)
+{
+	int i;
+	const char *s = src;
+	char *d = dest;
+
+	for (i = 0; i < n; i++)
+		d[i] = s[i];
+	return dest;
+}
+#include "../../../../lib/decompress_inflate.c"
+#endif
+
+#ifdef CONFIG_KERNEL_BZIP2
+void *memset(void *s, int c, size_t n)
+{
+	int i;
+	char *ss = s;
+
+	for (i = 0; i < n; i++)
+		ss[i] = c;
+	return s;
+}
+#include "../../../../lib/decompress_bunzip2.c"
+#endif
+
+#ifdef CONFIG_KERNEL_LZMA
+#include "../../../../lib/decompress_unlzma.c"
+#endif
+
+void decompress_kernel(unsigned long boot_heap_start)
+{
+	int zimage_size;
+
+	/*
+	 * We link ourself to an arbitrary low address.  When we run, we
+	 * relocate outself to that address.  __image_beign points to
+	 * the part of the image where the zImage is. -- Tom
+	 */
+	zimage_start = (char *)(unsigned long)(&__image_begin);
+	zimage_size = (unsigned long)(&__image_end) -
+	    (unsigned long)(&__image_begin);
+
+	/*
+	 * The zImage and initrd will be between start and _end, so they've
+	 * already been moved once.  We're good to go now. -- Tom
+	 */
+	puts("zimage at:     ");
+	puthex((unsigned long)zimage_start);
+	puts(" ");
+	puthex((unsigned long)(zimage_size + zimage_start));
+	puts("\n");
+
+	if (initrd_size) {
+		puts("initrd at:     ");
+		puthex((unsigned long)(&__ramdisk_begin));
+		puts(" ");
+		puthex((unsigned long)(&__ramdisk_end));
+		puts("\n");
+	}
+
+	/* this area are prepared for mallocing when decompressing */
+	free_mem_ptr = boot_heap_start;
+	free_mem_end_ptr = boot_heap_start + BOOT_HEAP_SIZE;
+
+	/* Display standard Linux/MIPS boot prompt for kernel args */
+	puts("Uncompressing Linux at load address ");
+	puthex(VMLINUX_LOAD_ADDRESS_ULL);
+	puts("\n");
+	/* Decompress the kernel with according algorithm */
+	decompress(zimage_start, zimage_size, 0, 0,
+		   (void *)VMLINUX_LOAD_ADDRESS_ULL, 0, error);
+	/* FIXME: is there a need to flush cache here? */
+	puts("Now, booting the kernel...\n");
+}
diff --git a/arch/mips/boot/compressed/dummy.c b/arch/mips/boot/compressed/dummy.c
new file mode 100644
index 0000000..31dbf45
--- /dev/null
+++ b/arch/mips/boot/compressed/dummy.c
@@ -0,0 +1,4 @@
+int main(void)
+{
+	return 0;
+}
diff --git a/arch/mips/boot/compressed/head.S b/arch/mips/boot/compressed/head.S
new file mode 100644
index 0000000..e23f25e
--- /dev/null
+++ b/arch/mips/boot/compressed/head.S
@@ -0,0 +1,55 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 1994, 1995 Waldorf Electronics
+ * Written by Ralf Baechle and Andreas Busse
+ * Copyright (C) 1995 - 1999 Ralf Baechle
+ * Copyright (C) 1996 Paul M. Antoine
+ * Modified for DECStation and hence R3000 support by Paul M. Antoine
+ * Further modifications by David S. Miller and Harald Koerfgen
+ * Copyright (C) 1999 Silicon Graphics, Inc.
+ */
+
+#include <asm/asm.h>
+#include <asm/regdef.h>
+
+	.set noreorder
+	.cprestore
+	LEAF(start)
+start:
+	/* Save boot rom start args */
+	move	s0, a0
+	move	s1, a1
+	move	s2, a2
+	move	s3, a3
+
+	/* Clear BSS */
+	PTR_LA	a0, _edata
+	PTR_LA	a2, _end
+1:	sw	zero, 0(a0)
+	bne	a2, a0, 1b
+	addu	a0, 4
+
+	PTR_LA	a0, (.heap)          /* heap address */
+	PTR_LA  sp, (.stack + 8192)  /* stack address */
+
+	PTR_LA	ra, 2f
+	PTR_LA	k0, decompress_kernel
+	jr	k0
+	nop
+2:
+	move	a0, s0
+	move	a1, s1
+	move	a2, s2
+	move	a3, s3
+	PTR_LI	k0, KERNEL_ENTRY
+	jr	k0
+	nop
+3:
+	b 3b
+	END(start)
+
+	.comm .heap,BOOT_HEAP_SIZE,4
+	.comm .stack,4096*2,4
diff --git a/arch/mips/boot/compressed/ld.script b/arch/mips/boot/compressed/ld.script
new file mode 100644
index 0000000..29e9f4c
--- /dev/null
+++ b/arch/mips/boot/compressed/ld.script
@@ -0,0 +1,150 @@
+OUTPUT_ARCH(mips)
+ENTRY(start)
+SECTIONS
+{
+  /* Read-only sections, merged into text segment: */
+  .init          : { *(.init)		} =0
+  .text      :
+  {
+    _ftext = . ;
+    *(.text)
+    *(.rodata)
+    *(.rodata1)
+    /* .gnu.warning sections are handled specially by elf32.em.  */
+    *(.gnu.warning)
+  } =0
+  .kstrtab : { *(.kstrtab) }
+
+  . = ALIGN(16);		/* Exception table */
+  __start___ex_table = .;
+  __ex_table : { *(__ex_table) }
+  __stop___ex_table = .;
+
+  __start___dbe_table = .;	/* Exception table for data bus errors */
+  __dbe_table : { *(__dbe_table) }
+  __stop___dbe_table = .;
+
+  __start___ksymtab = .;	/* Kernel symbol table */
+  __ksymtab : { *(__ksymtab) }
+  __stop___ksymtab = .;
+
+  _etext = .;
+
+  . = ALIGN(8192);
+  .data.init_task : { *(.data.init_task) }
+
+  /* Startup code */
+  . = ALIGN(4096);
+  __init_begin = .;
+  .text.init : { *(.text.init) }
+  .data.init : { *(.data.init) }
+  . = ALIGN(16);
+  __setup_start = .;
+  .setup.init : { *(.setup.init) }
+  __setup_end = .;
+  __initcall_start = .;
+  .initcall.init : { *(.initcall.init) }
+  __initcall_end = .;
+  . = ALIGN(4096);	/* Align double page for init_task_union */
+  __init_end = .;
+
+  . = ALIGN(4096);
+  .data.page_aligned : { *(.data.idt) }
+
+  . = ALIGN(32);
+  .data.cacheline_aligned : { *(.data.cacheline_aligned) }
+
+  .fini      : { *(.fini)    } =0
+  .reginfo : { *(.reginfo) }
+  /* Adjust the address for the data segment.  We want to adjust up to
+     the same address within the page on the next page up.  It would
+     be more correct to do this:
+       . = .;
+     The current expression does not correctly handle the case of a
+     text segment ending precisely at the end of a page; it causes the
+     data segment to skip a page.  The above expression does not have
+     this problem, but it will currently (2/95) cause BFD to allocate
+     a single segment, combining both text and data, for this case.
+     This will prevent the text segment from being shared among
+     multiple executions of the program; I think that is more
+     important than losing a page of the virtual address space (note
+     that no actual memory is lost; the page which is skipped can not
+     be referenced).  */
+  . = .;
+  .data    :
+  {
+    _fdata = . ;
+    *(.data)
+
+   /* Put the compressed image here, so bss is on the end. */
+   __image_begin = .;
+   *(.image)
+   __image_end = .;
+   /* Align the initial ramdisk image (INITRD) on page boundaries. */
+   . = ALIGN(4096);
+   __ramdisk_begin = .;
+   *(.initrd)
+   __ramdisk_end = .;
+   . = ALIGN(4096);
+
+    CONSTRUCTORS
+  }
+  .data1   : { *(.data1) }
+  _gp = . + 0x8000;
+  .lit8 : { *(.lit8) }
+  .lit4 : { *(.lit4) }
+  .ctors         : { *(.ctors)   }
+  .dtors         : { *(.dtors)   }
+  .got           : { *(.got.plt) *(.got) }
+  .dynamic       : { *(.dynamic) }
+  /* We want the small data sections together, so single-instruction offsets
+     can access them all, and initialized data all before uninitialized, so
+     we can shorten the on-disk segment size.  */
+  .sdata     : { *(.sdata) }
+  . = ALIGN(4);
+  _edata  =  .;
+  PROVIDE (edata = .);
+
+  __bss_start = .;
+  _fbss = .;
+  .sbss      : { *(.sbss) *(.scommon) }
+  .bss       :
+  {
+   *(.dynbss)
+   *(.bss)
+   *(COMMON)
+   .  = ALIGN(4);
+  _end = . ;
+  PROVIDE (end = .);
+  }
+
+  /* Sections to be discarded */
+  /DISCARD/ :
+  {
+        *(.text.exit)
+        *(.data.exit)
+        *(.exitcall.exit)
+  }
+
+  /* This is the MIPS specific mdebug section.  */
+  .mdebug : { *(.mdebug) }
+  /* These are needed for ELF backends which have not yet been
+     converted to the new style linker.  */
+  .stab 0 : { *(.stab) }
+  .stabstr 0 : { *(.stabstr) }
+  /* DWARF debug sections.
+     Symbols in the .debug DWARF section are relative to the beginning of the
+     section so we begin .debug at 0.  It's not clear yet what needs to happen
+     for the others.   */
+  .debug          0 : { *(.debug) }
+  .debug_srcinfo  0 : { *(.debug_srcinfo) }
+  .debug_aranges  0 : { *(.debug_aranges) }
+  .debug_pubnames 0 : { *(.debug_pubnames) }
+  .debug_sfnames  0 : { *(.debug_sfnames) }
+  .line           0 : { *(.line) }
+  /* These must appear regardless of  .  */
+  .gptab.sdata : { *(.gptab.data) *(.gptab.sdata) }
+  .gptab.sbss : { *(.gptab.bss) *(.gptab.sbss) }
+  .comment : { *(.comment) }
+  .note : { *(.note) }
+}
diff --git a/arch/mips/boot/compressed/uart-16550.c b/arch/mips/boot/compressed/uart-16550.c
new file mode 100644
index 0000000..c9caaf4
--- /dev/null
+++ b/arch/mips/boot/compressed/uart-16550.c
@@ -0,0 +1,43 @@
+/*
+ * 16550 compatible uart based serial debug support for zboot
+ */
+
+#include <linux/types.h>
+#include <linux/serial_reg.h>
+#include <linux/init.h>
+
+#include <asm/addrspace.h>
+
+#if defined(CONFIG_MACH_LOONGSON) || defined(CONFIG_MIPS_MALTA)
+#define UART_BASE 0x1fd003f8
+#define PORT(offset) (CKSEG1ADDR(UART_BASE) + (offset))
+#endif
+
+#ifdef CONFIG_AR7
+#include <ar7.h>
+#define PORT(offset) (CKSEG1ADDR(AR7_REGS_UART0) + (4 * offset))
+#endif
+
+#ifndef PORT
+#error please define the serial port address for your own machine
+#endif
+
+static inline unsigned int serial_in(int offset)
+{
+	return *((char *)PORT(offset));
+}
+
+static inline void serial_out(int offset, int value)
+{
+	*((char *)PORT(offset)) = value;
+}
+
+void putc(char c)
+{
+	int timeout = 1024;
+
+	while (((serial_in(UART_LSR) & UART_LSR_THRE) == 0) && (timeout-- > 0))
+		;
+
+	serial_out(UART_TX, c);
+}
-- 
1.6.2.1
