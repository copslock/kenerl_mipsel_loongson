Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Aug 2008 17:55:23 +0100 (BST)
Received: from smtp4.int-evry.fr ([157.159.10.71]:24017 "EHLO
	smtp4.int-evry.fr") by ftp.linux-mips.org with ESMTP
	id S20027114AbYHWQyv (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Sat, 23 Aug 2008 17:54:51 +0100
Received: from smtp2.int-evry.fr (smtp2.int-evry.fr [157.159.10.45])
	by smtp4.int-evry.fr (Postfix) with ESMTP id E6B83FE2E93;
	Sat, 23 Aug 2008 18:54:45 +0200 (CEST)
Received: from smtp-ext.int-evry.fr (smtp-ext.int-evry.fr [157.159.11.17])
	by smtp2.int-evry.fr (Postfix) with ESMTP id 1CF9E3F0B38;
	Sat, 23 Aug 2008 18:53:54 +0200 (CEST)
Received: from florian.maisel.int-evry.fr (unknown [157.159.47.24])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp-ext.int-evry.fr (Postfix) with ESMTP id 05D3D90004;
	Sat, 23 Aug 2008 18:53:54 +0200 (CEST)
From:	Florian Fainelli <florian@openwrt.org>
Date:	Sat, 23 Aug 2008 18:53:50 +0200
Subject: [PATCH 2/5] rb532: cleanup the headers again
MIME-Version: 1.0
X-UID:	1149
X-Length: 5851
To:	"linux-mips" <linux-mips@linux-mips.org>
Cc:	ralf@linux-mips.org
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200808231853.50661.florian@openwrt.org>
X-INT-MailScanner-Information: Please contact the ISP for more information
X-MailScanner-ID: 1CF9E3F0B38.F32C8
X-INT-MailScanner: Found to be clean
X-INT-MailScanner-SpamCheck: 
X-INT-MailScanner-From:	florian@openwrt.org
Return-Path: <florian@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch cleans up headers and regroups informations to
where they should reside. While moving, try to have a
consistant naming for defines.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
diff --git a/arch/mips/rb532/irq.c b/arch/mips/rb532/irq.c
index c0d0f95..549b46d 100644
--- a/arch/mips/rb532/irq.c
+++ b/arch/mips/rb532/irq.c
@@ -45,7 +45,7 @@
 #include <asm/mipsregs.h>
 #include <asm/system.h>
 
-#include <asm/mach-rc32434/rc32434.h>
+#include <asm/mach-rc32434/irq.h>
 
 struct intr_group {
 	u32 mask;	/* mask of valid bits in pending/mask registers */
diff --git a/arch/mips/rb532/serial.c b/arch/mips/rb532/serial.c
index 1a05b5d..3e0d7ec 100644
--- a/arch/mips/rb532/serial.c
+++ b/arch/mips/rb532/serial.c
@@ -31,16 +31,16 @@
 #include <linux/serial_8250.h>
 
 #include <asm/serial.h>
-#include <asm/mach-rc32434/rc32434.h>
+#include <asm/mach-rc32434/rb.h>
 
 extern unsigned int idt_cpu_freq;
 
 static struct uart_port rb532_uart = {
 	.type = PORT_16550A,
 	.line = 0,
-	.irq = RC32434_UART0_IRQ,
+	.irq = UART0_IRQ,
 	.iotype = UPIO_MEM,
-	.membase = (char *)KSEG1ADDR(RC32434_UART0_BASE),
+	.membase = (char *)KSEG1ADDR(REGBASE + UART0BASE),
 	.regshift = 2
 };
 
diff --git a/arch/mips/rb532/setup.c b/arch/mips/rb532/setup.c
index 7aafa95..50f530f 100644
--- a/arch/mips/rb532/setup.c
+++ b/arch/mips/rb532/setup.c
@@ -9,7 +9,7 @@
 #include <asm/time.h>
 #include <linux/ioport.h>
 
-#include <asm/mach-rc32434/rc32434.h>
+#include <asm/mach-rc32434/rb.h>
 #include <asm/mach-rc32434/pci.h>
 
 struct pci_reg __iomem *pci_reg;
@@ -27,7 +27,7 @@ static struct resource pci0_res[] = {
 static void rb_machine_restart(char *command)
 {
 	/* just jump to the reset vector */
-	writel(0x80000001, (void *)KSEG1ADDR(RC32434_REG_BASE + RC32434_RST));
+	writel(0x80000001, IDT434_REG_BASE + RST);
 	((void (*)(void)) KSEG1ADDR(0x1FC00000u))();
 }
 
diff --git a/include/asm-mips/mach-rc32434/irq.h b/include/asm-mips/mach-rc32434/irq.h
index d68318b..56738d8 100644
--- a/include/asm-mips/mach-rc32434/irq.h
+++ b/include/asm-mips/mach-rc32434/irq.h
@@ -4,6 +4,26 @@
 #define NR_IRQS	256
 
 #include <asm/mach-generic/irq.h>
+#include <asm/mach-rc32434/rb.h>
+
+/* Interrupt Controller */
+#define IC_GROUP0_PEND		(REGBASE + 0x38000)
+#define IC_GROUP0_MASK		(REGBASE + 0x38008)
+#define IC_GROUP_OFFSET		0x0C
+
+#define NUM_INTR_GROUPS		5
+
+/* 16550 UARTs */
+#define GROUP0_IRQ_BASE		8	/* GRP2 IRQ numbers start here */
+					/* GRP3 IRQ numbers start here */
+#define GROUP1_IRQ_BASE		(GROUP0_IRQ_BASE + 32)
+					/* GRP4 IRQ numbers start here */
+#define GROUP2_IRQ_BASE		(GROUP1_IRQ_BASE + 32)
+					/* GRP5 IRQ numbers start here */
+#define GROUP3_IRQ_BASE		(GROUP2_IRQ_BASE + 32)
+#define GROUP4_IRQ_BASE		(GROUP3_IRQ_BASE + 32)
+
+#define UART0_IRQ		(GROUP3_IRQ_BASE + 0)
 
 #define ETH0_DMA_RX_IRQ   	(GROUP1_IRQ_BASE + 0)
 #define ETH0_DMA_TX_IRQ   	(GROUP1_IRQ_BASE + 1)
diff --git a/include/asm-mips/mach-rc32434/rb.h b/include/asm-mips/mach-rc32434/rb.h
index 62ac73c..79e8ef6 100644
--- a/include/asm-mips/mach-rc32434/rb.h
+++ b/include/asm-mips/mach-rc32434/rb.h
@@ -19,6 +19,8 @@
 
 #define REGBASE		0x18000000
 #define IDT434_REG_BASE	((volatile void *) KSEG1ADDR(REGBASE))
+#define UART0BASE	0x58000
+#define RST		(1 << 15)
 #define DEV0BASE	0x010000
 #define DEV0MASK	0x010004
 #define DEV0C		0x010008
diff --git a/include/asm-mips/mach-rc32434/rc32434.h b/include/asm-mips/mach-rc32434/rc32434.h
index c4a0214..9df04b7 100644
--- a/include/asm-mips/mach-rc32434/rc32434.h
+++ b/include/asm-mips/mach-rc32434/rc32434.h
@@ -8,37 +8,7 @@
 #include <linux/delay.h>
 #include <linux/io.h>
 
-#define RC32434_REG_BASE	0x18000000
-#define RC32434_RST		(1 << 15)
-
 #define IDT_CLOCK_MULT		2
-#define MIPS_CPU_TIMER_IRQ	7
-
-/* Interrupt Controller */
-#define IC_GROUP0_PEND		(RC32434_REG_BASE + 0x38000)
-#define IC_GROUP0_MASK		(RC32434_REG_BASE + 0x38008)
-#define IC_GROUP_OFFSET		0x0C
-
-#define NUM_INTR_GROUPS		5
-
-/* 16550 UARTs */
-#define GROUP0_IRQ_BASE		8	/* GRP2 IRQ numbers start here */
-					/* GRP3 IRQ numbers start here */
-#define GROUP1_IRQ_BASE		(GROUP0_IRQ_BASE + 32)
-					/* GRP4 IRQ numbers start here */
-#define GROUP2_IRQ_BASE		(GROUP1_IRQ_BASE + 32)
-					/* GRP5 IRQ numbers start here */
-#define GROUP3_IRQ_BASE		(GROUP2_IRQ_BASE + 32)
-#define GROUP4_IRQ_BASE		(GROUP3_IRQ_BASE + 32)
-
-
-#ifdef __MIPSEB__
-#define RC32434_UART0_BASE	(RC32434_REG_BASE + 0x58003)
-#else
-#define RC32434_UART0_BASE	(RC32434_REG_BASE + 0x58000)
-#endif
-
-#define RC32434_UART0_IRQ	(GROUP3_IRQ_BASE + 0)
 
 /* cpu pipeline flush */
 static inline void rc32434_sync(void)
