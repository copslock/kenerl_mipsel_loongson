Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Jul 2008 16:26:13 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:27626 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28577897AbYGWPXi (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 23 Jul 2008 16:23:38 +0100
Received: from localhost.localdomain (p3049-ipad205funabasi.chiba.ocn.ne.jp [222.146.98.49])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id BACFEA9F1; Thu, 24 Jul 2008 00:23:30 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 08/10] txx9: Make tx3927-specific code more independent
Date:	Thu, 24 Jul 2008 00:25:19 +0900
Message-Id: <1216826721-28259-8-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.5.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Make some TX3927 SoC specific code independent from board specific code.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/Makefile       |    1 +
 arch/mips/txx9/generic/irq_tx3927.c   |   25 ++++++
 arch/mips/txx9/generic/setup_tx3927.c |  141 +++++++++++++++++++++++++++++++++
 arch/mips/txx9/jmr3927/irq.c          |   43 +++-------
 arch/mips/txx9/jmr3927/setup.c        |  136 ++++---------------------------
 include/asm-mips/txx9/jmr3927.h       |    2 -
 include/asm-mips/txx9/tx3927.h        |   12 +++-
 7 files changed, 207 insertions(+), 153 deletions(-)
 create mode 100644 arch/mips/txx9/generic/irq_tx3927.c
 create mode 100644 arch/mips/txx9/generic/setup_tx3927.c

diff --git a/arch/mips/txx9/generic/Makefile b/arch/mips/txx9/generic/Makefile
index 9c12077..57ed07b 100644
--- a/arch/mips/txx9/generic/Makefile
+++ b/arch/mips/txx9/generic/Makefile
@@ -4,6 +4,7 @@
 
 obj-y	+= setup.o
 obj-$(CONFIG_PCI)	+= pci.o
+obj-$(CONFIG_SOC_TX3927)	+= setup_tx3927.o irq_tx3927.o
 obj-$(CONFIG_SOC_TX4927)	+= mem_tx4927.o setup_tx4927.o irq_tx4927.o
 obj-$(CONFIG_SOC_TX4938)	+= mem_tx4927.o setup_tx4938.o irq_tx4938.o
 obj-$(CONFIG_TOSHIBA_FPCIB0)	+= smsc_fdc37m81x.o
