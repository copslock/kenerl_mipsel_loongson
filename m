Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 18 Jul 2008 17:50:22 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:53463 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28588257AbYGRQuD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 18 Jul 2008 17:50:03 +0100
Received: from localhost (p8181-ipad203funabasi.chiba.ocn.ne.jp [222.146.87.181])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 6376CB384; Sat, 19 Jul 2008 01:49:57 +0900 (JST)
Date:	Sat, 19 Jul 2008 01:51:47 +0900 (JST)
Message-Id: <20080719.015147.112855514.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 2/3] txx9: Add 64-bit support
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19890
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

SYS_SUPPORTS_64BIT_KERNEL is enabled for RBTX4927/RBTX4938, but
actually it was broken for long time (or from the beginning).  Now it
should work.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/Makefile       |    4 +-
 arch/mips/txx9/generic/irq_tx4927.c   |    2 +-
 arch/mips/txx9/generic/irq_tx4938.c   |    2 +-
 arch/mips/txx9/generic/setup.c        |   16 ++-
 arch/mips/txx9/generic/setup_tx4927.c |  194 ++++++++++++++++++++++++
 arch/mips/txx9/generic/setup_tx4938.c |  259 +++++++++++++++++++++++++++++++++
 arch/mips/txx9/jmr3927/setup.c        |    8 -
 arch/mips/txx9/rbtx4927/irq.c         |   12 +-
 arch/mips/txx9/rbtx4927/setup.c       |   89 ++++--------
 arch/mips/txx9/rbtx4938/setup.c       |  218 +--------------------------
 include/asm-mips/txx9/generic.h       |    7 +
 include/asm-mips/txx9/rbtx4927.h      |   26 +++-
 include/asm-mips/txx9/rbtx4938.h      |   52 +++----
 include/asm-mips/txx9/tx4927.h        |   15 ++
 include/asm-mips/txx9/tx4938.h        |    6 +
 15 files changed, 580 insertions(+), 330 deletions(-)

diff --git a/arch/mips/txx9/generic/Makefile b/arch/mips/txx9/generic/Makefile
index ab274ed..9c12077 100644
--- a/arch/mips/txx9/generic/Makefile
+++ b/arch/mips/txx9/generic/Makefile
@@ -4,8 +4,8 @@
 
 obj-y	+= setup.o
 obj-$(CONFIG_PCI)	+= pci.o
-obj-$(CONFIG_SOC_TX4927)	+= mem_tx4927.o irq_tx4927.o
-obj-$(CONFIG_SOC_TX4938)	+= mem_tx4927.o irq_tx4938.o
+obj-$(CONFIG_SOC_TX4927)	+= mem_tx4927.o setup_tx4927.o irq_tx4927.o
+obj-$(CONFIG_SOC_TX4938)	+= mem_tx4927.o setup_tx4938.o irq_tx4938.o
 obj-$(CONFIG_TOSHIBA_FPCIB0)	+= smsc_fdc37m81x.o
 obj-$(CONFIG_KGDB)	+= dbgio.o
 
diff --git a/arch/mips/txx9/generic/irq_tx4927.c b/arch/mips/txx9/generic/irq_tx4927.c
index 6377bd8..cbea1fd 100644
--- a/arch/mips/txx9/generic/irq_tx4927.c
+++ b/arch/mips/txx9/generic/irq_tx4927.c
@@ -31,7 +31,7 @@
 void __init tx4927_irq_init(void)
 {
 	mips_cpu_irq_init();
-	txx9_irq_init(TX4927_IRC_REG);
+	txx9_irq_init(TX4927_IRC_REG & 0xfffffffffULL);
 	set_irq_chained_handler(MIPS_CPU_IRQ_BASE + TX4927_IRC_INT,
 				handle_simple_irq);
 }
diff --git a/arch/mips/txx9/generic/irq_tx4938.c b/arch/mips/txx9/generic/irq_tx4938.c
index 5fc86c9..6eac684 100644
--- a/arch/mips/txx9/generic/irq_tx4938.c
+++ b/arch/mips/txx9/generic/irq_tx4938.c
@@ -19,7 +19,7 @@
 void __init tx4938_irq_init(void)
 {
 	mips_cpu_irq_init();
-	txx9_irq_init(TX4938_IRC_REG);
+	txx9_irq_init(TX4938_IRC_REG & 0xfffffffffULL);
 	set_irq_chained_handler(MIPS_CPU_IRQ_BASE + TX4938_IRC_INT,
 				handle_simple_irq);
 }
diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index 8caef07..3715a8f 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -30,6 +30,7 @@ struct resource txx9_ce_res[8];
 static char txx9_ce_res_name[8][4];	/* "CEn" */
 
 /* pcode, internal register */
