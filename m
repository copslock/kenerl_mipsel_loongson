Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Oct 2004 01:20:12 +0100 (BST)
Received: from pollux.ds.pg.gda.pl ([IPv6:::ffff:153.19.208.7]:6413 "EHLO
	pollux.ds.pg.gda.pl") by linux-mips.org with ESMTP
	id <S8224900AbUJSAUC>; Tue, 19 Oct 2004 01:20:02 +0100
Received: from localhost (localhost [127.0.0.1])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id C1220E1CB0; Tue, 19 Oct 2004 02:19:49 +0200 (CEST)
Received: from pollux.ds.pg.gda.pl ([127.0.0.1])
 by localhost (pollux [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
 id 28435-03; Tue, 19 Oct 2004 02:19:49 +0200 (CEST)
Received: from piorun.ds.pg.gda.pl (piorun.ds.pg.gda.pl [153.19.208.8])
	by pollux.ds.pg.gda.pl (Postfix) with ESMTP
	id 78425E1C7B; Tue, 19 Oct 2004 02:19:49 +0200 (CEST)
Received: from blysk.ds.pg.gda.pl (macro@blysk.ds.pg.gda.pl [153.19.208.6])
	by piorun.ds.pg.gda.pl (8.13.1/8.12.11) with ESMTP id i9J0K9S5006177;
	Tue, 19 Oct 2004 02:20:10 +0200
Date: Tue, 19 Oct 2004 01:19:56 +0100 (BST)
From: "Maciej W. Rozycki" <macro@linux-mips.org>
To: Manish Lachwani <mlachwani@mvista.com>,
	Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Subject: Re: [PATCH] 64-bit on Broadcom SWARM
In-Reply-To: <Pine.LNX.4.58L.0409301823290.25286@blysk.ds.pg.gda.pl>
Message-ID: <Pine.LNX.4.58L.0410182204280.12159@blysk.ds.pg.gda.pl>
References: <415C3ABA.6080601@mvista.com> <Pine.LNX.4.58L.0409301823290.25286@blysk.ds.pg.gda.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Virus-Scanned: by amavisd-new at pollux.ds.pg.gda.pl
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6094
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Thu, 30 Sep 2004, Maciej W. Rozycki wrote:

> > --- arch/mips/Makefile.orig	2004-09-30 09:49:45.000000000 -0700
> > +++ arch/mips/Makefile	2004-09-30 09:50:27.000000000 -0700
> > @@ -35,7 +35,7 @@
> >  endif
> >  ifdef CONFIG_MIPS64
> >  gcc-abi			= 64
> > -gas-abi			= 32
> > +gas-abi			= 64
> >  tool-prefix		= $(64bit-tool-prefix)
> >  UTS_MACHINE		:= mips64
> >  endif
> 
>  I won't particularly mind having this change in, but there are apparently
> people who want to have the current setting preserved.  So I doubt this
> part is going to be accepted.  Please use `make "gas-abi=64" <whatever>'
> instead.
> 
>  Alternatively, please let me check if I can get some time to implement 
> one of my to-do list goals, that is having it configurable.

 Here is a proposal for an implementation I've finally done.  It adds a 
CONFIG_BUILD_ELF64 option for people to select whichever binary format 
suits them best.

 I've tested it with a gcc 3.5 snapshot and a binutils 2.15.91 snapshot
for building using the 64-bit ELF binary format or binutils 2.13.2.1 for
the 32-bit format.  I've tested Malta and SWARM configurations.  I have a
version for 2.4 as well.

 The <asm/stackframe.h> fix is needed for binutils 2.13.2.1; it's a 
reasonable clean-up anyway.

 I consider the patch ready for inclusion, but I'll appreciate any
feedback, whether positive or negative, as long as constructive.

  Maciej

patch-mips-2.6.9-rc2-20040920-mips-elf64-5
diff -up --recursive --new-file linux-mips-2.6.9-rc2-20040920.macro/arch/mips/Kconfig linux-mips-2.6.9-rc2-20040920/arch/mips/Kconfig
--- linux-mips-2.6.9-rc2-20040920.macro/arch/mips/Kconfig	2004-09-01 03:57:35.000000000 +0000
+++ linux-mips-2.6.9-rc2-20040920/arch/mips/Kconfig	2004-10-17 21:20:53.000000000 +0000
@@ -1503,6 +1503,21 @@ config TRAD_SIGNALS
 	bool
 	default y if MIPS32
 
+config BUILD_ELF64
+	bool "Use 64-bit ELF format for building"
+	depends on MIPS64
+	help
+	  A 64-bit kernel is usually built using the 64-bit ELF binary object
+	  format as it's one that allows arbitrary 64-bit constructs.  For
+	  kernels that are loaded within the KSEG compatibility segments the
+	  32-bit ELF format can optionally be used resulting in a somewhat
+	  smaller binary, but this option is not explicitly supported by the
+	  toolchain and since binutils 2.14 it does not even work at all.
+
+	  Say Y to use the 64-bit format or N to use the 32-bit one.
+
+	  If unsure say Y.
+
 config BINFMT_IRIX
 	bool "Include IRIX binary compatibility"
 	depends on !CPU_LITTLE_ENDIAN && MIPS32
diff -up --recursive --new-file linux-mips-2.6.9-rc2-20040920.macro/arch/mips/Makefile linux-mips-2.6.9-rc2-20040920/arch/mips/Makefile
--- linux-mips-2.6.9-rc2-20040920.macro/arch/mips/Makefile	2004-09-19 03:57:24.000000000 +0000
+++ linux-mips-2.6.9-rc2-20040920/arch/mips/Makefile	2004-10-18 00:35:04.000000000 +0000
@@ -5,13 +5,19 @@
 #
 # Copyright (C) 1994, 95, 96, 2003 by Ralf Baechle
 # DECStation modifications by Paul M. Antoine, 1996
-# Copyright (C) 2002, 2003  Maciej W. Rozycki
+# Copyright (C) 2002, 2003, 2004  Maciej W. Rozycki
 #
 # This file is included by the global makefile so that you can add your own
 # architecture-specific flags and dependencies. Remember to do have actions
 # for "archclean" cleaning up for this architecture.
 #
 
+as-option = $(shell if $(CC) $(CFLAGS) $(1) -Wa,-Z -c -o /dev/null \
+	     -xassembler /dev/null > /dev/null 2>&1; then echo "$(1)"; \
+	     else echo "$(2)"; fi ;)
+
+cflags-y :=
+
 #
 # Select the object file format to substitute into the linker script.
 #
@@ -29,13 +35,11 @@ endif
 
 ifdef CONFIG_MIPS32
 gcc-abi			= 32
-gas-abi			= 32
 tool-prefix		= $(32bit-tool-prefix)
 UTS_MACHINE		:= mips
 endif
 ifdef CONFIG_MIPS64
 gcc-abi			= 64
-gas-abi			= 32
 tool-prefix		= $(64bit-tool-prefix)
 UTS_MACHINE		:= mips64
 endif
@@ -44,6 +48,20 @@ ifdef CONFIG_CROSSCOMPILE
 CROSS_COMPILE		:= $(tool-prefix)
 endif
 
+ifdef CONFIG_BUILD_ELF64
+gas-abi			= 64
+build-bfd		= $(64bit-bfd)
+vmlinux-32		= vmlinux.32
+vmlinux-64		= vmlinux
+else
+gas-abi			= 32
+build-bfd		= $(32bit-bfd)
+vmlinux-32		= vmlinux
+vmlinux-64		= vmlinux.64
+
+cflags-$(CONFIG_MIPS64)	+= $(call cc-option,-mno-explicit-relocs)
+endif
+
 #
 # GCC uses -G 0 -mabicalls -fpic as default.  We don't want PIC in the kernel
 # code since it only slows down the whole thing.  At some point we might make
@@ -54,7 +72,7 @@ endif
 # machines may also.  Since BFD is incredibly buggy with respect to
 # crossformat linking we rely on the elf2ecoff tool for format conversion.
 #
-cflags-y			:= -I $(TOPDIR)/include/asm/gcc
+cflags-y			+= -I $(TOPDIR)/include/asm/gcc
 cflags-y			+= -G 0 -mno-abicalls -fno-pic -pipe
 cflags-y			+= $(call cc-option, -finline-limit=100000)
 LDFLAGS_vmlinux			+= -G 0 -static -n
@@ -211,7 +229,7 @@ libs-$(CONFIG_SIBYTE_CFE)	+= arch/mips/s
 #
 core-$(CONFIG_MACH_JAZZ)	+= arch/mips/jazz/
 cflags-$(CONFIG_MACH_JAZZ)	+= -Iinclude/asm-mips/mach-jazz
-load-$(CONFIG_MACH_JAZZ)	+= 0x80080000
+load-$(CONFIG_MACH_JAZZ)	+= 0xffffffff80080000
 
 #
 # Common Alchemy Au1x00 stuff
@@ -224,94 +242,94 @@ cflags-$(CONFIG_SOC_AU1X00)	+= -Iinclude
 #
 libs-$(CONFIG_MIPS_PB1000)	+= arch/mips/au1000/pb1000/
 cflags-$(CONFIG_MIPS_PB1000)	+= -Iinclude/asm-mips/mach-pb1x00
-load-$(CONFIG_MIPS_PB1000)	+= 0x80100000
+load-$(CONFIG_MIPS_PB1000)	+= 0xffffffff80100000
 
 #
 # AMD Alchemy Pb1100 eval board
 #
 libs-$(CONFIG_MIPS_PB1100)	+= arch/mips/au1000/pb1100/
 cflags-$(CONFIG_MIPS_PB1100)	+= -Iinclude/asm-mips/mach-pb1x00
-load-$(CONFIG_MIPS_PB1100)	+= 0x80100000
+load-$(CONFIG_MIPS_PB1100)	+= 0xffffffff80100000
 
 #
 # AMD Alchemy Pb1500 eval board
 #
 libs-$(CONFIG_MIPS_PB1500)	+= arch/mips/au1000/pb1500/
 cflags-$(CONFIG_MIPS_PB1500)	+= -Iinclude/asm-mips/mach-pb1x00
-load-$(CONFIG_MIPS_PB1500)	+= 0x80100000
+load-$(CONFIG_MIPS_PB1500)	+= 0xffffffff80100000
 
 #
 # AMD Alchemy Pb1550 eval board
 #
 libs-$(CONFIG_MIPS_PB1550)	+= arch/mips/au1000/pb1550/
 cflags-$(CONFIG_MIPS_PB1550)	+= -Iinclude/asm-mips/mach-pb1x00
-load-$(CONFIG_MIPS_PB1550)	+= 0x80100000
+load-$(CONFIG_MIPS_PB1550)	+= 0xffffffff80100000
 
 #
 # AMD Alchemy Db1000 eval board
 #
 libs-$(CONFIG_MIPS_DB1000)	+= arch/mips/au1000/db1x00/
 cflags-$(CONFIG_MIPS_DB1000)	+= -Iinclude/asm-mips/mach-db1x00
-load-$(CONFIG_MIPS_DB1000)	+= 0x80100000
+load-$(CONFIG_MIPS_DB1000)	+= 0xffffffff80100000
 
 #
 # AMD Alchemy Db1100 eval board
 #
 libs-$(CONFIG_MIPS_DB1100)	+= arch/mips/au1000/db1x00/
 cflags-$(CONFIG_MIPS_DB1100)	+= -Iinclude/asm-mips/mach-db1x00
-load-$(CONFIG_MIPS_DB1100)	+= 0x80100000
+load-$(CONFIG_MIPS_DB1100)	+= 0xffffffff80100000
 
 #
 # AMD Alchemy Db1500 eval board
 #
 libs-$(CONFIG_MIPS_DB1500)	+= arch/mips/au1000/db1x00/
 cflags-$(CONFIG_MIPS_DB1500)	+= -Iinclude/asm-mips/mach-db1x00
-load-$(CONFIG_MIPS_DB1500)	+= 0x80100000
+load-$(CONFIG_MIPS_DB1500)	+= 0xffffffff80100000
 
 #
 # AMD Alchemy Db1550 eval board
 #
 libs-$(CONFIG_MIPS_DB1550)	+= arch/mips/au1000/db1x00/
 cflags-$(CONFIG_MIPS_DB1550)	+= -Iinclude/asm-mips/mach-db1x00
-load-$(CONFIG_MIPS_DB1550)	+= 0x80100000
+load-$(CONFIG_MIPS_DB1550)	+= 0xffffffff80100000
 
 #
 # AMD Alchemy Bosporus eval board
 #
 libs-$(CONFIG_MIPS_BOSPORUS)	+= arch/mips/au1000/db1x00/
 cflags-$(CONFIG_MIPS_BOSPORUS)	+= -Iinclude/asm-mips/mach-db1x00
-load-$(CONFIG_MIPS_BOSPORUS)	+= 0x80100000
+load-$(CONFIG_MIPS_BOSPORUS)	+= 0xffffffff80100000
 
 #
 # AMD Alchemy Mirage eval board
 #
 libs-$(CONFIG_MIPS_MIRAGE)	+= arch/mips/au1000/db1x00/
 cflags-$(CONFIG_MIPS_MIRAGE)	+= -Iinclude/asm-mips/mach-db1x00
-load-$(CONFIG_MIPS_MIRAGE)	+= 0x80100000
+load-$(CONFIG_MIPS_MIRAGE)	+= 0xffffffff80100000
 
 #
 # 4G-Systems eval board
 #
 libs-$(CONFIG_MIPS_MTX1)	+= arch/mips/au1000/mtx-1/
-load-$(CONFIG_MIPS_MTX1)	+= 0x80100000
+load-$(CONFIG_MIPS_MTX1)	+= 0xffffffff80100000
 
 #
 # MyCable eval board
 #
 libs-$(CONFIG_MIPS_XXS1500)	+= arch/mips/au1000/xxs1500/
-load-$(CONFIG_MIPS_XXS1500)	+= 0x80100000
+load-$(CONFIG_MIPS_XXS1500)	+= 0xffffffff80100000
 
 #
 # Baget/MIPS
 #
 libs-$(CONFIG_BAGET_MIPS)	+= arch/mips/baget/ arch/mips/baget/prom/
-load-$(CONFIG_BAGET_MIPS)	+= 0x80001000
+load-$(CONFIG_BAGET_MIPS)	+= 0xffffffff80001000
 
 #
 # Cobalt Server
 #
 core-$(CONFIG_MIPS_COBALT)	+= arch/mips/cobalt/
-load-$(CONFIG_MIPS_COBALT)	+= 0x80080000
+load-$(CONFIG_MIPS_COBALT)	+= 0xffffffff80080000
 
 #
 # DECstation family
@@ -319,7 +337,7 @@ load-$(CONFIG_MIPS_COBALT)	+= 0x80080000
 core-$(CONFIG_MACH_DECSTATION)	+= arch/mips/dec/
 cflags-$(CONFIG_MACH_DECSTATION)+= -Iinclude/asm-mips/mach-dec
 libs-$(CONFIG_MACH_DECSTATION)	+= arch/mips/dec/prom/
-load-$(CONFIG_MACH_DECSTATION)	+= 0x80040000
+load-$(CONFIG_MACH_DECSTATION)	+= 0xffffffff80040000
 CLEAN_FILES			+= drivers/tc/lk201-map.c
 
 #
@@ -328,33 +346,33 @@ CLEAN_FILES			+= drivers/tc/lk201-map.c
 core-$(CONFIG_MIPS_EV64120)	+= arch/mips/gt64120/ev64120/
 core-$(CONFIG_MIPS_EV64120)	+= arch/mips/gt64120/common/
 cflags-$(CONFIG_MIPS_EV64120)	+= -Iinclude/asm-mips/mach-ev64120
-load-$(CONFIG_MIPS_EV64120)	+= 0x80100000
+load-$(CONFIG_MIPS_EV64120)	+= 0xffffffff80100000
 
 #
 # Galileo EV96100 Board
 #
 core-$(CONFIG_MIPS_EV96100)	+= arch/mips/galileo-boards/ev96100/
 cflags-$(CONFIG_MIPS_EV96100)	+= -Iinclude/asm-mips/mach-ev96100
-load-$(CONFIG_MIPS_EV96100)	+= 0x80100000
+load-$(CONFIG_MIPS_EV96100)	+= 0xffffffff80100000
 
 #
 # Globespan IVR eval board with QED 5231 CPU
 #
 core-$(CONFIG_ITE_BOARD_GEN)	+= arch/mips/ite-boards/generic/
 core-$(CONFIG_MIPS_IVR)		+= arch/mips/ite-boards/ivr/
-load-$(CONFIG_MIPS_IVR)		+= 0x80100000
+load-$(CONFIG_MIPS_IVR)		+= 0xffffffff80100000
 
 #
 # HP LaserJet
 #
 core-$(CONFIG_HP_LASERJET)	+= arch/mips/hp-lj/
-load-$(CONFIG_HP_LASERJET)	+= 0x80030000
+load-$(CONFIG_HP_LASERJET)	+= 0xffffffff80030000
 
 #
 # ITE 8172 eval board with QED 5231 CPU
 #
 core-$(CONFIG_MIPS_ITE8172)	+= arch/mips/ite-boards/qed-4n-s01b/
-load-$(CONFIG_MIPS_ITE8172)	+= 0x80100000
+load-$(CONFIG_MIPS_ITE8172)	+= 0xffffffff80100000
 
 #
 # For all MIPS, Inc. eval boards
@@ -367,20 +385,20 @@ core-$(CONFIG_MIPS_BOARDS_GEN)	+= arch/m
 core-$(CONFIG_MIPS_ATLAS)	+= arch/mips/mips-boards/atlas/
 cflags-$(CONFIG_MIPS_ATLAS)	+= -Iinclude/asm-mips/mach-atlas
 cflags-$(CONFIG_MIPS_ATLAS)	+= -Iinclude/asm-mips/mach-mips
-load-$(CONFIG_MIPS_ATLAS)	+= 0x80100000
+load-$(CONFIG_MIPS_ATLAS)	+= 0xffffffff80100000
 
 #
 # MIPS Malta board
 #
 core-$(CONFIG_MIPS_MALTA)	+= arch/mips/mips-boards/malta/
 cflags-$(CONFIG_MIPS_MALTA)	+= -Iinclude/asm-mips/mach-mips
-load-$(CONFIG_MIPS_MALTA)	+= 0x80100000
+load-$(CONFIG_MIPS_MALTA)	+= 0xffffffff80100000
 
 #
 # MIPS SEAD board
 #
 core-$(CONFIG_MIPS_SEAD)	+= arch/mips/mips-boards/sead/
-load-$(CONFIG_MIPS_SEAD)	+= 0x80100000
+load-$(CONFIG_MIPS_SEAD)	+= 0xffffffff80100000
 
 #
 # Momentum Ocelot board
@@ -391,7 +409,7 @@ load-$(CONFIG_MIPS_SEAD)	+= 0x80100000
 core-$(CONFIG_MOMENCO_OCELOT)	+= arch/mips/gt64120/common/ \
 				   arch/mips/gt64120/momenco_ocelot/
 cflags-$(CONFIG_MOMENCO_OCELOT)	+= -Iinclude/asm-mips/mach-ocelot
-load-$(CONFIG_MOMENCO_OCELOT)	+= 0x80100000
+load-$(CONFIG_MOMENCO_OCELOT)	+= 0xffffffff80100000
 
 #
 # Momentum Ocelot-G board
@@ -400,7 +418,7 @@ load-$(CONFIG_MOMENCO_OCELOT)	+= 0x80100
 # mips_io_port_base.
 #
 core-$(CONFIG_MOMENCO_OCELOT_G)	+= arch/mips/momentum/ocelot_g/
-load-$(CONFIG_MOMENCO_OCELOT_G)	+= 0x80100000
+load-$(CONFIG_MOMENCO_OCELOT_G)	+= 0xffffffff80100000
 
 #
 # Momentum Ocelot-C and -CS boards
@@ -408,14 +426,14 @@ load-$(CONFIG_MOMENCO_OCELOT_G)	+= 0x801
 # The Ocelot-C[S] setup.o must be linked early - it does the ioremap() for the
 # mips_io_port_base.
 core-$(CONFIG_MOMENCO_OCELOT_C)	+= arch/mips/momentum/ocelot_c/
-load-$(CONFIG_MOMENCO_OCELOT_C)	+= 0x80100000
+load-$(CONFIG_MOMENCO_OCELOT_C)	+= 0xffffffff80100000
 
 #
 # PMC-Sierra Yosemite
 #
 core-$(CONFIG_PMC_YOSEMITE)	+= arch/mips/pmc-sierra/yosemite/
 cflags-$(CONFIG_PMC_YOSEMITE)	+= -Iinclude/asm-mips/mach-yosemite
-load-$(CONFIG_PMC_YOSEMITE)	+= 0x80100000
+load-$(CONFIG_PMC_YOSEMITE)	+= 0xffffffff80100000
 
 #
 # Momentum Jaguar ATX
@@ -423,9 +441,9 @@ load-$(CONFIG_PMC_YOSEMITE)	+= 0x8010000
 core-$(CONFIG_MOMENCO_JAGUAR_ATX)	+= arch/mips/momentum/jaguar_atx/
 cflags-$(CONFIG_MOMENCO_JAGUAR_ATX)	+= -Iinclude/asm-mips/mach-ja
 #ifdef CONFIG_JAGUAR_DMALOW
-#load-$(CONFIG_MOMENCO_JAGUAR_ATX)	+= 0x88000000
+#load-$(CONFIG_MOMENCO_JAGUAR_ATX)	+= 0xffffffff88000000
 #else
-load-$(CONFIG_MOMENCO_JAGUAR_ATX)	+= 0x80100000
+load-$(CONFIG_MOMENCO_JAGUAR_ATX)	+= 0xffffffff80100000
 #endif
 
 #
@@ -437,30 +455,30 @@ core-$(CONFIG_DDB5XXX_COMMON)	+= arch/mi
 # NEC DDB Vrc-5074
 #
 core-$(CONFIG_DDB5074)		+= arch/mips/ddb5xxx/ddb5074/
-load-$(CONFIG_DDB5074)		+= 0x80080000
+load-$(CONFIG_DDB5074)		+= 0xffffffff80080000
 
 #
 # NEC DDB Vrc-5476
 #
 core-$(CONFIG_DDB5476)		+= arch/mips/ddb5xxx/ddb5476/
-load-$(CONFIG_DDB5476)		+= 0x80080000
+load-$(CONFIG_DDB5476)		+= 0xffffffff80080000
 
 #
 # NEC DDB Vrc-5477
 #
 core-$(CONFIG_DDB5477)		+= arch/mips/ddb5xxx/ddb5477/
-load-$(CONFIG_DDB5477)		+= 0x80100000
+load-$(CONFIG_DDB5477)		+= 0xffffffff80100000
 
 core-$(CONFIG_LASAT)		+= arch/mips/lasat/
 cflags-$(CONFIG_LASAT)		+= -Iinclude/asm-mips/mach-lasat
-load-$(CONFIG_LASAT)		+= 0x80000000
+load-$(CONFIG_LASAT)		+= 0xffffffff80000000
 
 #
 # NEC Osprey (vr4181) board
 #
 core-$(CONFIG_NEC_OSPREY)	+= arch/mips/vr4181/common/ \
 				   arch/mips/vr4181/osprey/
-load-$(CONFIG_NEC_OSPREY)	+= 0x80002000
+load-$(CONFIG_NEC_OSPREY)	+= 0xffffffff80002000
 
 #
 # Common VR41xx
@@ -472,70 +490,82 @@ cflags-$(CONFIG_MACH_VR41XX)	+= -Iinclud
 # ZAO Networks Capcella (VR4131)
 #
 core-$(CONFIG_ZAO_CAPCELLA)	+= arch/mips/vr41xx/zao-capcella/
-load-$(CONFIG_ZAO_CAPCELLA)	+= 0x80000000
+load-$(CONFIG_ZAO_CAPCELLA)	+= 0xffffffff80000000
 
 #
 # Victor MP-C303/304 (VR4122)
 #
 core-$(CONFIG_VICTOR_MPC30X)	+= arch/mips/vr41xx/victor-mpc30x/
-load-$(CONFIG_VICTOR_MPC30X)	+= 0x80001000
+load-$(CONFIG_VICTOR_MPC30X)	+= 0xffffffff80001000
 
 #
 # IBM WorkPad z50 (VR4121)
 #
 core-$(CONFIG_IBM_WORKPAD)	+= arch/mips/vr41xx/ibm-workpad/
-load-$(CONFIG_IBM_WORKPAD)	+= 0x80004000
+load-$(CONFIG_IBM_WORKPAD)	+= 0xffffffff80004000
 
 #
 # CASIO CASSIPEIA E-55/65 (VR4111)
 #
 core-$(CONFIG_CASIO_E55)	+= arch/mips/vr41xx/casio-e55/
-load-$(CONFIG_CASIO_E55)	+= 0x80004000
+load-$(CONFIG_CASIO_E55)	+= 0xffffffff80004000
 
 #
 # TANBAC TB0226 Mbase (VR4131)
 #
 core-$(CONFIG_TANBAC_TB0226)	+= arch/mips/vr41xx/tanbac-tb0226/
-load-$(CONFIG_TANBAC_TB0226)	+= 0x80000000
+load-$(CONFIG_TANBAC_TB0226)	+= 0xffffffff80000000
 
 #
 # TANBAC TB0229 VR4131DIMM (VR4131)
 #
 core-$(CONFIG_TANBAC_TB0229)	+= arch/mips/vr41xx/tanbac-tb0229/
-load-$(CONFIG_TANBAC_TB0229)	+= 0x80000000
+load-$(CONFIG_TANBAC_TB0229)	+= 0xffffffff80000000
 
 #
 # SGI IP22 (Indy/Indigo2)
 #
-# Set the load address to >= 0x88069000 if you want to leave space for symmon,
-# 0x80002000 for production kernels.  Note that the value must be aligned to
-# a multiple of the kernel stack size or the handling of the current variable
-# will break so for 64-bit kernels we have to raise the start address by 8kb.
+# Set the load address to >= 0xffffffff88069000 if you want to leave space for
+# symmon, 0xffffffff80002000 for production kernels.  Note that the value must
+# be aligned to a multiple of the kernel stack size or the handling of the
+# current variable will break so for 64-bit kernels we have to raise the start
+# address by 8kb.
 #
 core-$(CONFIG_SGI_IP22)		+= arch/mips/sgi-ip22/
 cflags-$(CONFIG_SGI_IP22)	+= -Iinclude/asm-mips/mach-ip22
 ifdef CONFIG_MIPS32
-load-$(CONFIG_SGI_IP22)		+= 0x88002000
+load-$(CONFIG_SGI_IP22)		+= 0xffffffff88002000
 endif
 ifdef CONFIG_MIPS64
-load-$(CONFIG_SGI_IP22)		+= 0x88004000
+load-$(CONFIG_SGI_IP22)		+= 0xffffffff88004000
 endif
 
 #
 # SGI-IP27 (Origin200/2000)
 #
 # Set the load address to >= 0xc000000000300000 if you want to leave space for
-# symmon, 0xc00000000001c000 for production kernels.  Note that the value
-# must be 16kb aligned or the handling of the current variable will break.
+# symmon, 0xc00000000001c000 for production kernels.  Note that the value must
+# be 16kb aligned or the handling of the current variable will break.
 #
 ifdef CONFIG_SGI_IP27
 core-$(CONFIG_SGI_IP27)		+= arch/mips/sgi-ip27/
 cflags-$(CONFIG_SGI_IP27)	+= -Iinclude/asm-mips/mach-ip27
-#load-$(CONFIG_SGI_IP27)	+= 0xa80000000001c000
+ifdef CONFIG_BUILD_ELF64
+ifdef CONFIG_MAPPED_KERNEL
+load-$(CONFIG_SGI_IP27)		+= 0xc00000004001c000
+OBJCOPYFLAGS			:= --change-addresses=0x3fffffff80000000
+else
+load-$(CONFIG_SGI_IP27)		+= 0xa80000000001c000
+OBJCOPYFLAGS			:= --change-addresses=0x57ffffff80000000
+endif
+else
 ifdef CONFIG_MAPPED_KERNEL
-load-$(CONFIG_SGI_IP27)		+= 0xc001c000
+load-$(CONFIG_SGI_IP27)		+= 0xffffffffc001c000
+OBJCOPYFLAGS			:= --change-addresses=0xc000000080000000
 else
-load-$(CONFIG_SGI_IP27)		+= 0x8001c000
+load-$(CONFIG_SGI_IP27)		+= 0xffffffff8001c000
+OBJCOPYFLAGS			:= --change-addresses=0xa800000080000000
+endif
 endif
 endif
 
@@ -543,13 +573,13 @@ endif
 # SGI-IP32 (O2)
 #
 # Set the load address to >= 80069000 if you want to leave space for symmon,
-# 0x80004000 for production kernels.  Note that the value must be aligned to
+# 0xffffffff80004000 for production kernels.  Note that the value must be aligned to
 # a multiple of the kernel stack size or the handling of the current variable
 # will break.
 #
 core-$(CONFIG_SGI_IP32)		+= arch/mips/sgi-ip32/
 cflags-$(CONFIG_SGI_IP32)	+= -Iinclude/asm-mips/mach-ip32
-load-$(CONFIG_SGI_IP32)		+= 0x80004000
+load-$(CONFIG_SGI_IP32)		+= 0xffffffff80004000
 
 #
 # Sibyte SB1250 SOC
@@ -572,31 +602,31 @@ cflags-$(CONFIG_SIBYTE_SB1250)	+= -Iincl
 # Sibyte SWARM board
 #
 libs-$(CONFIG_SIBYTE_CARMEL)	+= arch/mips/sibyte/swarm/
-load-$(CONFIG_SIBYTE_CARMEL)	:= 0x80100000
+load-$(CONFIG_SIBYTE_CARMEL)	:= 0xffffffff80100000
 libs-$(CONFIG_SIBYTE_CRHINE)	+= arch/mips/sibyte/swarm/
-load-$(CONFIG_SIBYTE_CRHINE)	:= 0x80100000
+load-$(CONFIG_SIBYTE_CRHINE)	:= 0xffffffff80100000
 libs-$(CONFIG_SIBYTE_CRHONE)	+= arch/mips/sibyte/swarm/
-load-$(CONFIG_SIBYTE_CRHONE)	:= 0x80100000
+load-$(CONFIG_SIBYTE_CRHONE)	:= 0xffffffff80100000
 libs-$(CONFIG_SIBYTE_RHONE)	+= arch/mips/sibyte/swarm/
-load-$(CONFIG_SIBYTE_RHONE)	:= 0x80100000
+load-$(CONFIG_SIBYTE_RHONE)	:= 0xffffffff80100000
 libs-$(CONFIG_SIBYTE_SENTOSA)	+= arch/mips/sibyte/swarm/
-load-$(CONFIG_SIBYTE_SENTOSA)	:= 0x80100000
+load-$(CONFIG_SIBYTE_SENTOSA)	:= 0xffffffff80100000
 libs-$(CONFIG_SIBYTE_SWARM)	+= arch/mips/sibyte/swarm/
-load-$(CONFIG_SIBYTE_SWARM)	:= 0x80100000
+load-$(CONFIG_SIBYTE_SWARM)	:= 0xffffffff80100000
 
 #
 # SNI RM200 PCI
 #
 core-$(CONFIG_SNI_RM200_PCI)	+= arch/mips/sni/
 cflags-$(CONFIG_SNI_RM200_PCI)	+= -Iinclude/asm-mips/mach-rm200
-load-$(CONFIG_SNI_RM200_PCI)	+= 0x80600000
+load-$(CONFIG_SNI_RM200_PCI)	+= 0xffffffff80600000
 
 #
 # Toshiba JMR-TX3927 board
 #
 core-$(CONFIG_TOSHIBA_JMR3927)	+= arch/mips/jmr3927/rbhma3100/ \
 				   arch/mips/jmr3927/common/
-load-$(CONFIG_TOSHIBA_JMR3927)	+= 0x80050000
+load-$(CONFIG_TOSHIBA_JMR3927)	+= 0xffffffff80050000
 
 #
 # Toshiba RBTX4927 board or
@@ -604,21 +634,12 @@ load-$(CONFIG_TOSHIBA_JMR3927)	+= 0x8005
 #
 core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/mips/tx4927/toshiba_rbtx4927/
 core-$(CONFIG_TOSHIBA_RBTX4927)	+= arch/mips/tx4927/common/
-load-$(CONFIG_TOSHIBA_RBTX4927)	+= 0x80020000
+load-$(CONFIG_TOSHIBA_RBTX4927)	+= 0xffffffff80020000
 
 cflags-y			+= -Iinclude/asm-mips/mach-generic
 drivers-$(CONFIG_PCI)		+= arch/mips/pci/
 
 ifdef CONFIG_MIPS32
-build-bfd		= $(32bit-bfd)
-cflags-y		+= $(32bit-isa-y)
-endif
-ifdef CONFIG_MIPS64
-build-bfd		= $(64bit-bfd)
-cflags-y		+= $(64bit-isa-y)
-endif
-
-ifdef CONFIG_MIPS32
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 JIFFIES			= jiffies_64
 else
@@ -628,21 +649,12 @@ else
 JIFFIES			= jiffies_64
 endif
 
-#
-# Some machines like the Indy need 32-bit ELF binaries for booting purposes.
-# Other need ECOFF, so we build a 32-bit ELF binary for them which we then
-# convert to ECOFF using elf2ecoff.
-#
-# The 64-bit ELF tools are pretty broken so at this time we generate 64-bit
-# ELF files from 32-bit files by conversion.
-#
-#AS += -64
-#LDFLAGS += -m elf64bmip
-
 AFLAGS		+= $(cflags-y)
 CFLAGS		+= $(cflags-y)
 
-LDFLAGS			+= --oformat $(32bit-bfd)
+LDFLAGS			+= --oformat $(build-bfd)
+
+OBJCOPYFLAGS		+= --remove-section=.reginfo
 
 #
 # Choosing incompatible machines durings configuration will result in
@@ -678,30 +690,39 @@ rom.bin rom.sw: vmlinux
 	$(call descend,arch/mips/lasat/image,$@)
 endif
 
-ifdef CONFIG_MAPPED_KERNEL
-vmlinux.64: vmlinux
-	$(OBJCOPY) -O $(64bit-bfd) --remove-section=.reginfo \
-		--change-addresses=0xc000000080000000 $< $@
-else
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
-	$(OBJCOPY) -O $(64bit-bfd) --remove-section=.reginfo \
-		--change-addresses=0xa800000080000000 $< $@
-endif
+	$(OBJCOPY) -O $(64bit-bfd) $(OBJCOPYFLAGS) $< $@
 
-makeboot =$(Q)$(MAKE) $(build)=arch/mips/boot $(1)
+makeboot =$(Q)$(MAKE) $(build)=arch/mips/boot VMLINUX=$(vmlinux-32) $(1)
 
-ifdef CONFIG_SGI_IP27
-all:	vmlinux.64
+ifdef CONFIG_BOOT_ELF32
+all:	$(vmlinux-32)
+endif
+
+ifdef CONFIG_BOOT_ELF64
+all:	$(vmlinux-64)
 endif
 
 ifdef CONFIG_SNI_RM200_PCI
 all:	vmlinux.ecoff
 endif
 
-vmlinux.ecoff vmlinux.rm200: vmlinux
+vmlinux.ecoff vmlinux.rm200: $(vmlinux-32)
 	+@$(call makeboot,$@)
 
-vmlinux.srec: vmlinux
+vmlinux.srec: $(vmlinux-32)
 	+@$(call makeboot,$@)
 
 CLEAN_FILES += vmlinux.ecoff \
@@ -766,5 +787,6 @@ CLEAN_FILES += include/asm-$(ARCH)/offse
 	       include/asm-$(ARCH)/offset.h \
 	       include/asm-$(ARCH)/reg.h.tmp \
 	       include/asm-$(ARCH)/reg.h \
+	       vmlinux.32 \
 	       vmlinux.64 \
 	       vmlinux.ecoff
diff -up --recursive --new-file linux-mips-2.6.9-rc2-20040920.macro/arch/mips/boot/Makefile linux-mips-2.6.9-rc2-20040920/arch/mips/boot/Makefile
--- linux-mips-2.6.9-rc2-20040920.macro/arch/mips/boot/Makefile	2004-05-27 03:57:24.000000000 +0000
+++ linux-mips-2.6.9-rc2-20040920/arch/mips/boot/Makefile	2004-10-17 21:45:45.000000000 +0000
@@ -4,6 +4,7 @@
 # for more details.
 #
 # Copyright (C) 1995, 1998, 2001, 2002 by Ralf Baechle
+# Copyright (C) 2004  Maciej W. Rozycki
 #
 
 #
@@ -19,29 +20,30 @@ endif
 # Drop some uninteresting sections in the kernel.
 # This is only relevant for ELF kernels but doesn't hurt a.out
 #
-drop-sections	= .reginfo .mdebug .comment .note .pdr
+drop-sections	= .reginfo .mdebug .comment .note .pdr .options .MIPS.options
 strip-flags	= $(addprefix --remove-section=,$(drop-sections))
 
+VMLINUX = vmlinux
+
 all: vmlinux.ecoff vmlinux.srec addinitrd
 
-vmlinux.ecoff:	$(obj)/elf2ecoff vmlinux
-	$(obj)/elf2ecoff vmlinux vmlinux.ecoff $(E2EFLAGS)
+vmlinux.ecoff: $(obj)/elf2ecoff $(VMLINUX)
+	$(obj)/elf2ecoff $(VMLINUX) vmlinux.ecoff $(E2EFLAGS)
 
 $(obj)/elf2ecoff: $(obj)/elf2ecoff.c
 	$(HOSTCC) -o $@ $^
 
-vmlinux.srec:   vmlinux
-	$(OBJCOPY) -S -O srec $(strip-flags) vmlinux $(obj)/vmlinux.srec
+vmlinux.srec: $(VMLINUX)
+	$(OBJCOPY) -S -O srec $(strip-flags) $(VMLINUX) $(obj)/vmlinux.srec
 
 $(obj)/addinitrd: $(obj)/addinitrd.c
 	$(HOSTCC) -o $@ $^
 
 archhelp:
 	@echo	'* vmlinux.ecoff	- ECOFF boot image'
+	@echo	'* vmlinux.srec		- SREC boot image'
 
 clean-files += addinitrd \
 	       elf2ecoff \
 	       vmlinux.ecoff \
-	       vmlinux.srec \
-	       zImage.tmp \
-	       zImage
+	       vmlinux.srec
diff -up --recursive --new-file linux-mips-2.6.9-rc2-20040920.macro/arch/mips/kernel/vmlinux.lds.S linux-mips-2.6.9-rc2-20040920/arch/mips/kernel/vmlinux.lds.S
--- linux-mips-2.6.9-rc2-20040920.macro/arch/mips/kernel/vmlinux.lds.S	2004-09-20 03:58:10.000000000 +0000
+++ linux-mips-2.6.9-rc2-20040920/arch/mips/kernel/vmlinux.lds.S	2004-10-17 22:48:01.000000000 +0000
@@ -87,6 +87,8 @@ SECTIONS
   __init_begin = .;
   /* /DISCARD/ doesn't work for .reginfo */
   .reginfo : { *(.reginfo) }
+  .options : { *(.options) }
+  .MIPS.options : { *(.MIPS.options) }
   .init.text : {
 	_sinittext = .;
 	*(.init.text)
diff -up --recursive --new-file linux-mips-2.6.9-rc2-20040920.macro/include/asm-mips/stackframe.h linux-mips-2.6.9-rc2-20040920/include/asm-mips/stackframe.h
--- linux-mips-2.6.9-rc2-20040920.macro/include/asm-mips/stackframe.h	2004-05-28 03:57:55.000000000 +0000
+++ linux-mips-2.6.9-rc2-20040920/include/asm-mips/stackframe.h	2004-10-18 00:46:31.000000000 +0000
@@ -68,7 +68,7 @@
 		MFC0	k1, CP0_CONTEXT
 		dsra	k1, 23
 		lui	k0, %hi(pgd_current)
-		daddiu	k0, %lo(pgd_current)
+		addiu	k0, %lo(pgd_current)
 		dsubu	k1, k0
 		lui	k0, %hi(kernelsp)
 		daddu	k1, k0
