Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Sep 2010 03:29:40 +0200 (CEST)
Received: from mail-iw0-f177.google.com ([209.85.214.177]:46989 "EHLO
        mail-iw0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491076Ab0IVB3d (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Sep 2010 03:29:33 +0200
Received: by iwn36 with SMTP id 36so57563iwn.36
        for <multiple recipients>; Tue, 21 Sep 2010 18:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:mime-version:content-type
         :content-transfer-encoding;
        bh=sXrpddjXKUf3EI6mXmhMaveVKLD4uMLo7XVowWf2r6k=;
        b=qw6NdTg4AWR4kRYAPZbL/KHVxSo+q8vSydIbCom4hFynMGtZGcpGGPFD4aTuwmhn7h
         i45N6Y2W80PYj6rNF6178NsSI8t7mAXrDsq+DpEnZAbNsiswl/zNzpLWD8OjboRMS8iP
         GHfeNCXH6pTANV8y1n9heOAuyP8URU+RrQ5Dc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=x3SJTe5eRF059phDhR/qCWmNjVTCRh8lqFVUtVaN25d03BLknlt/ea92AgwKPdgzR0
         hyLZJoPI4FcvJQj/hOBGNVGouDyjt38shs8Qdc7Sqex2aTxHtrgoKvNsU16YFVwh+0Fr
         0fmu0LYrINiqEcjO/wD4/8WV/rM4jLj+cECaM=
Received: by 10.231.30.76 with SMTP id t12mr12862909ibc.161.1285118969626;
        Tue, 21 Sep 2010 18:29:29 -0700 (PDT)
Received: from localhost.localdomain ([76.91.45.220])
        by mx.google.com with ESMTPS id i6sm9807344iba.8.2010.09.21.18.29.24
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 21 Sep 2010 18:29:28 -0700 (PDT)
From:   "Justin P. Mattock" <justinmattock@gmail.com>
To:     trivial@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-m32r@ml.linux-m32r.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-laptop@vger.kernel.org,
        "Justin P. Mattock" <justinmattock@gmail.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>,
        Finn Thain <fthain@telegraphics.com.au>,
        Randy Dunlap <rdunlap@xenotime.net>
Subject: =?UTF-8?q?=5BPATCH=201/2=20v3=5DUpdate=20broken=20web=20addresses=2E?=
Date:   Tue, 21 Sep 2010 18:29:16 -0700
Message-Id: <1285118957-24965-1-git-send-email-justinmattock@gmail.com>
X-Mailer: git-send-email 1.7.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 27781
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinmattock@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 16850

Below is an update from the original, with changes to the broken web addresses and removal of 
archive.org and moved to a seperate patch for you guys to decide if you want to use this and/or
just leave the old url in and leave it at that..
Please dont apply this to anything just comments and fixes for now,
then when the time is right, I can bunch everything all into one big patch.
 
Signed-off-by: Justin P. Mattock <justinmattock@gmail.com>
Cc: Maciej W. Rozycki <macro@linux-mips.org>
Cc: Finn Thain <fthain@telegraphics.com.au>
Cc: Randy Dunlap <rdunlap@xenotime.net>

---
 arch/arm/Kconfig                         |    4 ++--
 arch/arm/common/icst.c                   |    2 +-
 arch/arm/include/asm/hardware/icst.h     |    2 +-
 arch/arm/mach-at91/Kconfig               |    6 +++---
 arch/arm/mach-omap1/Kconfig              |    2 +-
 arch/arm/mach-pxa/am200epd.c             |    2 +-
 arch/arm/mach-pxa/am300epd.c             |    2 +-
 arch/arm/mach-s3c2440/mach-at2440evb.c   |    2 +-
 arch/arm/mach-sa1100/Kconfig             |    6 +++---
 arch/arm/mach-sa1100/cpu-sa1100.c        |    2 +-
 arch/arm/mm/Kconfig                      |    2 +-
 arch/arm/mm/proc-xscale.S                |    2 +-
 arch/arm/nwfpe/milieu.h                  |    4 ++--
 arch/arm/nwfpe/softfloat-macros          |    4 ++--
 arch/arm/nwfpe/softfloat-specialize      |    4 ++--
 arch/arm/nwfpe/softfloat.c               |    4 ++--
 arch/arm/nwfpe/softfloat.h               |    4 ++--
 arch/arm/plat-samsung/include/plat/adc.h |    2 +-
 arch/avr32/Kconfig                       |    2 +-
 arch/h8300/Kconfig.cpu                   |   12 ++++++------
 arch/h8300/README                        |    6 +++---
 arch/m32r/Kconfig                        |    2 +-
 arch/m68k/mac/macboing.c                 |    3 ++-
 arch/m68k/q40/README                     |    2 +-
 arch/mips/Kconfig                        |   12 ++++++++----
 arch/mips/math-emu/cp1emu.c              |    1 -
 arch/mips/math-emu/dp_add.c              |    1 -
 arch/mips/math-emu/dp_cmp.c              |    1 -
 arch/mips/math-emu/dp_div.c              |    1 -
 arch/mips/math-emu/dp_fint.c             |    1 -
 arch/mips/math-emu/dp_flong.c            |    1 -
 arch/mips/math-emu/dp_frexp.c            |    1 -
 arch/mips/math-emu/dp_fsp.c              |    1 -
 arch/mips/math-emu/dp_logb.c             |    1 -
 arch/mips/math-emu/dp_modf.c             |    1 -
 arch/mips/math-emu/dp_mul.c              |    1 -
 arch/mips/math-emu/dp_scalb.c            |    1 -
 arch/mips/math-emu/dp_simple.c           |    1 -
 arch/mips/math-emu/dp_sqrt.c             |    1 -
 arch/mips/math-emu/dp_sub.c              |    1 -
 arch/mips/math-emu/dp_tint.c             |    1 -
 arch/mips/math-emu/dp_tlong.c            |    1 -
 arch/mips/math-emu/ieee754.c             |    1 -
 arch/mips/math-emu/ieee754.h             |    1 -
 arch/mips/math-emu/ieee754d.c            |    1 -
 arch/mips/math-emu/ieee754dp.c           |    1 -
 arch/mips/math-emu/ieee754dp.h           |    1 -
 arch/mips/math-emu/ieee754int.h          |    1 -
 arch/mips/math-emu/ieee754m.c            |    1 -
 arch/mips/math-emu/ieee754sp.c           |    1 -
 arch/mips/math-emu/ieee754sp.h           |    1 -
 arch/mips/math-emu/ieee754xcpt.c         |    1 -
 arch/mips/math-emu/sp_add.c              |    1 -
 arch/mips/math-emu/sp_cmp.c              |    1 -
 arch/mips/math-emu/sp_div.c              |    1 -
 arch/mips/math-emu/sp_fdp.c              |    1 -
 arch/mips/math-emu/sp_fint.c             |    1 -
 arch/mips/math-emu/sp_flong.c            |    1 -
 arch/mips/math-emu/sp_frexp.c            |    1 -
 arch/mips/math-emu/sp_logb.c             |    1 -
 arch/mips/math-emu/sp_modf.c             |    1 -
 arch/mips/math-emu/sp_mul.c              |    1 -
 arch/mips/math-emu/sp_scalb.c            |    1 -
 arch/mips/math-emu/sp_simple.c           |    1 -
 arch/mips/math-emu/sp_sqrt.c             |    1 -
 arch/mips/math-emu/sp_sub.c              |    1 -
 arch/mips/math-emu/sp_tint.c             |    1 -
 arch/mips/math-emu/sp_tlong.c            |    1 -
 arch/powerpc/include/asm/hydra.h         |    2 +-
 arch/x86/kernel/apm_32.c                 |    4 ++--
 arch/x86/kernel/microcode_core.c         |    2 +-
 arch/x86/kernel/microcode_intel.c        |    2 +-
 72 files changed, 55 insertions(+), 93 deletions(-)

diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
index 553b7cf..c562c68 100644
--- a/arch/arm/Kconfig
+++ b/arch/arm/Kconfig
@@ -647,7 +647,7 @@ config ARCH_S3C2410
 	select HAVE_S3C2410_I2C
 	help
 	  Samsung S3C2410X CPU based systems, such as the Simtec Electronics
-	  BAST (<http://www.simtec.co.uk/products/EB110ITX/>), the IPAQ 1940 or
+	  BAST (<http://www.simtec.co.uk/products/EB110ATX/>), the IPAQ 1940 or
 	  the Samsung SMDK2410 development board (and derivatives).
 
 	  Note, the S3C2416 and the S3C2450 are so close that they even share
@@ -1162,7 +1162,7 @@ config SMP
 
 	  See also <file:Documentation/i386/IO-APIC.txt>,
 	  <file:Documentation/nmi_watchdog.txt> and the SMP-HOWTO available at
-	  <http://www.linuxdoc.org/docs.html#howto>.
+	  <http://tldp.org/HOWTO/SMP-HOWTO.html>.
 
 	  If you don't know what to do here, say N.
 
diff --git a/arch/arm/common/icst.c b/arch/arm/common/icst.c
index 9a7f09c..2dc6da70 100644
--- a/arch/arm/common/icst.c
+++ b/arch/arm/common/icst.c
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  *
  *  Support functions for calculating clocks/divisors for the ICST307
- *  clock generators.  See http://www.icst.com/ for more information
+ *  clock generators.  See http://www.idt.com/ for more information
  *  on these devices.
  *
  *  This is an almost identical implementation to the ICST525 clock generator.
diff --git a/arch/arm/include/asm/hardware/icst.h b/arch/arm/include/asm/hardware/icst.h
index 10382a3..794220b 100644
--- a/arch/arm/include/asm/hardware/icst.h
+++ b/arch/arm/include/asm/hardware/icst.h
@@ -8,7 +8,7 @@
  * published by the Free Software Foundation.
  *
  *  Support functions for calculating clocks/divisors for the ICST
- *  clock generators.  See http://www.icst.com/ for more information
+ *  clock generators.  See http://www.idt.com/ for more information
  *  on these devices.
  */
 #ifndef ASMARM_HARDWARE_ICST_H
diff --git a/arch/arm/mach-at91/Kconfig b/arch/arm/mach-at91/Kconfig
index 939bccd..c0bcfb8 100644
--- a/arch/arm/mach-at91/Kconfig
+++ b/arch/arm/mach-at91/Kconfig
@@ -105,7 +105,7 @@ config MACH_ONEARM
 	bool "Ajeco 1ARM Single Board Computer"
 	help
 	  Select this if you are using Ajeco's 1ARM Single Board Computer.
-	  <http://www.ajeco.fi/products.htm>
+	  <http://www.ajeco.fi/index.php?language=fin>
 
 config ARCH_AT91RM9200DK
 	bool "Atmel AT91RM9200-DK Development board"
@@ -137,7 +137,7 @@ config MACH_CARMEVA
 	bool "Conitec ARM&EVA"
 	help
 	  Select this if you are using Conitec's AT91RM9200-MCU-Module.
-	  <http://www.conitec.net/english/linuxboard.htm>
+	  <http://www.conitec.net/english/linuxboard.php>
 
 config MACH_ATEB9200
 	bool "Embest ATEB9200"
@@ -149,7 +149,7 @@ config MACH_KB9200
 	bool "KwikByte KB920x"
 	help
 	  Select this if you are using KwikByte's KB920x board.
-	  <http://kwikbyte.com/KB9202_description_new.htm>
+	  <http://www.kwikbyte.com/KB9202.html>
 
 config MACH_PICOTUX2XX
 	bool "picotux 200"
diff --git a/arch/arm/mach-omap1/Kconfig b/arch/arm/mach-omap1/Kconfig
index 3b02d3b..5f64963 100644
--- a/arch/arm/mach-omap1/Kconfig
+++ b/arch/arm/mach-omap1/Kconfig
@@ -128,7 +128,7 @@ config MACH_OMAP_PALMTT
 	help
 	  Support for the Palm Tungsten|T PDA. To boot the kernel, you'll
 	  need a PalmOS compatible bootloader (Garux); check out
-	  http://www.hackndev.com/palm/tt/ for more information.
+	  http://garux.sourceforge.net/ for more information.
 	  Say Y here if you have this PDA model, say N otherwise.
 
 config MACH_SX1
diff --git a/arch/arm/mach-pxa/am200epd.c b/arch/arm/mach-pxa/am200epd.c
index 3499fad..0fd6a08 100644
--- a/arch/arm/mach-pxa/am200epd.c
+++ b/arch/arm/mach-pxa/am200epd.c
@@ -10,7 +10,7 @@
  * Layout is based on skeletonfb.c by James Simmons and Geert Uytterhoeven.
  *
  * This work was made possible by help and equipment support from E-Ink
- * Corporation. http://support.eink.com/community
+ * Corporation. http://www.support.eink.com/
  *
  * This driver is written to be used with the Metronome display controller.
  * on the AM200 EPD prototype kit/development kit with an E-Ink 800x600
diff --git a/arch/arm/mach-pxa/am300epd.c b/arch/arm/mach-pxa/am300epd.c
index 993d75e..01aa021 100644
--- a/arch/arm/mach-pxa/am300epd.c
+++ b/arch/arm/mach-pxa/am300epd.c
@@ -8,7 +8,7 @@
  * more details.
  *
  * This work was made possible by help and equipment support from E-Ink
- * Corporation. http://support.eink.com/community
+ * Corporation. http://www.support.eink.com/
  *
  * This driver is written to be used with the Broadsheet display controller.
  * on the AM300 EPD prototype kit/development kit with an E-Ink 800x600
diff --git a/arch/arm/mach-s3c2440/mach-at2440evb.c b/arch/arm/mach-s3c2440/mach-at2440evb.c
index 8472579..67b6ba0 100644
--- a/arch/arm/mach-s3c2440/mach-at2440evb.c
+++ b/arch/arm/mach-s3c2440/mach-at2440evb.c
@@ -5,7 +5,7 @@
  *      and modifications by SBZ <sbz@spgui.org> and
  *      Weibing <http://weibing.blogbus.com>
  *
- * For product information, visit http://www.arm9e.com/
+ * For product information, visit http://www.arm.com/
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
diff --git a/arch/arm/mach-sa1100/Kconfig b/arch/arm/mach-sa1100/Kconfig
index fd4c52b..5da8c35 100644
--- a/arch/arm/mach-sa1100/Kconfig
+++ b/arch/arm/mach-sa1100/Kconfig
@@ -90,8 +90,8 @@ config SA1100_JORNADA720
 	# FIXME: select CPU_FREQ_SA11x0
 	help
 	  Say Y here if you want to build a kernel for the HP Jornada 720
-	  handheld computer.  See <http://www.hp.com/jornada/products/720>
-	  for details.
+	  handheld computer.  See 
+	  <http://h10025.www1.hp.com/ewfrf/wc/product?product=61677&cc=us&lc=en&dlc=en&product=61677#> 
 
 config SA1100_JORNADA720_SSP
 	bool "HP Jornada 720 Extended SSP driver"
@@ -145,7 +145,7 @@ config SA1100_SIMPAD
 	  FLASH. The SL4 version got 64 MB RAM and 32 MB FLASH and a
 	  PCMCIA-Slot. The version for the Germany Telecom (DTAG) is the same
 	  like CL4 in additional it has a PCMCIA-Slot. For more information
-	  visit <http://www.my-siemens.com/> or <http://www.siemens.ch/>.
+	  visit <http://www.usa.siemens.com/> or <http://www.siemens.ch/>.
 
 config SA1100_SSP
 	tristate "Generic PIO SSP"
diff --git a/arch/arm/mach-sa1100/cpu-sa1100.c b/arch/arm/mach-sa1100/cpu-sa1100.c
index ef81787..c0a13ef 100644
--- a/arch/arm/mach-sa1100/cpu-sa1100.c
+++ b/arch/arm/mach-sa1100/cpu-sa1100.c
@@ -13,7 +13,7 @@
  * This software has been developed while working on the LART
  * computing board (http://www.lartmaker.nl/), which is
  * sponsored by the Mobile Multi-media Communications
- * (http://www.mmc.tudelft.nl/) and Ubiquitous Communications
+ * (http://www.mobimedia.org/) and Ubiquitous Communications
  * (http://www.ubicom.tudelft.nl/) projects.
  *
  * The authors can be reached at:
diff --git a/arch/arm/mm/Kconfig b/arch/arm/mm/Kconfig
index a0a2928..c1a68af 100644
--- a/arch/arm/mm/Kconfig
+++ b/arch/arm/mm/Kconfig
@@ -314,7 +314,7 @@ config CPU_SA110
 	  The Intel StrongARM(R) SA-110 is a 32-bit microprocessor and
 	  is available at five speeds ranging from 100 MHz to 233 MHz.
 	  More information is available at
-	  <http://developer.intel.com/design/strong/sa110.htm>.
+	  <http://www.renan.org/ARM/doc/sa110.pdf>.
 
 	  Say Y if you want support for the SA-110 processor.
 	  Otherwise, say N.
diff --git a/arch/arm/mm/proc-xscale.S b/arch/arm/mm/proc-xscale.S
index 1407597..25d03fa 100644
--- a/arch/arm/mm/proc-xscale.S
+++ b/arch/arm/mm/proc-xscale.S
@@ -418,7 +418,7 @@ ENTRY(xscale_cache_fns)
  *
  * See erratum #25 of "Intel 80200 Processor Specification Update",
  * revision January 22, 2003, available at:
- *     http://www.intel.com/design/iio/specupdt/273415.htm
+ *     http://www.intel.com/design/support/faq/io_processors/iq80310_chipset.htm
  */
 ENTRY(xscale_80200_A0_A1_cache_fns)
 	.long	xscale_flush_kern_cache_all
diff --git a/arch/arm/nwfpe/milieu.h b/arch/arm/nwfpe/milieu.h
index a3892ab..09a4f2d 100644
--- a/arch/arm/nwfpe/milieu.h
+++ b/arch/arm/nwfpe/milieu.h
@@ -12,8 +12,8 @@ National Science Foundation under grant MIP-9311980.  The original version
 of this code was written as part of a project to build a fixed-point vector
 processor in collaboration with the University of California at Berkeley,
 overseen by Profs. Nelson Morgan and John Wawrzynek.  More information
-is available through the Web page `http://HTTP.CS.Berkeley.EDU/~jhauser/
-arithmetic/softfloat.html'.
+is available through the Web page
+http://www.jhauser.us/arithmetic/SoftFloat-2b/SoftFloat-source.txt
 
 THIS SOFTWARE IS DISTRIBUTED AS IS, FOR FREE.  Although reasonable effort
 has been made to avoid it, THIS SOFTWARE MAY CONTAIN FAULTS THAT WILL AT
diff --git a/arch/arm/nwfpe/softfloat-macros b/arch/arm/nwfpe/softfloat-macros
index 5a060f9..cf2a617 100644
--- a/arch/arm/nwfpe/softfloat-macros
+++ b/arch/arm/nwfpe/softfloat-macros
@@ -12,8 +12,8 @@ National Science Foundation under grant MIP-9311980.  The original version
 of this code was written as part of a project to build a fixed-point vector
 processor in collaboration with the University of California at Berkeley,
 overseen by Profs. Nelson Morgan and John Wawrzynek.  More information
-is available through the web page `http://HTTP.CS.Berkeley.EDU/~jhauser/
-arithmetic/softfloat.html'.
+is available through the web page
+http://www.jhauser.us/arithmetic/SoftFloat-2b/SoftFloat-source.txt
 
 THIS SOFTWARE IS DISTRIBUTED AS IS, FOR FREE.  Although reasonable effort
 has been made to avoid it, THIS SOFTWARE MAY CONTAIN FAULTS THAT WILL AT
diff --git a/arch/arm/nwfpe/softfloat-specialize b/arch/arm/nwfpe/softfloat-specialize
index d4a4c8e..679a026 100644
--- a/arch/arm/nwfpe/softfloat-specialize
+++ b/arch/arm/nwfpe/softfloat-specialize
@@ -12,8 +12,8 @@ National Science Foundation under grant MIP-9311980.  The original version
 of this code was written as part of a project to build a fixed-point vector
 processor in collaboration with the University of California at Berkeley,
 overseen by Profs. Nelson Morgan and John Wawrzynek.  More information
-is available through the Web page `http://HTTP.CS.Berkeley.EDU/~jhauser/
-arithmetic/softfloat.html'.
+is available through the Web page
+http://www.jhauser.us/arithmetic/SoftFloat-2b/SoftFloat-source.txt
 
 THIS SOFTWARE IS DISTRIBUTED AS IS, FOR FREE.  Although reasonable effort
 has been made to avoid it, THIS SOFTWARE MAY CONTAIN FAULTS THAT WILL AT
diff --git a/arch/arm/nwfpe/softfloat.c b/arch/arm/nwfpe/softfloat.c
index 0f9656e..ffa6b43 100644
--- a/arch/arm/nwfpe/softfloat.c
+++ b/arch/arm/nwfpe/softfloat.c
@@ -11,8 +11,8 @@ National Science Foundation under grant MIP-9311980.  The original version
 of this code was written as part of a project to build a fixed-point vector
 processor in collaboration with the University of California at Berkeley,
 overseen by Profs. Nelson Morgan and John Wawrzynek.  More information
-is available through the web page `http://HTTP.CS.Berkeley.EDU/~jhauser/
-arithmetic/softfloat.html'.
+is available through the web page
+http://www.jhauser.us/arithmetic/SoftFloat-2b/SoftFloat-source.txt
 
 THIS SOFTWARE IS DISTRIBUTED AS IS, FOR FREE.  Although reasonable effort
 has been made to avoid it, THIS SOFTWARE MAY CONTAIN FAULTS THAT WILL AT
diff --git a/arch/arm/nwfpe/softfloat.h b/arch/arm/nwfpe/softfloat.h
index 13e479c..df4d243 100644
--- a/arch/arm/nwfpe/softfloat.h
+++ b/arch/arm/nwfpe/softfloat.h
@@ -12,8 +12,8 @@ National Science Foundation under grant MIP-9311980.  The original version
 of this code was written as part of a project to build a fixed-point vector
 processor in collaboration with the University of California at Berkeley,
 overseen by Profs. Nelson Morgan and John Wawrzynek.  More information
-is available through the Web page `http://HTTP.CS.Berkeley.EDU/~jhauser/
-arithmetic/softfloat.html'.
+is available through the Web page
+http://www.jhauser.us/arithmetic/SoftFloat-2b/SoftFloat-source.txt
 
 THIS SOFTWARE IS DISTRIBUTED AS IS, FOR FREE.  Although reasonable effort
 has been made to avoid it, THIS SOFTWARE MAY CONTAIN FAULTS THAT WILL AT
diff --git a/arch/arm/plat-samsung/include/plat/adc.h b/arch/arm/plat-samsung/include/plat/adc.h
index e8382c7..b258a08 100644
--- a/arch/arm/plat-samsung/include/plat/adc.h
+++ b/arch/arm/plat-samsung/include/plat/adc.h
@@ -1,7 +1,7 @@
 /* arch/arm/plat-samsung/include/plat/adc.h
  *
  * Copyright (c) 2008 Simtec Electronics
- *	http://armlinux.simnte.co.uk/
+ *	http://armlinux.simtec.co.uk/	
  *	Ben Dooks <ben@simtec.co.uk>
  *
  * S3C ADC driver information
diff --git a/arch/avr32/Kconfig b/arch/avr32/Kconfig
index f515727..787dcba 100644
--- a/arch/avr32/Kconfig
+++ b/arch/avr32/Kconfig
@@ -145,7 +145,7 @@ config BOARD_HAMMERHEAD
 	  will cover even the most exceptional need of memory bandwidth. Together with the onboard
 	  video decoder the board is ready for video processing.
 
-	  For more information see: http://www.miromico.com/hammerhead
+	  For more information see: http://www.hammerhead.ch/index.php/getting-started.html 
 
 config BOARD_FAVR_32
 	bool "Favr-32 LCD-board"
diff --git a/arch/h8300/Kconfig.cpu b/arch/h8300/Kconfig.cpu
index 6e2ecff..8de966a 100644
--- a/arch/h8300/Kconfig.cpu
+++ b/arch/h8300/Kconfig.cpu
@@ -17,7 +17,7 @@ config H8300H_AKI3068NET
 	help
 	  AKI-H8/3068F / AKI-H8/3069F Flashmicom LAN Board Support
 	  More Information. (Japanese Only)
-	  <http://akizukidensi.com/catalog/h8.html>
+	  <http://akizukidenshi.com/catalog/default.aspx>
 	  AE-3068/69 Evaluation Board Support
 	  More Information.
 	  <http://www.microtronique.com/ae3069lan.htm>
@@ -28,7 +28,7 @@ config H8300H_H8MAX
 	help
 	  H8MAX Evaluation Board Support
 	  More Information. (Japanese Only)
-	  <http://strawberry-linux.com/h8/index.html>
+	  <http://strawberry-linux.com/h8/>
 
 config H8300H_SIM
 	bool "H8/300H Simulator"
@@ -36,7 +36,7 @@ config H8300H_SIM
 	help
 	  GDB Simulator Support
 	  More Information.
-	  arch/h8300/Doc/simulator.txt
+	  <http://sourceware.org/sid/> 
 
 config H8S_GENERIC
 	bool "H8S Generic"
@@ -49,15 +49,15 @@ config H8S_EDOSK2674
 	help
 	  Renesas EDOSK-2674 Evaluation Board Support
 	  More Information.
-	  <http://www.azpower.com/H8-uClinux/index.html>
- 	  <http://www.eu.renesas.com/tools/edk/support/edosk2674.html>
+	  <http://h8-uclinux.sourceforge.net/>
+ 	  <http://www.renesas.eu/products/tools/introductory_evaluation_tools/evaluation_development_os_kits/edosk2674r/edosk2674r_software_tools_root.jsp>
 
 config H8S_SIM
 	bool "H8S Simulator"
 	help
 	  GDB Simulator Support
 	  More Information.
-	  arch/h8300/Doc/simulator.txt
+	  <http://sourceware.org/sid/> 
 
 endchoice
 
diff --git a/arch/h8300/README b/arch/h8300/README
index 2fd6f6d..7dac451 100644
--- a/arch/h8300/README
+++ b/arch/h8300/README
@@ -14,11 +14,11 @@ H8/300H and H8S
   Akizuki Denshi Tsusho Ltd. <http://www.akizuki.ne.jp> (Japanese Only)
 
 3.H8MAX 
-  see http://ip-sol.jp/h8max/ (Japanese Only)
+  see http://strawberry-linux.com/h8/h8max.html (Japanese Only)
 
 4.EDOSK2674
-  see http://www.eu.renesas.com/products/mpumcu/tool/edk/support/edosk2674.html
-      http://www.azpower.com/H8-uClinux/
+  see http://www.uclinux.org/pub/uClinux/ports/h8/HITACHI-EDOSK2674-HOWTO 
+      http://h8-uclinux.sourceforge.net/
 
 * Toolchain Version
 gcc-3.1 or higher and patch
diff --git a/arch/m32r/Kconfig b/arch/m32r/Kconfig
index 836abbb..3867fd2 100644
--- a/arch/m32r/Kconfig
+++ b/arch/m32r/Kconfig
@@ -315,7 +315,7 @@ config SMP
 	  Management" code will be disabled if you say Y here.
 
 	  See also the SMP-HOWTO available at
-	  <http://www.linuxdoc.org/docs.html#howto>.
+	  <http://tldp.org/HOWTO/SMP-HOWTO.html>.
 
 	  If you don't know what to do here, say N.
 
diff --git a/arch/m68k/mac/macboing.c b/arch/m68k/mac/macboing.c
index 8f06408..234d9ee 100644
--- a/arch/m68k/mac/macboing.c
+++ b/arch/m68k/mac/macboing.c
@@ -114,7 +114,8 @@ static void mac_init_asc( void )
 			 *   16-bit I/O functionality.  The PowerBook 500 series computers
 			 *   support 16-bit stereo output, but only mono input."
 			 *
-			 *   http://til.info.apple.com/techinfo.nsf/artnum/n16405
+			 *   Article number 16405:
+			 *   http://support.apple.com/kb/TA32601 
 			 *
 			 * --David Kilzer
 			 */
diff --git a/arch/m68k/q40/README b/arch/m68k/q40/README
index 6bdbf48..92806c0 100644
--- a/arch/m68k/q40/README
+++ b/arch/m68k/q40/README
@@ -3,7 +3,7 @@ Linux for the Q40
 
 You may try http://www.geocities.com/SiliconValley/Bay/2602/ for
 some up to date information. Booter and other tools will be also
-available from this place or ftp.uni-erlangen.de/linux/680x0/q40/
+available from this place or http://www.linux-m68k.org/mail.html 
 and mirrors.
 
 Hints to documentation usually refer to the linux source tree in
diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 3ad59dd..4606248 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2175,10 +2175,14 @@ config TC
 	bool "TURBOchannel support"
 	depends on MACH_DECSTATION
 	help
-	  TurboChannel is a DEC (now Compaq (now HP)) bus for Alpha and MIPS
-	  processors.  Documentation on writing device drivers for TurboChannel
-	  is available at:
-	  <http://www.cs.arizona.edu/computer.help/policy/DIGITAL_unix/AA-PS3HD-TET1_html/TITLE.html>.
+	  TURBOchannel is a DEC (now Compaq (now HP)) bus for Alpha and MIPS
+	  processors.  TURBOchannel programming specifications are available
+	  at:
+	  <ftp://ftp.hp.com/pub/alphaserver/archive/triadd/>
+	  and:
+	  <http://www.computer-refuge.org/classiccmp/ftp.digital.com/pub/DEC/TriAdd/>
+	  Linux driver support status is documented at:
+	  <http://www.linux-mips.org/wiki/DECstation>
 
 #config ACCESSBUS
 #	bool "Access.Bus support"
diff --git a/arch/mips/math-emu/cp1emu.c b/arch/mips/math-emu/cp1emu.c
index 47842b7..ec3faa4 100644
--- a/arch/mips/math-emu/cp1emu.c
+++ b/arch/mips/math-emu/cp1emu.c
@@ -3,7 +3,6 @@
  *
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * Kevin D. Kissell, kevink@mips.com and Carsten Langgaard, carstenl@mips.com
  * Copyright (C) 2000  MIPS Technologies, Inc.
diff --git a/arch/mips/math-emu/dp_add.c b/arch/mips/math-emu/dp_add.c
index bcf73bb..b422fca 100644
--- a/arch/mips/math-emu/dp_add.c
+++ b/arch/mips/math-emu/dp_add.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/dp_cmp.c b/arch/mips/math-emu/dp_cmp.c
index 8ab4f32..0f32486 100644
--- a/arch/mips/math-emu/dp_cmp.c
+++ b/arch/mips/math-emu/dp_cmp.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/dp_div.c b/arch/mips/math-emu/dp_div.c
index 6acedce..a1bce1b 100644
--- a/arch/mips/math-emu/dp_div.c
+++ b/arch/mips/math-emu/dp_div.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/dp_fint.c b/arch/mips/math-emu/dp_fint.c
index 39a71de1..8857128 100644
--- a/arch/mips/math-emu/dp_fint.c
+++ b/arch/mips/math-emu/dp_fint.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/dp_flong.c b/arch/mips/math-emu/dp_flong.c
index f08f223..14fc01e 100644
--- a/arch/mips/math-emu/dp_flong.c
+++ b/arch/mips/math-emu/dp_flong.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/dp_frexp.c b/arch/mips/math-emu/dp_frexp.c
index e650cb1..cb15a5e 100644
--- a/arch/mips/math-emu/dp_frexp.c
+++ b/arch/mips/math-emu/dp_frexp.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/dp_fsp.c b/arch/mips/math-emu/dp_fsp.c
index 494d19a..1dfbd92 100644
--- a/arch/mips/math-emu/dp_fsp.c
+++ b/arch/mips/math-emu/dp_fsp.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/dp_logb.c b/arch/mips/math-emu/dp_logb.c
index 6033886..151127e 100644
--- a/arch/mips/math-emu/dp_logb.c
+++ b/arch/mips/math-emu/dp_logb.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/dp_modf.c b/arch/mips/math-emu/dp_modf.c
index a8570e5..b01f9cf 100644
--- a/arch/mips/math-emu/dp_modf.c
+++ b/arch/mips/math-emu/dp_modf.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/dp_mul.c b/arch/mips/math-emu/dp_mul.c
index 48908a8..aa566e7 100644
--- a/arch/mips/math-emu/dp_mul.c
+++ b/arch/mips/math-emu/dp_mul.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/dp_scalb.c b/arch/mips/math-emu/dp_scalb.c
index b84e633..6f5df43 100644
--- a/arch/mips/math-emu/dp_scalb.c
+++ b/arch/mips/math-emu/dp_scalb.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/dp_simple.c b/arch/mips/math-emu/dp_simple.c
index b909742..79ce267 100644
--- a/arch/mips/math-emu/dp_simple.c
+++ b/arch/mips/math-emu/dp_simple.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/dp_sqrt.c b/arch/mips/math-emu/dp_sqrt.c
index 032328c..a2a51b8 100644
--- a/arch/mips/math-emu/dp_sqrt.c
+++ b/arch/mips/math-emu/dp_sqrt.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/dp_sub.c b/arch/mips/math-emu/dp_sub.c
index a2127d6..0de098c 100644
--- a/arch/mips/math-emu/dp_sub.c
+++ b/arch/mips/math-emu/dp_sub.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/dp_tint.c b/arch/mips/math-emu/dp_tint.c
index 2447862..0ebe859 100644
--- a/arch/mips/math-emu/dp_tint.c
+++ b/arch/mips/math-emu/dp_tint.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/dp_tlong.c b/arch/mips/math-emu/dp_tlong.c
index 0f07ec2..133ce2b 100644
--- a/arch/mips/math-emu/dp_tlong.c
+++ b/arch/mips/math-emu/dp_tlong.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/ieee754.c b/arch/mips/math-emu/ieee754.c
index cb1b682..30554e1 100644
--- a/arch/mips/math-emu/ieee754.c
+++ b/arch/mips/math-emu/ieee754.c
@@ -9,7 +9,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/ieee754.h b/arch/mips/math-emu/ieee754.h
index dd91733..22796e0 100644
--- a/arch/mips/math-emu/ieee754.h
+++ b/arch/mips/math-emu/ieee754.h
@@ -1,7 +1,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
diff --git a/arch/mips/math-emu/ieee754d.c b/arch/mips/math-emu/ieee754d.c
index a032533..9599bdd 100644
--- a/arch/mips/math-emu/ieee754d.c
+++ b/arch/mips/math-emu/ieee754d.c
@@ -4,7 +4,6 @@
  * MIPS floating point support
  *
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  *  This program is free software; you can distribute it and/or modify it
  *  under the terms of the GNU General Public License (Version 2) as
diff --git a/arch/mips/math-emu/ieee754dp.c b/arch/mips/math-emu/ieee754dp.c
index 2f22fd7..080b5ca 100644
--- a/arch/mips/math-emu/ieee754dp.c
+++ b/arch/mips/math-emu/ieee754dp.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/ieee754dp.h b/arch/mips/math-emu/ieee754dp.h
index 7627865..f139c72 100644
--- a/arch/mips/math-emu/ieee754dp.h
+++ b/arch/mips/math-emu/ieee754dp.h
@@ -5,7 +5,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/ieee754int.h b/arch/mips/math-emu/ieee754int.h
index 1a846c5..2701d95 100644
--- a/arch/mips/math-emu/ieee754int.h
+++ b/arch/mips/math-emu/ieee754int.h
@@ -5,7 +5,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/ieee754m.c b/arch/mips/math-emu/ieee754m.c
index d66896c..24190f3 100644
--- a/arch/mips/math-emu/ieee754m.c
+++ b/arch/mips/math-emu/ieee754m.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/ieee754sp.c b/arch/mips/math-emu/ieee754sp.c
index a19b721..271d00d 100644
--- a/arch/mips/math-emu/ieee754sp.c
+++ b/arch/mips/math-emu/ieee754sp.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/ieee754sp.h b/arch/mips/math-emu/ieee754sp.h
index d9e3586..754fd54 100644
--- a/arch/mips/math-emu/ieee754sp.h
+++ b/arch/mips/math-emu/ieee754sp.h
@@ -5,7 +5,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/ieee754xcpt.c b/arch/mips/math-emu/ieee754xcpt.c
index e02423a..b99a693 100644
--- a/arch/mips/math-emu/ieee754xcpt.c
+++ b/arch/mips/math-emu/ieee754xcpt.c
@@ -1,7 +1,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/sp_add.c b/arch/mips/math-emu/sp_add.c
index d8c4211..ae1a327 100644
--- a/arch/mips/math-emu/sp_add.c
+++ b/arch/mips/math-emu/sp_add.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/sp_cmp.c b/arch/mips/math-emu/sp_cmp.c
index d3eff6b..716cf37 100644
--- a/arch/mips/math-emu/sp_cmp.c
+++ b/arch/mips/math-emu/sp_cmp.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/sp_div.c b/arch/mips/math-emu/sp_div.c
index 2b437fc..d774792 100644
--- a/arch/mips/math-emu/sp_div.c
+++ b/arch/mips/math-emu/sp_div.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/sp_fdp.c b/arch/mips/math-emu/sp_fdp.c
index 4093723..e1515aa 100644
--- a/arch/mips/math-emu/sp_fdp.c
+++ b/arch/mips/math-emu/sp_fdp.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/sp_fint.c b/arch/mips/math-emu/sp_fint.c
index e88e125..9694d6c 100644
--- a/arch/mips/math-emu/sp_fint.c
+++ b/arch/mips/math-emu/sp_fint.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/sp_flong.c b/arch/mips/math-emu/sp_flong.c
index 26d6919..16a651f 100644
--- a/arch/mips/math-emu/sp_flong.c
+++ b/arch/mips/math-emu/sp_flong.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/sp_frexp.c b/arch/mips/math-emu/sp_frexp.c
index 359c648..5bc993c 100644
--- a/arch/mips/math-emu/sp_frexp.c
+++ b/arch/mips/math-emu/sp_frexp.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/sp_logb.c b/arch/mips/math-emu/sp_logb.c
index 3c33721..9c14e0c 100644
--- a/arch/mips/math-emu/sp_logb.c
+++ b/arch/mips/math-emu/sp_logb.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/sp_modf.c b/arch/mips/math-emu/sp_modf.c
index 7656894..25a0fba 100644
--- a/arch/mips/math-emu/sp_modf.c
+++ b/arch/mips/math-emu/sp_modf.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/sp_mul.c b/arch/mips/math-emu/sp_mul.c
index 3f070f8..c06bb40 100644
--- a/arch/mips/math-emu/sp_mul.c
+++ b/arch/mips/math-emu/sp_mul.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/sp_scalb.c b/arch/mips/math-emu/sp_scalb.c
index 44ceb87..dd76196 100644
--- a/arch/mips/math-emu/sp_scalb.c
+++ b/arch/mips/math-emu/sp_scalb.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/sp_simple.c b/arch/mips/math-emu/sp_simple.c
index 2fd53c9..ae4fcfa 100644
--- a/arch/mips/math-emu/sp_simple.c
+++ b/arch/mips/math-emu/sp_simple.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/sp_sqrt.c b/arch/mips/math-emu/sp_sqrt.c
index 8a934b9..fed2017 100644
--- a/arch/mips/math-emu/sp_sqrt.c
+++ b/arch/mips/math-emu/sp_sqrt.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/sp_sub.c b/arch/mips/math-emu/sp_sub.c
index dbb802c..886ed5b 100644
--- a/arch/mips/math-emu/sp_sub.c
+++ b/arch/mips/math-emu/sp_sub.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/sp_tint.c b/arch/mips/math-emu/sp_tint.c
index 352dc3a..0fe9acc 100644
--- a/arch/mips/math-emu/sp_tint.c
+++ b/arch/mips/math-emu/sp_tint.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/mips/math-emu/sp_tlong.c b/arch/mips/math-emu/sp_tlong.c
index 92cd9c5..d0ca6e2 100644
--- a/arch/mips/math-emu/sp_tlong.c
+++ b/arch/mips/math-emu/sp_tlong.c
@@ -4,7 +4,6 @@
 /*
  * MIPS floating point support
  * Copyright (C) 1994-2000 Algorithmics Ltd.
- * http://www.algor.co.uk
  *
  * ########################################################################
  *
diff --git a/arch/powerpc/include/asm/hydra.h b/arch/powerpc/include/asm/hydra.h
index 1ad4eed..d529a2c 100644
--- a/arch/powerpc/include/asm/hydra.h
+++ b/arch/powerpc/include/asm/hydra.h
@@ -10,7 +10,7 @@
  *
  *	© Copyright 1995 Apple Computer, Inc. All rights reserved.
  *
- *  It's available online from http://chrp.apple.com/MacTech.pdf.
+ *  It's available online from http://www.cpu.lu/~mlan/ftp/MacTech.pdf.
  *  You can obtain paper copies of this book from computer bookstores or by
  *  writing Morgan Kaufmann Publishers, Inc., 340 Pine Street, Sixth Floor, San
  *  Francisco, CA 94104. Reference ISBN 1-55860-393-X.
diff --git a/arch/x86/kernel/apm_32.c b/arch/x86/kernel/apm_32.c
index 4c9c67b..9fed1cc 100644
--- a/arch/x86/kernel/apm_32.c
+++ b/arch/x86/kernel/apm_32.c
@@ -189,8 +189,8 @@
  *   Intel Order Number 241704-001.  Microsoft Part Number 781-110-X01.
  *
  * [This document is available free from Intel by calling 800.628.8686 (fax
- * 916.356.6100) or 800.548.4725; or via anonymous ftp from
- * ftp://ftp.intel.com/pub/IAL/software_specs/apmv11.doc.  It is also
+ * 916.356.6100) or 800.548.4725; or from
+ * http://www.microsoft.com/whdc/archive/amp_12.mspx  It is also
  * available from Microsoft by calling 206.882.8080.]
  *
  * APM 1.2 Reference:
diff --git a/arch/x86/kernel/microcode_core.c b/arch/x86/kernel/microcode_core.c
index fa6551d..b9c5c54 100644
--- a/arch/x86/kernel/microcode_core.c
+++ b/arch/x86/kernel/microcode_core.c
@@ -12,7 +12,7 @@
  *	Software Developer's Manual
  *	Order Number 253668 or free download from:
  *
- *	http://developer.intel.com/design/pentium4/manuals/253668.htm
+ *	http://developer.intel.com/Assets/PDF/manual/253668.pdf	
  *
  *	For more information, go to http://www.urbanmyth.org/microcode
  *
diff --git a/arch/x86/kernel/microcode_intel.c b/arch/x86/kernel/microcode_intel.c
index 3561702..dcb65cc 100644
--- a/arch/x86/kernel/microcode_intel.c
+++ b/arch/x86/kernel/microcode_intel.c
@@ -12,7 +12,7 @@
  *	Software Developer's Manual
  *	Order Number 253668 or free download from:
  *
- *	http://developer.intel.com/design/pentium4/manuals/253668.htm
+ *	http://developer.intel.com/Assets/PDF/manual/253668.pdf	
  *
  *	For more information, go to http://www.urbanmyth.org/microcode
  *
-- 
1.7.2.1
