Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Sep 2002 16:16:14 +0200 (CEST)
Received: from buserror-extern.convergence.de ([212.84.236.66]:33284 "EHLO
	hell") by linux-mips.org with ESMTP id <S1122962AbSIPOQN>;
	Mon, 16 Sep 2002 16:16:13 +0200
Received: from js by hell with local (Exim 3.35 #1 (Debian))
	id 17qwfV-0002CF-00
	for <linux-mips@linux-mips.org>; Mon, 16 Sep 2002 16:16:05 +0200
Date: Mon, 16 Sep 2002 16:16:05 +0200
From: Johannes Stezenbach <js@convergence.de>
To: linux-mips@linux-mips.org
Subject: Compressed kernel image
Message-ID: <20020916141605.GA8409@convergence.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="envbJBWh7q8WU6mo"
Content-Disposition: inline
User-Agent: Mutt/1.4i
Return-Path: <js@convergence.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 188
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: js@convergence.de
Precedence: bulk
X-list: linux-mips


--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

for the embedded Linux project I'm working on I needed the
ability to boot a compressed kernel image from ROM, i.e.
uncompress it to RAM and jump to the kernel entry.

So I took some parts from arch/i386/boot/compressed,
and some from linux-mips.sf.net/arch/mips/zboot/ and
hacked up something which works for me.

The appended patch is incomplete as I removed anything
specific to my platform. To use it for a different platform
you would need:

- A head.S which works for your board. Depending on what
  your bootloader does, you probably don't need the
  cache flushing stuff.
- For debug output, you need a putc() implementation; maybe
  the included uart16550.c works for you. If you think you don't
  need to debug anything ;-), you could use a dummy putc().
- Set some configuration variables in the Makefile. I tested
  both booting from ROM and loading the zImage to RAM, then
  uncompressing to some different area in RAM.
  Note: For my platform I allocate a 2MB frame buffer at
  0x80002000 in unified memory, so reuse this space
  for uncompressing the zImage.

I hope the patch is of use to someone. Comments are welcome.


Regards,
Johannes

--envbJBWh7q8WU6mo
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="linux-oss-zimage.patch"

diff -urN linux-oss.orig/arch/mips/Makefile linux-oss/arch/mips/Makefile
--- linux-oss.orig/arch/mips/Makefile	2002-09-09 21:30:11.000000000 +0200
+++ linux-oss/arch/mips/Makefile	2002-09-16 14:55:40.000000000 +0200
@@ -475,6 +475,11 @@
 endif
 
 MAKEBOOT = $(MAKE) -C arch/$(ARCH)/boot
+MAKEZBOOT = $(MAKE) -C arch/$(ARCH)/boot/compressed
+
+BOOT_TARGETS = zImage
+$(BOOT_TARGETS):  vmlinux
+	@$(MAKEZBOOT) $@
 
 vmlinux.ecoff: vmlinux
 	@$(MAKEBOOT) $@
@@ -484,6 +489,7 @@
 	rm -f arch/$(ARCH)/ld.script
 	$(MAKE) -C arch/$(ARCH)/tools clean
 	$(MAKE) -C arch/mips/baget clean
+	$(MAKE) -C arch/$(ARCH)/boot/compressed clean
 
 archmrproper:
 	@$(MAKEBOOT) mrproper
diff -urN linux-oss.orig/arch/mips/boot/compressed/Makefile linux-oss/arch/mips/boot/compressed/Makefile
--- linux-oss.orig/arch/mips/boot/compressed/Makefile	1970-01-01 01:00:00.000000000 +0100
+++ linux-oss/arch/mips/boot/compressed/Makefile	2002-09-16 15:01:13.000000000 +0200
@@ -0,0 +1,74 @@
+#
+# linux/arch/mips/boot/compressed/Makefile
+#
+# create a compressed zImage from the original vmlinux
+#
+
+HEAD = head.o
+SYSTEM = $(TOPDIR)/vmlinux
+
+ZLDFLAGS = -e zstartup -T $(TOPDIR)/arch/mips/ld.script
+
+all: $(TOPDIR)/zImage
+
+##################################################################
+# board configuration
+##################################################################
+
+ifdef CONFIG_FOOBAR // board specific
+
+# ZIMAGE_OFFSET is the load offset of the compression loader
+ifdef BOOT_FROM_ROM
+# zImage in ROM after boot code
+ZIMAGE_OFFSET := 0x9fc20000
+ZBSS          := -Tbss 0x80002000
+else
+# for loading in RAM
+ZIMAGE_OFFSET := 0x81000000
+endif
+
+# *MUST* match LOADADDR from arch/mips/Makefile
+LOADADDR      := 0x80202000
+KERNEL_ENTRY  = $(shell $(OBJDUMP) -f $(SYSTEM) | sed -n -e 's/^start address //p')
+# working space for gunzip:
+FREE_RAM      := 0x80080000
+END_RAM       := 0x80200000
+# putc config
+PUTC_IMPL     := uart16550.o
+uart16550.o: uart16550.c Makefile
+	$(CC) $(CFLAGS) -DBASE=0xb2001000 -DMAX_BAUD=1152000 -DREG_OFFSET=0x10 -c uart16550.c
+endif
+
+##################################################################
+
+OBJECTS = $(HEAD) misc.o $(PUTC_IMPL)
+
+ZLINKFLAGS = -Ttext $(ZIMAGE_OFFSET) $(ZBSS) $(ZLDFLAGS)
+
+.PHONY: zImage
+zImage: $(TOPDIR)/zImage
+
+$(TOPDIR)/zImage: piggy.o $(OBJECTS)
+	$(LD) $(ZLINKFLAGS) -o $(TOPDIR)/zImage $(OBJECTS) piggy.o
+
+head.o: head.S Makefile $(SYSTEM)
+	$(CC) $(AFLAGS) -DKERNEL_ENTRY=$(KERNEL_ENTRY) -c head.S
+
+comma	:= ,
+
+misc.o: misc.c Makefile
+	$(CC) $(CFLAGS) -DLOADADDR=$(LOADADDR) \
+	    -DFREE_RAM=$(FREE_RAM) -DEND_RAM=$(END_RAM) \
+	    -DKBUILD_BASENAME=$(subst $(comma),_,$(subst -,_,$(*F))) -c misc.c
+
+piggy.o:	$(SYSTEM)
+	tmppiggy=_tmp_$$$$piggy; \
+	rm -f $$tmppiggy $$tmppiggy.gz $$tmppiggy.lnk; \
+	$(OBJCOPY) -S -O binary -R .note -R .comment $(SYSTEM) $$tmppiggy; \
+	gzip -f -9 < $$tmppiggy > $$tmppiggy.gz; \
+	echo "SECTIONS { .data : { input_len = .; LONG(input_data_end - input_data) input_data = .; *(.data) input_data_end = .; }}" > $$tmppiggy.lnk; \
+	$(LD) -r -o piggy.o -b binary $$tmppiggy.gz -b elf32-tradbigmips -T $$tmppiggy.lnk; \
+	rm -f $$tmppiggy $$tmppiggy.gz $$tmppiggy.lnk
+
+clean:
+	rm -f $(TOPDIR)/zImage _tmp_* *.o
diff -urN linux-oss.orig/arch/mips/boot/compressed/head.S linux-oss/arch/mips/boot/compressed/head.S
--- linux-oss.orig/arch/mips/boot/compressed/head.S	1970-01-01 01:00:00.000000000 +0100
+++ linux-oss/arch/mips/boot/compressed/head.S	2002-09-16 15:11:48.000000000 +0200
@@ -0,0 +1,100 @@
+/*
+ * arch/mips/boot/compressed/head.S
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
+ * 08/2002 modified for zImage boot from ROM
+ * Johannes Stezenbach <js@convergence.de>
+ */
+
+
+#include <linux/config.h>
+#include <linux/threads.h>
+
+#include <asm/asm.h>
+#include <asm/cacheops.h>
+#include <asm/mipsregs.h>
+#include <asm/offset.h>
+#include <asm/cachectl.h>
+#include <asm/regdef.h>
+
+#define IndexInvalidate_I       0x00
+
+	.set noreorder
+	.cprestore
+	LEAF(zstartup)
+zstartup:
+
+        la      sp, .stack
+	move	s0, a0
+	move	s1, a1
+	move	s2, a2
+	move	s3, a3
+
+	/* Clear BSS */
+	/* Note: when zImage is in ROM, _edata and _bss point to
+	 * ROM space even when using -Tbss on the linker command line;
+	 * maybe ld.script needs to be corrected.
+	 */
+	la	a0, .stack
+	la	a2, _end
+1:	sw	zero, 0(a0)
+	bne	a2, a0, 1b
+	addu	a0, 4
+
+	/* flush the I-Cache */
+	li	k0, 0x80000000  # start address
+	li	k1, 0x80004000  # end address (16KB I-Cache)
+	subu	k1, 128
+
+2:
+	.set mips3
+	cache	IndexInvalidate_I, 0(k0)
+	cache	IndexInvalidate_I, 32(k0)
+	cache	IndexInvalidate_I, 64(k0)
+	cache	IndexInvalidate_I, 96(k0)
+	.set mips0
+
+	bne	k0, k1, 2b
+	addu	k0, k0, 128
+	/* done */
+
+	la	ra, 3f
+	la	k0, decompress_kernel
+	jr	k0
+	nop
+3:
+
+	move	a0, s0
+	move	a1, s1
+	move	a2, s2
+	move	a3, s3
+	li	k0, KERNEL_ENTRY
+	jr	k0
+	nop
+4:
+	b 4b
+	END(zstartup)
+
+	.bss
+	.fill 0x2000
+	EXPORT(.stack)
diff -urN linux-oss.orig/arch/mips/boot/compressed/misc.c linux-oss/arch/mips/boot/compressed/misc.c
--- linux-oss.orig/arch/mips/boot/compressed/misc.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-oss/arch/mips/boot/compressed/misc.c	2002-08-06 19:19:11.000000000 +0200
@@ -0,0 +1,311 @@
+/*
+ * arch/mips/boot/misc.c
+ *
+ * This is a collection of several routines from gzip-1.0.3
+ * adapted for Linux.
+ *
+ * malloc by Hannu Savolainen 1993 and Matthias Urlichs 1994
+ * puts by Nick Holloway 1993, better puts by Martin Mares 1995
+ * High loaded stuff by Hans Lermen & Werner Almesberger, Feb. 1996
+ *
+ * Modified by RidgeRun Inc.
+ *
+ * 08/2002 modified for booting zImage from ROM
+ * Johannes Stezenbach <js@convergence.de>
+ * (All statically initialized data is read only, all data which needs to be
+ * in RAM must not be statically initialized.)
+ */
+
+#define ZDEBUG 1
+
+#include <linux/types.h>
+
+/*
+ * gzip declarations
+ */
+#define OF(args)  args
+#define STATIC static
+#define memzero(s, n)     memset ((s), 0, (n))
+typedef unsigned char uch;
+typedef unsigned short ush;
+typedef unsigned long ulg;
+#define WSIZE 0x8000		/* Window size must be at least 32k, */
+				/* and a power of two */
+static uch *inbuf;		/* input buffer */
+static uch window[WSIZE];	/* Sliding window buffer */
+
+/* gzip flag byte */
+#define ASCII_FLAG   0x01	/* bit 0 set: file probably ASCII text */
+#define CONTINUATION 0x02	/* bit 1 set: continuation of multi-part gzip file */
+#define EXTRA_FIELD  0x04	/* bit 2 set: extra field present */
+#define ORIG_NAME    0x08	/* bit 3 set: original file name present */
+#define COMMENT      0x10	/* bit 4 set: file comment present */
+#define ENCRYPTED    0x20	/* bit 5 set: file is encrypted */
+#define RESERVED     0xC0	/* bit 6,7:   reserved */
+
+
+static unsigned insize;	/* valid bytes in inbuf */
+static unsigned inptr;	/* index of next byte to be processed in inbuf */
+static unsigned outcnt;	/* bytes in output buffer */
+
+void variable_init(void);
+static void puts(const char *);
+extern void putc_init(void);
+extern void putc(unsigned char c);
+static int fill_inbuf(void);
+static void flush_window(void);
+static void error(char *m);
+static void gzip_mark(void **);
+static void gzip_release(void **);
+
+extern char input_data[];
+extern int input_len;
+
+
+void int2hex(unsigned long val)
+{
+        unsigned char buf[10];
+        int i;
+        for (i = 7;  i >= 0;  i--)
+        {
+                buf[i] = "0123456789ABCDEF"[val & 0x0F];
+                val >>= 4;
+        }
+        buf[8] = '\0';
+        puts(buf);
+}
+
+static unsigned long byte_count;
+
+int get_byte(void)
+{
+#if ZDEBUG > 1
+	static int printCnt;
+#endif
+	unsigned char c = (inptr < insize ? inbuf[inptr++] : fill_inbuf());
+	byte_count++;
+
+#if ZDEBUG > 1
+	if (printCnt++ < 32)
+	{
+	  puts("byte count = ");
+	  int2hex(byte_count);
+	  puts(" byte val = ");
+	  int2hex(c);
+	  puts("\n");
+	}
+#endif
+	return c;
+}
+
+/* Diagnostic functions */
+#ifdef DEBUG
+#  define Assert(cond,msg) {if(!(cond)) error(msg);}
+#  define Trace(x) fprintf x
+#  define Tracev(x) {if (verbose) fprintf x ;}
+#  define Tracevv(x) {if (verbose>1) fprintf x ;}
+#  define Tracec(c,x) {if (verbose && (c)) fprintf x ;}
+#  define Tracecv(c,x) {if (verbose>1 && (c)) fprintf x ;}
+#else
+#  define Assert(cond,msg)
+#  define Trace(x)
+#  define Tracev(x)
+#  define Tracevv(x)
+#  define Tracec(c,x)
+#  define Tracecv(c,x)
+#endif
+
+/*
+ * This is set up by the setup-routine at boot-time
+ */
+
+static long bytes_out;
+static uch *output_data;
+static unsigned long output_ptr;
+
+
+static void *malloc(int size);
+static void free(void *where);
+static void error(char *m);
+static void gzip_mark(void **);
+static void gzip_release(void **);
+
+static unsigned long free_mem_ptr;
+static unsigned long free_mem_end_ptr;
+
+#include "../../../../lib/inflate.c"
+
+static void *malloc(int size)
+{
+	void *p;
+
+	if (size < 0)
+		error("Malloc error\n");
+	if (free_mem_ptr <= 0) error("Memory error\n");
+
+	free_mem_ptr = (free_mem_ptr + 3) & ~3;	/* Align */
+
+	p = (void *) free_mem_ptr;
+	free_mem_ptr += size;
+
+	if (free_mem_ptr >= free_mem_end_ptr)
+		error("\nOut of memory\n");
+
+	return p;
+}
+
+static void free(void *where)
+{				/* Don't care */
+}
+
+static void gzip_mark(void **ptr)
+{
+	*ptr = (void *) free_mem_ptr;
+}
+
+static void gzip_release(void **ptr)
+{
+	free_mem_ptr = (long) *ptr;
+}
+
+static void puts(const char *s)
+{
+	while (*s) {
+		if (*s == 10)
+			putc(13);
+		putc(*s++);
+	}
+}
+
+void *memset(void *s, int c, size_t n)
+{
+	int i;
+	char *ss = (char *) s;
+
+	for (i = 0; i < n; i++)
+		ss[i] = c;
+	return s;
+}
+
+void *memcpy(void *__dest, __const void *__src, size_t __n)
+{
+	int i;
+	char *d = (char *) __dest, *s = (char *) __src;
+
+	for (i = 0; i < __n; i++)
+		d[i] = s[i];
+	return __dest;
+}
+
+/* ===========================================================================
+ * Fill the input buffer. This is called only when the buffer is empty
+ * and at least one byte is really needed.
+ */
+static int fill_inbuf(void)
+{
+	if (insize != 0) {
+		error("ran out of input data\n");
+	}
+
+	inbuf = input_data;
+	insize = input_len;
+	inptr = 1;
+	return inbuf[0];
+}
+
+/* ===========================================================================
+ * Write the output window window[0..outcnt-1] and update crc and bytes_out.
+ * (Used for the decompressed data only.)
+ */
+static void flush_window(void)
+{
+	ulg c = crc;		/* temporary variable */
+	unsigned n;
+	uch *in, *out, ch;
+
+	in = window;
+	out = &output_data[output_ptr];
+	for (n = 0; n < outcnt; n++) {
+		ch = *out++ = *in++;
+		c = crc_32_tab[((int) c ^ ch) & 0xff] ^ (c >> 8);
+	}
+	crc = c;
+	bytes_out += (ulg) outcnt;
+	output_ptr += (ulg) outcnt;
+	outcnt = 0;
+}
+
+void check_mem(void)
+{
+	int i;
+
+	puts("\ncplens = ");
+	for (i = 0; i < 10; i++) {
+		int2hex(cplens[i]);
+		puts(" ");
+	}
+	puts("\ncplext = ");
+	for (i = 0; i < 10; i++) {
+		int2hex(cplext[i]);
+		puts(" ");
+	}
+	puts("\nborder = ");
+	for (i = 0; i < 10; i++) {
+		int2hex(border[i]);
+		puts(" ");
+	}
+	puts("\n");
+}
+
+static void error(char *x)
+{
+	check_mem();
+	puts("\n\n");
+	puts(x);
+	puts("byte_count = ");
+	int2hex(byte_count);
+	puts("\n");
+	puts("\n\n -- System halted");
+	while (1);		/* Halt */
+}
+
+void variable_init(void)
+{
+	byte_count = 0;
+	output_data = (char *) LOADADDR;
+	free_mem_ptr = FREE_RAM;
+	free_mem_end_ptr = END_RAM;
+#if ZDEBUG
+	puts("variable_init:\n");
+	int2hex((unsigned long)output_data); puts("\n");
+	int2hex(free_mem_ptr); puts("\n");
+	int2hex(free_mem_end_ptr); puts("\n");
+	int2hex((unsigned long)input_data); puts("\n");
+	int2hex(input_len); puts("\n");
+#endif
+}
+
+int decompress_kernel(void)
+{
+#if ZDEBUG
+	//check_mem();
+	unsigned long *p = (unsigned long *)LOADADDR;
+#endif
+
+	putc_init();
+	variable_init();
+
+	makecrc();
+	puts("Uncompressing Linux... \n");
+	gunzip();		// ...see inflate.c
+	puts("Ok, booting the kernel.\n");
+
+#if ZDEBUG
+	int2hex(p[0]); puts("\n");
+	int2hex(p[1]); puts("\n");
+	int2hex(p[2]); puts("\n");
+	int2hex(p[3]); puts("\n");
+#endif
+
+	return 0;
+}
diff -urN linux-oss.orig/arch/mips/boot/compressed/uart16550.c linux-oss/arch/mips/boot/compressed/uart16550.c
--- linux-oss.orig/arch/mips/boot/compressed/uart16550.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-oss/arch/mips/boot/compressed/uart16550.c	2002-09-16 15:16:38.000000000 +0200
@@ -0,0 +1,141 @@
+/*
+ * 16550 uart routines.
+ * based on something similar to arch/mips/vr4181/osprey/dbg_io.c
+ * Copyright (C) 2001 MontaVista Software Inc.
+ * Author: jsun@mvista.com or jsun@junsun.net
+ */
+#include <linux/config.h>
+#include <asm/io.h>
+
+/* === CONFIG === */
+
+/*
+ * #define BASE			0xb2001000
+ * #define MAX_BAUD		1152000
+ * #define REG_OFFSET		0x10
+ */
+#if (!defined(BASE) || !defined(MAX_BAUD) || !defined(REG_OFFSET))
+#error You must define BASE, MAX_BAUD and REG_OFFSET in the Makefile.
+#endif
+
+#ifndef INIT_SERIAL_PORT
+#define INIT_SERIAL_PORT	1
+#endif
+
+#ifndef DEFAULT_BAUD
+#define DEFAULT_BAUD		UART16550_BAUD_115200
+#endif
+#ifndef DEFAULT_PARITY
+#define DEFAULT_PARITY		UART16550_PARITY_NONE
+#endif
+#ifndef DEFAULT_DATA
+#define DEFAULT_DATA		UART16550_DATA_8BIT
+#endif
+#ifndef DEFAULT_STOP
+#define DEFAULT_STOP		UART16550_STOP_1BIT
+#endif
+
+/* === END OF CONFIG === */
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
+/* register offset */
+#define		OFS_RCV_BUFFER		(0*REG_OFFSET)
+#define		OFS_TRANS_HOLD		(0*REG_OFFSET)
+#define		OFS_SEND_BUFFER		(0*REG_OFFSET)
+#define		OFS_INTR_ENABLE		(1*REG_OFFSET)
+#define		OFS_INTR_ID		(2*REG_OFFSET)
+#define		OFS_DATA_FORMAT		(3*REG_OFFSET)
+#define		OFS_LINE_CONTROL	(3*REG_OFFSET)
+#define		OFS_MODEM_CONTROL	(4*REG_OFFSET)
+#define		OFS_RS232_OUTPUT	(4*REG_OFFSET)
+#define		OFS_LINE_STATUS		(5*REG_OFFSET)
+#define		OFS_MODEM_STATUS	(6*REG_OFFSET)
+#define		OFS_RS232_INPUT		(6*REG_OFFSET)
+#define		OFS_SCRATCH_PAD		(7*REG_OFFSET)
+
+#define		OFS_DIVISOR_LSB		(0*REG_OFFSET)
+#define		OFS_DIVISOR_MSB		(1*REG_OFFSET)
+
+#define		UART16550_READ(y)    (*((volatile uint8*)(BASE + y)))
+#define		UART16550_WRITE(y, z)  ((*((volatile uint8*)(BASE + y))) = z)
+
+static void Uart16550Init(uint32 baud, uint8 data, uint8 parity, uint8 stop)
+{
+	/* disable interrupts */
+	UART16550_WRITE(OFS_LINE_CONTROL, 0x0);
+	UART16550_WRITE(OFS_INTR_ENABLE, 0);
+
+	/* set up baud rate */
+	{
+		uint32 divisor;
+
+		/* set DIAB bit */
+		UART16550_WRITE(OFS_LINE_CONTROL, 0x80);
+
+		/* set divisor */
+		divisor = MAX_BAUD / baud;
+		UART16550_WRITE(OFS_DIVISOR_LSB, divisor & 0xff);
+		UART16550_WRITE(OFS_DIVISOR_MSB, (divisor & 0xff00)>>8);
+
+		/* clear DIAB bit */
+		UART16550_WRITE(OFS_LINE_CONTROL, 0x0);
+	}
+
+	/* set data format */
+	UART16550_WRITE(OFS_DATA_FORMAT, data | parity | stop);
+}
+
+
+void
+putc_init(void)
+{
+#if INIT_SERIAL_PORT
+	Uart16550Init(DEFAULT_BAUD, DEFAULT_DATA, DEFAULT_PARITY, DEFAULT_STOP);
+#endif
+}
+
+void
+putc(unsigned char c)
+{
+	while ((UART16550_READ(OFS_LINE_STATUS) &0x20) == 0);
+	UART16550_WRITE(OFS_SEND_BUFFER, c);
+}
+
+#if 0
+unsigned char
+getc(void)
+{
+	while((UART16550_READ(OFS_LINE_STATUS) & 0x1) == 0);
+	return UART16550_READ(OFS_RCV_BUFFER);
+}
+
+int
+tstc(void)
+{
+	return((UART16550_READ(OFS_LINE_STATUS) & 0x01) != 0);
+}
+#endif

--envbJBWh7q8WU6mo--
