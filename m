Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fBEJMUl06588
	for linux-mips-outgoing; Fri, 14 Dec 2001 11:22:30 -0800
Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fBEJL9o06574
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 11:21:09 -0800
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA07368
	for <linux-mips@oss.sgi.com>; Fri, 14 Dec 2001 10:20:28 -0800 (PST)
	mail_from (ppopov@mvista.com)
Received: from zeus.mvista.com (zeus.mvista.com [10.0.0.112])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id fBEI33B10133;
	Fri, 14 Dec 2001 10:03:05 -0800
Subject: Re: No bzImage target for MIPS
From: Pete Popov <ppopov@mvista.com>
To: Geoffrey Espin <espin@idiom.com>
Cc: Krishna Kondaka <krishna@sanera.net>, linux-mips <linux-mips@oss.sgi.com>
In-Reply-To: <20011213192846.A36207@idiom.com>
References: <200112140047.fBE0l9n02204@icarus.sanera.net>
	<1008292240.27799.134.camel@zeus>  <20011213192846.A36207@idiom.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0 (Preview Release)
Date: 14 Dec 2001 10:05:47 -0800
Message-Id: <1008353149.27799.144.camel@zeus>
Mime-Version: 1.0
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 2001-12-13 at 19:28, Geoffrey Espin wrote:
> 
> > > 	There is no "bzImage" target in the mips linux Makefiles. Could
> > > 	you tell me why this is missing? If I want to generate a 
> > > 	compressed image for linux on MIPS, how do I do it?
> 
> I guess Bill Gates was right, he practically created the Open
> Source movement by "providing" an excellent BIOS.  </sarcasm>
> 
> One of Embedded Linux's unspoken "problems" is lack of truly
> universal boot program.  GRUB is as univeral as x86, not!
> Ppcboot is one of the best, but notice the 'ppc' in the name?
> I gather that PMON is used by many in MIPS... but that is another
> secret you won't find revealed, even in Jun Sun's execellent MIPS
> Porting Guide. :-)

The "original" pmon has outlived its purpose, although it's still found
on many boards. I've become a fan of MIPS Tech's yamon; it's small, it
works, it has just the features I need in an embedded system, and, did I
say it works?.  Unfortunately the code is released under NDA only. If
MIPS opened the code, I think you would see it on many more boards.
 
> COming from a certain proprietary RTOS, I believe, using the OS
> itself, as the "boot monitor" is best approach.  All reusable
> code, fastest bootstrap (i.e. no 2nd stage loading), etc... But,
> of course, not optimal for size, though my image is 1.3M which
> includes a 580K cramfs ramdisk.

That's fine once you've ported the kernel to your board. What do you do
before that point?

> > Download the linux-mips drop-in tree from sourceforge.net. Take a look
> > at arch/mips/zboot.  The only zImage support in that directory is for
> > the Alchemy Pb1000 board.  That's one way to do it and I basically
> 
> I finally did rework this.  I have a single 360 line "<board>/misc.c" file,
> a <board>/Boot.make included by arch/linux/boot/Makefile, and <board>/boot.S.
> There is no cut & pasting of code elsewhere in the linux tree, there are
> no new directories (zboot, compressed, blah-blah).  Its just glue that
> sticks in front of vmlinux.bin.gz.  Where <board> is Korva (AKA Markham),
> for now.  Support for compressed, or not, plus linking a kernel to run
> at low memory or high.  Running at 'high' allows the kernel to load
> another kernel into 'low' memory without burning flash.  All selectable
> from "make menuconfig".
> 
> Keeping up with sf.net is one of my failings... so no patch, sorry.
> Attached are the key files, if anyone thinks this is worth pursuing.

That's OK, I'm sure someone with interest in the Korva can create the
patch.  But I fail to see how having this code in every <board>
directory is better than having a separate boot directory like the ppc
arch.  The ppc-like zImage support I added is a bit different from the
patch below. It assumes that you do have a boot loader and the 'kernel
loader' is basically separate from the kernel image itself. Adding
initrd support that's not statically compiled in the kernel should be
pretty easy and I like that approach better than statically compiled
initrd images.

Pete

