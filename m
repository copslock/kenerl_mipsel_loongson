Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Jul 2008 15:06:18 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:15858 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20031841AbYGYOGQ (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 25 Jul 2008 15:06:16 +0100
Received: from localhost.localdomain (p3225-ipad203funabasi.chiba.ocn.ne.jp [222.146.82.225])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 34B9CACB6; Fri, 25 Jul 2008 23:06:11 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH] txx9: Unify serial_txx9 setup
Date:	Fri, 25 Jul 2008 23:08:06 +0900
Message-Id: <1216994886-6559-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.5.5
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19956
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Unify calling of early_serial_txx9_setup.
* Use dedicated serial clock on RBTX4938.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/generic/setup.c        |   24 ++++++++++++++++++++++++
 arch/mips/txx9/generic/setup_tx3927.c |   25 +++++++------------------
 arch/mips/txx9/generic/setup_tx4927.c |   23 ++++++-----------------
 arch/mips/txx9/generic/setup_tx4938.c |   18 ++++--------------
 arch/mips/txx9/jmr3927/setup.c        |    2 +-
 arch/mips/txx9/rbtx4927/setup.c       |    2 +-
 arch/mips/txx9/rbtx4938/setup.c       |    2 +-
 include/asm-mips/txx9/generic.h       |    2 ++
 include/asm-mips/txx9/tx3927.h        |    2 +-
 include/asm-mips/txx9/tx4927.h        |    2 +-
 include/asm-mips/txx9/tx4938.h        |    2 +-
 11 files changed, 49 insertions(+), 55 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index b136c66..94ce1a5 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -21,6 +21,7 @@
 #include <linux/err.h>
 #include <linux/gpio.h>
 #include <linux/platform_device.h>
+#include <linux/serial_core.h>
 #include <asm/bootinfo.h>
 #include <asm/time.h>
 #include <asm/reboot.h>
@@ -247,6 +248,29 @@ void __init txx9_ethaddr_init(unsigned int id, unsigned char *ethaddr)
 		platform_device_put(pdev);
 }
 
+void __init txx9_sio_init(unsigned long baseaddr, int irq,
+			  unsigned int line, unsigned int sclk, int nocts)
+{
+#ifdef CONFIG_SERIAL_TXX9
+	struct uart_port req;
+
+	memset(&req, 0, sizeof(req));
+	req.line = line;
+	req.iotype = UPIO_MEM;
+	req.membase = ioremap(baseaddr, 0x24);
+	req.mapbase = baseaddr;
+	req.irq = irq;
+	if (!nocts)
+		req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
+	if (sclk) {
+		req.flags |= UPF_MAGIC_MULTIPLIER /*USE_SCLK*/;
+		req.uartclk = sclk;
+	} else
+		req.uartclk = TXX9_IMCLK;
+	early_serial_txx9_setup(&req);
+#endif /* CONFIG_SERIAL_TXX9 */
+}
+
 /* wrappers */
 void __init plat_mem_setup(void)
 {
diff --git a/arch/mips/txx9/generic/setup_tx3927.c b/arch/mips/txx9/generic/setup_tx3927.c
index 0d09a0f..7bd963d 100644
--- a/arch/mips/txx9/generic/setup_tx3927.c
+++ b/arch/mips/txx9/generic/setup_tx3927.c
@@ -13,8 +13,8 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
-#include <linux/serial_core.h>
 #include <linux/param.h>
+#include <linux/io.h>
 #include <asm/mipsregs.h>
 #include <asm/txx9irq.h>
 #include <asm/txx9tmr.h>
@@ -119,23 +119,12 @@ void __init tx3927_time_init(unsigned int evt_tmrnr, unsigned int src_tmrnr)
 	txx9_clocksource_init(TX3927_TMR_REG(src_tmrnr), TXX9_IMCLK);
 }
 
-void __init tx3927_setup_serial(unsigned int cts_mask)
+void __init tx3927_sio_init(unsigned int sclk, unsigned int cts_mask)
 {
-#ifdef CONFIG_SERIAL_TXX9
 	int i;
-	struct uart_port req;
-
-	for (i = 0; i < 2; i++) {
-		memset(&req, 0, sizeof(req));
-		req.line = i;
-		req.iotype = UPIO_MEM;
-		req.membase = (unsigned char __iomem *)TX3927_SIO_REG(i);
-		req.mapbase = TX3927_SIO_REG(i);
-		req.irq = TXX9_IRQ_BASE + TX3927_IR_SIO(i);
-		if (!((1 << i) & cts_mask))
-			req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
-		req.uartclk = TXX9_IMCLK;
-		early_serial_txx9_setup(&req);
-	}
-#endif /* CONFIG_SERIAL_TXX9 */
+
+	for (i = 0; i < 2; i++)
+		txx9_sio_init(TX3927_SIO_REG(i),
+			      TXX9_IRQ_BASE + TX3927_IR_SIO(i),
+			      i, sclk, (1 << i) & cts_mask);
 }
