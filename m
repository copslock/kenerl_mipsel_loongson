Received:  by oss.sgi.com id <S305185AbQDWV5C>;
	Sun, 23 Apr 2000 14:57:02 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:21353 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S305161AbQDWV4r>; Sun, 23 Apr 2000 14:56:47 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA09128; Sun, 23 Apr 2000 15:00:52 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id OAA64497; Sun, 23 Apr 2000 14:56:16 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA45139
	for linux-list;
	Sun, 23 Apr 2000 14:40:42 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA32564
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 23 Apr 2000 14:40:40 -0700 (PDT)
	mail_from (geert@linux-m68k.org)
Received: from styx.cs.kuleuven.ac.be (styx.cs.kuleuven.ac.be [134.58.40.3]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA05734
	for <linux@cthulhu.engr.sgi.com>; Sun, 23 Apr 2000 14:40:38 -0700 (PDT)
	mail_from (geert@linux-m68k.org)
Received: from cassiopeia.home (geert@dialup006.cs.kuleuven.ac.be [134.58.47.135])
	by styx.cs.kuleuven.ac.be (8.9.3/8.9.3) with ESMTP id XAA14755;
	Sun, 23 Apr 2000 23:40:31 +0200 (MET DST)
Received: from localhost (geert@localhost)
	by cassiopeia.home (8.9.3/8.9.3/Debian/GNU) with ESMTP id XAA01852;
	Sun, 23 Apr 2000 23:40:26 +0200
X-Authentication-Warning: cassiopeia.home: geert owned process doing -bs
Date:   Sun, 23 Apr 2000 23:40:26 +0200 (CEST)
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     "Kevin D. Kissell" <kevink@mips.com>
cc:     Florian Lohoff <flo@rfc822.org>, linux@cthulhu.engr.sgi.com
Subject: Re: /usr/include/asm/io.h:308: undefined reference to `mips_io_port_base'
In-Reply-To: <000d01bfad56$7541c320$0ceca8c0@satanas.mips.com>
Message-ID: <Pine.LNX.4.10.10004232224240.801-100000@cassiopeia.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sun, 23 Apr 2000, Kevin D. Kissell wrote:
> >i am trying to build "pileup" which is a "SoundBlaster" morse trainer.
> >As it directly accesses hardware it seems to include some files which
> >aehm - dont seem to work for userspace :)
> >
> >Does someone have an idea what goes wrong here ?
> 
> Sure.  The "IN" and "OUT" macros used to simulate x86
> I/O instructions operating on ISA I/O space use
> mips_io_port_base as the base address for the
> memory-mapped I/O access to "non memory-mapped I/O"
> (in the PC sense) addresses.  Since MIPS platforms don't
> always have the same address space layout as a standard PC,
> mips_io_port_base is not a constant, but a variable declared
> in arch/mips/kernel/setup.c and initialized (if a non-zero value
> is required) in the platform setup code.
> 
> So arguably, what you need to do to make those macros
> work in user mode, is to have some kind of library module
> that you can link into the application that contains a declaration
> of mips_io_port_base, initialized to the correct value for
> your platform.

This is similar like on other platforms, like e.g. PPC.

I think the best solution is to provide the value of mips_io_port_base through
some /proc interface, so userspace knows where ISA I/O space is located.
Of course this is best coordinated across the different architectures where
this problem occurs (e.g. PPC).

> >[...]
> >make CFLAGS="-O2 -g -Wall -D_REENTRANT"
> >make[1]: Entering directory `/home/builder/build/pileup-1.1'
> >gcc -O2 -g -Wall -D_REENTRANT -c  AdLib.c
> >gcc -O2 -g -Wall -D_REENTRANT -c pileup.c
> >gcc -O2 -g -Wall -D_REENTRANT -o pileup pileup.o AdLib.o -lm -lpthread
> >pileup.o: In function `stop_thread':
> >/home/builder/build/pileup-1.1/pileup.c:229: undefined reference to `ioperm'

And we don't have ioperm() on architectures that don't have special I/O
instructions.

Just for reference, this is an example of what I use on PPC to access ISA I/O
space (please also look at include/asm-ppc/io.h, which resembles a bit to the
MIPS version).

--- tulip/tulip-diag.c.orig	Wed Mar 22 09:30:07 2000
+++ tulip/tulip-diag.c	Wed Mar 22 18:18:22 2000
@@ -42,6 +42,7 @@
 #include <string.h>
 #include <strings.h>
 #include <errno.h>
+#include <sys/mman.h>
 
 #include <asm/types.h>
 #include <asm/unaligned.h>
@@ -168,6 +169,56 @@
 static int scan_proc_pci(int card_num);
 static int parse_media_type(const char *capabilities);
 static int get_media_index(const char *name);
+
+#ifdef __powerpc__
+unsigned long isa_io_base;
+static int io_fd = -1;
+
+#define REAL_ISA_IO_BASE	0xf8000000	/* for CHRP LongTrail */
+#define REAL_ISA_IO_SIZE	0x01000000
+
+#warning Make sure REAL_ISA_IO_BASE is the correct base address for ISA I/O space!
+
+static void enable_isa_io(void)
+{
+    if ((io_fd = open("/dev/mem", O_RDWR)) == -1) {
+	perror("open /dev/mem");
+	exit(1);
+    }
+    isa_io_base = (unsigned long)mmap(0, REAL_ISA_IO_SIZE,
+	    			      PROT_READ | PROT_WRITE, MAP_SHARED,
+				      io_fd, REAL_ISA_IO_BASE);
+    if (isa_io_base == (unsigned long)-1) {
+	fprintf(stderr, "mmap 0x%08x: %s", REAL_ISA_IO_BASE, strerror(errno));
+	exit(1);
+    }
+}
+
+static void disable_isa_io(void)
+{
+    if (isa_io_base != (unsigned long)-1) {
+	munmap((caddr_t)isa_io_base, REAL_ISA_IO_SIZE);
+	isa_io_base = (unsigned long)-1;
+    }
+    if (io_fd != -1) {
+	close(io_fd);
+	io_fd = -1;
+    }
+}
+#else
+static void enable_isa_io(void)
+{
+    /* Get access to all of I/O space. */
+    if (iopl(3) < 0) {
+	perror("Network adapter diagnostic: iopl()");
+	fprintf(stderr, "This program must be run as root.\n");
+	exit(1);
+    }
+}
+
+#define disable_isa_io()	do { } while (0)
+#endif /* !__powerpc__ */
+
 
 int
 main(int argc, char **argv)
@@ -244,12 +295,7 @@
 		return 3;
 	}
 
-	/* Get access to all of I/O space. */
-	if (iopl(3) < 0) {
-		perror("Network adapter diagnostic: iopl()");
-		fprintf(stderr, "This program must be run as root.\n");
-		return 2;
-	}
+	enable_isa_io();
 
 	/* Try to read a likely port_base value from /proc/pci. */
 	if (port_base) {
@@ -270,6 +316,7 @@
 			   "     '-e' to show EEPROM contents, -ee for parsed contents,\n"
 			   "  or '-m' or '-mm' to show MII management registers.\n");
 
+	disable_isa_io();
 	return 0;
 }
 

Gr{oetje,eeting}s,

						Geert

--
Geert Uytterhoeven -- Linux/{m68k~Amiga,PPC~CHRP} -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
							    -- Linus Torvalds
