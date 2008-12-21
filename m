Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Dec 2008 08:29:09 +0000 (GMT)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:46492 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S24126022AbYLUI0a (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sun, 21 Dec 2008 08:26:30 +0000
Received: (qmail 3967 invoked from network); 21 Dec 2008 09:24:59 +0100
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 21 Dec 2008 09:24:59 +0100
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH 08/14] Alchemy: remove cpu_table.
Date:	Sun, 21 Dec 2008 09:26:21 +0100
Message-Id: <f701f25036ff0e654e2bad646e0103b32cb83d34.1229846414.git.mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <ad6889e72585d9fa5bedeb080d6d78d91c9e23c9.1229846414.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
 <caebb02f97491d8e5830438e1a746b0e02fa2c7c.1229846411.git.mano@roarinelk.homelinux.net>
 <80cf5c7a0db39a7230bae7766264acbfc68d200e.1229846412.git.mano@roarinelk.homelinux.net>
 <e6862a9acc480a4f00d0b7ae738e8a355a7e4810.1229846412.git.mano@roarinelk.homelinux.net>
 <ac2064c64b746420a21008fa4e9e7c4ecf048d7a.1229846413.git.mano@roarinelk.homelinux.net>
 <dc79b2a4d9da426f867de084c75940109eff1287.1229846413.git.mano@roarinelk.homelinux.net>
 <535458cb8c8f570089b2712a1e73ca7314d5b7c7.1229846413.git.mano@roarinelk.homelinux.net>
 <ad6889e72585d9fa5bedeb080d6d78d91c9e23c9.1229846414.git.mano@roarinelk.homelinux.net>
In-Reply-To: <cover.1229846410.git.mano@roarinelk.homelinux.net>
References: <cover.1229846410.git.mano@roarinelk.homelinux.net>
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21642
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Remove the cpu_table:
- move detection of whether c0_config[OD] is read-only and should be set
  to fix various chip errata to au1000 headers.
- move detection of write-only sys_cpupll to au1000 headers.
- remove the BCLK switching code:  Activation of this features should be
  left to the boards using the chips since it also affects external devices
  tied to BCLK, and only the board designers know whether it is safe to
  enable.

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/common/Makefile          |    2 +-
 arch/mips/alchemy/common/cputable.c        |   52 -------------------------
 arch/mips/alchemy/common/setup.c           |   26 +------------
 arch/mips/alchemy/common/time.c            |    4 +-
 arch/mips/include/asm/mach-au1x00/au1000.h |   58 ++++++++++++++++++----------
 5 files changed, 42 insertions(+), 100 deletions(-)
 delete mode 100644 arch/mips/alchemy/common/cputable.c

diff --git a/arch/mips/alchemy/common/Makefile b/arch/mips/alchemy/common/Makefile
index 28b8aeb..d50d476 100644
--- a/arch/mips/alchemy/common/Makefile
+++ b/arch/mips/alchemy/common/Makefile
@@ -7,7 +7,7 @@
 
 obj-y += prom.o irq.o puts.o time.o reset.o \
 	clocks.o platform.o power.o setup.o \
-	sleeper.o cputable.o dma.o dbdma.o gpio.o
+	sleeper.o dma.o dbdma.o gpio.o
 
 obj-$(CONFIG_PCI)		+= pci.o
 