diff --git a/arch/mips/txx9/generic/setup_tx4927.c b/arch/mips/txx9/generic/setup_tx4927.c
index b42c855..f80d4b7 100644
--- a/arch/mips/txx9/generic/setup_tx4927.c
+++ b/arch/mips/txx9/generic/setup_tx4927.c
@@ -13,7 +13,6 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
-#include <linux/serial_core.h>
 #include <linux/param.h>
 #include <asm/txx9irq.h>
 #include <asm/txx9tmr.h>
@@ -178,22 +177,12 @@ void __init tx4927_time_init(unsigned int tmrnr)
 				     TXX9_IMCLK);
 }
 
-void __init tx4927_setup_serial(void)
+void __init tx4927_sio_init(unsigned int sclk, unsigned int cts_mask)
 {
-#ifdef CONFIG_SERIAL_TXX9
 	int i;
-	struct uart_port req;
-
-	for (i = 0; i < 2; i++) {
-		memset(&req, 0, sizeof(req));
-		req.line = i;
-		req.iotype = UPIO_MEM;
-		req.membase = (unsigned char __iomem *)TX4927_SIO_REG(i);
-		req.mapbase = TX4927_SIO_REG(i) & 0xfffffffffULL;
-		req.irq = TXX9_IRQ_BASE + TX4927_IR_SIO(i);
-		req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
-		req.uartclk = TXX9_IMCLK;
-		early_serial_txx9_setup(&req);
-	}
-#endif /* CONFIG_SERIAL_TXX9 */
+
+	for (i = 0; i < 2; i++)
+		txx9_sio_init(TX4927_SIO_REG(i) & 0xfffffffffULL,
+			      TXX9_IRQ_BASE + TX4927_IR_SIO(i),
+			      i, sclk, (1 << i) & cts_mask);
 }
diff --git a/arch/mips/txx9/generic/setup_tx4938.c b/arch/mips/txx9/generic/setup_tx4938.c
index 1ceace4..f3040b9 100644
--- a/arch/mips/txx9/generic/setup_tx4938.c
+++ b/arch/mips/txx9/generic/setup_tx4938.c
@@ -13,7 +13,6 @@
 #include <linux/init.h>
 #include <linux/ioport.h>
 #include <linux/delay.h>
-#include <linux/serial_core.h>
 #include <linux/param.h>
 #include <asm/txx9irq.h>
 #include <asm/txx9tmr.h>
@@ -238,11 +237,9 @@ void __init tx4938_time_init(unsigned int tmrnr)
 				     TXX9_IMCLK);
 }
 
-void __init tx4938_setup_serial(void)
+void __init tx4938_sio_init(unsigned int sclk, unsigned int cts_mask)
 {
-#ifdef CONFIG_SERIAL_TXX9
 	int i;
-	struct uart_port req;
 	unsigned int ch_mask = 0;
 
 	if (__raw_readq(&tx4938_ccfgptr->pcfg) & TX4938_PCFG_ETH0_SEL)
@@ -250,17 +247,10 @@ void __init tx4938_setup_serial(void)
 	for (i = 0; i < 2; i++) {
 		if ((1 << i) & ch_mask)
 			continue;
-		memset(&req, 0, sizeof(req));
-		req.line = i;
-		req.iotype = UPIO_MEM;
-		req.membase = (unsigned char __iomem *)TX4938_SIO_REG(i);
-		req.mapbase = TX4938_SIO_REG(i) & 0xfffffffffULL;
-		req.irq = TXX9_IRQ_BASE + TX4938_IR_SIO(i);
-		req.flags |= UPF_BUGGY_UART /*HAVE_CTS_LINE*/;
-		req.uartclk = TXX9_IMCLK;
-		early_serial_txx9_setup(&req);
+		txx9_sio_init(TX4938_SIO_REG(i) & 0xfffffffffULL,
+			      TXX9_IRQ_BASE + TX4938_IR_SIO(i),
+			      i, sclk, (1 << i) & cts_mask);
 	}
-#endif /* CONFIG_SERIAL_TXX9 */
 }
 
 void __init tx4938_spi_init(int busid)
diff --git a/arch/mips/txx9/jmr3927/setup.c b/arch/mips/txx9/jmr3927/setup.c
index cf7513d..87db41b 100644
--- a/arch/mips/txx9/jmr3927/setup.c
+++ b/arch/mips/txx9/jmr3927/setup.c
@@ -105,7 +105,7 @@ static void __init jmr3927_mem_setup(void)
 	/* initialize board */
 	jmr3927_board_init();
 