diff --git a/arch/mips/txx9/generic/irq_tx3927.c b/arch/mips/txx9/generic/irq_tx3927.c
new file mode 100644
index 0000000..c683f59
--- /dev/null
+++ b/arch/mips/txx9/generic/irq_tx3927.c
@@ -0,0 +1,25 @@
+/*
+ * Common tx3927 irq handler
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright 2001 MontaVista Software Inc.
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ */
+#include <linux/init.h>
+#include <asm/txx9irq.h>
+#include <asm/txx9/tx3927.h>
+
+void __init tx3927_irq_init(void)
+{
+	int i;
+
+	txx9_irq_init(TX3927_IRC_REG);
+	/* raise priority for timers, sio */
+	for (i = 0; i < TX3927_NR_TMR; i++)
+		txx9_irq_set_pri(TX3927_IR_TMR(i), 6);
+	for (i = 0; i < TX3927_NR_SIO; i++)
+		txx9_irq_set_pri(TX3927_IR_SIO(i), 7);
+}
diff --git a/arch/mips/txx9/generic/setup_tx3927.c b/arch/mips/txx9/generic/setup_tx3927.c
new file mode 100644
index 0000000..0d09a0f
--- /dev/null
+++ b/arch/mips/txx9/generic/setup_tx3927.c
@@ -0,0 +1,141 @@
+/*
+ * TX3927 setup routines
+ * Based on linux/arch/mips/txx9/jmr3927/setup.c
+ *
+ * Copyright 2001 MontaVista Software Inc.
+ * Copyright (C) 2000-2001 Toshiba Corporation
+ * Copyright (C) 2007 Ralf Baechle (ralf@linux-mips.org)
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
+#include <asm/mipsregs.h>
+#include <asm/txx9irq.h>
+#include <asm/txx9tmr.h>
+#include <asm/txx9pio.h>
+#include <asm/txx9/generic.h>
+#include <asm/txx9/tx3927.h>
+
+void __init tx3927_wdt_init(void)
+{
+	txx9_wdt_init(TX3927_TMR_REG(2));
+}
+
+void __init tx3927_setup(void)
+{
+	int i;
+	unsigned int conf;
+
+	/* don't enable - see errata */
+	txx9_ccfg_toeon = 0;
+	if (strstr(prom_getcmdline(), "toeon") != NULL)
+		txx9_ccfg_toeon = 1;
+
+	txx9_reg_res_init(TX3927_REV_PCODE(), TX3927_REG_BASE,
+			  TX3927_REG_SIZE);
+
+	/* SDRAMC,ROMC are configured by PROM */
+	for (i = 0; i < 8; i++) {
+		if (!(tx3927_romcptr->cr[i] & 0x8))
+			continue;	/* disabled */
+		txx9_ce_res[i].start = (unsigned long)TX3927_ROMC_BA(i);
+		txx9_ce_res[i].end =
+			txx9_ce_res[i].start + TX3927_ROMC_SIZE(i) - 1;
+		request_resource(&iomem_resource, &txx9_ce_res[i]);
+	}
+
+	/* clocks */
+	txx9_gbus_clock = txx9_cpu_clock / 2;
+	/* change default value to udelay/mdelay take reasonable time */
+	loops_per_jiffy = txx9_cpu_clock / HZ / 2;
+
+	/* CCFG */
+	/* enable Timeout BusError */
+	if (txx9_ccfg_toeon)
+		tx3927_ccfgptr->ccfg |= TX3927_CCFG_TOE;
+
+	/* clear BusErrorOnWrite flag */
+	tx3927_ccfgptr->ccfg &= ~TX3927_CCFG_BEOW;
+	if (read_c0_conf() & TX39_CONF_WBON)
+		/* Disable PCI snoop */
+		tx3927_ccfgptr->ccfg &= ~TX3927_CCFG_PSNP;
+	else
+		/* Enable PCI SNOOP - with write through only */
+		tx3927_ccfgptr->ccfg |= TX3927_CCFG_PSNP;
+	/* do reset on watchdog */
+	tx3927_ccfgptr->ccfg |= TX3927_CCFG_WR;
+
+	printk(KERN_INFO "TX3927 -- CRIR:%08lx CCFG:%08lx PCFG:%08lx\n",
+	       tx3927_ccfgptr->crir,
+	       tx3927_ccfgptr->ccfg, tx3927_ccfgptr->pcfg);
+
+	/* TMR */
+	for (i = 0; i < TX3927_NR_TMR; i++)
+		txx9_tmr_init(TX3927_TMR_REG(i));
+
+	/* DMA */
+	tx3927_dmaptr->mcr = 0;
+	for (i = 0; i < ARRAY_SIZE(tx3927_dmaptr->ch); i++) {
+		/* reset channel */
+		tx3927_dmaptr->ch[i].ccr = TX3927_DMA_CCR_CHRST;
+		tx3927_dmaptr->ch[i].ccr = 0;
+	}
+	/* enable DMA */
+#ifdef __BIG_ENDIAN
+	tx3927_dmaptr->mcr = TX3927_DMA_MCR_MSTEN;
+#else
+	tx3927_dmaptr->mcr = TX3927_DMA_MCR_MSTEN | TX3927_DMA_MCR_LE;
+#endif
+
+	/* PIO */
+	__raw_writel(0, &tx3927_pioptr->maskcpu);
+	__raw_writel(0, &tx3927_pioptr->maskext);
+	txx9_gpio_init(TX3927_PIO_REG, 0, 16);
+
+	conf = read_c0_conf();
+	if (!(conf & TX39_CONF_ICE))
+		printk(KERN_INFO "TX3927 I-Cache disabled.\n");
+	if (!(conf & TX39_CONF_DCE))
+		printk(KERN_INFO "TX3927 D-Cache disabled.\n");
+	else if (!(conf & TX39_CONF_WBON))
+		printk(KERN_INFO "TX3927 D-Cache WriteThrough.\n");
+	else if (!(conf & TX39_CONF_CWFON))
+		printk(KERN_INFO "TX3927 D-Cache WriteBack.\n");
+	else
+		printk(KERN_INFO "TX3927 D-Cache WriteBack (CWF) .\n");
+}
+
+void __init tx3927_time_init(unsigned int evt_tmrnr, unsigned int src_tmrnr)
+{
+	txx9_clockevent_init(TX3927_TMR_REG(evt_tmrnr),
+			     TXX9_IRQ_BASE + TX3927_IR_TMR(evt_tmrnr),
+			     TXX9_IMCLK);
+	txx9_clocksource_init(TX3927_TMR_REG(src_tmrnr), TXX9_IMCLK);
+}
+
+void __init tx3927_setup_serial(unsigned int cts_mask)
+{
+#ifdef CONFIG_SERIAL_TXX9
+	int i;
+	struct uart_port req;
+
+	for (i = 0; i < 2; i++) {
+		memset(&req, 0, sizeof(req));
+		req.line = i;
+		req.iotype = UPIO_MEM;
+		req.membase = (unsigned char __iomem *)TX3927_SIO_REG(i);
+		req.mapbase = TX3927_SIO_REG(i);
+		req.irq = TXX9_IRQ_BASE + TX3927_IR_SIO(i);
+		if (!((1 << i) & cts_mask))
+			req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
+		req.uartclk = TXX9_IMCLK;
+		early_serial_txx9_setup(&req);
+	}
+#endif /* CONFIG_SERIAL_TXX9 */
+}
diff --git a/arch/mips/txx9/jmr3927/irq.c b/arch/mips/txx9/jmr3927/irq.c
index f3b6023..68f7436 100644
--- a/arch/mips/txx9/jmr3927/irq.c
+++ b/arch/mips/txx9/jmr3927/irq.c
@@ -46,13 +46,6 @@
 #error JMR3927_IRQ_END > NR_IRQS
 #endif
 