diff --git a/arch/mips/alchemy/common/cputable.c b/arch/mips/alchemy/common/cputable.c
deleted file mode 100644
index ba6430b..0000000
--- a/arch/mips/alchemy/common/cputable.c
+++ /dev/null
@@ -1,52 +0,0 @@
-/*
- *  arch/mips/au1000/common/cputable.c
- *
- *  Copyright (C) 2004 Dan Malek (dan@embeddededge.com)
- *	Copied from PowerPC and updated for Alchemy Au1xxx processors.
- *
- *  Copyright (C) 2001 Ben. Herrenschmidt (benh@kernel.crashing.org)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- */
-
-#include <asm/mach-au1x00/au1000.h>
-
-struct cpu_spec *cur_cpu_spec[NR_CPUS];
-
-/* With some thought, we can probably use the mask to reduce the
- * size of the table.
- */
-struct cpu_spec cpu_specs[] = {
-	{ 0xffffffff, 0x00030100, "Au1000 DA", 1, 0, 1 },
-	{ 0xffffffff, 0x00030201, "Au1000 HA", 1, 0, 1 },
-	{ 0xffffffff, 0x00030202, "Au1000 HB", 1, 0, 1 },
-	{ 0xffffffff, 0x00030203, "Au1000 HC", 1, 1, 0 },
-	{ 0xffffffff, 0x00030204, "Au1000 HD", 1, 1, 0 },
-	{ 0xffffffff, 0x01030200, "Au1500 AB", 1, 1, 0 },
-	{ 0xffffffff, 0x01030201, "Au1500 AC", 0, 1, 0 },
-	{ 0xffffffff, 0x01030202, "Au1500 AD", 0, 1, 0 },
-	{ 0xffffffff, 0x02030200, "Au1100 AB", 1, 1, 0 },
-	{ 0xffffffff, 0x02030201, "Au1100 BA", 1, 1, 0 },
-	{ 0xffffffff, 0x02030202, "Au1100 BC", 1, 1, 0 },
-	{ 0xffffffff, 0x02030203, "Au1100 BD", 0, 1, 0 },
-	{ 0xffffffff, 0x02030204, "Au1100 BE", 0, 1, 0 },
-	{ 0xffffffff, 0x03030200, "Au1550 AA", 0, 1, 0 },
-	{ 0xffffffff, 0x04030200, "Au1200 AB", 0, 0, 0 },
-	{ 0xffffffff, 0x04030201, "Au1200 AC", 1, 0, 0 },
-	{ 0x00000000, 0x00000000, "Unknown Au1xxx", 1, 0, 0 }
-};
-
-void set_cpuspec(void)
-{
-	struct	cpu_spec *sp;
-	u32	prid;
-
-	prid = read_c0_prid();
-	sp = cpu_specs;
-	while ((prid & sp->prid_mask) != sp->prid_value)
-		sp++;
-	cur_cpu_spec[0] = sp;
-}
diff --git a/arch/mips/alchemy/common/setup.c b/arch/mips/alchemy/common/setup.c
index 9889ec3..4d42be8 100644
--- a/arch/mips/alchemy/common/setup.c
+++ b/arch/mips/alchemy/common/setup.c
@@ -44,37 +44,13 @@ extern void set_cpuspec(void);
 
 void __init plat_mem_setup(void)
 {
-	struct	cpu_spec *sp;
-	unsigned long prid, cpufreq, bclk;
-
-	set_cpuspec();
-	sp = cur_cpu_spec[0];
-
 	_machine_restart = au1000_restart;
 	_machine_halt = au1000_halt;
 	pm_power_off = au1000_power_off;
 
 	board_setup();  /* board specific setup */
 
-	prid = read_c0_prid();
-	if (sp->cpu_pll_wo)
-#ifdef CONFIG_SOC_AU1000_FREQUENCY
-		cpufreq = CONFIG_SOC_AU1000_FREQUENCY / 1000000;
-#else
-		cpufreq = 396;
-#endif
-	else
-		cpufreq = (au_readl(SYS_CPUPLL) & 0x3F) * 12;
-	printk(KERN_INFO "(PRID %08lx) @ %ld MHz\n", prid, cpufreq);
-
-	if (sp->cpu_bclk) {
-		/* Enable BCLK switching */
-		bclk = au_readl(SYS_POWERCTRL);
-		au_writel(bclk | 0x60, SYS_POWERCTRL);
-		printk(KERN_INFO "BCLK switching enabled!\n");
-	}
-
-	if (sp->cpu_od)
+	if (au1xxx_cpu_needs_config_od())
 		/* Various early Au1xx0 errata corrected by this */
 		set_c0_config(1 << 19); /* Set Config[OD] */
 	else
diff --git a/arch/mips/alchemy/common/time.c b/arch/mips/alchemy/common/time.c
index 68d7142..1518570 100644
--- a/arch/mips/alchemy/common/time.c
+++ b/arch/mips/alchemy/common/time.c
@@ -198,7 +198,7 @@ unsigned long calc_clock(void)
 	 * silicon versions of Au1000 are not sold by AMD, we don't bend
 	 * over backwards trying to determine the frequency.
 	 */
-	if (cur_cpu_spec[0]->cpu_pll_wo)
+	if (au1xxx_cpu_has_pll_wo())
 #ifdef CONFIG_SOC_AU1000_FREQUENCY
 		cpu_speed = CONFIG_SOC_AU1000_FREQUENCY;
 #else
@@ -221,7 +221,7 @@ void __init plat_time_init(void)
 
 	est_freq += 5000;    /* round */
 	est_freq -= est_freq%10000;
-	printk(KERN_INFO "CPU frequency %u.%02u MHz\n",
+	printk(KERN_INFO "(PRId %08x) @ %u.%02u MHz\n", read_c0_prid(),
 	       est_freq / 1000000, ((est_freq % 1000000) * 100) / 1000000);
 	set_au1x00_speed(est_freq);
 
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index d07632e..5db26e6 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -91,6 +91,44 @@ static inline u32 au_readl(unsigned long reg)
 	return *(volatile u32 *)reg;
 }
 
+/* Early Au1000 have a write-only SYS_CPUPLL register. */
+static inline int au1xxx_cpu_has_pll_wo(void)
+{
+	switch (read_c0_prid()) {
+	case 0x00030100:	/* Au1000 DA */
+	case 0x00030201:	/* Au1000 HA */
+	case 0x00030202:	/* Au1000 HB */
+		return 1;
+	}
+	return 0;
+}
+
+/* does CPU need CONFIG[OD] set to fix tons of errata? */
+static inline int au1xxx_cpu_needs_config_od(void)
+{
+	/*
+	 * c0_config.od (bit 19) was write only (and read as 0) on the
+	 * early revisions of Alchemy SOCs.  It disables the bus trans-
+	 * action overlapping and needs to be set to fix various errata.
+	 */
+	switch (read_c0_prid()) {
+	case 0x00030100: /* Au1000 DA */
+	case 0x00030201: /* Au1000 HA */
+	case 0x00030202: /* Au1000 HB */
+	case 0x01030200: /* Au1500 AB */
+	/*
+	 * Au1100/Au1200 errata actually keep silence about this bit,
+	 * so we set it just in case for those revisions that require
+	 * it to be set according to the (now gone) cpu_table.
+	 */
+	case 0x02030200: /* Au1100 AB */
+	case 0x02030201: /* Au1100 BA */
+	case 0x02030202: /* Au1100 BC */
+	case 0x04030201: /* Au1200 AC */
+		return 1;
+	}
+	return 0;
+}
 
 /* arch/mips/au1000/common/clocks.c */
 extern void set_au1x00_speed(unsigned int new_freq);
@@ -1739,24 +1777,4 @@ static AU1X00_SYS * const sys = (AU1X00_SYS *)SYS_BASE;
 
 #endif
 
-/*
- * Processor information based on PRID.
- * Copied from PowerPC.
- */
-#ifndef _LANGUAGE_ASSEMBLY
-struct cpu_spec {
-	/* CPU is matched via (PRID & prid_mask) == prid_value */
-	unsigned int	prid_mask;
-	unsigned int	prid_value;
-
-	char		*cpu_name;
-	unsigned char	cpu_od;		/* Set Config[OD] */
-	unsigned char	cpu_bclk;	/* Enable BCLK switching */
-	unsigned char	cpu_pll_wo;	/* sys_cpupll reg. write-only */
-};
-
-extern struct cpu_spec	cpu_specs[];
-extern struct cpu_spec	*cur_cpu_spec[];
-#endif
-
 #endif
-- 
1.6.0.4
