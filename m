Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Jan 2005 19:54:06 +0000 (GMT)
Received: from mail.chipsandsystems.com ([IPv6:::ffff:64.164.196.27]:57297
	"EHLO mail.chipsag.com") by linux-mips.org with ESMTP
	id <S8224842AbVAOTxy>; Sat, 15 Jan 2005 19:53:54 +0000
Received: from [10.2.2.64] ([63.194.214.47]) by mail.chipsag.com with Microsoft SMTPSVC(6.0.3790.0);
	 Sat, 15 Jan 2005 11:56:10 -0800
Message-ID: <41E974CD.6080407@embeddedalley.com>
Date: Sat, 15 Jan 2005 11:53:49 -0800
From: Pete Popov <ppopov@embeddedalley.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ralf Baechle <ralf@linux-mips.org>
CC: Mudeem Iqbal <mudeem@Quartics.com>,
	"'linux-mips@linux-mips.org'" <linux-mips@linux-mips.org>
Subject: Re: compressed kernel image for mips
References: <1B701004057AF74FAFF851560087B1610646A7@1aurora.enabtech> <20050115194636.GB15595@linux-mips.org>
In-Reply-To: <20050115194636.GB15595@linux-mips.org>
X-Enigmail-Version: 0.86.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------080105010208010002020104"
X-OriginalArrivalTime: 15 Jan 2005 19:56:10.0374 (UTC) FILETIME=[4264FA60:01C4FB3C]
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------080105010208010002020104
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ralf Baechle wrote:
> On Fri, Jan 14, 2005 at 09:47:00AM +0500, Mudeem Iqbal wrote:
> 
> This is work in progress, should hopefully make it into CVS soon.

I've attached the patch and will put it in my directory on 
linux-mips (can't access the server right now). The patch is really 
for the Au1x boards but can easily be updated for other boards as well.

However, I thought we agreed that in order for the patch to get into 
the tree, the common code between mips and ppc and perhaps other 
arches needs to be merged into a common directory/library 
(misc-common.c for example). That requires some coordination, 
testing, etc, and I'm not sure when I'll have the time to do that.

The other solution is to just use u-boot which has its own 
compressed image support :)

Pete

--------------080105010208010002020104
Content-Type: text/plain;
 name="zImage_2_6_10.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="zImage_2_6_10.patch"

diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/au1xxx/head.S linux-2.6-dev/arch/mips/boot/compressed/au1xxx/head.S
--- linux-2.6-orig/arch/mips/boot/compressed/au1xxx/head.S	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/au1xxx/head.S	2005-01-08 02:28:46.000000000 -0800
@@ -0,0 +1,119 @@
+/*
+ * arch/mips/kernel/head.S
+ *
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
+ *
+ * Head.S contains the MIPS exception handler and startup code.
+ *
+ **************************************************************************
+ *  9 Nov, 2000.
+ *  Added Cache Error exception handler and SBDDP EJTAG debug exception.
+ *
+ *  Kevin Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
+ *  Copyright (C) 2000 MIPS Technologies, Inc.  All rights reserved.
+ **************************************************************************
+ */
+#include <linux/config.h>
+#include <linux/threads.h>
+
+#include <asm/asm.h>
+#include <asm/cacheops.h>
+#include <asm/mipsregs.h>
+#include <asm/cachectl.h>
+#include <asm/regdef.h>
+
+#define IndexInvalidate_I       0x00
+#define IndexWriteBack_D        0x01
+
+	.set noreorder
+	.cprestore
+	LEAF(start)
+start:
+	bal	locate
+	nop
+locate:
+	subu	s8, ra, 8	/* Where we were loaded */
+	la	sp, (.stack + 8192)
+
+	move	s0, a0		/* Save boot rom start args */
+	move	s1, a1
+	move	s2, a2
+	move	s3, a3
+
+	la	a0, start	/* Where we were linked to run */
+
+	move	a1, s8
+	la	a2, _edata
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
+	la	a0, _edata
+	la	a2, _end
+2:	sw	zero, 0(a0)
+	bne	a2, a0, 2b
+	addu	a0, 4
+
+	/* push the D-Cache and invalidate I-Cache */
+	li	k0, 0x80000000  # start address
+	li	k1, 0x80004000  # end address (16KB I-Cache)
+	subu	k1, 128
+
+1:
+	.set mips3
+	cache	IndexWriteBack_D, 0(k0)
+	cache	IndexWriteBack_D, 32(k0)
+	cache	IndexWriteBack_D, 64(k0)
+	cache	IndexWriteBack_D, 96(k0)
+	cache	IndexInvalidate_I, 0(k0)
+	cache	IndexInvalidate_I, 32(k0)
+	cache	IndexInvalidate_I, 64(k0)
+	cache	IndexInvalidate_I, 96(k0)
+	.set mips0
+
+	bne	k0, k1, 1b
+	addu	k0, k0, 128
+	/* done */
+
+	move	a0, s8		     /* load address */
+	move	a1, t1               /* length in words */
+	move	a2, t0               /* checksum */
+	move	a3, sp
+
+	la	ra, 1f
+	la	k0, decompress_kernel
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
+	.comm .stack,4096*2,4
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/au1xxx/Makefile linux-2.6-dev/arch/mips/boot/compressed/au1xxx/Makefile
--- linux-2.6-orig/arch/mips/boot/compressed/au1xxx/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/au1xxx/Makefile	2005-01-08 02:28:03.000000000 -0800
@@ -0,0 +1,110 @@
+# arch/mips/boot/compressed/au1xxx/Makefile
+# 
+# Makefile for AMD Alchemy Semiconductor Au1x based boards.
+# All of the boot loader code was derived from the ppc
+# boot code.
+#
+# Copyright 2001,2002 MontaVista Software Inc.
+#
+# Author: Mark A. Greer
+#	  mgreer@mvista.com
+#
+# Copyright 2004 Embedded Alley Solutions, Inc
+# Ported and modified for mips 2.6 support by 
+# Pete Popov <ppopov@embeddedalley.com>
+#
+# This program is free software; you can redistribute  it and/or modify it
+# under  the terms of  the GNU General  Public License as published by the
+# Free Software Foundation;  either version 2 of the  License, or (at your
+# option) any later version.
+
+boot		:= arch/mips/boot
+compressed	:= $(boot)/compressed
+utils		:= $(compressed)/utils
+lib		:= $(compressed)/lib
+images		:= $(compressed)/images
+common		:= $(compressed)/common
+
+#########################################################################
+# START BOARD SPECIFIC VARIABLES
+
+# These two variables control where the zImage is stored
+# in flash and loaded in memory.  It only controls how the srec
+# file is generated, the code is the same.
+RAM_RUN_ADDR = 0x81000000
+
+ifdef CONFIG_MIPS_XXS1500
+FLASH_LOAD_ADDR = 0xBF000000
+else
+FLASH_LOAD_ADDR = 0xBFD00000
+endif
+
+# These two variables specify the free ram region
+# that can be used for temporary malloc area
+AVAIL_RAM_START=0x80500000
+AVAIL_RAM_END=0x80900000
+
+# This one must match the LOADADDR in arch/mips/Makefile!
+LOADADDR=0x80100000
+
+# WARNING WARNING WARNING
+# Note that with a LOADADDR of 0x80100000 and AVAIL_RAM_START of
+# 0x80500000, the max decompressed kernel size can be 4MB. Else we
+# start overwriting ourselve. You can change these vars as needed;
+# it would be much better if we just figured everything out on the fly.
+
+# END BOARD SPECIFIC VARIABLES
+#########################################################################
+
+OBJECTS	:= $(obj)/head.o $(common)/misc-common.o $(common)/misc-simple.o \
+	$(common)/au1k_uart.o
+LIBS := $(lib)/lib.a
+
+ENTRY := $(utils)/entry
+OFFSET := $(utils)/offset
+SIZE := $(utils)/size
+
+LD_ARGS := -T $(compressed)/ld.script -Ttext $(RAM_RUN_ADDR) -Bstatic
+
+ifdef CONFIG_CPU_LITTLE_ENDIAN
+OBJCOPY_ARGS = -O elf32-tradlittlemips
+else
+OBJCOPY_ARGS = -O elf32-tradbigmips
+endif
+
+$(obj)/head.o: $(obj)/head.S $(TOPDIR)/vmlinux
+	$(CC) $(AFLAGS) \
+	-DKERNEL_ENTRY=$(shell sh $(ENTRY) $(NM) $(TOPDIR)/vmlinux ) \
+	-c -o $*.o $<
+
+$(common)/misc-simple.o:
+	$(CC) $(CFLAGS) -DINITRD_OFFSET=0 -DINITRD_SIZE=0 -DZIMAGE_OFFSET=0 \
+		-DAVAIL_RAM_START=$(AVAIL_RAM_START) \
+		-DAVAIL_RAM_END=$(AVAIL_RAM_END) \
+		-DLOADADDR=$(LOADADDR) \
+		-DZIMAGE_SIZE=0 -c -o $@ $*.c
+
+$(obj)/zvmlinux: $(OBJECTS) $(LIBS) $(srctree)/$(compressed)/ld.script $(images)/vmlinux.gz $(common)/dummy.o
+	$(OBJCOPY) \
+		--add-section=.image=$(images)/vmlinux.gz \
+		--set-section-flags=.image=contents,alloc,load,readonly,data \
+		$(common)/dummy.o $(common)/image.o
+	$(LD) $(LD_ARGS) -o $@ $(OBJECTS) $(common)/image.o $(LIBS)
+	$(OBJCOPY) $(OBJCOPY_ARGS) $@ $@ -R __kcrctab -R __ksymtab_strings \
+	-R .comment -R .stab -R .stabstr -R .initrd -R .sysmap
+
+# Here we manipulate the image in order to get it the necessary
+# srecord file we need.
+zImage: $(obj)/zvmlinux
+	mv $(obj)/zvmlinux $(images)/zImage
+	$(OBJCOPY) -O srec $(images)/zImage $(images)/zImage.srec
+	$(OBJCOPY) -O binary $(images)/zImage $(images)/zImage.bin
+
+zImage.flash: zImage
+	( \
+	flash=${FLASH_LOAD_ADDR} ; \
+	ram=${RAM_RUN_ADDR} ; \
+	adjust=$$[ $$flash - $$ram ] ; \
+	$(OBJCOPY) -O srec --adjust-vma `printf '0x%08x' $$adjust` \
+		$(images)/zImage $(images)/zImage.flash.srec ; \
+	)
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/common/au1k_uart.c linux-2.6-dev/arch/mips/boot/compressed/common/au1k_uart.c
--- linux-2.6-orig/arch/mips/boot/compressed/common/au1k_uart.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/common/au1k_uart.c	2004-12-12 22:42:29.000000000 -0800
@@ -0,0 +1,103 @@
+/*
+ * BRIEF MODULE DESCRIPTION
+ *	Simple Au1000 uart routines.
+ *
+ * Copyright 2001 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc.
+ *		ppopov@mvista.com or source@mvista.com
+ *
+ *  This program is free software; you can redistribute	 it and/or modify it
+ *  under  the terms of	 the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the	License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED	  ``AS	IS'' AND   ANY	EXPRESS OR IMPLIED
+ *  WARRANTIES,	  INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO	EVENT  SHALL   THE AUTHOR  BE	 LIABLE FOR ANY	  DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED	  TO, PROCUREMENT OF  SUBSTITUTE GOODS	OR SERVICES; LOSS OF
+ *  USE, DATA,	OR PROFITS; OR	BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN	 CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+#include <linux/config.h>
+#include <asm/io.h>
+#include <asm/mach-au1x00/au1000.h>
+#include "ns16550.h"
+
+typedef         unsigned char uint8;
+typedef         unsigned int  uint32;
+
+#define         UART16550_BAUD_2400             2400
+#define         UART16550_BAUD_4800             4800
+#define         UART16550_BAUD_9600             9600
+#define         UART16550_BAUD_19200            19200
+#define         UART16550_BAUD_38400            38400
+#define         UART16550_BAUD_57600            57600
+#define         UART16550_BAUD_115200           115200
+
+#define         UART16550_PARITY_NONE           0
+#define         UART16550_PARITY_ODD            0x08
+#define         UART16550_PARITY_EVEN           0x18
+#define         UART16550_PARITY_MARK           0x28
+#define         UART16550_PARITY_SPACE          0x38
+
+#define         UART16550_DATA_5BIT             0x0
+#define         UART16550_DATA_6BIT             0x1
+#define         UART16550_DATA_7BIT             0x2
+#define         UART16550_DATA_8BIT             0x3
+
+#define         UART16550_STOP_1BIT             0x0
+#define         UART16550_STOP_2BIT             0x4
+
+/* It would be nice if we had a better way to do this.
+ * It could be a variable defined in one of the board specific files.
+ */
+#undef UART_BASE
+#ifdef CONFIG_COGENT_CSB250
+#define UART_BASE UART3_ADDR
+#else
+#define UART_BASE UART0_ADDR
+#endif
+
+/* memory-mapped read/write of the port */
+#define UART16550_READ(y)    (au_readl(UART_BASE + y) & 0xff)
+#define UART16550_WRITE(y,z) (au_writel(z&0xff, UART_BASE + y))
+
+/*
+ * We use uart 0, which is already initialized by
+ * yamon. 
+ */
+volatile struct NS16550 *
+serial_init(int chan)
+{
+	volatile struct NS16550 *com_port;
+	com_port = (struct NS16550 *) UART_BASE;
+	return (com_port);
+}
+
+void
+serial_putc(volatile struct NS16550 *com_port, unsigned char c)
+{
+	while ((UART16550_READ(UART_LSR)&0x40) == 0);
+	UART16550_WRITE(UART_TX, c);
+}
+
+unsigned char
+serial_getc(volatile struct NS16550 *com_port)
+{
+	while((UART16550_READ(UART_LSR) & 0x1) == 0);
+	return UART16550_READ(UART_RX);
+}
+
+int
+serial_tstc(volatile struct NS16550 *com_port)
+{
+	return((UART16550_READ(UART_LSR) & LSR_DR) != 0);
+}
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/common/dummy.c linux-2.6-dev/arch/mips/boot/compressed/common/dummy.c
--- linux-2.6-orig/arch/mips/boot/compressed/common/dummy.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/common/dummy.c	2004-12-12 22:42:29.000000000 -0800
@@ -0,0 +1,4 @@
+int main(void)
+{
+	return 0;
+}
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/common/Makefile linux-2.6-dev/arch/mips/boot/compressed/common/Makefile
--- linux-2.6-orig/arch/mips/boot/compressed/common/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/common/Makefile	2004-12-12 23:43:43.000000000 -0800
@@ -0,0 +1,14 @@
+#
+# arch/mips/boot/compressed/common/Makefile
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Tom Rini	January 2001
+#
+# Pete Popov, 2004
+#
+
+lib-y		:= misc-common.o no_initrd.o dummy.o
+lib-$(CONFIG_SOC_AU1X00)	+= au1k_uart.o
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/common/misc-common.c linux-2.6-dev/arch/mips/boot/compressed/common/misc-common.c
--- linux-2.6-orig/arch/mips/boot/compressed/common/misc-common.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/common/misc-common.c	2004-12-15 01:00:03.000000000 -0800
@@ -0,0 +1,434 @@
+/*
+ * arch/mips/boot/compressed/common/misc-common.c
+ * 
+ * Misc. bootloader code (almost) all platforms can use
+ *
+ * Author: Johnnie Peters <jpeters@mvista.com>
+ * Editor: Tom Rini <trini@mvista.com>
+ *
+ * Derived from arch/ppc/boot/prep/misc.c
+ *
+ * Ported by Pete Popov <ppopov@mvista.com> to
+ * support mips board(s).  I also got rid of the vga console
+ * code.
+ *
+ * Copyright 2000-2001 MontaVista Software Inc.
+ *
+ * Ported to MIPS 2.6 by Pete Popov, <ppopov@embeddedalley.com>
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ * THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR   IMPLIED
+ * WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ * NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT,  INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ * USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ * ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ * You should have received a copy of the  GNU General Public License along
+ * with this program; if not, write  to the Free Software Foundation, Inc.,
+ * 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <stdarg.h>	/* for va_ bits */
+#include <linux/config.h>
+#include <linux/string.h>
+#include <linux/zlib.h>
+
+extern char *avail_ram;
+extern char *end_avail;
+extern char _end[];
+
+void puts(const char *);
+void putc(const char c);
+void puthex(unsigned long val);
+void _bcopy(char *src, char *dst, int len);
+void gunzip(void *, int, unsigned char *, int *);
+static int _cvt(unsigned long val, char *buf, long radix, char *digits);
+
+void _vprintk(void(*)(const char), const char *, va_list ap);
+
+struct NS16550 *com_port;
+
+int serial_tstc(volatile struct NS16550 *);
+unsigned char serial_getc(volatile struct NS16550 *);
+void serial_putc(volatile struct NS16550 *, unsigned char);
+
+void pause(void)
+{
+	puts("pause\n");
+}
+
+void exit(void)
+{
+	puts("exit\n");
+	while(1); 
+}
+
+int tstc(void)
+{
+	return (serial_tstc(com_port));
+}
+
+int getc(void)
+{
+	while (1) {
+		if (serial_tstc(com_port))
+			return (serial_getc(com_port));
+	}
+}
+
+void 
+putc(const char c)
+{
+	serial_putc(com_port, c);
+	if ( c == '\n' )
+		serial_putc(com_port, '\r');
+}
+
+void puts(const char *s)
+{
+	char c;
+	while ( ( c = *s++ ) != '\0' ) {
+	        serial_putc(com_port, c);
+	        if ( c == '\n' ) serial_putc(com_port, '\r');
+	}
+}
+
+void error(char *x)
+{
+	puts("\n\n");
+	puts(x);
+	puts("\n\n -- System halted");
+
+	while(1);	/* Halt */
+}
+
+static void *zalloc(unsigned size)
+{
+	void *p = avail_ram;
+
+	size = (size + 7) & -8;
+	avail_ram += size;
+	if (avail_ram > end_avail) {
+		puts("oops... out of memory\n");
+		pause();
+	}
+	return p;
+}
+
+
+#define HEAD_CRC	2
+#define EXTRA_FIELD	4
+#define ORIG_NAME	8
+#define COMMENT		0x10
+#define RESERVED	0xe0
+
+#define DEFLATED	8
+
+void gunzip(void *dst, int dstlen, unsigned char *src, int *lenp)
+{
+	z_stream s;
+	int r, i, flags;
+
+	/* skip header */
+	i = 10;
+	flags = src[3];
+	if (src[2] != Z_DEFLATED || (flags & RESERVED) != 0) {
+		puts("bad gzipped data\n");
+		exit();
+	}
+	if ((flags & EXTRA_FIELD) != 0)
+		i = 12 + src[10] + (src[11] << 8);
+	if ((flags & ORIG_NAME) != 0)
+		while (src[i++] != 0)
+			;
+	if ((flags & COMMENT) != 0)
+		while (src[i++] != 0)
+			;
+	if ((flags & HEAD_CRC) != 0)
+		i += 2;
+	if (i >= *lenp) {
+		puts("gunzip: ran out of data in header\n");
+		exit();
+	}
+
+	/* Initialize ourself. */
+	s.workspace = zalloc(zlib_inflate_workspacesize());
+	r = zlib_inflateInit2(&s, -MAX_WBITS);
+	if (r != Z_OK) {
+		puts("zlib_inflateInit2 returned "); puthex(r); puts("\n");
+		exit();
+	}
+	s.next_in = src + i;
+	s.avail_in = *lenp - i;
+	s.next_out = dst;
+	s.avail_out = dstlen;
+	r = zlib_inflate(&s, Z_FINISH);
+	if (r != Z_OK && r != Z_STREAM_END) {
+		puts("inflate returned "); puthex(r); puts("\n");
+		exit();
+	}
+	*lenp = s.next_out - (unsigned char *) dst;
+	zlib_inflateEnd(&s);
+}
+
+void
+puthex(unsigned long val)
+{
+
+	unsigned char buf[10];
+	int i;
+	for (i = 7;  i >= 0;  i--)
+	{
+		buf[i] = "0123456789ABCDEF"[val & 0x0F];
+		val >>= 4;
+	}
+	buf[8] = '\0';
+	puts(buf);
+}
+
+#define FALSE 0
+#define TRUE  1
+
+void
+_printk(char const *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	_vprintk(putc, fmt, ap);
+	va_end(ap);
+	return;
+}
+
+#define is_digit(c) ((c >= '0') && (c <= '9'))
+
+void
+_vprintk(void(*putc)(const char), const char *fmt0, va_list ap)
+{
+	char c, sign, *cp = 0;
+	int left_prec, right_prec, zero_fill, length = 0, pad, pad_on_right;
+	char buf[32];
+	long val;
+	while ((c = *fmt0++))
+	{
+		if (c == '%')
+		{
+			c = *fmt0++;
+			left_prec = right_prec = pad_on_right = 0;
+			if (c == '-')
+			{
+				c = *fmt0++;
+				pad_on_right++;
+			}
+			if (c == '0')
+			{
+				zero_fill = TRUE;
+				c = *fmt0++;
+			} else
+			{
+				zero_fill = FALSE;
+			}
+			while (is_digit(c))
+			{
+				left_prec = (left_prec * 10) + (c - '0');
+				c = *fmt0++;
+			}
+			if (c == '.')
+			{
+				c = *fmt0++;
+				zero_fill++;
+				while (is_digit(c))
+				{
+					right_prec = (right_prec * 10) + (c - '0');
+					c = *fmt0++;
+				}
+			} else
+			{
+				right_prec = left_prec;
+			}
+			sign = '\0';
+			switch (c)
+			{
+			case 'd':
+			case 'x':
+			case 'X':
+				val = va_arg(ap, long);
+				switch (c)
+				{
+				case 'd':
+					if (val < 0)
+					{
+						sign = '-';
+						val = -val;
+					}
+					length = _cvt(val, buf, 10, "0123456789");
+					break;
+				case 'x':
+					length = _cvt(val, buf, 16, "0123456789abcdef");
+					break;
+				case 'X':
+					length = _cvt(val, buf, 16, "0123456789ABCDEF");
+					break;
+				}
+				cp = buf;
+				break;
+			case 's':
+				cp = va_arg(ap, char *);
+				length = strlen(cp);
+				break;
+			case 'c':
+				c = va_arg(ap, long /*char*/);
+				(*putc)(c);
+				continue;
+			default:
+				(*putc)('?');
+			}
+			pad = left_prec - length;
+			if (sign != '\0')
+			{
+				pad--;
+			}
+			if (zero_fill)
+			{
+				c = '0';
+				if (sign != '\0')
+				{
+					(*putc)(sign);
+					sign = '\0';
+				}
+			} else
+			{
+				c = ' ';
+			}
+			if (!pad_on_right)
+			{
+				while (pad-- > 0)
+				{
+					(*putc)(c);
+				}
+			}
+			if (sign != '\0')
+			{
+				(*putc)(sign);
+			}
+			while (length-- > 0)
+			{
+				(*putc)(c = *cp++);
+				if (c == '\n')
+				{
+					(*putc)('\r');
+				}
+			}
+			if (pad_on_right)
+			{
+				while (pad-- > 0)
+				{
+					(*putc)(c);
+				}
+			}
+		} else
+		{
+			(*putc)(c);
+			if (c == '\n')
+			{
+				(*putc)('\r');
+			}
+		}
+	}
+}
+
+int
+_cvt(unsigned long val, char *buf, long radix, char *digits)
+{
+	char temp[80];
+	char *cp = temp;
+	int length = 0;
+	if (val == 0)
+	{ /* Special case */
+		*cp++ = '0';
+	} else
+		while (val)
+		{
+			*cp++ = digits[val % radix];
+			val /= radix;
+		}
+	while (cp != temp)
+	{
+		*buf++ = *--cp;
+		length++;
+	}
+	*buf = '\0';
+	return (length);
+}
+
+void
+_dump_buf_with_offset(unsigned char *p, int s, unsigned char *base)
+{
+	int i, c;
+	if ((unsigned int)s > (unsigned int)p)
+	{
+		s = (unsigned int)s - (unsigned int)p;
+	}
+	while (s > 0)
+	{
+		if (base)
+		{
+			_printk("%06X: ", (int)p - (int)base);
+		} else
+		{
+			_printk("%06X: ", p);
+		}
+		for (i = 0;  i < 16;  i++)
+		{
+			if (i < s)
+			{
+				_printk("%02X", p[i] & 0xFF);
+			} else
+			{
+				_printk("  ");
+			}
+			if ((i % 2) == 1) _printk(" ");
+			if ((i % 8) == 7) _printk(" ");
+		}
+		_printk(" |");
+		for (i = 0;  i < 16;  i++)
+		{
+			if (i < s)
+			{
+				c = p[i] & 0xFF;
+				if ((c < 0x20) || (c >= 0x7F)) c = '.';
+			} else
+			{
+				c = ' ';
+			}
+			_printk("%c", c);
+		}
+		_printk("|\n");
+		s -= 16;
+		p += 16;
+	}
+}
+
+void
+_dump_buf(unsigned char *p, int s)
+{
+	_printk("\n");
+	_dump_buf_with_offset(p, s, 0);
+}
+
+/*
+ * Local variables:
+ *  c-indent-level: 8
+ *  c-basic-offset: 8
+ *  tab-width: 8
+ * End:
+ */
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/common/misc-simple.c linux-2.6-dev/arch/mips/boot/compressed/common/misc-simple.c
--- linux-2.6-orig/arch/mips/boot/compressed/common/misc-simple.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/common/misc-simple.c	2004-12-13 00:00:42.000000000 -0800
@@ -0,0 +1,122 @@
+/*
+ * arch/mips/zboot/common/misc-simple.c
+ *
+ * Misc. bootloader code for many machines.  This assumes you have are using
+ * a 6xx/7xx/74xx CPU in your machine.  This assumes the chunk of memory
+ * below 8MB is free.  Finally, it assumes you have a NS16550-style uart for 
+ * your serial console.  If a machine meets these requirements, it can quite
+ * likely use this code during boot.
+ * 
+ * Author: Matt Porter <mporter@mvista.com>
+ * Derived from arch/ppc/boot/prep/misc.c
+ *
+ * Copyright 2001 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#include <linux/types.h>
+#include <linux/elf.h>
+#include <linux/config.h>
+
+#include <asm/page.h>
+
+#include "zlib.h"
+
+extern struct NS16550 *com_port;
+
+char *avail_ram;
+char *end_avail;
+extern char _end[];
+char *zimage_start;
+
+#ifdef CONFIG_CMDLINE
+#define CMDLINE CONFIG_CMDLINE
+#else
+#define CMDLINE ""
+#endif
+char cmd_preset[] = CMDLINE;
+char cmd_buf[256];
+char *cmd_line = cmd_buf;
+
+/* The linker tells us where the image is.
+*/
+extern unsigned char __image_begin, __image_end;
+extern unsigned char __ramdisk_begin, __ramdisk_end;
+unsigned long initrd_size;
+
+extern void puts(const char *);
+extern void putc(const char c);
+extern void puthex(unsigned long val);
+extern void *memcpy(void * __dest, __const void * __src,
+			    __kernel_size_t __n);
+extern void gunzip(void *, int, unsigned char *, int *);
+extern void udelay(long delay);
+extern int tstc(void);
+extern int getc(void);
+extern volatile struct NS16550 *serial_init(int chan);
+
+void
+decompress_kernel(unsigned long load_addr, int num_words, 
+		unsigned long cksum, unsigned long *sp)
+{
+	extern unsigned long start;
+	int	zimage_size;
+
+	com_port = (struct NS16550 *)serial_init(0);
+
+	initrd_size = (unsigned long)(&__ramdisk_end) -
+		(unsigned long)(&__ramdisk_begin);
+
+	/*
+	 * Reveal where we were loaded at and where we
+	 * were relocated to.
+	 */
+	puts("loaded at:     "); puthex(load_addr);
+	puts(" "); puthex((unsigned long)(load_addr + (4*num_words))); puts("\n");
+	if ( (unsigned long)load_addr != (unsigned long)&start )
+	{
+		puts("relocated to:  "); puthex((unsigned long)&start);
+		puts(" ");
+		puthex((unsigned long)((unsigned long)&start + (4*num_words)));
+		puts("\n");
+	}
+
+	/*
+	 * We link ourself to an arbitrary low address.  When we run, we
+	 * relocate outself to that address.  __image_being points to
+	 * the part of the image where the zImage is. -- Tom
+	 */
+	zimage_start = (char *)(unsigned long)(&__image_begin);
+	zimage_size = (unsigned long)(&__image_end) -
+			(unsigned long)(&__image_begin);
+
+	/*
+	 * The zImage and initrd will be between start and _end, so they've
+	 * already been moved once.  We're good to go now. -- Tom
+	 */
+	puts("zimage at:     "); puthex((unsigned long)zimage_start);
+	puts(" "); puthex((unsigned long)(zimage_size+zimage_start));
+	puts("\n");
+
+	if ( initrd_size ) {
+		puts("initrd at:     ");
+		puthex((unsigned long)(&__ramdisk_begin));
+		puts(" "); puthex((unsigned long)(&__ramdisk_end));puts("\n");
+	}
+
+	/* assume the chunk below 8M is free */
+	avail_ram = (char *)AVAIL_RAM_START;
+	end_avail = (char *)AVAIL_RAM_END;
+
+	/* Display standard Linux/MIPS boot prompt for kernel args */
+	puts("Uncompressing Linux at load address ");
+	puthex(LOADADDR);
+	puts("\n");
+	/* I don't like this hard coded gunzip size (fixme) */
+	gunzip((void *)LOADADDR, 0x400000, zimage_start, &zimage_size);
+	puts("Now booting the kernel\n");
+}
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/common/no_initrd.c linux-2.6-dev/arch/mips/boot/compressed/common/no_initrd.c
--- linux-2.6-orig/arch/mips/boot/compressed/common/no_initrd.c	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/common/no_initrd.c	2004-12-12 22:42:29.000000000 -0800
@@ -0,0 +1,2 @@
+char initrd_data[1];
+int initrd_len = 0;
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/images/Makefile linux-2.6-dev/arch/mips/boot/compressed/images/Makefile
--- linux-2.6-orig/arch/mips/boot/compressed/images/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/images/Makefile	2004-12-12 22:42:29.000000000 -0800
@@ -0,0 +1,17 @@
+
+#
+# This dir holds all of the images for MIPS machines.
+# Tom Rini	January 2001
+# Pete Popov	2004
+
+extra-y		:= vmlinux.bin vmlinux.gz
+
+OBJCOPYFLAGS_vmlinux.bin := -O binary
+$(obj)/vmlinux.bin: vmlinux FORCE
+	$(call if_changed,objcopy)
+
+$(obj)/vmlinux.gz: $(obj)/vmlinux.bin FORCE
+	$(call if_changed,gzip)
+
+# Files generated that shall be removed upon make clean
+clean-files	:= vmlinux* zImage* 
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/include/nonstdio.h linux-2.6-dev/arch/mips/boot/compressed/include/nonstdio.h
--- linux-2.6-orig/arch/mips/boot/compressed/include/nonstdio.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/include/nonstdio.h	2004-12-12 22:42:29.000000000 -0800
@@ -0,0 +1,18 @@
+/*
+ * Copyright (C) Paul Mackerras 1997.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+typedef int	FILE;
+extern FILE *stdin, *stdout;
+#define NULL	((void *)0)
+#define EOF	(-1)
+#define fopen(n, m)	NULL
+#define fflush(f)	0
+#define fclose(f)	0
+extern char *fgets();
+
+#define perror(s)	printf("%s: no files!\n", (s))
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/include/ns16550.h linux-2.6-dev/arch/mips/boot/compressed/include/ns16550.h
--- linux-2.6-orig/arch/mips/boot/compressed/include/ns16550.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/include/ns16550.h	2004-12-12 22:42:29.000000000 -0800
@@ -0,0 +1,46 @@
+/*
+ * NS16550 Serial Port
+ */
+
+/*
+ * Figure out which file will have the definitons of COMx
+ */
+
+/* Some machines have their uart registers 16 bytes apart.  Most don't.
+ * TODO: Make this work like drivers/char/serial does - Tom */
+#if !defined(UART_REG_PAD)
+#define UART_REG_PAD(x)
+#endif
+
+struct NS16550
+ {
+  unsigned char rbr;  /* 0 */
+  UART_REG_PAD(rbr)
+  unsigned char ier;  /* 1 */
+  UART_REG_PAD(ier)
+  unsigned char fcr;  /* 2 */
+  UART_REG_PAD(fcr)
+  unsigned char lcr;  /* 3 */
+  UART_REG_PAD(lcr)
+  unsigned char mcr;  /* 4 */
+  UART_REG_PAD(mcr)
+  unsigned char lsr;  /* 5 */
+  UART_REG_PAD(lsr)
+  unsigned char msr;  /* 6 */
+  UART_REG_PAD(msr)
+  unsigned char scr;  /* 7 */
+ };
+
+#define thr rbr
+#define iir fcr
+#define dll rbr
+#define dlm ier
+
+#define LSR_DR   0x01  /* Data ready */
+#define LSR_OE   0x02  /* Overrun */
+#define LSR_PE   0x04  /* Parity error */
+#define LSR_FE   0x08  /* Framing error */
+#define LSR_BI   0x10  /* Break */
+#define LSR_THRE 0x20  /* Xmit holding register empty */
+#define LSR_TEMT 0x40  /* Xmitter empty */
+#define LSR_ERR  0x80  /* Error */
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/include/pb1000_serial.h linux-2.6-dev/arch/mips/boot/compressed/include/pb1000_serial.h
--- linux-2.6-orig/arch/mips/boot/compressed/include/pb1000_serial.h	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/include/pb1000_serial.h	2004-12-12 22:42:29.000000000 -0800
@@ -0,0 +1,20 @@
+/*
+ * arch/ppc/boot/include/sandpoint_serial.h
+ * 
+ * Location of the COM ports on Motorola SPS Sandpoint machines
+ *
+ * Author: Mark A. Greer
+ * 	   mgreer@mvista.com
+ *
+ * Copyright 2001 MontaVista Software Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ */
+
+#define COM1 0xfe0003f8
+#define COM2 0xfe0002f8
+#define COM3 0x00000000		/* No COM3 */
+#define COM4 0x00000000		/* No COM4 */
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/ld.script linux-2.6-dev/arch/mips/boot/compressed/ld.script
--- linux-2.6-orig/arch/mips/boot/compressed/ld.script	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/ld.script	2005-01-08 02:28:03.000000000 -0800
@@ -0,0 +1,151 @@
+OUTPUT_ARCH(mips)
+ENTRY(start)
+SECTIONS
+{
+  /* Read-only sections, merged into text segment: */
+  /* . = 0x81000000; */
+  .init          : { *(.init)		} =0
+  .text      :
+  {
+    _ftext = . ;
+    *(.text)
+    *(.rodata) *(.rodata.*)
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
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/lib/Makefile linux-2.6-dev/arch/mips/boot/compressed/lib/Makefile
--- linux-2.6-orig/arch/mips/boot/compressed/lib/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/lib/Makefile	2004-12-15 00:14:31.000000000 -0800
@@ -0,0 +1,11 @@
+
+#
+# Makefile for some libs needed by zImage.
+#
+
+lib-y := $(addprefix ../../../../../lib/zlib_inflate/, \
+	infblock.o infcodes.o inffast.o inflate.o inftrees.o infutil.o) \
+	$(addprefix ../../../../../lib/, ctype.o string.o) \
+	$(addprefix ../../../../../arch/mips/lib/, memcpy.o) \
+
+
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/Makefile linux-2.6-dev/arch/mips/boot/compressed/Makefile
--- linux-2.6-orig/arch/mips/boot/compressed/Makefile	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/Makefile	2004-12-12 22:42:29.000000000 -0800
@@ -0,0 +1,32 @@
+
+#
+# arch/mips/boot/compressed/Makefile
+#
+# This file is subject to the terms and conditions of the GNU General Public
+# License.  See the file "COPYING" in the main directory of this archive
+# for more details.
+#
+# Copyright (C) 1994 by Linus Torvalds
+# Adapted for PowerPC by Gary Thomas
+# modified by Cort (cort@cs.nmt.edu)
+#
+# Ported to MIPS by Pete Popov, ppopov@embeddedalley.com
+#
+
+boot		:= arch/mips/boot
+compressed	:= arch/mips/boot/compressed
+
+CFLAGS	 	+= -fno-builtin -D__BOOTER__ -I$(compressed)/include
+
+BOOT_TARGETS	= zImage 
+
+bootdir-$(CONFIG_SOC_AU1X00)	:= au1xxx
+subdir-y			:= common lib images
+
+.PHONY: $(BOOT_TARGETS) $(bootdir-y)
+
+$(BOOT_TARGETS): $(bootdir-y)
+
+$(bootdir-y): $(addprefix $(obj)/,$(subdir-y)) \
+		$(addprefix $(obj)/,$(hostprogs-y))
+	$(Q)$(MAKE) $(build)=$(obj)/$@ $(MAKECMDGOALS)
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/utils/entry linux-2.6-dev/arch/mips/boot/compressed/utils/entry
--- linux-2.6-orig/arch/mips/boot/compressed/utils/entry	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/utils/entry	2004-12-12 22:42:29.000000000 -0800
@@ -0,0 +1,12 @@
+#!/bin/sh
+
+# grab the kernel_entry address from the vmlinux elf image
+entry=`$1 $2  | grep kernel_entry`
+
+fs=`echo $entry | grep ffffffff`  # check toolchain output
+
+if [ -n "$fs" ]; then
+	echo "0x"`$1 $2  | grep kernel_entry | cut -c9- | awk '{print $1}'`
+else
+	echo "0x"`$1 $2  | grep kernel_entry | cut -c1- | awk '{print $1}'`
+fi
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/utils/offset linux-2.6-dev/arch/mips/boot/compressed/utils/offset
--- linux-2.6-orig/arch/mips/boot/compressed/utils/offset	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/utils/offset	2004-12-12 22:42:29.000000000 -0800
@@ -0,0 +1,3 @@
+#!/bin/sh
+
+echo "0x"`$1 -h $2  | grep $3 | grep -v zvmlinux| awk '{print $6}'`
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/compressed/utils/size linux-2.6-dev/arch/mips/boot/compressed/utils/size
--- linux-2.6-orig/arch/mips/boot/compressed/utils/size	1969-12-31 16:00:00.000000000 -0800
+++ linux-2.6-dev/arch/mips/boot/compressed/utils/size	2004-12-12 22:42:29.000000000 -0800
@@ -0,0 +1,4 @@
+#!/bin/sh
+
+OFFSET=`$1 -h $2  | grep $3 | grep -v zvmlinux | awk '{print $3}'`
+echo "0x"$OFFSET
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/boot/Makefile linux-2.6-dev/arch/mips/boot/Makefile
--- linux-2.6-orig/arch/mips/boot/Makefile	2004-10-23 19:11:43.000000000 -0700
+++ linux-2.6-dev/arch/mips/boot/Makefile	2004-12-12 22:42:29.000000000 -0800
@@ -16,6 +16,7 @@
   E2EFLAGS =
 endif
 
+
 #
 # Drop some uninteresting sections in the kernel.
 # This is only relevant for ELF kernels but doesn't hurt a.out
@@ -25,7 +26,10 @@
 
 VMLINUX = vmlinux
 
-all: vmlinux.ecoff vmlinux.srec addinitrd
+ZBOOT_TARGETS	= zImage
+bootdir-y	:= compressed
+
+all: vmlinux.ecoff vmlinux.srec addinitrd zImage
 
 vmlinux.ecoff: $(obj)/elf2ecoff $(VMLINUX)
 	$(obj)/elf2ecoff $(VMLINUX) vmlinux.ecoff $(E2EFLAGS)
@@ -47,3 +51,11 @@
 	       elf2ecoff \
 	       vmlinux.ecoff \
 	       vmlinux.srec
+ 
+.PHONY: $(ZBOOT_TARGETS) $(bootdir-y)
+ 
+$(ZBOOT_TARGETS): $(bootdir-y)
+
+$(bootdir-y): $(addprefix $(obj)/,$(subdir-y)) \
+		$(addprefix $(obj)/,$(hostprogs-y))
+	$(Q)$(MAKE) $(build)=$(obj)/$@ $(MAKECMDGOALS)
diff -Naur --exclude=CVS linux-2.6-orig/arch/mips/Makefile linux-2.6-dev/arch/mips/Makefile
--- linux-2.6-orig/arch/mips/Makefile	2005-01-08 01:45:09.000000000 -0800
+++ linux-2.6-dev/arch/mips/Makefile	2004-12-29 00:11:45.000000000 -0800
@@ -721,6 +721,9 @@
 vmlinux.srec: $(vmlinux-32)
 	+@$(call makeboot,$@)
 
+zImage: vmlinux
+	+@$(call makeboot,$@)
+
 CLEAN_FILES += vmlinux.ecoff \
 	       vmlinux.srec \
 	       vmlinux.rm200.tmp \
@@ -729,6 +732,7 @@
 archclean:
 	@$(MAKE) $(clean)=arch/mips/boot
 	@$(MAKE) $(clean)=arch/mips/lasat
+	@$(MAKE) $(clean)=arch/mips/boot/compressed
 
 # Generate <asm/offset.h 
 #

--------------080105010208010002020104--