-static unsigned char irc_level[TX3927_NUM_IR] = {
-	5, 5, 5, 5, 5, 5,	/* INT[5:0] */
-	7, 7,			/* SIO */
-	5, 5, 5, 0, 0,		/* DMA, PIO, PCI */
-	6, 6, 6			/* TMR */
-};
-
 /*
  * CP0_STATUS is a thread's resource (saved/restored on context switch).
  * So disable_irq/enable_irq MUST handle IOC/IRC registers.
@@ -103,10 +96,18 @@ static int jmr3927_irq_dispatch(int pending)
 	return irq;
 }
 
-static void __init jmr3927_irq_init(void);
+static struct irq_chip jmr3927_irq_ioc = {
+	.name = "jmr3927_ioc",
+	.ack = mask_irq_ioc,
+	.mask = mask_irq_ioc,
+	.mask_ack = mask_irq_ioc,
+	.unmask = unmask_irq_ioc,
+};
 
 void __init jmr3927_irq_setup(void)
 {
+	int i;
+
 	txx9_irq_dispatch = jmr3927_irq_dispatch;
 	/* Now, interrupt control disabled, */
 	/* all IRC interrupts are masked, */
@@ -122,30 +123,10 @@ void __init jmr3927_irq_setup(void)
 	/* clear PCI Reset interrupts */
 	jmr3927_ioc_reg_out(0, JMR3927_IOC_RESET_ADDR);
 
-	jmr3927_irq_init();
+	tx3927_irq_init();
+	for (i = JMR3927_IRQ_IOC; i < JMR3927_IRQ_IOC + JMR3927_NR_IRQ_IOC; i++)
+		set_irq_chip_and_handler(i, &jmr3927_irq_ioc, handle_level_irq);
 
 	/* setup IOC interrupt 1 (PCI, MODEM) */
 	set_irq_chained_handler(JMR3927_IRQ_IOCINT, handle_simple_irq);
-
-	/* enable all CPU interrupt bits. */
-	set_c0_status(ST0_IM);	/* IE bit is still 0. */
-}
-
-static struct irq_chip jmr3927_irq_ioc = {
-	.name = "jmr3927_ioc",
-	.ack = mask_irq_ioc,
-	.mask = mask_irq_ioc,
-	.mask_ack = mask_irq_ioc,
-	.unmask = unmask_irq_ioc,
-};
-
-static void __init jmr3927_irq_init(void)
-{
-	u32 i;
-
-	txx9_irq_init(TX3927_IRC_REG);
-	for (i = 0; i < TXx9_MAX_IR; i++)
-		txx9_irq_set_pri(i, irc_level[i]);
-	for (i = JMR3927_IRQ_IOC; i < JMR3927_IRQ_IOC + JMR3927_NR_IRQ_IOC; i++)
-		set_irq_chip_and_handler(i, &jmr3927_irq_ioc, handle_level_irq);
 }
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index ae34e9a..7378a83 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -34,20 +34,13 @@
 #include <linux/delay.h>
 #include <linux/platform_device.h>
 #include <linux/gpio.h>
