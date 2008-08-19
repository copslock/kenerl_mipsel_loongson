Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 19 Aug 2008 14:55:27 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:11983 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S28574756AbYHSNzU (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 19 Aug 2008 14:55:20 +0100
Received: from localhost.localdomain (p6195-ipad311funabasi.chiba.ocn.ne.jp [123.217.216.195])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 67C5FB91A; Tue, 19 Aug 2008 22:55:14 +0900 (JST)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	ralf@linux-mips.org
Subject: [PATCH 01/14] RBTX4927: More explicit initialization
Date:	Tue, 19 Aug 2008 22:55:05 +0900
Message-Id: <1219154118-21193-1-git-send-email-anemo@mba.ocn.ne.jp>
X-Mailer: git-send-email 1.5.6.3
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

* Make sure all interrupts cleared on startup
* Initialize some GPIOs

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 arch/mips/txx9/rbtx4927/irq.c    |    5 +++++
 arch/mips/txx9/rbtx4927/setup.c  |    9 +++++++++
 include/asm-mips/txx9/rbtx4927.h |    2 ++
 3 files changed, 16 insertions(+), 0 deletions(-)

diff --git a/arch/mips/txx9/rbtx4927/irq.c b/arch/mips/txx9/rbtx4927/irq.c
index 00cd523..22076e3 100644
--- a/arch/mips/txx9/rbtx4927/irq.c
+++ b/arch/mips/txx9/rbtx4927/irq.c
@@ -142,6 +142,11 @@ static void __init toshiba_rbtx4927_irq_ioc_init(void)
 {
 	int i;
 
+	/* mask all IOC interrupts */
+	writeb(0, rbtx4927_imask_addr);
+	/* clear SoftInt interrupts */
+	writeb(0, rbtx4927_softint_addr);
+
 	for (i = RBTX4927_IRQ_IOC;
 	     i < RBTX4927_IRQ_IOC + RBTX4927_NR_IRQ_IOC; i++)
 		set_irq_chip_and_handler(i, &toshiba_rbtx4927_irq_ioc_type,
diff --git a/arch/mips/txx9/rbtx4927/setup.c b/arch/mips/txx9/rbtx4927/setup.c
index 0d39baf..5985f33 100644
--- a/arch/mips/txx9/rbtx4927/setup.c
+++ b/arch/mips/txx9/rbtx4927/setup.c
@@ -48,6 +48,7 @@
 #include <linux/ioport.h>
 #include <linux/platform_device.h>
 #include <linux/delay.h>
+#include <linux/gpio.h>
 #include <asm/io.h>
 #include <asm/reboot.h>
 #include <asm/txx9/generic.h>
@@ -212,6 +213,14 @@ static void __init rbtx4927_mem_setup(void)
 	set_io_port_base(KSEG1 + RBTX4927_ISA_IO_OFFSET);
 #endif
 
+	/* TX4927-SIO DTR on (PIO[15]) */
+	gpio_request(15, "sio-dtr");
+	gpio_direction_output(15, 1);
+	gpio_request(0, "led");
+	gpio_direction_output(0, 1);
+	gpio_request(1, "led");
+	gpio_direction_output(1, 1);
+
 	tx4927_sio_init(0, 0);
 #ifdef CONFIG_SERIAL_TXX9_CONSOLE
 	argptr = prom_getcmdline();
diff --git a/include/asm-mips/txx9/rbtx4927.h b/include/asm-mips/txx9/rbtx4927.h
index 6fcec91..c601546 100644
--- a/include/asm-mips/txx9/rbtx4927.h
+++ b/include/asm-mips/txx9/rbtx4927.h
@@ -36,6 +36,7 @@
 
 #define RBTX4927_IMASK_ADDR	(IO_BASE + TXX9_CE(2) + 0x00002000)
 #define RBTX4927_IMSTAT_ADDR	(IO_BASE + TXX9_CE(2) + 0x00002006)
+#define RBTX4927_SOFTINT_ADDR	(IO_BASE + TXX9_CE(2) + 0x00003000)
 #define RBTX4927_SOFTRESET_ADDR	(IO_BASE + TXX9_CE(2) + 0x0000f000)
 #define RBTX4927_SOFTRESETLOCK_ADDR	(IO_BASE + TXX9_CE(2) + 0x0000f002)
 #define RBTX4927_PCIRESET_ADDR	(IO_BASE + TXX9_CE(2) + 0x0000f006)
@@ -47,6 +48,7 @@
 
 #define rbtx4927_imask_addr	((__u8 __iomem *)RBTX4927_IMASK_ADDR)
 #define rbtx4927_imstat_addr	((__u8 __iomem *)RBTX4927_IMSTAT_ADDR)
+#define rbtx4927_softint_addr	((__u8 __iomem *)RBTX4927_SOFTINT_ADDR)
 #define rbtx4927_softreset_addr	((__u8 __iomem *)RBTX4927_SOFTRESET_ADDR)
 #define rbtx4927_softresetlock_addr	\
 				((__u8 __iomem *)RBTX4927_SOFTRESETLOCK_ADDR)
-- 
1.5.6.3
