Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 May 2003 20:22:35 +0100 (BST)
Received: from delta.ds2.pg.gda.pl ([IPv6:::ffff:213.192.72.1]:8659 "EHLO
	delta.ds2.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8225239AbTEHTWa>; Thu, 8 May 2003 20:22:30 +0100
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id VAA17767;
	Thu, 8 May 2003 21:21:41 +0200 (MET DST)
Date: Thu, 8 May 2003 21:21:41 +0200 (MET DST)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Ralf Baechle <ralf@linux-mips.org>
cc: Guo Michael <michael_e_guo@hotmail.com>, linux-mips@linux-mips.org
Subject: Re: Which compiler should I use to make mips64 kernel
In-Reply-To: <20030506124029.GA2180@linux-mips.org>
Message-ID: <Pine.GSO.3.96.1030508211935.12320G-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@ds2.pg.gda.pl>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2302
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@ds2.pg.gda.pl
Precedence: bulk
X-list: linux-mips

On Tue, 6 May 2003, Ralf Baechle wrote:

> > mips64el-linux-ld  -r -o kernel.o sched.o dma.o fork.o exec_domain.o 
> > panic.o printk.o module.o exit.o itimer.o info.o time.o softirq.o 
> > resource.o sysctl.o acct.o capability.o ptrace.o timer.o user.o signal.o 
> > sys.o kmod.o context.o ksyms.o
> > mips64el-linux-ld: BFD 2.13.2.1 assertion fail elflink.h:5117
> 
> This is a known but not yet fixed problem that only seems to hit certain
> kernel configurations; I believe it somehow tied to little endianess also.

 This patch makes ld work for the kernel regardless of the default
emulation (output format).  What do you think?

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +

patch-mips-2.4.21-pre4-20030505-mips64-ld-oformat-0
diff -up --recursive --new-file linux-mips-2.4.21-pre4-20030505.macro/arch/mips64/Makefile linux-mips-2.4.21-pre4-20030505/arch/mips64/Makefile
--- linux-mips-2.4.21-pre4-20030505.macro/arch/mips64/Makefile	2003-02-27 03:56:44.000000000 +0000
+++ linux-mips-2.4.21-pre4-20030505/arch/mips64/Makefile	2003-05-08 15:44:25.000000000 +0000
@@ -251,10 +251,20 @@ LINKFLAGS += -T arch/mips64/ld.script.el
 #LINKFLAGS += -T arch/mips64/ld.script.elf64
 endif
 
+ifdef CONFIG_CPU_LITTLE_ENDIAN
+32bit-bfd = elf32-tradlittlemips
+64bit-bfd = elf64-tradlittlemips
+else
+32bit-bfd = elf32-tradbigmips
+64bit-bfd = elf64-tradbigmips
+endif
+
 
 AFLAGS		+= $(GCCFLAGS)
 CFLAGS		+= $(GCCFLAGS)
 
+LD		+= --oformat $(32bit-bfd)
+
 
 LINKFLAGS += -Ttext $(LOADADDR)
 
@@ -266,12 +276,6 @@ LIBS := arch/mips64/lib/lib.a $(LIBS)
 
 MAKEBOOT = $(MAKE) -C arch/$(ARCH)/boot
 
-ifdef CONFIG_CPU_LITTLE_ENDIAN
-64bit-bfd = elf64-tradlittlemips
-else
-64bit-bfd = elf64-tradbigmips
-endif
-
 vmlinux: arch/mips64/ld.script.elf32
 arch/mips64/ld.script.elf32: arch/mips64/ld.script.elf32.S
 	$(CPP) -C -P -I$(HPATH) -imacros $(HPATH)/asm-mips64/sn/mapped_kernel.h -Umips arch/mips64/ld.script.elf32.S > arch/mips64/ld.script.elf32