-#ifdef CONFIG_SERIAL_TXX9
-#include <linux/serial_core.h>
-#endif
-#include <asm/txx9tmr.h>
-#include <asm/txx9pio.h>
 #include <asm/reboot.h>
+#include <asm/txx9pio.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/pci.h>
 #include <asm/txx9/jmr3927.h>
 #include <asm/mipsregs.h>
 
-/* don't enable - see errata */
-static int jmr3927_ccfg_toeon;
-
 static void jmr3927_machine_restart(char *command)
 {
 	local_irq_disable();
@@ -65,10 +58,7 @@ static void jmr3927_machine_restart(char *command)
 
 static void __init jmr3927_time_init(void)
 {
-	txx9_clockevent_init(TX3927_TMR_REG(0),
-			     JMR3927_IRQ_IRC_TMR(0),
-			     JMR3927_IMCLK);
-	txx9_clocksource_init(TX3927_TMR_REG(1), JMR3927_IMCLK);
+	tx3927_time_init(0, 1);
 }
 
 #define DO_WRITE_THROUGH
@@ -118,34 +108,12 @@ static void __init jmr3927_mem_setup(void)
 	jmr3927_board_init();
 
 	argptr = prom_getcmdline();
-
-	if ((argptr = strstr(argptr, "toeon")) != NULL)
-		jmr3927_ccfg_toeon = 1;
-	argptr = prom_getcmdline();
 	if ((argptr = strstr(argptr, "ip=")) == NULL) {
 		argptr = prom_getcmdline();
 		strcat(argptr, " ip=bootp");
 	}
 
-#ifdef CONFIG_SERIAL_TXX9
-	{
-		extern int early_serial_txx9_setup(struct uart_port *port);
-		int i;
-		struct uart_port req;
-		for(i = 0; i < 2; i++) {
-			memset(&req, 0, sizeof(req));
-			req.line = i;
-			req.iotype = UPIO_MEM;
-			req.membase = (unsigned char __iomem *)TX3927_SIO_REG(i);
-			req.mapbase = TX3927_SIO_REG(i);
-			req.irq = i == 0 ?
-				JMR3927_IRQ_IRC_SIO0 : JMR3927_IRQ_IRC_SIO1;
-			if (i == 0)
-				req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
-			req.uartclk = JMR3927_IMCLK;
-			early_serial_txx9_setup(&req);
-		}
-	}
+	tx3927_setup_serial(1 << 1); /* ch1: noCTS */
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
 	argptr = prom_getcmdline();
 	if ((argptr = strstr(argptr, "console=")) == NULL) {
@@ -153,11 +121,8 @@ static void __init jmr3927_mem_setup(void)
 		strcat(argptr, " console=ttyS1,115200");
 	}
 #endif
-#endif
 }
 
