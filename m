Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 08 May 2011 10:45:28 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:44184 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491141Ab1EHImg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 8 May 2011 10:42:36 +0200
Received: by wyb28 with SMTP id 28so4138987wyb.36
        for <linux-mips@linux-mips.org>; Sun, 08 May 2011 01:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :in-reply-to:references;
        bh=r+LfCDSKOmFBbid0W72U3RwaSD68VVlmguuuNUX9I3I=;
        b=iE31supcqQeTiDfWdKLnAMhcRtyg2l7M146YMz2PGz0Wh8hWgTCTk3KBPXjwzQXvyJ
         iVC4KFznXdd6rqMvdH/E6ZguD5pWoOztjIR1zVNZNNGiXHBwgj7yq8od/N5hWZAhD/wV
         mBWoVtqHcSBZsdL3omHv4xVZFUKhF8Wu7VtwU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=OIrHYNjb+SjLHfS3R7W8nRJT9b0S+RWqWk6bM7I9wyuh/9W6FNtRgq2PzhfDNl2Cyt
         bI31Nmd3K6waT9I+tR24AKLaI0guREO9I1hgnkT4TFCv8iNFa4cyUBv73sIw+lMyi1gT
         LteaU8gm7QMNVush3o1naQ2VtFE4VzRGoE2YA=
Received: by 10.227.10.141 with SMTP id p13mr1243wbp.75.1304844151460;
        Sun, 08 May 2011 01:42:31 -0700 (PDT)
Received: from localhost.localdomain (178-191-5-255.adsl.highway.telekom.at [178.191.5.255])
        by mx.google.com with ESMTPS id z9sm3022884wbx.34.2011.05.08.01.42.30
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sun, 08 May 2011 01:42:31 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Florian Fainelli <florian@openwrt.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 6/9] MIPS: Alchemy: rewrite UART setup and constants.
Date:   Sun,  8 May 2011 10:42:17 +0200
Message-Id: <1304844140-3259-7-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.5.rc3
In-Reply-To: <1304844140-3259-1-git-send-email-manuel.lauss@googlemail.com>
References: <1304844140-3259-1-git-send-email-manuel.lauss@googlemail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Detect CPU type at runtime and setup uarts accordingly; also
clean up the uart base address mess in the process as far
as possible.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/platform.c        |   93 +++++++++++++++-------------
 arch/mips/alchemy/devboards/prom.c         |    2 +-
 arch/mips/alchemy/gpr/board_setup.c        |   14 +---
 arch/mips/alchemy/gpr/init.c               |    2 +-
 arch/mips/alchemy/mtx-1/init.c             |    2 +-
 arch/mips/alchemy/xxs1500/board_setup.c    |   11 +--
 arch/mips/alchemy/xxs1500/init.c           |    2 +-
 arch/mips/boot/compressed/uart-alchemy.c   |    2 +-
 arch/mips/include/asm/mach-au1x00/au1000.h |   57 +++++++++++++----
 9 files changed, 107 insertions(+), 78 deletions(-)