> Geoff
> -- 
> Geoffrey Espin espin@idiom.com
> -- 
> 
> =misc.c=========================================================================
> /*
>  * For Korva/Markham MIPS by Geoffrey Espin espin@idiom.com
>  * Based on numerous predecessors including...
>  *
>  * Author: Johnnie Peters <jpeters@mvista.com>
>  * Editor: Tom Rini <trini@mvista.com>
>  * Ported by Pete Popov <ppopov@mvista.com> to
>  * Copyright 2000-2001 MontaVista Software Inc.
>  *
>  * This program is free software; you can redistribute  it and/or modify it
>  * under  the terms of  the GNU General  Public License as published by the
>  * Free Software Foundation;  either version 2 of the  License, or (at your
>  * option) any later version.
>  *
>  * THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR   IMPLIED
>  * WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
>  * MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
>  * NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT,  INDIRECT,
>  * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
>  * NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
>  * USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
>  * ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
>  * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
>  * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
>  *
>  * You should have received a copy of the  GNU General Public License along
>  * with this program; if not, write  to the Free Software Foundation, Inc.,
>  * 675 Mass Ave, Cambridge, MA 02139, USA.
>  */
> 
> #include <linux/config.h>
> 
> #include <stdarg.h>
> #include <asm/page.h>
> 
> #include "../../../fs/jffs2/zlib.c" /**/
> #include "../../../lib/ctype.c"
> #undef __HAVE_ARCH_MEMCPY
> #undef __HAVE_ARCH_MEMSET
> #include "../../../lib/string.c"
> #define CONFIG_REMOTE_DEBUG
> #include "../korva/dbg_io.c"
> 
> extern char _end[];		/* end of bss */
> 
> int printk(const char *fmt, ...);
> void putc(const char c);
> 
> void gunzip(void *, int, unsigned char *, int *);
> 
> /* NEC KORVA/MARKHAM */
> #define	DELAY(n)	{ volatile int x,y; for (x=0;x<100000*(n);x++) y=x; }
> #define	LED(n)		*(volatile unsigned char*)0xb000001c = (n)
> 
> #define	ZIMAGE_OFFSET	0x00010000	/* 64k per Makefile/VMA/vrboot */
> #define	ZIMAGE_SIZE	0x00200000	/* 2M */
> 
> #define	AVAIL_RAM_START	(PAGE_ALIGN((int)_end))	/* scratch area after image */
> #define	AVAIL_RAM_SIZE	0x00100000	/* 1M */
> 
> char *avail_ram;		/* used by zalloc */
> char *end_avail;
> 
> void
> decompress_kernel(void)
> {
> 	char *zimage_start;
> 	int zimage_size;
> 	int i;
> 
> 	for (i = 0; i < 8; i++) {
> 		LED(1 << (7 - i));
> 		DELAY(5);
> 	}
> 
> 	/* fix for dbg_io.c on Korva/Markham */
> 	*((volatile uint8 *) (0xb0000000 + 0)) |= 0x8;	/* GMR = 0x8 UCSEL (uart) */
> 	avail_ram = (char *) AVAIL_RAM_START;	/* used by zalloc */
> 	end_avail = (char *) (AVAIL_RAM_START + AVAIL_RAM_SIZE);
> 
> 	zimage_start = (char *) (FLASHADDR + ZIMAGE_OFFSET);
> 	zimage_size = ZIMAGE_SIZE;
> 
> 	printk("\nUncompressing from %#x to %#x\n", zimage_start, LOADADDR);
> 
> #if	0
> 	printk("zImage [0-4]:  %#x %#x %#x %#x\n",
> 	       ((unsigned long *) zimage_start)[0],
> 	       ((unsigned long *) zimage_start)[1],
> 	       ((unsigned long *) zimage_start)[2],
> 	       ((unsigned long *) zimage_start)[3]);
> #endif
> 
> 	gunzip((void *) LOADADDR, 0x00400000, zimage_start, &zimage_size);
> 
> #if	0
> 	printk("entry  [0-4]:  %#x %#x %#x %#x (at %#x size %d)\n",
> 	       ((unsigned long *) KERNEL_ENTRY)[0],
> 	       ((unsigned long *) KERNEL_ENTRY)[1],
> 	       ((unsigned long *) KERNEL_ENTRY)[2],
> 	       ((unsigned long *) KERNEL_ENTRY)[3], KERNEL_ENTRY, zimage_size);
> #endif
> 
> 	printk("Booting Linux at %#x\n", KERNEL_ENTRY);
> 
> 	for (i = 0; i < 8; i++) {
> 		LED(1 << (i));
> 		DELAY(5);
> 	}
> 
> 	/* XXX returning and letting boot.S jump used to work? */
> 	if (1) {
> 		__asm__ __volatile__("jr\t%0"::"r"(KERNEL_ENTRY));
> 	}
> }
> 
> void
> exit(void)
> {
> 	printk("\nexit\n");
> 	while (1) ;
> }
> 
> void
> putc(const char c)
> {
> #define serial_putc(ch) putDebugChar(ch)
> 
> 	serial_putc(c);
> 	if (c == '\n')
> 		serial_putc('\r');
> }
> 
> void *
> zalloc(void *x, unsigned items, unsigned size)
> {
> 	void *p = avail_ram;
> 
> 	size *= items;
> 	size = (size + 7) & -8;
> 	avail_ram += size;
> 	if (avail_ram > end_avail) {
> 		printk("oops... zalloc(%#x, %d, %#x) out of memory\n",
> 		       (int) x, items, size);
> 		p = NULL;
> 	}
> 	return p;
> }
> 
> void
> zfree(void *x, void *addr)
> {
> }
> 
> void
> gunzip(void *dst, int dstlen, unsigned char *src, int *lenp)
> {
> #define HEAD_CRC	2
> #define EXTRA_FIELD	4
> #define ORIG_NAME	8
> #define COMMENT		0x10
> #define RESERVED	0xe0
> 
> #define DEFLATED	8
> 
> 	z_stream s;
> 	int r, i, flags;
> 
> 	/* skip header */
> 	i = 10;
> 	flags = src[3];
> 	if (src[2] != DEFLATED || (flags & RESERVED) != 0) {
> 		printk("bad gzipped data\n");
> 		exit();
> 	}
> 	if ((flags & EXTRA_FIELD) != 0)
> 		i = 12 + src[10] + (src[11] << 8);
> 	if ((flags & ORIG_NAME) != 0)
> 		while (src[i++] != 0) ;
> 	if ((flags & COMMENT) != 0)
> 		while (src[i++] != 0) ;
> 	if ((flags & HEAD_CRC) != 0)
> 		i += 2;
> 	if (i >= *lenp) {
> 		printk("gunzip: ran out of data in header\n");
> 		exit();
> 	}
> 
> 	s.zalloc = zalloc;
> 	s.zfree = zfree;
> 	r = inflateInit2(&s, -MAX_WBITS);
> 	if (r != Z_OK) {
> 		printk("inflateInit2 returned %#x\n", r);
> 		exit();
> 	}
> 	s.next_in = src + i;
> 	s.avail_in = *lenp - i;
> 	s.next_out = dst;
> 	s.avail_out = dstlen;
> 	r = inflate(&s, Z_FINISH);
> 	if (r != Z_OK && r != Z_STREAM_END) {
> 		printk("inflate returned %#x\n", r);
> 		exit();
> 	}
> 	*lenp = s.next_out - (unsigned char *) dst;
> 	inflateEnd(&s);
> }
> 
> int
> _cvt(unsigned long val, char *buf, long radix, char *digits)
> {
> 	char temp[80];
> 	char *cp = temp;
> 	int length = 0;
> 	if (val == 0) {		/* Special case */
> 		*cp++ = '0';
> 	} else
> 		while (val) {
> 			*cp++ = digits[val % radix];
> 			val /= radix;
> 		}
> 	while (cp != temp) {
> 		*buf++ = *--cp;
> 		length++;
> 	}
> 	*buf = '\0';
> 	return (length);
> }
> 
> #define is_digit(c) ((c >= '0') && (c <= '9'))
> 
> void
> _vprintk(void (*putc) (const char), const char *fmt0, va_list ap)
> {
> 	char c, sign, *cp = 0;
> 	int left_prec, right_prec, zero_fill, length = 0, pad, pad_on_right;
> 	char buf[32];
> 	long val;
> 
> 	while ((c = *fmt0++)) {
> 		if (c == '%') {
> 			c = *fmt0++;
> 			left_prec = right_prec = pad_on_right = 0;
> 			if (c == '#')
> 				c = *fmt0++;	/* ignore alternate fmt */
> 
> 			if (c == '-') {
> 				c = *fmt0++;
> 				pad_on_right++;
> 			}
> 			if (c == '0') {
> 				zero_fill = 1;
> 				c = *fmt0++;
> 			} else {
> 				zero_fill = 0;
> 			}
> 			while (is_digit(c)) {
> 				left_prec = (left_prec * 10) + (c - '0');
> 				c = *fmt0++;
> 			}
> 			if (c == '.') {
> 				c = *fmt0++;
> 				zero_fill++;
> 				while (is_digit(c)) {
> 					right_prec =
> 					    (right_prec * 10) + (c - '0');
> 					c = *fmt0++;
> 				}
> 			} else {
> 				right_prec = left_prec;
> 			}
> 
> 			sign = '\0';
> 			switch (c) {
> 			case 'd':
> 			case 'x':
> 			case 'X':
> 				val = va_arg(ap, long);
> 				switch (c) {
> 				case 'd':
> 					if (val < 0) {
> 						sign = '-';
> 						val = -val;
> 					}
> 					length =
> 					    _cvt(val, buf, 10, "0123456789");
> 					break;
> 				case 'x':
> 					length =
> 					    _cvt(val, buf, 16,
> 						 "0123456789abcdef");
> 					break;
> 				case 'X':
> 					length =
> 					    _cvt(val, buf, 16,
> 						 "0123456789ABCDEF");
> 					break;
> 				}
> 				cp = buf;
> 				break;
> 			case 's':
> 				cp = va_arg(ap, char *);
> 				length = strlen(cp);
> 				break;
> 			case 'c':
> 				c = va_arg(ap, long /*char */ );
> 				(*putc) (c);
> 				continue;
> 			default:
> 				(*putc) ('?');
> 			}
> 			pad = left_prec - length;
> 			if (sign != '\0') {
> 				pad--;
> 			}
> 			if (zero_fill) {
> 				c = '0';
> 				if (sign != '\0') {
> 					(*putc) (sign);
> 					sign = '\0';
> 				}
> 			} else {
> 				c = ' ';
> 			}
> 			if (!pad_on_right) {
> 				while (pad-- > 0) {
> 					(*putc) (c);
> 				}
> 			}
> 			if (sign != '\0') {
> 				(*putc) (sign);
> 			}
> 			while (length-- > 0) {
> 				(*putc) (c = *cp++);
> 				if (c == '\n') {
> 					(*putc) ('\r');
> 				}
> 			}
> 			if (pad_on_right) {
> 				while (pad-- > 0) {
> 					(*putc) (c);
> 				}
> 			}
> 		} else {
> 			(*putc) (c);
> 			if (c == '\n') {
> 				(*putc) ('\r');
> 			}
> 		}
> 	}
> }
> 
> int
> printk(const char *fmt, ...)
> {
> 	va_list args;
> 	va_start(args, fmt);
> 	_vprintk(putc, fmt, args);
> 	va_end(args);
> 	return 0;
> }
> 
> =boot.S=========================================================================
> /*
>  * boot.S
>  *
>  * Modified by Geoffrey Espin <espin@idiom.com> for NEC Electronics
>  *
>  * Copyright (C) 1999 Bradley D. LaRonde
>  * Copyright (C) 2001 Dai Itasaka <Daisaku_Itasaka@el.nec.com>
>  *
>  * This file is subject to the terms and conditions of the GNU General Public
>  * License.  See the file "COPYING" in the main directory of this archive
>  * for more details.
>  */
> 
> #include <linux/config.h>
> 
> #include <asm/asm.h>
> #include <asm/regdef.h>
> #include <asm/addrspace.h>
> #include <asm/mipsregs.h>
> 
> #define	FLASH_BEGIN	(FLASHADDR+0x00010000) // skip first 64k (this program)
> #define	FLASH_END	(FLASHADDR+0x00400000) // 4M; see Boot.make
> 
> 
> /*
> EC:7(CPU clock / 1), EP:0(1word/1cycle), AD:0(VR4000 compatible)
> M16:0(Disable), BE:1(Big endian), CS:1(+10), IC:4(16K), DC:3(8K)
> K0:2(Disable)
> 
> 31  30 28 27 24  23 22 21  19  18  17  16  15 14 13  12 11  9 8  6 5 3 2  0
> +---+-----+-----+---+-----+---+---+---+---+---+-----+---+-----+----+---+----+
> | 0 | EC  |  EP | AD|  0  |M16| 0 | 1 | 0 | BE| 1 0 | CS| IC  | DC | 0 | K0 |
> +---+-----+-----+---+-----+---+---+---+---+---+-----+---+-----+----+---+----+
> EC : Tclock rate,  EP : Transfer data pattern setting,
> AD : Accelerate data mode,  M16 : MIPS16 ISA mode enable
> BE : BigEndian, CS : Cache Size mode Indication(fixed to 1)
> IC : Instruction Cache Size,  DC : Data Cache Size,
> K0 : kseg0 coherency algorithm
> 
> See uPD98501 Preliminary User's Manual, Chapter 2, page 156.
> */
> 
> #define KORVA_CONFIG_INIT_VAL_BE	0x7002d8c2   /*BE*/
> #define KORVA_CONFIG_INIT_VAL	0x700258c2   /*LE*/
> 
> 
> #define DEBUG
> #ifdef DEBUG
> #define DEBUG_LED      0xb000001c
> #define CHECKPOINT(n)  li t4, n; sw t4, DEBUG_LED;
> #else
> #define CHECKPOINT(n)
> #endif
> 
> LEAF(__start)
> 	.set	mips3
> 	.set	noreorder
> 
> 	nop  // patched by script if using Kyoto-Micro ROM Emulator
> 	nop
> 	nop
> 
> 	mtc0	zero, CP0_STATUS	// disable interrupts
> 	mtc0	zero, CP0_CAUSE		// clear interrupts
> 	li	t0, KORVA_CONFIG_INIT_VAL
> 	mtc0	t0, CP0_CONFIG		// make sure the cache is disabled
> 	mtc0	zero, CP0_WATCHLO
> 	mtc0	zero, CP0_WATCHHI	// disable watch exception
> 
> 	CHECKPOINT(0xB1)
> 
> 	/* setup_hardware (was function, now PIC as may be linked at RAM) */
> 
> 	// check if the CPU is running at 66MHz or 100MHz
> 	lui	t0, 0xb000
> 	lw	t1,	4(t0)	// 0xb0000004 = GSR
> 	li	t0,	2	// CCLKSEL
> 	and	t0, t0, t1
> 	beq	zero, t0, clk100
> 	lui	t0, 0xb000
> 
> clk66:
> 	li	t1,	0x120	// SDMDR
> 	sw	t1, 0x108(t0)	// *(0xb0000108) = 0x120;
> 	li	t1,	0x000	// SDPTR
> 	sw	t1, 0x110(t0)	// *(0xb0000110) = 0x000;
> 
> 	beq zero, zero, 1f
> 	nop
> 
> clk100:
> 	li	t1,	0x230	// SDMDR
> 	sw	t1, 0x108(t0)	// *(0xb0000108) = 0x230;
> 	li	t1,	0x021	// SDPTR
> 	sw	t1, 0x110(t0)	// *(0xb0000110) = 0x021;
> 
> 1:
> #if defined(CONFIG_NEC_MARKHAM_32MB)
> 	li	t1, 0x3c2	// SDTSR 32M
> 				// CAB=0x02, RAB=0x40 BTM=0x0080 SIZE=0x300(32M)
> #else
> 	li	t1, 0x1a1	// SDTSR  8M
> 				// CAB=0x01, RAB=0x20 BTM=0x0080 SIZE=0x100(8M)
> #endif
> 	sw	t1, 0x10c(t0)	// *(0xb000010c) = 0x1a1/0x3c2;
> 	
> 				// allow writing to flash parts
> 	li	t1,	0x100	// RMMDR (00 4MB mode) WM=1 unmasked
> 	sw	t1, 0x100(t0)	// *(0xb0000100) = 0x000;
> 
> 	li	t1,	0x003	// RMATR   FAT_8
> 	sw	t1, 0x104(t0)	// *(0xb0000104) = 0x003;
> 
> 	li	t1,	0x000	// IMR
> 	sw	t1, 0x00c(t0)	// disable all INTs
> 
> 	nop
> 	/* end of setup_hardware */
> 
> 	CHECKPOINT(0xB2)
> 
> 	/* invalidate_cache (was function, now PIC as may be linked at RAM) */ 
> 
> 	mtc0	zero, CP0_TAGLO	// invalidate the instruction cache
> 	li	s0, 0x80000000
> 	li	s1, 0x80000000 + (1 << 14) // 16k
> 1:
> 	cache	(2 << 2) | 0, (s0)
> 	add	s0, 0x10
> 	bne	s0, s1, 1b
> 	nop
> 
> 	mtc0	zero, CP0_TAGLO	// invalidate the data cache
> 	li	s0, 0x80000000
> 	li	s1, 0x80000000 + (1 << 13) // 8k
> 1:
> 	cache	(2 << 2) | 1, (s0)
> 	add	s0, 0x10
> 	bne	s0, s1, 1b
> 	nop
> 
> 	nop
> 	/* end of invalidate_cache */
> 
> 	CHECKPOINT(0xB3)
> 
> 	mfc0	t0, CP0_CONFIG	// enable kseg0 caching
> 	ori	t0, 0x1	// cached
> 	mtc0	t0, CP0_CONFIG
> 
> 	CHECKPOINT(0xB4)
> 
> #ifdef	CONFIG_NEC_KORVA_COMPRESSED
> relocate:
> 	la	sp, .stack
> 	move	s0, a0
> 	move	s1, a1
> 	move	s2, a2
> 	move	s3, a3
> 
> 	la	a0, __start
> 
> 	li	a1, FLASHADDR
> 	la	a2, _edata
> 	subu	t1, a2, a0
> 	srl	t1, t1, 2
> 
> 	/* copy text section */
> 	li	t0, 0
> 1:	lw	v0, 0(a1)
> 	nop
> 	sw	v0, 0(a0)
> 	xor	t0, t0, v0
> 	addu	a0, 4
> 	bne	a2, a0, 1b
> 	addu	a1, 4
> 
> 	/* clear BSS */
> 	la	a0, _edata
> 	la	a2, _end
> 2:	sw	zero, 0(a0)
> 	bne	a2, a0, 2b
> 	addu	a0, 4
> 
> 	/* now that code is in RAM we can jump okay */
> 
> 	// decompress kernel to ram
> 	la      ra, 1f
> 	la      t4, decompress_kernel	// elsewhere in 'C'
> 	jr      t4
> #else
> 	/* actually we were linked at ROM so we're okay */
> 
> 	// copy kernel to ram
> 	la      ra, 1f
> 	la      t4, copy_kernel
> 	jr      t4
> #endif
> 	nop
> 1:
> 
> 	CHECKPOINT(0xB5)
> 
> 	// jump to kernel entry point
> 	li	t4, KERNEL_ENTRY
> 	jr	t4
> 	nop
> 
> 	nop
> END(__start)
> 
> 
> LEAF(copy_kernel)
> 	// copy kernel from ROM to RAM
> 
> 	// Load s0 = src, s1 = src_end, s2 = dest.
> 	li	s0, FLASH_BEGIN
> 	li	s1, FLASH_END
> 
> 	li	s2, LOADADDR
> 
> 	sw	zero, (s2)
> 	sw	zero, 4(s2)
> 	sw	zero, 8(s2)
> 	sw	zero, 12(s2)
> 
> 1:
> 	// Only update LED once in a while.
> 	and	t0, s0, 0xffff
> 	bne	t0, zero, 2f
> 
> 	// Show copy progress on LED.
> 	srl	t0, s0, 16
> 	sh	t0, DEBUG_LED
> 
> 2:
> 	// Copy src to dest.
> 	lw	t0, (s0)
> 	bne	t0, zero, 3f
> 	nop
> 	sw	zero, (s2)
> 	beq	zero, zero, 4f
> 	nop
> 3:
> 	sw	t0, (s2)
> 4:
> 	// Increment src and dest.
> 	add	s0, 4
> 	add	s2, 4
> 
> 	// Loop if still more to go.
> 	bne	s0, s1, 1b
> 	nop
> 
> 	jr	ra
> 	 nop
> END(copy_kernel)
> 
> #ifdef	CONFIG_NEC_KORVA_COMPRESSED
> 	.comm .stack,4096*2,4	// used by relocate to call 'C' program
> #endif
> 
> =Boot.make======================================================================
> # Boot.make - used by ../boot/Makefile
> 
> OBJCOPY         = mipsel-linux-objcopy
> OBJCOPY_FLAGS   = -R .stab -R .stabstr -R .comment -R .note -R .reginfo -R .mdebug
> OBJDUMP         = mipsel-linux-objdump
> #OBJDUMP_HFLAGS  = --disassemble-all -b srec -m  mips:4600 -EL
> 
> TOPDIR          = ../../..
> 
> ifeq ($(LINUX_SRC),)
> LINUX_SRC=$(TOPDIR)
> endif
> VMLINUX=$(LINUX_SRC)/vmlinux
> SYSTEM_MAP=$(LINUX_SRC)/System.map
> 
> ifeq ($(USERLAND),)
> USERLAND=$(LINUX_SRC)/../userland
> endif
> 
> FLASHADDR      = 0xbfc00000
> 
> # see arch/mips/Makefile LOADADDR
> # 0x10000  bottom 64k reserved by/for boot.S (FLASH_BEGIN)
> # 0x02000  additional 8k reserved RAM image vector table (see LOADADDR)
> 
> ifdef CONFIG_NEC_MARKHAM_BOOTROM
> NN=10#in hex is 16M
> LOADADDR      += 0x81002000
> ZLOADADDR     += 0x81402000# +4M
> VMA            = 0x7f00e000 # 0x0-0x81000000+0x10000-0x2000
> ZVMA           = 0x7ebfe000 # 0x0-0x81402000
> else
> NN=00
> LOADADDR      += 0x80002000
> ZLOADADDR     += 0x80402000# +4M
> VMA            = 0x8000e000 # 0x0-0x80000000+0x10000-0x2000
> ZVMA           = 0x7fbfe000 # 0x0-0x80402000
> endif
> 
> KERNEL_ENTRY=$(shell awk '/kernel_entry/{print "0x" $$1}' $(LINUX_SRC)/System.map)
> 
> override CFLAGS += -DKERNEL_ENTRY=$(KERNEL_ENTRY) -DNN=$(NN)
> override CFLAGS += -DLOADADDR=$(LOADADDR) -DFLASHADDR=$(FLASHADDR) -DZLOADADDR=$(ZLOADADDR)
> 
> ifdef CONFIG_NEC_KORVA_COMPRESSED
> zbootroms: bin zsrec
> else
> bootroms: bin srec
> endif
> 
> $(TOPDIR)/arch/$(ARCH)/ld.script.$(ZLOADADDR)_z: $(TOPDIR)/arch/$(ARCH)/ld.script.in 
> 	sed -e 's/kernel_entry/__start/' -e 's/@@LOADADDR@@/$(ZLOADADDR)/' <$< >$@
> 
> ZLINKFLAGS += -T $(TOPDIR)/arch/$(ARCH)/ld.script.$(ZLOADADDR)_z
> 
> misc.c: ../korva/misc.c
> 	@rm -f $@
> 	cp $< $@
> 
> boot.S: ../korva/boot.S
> 	@rm -f $@
> 	cp $< $@
> 
> #vrboot$(NN): boot.o 
> vrboot$(NN): boot.o misc.o $(TOPDIR)/arch/$(ARCH)/ld.script.$(ZLOADADDR)_z
> 	@rm -f $@
> ifdef CONFIG_NEC_KORVA_COMPRESSED
> 	$(LD) $(LDFLAGS) -static -EL -N -o $@ $(ZLINKFLAGS) boot.o misc.o
> else
> 	$(LD) $(LDFLAGS) -static -EL -N -o $@ -Ttext $(FLASHADDR) boot.o
> endif
> 	@rm -f $^ ../boot/misc.c ../boot/boot.S 
> 
> vmlinux$(NN): $(VMLINUX)
> 	@rm -f System$(NN).map
> 	cp -p $(SYSTEM_MAP) System$(NN).map
> 	cp -p $< $@
> 
> # move sections to 0, then add bfc00000 for ROMulator
> vrvmlinux$(NN)-0: vmlinux$(NN) vrboot$(NN)
> 	@rm -f $@
> 	$(OBJCOPY) $(OBJCOPY_FLAGS) --change-addresses 0 -O binary \
> 		vrboot$(NN) vrboot$(NN)-0.bin
> 	$(OBJCOPY) $(OBJCOPY_FLAGS) --change-addresses $(VMA) \
> 		vmlinux$(NN) vmlinux$(NN)-0
> 	$(OBJCOPY) $(OBJCOPY_FLAGS) --add-section .vrboot=vrboot$(NN)-0.bin  \
> 		--set-section-flags .vrboot=,alloc,load,readonly,code \
> 		vmlinux$(NN)-0 vrvmlinux$(NN)-0
> 
> vrvmlinux$(NN)-bfc: vrvmlinux$(NN)-0
> 	$(OBJCOPY) $(OBJCOPY_FLAGS) --change-address $(FLASHADDR) \
> 		vrvmlinux$(NN)-0 vrvmlinux$(NN)-bfc
> 
> # xxx-bfc.bin is for 'reload' & 'reburn' used on a running system
> vrvmlinux$(NN)-bfc.bin: vrvmlinux$(NN)-0
> 	$(OBJCOPY) $(OBJCOPY_FLAGS) --change-address $(FLASHADDR) -O binary \
> 		vrvmlinux$(NN)-0 vrvmlinux$(NN)-bfc.bin
> 
> bin: vrvmlinux$(NN)-bfc vrvmlinux$(NN)-bfc.bin
> 
> vrvmlinux$(NN)-0.srec: vrvmlinux$(NN)-0
> 	$(OBJCOPY) $(OBJCOPY_FLAGS) -O srec --srec-forceS3 --gap-fill 0 \
> 		vrvmlinux$(NN)-0 vrvmlinux$(NN)-0.srec
> 	$(OBJCOPY) $(OBJCOPY_FLAGS) --change-address $(FLASHADDR) -O srec \
> 		vrvmlinux$(NN)-0 vrvmlinux$(NN)-bfc.srec
> 
> srec: vrvmlinux$(NN)-0.srec
> 
> # used by 'reburn' script for Korva (8M) which needs small 256K chunks
> split:
> 	@rm -rf split
> 	@mkdir split
> 	cd split && split -b 256k ../vrvmlinux00-bfc.bin vrvm
> 
> # compressed...
> 
> vmlinux$(NN).bin.gz: vmlinux$(NN)
> 	$(OBJCOPY) -S -O binary $< $<.bin
> 	gzip -vf $<.bin
> 
> zvrvmlinux$(NN)-0: vmlinux$(NN).bin.gz vrboot$(NN)
> 	@rm -f $@
> 	$(OBJCOPY) $(OBJCOPY_FLAGS) --change-addresses=$(ZVMA) \
> 		vrboot$(NN) zvrboot$(NN)-0
> 	$(OBJCOPY) $(OBJCOPY_FLAGS) --add-section .vmlinux=vmlinux$(NN).bin.gz \
> 		--change-section-address .vmlinux=0x10000 \
> 		--set-section-flags .vmlinux=,alloc,load,readonly,code \
> 		zvrboot$(NN)-0 zvrvmlinux$(NN)-0
> 
> zvrvmlinux$(NN)-0.srec: zvrvmlinux$(NN)-0
> 	$(OBJCOPY) $(OBJCOPY_FLAGS) -O srec --srec-forceS3 \
> 		zvrvmlinux$(NN)-0 zvrvmlinux$(NN)-0.srec
> 	$(OBJCOPY) $(OBJCOPY_FLAGS) -O srec --srec-forceS3 \
> 		--change-address 0xbfc00000 \
> 		zvrvmlinux$(NN)-0 zvrvmlinux$(NN)-bfc.srec
> 
> zsrec: zvrvmlinux$(NN)-0.srec
> 
> clean::
> 	@rm -f System* vrvmlinux* vmlinux* vrboot* zvrvmlinux*
> ================================================================================