-static void tx3927_setup(void);
-
 static void __init jmr3927_pci_setup(void)
 {
 #ifdef CONFIG_PCI
@@ -184,27 +149,7 @@ static void __init jmr3927_pci_setup(void)
 
 static void __init jmr3927_board_init(void)
 {
-	tx3927_setup();
-	jmr3927_pci_setup();
-
-	/* SIO0 DTR on */
-	jmr3927_ioc_reg_out(0, JMR3927_IOC_DTR_ADDR);
-
-	jmr3927_led_set(0);
-
-	printk("JMR-TX3927 (Rev %d) --- IOC(Rev %d) DIPSW:%d,%d,%d,%d\n",
-	       jmr3927_ioc_reg_in(JMR3927_IOC_BREV_ADDR) & JMR3927_REV_MASK,
-	       jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR) & JMR3927_REV_MASK,
-	       jmr3927_dipsw1(), jmr3927_dipsw2(),
-	       jmr3927_dipsw3(), jmr3927_dipsw4());
-}
-
-static void __init tx3927_setup(void)
-{
-	int i;
-
 	txx9_cpu_clock = JMR3927_CORECLK;
-	txx9_gbus_clock = JMR3927_GBUSCLK;
 	/* SDRAMC are configured by PROM */
 
 	/* ROMC */
@@ -213,74 +158,32 @@ static void __init tx3927_setup(void)
 	tx3927_romcptr->cr[3] = JMR3927_ROMCE3 | 0x0003f698;
 	tx3927_romcptr->cr[5] = JMR3927_ROMCE5 | 0x0000f218;
 
-	/* CCFG */
-	/* enable Timeout BusError */
-	if (jmr3927_ccfg_toeon)
-		tx3927_ccfgptr->ccfg |= TX3927_CCFG_TOE;
-
-	/* clear BusErrorOnWrite flag */
-	tx3927_ccfgptr->ccfg &= ~TX3927_CCFG_BEOW;
-	/* Disable PCI snoop */
-	tx3927_ccfgptr->ccfg &= ~TX3927_CCFG_PSNP;
-	/* do reset on watchdog */
-	tx3927_ccfgptr->ccfg |= TX3927_CCFG_WR;
-
-#ifdef DO_WRITE_THROUGH
-	/* Enable PCI SNOOP - with write through only */
-	tx3927_ccfgptr->ccfg |= TX3927_CCFG_PSNP;
-#endif
-
 	/* Pin selection */
 	tx3927_ccfgptr->pcfg &= ~TX3927_PCFG_SELALL;
 	tx3927_ccfgptr->pcfg |=
 		TX3927_PCFG_SELSIOC(0) | TX3927_PCFG_SELSIO_ALL |
 		(TX3927_PCFG_SELDMA_ALL & ~TX3927_PCFG_SELDMA(1));
 
-	printk("TX3927 -- CRIR:%08lx CCFG:%08lx PCFG:%08lx\n",
-	       tx3927_ccfgptr->crir,
-	       tx3927_ccfgptr->ccfg, tx3927_ccfgptr->pcfg);
-
-	/* TMR */
-	for (i = 0; i < TX3927_NR_TMR; i++)
-		txx9_tmr_init(TX3927_TMR_REG(i));
-
-	/* DMA */
-	tx3927_dmaptr->mcr = 0;
-	for (i = 0; i < ARRAY_SIZE(tx3927_dmaptr->ch); i++) {
-		/* reset channel */
-		tx3927_dmaptr->ch[i].ccr = TX3927_DMA_CCR_CHRST;
-		tx3927_dmaptr->ch[i].ccr = 0;
-	}
-	/* enable DMA */
-#ifdef __BIG_ENDIAN
-	tx3927_dmaptr->mcr = TX3927_DMA_MCR_MSTEN;
-#else
-	tx3927_dmaptr->mcr = TX3927_DMA_MCR_MSTEN | TX3927_DMA_MCR_LE;
-#endif
+	tx3927_setup();
 
-	/* PIO */
 	/* PIO[15:12] connected to LEDs */
 	__raw_writel(0x0000f000, &tx3927_pioptr->dir);
-	__raw_writel(0, &tx3927_pioptr->maskcpu);
-	__raw_writel(0, &tx3927_pioptr->maskext);
-	txx9_gpio_init(TX3927_PIO_REG, 0, 16);
 	gpio_request(11, "dipsw1");
 	gpio_request(10, "dipsw2");
-	{
-		unsigned int conf;
 
-	conf = read_c0_conf();
-               if (!(conf & TX39_CONF_ICE))
-                       printk("TX3927 I-Cache disabled.\n");
-               if (!(conf & TX39_CONF_DCE))
-                       printk("TX3927 D-Cache disabled.\n");
-               else if (!(conf & TX39_CONF_WBON))
-                       printk("TX3927 D-Cache WriteThrough.\n");
-               else if (!(conf & TX39_CONF_CWFON))
-                       printk("TX3927 D-Cache WriteBack.\n");
-               else
-                       printk("TX3927 D-Cache WriteBack (CWF) .\n");
-	}
+	jmr3927_pci_setup();
+
+	/* SIO0 DTR on */
+	jmr3927_ioc_reg_out(0, JMR3927_IOC_DTR_ADDR);
+
+	jmr3927_led_set(0);
+
+	printk(KERN_INFO
+	       "JMR-TX3927 (Rev %d) --- IOC(Rev %d) DIPSW:%d,%d,%d,%d\n",
+	       jmr3927_ioc_reg_in(JMR3927_IOC_BREV_ADDR) & JMR3927_REV_MASK,
+	       jmr3927_ioc_reg_in(JMR3927_IOC_REV_ADDR) & JMR3927_REV_MASK,
+	       jmr3927_dipsw1(), jmr3927_dipsw2(),
+	       jmr3927_dipsw3(), jmr3927_dipsw4());
 }
 
 /* This trick makes rtc-ds1742 driver usable as is. */