diff --git a/arch/mips/alchemy/common/platform.c b/arch/mips/alchemy/common/platform.c
index 9e7814d..36489fb 100644
--- a/arch/mips/alchemy/common/platform.c
+++ b/arch/mips/alchemy/common/platform.c
@@ -30,21 +30,12 @@ static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
 #ifdef CONFIG_SERIAL_8250
 	switch (state) {
 	case 0:
-		if ((__raw_readl(port->membase + UART_MOD_CNTRL) & 3) != 3) {
-			/* power-on sequence as suggested in the databooks */
-			__raw_writel(0, port->membase + UART_MOD_CNTRL);
-			wmb();
-			__raw_writel(1, port->membase + UART_MOD_CNTRL);
-			wmb();
-		}
-		__raw_writel(3, port->membase + UART_MOD_CNTRL); /* full on */
-		wmb();
+		alchemy_uart_enable(CPHYSADDR(port->membase));
 		serial8250_do_pm(port, state, old_state);
 		break;
 	case 3:		/* power off */
 		serial8250_do_pm(port, state, old_state);
-		__raw_writel(0, port->membase + UART_MOD_CNTRL);
-		wmb();
+		alchemy_uart_disable(CPHYSADDR(port->membase));
 		break;
 	default:
 		serial8250_do_pm(port, state, old_state);
@@ -65,38 +56,60 @@ static void alchemy_8250_pm(struct uart_port *port, unsigned int state,
 		.pm		= alchemy_8250_pm,		\
 	}
 
-static struct plat_serial8250_port au1x00_uart_data[] = {
-#if defined(CONFIG_SOC_AU1000)
-	PORT(UART0_PHYS_ADDR, AU1000_UART0_INT),
-	PORT(UART1_PHYS_ADDR, AU1000_UART1_INT),
-	PORT(UART2_PHYS_ADDR, AU1000_UART2_INT),
-	PORT(UART3_PHYS_ADDR, AU1000_UART3_INT),
-#elif defined(CONFIG_SOC_AU1500)
-	PORT(UART0_PHYS_ADDR, AU1500_UART0_INT),
-	PORT(UART3_PHYS_ADDR, AU1500_UART3_INT),
-#elif defined(CONFIG_SOC_AU1100)
-	PORT(UART0_PHYS_ADDR, AU1100_UART0_INT),
-	PORT(UART1_PHYS_ADDR, AU1100_UART1_INT),
-	PORT(UART3_PHYS_ADDR, AU1100_UART3_INT),
-#elif defined(CONFIG_SOC_AU1550)
-	PORT(UART0_PHYS_ADDR, AU1550_UART0_INT),
-	PORT(UART1_PHYS_ADDR, AU1550_UART1_INT),
-	PORT(UART3_PHYS_ADDR, AU1550_UART3_INT),
-#elif defined(CONFIG_SOC_AU1200)
-	PORT(UART0_PHYS_ADDR, AU1200_UART0_INT),
-	PORT(UART1_PHYS_ADDR, AU1200_UART1_INT),
-#endif
-	{ },
+static struct plat_serial8250_port au1x00_uart_data[][4] __initdata = {
+	[ALCHEMY_CPU_AU1000] = {
+		PORT(AU1000_UART0_PHYS_ADDR, AU1000_UART0_INT),
+		PORT(AU1000_UART1_PHYS_ADDR, AU1000_UART1_INT),
+		PORT(AU1000_UART2_PHYS_ADDR, AU1000_UART2_INT),
+		PORT(AU1000_UART3_PHYS_ADDR, AU1000_UART3_INT),
+	},
+	[ALCHEMY_CPU_AU1500] = {
+		PORT(AU1000_UART0_PHYS_ADDR, AU1500_UART0_INT),
+		PORT(AU1000_UART3_PHYS_ADDR, AU1500_UART3_INT),
+	},
+	[ALCHEMY_CPU_AU1100] = {
+		PORT(AU1000_UART0_PHYS_ADDR, AU1100_UART0_INT),
+		PORT(AU1000_UART1_PHYS_ADDR, AU1100_UART1_INT),
+		PORT(AU1000_UART3_PHYS_ADDR, AU1100_UART3_INT),
+	},
+	[ALCHEMY_CPU_AU1550] = {
+		PORT(AU1000_UART0_PHYS_ADDR, AU1550_UART0_INT),
+		PORT(AU1000_UART1_PHYS_ADDR, AU1550_UART1_INT),
+		PORT(AU1000_UART3_PHYS_ADDR, AU1550_UART3_INT),
+	},
+	[ALCHEMY_CPU_AU1200] = {
+		PORT(AU1000_UART0_PHYS_ADDR, AU1200_UART0_INT),
+		PORT(AU1000_UART1_PHYS_ADDR, AU1200_UART1_INT),
+	},
 };
 
 static struct platform_device au1xx0_uart_device = {
 	.name			= "serial8250",
 	.id			= PLAT8250_DEV_AU1X00,
-	.dev			= {
-		.platform_data	= au1x00_uart_data,
-	},
 };
 
+static void __init alchemy_setup_uarts(int ctype)
+{
+	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
+	int s = sizeof(struct plat_serial8250_port);
+	int c = alchemy_get_uarts(ctype);
+	struct plat_serial8250_port *ports;
+
+	ports = kzalloc(s * (c + 1), GFP_KERNEL);
+	if (!ports) {
+		printk(KERN_INFO "Alchemy: no memory for UART data\n");
+		return;
+	}
+	memcpy(ports, au1x00_uart_data[ctype], s * c);
+	au1xx0_uart_device.dev.platform_data = ports;
+
+	/* Fill up uartclk. */
+	for (s = 0; s < c; s++)
+		ports[s].uartclk = uartclk;
+	if (platform_device_register(&au1xx0_uart_device))
+		printk(KERN_INFO "Alchemy: failed to register UARTs\n");
+}
+
 /* OHCI (USB full speed host controller) */
 static struct resource au1xxx_usb_ohci_resources[] = {
 	[0] = {
@@ -442,7 +455,6 @@ void __init au1xxx_override_eth_cfg(unsigned int port,
 }
 
 static struct platform_device *au1xxx_platform_devices[] __initdata = {
-	&au1xx0_uart_device,
 	&au1xxx_usb_ohci_device,
 #ifdef CONFIG_FB_AU1100
 	&au1100_lcd_device,
@@ -465,13 +477,10 @@ static struct platform_device *au1xxx_platform_devices[] __initdata = {
 
 static int __init au1xxx_platform_init(void)
 {
-	unsigned int uartclk = get_au1x00_uart_baud_base() * 16;
-	int err, i;
+	int err, i, ctype = alchemy_get_cputype();
 	unsigned char ethaddr[6];
 
-	/* Fill up uartclk. */
-	for (i = 0; au1x00_uart_data[i].flags; i++)
-		au1x00_uart_data[i].uartclk = uartclk;
+	alchemy_setup_uarts(ctype);
 
 	/* use firmware-provided mac addr if available and necessary */
 	i = prom_get_ethernet_addr(ethaddr);
diff --git a/arch/mips/alchemy/devboards/prom.c b/arch/mips/alchemy/devboards/prom.c
index baeb213..e5306b5 100644
--- a/arch/mips/alchemy/devboards/prom.c
+++ b/arch/mips/alchemy/devboards/prom.c
@@ -62,5 +62,5 @@ void __init prom_init(void)
 
 void prom_putchar(unsigned char c)
 {
-    alchemy_uart_putchar(UART0_PHYS_ADDR, c);
+	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
 }
diff --git a/arch/mips/alchemy/gpr/board_setup.c b/arch/mips/alchemy/gpr/board_setup.c
index ad2e3f1..5f8f069 100644
--- a/arch/mips/alchemy/gpr/board_setup.c
+++ b/arch/mips/alchemy/gpr/board_setup.c
@@ -36,9 +36,6 @@
 
 #include <prom.h>
 
-#define UART1_ADDR	KSEG1ADDR(UART1_PHYS_ADDR)
-#define UART3_ADDR	KSEG1ADDR(UART3_PHYS_ADDR)
-
 char irq_tab_alchemy[][5] __initdata = {
 	[0] = { -1, AU1500_PCI_INTA, AU1500_PCI_INTB, 0xff, 0xff },
 };
@@ -67,18 +64,15 @@ static void gpr_power_off(void)
 
 void __init board_setup(void)
 {
-	printk(KERN_INFO "Tarpeze ITS GPR board\n");
+	printk(KERN_INFO "Trapeze ITS GPR board\n");
 
 	pm_power_off = gpr_power_off;
 	_machine_halt = gpr_power_off;
 	_machine_restart = gpr_reset;
 
-	/* Enable UART3 */
-	au_writel(0x1, UART3_ADDR + UART_MOD_CNTRL);/* clock enable (CE) */
-	au_writel(0x3, UART3_ADDR + UART_MOD_CNTRL); /* CE and "enable" */
-	/* Enable UART1 */
-	au_writel(0x1, UART1_ADDR + UART_MOD_CNTRL); /* clock enable (CE) */
-	au_writel(0x3, UART1_ADDR + UART_MOD_CNTRL); /* CE and "enable" */
+	/* Enable UART1/3 */
+	alchemy_uart_enable(AU1000_UART3_PHYS_ADDR);
+	alchemy_uart_enable(AU1000_UART1_PHYS_ADDR);
 
 	/* Take away Reset of UMTS-card */
 	alchemy_gpio_direction_output(215, 1);
diff --git a/arch/mips/alchemy/gpr/init.c b/arch/mips/alchemy/gpr/init.c
index f044f4c..229aafa 100644
--- a/arch/mips/alchemy/gpr/init.c
+++ b/arch/mips/alchemy/gpr/init.c
@@ -59,5 +59,5 @@ void __init prom_init(void)
 
 void prom_putchar(unsigned char c)
 {
-	alchemy_uart_putchar(UART0_PHYS_ADDR, c);
+	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
 }
diff --git a/arch/mips/alchemy/mtx-1/init.c b/arch/mips/alchemy/mtx-1/init.c
index f8d2557..2e81cc7 100644
--- a/arch/mips/alchemy/mtx-1/init.c
+++ b/arch/mips/alchemy/mtx-1/init.c
@@ -62,5 +62,5 @@ void __init prom_init(void)
 
 void prom_putchar(unsigned char c)
 {
-	alchemy_uart_putchar(UART0_PHYS_ADDR, c);
+	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
 }
diff --git a/arch/mips/alchemy/xxs1500/board_setup.c b/arch/mips/alchemy/xxs1500/board_setup.c
index febfb0f..81e57fa 100644
--- a/arch/mips/alchemy/xxs1500/board_setup.c
+++ b/arch/mips/alchemy/xxs1500/board_setup.c
@@ -66,13 +66,10 @@ void __init board_setup(void)
 	au_writel(pin_func, SYS_PINFUNC);
 
 	/* Enable UART */
-	au_writel(0x01, UART3_ADDR + UART_MOD_CNTRL); /* clock enable (CE) */
-	mdelay(10);
-	au_writel(0x03, UART3_ADDR + UART_MOD_CNTRL); /* CE and "enable" */
-	mdelay(10);
-
-	/* Enable DTR = USB power up */
-	au_writel(0x01, UART3_ADDR + UART_MCR); /* UART_MCR_DTR is 0x01??? */
+	alchemy_uart_enable(AU1000_UART3_PHYS_ADDR);
+	/* Enable DTR (MCR bit 0) = USB power up */
+	__raw_writel(1, (void __iomem *)KSEG1ADDR(AU1000_UART3_PHYS_ADDR + 0x18));
+	wmb();
 
 #ifdef CONFIG_PCI
 #if defined(__MIPSEB__)
diff --git a/arch/mips/alchemy/xxs1500/init.c b/arch/mips/alchemy/xxs1500/init.c
index 15125c2..0bf768f 100644
--- a/arch/mips/alchemy/xxs1500/init.c
+++ b/arch/mips/alchemy/xxs1500/init.c
@@ -60,5 +60,5 @@ void __init prom_init(void)
 
 void prom_putchar(unsigned char c)
 {
-	alchemy_uart_putchar(UART0_PHYS_ADDR, c);
+	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
 }
diff --git a/arch/mips/boot/compressed/uart-alchemy.c b/arch/mips/boot/compressed/uart-alchemy.c
index 1bff22f..eb063e6 100644
--- a/arch/mips/boot/compressed/uart-alchemy.c
+++ b/arch/mips/boot/compressed/uart-alchemy.c
@@ -3,5 +3,5 @@
 void putc(char c)
 {
 	/* all current (Jan. 2010) in-kernel boards */
-	alchemy_uart_putchar(UART0_PHYS_ADDR, c);
+	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
 }
diff --git a/arch/mips/include/asm/mach-au1x00/au1000.h b/arch/mips/include/asm/mach-au1x00/au1000.h
index eb8f103..c4ffb20 100644
--- a/arch/mips/include/asm/mach-au1x00/au1000.h
+++ b/arch/mips/include/asm/mach-au1x00/au1000.h
@@ -161,6 +161,45 @@ static inline int alchemy_get_cputype(void)
 	return ALCHEMY_CPU_UNKNOWN;
 }
 
+/* return number of uarts on a given cputype */
+static inline int alchemy_get_uarts(int type)
+{
+	switch (type) {
+	case ALCHEMY_CPU_AU1000:
+		return 4;
+	case ALCHEMY_CPU_AU1500:
+	case ALCHEMY_CPU_AU1200:
+		return 2;
+	case ALCHEMY_CPU_AU1100:
+	case ALCHEMY_CPU_AU1550:
+		return 3;
+	}
+	return 0;
+}
+
+/* enable an UART block if it isn't already */
+static inline void alchemy_uart_enable(u32 uart_phys)
+{
+	void __iomem *addr = (void __iomem *)KSEG1ADDR(uart_phys);
+
+	/* reset, enable clock, deassert reset */
+	if ((__raw_readl(addr + 0x100) & 3) != 3) {
+		__raw_writel(0, addr + 0x100);
+		wmb();
+		__raw_writel(1, addr + 0x100);
+		wmb();
+	}
+	__raw_writel(3, addr + 0x100);
+	wmb();
+}
+
+static inline void alchemy_uart_disable(u32 uart_phys)
+{
+	void __iomem *addr = (void __iomem *)KSEG1ADDR(uart_phys);
+	__raw_writel(0, addr + 0x100);	/* UART_MOD_CNTRL */
+	wmb();
+}
+
 static inline void alchemy_uart_putchar(u32 uart_phys, u8 c)
 {
 	void __iomem *base = (void __iomem *)KSEG1ADDR(uart_phys);
@@ -634,6 +673,10 @@ enum soc_au1200_ints {
  */
 
 #define AU1000_IC0_PHYS_ADDR		0x10400000 /* 01234 */
+#define AU1000_UART0_PHYS_ADDR		0x11100000 /* 01234 */
+#define AU1000_UART1_PHYS_ADDR		0x11200000 /* 0234 */
+#define AU1000_UART2_PHYS_ADDR		0x11300000 /* 0 */
+#define AU1000_UART3_PHYS_ADDR		0x11400000 /* 0123 */
 #define AU1000_IC1_PHYS_ADDR		0x11800000 /* 01234 */
 #define AU1550_DBDMA_PHYS_ADDR		0x14002000 /* 34 */
 #define AU1550_DBDMA_CONF_PHYS_ADDR	0x14003000 /* 34 */
@@ -660,10 +703,6 @@ enum soc_au1200_ints {
 #define	MACDMA0_PHYS_ADDR	0x14004000
 #define	MACDMA1_PHYS_ADDR	0x14004200
 #define	I2S_PHYS_ADDR		0x11000000
-#define	UART0_PHYS_ADDR		0x11100000
-#define	UART1_PHYS_ADDR		0x11200000
-#define	UART2_PHYS_ADDR		0x11300000
-#define	UART3_PHYS_ADDR		0x11400000
 #define	SSI0_PHYS_ADDR		0x11600000
 #define	SSI1_PHYS_ADDR		0x11680000
 #define	SYS_PHYS_ADDR		0x11900000
@@ -695,8 +734,6 @@ enum soc_au1200_ints {
 #define	MACDMA0_PHYS_ADDR	0x14004000
 #define	MACDMA1_PHYS_ADDR	0x14004200
 #define	I2S_PHYS_ADDR		0x11000000
-#define	UART0_PHYS_ADDR		0x11100000
-#define	UART3_PHYS_ADDR		0x11400000
 #define GPIO2_PHYS_ADDR		0x11700000
 #define	SYS_PHYS_ADDR		0x11900000
 #define PCI_MEM_PHYS_ADDR	0x400000000ULL
@@ -732,9 +769,6 @@ enum soc_au1200_ints {
 #define	MACDMA0_PHYS_ADDR	0x14004000
 #define	MACDMA1_PHYS_ADDR	0x14004200
 #define	I2S_PHYS_ADDR		0x11000000
-#define	UART0_PHYS_ADDR		0x11100000
-#define	UART1_PHYS_ADDR		0x11200000
-#define	UART3_PHYS_ADDR		0x11400000
 #define	SSI0_PHYS_ADDR		0x11600000
 #define	SSI1_PHYS_ADDR		0x11680000
 #define GPIO2_PHYS_ADDR		0x11700000
@@ -758,9 +792,6 @@ enum soc_au1200_ints {
 #define	MACEN_PHYS_ADDR		0x10520000
 #define	MACDMA0_PHYS_ADDR	0x14004000
 #define	MACDMA1_PHYS_ADDR	0x14004200
-#define	UART0_PHYS_ADDR		0x11100000
-#define	UART1_PHYS_ADDR		0x11200000
-#define	UART3_PHYS_ADDR		0x11400000
 #define GPIO2_PHYS_ADDR		0x11700000
 #define	SYS_PHYS_ADDR		0x11900000
 #define PE_PHYS_ADDR		0x14008000
@@ -786,8 +817,6 @@ enum soc_au1200_ints {
 #define CIM_PHYS_ADDR		0x14004000
 #define USBM_PHYS_ADDR		0x14020000
 #define	USBH_PHYS_ADDR		0x14020100
-#define	UART0_PHYS_ADDR		0x11100000
-#define	UART1_PHYS_ADDR		0x11200000
 #define GPIO2_PHYS_ADDR		0x11700000
 #define	SYS_PHYS_ADDR		0x11900000
 #define PSC0_PHYS_ADDR	 	0x11A00000
-- 
1.7.5.rc3
