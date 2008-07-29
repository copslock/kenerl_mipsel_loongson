Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 29 Jul 2008 18:00:40 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:40341 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20023919AbYG2RAd (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Tue, 29 Jul 2008 18:00:33 +0100
Received: (qmail 8913 invoked by uid 1000); 29 Jul 2008 19:00:32 +0200
Date:	Tue, 29 Jul 2008 19:00:32 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	linux-mips@linux-mips.org
Subject: [PATCH v4 2/10] Alchemy: remove cpu_table.
Message-ID: <20080729170032.GD8784@roarinelk.homelinux.net>
References: <20080729165853.GB8784@roarinelk.homelinux.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20080729165853.GB8784@roarinelk.homelinux.net>
User-Agent: Mutt/1.5.16 (2007-06-09)
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20034
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
 arch/mips/au1000/common/Makefile      |    2 +-
 arch/mips/au1000/common/cputable.c    |   52 -----------------------------
 arch/mips/au1000/common/setup.c       |   26 +--------------
 arch/mips/au1000/common/time.c        |    4 +-
 include/asm-mips/mach-au1x00/au1000.h |   58 +++++++++++++++++++++-----------
 5 files changed, 42 insertions(+), 100 deletions(-)
 delete mode 100644 arch/mips/au1000/common/cputable.c

diff --git a/arch/mips/au1000/common/Makefile b/arch/mips/au1000/common/Makefile
index dd0e19d..850de08 100644
--- a/arch/mips/au1000/common/Makefile
+++ b/arch/mips/au1000/common/Makefile
@@ -7,7 +7,7 @@
 
 obj-y += prom.o irq.o puts.o time.o reset.o \
 	au1xxx_irqmap.o clocks.o platform.o power.o setup.o \
-	sleeper.o cputable.o dma.o dbdma.o gpio.o
+	sleeper.o dma.o dbdma.o gpio.o
 
 obj-$(CONFIG_KGDB)		+= dbg_io.o
 obj-$(CONFIG_PCI)		+= pci.o
diff --git a/arch/mips/au1000/common/cputable.c b/arch/mips/au1000/common/cputable.c
deleted file mode 100644
index ba6430b..0000000
--- a/arch/mips/au1000/common/cputable.c
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
diff --git a/arch/mips/au1000/common/setup.c b/arch/mips/au1000/common/setup.c
index 1ac6b06..8f06440 100644
--- a/arch/mips/au1000/common/setup.c
+++ b/arch/mips/au1000/common/setup.c
@@ -41,38 +41,14 @@ extern void __init board_setup(void);
 extern void au1000_restart(char *);
 extern void au1000_halt(void);
 extern void au1000_power_off(void);
-extern void set_cpuspec(void);
 
 void __init plat_mem_setup(void)
 {
-	struct	cpu_spec *sp;
 	char *argptr;
-	unsigned long prid, cpufreq, bclk;
-
-	set_cpuspec();
-	sp = cur_cpu_spec[0];
 
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
diff --git a/arch/mips/au1000/common/time.c b/arch/mips/au1000/common/time.c
index 68d7142..1518570 100644
--- a/arch/mips/au1000/common/time.c
+++ b/arch/mips/au1000/common/time.c
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
 
diff --git a/include/asm-mips/mach-au1x00/au1000.h b/include/asm-mips/mach-au1x00/au1000.h
index 8d2ced6..7245960 100644
--- a/include/asm-mips/mach-au1x00/au1000.h
+++ b/include/asm-mips/mach-au1x00/au1000.h
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
@@ -1747,24 +1785,4 @@ static AU1X00_SYS * const sys = (AU1X00_SYS *)SYS_BASE;
 
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
1.5.6.3