+unsigned int txx9_pcode;
 char txx9_pcode_str[8];
 static struct resource txx9_reg_res = {
 	.name = txx9_pcode_str,
@@ -59,15 +60,16 @@ unsigned int txx9_master_clock;
 unsigned int txx9_cpu_clock;
 unsigned int txx9_gbus_clock;
 
+int txx9_ccfg_toeon __initdata = 1;
 
 /* Minimum CLK support */
 
 struct clk *clk_get(struct device *dev, const char *id)
 {
 	if (!strcmp(id, "spi-baseclk"))
-		return (struct clk *)(txx9_gbus_clock / 2 / 4);
+		return (struct clk *)((unsigned long)txx9_gbus_clock / 2 / 4);
 	if (!strcmp(id, "imbus_clk"))
-		return (struct clk *)(txx9_gbus_clock / 2);
+		return (struct clk *)((unsigned long)txx9_gbus_clock / 2);
 	return ERR_PTR(-ENOENT);
 }
 EXPORT_SYMBOL(clk_get);
@@ -123,6 +125,12 @@ void __init prom_init_cmdline(void)
 	int argc = (int)fw_arg0;
 	char **argv = (char **)fw_arg1;
 	int i;			/* Always ignore the "-c" at argv[0] */
+#ifdef CONFIG_64BIT
+	char *fixed_argv[32];
+	for (i = 0; i < argc; i++)
+		fixed_argv[i] = (char *)(long)(*((__s32 *)argv + i));
+	argv = fixed_argv;
+#endif
 
 	/* ignore all built-in args if any f/w args given */
 	if (argc > 1)
@@ -180,6 +188,10 @@ char * __init prom_getcmdline(void)
 /* wrappers */
 void __init plat_mem_setup(void)
 {
+	ioport_resource.start = 0;
+	ioport_resource.end = ~0UL;	/* no limit */
+	iomem_resource.start = 0;
+	iomem_resource.end = ~0UL;	/* no limit */
 	txx9_board_vec->mem_setup();
 }
 
diff --git a/arch/mips/txx9/generic/setup_tx4927.c b/arch/mips/txx9/generic/setup_tx4927.c
new file mode 100644
index 0000000..89d6e28
--- /dev/null
+++ b/arch/mips/txx9/generic/setup_tx4927.c
@@ -0,0 +1,194 @@
+/*
+ * TX4927 setup routines
+ * Based on linux/arch/mips/txx9/rbtx4938/setup.c,
+ *	    and RBTX49xx patch from CELF patch archive.
+ *
+ * 2003-2005 (c) MontaVista Software, Inc.
+ * (C) Copyright TOSHIBA CORPORATION 2000-2001, 2004-2007
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/serial_core.h>
+#include <linux/param.h>
+#include <asm/txx9irq.h>
+#include <asm/txx9tmr.h>
+#include <asm/txx9pio.h>
+#include <asm/txx9/generic.h>
+#include <asm/txx9/tx4927.h>
+
+void __init tx4927_wdr_init(void)
+{
+	/* clear WatchDogReset (W1C) */
+	tx4927_ccfg_set(TX4927_CCFG_WDRST);
+	/* do reset on watchdog */
+	tx4927_ccfg_set(TX4927_CCFG_WR);
+}
+
+static struct resource tx4927_sdram_resource[4];
+
+void __init tx4927_setup(void)
+{
+	int i;
+	__u32 divmode;
+	int cpuclk = 0;
+	u64 ccfg;
+
+	txx9_reg_res_init(TX4927_REV_PCODE(), TX4927_REG_BASE,
+			  TX4927_REG_SIZE);
+
+	/* SDRAMC,EBUSC are configured by PROM */
+	for (i = 0; i < 8; i++) {
+		if (!(TX4927_EBUSC_CR(i) & 0x8))
+			continue;	/* disabled */
+		txx9_ce_res[i].start = (unsigned long)TX4927_EBUSC_BA(i);
+		txx9_ce_res[i].end =
+			txx9_ce_res[i].start + TX4927_EBUSC_SIZE(i) - 1;
+		request_resource(&iomem_resource, &txx9_ce_res[i]);
+	}
+
+	/* clocks */
+	ccfg = ____raw_readq(&tx4927_ccfgptr->ccfg);
+	if (txx9_master_clock) {
+		/* calculate gbus_clock and cpu_clock from master_clock */
+		divmode = (__u32)ccfg & TX4927_CCFG_DIVMODE_MASK;
+		switch (divmode) {
+		case TX4927_CCFG_DIVMODE_8:
+		case TX4927_CCFG_DIVMODE_10:
+		case TX4927_CCFG_DIVMODE_12:
+		case TX4927_CCFG_DIVMODE_16:
+			txx9_gbus_clock = txx9_master_clock * 4; break;
+		default:
+			txx9_gbus_clock = txx9_master_clock;
+		}
+		switch (divmode) {
+		case TX4927_CCFG_DIVMODE_2:
+		case TX4927_CCFG_DIVMODE_8:
+			cpuclk = txx9_gbus_clock * 2; break;
+		case TX4927_CCFG_DIVMODE_2_5:
+		case TX4927_CCFG_DIVMODE_10:
+			cpuclk = txx9_gbus_clock * 5 / 2; break;
+		case TX4927_CCFG_DIVMODE_3:
+		case TX4927_CCFG_DIVMODE_12:
+			cpuclk = txx9_gbus_clock * 3; break;
+		case TX4927_CCFG_DIVMODE_4:
+		case TX4927_CCFG_DIVMODE_16:
+			cpuclk = txx9_gbus_clock * 4; break;
+		}
+		txx9_cpu_clock = cpuclk;
+	} else {
+		if (txx9_cpu_clock == 0)
+			txx9_cpu_clock = 200000000;	/* 200MHz */
+		/* calculate gbus_clock and master_clock from cpu_clock */
+		cpuclk = txx9_cpu_clock;
+		divmode = (__u32)ccfg & TX4927_CCFG_DIVMODE_MASK;
+		switch (divmode) {
+		case TX4927_CCFG_DIVMODE_2:
+		case TX4927_CCFG_DIVMODE_8:
+			txx9_gbus_clock = cpuclk / 2; break;
+		case TX4927_CCFG_DIVMODE_2_5:
+		case TX4927_CCFG_DIVMODE_10:
+			txx9_gbus_clock = cpuclk * 2 / 5; break;
+		case TX4927_CCFG_DIVMODE_3:
+		case TX4927_CCFG_DIVMODE_12:
+			txx9_gbus_clock = cpuclk / 3; break;
+		case TX4927_CCFG_DIVMODE_4:
+		case TX4927_CCFG_DIVMODE_16:
+			txx9_gbus_clock = cpuclk / 4; break;
+		}
+		switch (divmode) {
+		case TX4927_CCFG_DIVMODE_8:
+		case TX4927_CCFG_DIVMODE_10:
+		case TX4927_CCFG_DIVMODE_12:
+		case TX4927_CCFG_DIVMODE_16:
+			txx9_master_clock = txx9_gbus_clock / 4; break;
+		default:
+			txx9_master_clock = txx9_gbus_clock;
+		}
+	}
+	/* change default value to udelay/mdelay take reasonable time */
+	loops_per_jiffy = txx9_cpu_clock / HZ / 2;
+
+	/* CCFG */
+	tx4927_wdr_init();
+	/* clear BusErrorOnWrite flag (W1C) */
+	tx4927_ccfg_set(TX4927_CCFG_BEOW);
+	/* enable Timeout BusError */
+	if (txx9_ccfg_toeon)
+		tx4927_ccfg_set(TX4927_CCFG_TOE);
+
+	/* DMA selection */
+	txx9_clear64(&tx4927_ccfgptr->pcfg, TX4927_PCFG_DMASEL_ALL);
+
+	/* Use external clock for external arbiter */
+	if (!(____raw_readq(&tx4927_ccfgptr->ccfg) & TX4927_CCFG_PCIARB))
+		txx9_clear64(&tx4927_ccfgptr->pcfg, TX4927_PCFG_PCICLKEN_ALL);
+
+	printk(KERN_INFO "%s -- %dMHz(M%dMHz) CRIR:%08x CCFG:%llx PCFG:%llx\n",
+	       txx9_pcode_str,
+	       (cpuclk + 500000) / 1000000,
+	       (txx9_master_clock + 500000) / 1000000,
+	       (__u32)____raw_readq(&tx4927_ccfgptr->crir),
+	       (unsigned long long)____raw_readq(&tx4927_ccfgptr->ccfg),
+	       (unsigned long long)____raw_readq(&tx4927_ccfgptr->pcfg));
+
+	printk(KERN_INFO "%s SDRAMC --", txx9_pcode_str);
+	for (i = 0; i < 4; i++) {
+		__u64 cr = TX4927_SDRAMC_CR(i);
+		unsigned long base, size;
+		if (!((__u32)cr & 0x00000400))
+			continue;	/* disabled */
+		base = (unsigned long)(cr >> 49) << 21;
+		size = (((unsigned long)(cr >> 33) & 0x7fff) + 1) << 21;
+		printk(" CR%d:%016llx", i, (unsigned long long)cr);
+		tx4927_sdram_resource[i].name = "SDRAM";
+		tx4927_sdram_resource[i].start = base;
+		tx4927_sdram_resource[i].end = base + size - 1;
+		tx4927_sdram_resource[i].flags = IORESOURCE_MEM;
+		request_resource(&iomem_resource, &tx4927_sdram_resource[i]);
+	}
+	printk(" TR:%09llx\n",
+	       (unsigned long long)____raw_readq(&tx4927_sdramcptr->tr));
+
+	/* TMR */
+	/* disable all timers */
+	for (i = 0; i < TX4927_NR_TMR; i++)
+		txx9_tmr_init(TX4927_TMR_REG(i) & 0xfffffffffULL);
+
+	/* PIO */
+	txx9_gpio_init(TX4927_PIO_REG & 0xfffffffffULL, 0, TX4927_NUM_PIO);
+	__raw_writel(0, &tx4927_pioptr->maskcpu);
+	__raw_writel(0, &tx4927_pioptr->maskext);
+}
+
+void __init tx4927_time_init(unsigned int tmrnr)
+{
+	if (____raw_readq(&tx4927_ccfgptr->ccfg) & TX4927_CCFG_TINTDIS)
+		txx9_clockevent_init(TX4927_TMR_REG(tmrnr) & 0xfffffffffULL,
+				     TXX9_IRQ_BASE + TX4927_IR_TMR(tmrnr),
+				     TXX9_IMCLK);
+}
+
+void __init tx4927_setup_serial(void)
+{
+#ifdef CONFIG_SERIAL_TXX9
+	int i;
+	struct uart_port req;
+
+	for (i = 0; i < 2; i++) {
+		memset(&req, 0, sizeof(req));
+		req.line = i;
+		req.iotype = UPIO_MEM;
+		req.membase = (unsigned char __iomem *)TX4927_SIO_REG(i);
+		req.mapbase = TX4927_SIO_REG(i) & 0xfffffffffULL;
+		req.irq = TXX9_IRQ_BASE + TX4927_IR_SIO(i);
+		req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
+		req.uartclk = TXX9_IMCLK;
+		early_serial_txx9_setup(&req);
+	}
+#endif /* CONFIG_SERIAL_TXX9 */
+}
diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
new file mode 100644
index 0000000..317378d
--- /dev/null
+++ b/arch/mips/txx9/generic/setup_tx4938.c
@@ -0,0 +1,259 @@
+/*
+ * TX4938/4937 setup routines
+ * Based on linux/arch/mips/txx9/rbtx4938/setup.c,
+ *	    and RBTX49xx patch from CELF patch archive.
+ *
+ * 2003-2005 (c) MontaVista Software, Inc.
+ * (C) Copyright TOSHIBA CORPORATION 2000-2001, 2004-2007
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ */
+#include <linux/init.h>
+#include <linux/ioport.h>
+#include <linux/delay.h>
+#include <linux/serial_core.h>
+#include <linux/param.h>
+#include <asm/txx9irq.h>
+#include <asm/txx9tmr.h>
+#include <asm/txx9pio.h>
+#include <asm/txx9/generic.h>
+#include <asm/txx9/tx4938.h>
+
+void __init tx4938_wdr_init(void)
+{
+	/* clear WatchDogReset (W1C) */
+	tx4938_ccfg_set(TX4938_CCFG_WDRST);
+	/* do reset on watchdog */
+	tx4938_ccfg_set(TX4938_CCFG_WR);
+}
+
+static struct resource tx4938_sdram_resource[4];
+static struct resource tx4938_sram_resource;
+
+#define TX4938_SRAM_SIZE 0x800
+
+void __init tx4938_setup(void)
+{
+	int i;
+	__u32 divmode;
+	int cpuclk = 0;
+	u64 ccfg;
+
+	txx9_reg_res_init(TX4938_REV_PCODE(), TX4938_REG_BASE,
+			  TX4938_REG_SIZE);
+
+	/* SDRAMC,EBUSC are configured by PROM */
+	for (i = 0; i < 8; i++) {
+		if (!(TX4938_EBUSC_CR(i) & 0x8))
+			continue;	/* disabled */
+		txx9_ce_res[i].start = (unsigned long)TX4938_EBUSC_BA(i);
+		txx9_ce_res[i].end =
+			txx9_ce_res[i].start + TX4938_EBUSC_SIZE(i) - 1;
+		request_resource(&iomem_resource, &txx9_ce_res[i]);
+	}
+
+	/* clocks */
+	ccfg = ____raw_readq(&tx4938_ccfgptr->ccfg);
+	if (txx9_master_clock) {
+		/* calculate gbus_clock and cpu_clock from master_clock */
+		divmode = (__u32)ccfg & TX4938_CCFG_DIVMODE_MASK;
+		switch (divmode) {
+		case TX4938_CCFG_DIVMODE_8:
+		case TX4938_CCFG_DIVMODE_10:
+		case TX4938_CCFG_DIVMODE_12:
+		case TX4938_CCFG_DIVMODE_16:
+		case TX4938_CCFG_DIVMODE_18:
+			txx9_gbus_clock = txx9_master_clock * 4; break;
+		default:
+			txx9_gbus_clock = txx9_master_clock;
+		}
+		switch (divmode) {
+		case TX4938_CCFG_DIVMODE_2:
+		case TX4938_CCFG_DIVMODE_8:
+			cpuclk = txx9_gbus_clock * 2; break;
+		case TX4938_CCFG_DIVMODE_2_5:
+		case TX4938_CCFG_DIVMODE_10:
+			cpuclk = txx9_gbus_clock * 5 / 2; break;
+		case TX4938_CCFG_DIVMODE_3:
+		case TX4938_CCFG_DIVMODE_12:
+			cpuclk = txx9_gbus_clock * 3; break;
+		case TX4938_CCFG_DIVMODE_4:
+		case TX4938_CCFG_DIVMODE_16:
+			cpuclk = txx9_gbus_clock * 4; break;
+		case TX4938_CCFG_DIVMODE_4_5:
+		case TX4938_CCFG_DIVMODE_18:
+			cpuclk = txx9_gbus_clock * 9 / 2; break;
+		}
+		txx9_cpu_clock = cpuclk;
+	} else {
+		if (txx9_cpu_clock == 0)
+			txx9_cpu_clock = 300000000;	/* 300MHz */
+		/* calculate gbus_clock and master_clock from cpu_clock */
+		cpuclk = txx9_cpu_clock;
+		divmode = (__u32)ccfg & TX4938_CCFG_DIVMODE_MASK;
+		switch (divmode) {
+		case TX4938_CCFG_DIVMODE_2:
+		case TX4938_CCFG_DIVMODE_8:
+			txx9_gbus_clock = cpuclk / 2; break;
+		case TX4938_CCFG_DIVMODE_2_5:
+		case TX4938_CCFG_DIVMODE_10:
+			txx9_gbus_clock = cpuclk * 2 / 5; break;
+		case TX4938_CCFG_DIVMODE_3:
+		case TX4938_CCFG_DIVMODE_12:
+			txx9_gbus_clock = cpuclk / 3; break;
+		case TX4938_CCFG_DIVMODE_4:
+		case TX4938_CCFG_DIVMODE_16:
+			txx9_gbus_clock = cpuclk / 4; break;
+		case TX4938_CCFG_DIVMODE_4_5:
+		case TX4938_CCFG_DIVMODE_18:
+			txx9_gbus_clock = cpuclk * 2 / 9; break;
+		}
+		switch (divmode) {
+		case TX4938_CCFG_DIVMODE_8:
+		case TX4938_CCFG_DIVMODE_10:
+		case TX4938_CCFG_DIVMODE_12:
+		case TX4938_CCFG_DIVMODE_16:
+		case TX4938_CCFG_DIVMODE_18:
+			txx9_master_clock = txx9_gbus_clock / 4; break;
+		default:
+			txx9_master_clock = txx9_gbus_clock;
+		}
+	}
+	/* change default value to udelay/mdelay take reasonable time */
+	loops_per_jiffy = txx9_cpu_clock / HZ / 2;
+
+	/* CCFG */
+	tx4938_wdr_init();
+	/* clear BusErrorOnWrite flag (W1C) */
+	tx4938_ccfg_set(TX4938_CCFG_BEOW);
+	/* enable Timeout BusError */
+	if (txx9_ccfg_toeon)
+		tx4938_ccfg_set(TX4938_CCFG_TOE);
+
+	/* DMA selection */
+	txx9_clear64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_DMASEL_ALL);
+
+	/* Use external clock for external arbiter */
+	if (!(____raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_PCIARB))
+		txx9_clear64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_PCICLKEN_ALL);
+
+	printk(KERN_INFO "%s -- %dMHz(M%dMHz) CRIR:%08x CCFG:%llx PCFG:%llx\n",
+	       txx9_pcode_str,
+	       (cpuclk + 500000) / 1000000,
+	       (txx9_master_clock + 500000) / 1000000,
+	       (__u32)____raw_readq(&tx4938_ccfgptr->crir),
+	       (unsigned long long)____raw_readq(&tx4938_ccfgptr->ccfg),
+	       (unsigned long long)____raw_readq(&tx4938_ccfgptr->pcfg));
+
+	printk(KERN_INFO "%s SDRAMC --", txx9_pcode_str);
+	for (i = 0; i < 4; i++) {
+		__u64 cr = TX4938_SDRAMC_CR(i);
+		unsigned long base, size;
+		if (!((__u32)cr & 0x00000400))
+			continue;	/* disabled */
+		base = (unsigned long)(cr >> 49) << 21;
+		size = (((unsigned long)(cr >> 33) & 0x7fff) + 1) << 21;
+		printk(" CR%d:%016llx", i, (unsigned long long)cr);
+		tx4938_sdram_resource[i].name = "SDRAM";
+		tx4938_sdram_resource[i].start = base;
+		tx4938_sdram_resource[i].end = base + size - 1;
+		tx4938_sdram_resource[i].flags = IORESOURCE_MEM;
+		request_resource(&iomem_resource, &tx4938_sdram_resource[i]);
+	}
+	printk(" TR:%09llx\n",
+	       (unsigned long long)____raw_readq(&tx4938_sdramcptr->tr));
+
+	/* SRAM */
+	if (txx9_pcode == 0x4938 && ____raw_readq(&tx4938_sramcptr->cr) & 1) {
+		unsigned int size = TX4938_SRAM_SIZE;
+		tx4938_sram_resource.name = "SRAM";
+		tx4938_sram_resource.start =
+			(____raw_readq(&tx4938_sramcptr->cr) >> (39-11))
+			& ~(size - 1);
+		tx4938_sram_resource.end =
+			tx4938_sram_resource.start + TX4938_SRAM_SIZE - 1;
+		tx4938_sram_resource.flags = IORESOURCE_MEM;
+		request_resource(&iomem_resource, &tx4938_sram_resource);
+	}
+
+	/* TMR */
+	/* disable all timers */
+	for (i = 0; i < TX4938_NR_TMR; i++)
+		txx9_tmr_init(TX4938_TMR_REG(i) & 0xfffffffffULL);
+
+	/* DMA */
+	for (i = 0; i < 2; i++)
+		____raw_writeq(TX4938_DMA_MCR_MSTEN,
+			       (void __iomem *)(TX4938_DMA_REG(i) + 0x50));
+
+	/* PIO */
+	txx9_gpio_init(TX4938_PIO_REG & 0xfffffffffULL, 0, TX4938_NUM_PIO);
+	__raw_writel(0, &tx4938_pioptr->maskcpu);
+	__raw_writel(0, &tx4938_pioptr->maskext);
+
+	if (txx9_pcode == 0x4938) {
+		__u64 pcfg = ____raw_readq(&tx4938_ccfgptr->pcfg);
+		/* set PCIC1 reset */
+		txx9_set64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIC1RST);
+		if (pcfg & (TX4938_PCFG_ETH0_SEL | TX4938_PCFG_ETH1_SEL)) {
+			mdelay(1);	/* at least 128 cpu clock */
+			/* clear PCIC1 reset */
+			txx9_clear64(&tx4938_ccfgptr->clkctr,
+				     TX4938_CLKCTR_PCIC1RST);
+		} else {
+			printk(KERN_INFO "%s: stop PCIC1\n", txx9_pcode_str);
+			/* stop PCIC1 */
+			txx9_set64(&tx4938_ccfgptr->clkctr,
+				   TX4938_CLKCTR_PCIC1CKD);
+		}
+		if (!(pcfg & TX4938_PCFG_ETH0_SEL)) {
+			printk(KERN_INFO "%s: stop ETH0\n", txx9_pcode_str);
+			txx9_set64(&tx4938_ccfgptr->clkctr,
+				   TX4938_CLKCTR_ETH0RST);
+			txx9_set64(&tx4938_ccfgptr->clkctr,
+				   TX4938_CLKCTR_ETH0CKD);
+		}
+		if (!(pcfg & TX4938_PCFG_ETH1_SEL)) {
+			printk(KERN_INFO "%s: stop ETH1\n", txx9_pcode_str);
+			txx9_set64(&tx4938_ccfgptr->clkctr,
+				   TX4938_CLKCTR_ETH1RST);
+			txx9_set64(&tx4938_ccfgptr->clkctr,
+				   TX4938_CLKCTR_ETH1CKD);
+		}
+	}
+}
+
+void __init tx4938_time_init(unsigned int tmrnr)
+{
+	if (____raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_TINTDIS)
+		txx9_clockevent_init(TX4938_TMR_REG(tmrnr) & 0xfffffffffULL,
+				     TXX9_IRQ_BASE + TX4938_IR_TMR(tmrnr),
+				     TXX9_IMCLK);
+}
+
+void __init tx4938_setup_serial(void)
+{
+#ifdef CONFIG_SERIAL_TXX9
+	int i;
+	struct uart_port req;
+	unsigned int ch_mask = 0;
+
+	if (__raw_readq(&tx4938_ccfgptr->pcfg) & TX4938_PCFG_ETH0_SEL)
+		ch_mask |= 1 << 1; /* disable SIO1 by PCFG setting */
+	for (i = 0; i < 2; i++) {
+		if ((1 << i) & ch_mask)
+			continue;
+		memset(&req, 0, sizeof(req));
+		req.line = i;
+		req.iotype = UPIO_MEM;
+		req.membase = (unsigned char __iomem *)TX4938_SIO_REG(i);
+		req.mapbase = TX4938_SIO_REG(i) & 0xfffffffffULL;
+		req.irq = TXX9_IRQ_BASE + TX4938_IR_SIO(i);
+		req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
+		req.uartclk = TXX9_IMCLK;
+		early_serial_txx9_setup(&req);
+	}
+#endif /* CONFIG_SERIAL_TXX9 */
+}
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index 5e35ef7..03647eb 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -105,14 +105,6 @@ static void __init jmr3927_mem_setup(void)
 	_machine_halt = jmr3927_machine_halt;
 	pm_power_off = jmr3927_machine_power_off;
 
