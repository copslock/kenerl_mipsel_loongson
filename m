Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id g17GS9C26320
	for linux-mips-outgoing; Thu, 7 Feb 2002 08:28:09 -0800
Received: from mail.sonytel.be (mail.sonytel.be [193.74.243.200])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id g17GRuA26315;
	Thu, 7 Feb 2002 08:27:57 -0800
Received: from vervain.sonytel.be (mail.sonytel.be [10.17.0.26])
	by mail.sonytel.be (8.9.0/8.8.6) with ESMTP id RAA20472;
	Thu, 7 Feb 2002 17:27:16 +0100 (MET)
Date: Thu, 7 Feb 2002 17:27:16 +0100 (MET)
From: Geert Uytterhoeven <geert@linux-m68k.org>
To: "Steven J. Hill" <sjhill@cotw.com>
cc: Ralf Baechle <ralf@oss.sgi.com>,
   Linux/MIPS Development <linux-mips@oss.sgi.com>
Subject: Re: [PATCH] Eliminate more compiler warnings...
In-Reply-To: <3C62A3D5.C9F7808E@cotw.com>
Message-ID: <Pine.GSO.4.21.0202071720330.14611-100000@vervain.sonytel.be>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Thu, 7 Feb 2002, Steven J. Hill wrote:
> Please apply this too. Thanks.

diff -urN -X cvs-exc.txt mipslinux-2.4.17-xfs/drivers/ide/ide-probe.c settop/drivers/ide/ide-probe.c
--- mipslinux-2.4.17-xfs/drivers/ide/ide-probe.c	Sun Dec  2 06:08:03 2001
+++ settop/drivers/ide/ide-probe.c	Tue Jan 29 14:06:39 2002
@@ -720,9 +720,9 @@
 
 #if !defined(__mc68000__) && !defined(CONFIG_APUS) && !defined(__sparc__)
 	printk("%s at 0x%03x-0x%03x,0x%03x on irq %d", hwif->name,
-		hwif->io_ports[IDE_DATA_OFFSET],
-		hwif->io_ports[IDE_DATA_OFFSET]+7,
-		hwif->io_ports[IDE_CONTROL_OFFSET], hwif->irq);
+		(unsigned int) hwif->io_ports[IDE_DATA_OFFSET],
+		(unsigned int) hwif->io_ports[IDE_DATA_OFFSET]+7,
+		(unsigned int) hwif->io_ports[IDE_CONTROL_OFFSET], hwif->irq);
 #elif defined(__sparc__)
 	printk("%s at 0x%03lx-0x%03lx,0x%03lx on irq %s", hwif->name,
 		hwif->io_ports[IDE_DATA_OFFSET],

Wouldn't it be better to treat MIPS the same as SPARC here, so you don't need
the casts? Both MIPS and SPARC define ide_ioreg_t to be unsigned long.

And perhaps the #if mess (__sparc__ is checked twice) can be cleant up a bit as
well.

BTW, find include/asm-* -type f | xargs grep 'typedef.*ide_ioreg_t' shows that
very few platforms define ide_ioreg_t to be unsigned short...

| include/asm-alpha/hdreg.h:typedef unsigned short ide_ioreg_t;
| include/asm-arm/hdreg.h:typedef unsigned long ide_ioreg_t;
| include/asm-cris/hdreg.h:typedef unsigned long ide_ioreg_t;
| include/asm-i386/hdreg.h:typedef unsigned short ide_ioreg_t;
| include/asm-ia64/hdreg.h:typedef unsigned short ide_ioreg_t;
| include/asm-m68k/hdreg.h:typedef unsigned int   q40ide_ioreg_t;
| include/asm-m68k/hdreg.h:typedef unsigned char * ide_ioreg_t;
| include/asm-mips/hdreg.h:typedef unsigned long ide_ioreg_t;
| include/asm-mips64/hdreg.h:typedef unsigned long ide_ioreg_t;
| include/asm-parisc/hdreg.h:typedef unsigned short ide_ioreg_t;
| include/asm-ppc/hdreg.h:typedef unsigned int ide_ioreg_t;
| include/asm-s390/hdreg.h:typedef unsigned long ide_ioreg_t;
| include/asm-s390x/hdreg.h:typedef unsigned long ide_ioreg_t;
| include/asm-sh/hdreg.h:typedef unsigned int ide_ioreg_t;
| include/asm-sparc/hdreg.h:typedef unsigned long ide_ioreg_t;
| include/asm-sparc64/hdreg.h:typedef unsigned long ide_ioreg_t;

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
