Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 08 Aug 2009 20:55:29 +0200 (CEST)
Received: from wa-out-1112.google.com ([209.85.146.178]:58941 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org
	with ESMTP id S1493306AbZHHSzX (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sat, 8 Aug 2009 20:55:23 +0200
Received: by wa-out-1112.google.com with SMTP id n4so432600wag.0
        for <multiple recipients>; Sat, 08 Aug 2009 11:55:18 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=qoOpqur32pDk/kuiRNI5x5Ij6JSvj9gxgG3aH86FqLk=;
        b=NtLH77jtMt8IVvawL66/4d9nwKCWtn9zJjMHVbgW3Pu4C7uczrteBaItfyAg/liD0j
         V9iXstSSc8HobL7/odqz+29I5a5AxF+MZ6w7bsAWcSIHtawBhxZIeXk67Z35Jttj0NkY
         WrWxe+i1JGTr69stFdKLbRl3vtbObAIUfAVPU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=wqDR0jU1eexcCP7AnW2DQ8et7XA1dJLgJplkESIQZf1YtWKsneGtmbJDqWqGnUMbo0
         Rhsq82/uVIjHauoKlH43QJbyhqu3HBjMlZh2hwGbMCWSmZe5S2OHLmYtiwFBl+O9wss/
         j5KiAI7WoX8xyVOMMhF4TghexEMKvOmovb/r4=
Received: by 10.114.199.1 with SMTP id w1mr451571waf.179.1249757718630;
        Sat, 08 Aug 2009 11:55:18 -0700 (PDT)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPS id m17sm3994244waf.38.2009.08.08.11.55.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sat, 08 Aug 2009 11:55:17 -0700 (PDT)
From:	Wu Zhangjin <wuzhangjin@gmail.com>
To:	linux-mips@linux-mips.org
Cc:	Ralf Baechle <ralf@linux-mips.org>,
	Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [PATCH] MIPS: add support for gzip/bzip2/lzma compressed kernel images
Date:	Sun,  9 Aug 2009 02:55:07 +0800
Message-Id: <1249757707-8876-1-git-send-email-wuzhangjin@gmail.com>
X-Mailer: git-send-email 1.6.2.1
Return-Path: <wuzhangjin@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23868
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips

This patch will help to generate smaller kernel images for linux-MIPS,

$ wc -c vmlinux
7465416 vmlinux
$ wc -c vmlinuz
2059691 vmlinuz

Have tested the 32bit kernel on Qemu/Malta and 64bit kernel on FuLoong
Mini PC. both of them works well.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
---
 arch/mips/Kconfig                      |    3 +
 arch/mips/Makefile                     |    6 +-
 arch/mips/boot/compressed/Makefile     |   52 +++++++++++
 arch/mips/boot/compressed/dbg.c        |   68 ++++++++++++++
 arch/mips/boot/compressed/dbg.h        |    5 +
 arch/mips/boot/compressed/decompress.c |  152 ++++++++++++++++++++++++++++++++
 arch/mips/boot/compressed/dummy.c      |    4 +
 arch/mips/boot/compressed/head.S       |   85 ++++++++++++++++++
 arch/mips/boot/compressed/ld.script    |  152 ++++++++++++++++++++++++++++++++
 9 files changed, 526 insertions(+), 1 deletions(-)
 create mode 100644 arch/mips/boot/compressed/Makefile
 create mode 100644 arch/mips/boot/compressed/dbg.c
 create mode 100644 arch/mips/boot/compressed/dbg.h
 create mode 100644 arch/mips/boot/compressed/decompress.c
 create mode 100644 arch/mips/boot/compressed/dummy.c
 create mode 100644 arch/mips/boot/compressed/head.S
 create mode 100644 arch/mips/boot/compressed/ld.script

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3ca0fe1..fae7029 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -4,6 +4,9 @@ config MIPS
 	select HAVE_IDE
 	select HAVE_OPROFILE
 	select HAVE_ARCH_KGDB
+	select HAVE_KERNEL_GZIP
+	select HAVE_KERNEL_BZIP2
+	select HAVE_KERNEL_LZMA
 	# Horrible source of confusion.  Die, die, die ...
 	select EMBEDDED
 	select RTC_LIB
diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 861da51..57f0146 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -709,7 +709,10 @@ vmlinux.64: vmlinux
 
 makeboot =$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) $(1)
 
-all:	$(all-y)
+all:	$(all-y) vmlinuz
+
+vmlinuz: vmlinux
+	$(Q)$(MAKE) $(build)=arch/mips/boot/compressed $@
 
 vmlinux.bin: $(vmlinux-32)
 	+@$(call makeboot,$@)
@@ -740,6 +743,7 @@ install:
 
 archclean:
 	@$(MAKE) $(clean)=arch/mips/boot
+	@$(MAKE) $(clean)=arch/mips/boot/compressed
 	@$(MAKE) $(clean)=arch/mips/lasat
 
 define archhelp
diff --git a/arch/mips/boot/compressed/Makefile b/arch/mips/boot/compressed/Makefile
new file mode 100644
index 0000000..012bdd8
--- /dev/null
+++ b/arch/mips/boot/compressed/Makefile
@@ -0,0 +1,52 @@
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
+# Copyright (C) 2009 Lemote Inc. & Insititute of Computing Technology
+# Author: Wu Zhangjin <wuzj@lemote.com>
+#
+
+KBUILD_CFLAGS := $(LINUXINCLUDE) $(KBUILD_CFLAGS) -D__KERNEL__ #-DDEBUG
+KBUILD_AFLAGS := $(LINUXINCLUDE) $(KBUILD_AFLAGS) -D__ASSEMBLY__ \
+	-DKERNEL_ENTRY=0x$(shell $(NM) $(objtree)/$(KBUILD_IMAGE) | grep " kernel_entry" | cut -f1 -d \ )
+
+OBJECTS := $(obj)/head.o $(obj)/decompress.o $(obj)/dbg.o
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
+
+$(obj)/piggy.o: $(obj)/vmlinux.$(suffix_y) $(obj)/dummy.o
+	$(Q)$(OBJCOPY) $(OBJCOPYFLAGS) \
+		--add-section=.image=$< \
+		--set-section-flags=.image=contents,alloc,load,readonly,data \
+		$(obj)/dummy.o $@
+
+# The start address of the compressed kernel, 81000000 > KERNEL_START + KERNEL_SIZE
+LDFLAGS_vmlinuz := $(LDFLAGS) -Ttext 0x$(if $(CONFIG_64BIT),ffffffff,)81000000 -T
+$(obj)/vmlinuz: $(src)/ld.script $(OBJECTS) $(obj)/piggy.o
+	$(call if_changed,ld)
+
+OBJCOPYFLAGS_vmlinuz := $(OBJCOPYFLAGS) -R .comment -R .stab -R .stabstr -R .initrd -R .sysmap
+vmlinuz: $(obj)/vmlinuz
+	$(call if_changed,objcopy)
+
+clean:
+clean-files += *.o \
+	       vmlinu* \
+	       $(objtree)/vmlinuz
diff --git a/arch/mips/boot/compressed/dbg.c b/arch/mips/boot/compressed/dbg.c
new file mode 100644
index 0000000..5c3f130
--- /dev/null
+++ b/arch/mips/boot/compressed/dbg.c
@@ -0,0 +1,68 @@
+/*
+ * MIPS-specific debug support for pre-boot environment
+ */
+
+#ifdef DEBUG
+
+#include <linux/types.h>
+#include <linux/serial_reg.h>
+#include <linux/init.h>
+
+#include "dbg.h"
+
+#include <asm/addrspace.h>
+
+#define PORT(offset) (CKSEG1ADDR(UART_BASE) + (offset))
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
+int putc(char c)
+{
+	while ((serial_in(UART_LSR) & UART_LSR_THRE) == 0)
+		;
+
+	serial_out(UART_TX, c);
+
+	return 1;
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
+void puthex(unsigned long val)
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
+
+
+#else
+void puts(const char *s)
+{
+}
+void puthex(unsigned long val)
+{
+}
+#endif
diff --git a/arch/mips/boot/compressed/dbg.h b/arch/mips/boot/compressed/dbg.h
new file mode 100644
index 0000000..b130ad0
--- /dev/null
+++ b/arch/mips/boot/compressed/dbg.h
@@ -0,0 +1,5 @@
+/*
+ * board-specific serial port
+ */
+
+#define UART_BASE 0x1fd003f8
diff --git a/arch/mips/boot/compressed/decompress.c b/arch/mips/boot/compressed/decompress.c
new file mode 100644
index 0000000..2ff8a18
--- /dev/null
+++ b/arch/mips/boot/compressed/decompress.c
@@ -0,0 +1,152 @@
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
+#include <asm/addrspace.h>
+#include <linux/types.h>
+#include <linux/kernel.h>
+
+/* These two variables specify the free mem region
+ * that can be used for temporary malloc area
+ *
+ * Here is toally 15M
+ */
+#define FREE_MEM_START CKSEG0ADDR(0x83000000)
+#define FREE_MEM_END CKSEG0ADDR(0x83f00000)
+
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
+extern void puthex(unsigned long val);
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
+void decompress_kernel(unsigned long load_addr, int num_words,
+		       unsigned long cksum, unsigned long *sp)
+{
+	extern unsigned long start;
+	int zimage_size;
+
+	initrd_size = (unsigned long)(&__ramdisk_end) -
+	    (unsigned long)(&__ramdisk_begin);
+
+	/*
+	 * Reveal where we were loaded at and where we
+	 * were relocated to.
+	 */
+	puts("loaded at:     ");
+	puthex(load_addr);
+	puts(" ");
+	puthex((unsigned long)(load_addr + (4 * num_words)));
+	puts("\n");
+	if ((unsigned long)load_addr != (unsigned long)&start) {
+		puts("relocated to:  ");
+		puthex((unsigned long)&start);
+		puts(" ");
+		puthex((unsigned long)((unsigned long)&start +
+				       (4 * num_words)));
+		puts("\n");
+	}
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
+	/* assume the chunk below 8M is free */
+	free_mem_ptr = FREE_MEM_START;
+	free_mem_end_ptr = FREE_MEM_END;
+
+	/* Display standard Linux/MIPS boot prompt for kernel args */
+	puts("Uncompressing Linux at load address ");
+	puthex(VMLINUX_LOAD_ADDRESS);
+	puts("\n");
+	/* I don't like this hard coded gunzip size (fixme) */
+	decompress(zimage_start, zimage_size, 0, 0,
+		   (void *)VMLINUX_LOAD_ADDRESS, 0, error);
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
index 0000000..6ac4492
--- /dev/null
+++ b/arch/mips/boot/compressed/head.S
@@ -0,0 +1,85 @@
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
+#include <linux/autoconf.h>
+#include <linux/threads.h>
+
+#include <asm/asm.h>
+#include <asm/cacheops.h>
+#include <asm/mipsregs.h>
+#include <asm/asm-offsets.h>
+#include <asm/cachectl.h>
+#include <asm/regdef.h>
+
+	.set noreorder
+	.cprestore
+	LEAF(start)
+start:
+	bal	locate
+	nop
+locate:
+	subu	s8, ra, 8	/* Where we were loaded */
+	PTR_LA	sp, (.stack + 8192)
+
+	move	s0, a0		/* Save boot rom start args */
+	move	s1, a1
+	move	s2, a2
+	move	s3, a3
+
+	PTR_LA	a0, start	/* Where we were linked to run */
+
+	move	a1, s8
+	PTR_LA	a2, _edata
+	subu	t1, a2, a0
+	srl	t1, t1, 2
+
+	/* copy text section */
+	li	t0, 0
+1:	lw	v0, 0(a1)
+	nop
+	sw	v0, 0(a0)
+	xor	t0, t0, v0
+	addu	a0, 4
+	bne	a2, a0, 1b
+	addu	a1, 4
+
+	/* Clear BSS */
+	PTR_LA	a0, _edata
+	PTR_LA	a2, _end
+2:	sw	zero, 0(a0)
+	bne	a2, a0, 2b
+	addu	a0, 4
+
+	move	a0, s8		     /* load address */
+	move	a1, t1               /* length in words */
+	move	a2, t0               /* checksum */
+	move	a3, sp
+
+	PTR_LA	ra, 1f
+	PTR_LA	k0, decompress_kernel
+	jr	k0
+	nop
+1:
+
+	move	a0, s0
+	move	a1, s1
+	move	a2, s2
+	move	a3, s3
+	li	k0, KERNEL_ENTRY
+	jr	k0
+	nop
+3:
+	b 3b
+	END(start)
+
+	.comm .stack,4096*2,4
diff --git a/arch/mips/boot/compressed/ld.script b/arch/mips/boot/compressed/ld.script
new file mode 100644
index 0000000..29eaf41
--- /dev/null
+++ b/arch/mips/boot/compressed/ld.script
@@ -0,0 +1,152 @@
+OUTPUT_ARCH(mips)
+ENTRY(start)
+SECTIONS
+{
+  /* Read-only sections, merged into text segment: */
+  /* . = 0x81000000; */ /* 32bit */
+  /* . = 0xffffffff81000000; */ /* 64bit */
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
-- 
1.6.2.1