-	/*
-	 * IO/MEM resources.
-	 */
-	ioport_resource.start = 0;
-	ioport_resource.end = 0xffffffff;
-	iomem_resource.start = 0;
-	iomem_resource.end = 0xffffffff;
-
 	/* Reboot on panic */
 	panic_timeout = 180;
 
diff --git a/arch/mips/txx9/rbtx4927/irq.c b/arch/mips/txx9/rbtx4927/irq.c
index 70f1321..cd748a9 100644
--- a/arch/mips/txx9/rbtx4927/irq.c
+++ b/arch/mips/txx9/rbtx4927/irq.c
@@ -126,14 +126,12 @@ static struct irq_chip toshiba_rbtx4927_irq_ioc_type = {
 	.mask_ack = toshiba_rbtx4927_irq_ioc_disable,
 	.unmask = toshiba_rbtx4927_irq_ioc_enable,
 };
-#define TOSHIBA_RBTX4927_IOC_INTR_ENAB (void __iomem *)0xbc002000UL
-#define TOSHIBA_RBTX4927_IOC_INTR_STAT (void __iomem *)0xbc002006UL
 
 static int toshiba_rbtx4927_irq_nested(int sw_irq)
 {
 	u8 level3;
 
-	level3 = readb(TOSHIBA_RBTX4927_IOC_INTR_STAT) & 0x1f;
+	level3 = readb(rbtx4927_imstat_addr) & 0x1f;
 	if (level3)
 		sw_irq = RBTX4927_IRQ_IOC + fls(level3) - 1;
 	return (sw_irq);
@@ -154,18 +152,18 @@ static void toshiba_rbtx4927_irq_ioc_enable(unsigned int irq)
 {
 	unsigned char v;
 
-	v = readb(TOSHIBA_RBTX4927_IOC_INTR_ENAB);
+	v = readb(rbtx4927_imask_addr);
 	v |= (1 << (irq - RBTX4927_IRQ_IOC));
-	writeb(v, TOSHIBA_RBTX4927_IOC_INTR_ENAB);
+	writeb(v, rbtx4927_imask_addr);
 }
 
 static void toshiba_rbtx4927_irq_ioc_disable(unsigned int irq)
 {
 	unsigned char v;
 
-	v = readb(TOSHIBA_RBTX4927_IOC_INTR_ENAB);
+	v = readb(rbtx4927_imask_addr);
 	v &= ~(1 << (irq - RBTX4927_IRQ_IOC));
-	writeb(v, TOSHIBA_RBTX4927_IOC_INTR_ENAB);
+	writeb(v, rbtx4927_imask_addr);
 	mmiowb();
 }
 
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index 1657fd9..3da20ea 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -53,17 +53,10 @@
 #include <asm/io.h>
 #include <asm/processor.h>
 #include <asm/reboot.h>
-#include <asm/time.h>
-#include <asm/txx9tmr.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/pci.h>
 #include <asm/txx9/rbtx4927.h>
 #include <asm/txx9/tx4938.h>	/* for TX4937 */
-#ifdef CONFIG_SERIAL_TXX9
-#include <linux/serial_core.h>
-#endif
-
-static int tx4927_ccfg_toeon = 1;
 
 #ifdef CONFIG_PCI
 static void __init tx4927_pci_setup(void)
@@ -184,14 +177,14 @@ static void toshiba_rbtx4927_restart(char *command)
 	printk(KERN_NOTICE "System Rebooting...\n");
 
 	/* enable the s/w reset register */
-	writeb(RBTX4927_SW_RESET_ENABLE_SET, RBTX4927_SW_RESET_ENABLE);
+	writeb(1, rbtx4927_softresetlock_addr);
 
 	/* wait for enable to be seen */
-	while ((readb(RBTX4927_SW_RESET_ENABLE) &
-		RBTX4927_SW_RESET_ENABLE_SET) == 0x00);
+	while (!(readb(rbtx4927_softresetlock_addr) & 1))
+		;
 
 	/* do a s/w reset */
-	writeb(RBTX4927_SW_RESET_DO_SET, RBTX4927_SW_RESET_DO);
+	writeb(1, rbtx4927_softreset_addr);
 
 	/* do something passive while waiting for reset */
 	local_irq_disable();
@@ -213,9 +206,11 @@ static void toshiba_rbtx4927_power_off(void)
 	/* no return */
 }
 