@@ -308,11 +211,6 @@ static int __init jmr3927_rtc_init(void)
 	return IS_ERR(dev) ? PTR_ERR(dev) : 0;
 }
 
-static void __init tx3927_wdt_init(void)
-{
-	txx9_wdt_init(TX3927_TMR_REG(2));
-}
-
 static void __init jmr3927_device_init(void)
 {
 	__swizzle_addr_b = jmr3927_swizzle_addr_b;
diff --git a/include/asm-mips/txx9/jmr3927.h b/include/asm-mips/txx9/jmr3927.h
index d6eb1b6..a409c44 100644
--- a/include/asm-mips/txx9/jmr3927.h
+++ b/include/asm-mips/txx9/jmr3927.h
@@ -149,8 +149,6 @@
 
 /* Clocks */
 #define JMR3927_CORECLK	132710400	/* 132.7MHz */
-#define JMR3927_GBUSCLK	(JMR3927_CORECLK / 2)	/* 66.35MHz */
-#define JMR3927_IMCLK	(JMR3927_CORECLK / 4)	/* 33.17MHz */
 
 /*
  * TX3927 Pin Configuration:
diff --git a/include/asm-mips/txx9/tx3927.h b/include/asm-mips/txx9/tx3927.h
index 8d62b1b..0bac37f 100644
--- a/include/asm-mips/txx9/tx3927.h
+++ b/include/asm-mips/txx9/tx3927.h
@@ -11,6 +11,7 @@
 #include <asm/txx9/txx927.h>
 
 #define TX3927_REG_BASE	0xfffe0000UL
+#define TX3927_REG_SIZE	0x00010000
 #define TX3927_SDRAMC_REG	(TX3927_REG_BASE + 0x8000)
 #define TX3927_ROMC_REG		(TX3927_REG_BASE + 0x9000)
 #define TX3927_DMA_REG		(TX3927_REG_BASE + 0xb000)
@@ -319,13 +320,22 @@ struct tx3927_ccfg_reg {
 #define tx3927_dmaptr		((struct tx3927_dma_reg *)TX3927_DMA_REG)
 #define tx3927_pcicptr		((struct tx3927_pcic_reg *)TX3927_PCIC_REG)
 #define tx3927_ccfgptr		((struct tx3927_ccfg_reg *)TX3927_CCFG_REG)
-#define tx3927_tmrptr(ch)	((struct txx927_tmr_reg *)TX3927_TMR_REG(ch))
 #define tx3927_sioptr(ch)	((struct txx927_sio_reg *)TX3927_SIO_REG(ch))
 #define tx3927_pioptr		((struct txx9_pio_reg __iomem *)TX3927_PIO_REG)
 
+#define TX3927_REV_PCODE()	(tx3927_ccfgptr->crir >> 16)
+#define TX3927_ROMC_BA(ch)	(tx3927_romcptr->cr[(ch)] & 0xfff00000)
+#define TX3927_ROMC_SIZE(ch)	\
+	(0x00100000 << ((tx3927_romcptr->cr[(ch)] >> 8) & 0xf))
+
+void tx3927_wdt_init(void);
+void tx3927_setup(void);
+void tx3927_time_init(unsigned int evt_tmrnr, unsigned int src_tmrnr);
+void tx3927_setup_serial(unsigned int cts_mask);
 struct pci_controller;
 void __init tx3927_pcic_setup(struct pci_controller *channel,
 			      unsigned long sdram_size, int extarb);
 void tx3927_setup_pcierr_irq(void);
+void tx3927_irq_init(void);
 
 #endif /* __ASM_TXX9_TX3927_H */
-- 
1.5.5.5