-	tx3927_setup_serial(1 << 1); /* ch1: noCTS */
+	tx3927_sio_init(0, 1 << 1); /* ch1: noCTS */
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
 	argptr = prom_getcmdline();
 	if (!strstr(argptr, "console="))
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index 962ada5..0d39baf 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -212,7 +212,7 @@ static void __init rbtx4927_mem_setup(void)
 	set_io_port_base(KSEG1 + RBTX4927_ISA_IO_OFFSET);
 #endif
 
-	tx4927_setup_serial();
+	tx4927_sio_init(0, 0);
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
 	argptr = prom_getcmdline();
 	if (!strstr(argptr, "console="))
diff --git a/arch/mips/txx9/rbtx4938/setup.c b/arch/mips/txx9/rbtx4938/setup.c
index 5c05a21..9ab48de 100644
--- a/arch/mips/txx9/rbtx4938/setup.c
+++ b/arch/mips/txx9/rbtx4938/setup.c
@@ -165,7 +165,7 @@ static void __init rbtx4938_mem_setup(void)
 	set_io_port_base(RBTX4938_ETHER_BASE);
 #endif
 
-	tx4938_setup_serial();
+	tx4938_sio_init(7372800, 0);
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
 	argptr = prom_getcmdline();
 	if (!strstr(argptr, "console="))
diff --git a/include/asm-mips/txx9/generic.h b/include/asm-mips/txx9/generic.h
index c6b5cd6..a295aaa 100644
--- a/include/asm-mips/txx9/generic.h
+++ b/include/asm-mips/txx9/generic.h
@@ -47,5 +47,7 @@ char *prom_getcmdline(void);
 void txx9_wdt_init(unsigned long base);
 void txx9_spi_init(int busid, unsigned long base, int irq);
 void txx9_ethaddr_init(unsigned int id, unsigned char *ethaddr);
+void txx9_sio_init(unsigned long baseaddr, int irq,
+		   unsigned int line, unsigned int sclk, int nocts);
 
 #endif /* __ASM_TXX9_GENERIC_H */
diff --git a/include/asm-mips/txx9/tx3927.h b/include/asm-mips/txx9/tx3927.h
index f0439a7..14e0636 100644
--- a/include/asm-mips/txx9/tx3927.h
+++ b/include/asm-mips/txx9/tx3927.h
@@ -331,7 +331,7 @@ struct tx3927_ccfg_reg {
 void tx3927_wdt_init(void);
 void tx3927_setup(void);
 void tx3927_time_init(unsigned int evt_tmrnr, unsigned int src_tmrnr);
-void tx3927_setup_serial(unsigned int cts_mask);
+void tx3927_sio_init(unsigned int sclk, unsigned int cts_mask);
 struct pci_controller;
 void tx3927_pcic_setup(struct pci_controller *channel,
 		       unsigned long sdram_size, int extarb);
diff --git a/include/asm-mips/txx9/tx4927.h b/include/asm-mips/txx9/tx4927.h
index 3d9fd7d..195f651 100644
--- a/include/asm-mips/txx9/tx4927.h
+++ b/include/asm-mips/txx9/tx4927.h
@@ -246,7 +246,7 @@ unsigned int tx4927_get_mem_size(void);
 void tx4927_wdt_init(void);
 void tx4927_setup(void);
 void tx4927_time_init(unsigned int tmrnr);
-void tx4927_setup_serial(void);
+void tx4927_sio_init(unsigned int sclk, unsigned int cts_mask);
 int tx4927_report_pciclk(void);
 int tx4927_pciclk66_setup(void);
 void tx4927_setup_pcierr_irq(void);
diff --git a/include/asm-mips/txx9/tx4938.h b/include/asm-mips/txx9/tx4938.h
index 26f9d4a..8175d4c 100644
--- a/include/asm-mips/txx9/tx4938.h
+++ b/include/asm-mips/txx9/tx4938.h
@@ -279,7 +279,7 @@ struct tx4938_ccfg_reg {
 void tx4938_wdt_init(void);
 void tx4938_setup(void);
 void tx4938_time_init(unsigned int tmrnr);
-void tx4938_setup_serial(void);
+void tx4938_sio_init(unsigned int sclk, unsigned int cts_mask);
 void tx4938_spi_init(int busid);
 void tx4938_ethaddr_init(unsigned char *addr0, unsigned char *addr1);
 int tx4938_report_pciclk(void);
-- 
1.5.5.5
