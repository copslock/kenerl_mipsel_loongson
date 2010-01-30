Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 18:36:53 +0100 (CET)
Received: from sakura.staff.proxad.net ([213.228.1.107]:53012 "EHLO
        sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492998Ab0A3RfN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2010 18:35:13 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id C80DF551082; Sat, 30 Jan 2010 18:35:12 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 4/7] MIPS: bcm63xx: add support for second uart.
Date:   Sat, 30 Jan 2010 18:34:55 +0100
Message-Id: <1264872898-28149-5-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
References: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 25761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19472

The bcm63xx SOC has two uarts, some boards use the second one for
bluetooth.  This patch changes platform device registration code to
handle this. Changes to the uart driver are in a separate patch.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/boards/board_bcm963xx.c          |   27 +++++++-
 arch/mips/bcm63xx/cpu.c                            |    5 ++
 arch/mips/bcm63xx/dev-uart.c                       |   66 +++++++++++++++-----
 arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h   |   15 +++++
 .../include/asm/mach-bcm63xx/bcm63xx_dev_uart.h    |    6 ++
 .../mips/include/asm/mach-bcm63xx/board_bcm963xx.h |    2 +
 6 files changed, 102 insertions(+), 19 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_uart.h

diff --git a/arch/mips/bcm63xx/boards/board_bcm963xx.c b/arch/mips/bcm63xx/boards/board_bcm963xx.c
index b0d3db3..90faa37 100644
--- a/arch/mips/bcm63xx/boards/board_bcm963xx.c
+++ b/arch/mips/bcm63xx/boards/board_bcm963xx.c
@@ -18,6 +18,7 @@
 #include <asm/addrspace.h>
 #include <bcm63xx_board.h>
 #include <bcm63xx_cpu.h>
+#include <bcm63xx_dev_uart.h>
 #include <bcm63xx_regs.h>
 #include <bcm63xx_io.h>
 #include <bcm63xx_dev_pci.h>