+static void __init rbtx4927_clock_init(void);
+static void __init rbtx4937_clock_init(void);
+
 static void __init rbtx4927_mem_setup(void)
 {
-	int i;
 	u32 cp0_config;
 	char *argptr;
 
@@ -227,16 +222,18 @@ static void __init rbtx4927_mem_setup(void)
 	cp0_config = cp0_config & ~(TX49_CONF_IC | TX49_CONF_DC);
 	write_c0_config(cp0_config);
 
-	ioport_resource.end = 0xffffffff;
-	iomem_resource.end = 0xffffffff;
+	if (TX4927_REV_PCODE() == 0x4927) {
+		rbtx4927_clock_init();
+		tx4927_setup();
+	} else {
+		rbtx4937_clock_init();
+		tx4938_setup();
+	}
 
 	_machine_restart = toshiba_rbtx4927_restart;
 	_machine_halt = toshiba_rbtx4927_halt;
 	pm_power_off = toshiba_rbtx4927_power_off;
 
-	for (i = 0; i < TX4927_NR_TMR; i++)
-		txx9_tmr_init(TX4927_TMR_REG(0) & 0xfffffffffULL);
-
 #ifdef CONFIG_PCI
 	txx9_alloc_pci_controller(&txx9_primary_pcic,
 				  RBTX4927_PCIMEM, RBTX4927_PCIMEM_SIZE,
@@ -245,36 +242,13 @@ static void __init rbtx4927_mem_setup(void)
 	set_io_port_base(KSEG1 + RBTX4927_ISA_IO_OFFSET);
 #endif
 
-	/* CCFG */
-	/* do reset on watchdog */
-	tx4927_ccfg_set(TX4927_CCFG_WR);
-	/* enable Timeout BusError */
-	if (tx4927_ccfg_toeon)
-		tx4927_ccfg_set(TX4927_CCFG_TOE);
-
-#ifdef CONFIG_SERIAL_TXX9
-	{
-		extern int early_serial_txx9_setup(struct uart_port *port);
-		struct uart_port req;
-		for(i = 0; i < 2; i++) {
-			memset(&req, 0, sizeof(req));
-			req.line = i;
-			req.iotype = UPIO_MEM;
-			req.membase = (char *)(0xff1ff300 + i * 0x100);
-			req.mapbase = 0xff1ff300 + i * 0x100;
-			req.irq = TXX9_IRQ_BASE + TX4927_IR_SIO(i);
-			req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
-			req.uartclk = 50000000;
-			early_serial_txx9_setup(&req);
-		}
-	}
+	tx4927_setup_serial();
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
         argptr = prom_getcmdline();
         if (strstr(argptr, "console=") == NULL) {
                 strcat(argptr, " console=ttyS0,38400");
         }
 #endif
-#endif
 
 #ifdef CONFIG_ROOT_NFS
         argptr = prom_getcmdline();
@@ -291,19 +265,7 @@ static void __init rbtx4927_mem_setup(void)
 #endif
 }
 
-static void __init rbtx49x7_common_time_init(void)
-{
-	/* change default value to udelay/mdelay take reasonable time */
-	loops_per_jiffy = txx9_cpu_clock / HZ / 2;
-
-	mips_hpt_frequency = txx9_cpu_clock / 2;
-	if (____raw_readq(&tx4927_ccfgptr->ccfg) & TX4927_CCFG_TINTDIS)
-		txx9_clockevent_init(TX4927_TMR_REG(0) & 0xfffffffffULL,
-				     TXX9_IRQ_BASE + 17,
-				     50000000);
-}
-
-static void __init rbtx4927_time_init(void)
+static void __init rbtx4927_clock_init(void)
 {
 	/*
 	 * ASSUMPTION: PCIDIVMODE is configured for PCI 33MHz or 66MHz.
@@ -325,11 +287,9 @@ static void __init rbtx4927_time_init(void)
 	default:
 		txx9_cpu_clock = 200000000;	/* 200MHz */
 	}
-
-	rbtx49x7_common_time_init();
 }
 
