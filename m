Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Mar 2008 14:08:42 +0100 (CET)
Received: from rtsoft3.corbina.net ([85.21.88.6]:26887 "EHLO
	buildserver.ru.mvista.com") by lappi.linux-mips.net with ESMTP
	id S523983AbYC0NIi (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 27 Mar 2008 14:08:38 +0100
Received: from wasted.dev.rtsoft.ru (unknown [10.150.0.9])
	by buildserver.ru.mvista.com (Postfix) with ESMTP
	id 5FB788810; Thu, 27 Mar 2008 18:08:27 +0400 (SAMT)
From:	Sergei Shtylyov <sshtylyov@ru.mvista.com>
Organization: MontaVista Software Inc.
To:	ralf@linux-mips.org
Subject: [PATCH] Alchemy: work around clock misdetection on early Au1000 (take 2)
Date:	Thu, 27 Mar 2008 16:09:31 +0300
User-Agent: KMail/1.5
Cc:	linux-mips@linux-mips.org
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200803271609.31772.sshtylyov@ru.mvista.com>
Return-Path: <sshtylyov@ru.mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@ru.mvista.com
Precedence: bulk
X-list: linux-mips

Work around the CPU clock miscalculation on Au1000DA/HA/HB due the sys_cpupll
register being write-only, i.e. actually do what the comment before cal_r4off()
function advertised for years but the code failed at.  This is achieved by just
giving user a chance to define the clock explicitly  in the board config. via
CONFIG_SOC_AU1000_FREQUENCY option, defaulting to 396 MHz if the option is not
given...

The patch is based on the AMD's big unpublished patch, the issue seems to be an
undocumented errata (or feature :-)...

Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

---
That's what happens to a dozen line (and incorrect) change when you do it
properly. ;-)

This should theoretically apply to all stable branches, but as AMD claimed that
the guilty chips were not sold, it's up to the maintainer.

In this revision I decided to revert to CONFIG_SOC_AU1000_FREQUENCY option name
and defer the copyright update till the big cleanup patch that's coming...

 arch/mips/au1000/common/cputable.c    |   36 +++++++++++++++++-----------------
 arch/mips/au1000/common/setup.c       |   13 +++++++++---
 arch/mips/au1000/common/time.c        |   24 +++++++++++++---------
 include/asm-mips/mach-au1x00/au1000.h |    1 
 4 files changed, 43 insertions(+), 31 deletions(-)

Index: linux-2.6/arch/mips/au1000/common/cputable.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/cputable.c
+++ linux-2.6/arch/mips/au1000/common/cputable.c
@@ -22,24 +22,24 @@ struct cpu_spec* cur_cpu_spec[NR_CPUS];
 /* With some thought, we can probably use the mask to reduce the
  * size of the table.
  */
-struct cpu_spec	cpu_specs[] = {
-    { 0xffffffff, 0x00030100, "Au1000 DA", 1, 0 },
-    { 0xffffffff, 0x00030201, "Au1000 HA", 1, 0 },
-    { 0xffffffff, 0x00030202, "Au1000 HB", 1, 0 },
-    { 0xffffffff, 0x00030203, "Au1000 HC", 1, 1 },
-    { 0xffffffff, 0x00030204, "Au1000 HD", 1, 1 },
-    { 0xffffffff, 0x01030200, "Au1500 AB", 1, 1 },
-    { 0xffffffff, 0x01030201, "Au1500 AC", 0, 1 },
-    { 0xffffffff, 0x01030202, "Au1500 AD", 0, 1 },
-    { 0xffffffff, 0x02030200, "Au1100 AB", 1, 1 },
-    { 0xffffffff, 0x02030201, "Au1100 BA", 1, 1 },
-    { 0xffffffff, 0x02030202, "Au1100 BC", 1, 1 },
-    { 0xffffffff, 0x02030203, "Au1100 BD", 0, 1 },
-    { 0xffffffff, 0x02030204, "Au1100 BE", 0, 1 },
-    { 0xffffffff, 0x03030200, "Au1550 AA", 0, 1 },
-    { 0xffffffff, 0x04030200, "Au1200 AB", 0, 0 },
-    { 0xffffffff, 0x04030201, "Au1200 AC", 1, 0 },
-    { 0x00000000, 0x00000000, "Unknown Au1xxx", 1, 0 },
+struct cpu_spec cpu_specs[] = {
+	{ 0xffffffff, 0x00030100, "Au1000 DA", 1, 0, 1 },
+	{ 0xffffffff, 0x00030201, "Au1000 HA", 1, 0, 1 },
+	{ 0xffffffff, 0x00030202, "Au1000 HB", 1, 0, 1 },
+	{ 0xffffffff, 0x00030203, "Au1000 HC", 1, 1, 0 },
+	{ 0xffffffff, 0x00030204, "Au1000 HD", 1, 1, 0 },
+	{ 0xffffffff, 0x01030200, "Au1500 AB", 1, 1, 0 },
+	{ 0xffffffff, 0x01030201, "Au1500 AC", 0, 1, 0 },
+	{ 0xffffffff, 0x01030202, "Au1500 AD", 0, 1, 0 },
+	{ 0xffffffff, 0x02030200, "Au1100 AB", 1, 1, 0 },
+	{ 0xffffffff, 0x02030201, "Au1100 BA", 1, 1, 0 },
+	{ 0xffffffff, 0x02030202, "Au1100 BC", 1, 1, 0 },
+	{ 0xffffffff, 0x02030203, "Au1100 BD", 0, 1, 0 },
+	{ 0xffffffff, 0x02030204, "Au1100 BE", 0, 1, 0 },
+	{ 0xffffffff, 0x03030200, "Au1550 AA", 0, 1, 0 },
+	{ 0xffffffff, 0x04030200, "Au1200 AB", 0, 0, 0 },
+	{ 0xffffffff, 0x04030201, "Au1200 AC", 1, 0, 0 },
+	{ 0x00000000, 0x00000000, "Unknown Au1xxx", 1, 0, 0 }
 };
 
 void
Index: linux-2.6/arch/mips/au1000/common/setup.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/setup.c
+++ linux-2.6/arch/mips/au1000/common/setup.c
@@ -57,7 +57,7 @@ void __init plat_mem_setup(void)
 {
 	struct	cpu_spec *sp;
 	char *argptr;
-	unsigned long prid, cpupll, bclk = 1;
+	unsigned long prid, cpufreq, bclk = 1;
 
 	set_cpuspec();
 	sp = cur_cpu_spec[0];
@@ -65,8 +65,15 @@ void __init plat_mem_setup(void)
 	board_setup();  /* board specific setup */
 
 	prid = read_c0_prid();
-	cpupll = (au_readl(0xB1900060) & 0x3F) * 12;
-	printk("(PRId %08lx) @ %ldMHZ\n", prid, cpupll);
+	if (cur_cpu_spec[0]->cpu_pll_wo)
+#ifdef CONFIG_SOC_AU1000_FREQUENCY
+		cpufreq = CONFIG_SOC_AU1000_FREQUENCY / 1000000;
+#else
+		cpufreq = 396;
+#endif
+	else
+		cpufreq = (au_readl(SYS_CPUPLL) & 0x3F) * 12;
+	printk(KERN_INFO "(PRID %08lx) @ %ld MHz\n", prid, cpufreq);
 
 	bclk = sp->cpu_bclk;
 	if (bclk)
Index: linux-2.6/arch/mips/au1000/common/time.c
===================================================================
--- linux-2.6.orig/arch/mips/au1000/common/time.c
+++ linux-2.6/arch/mips/au1000/common/time.c
@@ -209,18 +209,22 @@ unsigned long cal_r4koff(void)
 		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S);
 		au_writel(0, SYS_TOYWRITE);
 		while (au_readl(SYS_COUNTER_CNTRL) & SYS_CNTRL_C1S);
+	} else
+		no_au1xxx_32khz = 1;
 
-		cpu_speed = (au_readl(SYS_CPUPLL) & 0x0000003f) *
-			AU1000_SRC_CLK;
-	}
-	else {
-		/* The 32KHz oscillator isn't running, so assume there
-		 * isn't one and grab the processor speed from the PLL.
-		 * NOTE: some old silicon doesn't allow reading the PLL.
-		 */
+	/*
+	 * On early Au1000, sys_cpupll was write-only. Since these
+	 * silicon versions of Au1000 are not sold by AMD, we don't bend
+	 * over backwards trying to determine the frequency.
+	 */
+	if (cur_cpu_spec[0]->cpu_pll_wo)
+#ifdef CONFIG_SOC_AU1000_FREQUENCY
+		cpu_speed = CONFIG_SOC_AU1000_FREQUENCY;
+#else
+		cpu_speed = 396000000;
+#endif
+	else
 		cpu_speed = (au_readl(SYS_CPUPLL) & 0x0000003f) * AU1000_SRC_CLK;
-		no_au1xxx_32khz = 1;
-	}
 	mips_hpt_frequency = cpu_speed;
 	// Equation: Baudrate = CPU / (SD * 2 * CLKDIV * 16)
 	set_au1x00_uart_baud_base(cpu_speed / (2 * ((int)(au_readl(SYS_POWERCTRL)&0x03) + 2) * 16));
Index: linux-2.6/include/asm-mips/mach-au1x00/au1000.h
===================================================================
--- linux-2.6.orig/include/asm-mips/mach-au1x00/au1000.h
+++ linux-2.6/include/asm-mips/mach-au1x00/au1000.h
@@ -1778,6 +1778,7 @@ struct cpu_spec {
 	char		*cpu_name;
 	unsigned char	cpu_od;		/* Set Config[OD] */
 	unsigned char	cpu_bclk;	/* Enable BCLK switching */
+	unsigned char	cpu_pll_wo;	/* sys_cpupll reg. write-only */
 };
 
 extern struct cpu_spec		cpu_specs[];