@@ -42,6 +43,7 @@ static struct board_info __initdata board_96338gw = {
 	.name				= "96338GW",
 	.expected_cpu_id		= 0x6338,
 
+	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.enet0 = {
 		.force_speed_100	= 1,
@@ -84,6 +86,7 @@ static struct board_info __initdata board_96338w = {
 	.name				= "96338W",
 	.expected_cpu_id		= 0x6338,
 
+	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.enet0 = {
 		.force_speed_100	= 1,
@@ -128,6 +131,8 @@ static struct board_info __initdata board_96338w = {
 static struct board_info __initdata board_96345gw2 = {
 	.name				= "96345GW2",
 	.expected_cpu_id		= 0x6345,
+
+	.has_uart0			= 1,
 };
 #endif
 
@@ -139,6 +144,7 @@ static struct board_info __initdata board_96348r = {
 	.name				= "96348R",
 	.expected_cpu_id		= 0x6348,
 
+	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.has_pci			= 1,
 
@@ -182,6 +188,7 @@ static struct board_info __initdata board_96348gw_10 = {
 	.name				= "96348GW-10",
 	.expected_cpu_id		= 0x6348,
 
+	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.has_enet1			= 1,
 	.has_pci			= 1,
@@ -241,6 +248,7 @@ static struct board_info __initdata board_96348gw_11 = {
 	.name				= "96348GW-11",
 	.expected_cpu_id		= 0x6348,
 
+	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.has_enet1			= 1,
 	.has_pci			= 1,
@@ -294,6 +302,7 @@ static struct board_info __initdata board_96348gw = {
 	.name				= "96348GW",
 	.expected_cpu_id		= 0x6348,
 
+	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.has_enet1			= 1,
 	.has_pci			= 1,
@@ -351,9 +360,10 @@ static struct board_info __initdata board_FAST2404 = {
 	.name				= "F@ST2404",
 	.expected_cpu_id		= 0x6348,
 
-	.has_enet0			= 1,
-	.has_enet1			= 1,
-	.has_pci			= 1,
+	.has_uart0			= 1,
+        .has_enet0			= 1,
+        .has_enet1			= 1,
+        .has_pci			= 1,
 
 	.enet0 = {
 		.has_phy		= 1,
@@ -374,6 +384,7 @@ static struct board_info __initdata board_DV201AMR = {
 	.name				= "DV201AMR",
 	.expected_cpu_id		= 0x6348,
 
+	.has_uart0			= 1,
 	.has_pci			= 1,
 	.has_ohci0			= 1,
 
@@ -393,6 +404,7 @@ static struct board_info __initdata board_96348gw_a = {
 	.name				= "96348GW-A",
 	.expected_cpu_id		= 0x6348,
 
+	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.has_enet1			= 1,
 	.has_pci			= 1,
@@ -418,6 +430,7 @@ static struct board_info __initdata board_96358vw = {
 	.name				= "96358VW",
 	.expected_cpu_id		= 0x6358,
 
+	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.has_enet1			= 1,
 	.has_pci			= 1,
@@ -469,6 +482,7 @@ static struct board_info __initdata board_96358vw2 = {
 	.name				= "96358VW2",
 	.expected_cpu_id		= 0x6358,
 
+	.has_uart0			= 1,
 	.has_enet0			= 1,
 	.has_enet1			= 1,
 	.has_pci			= 1,
@@ -516,6 +530,7 @@ static struct board_info __initdata board_AGPFS0 = {
 	.name                           = "AGPF-S0",
 	.expected_cpu_id                = 0x6358,
 
+	.has_uart0			= 1,
 	.has_enet0                      = 1,
 	.has_enet1                      = 1,
 	.has_pci                        = 1,
@@ -794,6 +809,12 @@ int __init board_register_devices(void)
 {
 	u32 val;
 
+	if (board.has_uart0)
+		bcm63xx_uart_register(0);
+
+	if (board.has_uart1)
+		bcm63xx_uart_register(1);
+
 	if (board.has_pccard)
 		bcm63xx_pcmcia_register();
 
diff --git a/arch/mips/bcm63xx/cpu.c b/arch/mips/bcm63xx/cpu.c
index 70378bb..cbb7caf 100644
--- a/arch/mips/bcm63xx/cpu.c
+++ b/arch/mips/bcm63xx/cpu.c
@@ -36,6 +36,7 @@ static const unsigned long bcm96338_regs_base[] = {
 	[RSET_TIMER]		= BCM_6338_TIMER_BASE,
 	[RSET_WDT]		= BCM_6338_WDT_BASE,
 	[RSET_UART0]		= BCM_6338_UART0_BASE,
+	[RSET_UART1]		= BCM_6338_UART1_BASE,
 	[RSET_GPIO]		= BCM_6338_GPIO_BASE,
 	[RSET_SPI]		= BCM_6338_SPI_BASE,
 	[RSET_OHCI0]		= BCM_6338_OHCI0_BASE,
@@ -72,6 +73,7 @@ static const unsigned long bcm96345_regs_base[] = {
 	[RSET_TIMER]		= BCM_6345_TIMER_BASE,
 	[RSET_WDT]		= BCM_6345_WDT_BASE,
 	[RSET_UART0]		= BCM_6345_UART0_BASE,
+	[RSET_UART1]		= BCM_6345_UART1_BASE,
 	[RSET_GPIO]		= BCM_6345_GPIO_BASE,
 	[RSET_SPI]		= BCM_6345_SPI_BASE,
 	[RSET_UDC0]		= BCM_6345_UDC0_BASE,
@@ -109,6 +111,7 @@ static const unsigned long bcm96348_regs_base[] = {
 	[RSET_TIMER]		= BCM_6348_TIMER_BASE,
 	[RSET_WDT]		= BCM_6348_WDT_BASE,
 	[RSET_UART0]		= BCM_6348_UART0_BASE,
+	[RSET_UART1]		= BCM_6348_UART1_BASE,
 	[RSET_GPIO]		= BCM_6348_GPIO_BASE,
 	[RSET_SPI]		= BCM_6348_SPI_BASE,
 	[RSET_OHCI0]		= BCM_6348_OHCI0_BASE,
@@ -150,6 +153,7 @@ static const unsigned long bcm96358_regs_base[] = {
 	[RSET_TIMER]		= BCM_6358_TIMER_BASE,
 	[RSET_WDT]		= BCM_6358_WDT_BASE,
 	[RSET_UART0]		= BCM_6358_UART0_BASE,
+	[RSET_UART1]		= BCM_6358_UART1_BASE,
 	[RSET_GPIO]		= BCM_6358_GPIO_BASE,
 	[RSET_SPI]		= BCM_6358_SPI_BASE,
 	[RSET_OHCI0]		= BCM_6358_OHCI0_BASE,
@@ -170,6 +174,7 @@ static const unsigned long bcm96358_regs_base[] = {
 static const int bcm96358_irqs[] = {
 	[IRQ_TIMER]		= BCM_6358_TIMER_IRQ,
 	[IRQ_UART0]		= BCM_6358_UART0_IRQ,
+	[IRQ_UART1]		= BCM_6358_UART1_IRQ,
 	[IRQ_DSL]		= BCM_6358_DSL_IRQ,
 	[IRQ_ENET0]		= BCM_6358_ENET0_IRQ,
 	[IRQ_ENET1]		= BCM_6358_ENET1_IRQ,
diff --git a/arch/mips/bcm63xx/dev-uart.c b/arch/mips/bcm63xx/dev-uart.c
index b051946..c2963da 100644
--- a/arch/mips/bcm63xx/dev-uart.c
+++ b/arch/mips/bcm63xx/dev-uart.c
@@ -11,31 +11,65 @@
 #include <linux/platform_device.h>
 #include <bcm63xx_cpu.h>
 
-static struct resource uart_resources[] = {
+static struct resource uart0_resources[] = {
 	{
-		.start		= -1, /* filled at runtime */
-		.end		= -1, /* filled at runtime */
+		/* start & end filled at runtime */
 		.flags		= IORESOURCE_MEM,
 	},
 	{
-		.start		= -1, /* filled at runtime */
+		/* start filled at runtime */
 		.flags		= IORESOURCE_IRQ,
 	},
 };
 
-static struct platform_device bcm63xx_uart_device = {
-	.name		= "bcm63xx_uart",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(uart_resources),
-	.resource	= uart_resources,
+static struct resource uart1_resources[] = {
+	{
+		/* start & end filled at runtime */
+		.flags		= IORESOURCE_MEM,
+	},
+	{
+		/* start filled at runtime */
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device bcm63xx_uart_devices[] = {
+	{
+		.name		= "bcm63xx_uart",
+		.id		= 0,
+		.num_resources	= ARRAY_SIZE(uart0_resources),
+		.resource	= uart0_resources,
+	},
+
+	{
+		.name		= "bcm63xx_uart",
+		.id		= 1,
+		.num_resources	= ARRAY_SIZE(uart1_resources),
+		.resource	= uart1_resources,
+	}
 };
 
-int __init bcm63xx_uart_register(void)
+int __init bcm63xx_uart_register(unsigned int id)
 {
-	uart_resources[0].start = bcm63xx_regset_address(RSET_UART0);
-	uart_resources[0].end = uart_resources[0].start;
-	uart_resources[0].end += RSET_UART_SIZE - 1;
-	uart_resources[1].start = bcm63xx_get_irq_number(IRQ_UART0);
-	return platform_device_register(&bcm63xx_uart_device);
+	if (id >= ARRAY_SIZE(bcm63xx_uart_devices))
+		return -ENODEV;
+
+	if (id == 1 && !BCMCPU_IS_6358())
+		return -ENODEV;
+
+	if (id == 0) {
+		uart0_resources[0].start = bcm63xx_regset_address(RSET_UART0);
+		uart0_resources[0].end = uart0_resources[0].start +
+			RSET_UART_SIZE - 1;
+		uart0_resources[1].start = bcm63xx_get_irq_number(IRQ_UART0);
+	}
+
+	if (id == 1) {
+		uart1_resources[0].start = bcm63xx_regset_address(RSET_UART1);
+		uart1_resources[0].end = uart1_resources[0].start +
+			RSET_UART_SIZE - 1;
+		uart1_resources[1].start = bcm63xx_get_irq_number(IRQ_UART1);
+	}
+
+	return platform_device_register(&bcm63xx_uart_devices[id]);
 }
-arch_initcall(bcm63xx_uart_register);
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
index b12c4ac..96a2391 100644
--- a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_cpu.h
@@ -85,6 +85,7 @@ enum bcm63xx_regs_set {
 	RSET_TIMER,
 	RSET_WDT,
 	RSET_UART0,
+	RSET_UART1,
 	RSET_GPIO,
 	RSET_SPI,
 	RSET_UDC0,
@@ -123,6 +124,7 @@ enum bcm63xx_regs_set {
 #define BCM_6338_TIMER_BASE		(0xfffe0200)
 #define BCM_6338_WDT_BASE		(0xfffe021c)
 #define BCM_6338_UART0_BASE		(0xfffe0300)
+#define BCM_6338_UART1_BASE		(0xdeadbeef)
 #define BCM_6338_GPIO_BASE		(0xfffe0400)
 #define BCM_6338_SPI_BASE		(0xfffe0c00)
 #define BCM_6338_UDC0_BASE		(0xdeadbeef)
@@ -153,6 +155,7 @@ enum bcm63xx_regs_set {
 #define BCM_6345_TIMER_BASE		(0xfffe0200)
 #define BCM_6345_WDT_BASE		(0xfffe021c)
 #define BCM_6345_UART0_BASE		(0xfffe0300)
+#define BCM_6345_UART1_BASE		(0xdeadbeef)
 #define BCM_6345_GPIO_BASE		(0xfffe0400)
 #define BCM_6345_SPI_BASE		(0xdeadbeef)
 #define BCM_6345_UDC0_BASE		(0xdeadbeef)
@@ -182,6 +185,7 @@ enum bcm63xx_regs_set {
 #define BCM_6348_TIMER_BASE		(0xfffe0200)
 #define BCM_6348_WDT_BASE		(0xfffe021c)
 #define BCM_6348_UART0_BASE		(0xfffe0300)
+#define BCM_6348_UART1_BASE		(0xdeadbeef)
 #define BCM_6348_GPIO_BASE		(0xfffe0400)
 #define BCM_6348_SPI_BASE		(0xfffe0c00)
 #define BCM_6348_UDC0_BASE		(0xfffe1000)
@@ -208,6 +212,7 @@ enum bcm63xx_regs_set {
 #define BCM_6358_TIMER_BASE		(0xfffe0040)
 #define BCM_6358_WDT_BASE		(0xfffe005c)
 #define BCM_6358_UART0_BASE		(0xfffe0100)
+#define BCM_6358_UART1_BASE		(0xfffe0120)
 #define BCM_6358_GPIO_BASE		(0xfffe0080)
 #define BCM_6358_SPI_BASE		(0xdeadbeef)
 #define BCM_6358_UDC0_BASE		(0xfffe0800)
@@ -246,6 +251,8 @@ static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
 		return BCM_6338_WDT_BASE;
 	case RSET_UART0:
 		return BCM_6338_UART0_BASE;
+	case RSET_UART1:
+		return BCM_6338_UART1_BASE;
 	case RSET_GPIO:
 		return BCM_6338_GPIO_BASE;
 	case RSET_SPI:
@@ -292,6 +299,8 @@ static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
 		return BCM_6345_WDT_BASE;
 	case RSET_UART0:
 		return BCM_6345_UART0_BASE;
+	case RSET_UART1:
+		return BCM_6345_UART1_BASE;
 	case RSET_GPIO:
 		return BCM_6345_GPIO_BASE;
 	case RSET_SPI:
@@ -338,6 +347,8 @@ static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
 		return BCM_6348_WDT_BASE;
 	case RSET_UART0:
 		return BCM_6348_UART0_BASE;
+	case RSET_UART1:
+		return BCM_6348_UART1_BASE;
 	case RSET_GPIO:
 		return BCM_6348_GPIO_BASE;
 	case RSET_SPI:
@@ -384,6 +395,8 @@ static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
 		return BCM_6358_WDT_BASE;
 	case RSET_UART0:
 		return BCM_6358_UART0_BASE;
+	case RSET_UART1:
+		return BCM_6358_UART1_BASE;
 	case RSET_GPIO:
 		return BCM_6358_GPIO_BASE;
 	case RSET_SPI:
@@ -429,6 +442,7 @@ static inline unsigned long bcm63xx_regset_address(enum bcm63xx_regs_set set)
 enum bcm63xx_irq {
 	IRQ_TIMER = 0,
 	IRQ_UART0,
+	IRQ_UART1,
 	IRQ_DSL,
 	IRQ_ENET0,
 	IRQ_ENET1,
@@ -510,6 +524,7 @@ enum bcm63xx_irq {
  */
 #define BCM_6358_TIMER_IRQ		(IRQ_INTERNAL_BASE + 0)
 #define BCM_6358_UART0_IRQ		(IRQ_INTERNAL_BASE + 2)
+#define BCM_6358_UART1_IRQ		(IRQ_INTERNAL_BASE + 3)
 #define BCM_6358_OHCI0_IRQ		(IRQ_INTERNAL_BASE + 5)
 #define BCM_6358_ENET1_IRQ		(IRQ_INTERNAL_BASE + 6)
 #define BCM_6358_ENET0_IRQ		(IRQ_INTERNAL_BASE + 8)
diff --git a/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_uart.h b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_uart.h
new file mode 100644
index 0000000..23c705b
--- /dev/null
+++ b/arch/mips/include/asm/mach-bcm63xx/bcm63xx_dev_uart.h
@@ -0,0 +1,6 @@
+#ifndef BCM63XX_DEV_UART_H_
+#define BCM63XX_DEV_UART_H_
+
+int bcm63xx_uart_register(unsigned int id);
+
+#endif /* BCM63XX_DEV_UART_H_ */
diff --git a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
index 6479090..474daaa 100644
--- a/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
+++ b/arch/mips/include/asm/mach-bcm63xx/board_bcm963xx.h
@@ -45,6 +45,8 @@ struct board_info {
 	unsigned int	has_ohci0:1;
 	unsigned int	has_ehci0:1;
 	unsigned int	has_dsp:1;
+	unsigned int	has_uart0:1;
+	unsigned int	has_uart1:1;
 
 	/* ethernet config */
 	struct bcm63xx_enet_platform_data enet0;
-- 
1.6.3.3