-static void __init rbtx4937_time_init(void)
+static void __init rbtx4937_clock_init(void)
 {
 	/*
 	 * ASSUMPTION: PCIDIVMODE is configured for PCI 33MHz or 66MHz.
@@ -357,15 +317,18 @@ static void __init rbtx4937_time_init(void)
 	default:
 		txx9_cpu_clock = 333333333;	/* 333MHz */
 	}
+}
 
-	rbtx49x7_common_time_init();
+static void __init rbtx4927_time_init(void)
+{
+	tx4927_time_init(0);
 }
 
 static int __init toshiba_rbtx4927_rtc_init(void)
 {
-	static struct resource __initdata res = {
-		.start	= 0x1c010000,
-		.end	= 0x1c010000 + 0x800 - 1,
+	struct resource res = {
+		.start	= RBTX4927_BRAMRTC_BASE - IO_BASE,
+		.end	= RBTX4927_BRAMRTC_BASE - IO_BASE + 0x800 - 1,
 		.flags	= IORESOURCE_MEM,
 	};
 	struct platform_device *dev =
@@ -375,7 +338,7 @@ static int __init toshiba_rbtx4927_rtc_init(void)
 
 static int __init rbtx4927_ne_init(void)
 {
-	static struct resource __initdata res[] = {
+	struct resource res[] = {
 		{
 			.start	= RBTX4927_RTL_8019_BASE,
 			.end	= RBTX4927_RTL_8019_BASE + 0x20 - 1,
@@ -434,7 +397,7 @@ struct txx9_board_vec rbtx4937_vec __initdata = {
 	.prom_init = rbtx4927_prom_init,
 	.mem_setup = rbtx4927_mem_setup,
 	.irq_setup = rbtx4927_irq_setup,
-	.time_init = rbtx4937_time_init,
+	.time_init = rbtx4927_time_init,
 	.device_init = rbtx4927_device_init,
 	.arch_init = rbtx4937_arch_init,
 #ifdef CONFIG_PCI
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index c1e076c..6c2b99b 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -20,21 +20,14 @@
 #include <linux/gpio.h>
 
 #include <asm/reboot.h>
-#include <asm/time.h>
-#include <asm/txx9tmr.h>
 #include <asm/io.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/pci.h>
 #include <asm/txx9/rbtx4938.h>
-#ifdef CONFIG_SERIAL_TXX9
-#include <linux/serial_core.h>
-#endif
 #include <linux/spi/spi.h>
 #include <asm/txx9/spi.h>
 #include <asm/txx9pio.h>
 
-static int tx4938_ccfg_toeon = 1;
-
 static void rbtx4938_machine_halt(void)
 {
         printk(KERN_NOTICE "System Halted\n");
@@ -182,189 +175,10 @@ static void __init rbtx4938_spi_setup(void)
 }
 
 static struct resource rbtx4938_fpga_resource;
-static struct resource tx4938_sdram_resource[4];
-static struct resource tx4938_sram_resource;
-
-void __init tx4938_board_setup(void)
-{
-	int i;
-	unsigned long divmode;
-	int cpuclk = 0;
-	unsigned long pcode = TX4938_REV_PCODE();
-
-	ioport_resource.start = 0;
-	ioport_resource.end = 0xffffffff;
-	iomem_resource.start = 0;
-	iomem_resource.end = 0xffffffff;	/* expand to 4GB */
-
-	txx9_reg_res_init(pcode, TX4938_REG_BASE,
-			  TX4938_REG_SIZE);
-	/* SDRAMC,EBUSC are configured by PROM */
-	for (i = 0; i < 8; i++) {
-		if (!(TX4938_EBUSC_CR(i) & 0x8))
-			continue;	/* disabled */
-		txx9_ce_res[i].start = (unsigned long)TX4938_EBUSC_BA(i);
-		txx9_ce_res[i].end =
-			txx9_ce_res[i].start + TX4938_EBUSC_SIZE(i) - 1;
-		request_resource(&iomem_resource, &txx9_ce_res[i]);
-	}
-
-	/* clocks */
-	if (txx9_master_clock) {
-		u64 ccfg = ____raw_readq(&tx4938_ccfgptr->ccfg);
-		/* calculate gbus_clock and cpu_clock_freq from master_clock */
-		divmode = (__u32)ccfg & TX4938_CCFG_DIVMODE_MASK;
-		switch (divmode) {
-		case TX4938_CCFG_DIVMODE_8:
-		case TX4938_CCFG_DIVMODE_10:
-		case TX4938_CCFG_DIVMODE_12:
-		case TX4938_CCFG_DIVMODE_16:
-		case TX4938_CCFG_DIVMODE_18:
-			txx9_gbus_clock = txx9_master_clock * 4; break;
-		default:
-			txx9_gbus_clock = txx9_master_clock;
-		}
-		switch (divmode) {
-		case TX4938_CCFG_DIVMODE_2:
-		case TX4938_CCFG_DIVMODE_8:
-			cpuclk = txx9_gbus_clock * 2; break;
-		case TX4938_CCFG_DIVMODE_2_5:
-		case TX4938_CCFG_DIVMODE_10:
-			cpuclk = txx9_gbus_clock * 5 / 2; break;
-		case TX4938_CCFG_DIVMODE_3:
-		case TX4938_CCFG_DIVMODE_12:
-			cpuclk = txx9_gbus_clock * 3; break;
-		case TX4938_CCFG_DIVMODE_4:
-		case TX4938_CCFG_DIVMODE_16:
-			cpuclk = txx9_gbus_clock * 4; break;
-		case TX4938_CCFG_DIVMODE_4_5:
-		case TX4938_CCFG_DIVMODE_18:
-			cpuclk = txx9_gbus_clock * 9 / 2; break;
-		}
-		txx9_cpu_clock = cpuclk;
-	} else {
-		u64 ccfg = ____raw_readq(&tx4938_ccfgptr->ccfg);
-		if (txx9_cpu_clock == 0) {
-			txx9_cpu_clock = 300000000;	/* 300MHz */
-		}
-		/* calculate gbus_clock and master_clock from cpu_clock_freq */
-		cpuclk = txx9_cpu_clock;
-		divmode = (__u32)ccfg & TX4938_CCFG_DIVMODE_MASK;
-		switch (divmode) {
-		case TX4938_CCFG_DIVMODE_2:
-		case TX4938_CCFG_DIVMODE_8:
-			txx9_gbus_clock = cpuclk / 2; break;
-		case TX4938_CCFG_DIVMODE_2_5:
-		case TX4938_CCFG_DIVMODE_10:
-			txx9_gbus_clock = cpuclk * 2 / 5; break;
-		case TX4938_CCFG_DIVMODE_3:
-		case TX4938_CCFG_DIVMODE_12:
-			txx9_gbus_clock = cpuclk / 3; break;
-		case TX4938_CCFG_DIVMODE_4:
-		case TX4938_CCFG_DIVMODE_16:
-			txx9_gbus_clock = cpuclk / 4; break;
-		case TX4938_CCFG_DIVMODE_4_5:
-		case TX4938_CCFG_DIVMODE_18:
-			txx9_gbus_clock = cpuclk * 2 / 9; break;
-		}
-		switch (divmode) {
-		case TX4938_CCFG_DIVMODE_8:
-		case TX4938_CCFG_DIVMODE_10:
-		case TX4938_CCFG_DIVMODE_12:
-		case TX4938_CCFG_DIVMODE_16:
-		case TX4938_CCFG_DIVMODE_18:
-			txx9_master_clock = txx9_gbus_clock / 4; break;
-		default:
-			txx9_master_clock = txx9_gbus_clock;
-		}
-	}
-	/* change default value to udelay/mdelay take reasonable time */
-	loops_per_jiffy = txx9_cpu_clock / HZ / 2;
-
-	/* CCFG */
-	/* clear WatchDogReset,BusErrorOnWrite flag (W1C) */
-	tx4938_ccfg_set(TX4938_CCFG_WDRST | TX4938_CCFG_BEOW);
-	/* do reset on watchdog */
-	tx4938_ccfg_set(TX4938_CCFG_WR);
-	/* clear PCIC1 reset */
-	txx9_clear64(&tx4938_ccfgptr->clkctr, TX4938_CLKCTR_PCIC1RST);
-
-	/* enable Timeout BusError */
-	if (tx4938_ccfg_toeon)
-		tx4938_ccfg_set(TX4938_CCFG_TOE);
-
-	/* DMA selection */
-	txx9_clear64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_DMASEL_ALL);
-
-	/* Use external clock for external arbiter */
-	if (!(____raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_PCIARB))
-		txx9_clear64(&tx4938_ccfgptr->pcfg, TX4938_PCFG_PCICLKEN_ALL);
-
-	printk(KERN_INFO "%s -- %dMHz(M%dMHz) CRIR:%08x CCFG:%llx PCFG:%llx\n",
-	       txx9_pcode_str,
-	       (cpuclk + 500000) / 1000000,
-	       (txx9_master_clock + 500000) / 1000000,
-	       (__u32)____raw_readq(&tx4938_ccfgptr->crir),
-	       (unsigned long long)____raw_readq(&tx4938_ccfgptr->ccfg),
-	       (unsigned long long)____raw_readq(&tx4938_ccfgptr->pcfg));
-
-	printk(KERN_INFO "%s SDRAMC --", txx9_pcode_str);
-	for (i = 0; i < 4; i++) {
-		u64 cr = TX4938_SDRAMC_CR(i);
-		unsigned long ram_base, ram_size;
-		if (!((unsigned long)cr & 0x00000400))
-			continue;	/* disabled */
-		ram_base = (unsigned long)(cr >> 49) << 21;
-		ram_size = ((unsigned long)(cr >> 33) + 1) << 21;
-		if (ram_base >= 0x20000000)
-			continue;	/* high memory (ignore) */
-		printk(KERN_CONT " CR%d:%016llx", i, cr);
-		tx4938_sdram_resource[i].name = "SDRAM";
-		tx4938_sdram_resource[i].start = ram_base;
-		tx4938_sdram_resource[i].end = ram_base + ram_size - 1;
-		tx4938_sdram_resource[i].flags = IORESOURCE_MEM;
-		request_resource(&iomem_resource, &tx4938_sdram_resource[i]);
-	}
-	printk(KERN_CONT " TR:%09llx\n", ____raw_readq(&tx4938_sdramcptr->tr));
-
-	/* SRAM */
-	if (____raw_readq(&tx4938_sramcptr->cr) & 1) {
-		unsigned int size = 0x800;
-		unsigned long base =
-			(____raw_readq(&tx4938_sramcptr->cr) >> (39-11))
-			& ~(size - 1);
-		tx4938_sram_resource.name = "SRAM";
-		tx4938_sram_resource.start = base;
-		tx4938_sram_resource.end = base + size - 1;
-		tx4938_sram_resource.flags = IORESOURCE_MEM;
-		request_resource(&iomem_resource, &tx4938_sram_resource);
-	}
-
-	/* TMR */
-	for (i = 0; i < TX4938_NR_TMR; i++)
-		txx9_tmr_init(TX4938_TMR_REG(i) & 0xfffffffffULL);
-
-	/* enable DMA */
-	for (i = 0; i < 2; i++)
-		____raw_writeq(TX4938_DMA_MCR_MSTEN,
-			       (void __iomem *)(TX4938_DMA_REG(i) + 0x50));
-
-	/* PIO */
-	__raw_writel(0, &tx4938_pioptr->maskcpu);
-	__raw_writel(0, &tx4938_pioptr->maskext);
-
-#ifdef CONFIG_PCI
-	txx9_alloc_pci_controller(&txx9_primary_pcic, 0, 0, 0, 0);
-#endif
-}
 
 static void __init rbtx4938_time_init(void)
 {
-	mips_hpt_frequency = txx9_cpu_clock / 2;
-	if (____raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_TINTDIS)
-		txx9_clockevent_init(TX4938_TMR_REG(0) & 0xfffffffffULL,
-				     TXX9_IRQ_BASE + TX4938_IR_TMR(0),
-				     txx9_gbus_clock / 2);
+	tx4938_time_init(0);
 }
 
 static void __init rbtx4938_mem_setup(void)
@@ -372,39 +186,24 @@ static void __init rbtx4938_mem_setup(void)
 	unsigned long long pcfg;
 	char *argptr;
 
-	iomem_resource.end = 0xffffffff;	/* 4GB */
-
 	if (txx9_master_clock == 0)
 		txx9_master_clock = 25000000; /* 25MHz */
-	tx4938_board_setup();
-#ifndef CONFIG_PCI
+
+	tx4938_setup();
+
+#ifdef CONFIG_PCI
+	txx9_alloc_pci_controller(&txx9_primary_pcic, 0, 0, 0, 0);
+#else
 	set_io_port_base(RBTX4938_ETHER_BASE);
 #endif
 
-#ifdef CONFIG_SERIAL_TXX9
-	{
-		extern int early_serial_txx9_setup(struct uart_port *port);
-		int i;
-		struct uart_port req;
-		for(i = 0; i < 2; i++) {
-			memset(&req, 0, sizeof(req));
-			req.line = i;
-			req.iotype = UPIO_MEM;
-			req.membase = (char *)(0xff1ff300 + i * 0x100);
-			req.mapbase = 0xff1ff300 + i * 0x100;
-			req.irq = RBTX4938_IRQ_IRC_SIO(i);
-			req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
-			req.uartclk = 50000000;
-			early_serial_txx9_setup(&req);
-		}
-	}
+	tx4938_setup_serial();
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
         argptr = prom_getcmdline();
         if (strstr(argptr, "console=") == NULL) {
                 strcat(argptr, " console=ttyS0,38400");
         }
 #endif
-#endif
 
 #ifdef CONFIG_TOSHIBA_RBTX4938_MPLEX_PIO58_61
 	printk("PIOSEL: disabling both ata and nand selection\n");
@@ -568,7 +367,6 @@ static int __init rbtx4938_spi_init(void)
 
 static void __init rbtx4938_arch_init(void)
 {
-	txx9_gpio_init(TX4938_PIO_REG & 0xfffffffffULL, 0, 16);
 	gpiochip_add(&rbtx4938_spi_gpio_chip);
 	rbtx4938_pci_setup();
 	rbtx4938_spi_init();
diff --git a/include/asm-mips/txx9/generic.h b/include/asm-mips/txx9/generic.h
index d875666..cbae37e 100644
--- a/include/asm-mips/txx9/generic.h
+++ b/include/asm-mips/txx9/generic.h
@@ -12,6 +12,8 @@
 #include <linux/ioport.h>	/* for struct resource */
 
 extern struct resource txx9_ce_res[];
+#define TXX9_CE(n)	(unsigned long)(txx9_ce_res[(n)].start)
+extern unsigned int txx9_pcode;
 extern char txx9_pcode_str[8];
 void txx9_reg_res_init(unsigned int pcode, unsigned long base,
 		       unsigned long size);
@@ -19,6 +21,11 @@ void txx9_reg_res_init(unsigned int pcode, unsigned long base,
 extern unsigned int txx9_master_clock;
 extern unsigned int txx9_cpu_clock;
 extern unsigned int txx9_gbus_clock;
+#define TXX9_IMCLK	(txx9_gbus_clock / 2)
+
+extern int txx9_ccfg_toeon;
+struct uart_port;
+int early_serial_txx9_setup(struct uart_port *port);
 
 struct pci_dev;
 struct txx9_board_vec {
diff --git a/include/asm-mips/txx9/rbtx4927.h b/include/asm-mips/txx9/rbtx4927.h
index bf19458..6fcec91 100644
--- a/include/asm-mips/txx9/rbtx4927.h
+++ b/include/asm-mips/txx9/rbtx4927.h
@@ -34,7 +34,23 @@
 #define RBTX4927_PCIIO		0x16000000
 #define RBTX4927_PCIIO_SIZE	0x01000000
 
-#define rbtx4927_pcireset_addr	((__u8 __iomem *)0xbc00f006UL)
+#define RBTX4927_IMASK_ADDR	(IO_BASE + TXX9_CE(2) + 0x00002000)
+#define RBTX4927_IMSTAT_ADDR	(IO_BASE + TXX9_CE(2) + 0x00002006)
+#define RBTX4927_SOFTRESET_ADDR	(IO_BASE + TXX9_CE(2) + 0x0000f000)
+#define RBTX4927_SOFTRESETLOCK_ADDR	(IO_BASE + TXX9_CE(2) + 0x0000f002)
+#define RBTX4927_PCIRESET_ADDR	(IO_BASE + TXX9_CE(2) + 0x0000f006)
+#define RBTX4927_BRAMRTC_BASE	(IO_BASE + TXX9_CE(2) + 0x00010000)
+#define RBTX4927_ETHER_BASE	(IO_BASE + TXX9_CE(2) + 0x00020000)
+
+/* Ethernet port address */
+#define RBTX4927_ETHER_ADDR	(RBTX4927_ETHER_BASE + 0x280)
+
+#define rbtx4927_imask_addr	((__u8 __iomem *)RBTX4927_IMASK_ADDR)
+#define rbtx4927_imstat_addr	((__u8 __iomem *)RBTX4927_IMSTAT_ADDR)
+#define rbtx4927_softreset_addr	((__u8 __iomem *)RBTX4927_SOFTRESET_ADDR)
+#define rbtx4927_softresetlock_addr	\
+				((__u8 __iomem *)RBTX4927_SOFTRESETLOCK_ADDR)
+#define rbtx4927_pcireset_addr	((__u8 __iomem *)RBTX4927_PCIRESET_ADDR)
 
 /* bits for ISTAT/IMASK/IMSTAT */
 #define RBTX4927_INTB_PCID	0
@@ -62,13 +78,7 @@
 #define RBTX4927_ISA_IO_OFFSET 0
 #endif
 
-#define RBTX4927_SW_RESET_DO         (void __iomem *)0xbc00f000UL
-#define RBTX4927_SW_RESET_DO_SET                0x01
-
-#define RBTX4927_SW_RESET_ENABLE     (void __iomem *)0xbc00f002UL
-#define RBTX4927_SW_RESET_ENABLE_SET            0x01
-
-#define RBTX4927_RTL_8019_BASE (0x1c020280 - RBTX4927_ISA_IO_OFFSET)
+#define RBTX4927_RTL_8019_BASE (RBTX4927_ETHER_ADDR - mips_io_port_base)
 #define RBTX4927_RTL_8019_IRQ  (TXX9_IRQ_BASE + TX4927_IR_INT(3))
 
 void rbtx4927_prom_init(void);
diff --git a/include/asm-mips/txx9/rbtx4938.h b/include/asm-mips/txx9/rbtx4938.h
index 2f5d5e7..9f0441a 100644
--- a/include/asm-mips/txx9/rbtx4938.h
+++ b/include/asm-mips/txx9/rbtx4938.h
@@ -15,35 +15,31 @@
 #include <asm/txx9irq.h>
 #include <asm/txx9/tx4938.h>
 
-/* CS */
-#define RBTX4938_CE0	0x1c000000	/* 64M */
-#define RBTX4938_CE2	0x17f00000	/* 1M */
-
 /* Address map */
-#define RBTX4938_FPGA_REG_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000000)
-#define RBTX4938_FPGA_REV_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000002)
-#define RBTX4938_CONFIG1_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000004)
-#define RBTX4938_CONFIG2_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000006)
-#define RBTX4938_CONFIG3_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00000008)
-#define RBTX4938_LED_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00001000)
-#define RBTX4938_DIPSW_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00001002)
-#define RBTX4938_BDIPSW_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00001004)
-#define RBTX4938_IMASK_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002000)
-#define RBTX4938_IMASK2_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002002)
-#define RBTX4938_INTPOL_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002004)
-#define RBTX4938_ISTAT_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002006)
-#define RBTX4938_ISTAT2_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00002008)
-#define RBTX4938_IMSTAT_ADDR	(KSEG1 + RBTX4938_CE2 + 0x0000200a)
-#define RBTX4938_IMSTAT2_ADDR	(KSEG1 + RBTX4938_CE2 + 0x0000200c)
-#define RBTX4938_SOFTINT_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00003000)
-#define RBTX4938_PIOSEL_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00005000)
-#define RBTX4938_SPICS_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00005002)
-#define RBTX4938_SFPWR_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00005008)
-#define RBTX4938_SFVOL_ADDR	(KSEG1 + RBTX4938_CE2 + 0x0000500a)
-#define RBTX4938_SOFTRESET_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00007000)
-#define RBTX4938_SOFTRESETLOCK_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00007002)
-#define RBTX4938_PCIRESET_ADDR	(KSEG1 + RBTX4938_CE2 + 0x00007004)
-#define RBTX4938_ETHER_BASE	(KSEG1 + RBTX4938_CE2 + 0x00020000)
+#define RBTX4938_FPGA_REG_ADDR	(IO_BASE + TXX9_CE(2) + 0x00000000)
+#define RBTX4938_FPGA_REV_ADDR	(IO_BASE + TXX9_CE(2) + 0x00000002)
+#define RBTX4938_CONFIG1_ADDR	(IO_BASE + TXX9_CE(2) + 0x00000004)
+#define RBTX4938_CONFIG2_ADDR	(IO_BASE + TXX9_CE(2) + 0x00000006)
+#define RBTX4938_CONFIG3_ADDR	(IO_BASE + TXX9_CE(2) + 0x00000008)
+#define RBTX4938_LED_ADDR	(IO_BASE + TXX9_CE(2) + 0x00001000)
+#define RBTX4938_DIPSW_ADDR	(IO_BASE + TXX9_CE(2) + 0x00001002)
+#define RBTX4938_BDIPSW_ADDR	(IO_BASE + TXX9_CE(2) + 0x00001004)
+#define RBTX4938_IMASK_ADDR	(IO_BASE + TXX9_CE(2) + 0x00002000)
+#define RBTX4938_IMASK2_ADDR	(IO_BASE + TXX9_CE(2) + 0x00002002)
+#define RBTX4938_INTPOL_ADDR	(IO_BASE + TXX9_CE(2) + 0x00002004)
+#define RBTX4938_ISTAT_ADDR	(IO_BASE + TXX9_CE(2) + 0x00002006)
+#define RBTX4938_ISTAT2_ADDR	(IO_BASE + TXX9_CE(2) + 0x00002008)
+#define RBTX4938_IMSTAT_ADDR	(IO_BASE + TXX9_CE(2) + 0x0000200a)
+#define RBTX4938_IMSTAT2_ADDR	(IO_BASE + TXX9_CE(2) + 0x0000200c)
+#define RBTX4938_SOFTINT_ADDR	(IO_BASE + TXX9_CE(2) + 0x00003000)
+#define RBTX4938_PIOSEL_ADDR	(IO_BASE + TXX9_CE(2) + 0x00005000)
+#define RBTX4938_SPICS_ADDR	(IO_BASE + TXX9_CE(2) + 0x00005002)
+#define RBTX4938_SFPWR_ADDR	(IO_BASE + TXX9_CE(2) + 0x00005008)
+#define RBTX4938_SFVOL_ADDR	(IO_BASE + TXX9_CE(2) + 0x0000500a)
+#define RBTX4938_SOFTRESET_ADDR	(IO_BASE + TXX9_CE(2) + 0x00007000)
+#define RBTX4938_SOFTRESETLOCK_ADDR	(IO_BASE + TXX9_CE(2) + 0x00007002)
+#define RBTX4938_PCIRESET_ADDR	(IO_BASE + TXX9_CE(2) + 0x00007004)
+#define RBTX4938_ETHER_BASE	(IO_BASE + TXX9_CE(2) + 0x00020000)
 
 /* Ethernet port address (Jumperless Mode (W12:Open)) */
 #define RBTX4938_ETHER_ADDR	(RBTX4938_ETHER_BASE + 0x280)
diff --git a/include/asm-mips/txx9/tx4927.h b/include/asm-mips/txx9/tx4927.h
index c921215..ceb4b79 100644
--- a/include/asm-mips/txx9/tx4927.h
+++ b/include/asm-mips/txx9/tx4927.h
@@ -46,15 +46,22 @@
 #define TX4927_IRC_REG		(TX4927_REG_BASE + 0xf600)
 #define TX4927_NR_TMR	3
 #define TX4927_TMR_REG(ch)	(TX4927_REG_BASE + 0xf000 + (ch) * 0x100)
+#define TX4927_NR_SIO	2
+#define TX4927_SIO_REG(ch)	(TX4927_REG_BASE + 0xf300 + (ch) * 0x100)
+#define TX4927_PIO_REG		(TX4927_REG_BASE + 0xf500)
 
 #define TX4927_IR_INT(n)	(2 + (n))
 #define TX4927_IR_SIO(n)	(8 + (n))
 #define TX4927_IR_PCIC		16
+#define TX4927_NUM_IR_TMR	3
+#define TX4927_IR_TMR(n)	(17 + (n))
 #define TX4927_IR_PCIERR	22
 #define TX4927_NUM_IR	32
 
 #define TX4927_IRC_INT	2	/* IP[2] in Status register */
 
+#define TX4927_NUM_PIO	16
+
 struct tx4927_sdramc_reg {
 	u64 cr[4];
 	u64 unused0[4];
@@ -175,6 +182,10 @@ struct tx4927_ccfg_reg {
 		((struct tx4927_ccfg_reg __iomem *)TX4927_CCFG_REG)
 #define tx4927_ebuscptr \
 		((struct tx4927_ebusc_reg __iomem *)TX4927_EBUSC_REG)
+#define tx4927_pioptr		((struct txx9_pio_reg __iomem *)TX4927_PIO_REG)
+
+#define TX4927_REV_PCODE()	\
+	((__u32)__raw_readq(&tx4927_ccfgptr->crir) >> 16)
 
 #define TX4927_SDRAMC_CR(ch)	__raw_readq(&tx4927_sdramcptr->cr[(ch)])
 #define TX4927_SDRAMC_BA(ch)	((TX4927_SDRAMC_CR(ch) >> 49) << 21)
@@ -232,6 +243,10 @@ static inline void tx4927_ccfg_change(__u64 change, __u64 new)
 }
 
 unsigned int tx4927_get_mem_size(void);
+void tx4927_wdr_init(void);
+void tx4927_setup(void);
+void tx4927_time_init(unsigned int tmrnr);
+void tx4927_setup_serial(void);
 int tx4927_report_pciclk(void);
 int tx4927_pciclk66_setup(void);
 void tx4927_irq_init(void);
diff --git a/include/asm-mips/txx9/tx4938.h b/include/asm-mips/txx9/tx4938.h
index 6690246..1ed969d 100644
--- a/include/asm-mips/txx9/tx4938.h
+++ b/include/asm-mips/txx9/tx4938.h
@@ -90,6 +90,8 @@ struct tx4938_ccfg_reg {
 
 #define TX4938_IRC_INT	2	/* IP[2] in Status register */
 
+#define TX4938_NUM_PIO	16
+
 /*
  * CCFG
  */
@@ -274,6 +276,10 @@ struct tx4938_ccfg_reg {
 #define TX4938_EBUSC_SIZE(ch)	TX4927_EBUSC_SIZE(ch)
 
 #define tx4938_get_mem_size() tx4927_get_mem_size()
+void tx4938_wdr_init(void);
+void tx4938_setup(void);
+void tx4938_time_init(unsigned int tmrnr);
+void tx4938_setup_serial(void);
 int tx4938_report_pciclk(void);
 void tx4938_report_pci1clk(void);
 int tx4938_pciclk66_setup(void);
