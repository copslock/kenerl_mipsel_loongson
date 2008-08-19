Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 14:58:58 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:25809 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28580950AbYHSNz0 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 14:55:26 +0100
Received: from localhost.localdomain (p6195-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 4C459B699; Tue, 19 Aug 2008 22:55:20 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 11/14] TXx9: Default machine_restart using watchdog reset
Date:	Tue, 19 Aug 2008 22:55:15 +0900
Message-Id: <1219154118-21193-11-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20269
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

Add default machine_restart routine using watchdog reset of TX4927 and
TX4938.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c        |   15 +++++++++++++++
 arch/mips/txx9/generic/setup_tx4927.c |   28 ++++++++++++++++++++++++++++
 arch/mips/txx9/generic/setup_tx4938.c |   28 ++++++++++++++++++++++++++++
 include/asm-mips/txx9/generic.h       |    1 +
 4 files changed, 72 insertions(+), 0 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index a471a28..0f91e83 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -29,6 +29,7 @@
 #include <asm/r4kcache.h>
 #include <asm/txx9/generic.h>
 #include <asm/txx9/pci.h>
+#include <asm/txx9tmr.h>
 #ifdef CONFIG_CPU_TX49XX
 #include <asm/txx9/tx4938.h>
 #endif
@@ -443,6 +444,20 @@ void __init txx9_wdt_init(unsigned long base)
 	platform_device_register_simple("txx9wdt", -1, &res, 1);
 }
 
+void txx9_wdt_now(unsigned long base)
+{
+	struct txx9_tmr_reg __iomem *tmrptr =
+		ioremap(base, sizeof(struct txx9_tmr_reg));
+	/* disable watch dog timer */
+	__raw_writel(TXx9_TMWTMR_WDIS | TXx9_TMWTMR_TWC, &tmrptr->wtmr);
+	__raw_writel(0, &tmrptr->tcr);
+	/* kick watchdog */
+	__raw_writel(TXx9_TMWTMR_TWIE, &tmrptr->wtmr);
+	__raw_writel(1, &tmrptr->cpra); /* immediate */
+	__raw_writel(TXx9_TMTCR_TCE | TXx9_TMTCR_CCDE | TXx9_TMTCR_TMODE_WDOG,
+		     &tmrptr->tcr);
+}
+
 /* SPI support */
 void __init txx9_spi_init(int busid, unsigned long base, int irq)
 {
diff --git a/arch/mips/txx9/generic/setup_tx4927.c b/arch/mips/txx9/generic/setup_tx4927.c
index 0840ef9..7189675 100644
--- a/arch/mips/txx9/generic/setup_tx4927.c
+++ b/arch/mips/txx9/generic/setup_tx4927.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/param.h>
 #include <linux/mtd/physmap.h>
+#include <asm/reboot.h>
 #include <asm/txx9irq.h>
 #include <asm/txx9tmr.h>
 #include <asm/txx9pio.h>
@@ -23,6 +24,10 @@
 
 static void __init tx4927_wdr_init(void)
 {
+	/* report watchdog reset status */
+	if (____raw_readq(&tx4927_ccfgptr->ccfg) & TX4927_CCFG_WDRST)
+		pr_warning("Watchdog reset detected at 0x%lx\n",
+			   read_c0_errorepc());
 	/* clear WatchDogReset (W1C) */
 	tx4927_ccfg_set(TX4927_CCFG_WDRST);
 	/* do reset on watchdog */
@@ -34,6 +39,27 @@ void __init tx4927_wdt_init(void)
 	txx9_wdt_init(TX4927_TMR_REG(2) & 0xfffffffffULL);
 }
 
+static void tx4927_machine_restart(char *command)
+{
+	local_irq_disable();
+	pr_emerg("Rebooting (with %s watchdog reset)...\n",
+		 (____raw_readq(&tx4927_ccfgptr->ccfg) & TX4927_CCFG_WDREXEN) ?
+		 "external" : "internal");
+	/* clear watchdog status */
+	tx4927_ccfg_set(TX4927_CCFG_WDRST);	/* W1C */
+	txx9_wdt_now(TX4927_TMR_REG(2) & 0xfffffffffULL);
+	while (!(____raw_readq(&tx4927_ccfgptr->ccfg) & TX4927_CCFG_WDRST))
+		;
+	mdelay(10);
+	if (____raw_readq(&tx4927_ccfgptr->ccfg) & TX4927_CCFG_WDREXEN) {
+		pr_emerg("Rebooting (with internal watchdog reset)...\n");
+		/* External WDRST failed.  Do internal watchdog reset */
+		tx4927_ccfg_clear(TX4927_CCFG_WDREXEN);
+	}
+	/* fallback */
+	(*_machine_halt)();
+}
+
 static struct resource tx4927_sdram_resource[4];
 
 void __init tx4927_setup(void)
@@ -169,6 +195,8 @@ void __init tx4927_setup(void)
 	txx9_gpio_init(TX4927_PIO_REG & 0xfffffffffULL, 0, TX4927_NUM_PIO);
 	__raw_writel(0, &tx4927_pioptr->maskcpu);
 	__raw_writel(0, &tx4927_pioptr->maskext);
+
+	_machine_restart = tx4927_machine_restart;
 }
 
 void __init tx4927_time_init(unsigned int tmrnr)
diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
index 630a7aa..4fbc85a 100644
--- a/arch/mips/txx9/generic/setup_tx4938.c
+++ b/arch/mips/txx9/generic/setup_tx4938.c
@@ -15,6 +15,7 @@
 #include <linux/delay.h>
 #include <linux/param.h>
 #include <linux/mtd/physmap.h>
+#include <asm/reboot.h>
 #include <asm/txx9irq.h>
 #include <asm/txx9tmr.h>
 #include <asm/txx9pio.h>
@@ -23,6 +24,10 @@
 
 static void __init tx4938_wdr_init(void)
 {
+	/* report watchdog reset status */
+	if (____raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_WDRST)
+		pr_warning("Watchdog reset detected at 0x%lx\n",
+			   read_c0_errorepc());
 	/* clear WatchDogReset (W1C) */
 	tx4938_ccfg_set(TX4938_CCFG_WDRST);
 	/* do reset on watchdog */
@@ -34,6 +39,27 @@ void __init tx4938_wdt_init(void)
 	txx9_wdt_init(TX4938_TMR_REG(2) & 0xfffffffffULL);
 }
 
+static void tx4938_machine_restart(char *command)
+{
+	local_irq_disable();
+	pr_emerg("Rebooting (with %s watchdog reset)...\n",
+		 (____raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_WDREXEN) ?
+		 "external" : "internal");
+	/* clear watchdog status */
+	tx4938_ccfg_set(TX4938_CCFG_WDRST);	/* W1C */
+	txx9_wdt_now(TX4938_TMR_REG(2) & 0xfffffffffULL);
+	while (!(____raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_WDRST))
+		;
+	mdelay(10);
+	if (____raw_readq(&tx4938_ccfgptr->ccfg) & TX4938_CCFG_WDREXEN) {
+		pr_emerg("Rebooting (with internal watchdog reset)...\n");
+		/* External WDRST failed.  Do internal watchdog reset */
+		tx4938_ccfg_clear(TX4938_CCFG_WDREXEN);
+	}
+	/* fallback */
+	(*_machine_halt)();
+}
+
 static struct resource tx4938_sdram_resource[4];
 static struct resource tx4938_sram_resource;
 
@@ -229,6 +255,8 @@ void __init tx4938_setup(void)
 				   TX4938_CLKCTR_ETH1CKD);
 		}
 	}
+
+	_machine_restart = tx4938_machine_restart;
 }
 
 void __init tx4938_time_init(unsigned int tmrnr)
diff --git a/include/asm-mips/txx9/generic.h b/include/asm-mips/txx9/generic.h
index 1982c44..1e1a9f2 100644
--- a/include/asm-mips/txx9/generic.h
+++ b/include/asm-mips/txx9/generic.h
@@ -45,6 +45,7 @@ extern int (*txx9_irq_dispatch)(int pending);
 char *prom_getcmdline(void);
 const char *prom_getenv(const char *name);
 void txx9_wdt_init(unsigned long base);
+void txx9_wdt_now(unsigned long base);
 void txx9_spi_init(int busid, unsigned long base, int irq);
 void txx9_ethaddr_init(unsigned int id, unsigned char *ethaddr);
 void txx9_sio_init(unsigned long baseaddr, int irq,
-- 
1.5.6.3
