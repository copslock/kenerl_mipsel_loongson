Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Nov 2009 20:27:56 +0100 (CET)
Received: from mail-ew0-f216.google.com ([209.85.219.216]:58380 "EHLO
	mail-ew0-f216.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1494033AbZKCT1H (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 3 Nov 2009 20:27:07 +0100
Received: by ewy12 with SMTP id 12so963691ewy.0
        for <linux-mips@linux-mips.org>; Tue, 03 Nov 2009 11:27:02 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=rEWDKg/mBKnELbegnCjBiJ+qRDLGSTfHVX56k/Bm2s0=;
        b=oh0hl7LQaljLmsiOqzVbi59mBD5LoplyAjybGnnrXWgsYHyw0BfavAepkQcUzbCZfA
         afcD4es/tKJhC0i7xmgf2lqQv/WHUzCpVLLuI9V56ya+heCFknfK4vZaEdx/NFRH9qTA
         qHYpavvsAllg8V/OgRo/mC2XJMSZTu25ffUV8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=QA7G6Inzn8NGJSLfbUd2fCMFEdGeOKR83tMwXbOf9NVHY99HUBOz2Ei9+WPkVzSVDx
         NdXlIAILyVCK1LMmqYCzkZsGUCG/SlHZX3uj63AhT1lvkzLY3x4Gxhi/GTmhX/a0AtZO
         qFQq/fyfiCkKcWhRONHvYJkP7ufUun80d/6Tg=
Received: by 10.216.87.143 with SMTP id y15mr209938wee.39.1257276422115;
        Tue, 03 Nov 2009 11:27:02 -0800 (PST)
Received: from localhost.localdomain (p5496F342.dip.t-dialin.net [84.150.243.66])
        by mx.google.com with ESMTPS id p10sm1157027gvf.29.2009.11.03.11.27.00
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 03 Nov 2009 11:27:01 -0800 (PST)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Kevin Hickey <khickey@netlogicmicro.com>,
	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH -queue 2/2] Alchemy: DB1300 support.
Date:	Tue,  3 Nov 2009 20:27:03 +0100
Message-Id: <1257276423-26413-3-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.2
In-Reply-To: <1257276423-26413-2-git-send-email-manuel.lauss@gmail.com>
References: <1257276423-26413-1-git-send-email-manuel.lauss@gmail.com>
 <1257276423-26413-2-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24652
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

VERY basic DB1300 board support, WORK IN PROGRESS

---
 arch/mips/Makefile                            |    7 +
 arch/mips/alchemy/Kconfig                     |    8 +
 arch/mips/alchemy/devboards/Makefile          |    1 +
 arch/mips/alchemy/devboards/db1300/Makefile   |    2 +
 arch/mips/alchemy/devboards/db1300/platform.c |  234 +++++
 arch/mips/alchemy/devboards/db1300/setup.c    |  158 ++++
 arch/mips/alchemy/devboards/prom.c            |    4 +
 arch/mips/configs/db1300_defconfig            | 1160 +++++++++++++++++++++++++
 arch/mips/include/asm/mach-db1x00/bcsr.h      |    3 +
 arch/mips/include/asm/mach-db1x00/db1300.h    |   37 +
 drivers/pcmcia/db1xxx_ss.c                    |   14 +-
 11 files changed, 1626 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/db1300/Makefile
 create mode 100644 arch/mips/alchemy/devboards/db1300/platform.c
 create mode 100644 arch/mips/alchemy/devboards/db1300/setup.c
 create mode 100644 arch/mips/configs/db1300_defconfig
 create mode 100644 arch/mips/include/asm/mach-db1x00/db1300.h

diff --git a/arch/mips/Makefile b/arch/mips/Makefile
index 77f5021..f40eda4 100644
--- a/arch/mips/Makefile
+++ b/arch/mips/Makefile
@@ -266,6 +266,13 @@ cflags-$(CONFIG_MIPS_DB1200)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
 load-$(CONFIG_MIPS_DB1200)	+= 0xffffffff80100000
 
 #
+# RMI DBAu1300 development platform
+#
+core-$(CONFIG_MIPS_DB1300)	+= arch/mips/alchemy/devboards/
+cflags-$(CONFIG_MIPS_DB1300)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_DB1300)	+= 0xffffffff80100000
+
+#
 # AMD Alchemy Bosporus eval board
 #
 core-$(CONFIG_MIPS_BOSPORUS)	+= arch/mips/alchemy/devboards/
diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 478699e..2478d7b 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -56,6 +56,14 @@ config MIPS_DB1200
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
+config MIPS_DB1300
+	bool "RMI DB1300 board"
+	select SOC_AU1300
+	select DMA_COHERENT
+	select MIPS_DISABLE_OBSOLETE_IDE
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
+
 config MIPS_DB1500
 	bool "Alchemy DB1500 board"
 	select SOC_AU1500
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index ecbd37f..b6e9465 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -16,5 +16,6 @@ obj-$(CONFIG_MIPS_DB1500)	+= db1x00/
 obj-$(CONFIG_MIPS_DB1550)	+= db1x00/
 obj-$(CONFIG_MIPS_BOSPORUS)	+= db1x00/
 obj-$(CONFIG_MIPS_MIRAGE)	+= db1x00/
+obj-$(CONFIG_MIPS_DB1300)	+= db1300/
 
 EXTRA_CFLAGS += -Werror
diff --git a/arch/mips/alchemy/devboards/db1300/Makefile b/arch/mips/alchemy/devboards/db1300/Makefile
new file mode 100644
index 0000000..3d74c2f
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1300/Makefile
@@ -0,0 +1,2 @@
+obj-y := setup.o platform.o
+
diff --git a/arch/mips/alchemy/devboards/db1300/platform.c b/arch/mips/alchemy/devboards/db1300/platform.c
new file mode 100644
index 0000000..e276fdf
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1300/platform.c
@@ -0,0 +1,234 @@
+/*
+ * DBAu1300 platform initialization
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/gpio_keys.h>
+#include <linux/init.h>
+#include <linux/input.h>	/* KEY_* codes */
+#include <linux/kernel.h>
+#include <linux/platform_device.h>
+#include <linux/smsc911x.h>
+
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
+#include <asm/mach-db1x00/db1300.h>
+#include <asm/mach-db1x00/bcsr.h>
+
+#include "../platform.h"
+
+static struct resource db1300_eth_res[] = {
+	[0] = {
+		.start		= DB1300_ETH_PHYS_ADDR,
+		.end		= DB1300_ETH_PHYS_END,
+		.flags		= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start		= DB1300_ETH_INT,
+		.end		= DB1300_ETH_INT,
+		.flags		= IORESOURCE_IRQ,
+	},
+};
+
+static struct smsc911x_platform_config db1300_eth_config = {
+	.phy_interface		= PHY_INTERFACE_MODE_MII,
+	.irq_polarity		= SMSC911X_IRQ_POLARITY_ACTIVE_LOW,
+	.irq_type		= SMSC911X_IRQ_TYPE_PUSH_PULL,
+	.flags			= SMSC911X_USE_32BIT,
+};
+
+static struct platform_device db1300_eth_dev = {
+	.name			= "smsc911x",
+	.id			= -1,
+	.num_resources		= ARRAY_SIZE(db1300_eth_res),
+	.resource		= db1300_eth_res,
+	.dev = {
+		.platform_data 	= &db1300_eth_config,
+	},
+};
+
+static struct resource au1300_psc1_res[] = {
+	[0] = {
+		.start	= AU1300_PSC1_PHYS_ADDR,
+		.end	= AU1300_PSC1_PHYS_ADDR + 0x0fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1300_PSC1_INT,
+		.end	= AU1300_PSC1_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= DSCR_CMD0_PSC1_TX,
+		.end	= DSCR_CMD0_PSC1_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= DSCR_CMD0_PSC1_RX,
+		.end	= DSCR_CMD0_PSC1_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device db1300_ac97_dev = {
+	.name		= "au1xpsc_ac97",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(au1300_psc1_res),
+	.resource	= au1300_psc1_res,
+};
+
+static struct resource au1300_psc2_res[] = {
+	[0] = {
+		.start	= AU1300_PSC2_PHYS_ADDR,
+		.end	= AU1300_PSC2_PHYS_ADDR + 0x0fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1300_PSC2_INT,
+		.end	= AU1300_PSC2_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= DSCR_CMD0_PSC2_TX,
+		.end	= DSCR_CMD0_PSC2_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= DSCR_CMD0_PSC2_RX,
+		.end	= DSCR_CMD0_PSC2_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device db1300_i2s_dev = {
+	.name		= "au1xpsc_i2s",
+	.id		= 1,
+	.num_resources	= ARRAY_SIZE(au1300_psc2_res),
+	.resource	= au1300_psc2_res,
+};
+
+static struct resource au1300_psc3_res[] = {
+	[0] = {
+		.start	= AU1300_PSC3_PHYS_ADDR,
+		.end	= AU1300_PSC3_PHYS_ADDR + 0x0fff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1300_PSC3_INT,
+		.end	= AU1300_PSC3_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= DSCR_CMD0_PSC3_TX,
+		.end	= DSCR_CMD0_PSC3_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= DSCR_CMD0_PSC3_RX,
+		.end	= DSCR_CMD0_PSC3_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device db1300_i2c_dev = {
+	.name		= "au1xpsc_smbus",
+	.id		= 0,	/* bus number */
+	.num_resources	= ARRAY_SIZE(au1300_psc3_res),
+	.resource	= au1300_psc3_res,
+};
+
+/* FIXME: keys not yet correctly assigned. orientation: from display */
+static struct gpio_keys_button db1300_5waysw_buttons[] = {
+	{
+		.code			= KEY_UP,
+		.gpio			= AU1300_PIN_LCDPWM0,
+		.type			= EV_KEY,
+		.debounce_interval	= 1,
+	},
+	{
+		.code			= KEY_DOWN,
+		.gpio			= AU1300_PIN_PSC2SYNC1,
+		.type			= EV_KEY,
+		.debounce_interval	= 1,
+	},
+	{
+		.code			= KEY_LEFT,
+		.gpio			= AU1300_PIN_WAKE1,
+		.type			= EV_KEY,
+		.debounce_interval	= 1,
+	},
+	{
+		.code			= KEY_RIGHT,
+		.gpio			= AU1300_PIN_WAKE2,
+		.type			= EV_KEY,
+		.debounce_interval	= 1,
+	},
+	{
+		.code			= KEY_ENTER,
+		.gpio			= AU1300_PIN_WAKE3,
+		.type			= EV_KEY,
+		.debounce_interval	= 1,
+	},
+};
+
+static struct gpio_keys_platform_data db1300_5waysw_data = {
+	.buttons	= db1300_5waysw_buttons,
+	.nbuttons	= ARRAY_SIZE(db1300_5waysw_buttons),
+	.rep		= 1,
+};
+
+static struct platform_device db1300_5waysw_dev = {
+	.name		= "gpio_keys",
+	.dev	= {
+		.platform_data	= &db1300_5waysw_data,
+	},
+};
+
+static struct platform_device *db1300_devs[] = {
+	&db1300_eth_dev,
+	&db1300_i2c_dev,
+	&db1300_ac97_dev,
+	&db1300_i2s_dev,
+	&db1300_5waysw_dev,
+};
+
+static int __init db1300_device_init(void)
+{
+	int swapped;
+
+	/* Audio PSC clock is supplied by codecs (PSC0, 1) */
+	__raw_writel(PSC_SEL_CLK_SERCLK,
+		(void __iomem *)KSEG1ADDR(AU1300_PSC0_PHYS_ADDR) + PSC_SEL_OFFSET);
+	__raw_writel(PSC_SEL_CLK_SERCLK,
+		(void __iomem *)KSEG1ADDR(AU1300_PSC1_PHYS_ADDR) + PSC_SEL_OFFSET);
+	wmb();
+
+	swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1200_SWAPBOOT;
+	db1x_register_norflash(64 * 1024 * 1024, 2, swapped);
+
+	return platform_add_devices(db1300_devs, ARRAY_SIZE(db1300_devs));
+}
+device_initcall(db1300_device_init);
+
+/* au1200fb calls these: STERBT EINEN TRAGISCHEN TOD!!! */
+int board_au1200fb_panel(void)
+{
+	return (bcsr_read(BCSR_SWITCHES) >> 8) & 0x0f;
+}
+
+int board_au1200fb_panel_init(void)
+{
+	/* Apply power */
+	bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
+				BCSR_BOARD_LCDBL);
+	return 0;
+}
+
+int board_au1200fb_panel_shutdown(void)
+{
+	/* Remove power */
+	bcsr_mod(BCSR_BOARD, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
+			     BCSR_BOARD_LCDBL, 0);
+	return 0;
+}
diff --git a/arch/mips/alchemy/devboards/db1300/setup.c b/arch/mips/alchemy/devboards/db1300/setup.c
new file mode 100644
index 0000000..60b6430
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1300/setup.c
@@ -0,0 +1,158 @@
+/*
+ * DB1300 board setup
+ *
+ * Copyright (c) 2009 Manuel Lauss <manuel.lauss@gmail.com>
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/pm.h>
+
+#include <asm/barrier.h>
+#include <asm/io.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/gpio-au1300.h>
+#include <asm/mach-db1x00/bcsr.h>
+#include <asm/mach-db1x00/db1300.h>
+#include <asm/processor.h>
+#include <asm/reboot.h>
+
+/* multifunction pins to assign to GPIO controller */
+static int db1300_gpio_pins[] __initdata = {
+	AU1300_PIN_LCDPWM0, AU1300_PIN_PSC2SYNC1, AU1300_PIN_WAKE1,
+	AU1300_PIN_WAKE2, AU1300_PIN_WAKE3, AU1300_PIN_FG3AUX,
+	AU1300_PIN_EXTCLK1,
+
+	-1,	/* terminator */
+};
+
+/* multifunction pins to assign to device functions */
+static int db1300_dev_pins[] __initdata = {
+	/* wake-from-str pins 0-3 */
+	AU1300_PIN_WAKE0,
+	/* external clock sources for PSC0 */
+	AU1300_PIN_EXTCLK0,
+	/* 8bit MMC interface on SD0: 6-9 */
+	AU1300_PIN_SD0DAT4, AU1300_PIN_SD0DAT5, AU1300_PIN_SD0DAT6,
+	AU1300_PIN_SD0DAT7,
+	/* UART1 pins: 11-18 */
+	AU1300_PIN_U1RI, AU1300_PIN_U1DCD, AU1300_PIN_U1DSR,
+	AU1300_PIN_U1CTS, AU1300_PIN_U1RTS, AU1300_PIN_U1DTR,
+	AU1300_PIN_U1RX, AU1300_PIN_U1TX,
+	/* UART0 pins: 19-24 */
+	AU1300_PIN_U0RI, AU1300_PIN_U0DCD, AU1300_PIN_U0DSR,
+	AU1300_PIN_U0CTS, AU1300_PIN_U0RTS, AU1300_PIN_U0DTR,
+	/* UART2: 25-26 */
+	AU1300_PIN_U2RX, AU1300_PIN_U2TX,
+	/* UART3: 27-28 */
+	AU1300_PIN_U3RX, AU1300_PIN_U3TX,
+	/* LCD controller PWMs, ext pixclock: 30-31 */
+	AU1300_PIN_LCDPWM1, AU1300_PIN_LCDCLKIN,
+	/* SD1 interface: 32-37 */
+	AU1300_PIN_SD1DAT0, AU1300_PIN_SD1DAT1, AU1300_PIN_SD1DAT2,
+	AU1300_PIN_SD1DAT3, AU1300_PIN_SD1CMD, AU1300_PIN_SD1CLK,
+	/* SD2 interface: 38-43 */
+	AU1300_PIN_SD2DAT0, AU1300_PIN_SD2DAT1, AU1300_PIN_SD2DAT2,
+	AU1300_PIN_SD2DAT3, AU1300_PIN_SD2CMD, AU1300_PIN_SD2CLK,
+	/* PSC0/1 clocks: 44-45 */
+	AU1300_PIN_PSC0CLK, AU1300_PIN_PSC1CLK,
+	/* PSCs: 46-49/50-53/54-57/58-61 */
+	AU1300_PIN_PSC0SYNC0, AU1300_PIN_PSC0SYNC1, AU1300_PIN_PSC0D0,
+	AU1300_PIN_PSC0D1,
+	AU1300_PIN_PSC1SYNC0, AU1300_PIN_PSC1SYNC1, AU1300_PIN_PSC1D0,
+	AU1300_PIN_PSC1D1,
+	AU1300_PIN_PSC2SYNC0,                       AU1300_PIN_PSC2D0,
+	AU1300_PIN_PSC2D1,
+	AU1300_PIN_PSC3SYNC0, AU1300_PIN_PSC3SYNC1, AU1300_PIN_PSC3D0,
+	AU1300_PIN_PSC3D1,
+	/* PCMCIA interface: 62-70 */
+	AU1300_PIN_PCE2, AU1300_PIN_PCE1, AU1300_PIN_PIOS16,
+	AU1300_PIN_PIOR, AU1300_PIN_PWE, AU1300_PIN_PWAIT,
+	AU1300_PIN_PREG, AU1300_PIN_POE, AU1300_PIN_PIOW,
+	/* camera interface H/V sync inputs: 71-72 */
+	AU1300_PIN_CIMLS, AU1300_PIN_CIMFS,
+	/* PSC2/3 clocks: 73-74 */
+	AU1300_PIN_PSC2CLK, AU1300_PIN_PSC3CLK,
+	-1,	/* terminator */
+};
+
+static void __init db1300_gpio_config(void)
+{
+	int *i;
+
+	i = &db1300_dev_pins[0];
+	while (*i != -1)
+		au1300_pinfunc_to_dev(*i++);
+
+	i = &db1300_gpio_pins[0];
+	while (*i != -1)
+		au1300_gpio_direction_input(*i++);/* implies pin_to_gpio */
+
+	au1300_set_dbdma_gpio(1, AU1300_PIN_FG3AUX);
+}
+
+char *get_system_type(void)
+{
+	return "RMI DBAu1300 Development Platform";
+}
+
+static void board_power_off(void)
+{
+	bcsr_write(BCSR_RESETS, 0);
+	bcsr_write(BCSR_SYSTEM, BCSR_SYSTEM_PWROFF | BCSR_SYSTEM_RESET);
+}
+
+void board_reset(void)
+{
+	bcsr_write(BCSR_RESETS, 0);
+	bcsr_write(BCSR_SYSTEM, 0);
+}
+
+static inline void enable_uart(unsigned long phys)
+{
+	void __iomem *addr = (void __iomem *)KSEG1ADDR(phys);
+
+	/* enable clock */
+	__raw_writel(1, addr + 0x100);
+	wmb();
+	/* deassert reset */
+	__raw_writel(3, addr + 0x100);
+	wmb();
+}
+
+void __init board_setup(void)
+{
+	unsigned short whoami;
+
+	db1300_gpio_config();
+	bcsr_init(DB1300_BCSR_PHYS_ADDR,
+		  DB1300_BCSR_PHYS_ADDR + DB1300_BCSR_HEXLED_OFS);
+
+	whoami = bcsr_read(BCSR_WHOAMI);
+	printk(KERN_INFO "RMI DBAu1300 Development Platform.\n\t"
+		"BoardID %d   CPLD Rev %d   DCID %d\n",
+		BCSR_WHOAMI_BOARD(whoami), BCSR_WHOAMI_CPLD(whoami),
+		BCSR_WHOAMI_DCID(whoami));
+
+	/* enable UARTs, YAMON only enables #2 */
+	enable_uart(AU1300_UART0_PHYS_ADDR);
+	enable_uart(AU1300_UART1_PHYS_ADDR);
+	enable_uart(AU1300_UART3_PHYS_ADDR);
+
+	pm_power_off = board_power_off;
+	_machine_halt = board_power_off;
+	_machine_restart = (void(*)(char *))board_reset;
+}
+
+static int __init db1300_arch_init(void)
+{
+	int cpldirq;
+
+	cpldirq = au1300_gpio_to_irq(AU1300_PIN_EXTCLK1);
+
+	set_irq_type(cpldirq, IRQF_TRIGGER_HIGH);
+	bcsr_init_irq(DB1300_FIRST_INT, DB1300_LAST_INT, cpldirq);
+
+	return 0;
+}
+arch_initcall(db1300_arch_init);
diff --git a/arch/mips/alchemy/devboards/prom.c b/arch/mips/alchemy/devboards/prom.c
index b30df5c..347186f 100644
--- a/arch/mips/alchemy/devboards/prom.c
+++ b/arch/mips/alchemy/devboards/prom.c
@@ -63,5 +63,9 @@ void __init prom_init(void)
 
 void prom_putchar(unsigned char c)
 {
+#ifdef CONFIG_MIPS_DB1300
+    alchemy_uart_putchar(AU1300_UART2_PHYS_ADDR, c);
+#else
     alchemy_uart_putchar(UART0_PHYS_ADDR, c);
+#endif
 }
diff --git a/arch/mips/configs/db1300_defconfig b/arch/mips/configs/db1300_defconfig
new file mode 100644
index 0000000..f1224e5
--- /dev/null
+++ b/arch/mips/configs/db1300_defconfig
@@ -0,0 +1,1160 @@
+#
+# Automatically generated make config: don't edit
+# Linux kernel version: 2.6.32-rc5
+# Tue Nov  3 19:14:32 2009
+#
+CONFIG_MIPS=y
+
+#
+# Machine selection
+#
+CONFIG_MACH_ALCHEMY=y
+# CONFIG_AR7 is not set
+# CONFIG_BASLER_EXCITE is not set
+# CONFIG_BCM47XX is not set
+# CONFIG_BCM63XX is not set
+# CONFIG_MIPS_COBALT is not set
+# CONFIG_MACH_DECSTATION is not set
+# CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
+# CONFIG_MACH_LOONGSON is not set
+# CONFIG_MIPS_MALTA is not set
+# CONFIG_MIPS_SIM is not set
+# CONFIG_NEC_MARKEINS is not set
+# CONFIG_MACH_VR41XX is not set
+# CONFIG_NXP_STB220 is not set
+# CONFIG_NXP_STB225 is not set
+# CONFIG_PNX8550_JBS is not set
+# CONFIG_PNX8550_STB810 is not set
+# CONFIG_PMC_MSP is not set
+# CONFIG_PMC_YOSEMITE is not set
+# CONFIG_SGI_IP22 is not set
+# CONFIG_SGI_IP27 is not set
+# CONFIG_SGI_IP28 is not set
+# CONFIG_SGI_IP32 is not set
+# CONFIG_SIBYTE_CRHINE is not set
+# CONFIG_SIBYTE_CARMEL is not set
+# CONFIG_SIBYTE_CRHONE is not set
+# CONFIG_SIBYTE_RHONE is not set
+# CONFIG_SIBYTE_SWARM is not set
+# CONFIG_SIBYTE_LITTLESUR is not set
+# CONFIG_SIBYTE_SENTOSA is not set
+# CONFIG_SIBYTE_BIGSUR is not set
+# CONFIG_SNI_RM is not set
+# CONFIG_MACH_TX39XX is not set
+# CONFIG_MACH_TX49XX is not set
+# CONFIG_MIKROTIK_RB532 is not set
+# CONFIG_WR_PPMC is not set
+# CONFIG_CAVIUM_OCTEON_SIMULATOR is not set
+# CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD is not set
+CONFIG_ALCHEMY_GPIOINT_AU1300=y
+# CONFIG_ALCHEMY_GPIO_INDIRECT is not set
+# CONFIG_MIPS_MTX1 is not set
+# CONFIG_MIPS_BOSPORUS is not set
+# CONFIG_MIPS_DB1000 is not set
+# CONFIG_MIPS_DB1100 is not set
+# CONFIG_MIPS_DB1200 is not set
+CONFIG_MIPS_DB1300=y
+# CONFIG_MIPS_DB1500 is not set
+# CONFIG_MIPS_DB1550 is not set
+# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_MIPS_PB1000 is not set
+# CONFIG_MIPS_PB1100 is not set
+# CONFIG_MIPS_PB1200 is not set
+# CONFIG_MIPS_PB1500 is not set
+# CONFIG_MIPS_PB1550 is not set
+# CONFIG_MIPS_XXS1500 is not set
+CONFIG_SOC_AU1300=y
+CONFIG_SOC_AU1X00=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+# CONFIG_ARCH_HAS_ILOG2_U32 is not set
+# CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_TIME=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K_LIB=y
+CONFIG_CSRC_R4K_LIB=y
+CONFIG_DMA_COHERENT=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
+CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_GPIO=y
+# CONFIG_CPU_BIG_ENDIAN is not set
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_SYS_SUPPORTS_APM_EMULATION=y
+CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
+CONFIG_IRQ_CPU=y
+CONFIG_MIPS_L1_CACHE_SHIFT=5
+
+#
+# CPU selection
+#
+# CONFIG_CPU_LOONGSON2E is not set
+CONFIG_CPU_MIPS32_R1=y
+# CONFIG_CPU_MIPS32_R2 is not set
+# CONFIG_CPU_MIPS64_R1 is not set
+# CONFIG_CPU_MIPS64_R2 is not set
+# CONFIG_CPU_R3000 is not set
+# CONFIG_CPU_TX39XX is not set
+# CONFIG_CPU_VR41XX is not set
+# CONFIG_CPU_R4300 is not set
+# CONFIG_CPU_R4X00 is not set
+# CONFIG_CPU_TX49XX is not set
+# CONFIG_CPU_R5000 is not set
+# CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R5500 is not set
+# CONFIG_CPU_R6000 is not set
+# CONFIG_CPU_NEVADA is not set
+# CONFIG_CPU_R8000 is not set
+# CONFIG_CPU_R10000 is not set
+# CONFIG_CPU_RM7000 is not set
+# CONFIG_CPU_RM9000 is not set
+# CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_CAVIUM_OCTEON is not set
+CONFIG_SYS_HAS_CPU_MIPS32_R1=y
+CONFIG_CPU_MIPS32=y
+CONFIG_CPU_MIPSR1=y
+CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_HARDWARE_WATCHPOINTS=y
+
+#
+# Kernel type
+#
+CONFIG_32BIT=y
+# CONFIG_64BIT is not set
+CONFIG_PAGE_SIZE_4KB=y
+# CONFIG_PAGE_SIZE_8KB is not set
+# CONFIG_PAGE_SIZE_16KB is not set
+# CONFIG_PAGE_SIZE_32KB is not set
+# CONFIG_PAGE_SIZE_64KB is not set
+CONFIG_CPU_HAS_PREFETCH=y
+CONFIG_MIPS_MT_DISABLED=y
+# CONFIG_MIPS_MT_SMP is not set
+# CONFIG_MIPS_MT_SMTC is not set
+CONFIG_64BIT_PHYS_ADDR=y
+CONFIG_CPU_HAS_SYNC=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_CPU_SUPPORTS_HIGHMEM=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+# CONFIG_DISCONTIGMEM_MANUAL is not set
+# CONFIG_SPARSEMEM_MANUAL is not set
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+# CONFIG_KSM is not set
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+# CONFIG_HZ_48 is not set
+CONFIG_HZ_100=y
+# CONFIG_HZ_128 is not set
+# CONFIG_HZ_250 is not set
+# CONFIG_HZ_256 is not set
+# CONFIG_HZ_1000 is not set
+# CONFIG_HZ_1024 is not set
+CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
+CONFIG_HZ=100
+CONFIG_PREEMPT_NONE=y
+# CONFIG_PREEMPT_VOLUNTARY is not set
+# CONFIG_PREEMPT is not set
+# CONFIG_KEXEC is not set
+# CONFIG_SECCOMP is not set
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
+
+#
+# General setup
+#
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_LOCALVERSION="-db1300"
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
+# CONFIG_BSD_PROCESS_ACCT is not set
+# CONFIG_TASKSTATS is not set
+# CONFIG_AUDIT is not set
+
+#
+# RCU Subsystem
+#
+CONFIG_TREE_RCU=y
+# CONFIG_TREE_PREEMPT_RCU is not set
+# CONFIG_RCU_TRACE is not set
+CONFIG_RCU_FANOUT=4
+CONFIG_RCU_FANOUT_EXACT=y
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=17
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
+# CONFIG_RELAY is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
+CONFIG_EMBEDDED=y
+# CONFIG_SYSCTL_SYSCALL is not set
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+# CONFIG_KALLSYMS_EXTRA_PASS is not set
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+# CONFIG_PCSPKR_PLATFORM is not set
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_AIO=y
+
+#
+# Kernel Performance Events And Counters
+#
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+CONFIG_COMPAT_BRK=y
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+CONFIG_HAVE_OPROFILE=y
+
+#
+# GCOV-based kernel profiling
+#
+# CONFIG_SLOW_WORK is not set
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+# CONFIG_MODULE_FORCE_LOAD is not set
+CONFIG_MODULE_UNLOAD=y
+# CONFIG_MODULE_FORCE_UNLOAD is not set
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
+CONFIG_BLOCK=y
+# CONFIG_LBDAF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
+
+#
+# IO Schedulers
+#
+CONFIG_IOSCHED_NOOP=y
+# CONFIG_IOSCHED_AS is not set
+# CONFIG_IOSCHED_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_DEFAULT_CFQ is not set
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
+# CONFIG_FREEZER is not set
+
+#
+# Bus options (PCI, PCMCIA, EISA, ISA, TC)
+#
+# CONFIG_ARCH_SUPPORTS_MSI is not set
+CONFIG_MMU=y
+CONFIG_PCCARD=y
+# CONFIG_PCMCIA_DEBUG is not set
+CONFIG_PCMCIA=y
+CONFIG_PCMCIA_LOAD_CIS=y
+# CONFIG_PCMCIA_IOCTL is not set
+
+#
+# PC-card bridges
+#
+# CONFIG_PCMCIA_AU1X00 is not set
+CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
+
+#
+# Executable file formats
+#
+CONFIG_BINFMT_ELF=y
+# CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
+# CONFIG_HAVE_AOUT is not set
+# CONFIG_BINFMT_MISC is not set
+CONFIG_TRAD_SIGNALS=y
+
+#
+# Power management options
+#
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+# CONFIG_PM is not set
+CONFIG_NET=y
+
+#
+# Networking options
+#
+CONFIG_PACKET=y
+CONFIG_PACKET_MMAP=y
+CONFIG_UNIX=y
+# CONFIG_NET_KEY is not set
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+# CONFIG_IP_ADVANCED_ROUTER is not set
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
+# CONFIG_NET_IPIP is not set
+# CONFIG_NET_IPGRE is not set
+# CONFIG_IP_MROUTE is not set
+# CONFIG_ARPD is not set
+# CONFIG_SYN_COOKIES is not set
+# CONFIG_INET_AH is not set
+# CONFIG_INET_ESP is not set
+# CONFIG_INET_IPCOMP is not set
+# CONFIG_INET_XFRM_TUNNEL is not set
+# CONFIG_INET_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+CONFIG_INET_LRO=y
+# CONFIG_INET_DIAG is not set
+# CONFIG_TCP_CONG_ADVANCED is not set
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+# CONFIG_TCP_MD5SIG is not set
+# CONFIG_IPV6 is not set
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
+# CONFIG_IP_DCCP is not set
+# CONFIG_IP_SCTP is not set
+# CONFIG_RDS is not set
+# CONFIG_TIPC is not set
+# CONFIG_ATM is not set
+# CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
+# CONFIG_VLAN_8021Q is not set
+# CONFIG_DECNET is not set
+# CONFIG_LLC2 is not set
+# CONFIG_IPX is not set
+# CONFIG_ATALK is not set
+# CONFIG_X25 is not set
+# CONFIG_LAPB is not set
+# CONFIG_ECONET is not set
+# CONFIG_WAN_ROUTER is not set
+# CONFIG_PHONET is not set
+# CONFIG_IEEE802154 is not set
+# CONFIG_NET_SCHED is not set
+# CONFIG_DCB is not set
+
+#
+# Network testing
+#
+# CONFIG_NET_PKTGEN is not set
+# CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
+# CONFIG_IRDA is not set
+# CONFIG_BT is not set
+# CONFIG_AF_RXRPC is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
+
+#
+# Device Drivers
+#
+
+#
+# Generic Driver Options
+#
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+# CONFIG_DEVTMPFS is not set
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
+# CONFIG_SYS_HYPERVISOR is not set
+# CONFIG_CONNECTOR is not set
+CONFIG_MTD=y
+# CONFIG_MTD_DEBUG is not set
+# CONFIG_MTD_TESTS is not set
+# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_REDBOOT_PARTS is not set
+CONFIG_MTD_CMDLINE_PARTS=y
+# CONFIG_MTD_AR7_PARTS is not set
+
+#
+# User Modules And Translation Layers
+#
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+# CONFIG_FTL is not set
+# CONFIG_NFTL is not set
+# CONFIG_INFTL is not set
+# CONFIG_RFD_FTL is not set
+# CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
+
+#
+# RAM/ROM/Flash chip drivers
+#
+CONFIG_MTD_CFI=y
+# CONFIG_MTD_JEDECPROBE is not set
+CONFIG_MTD_GEN_PROBE=y
+# CONFIG_MTD_CFI_ADV_OPTIONS is not set
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+# CONFIG_MTD_MAP_BANK_WIDTH_8 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_16 is not set
+# CONFIG_MTD_MAP_BANK_WIDTH_32 is not set
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+# CONFIG_MTD_CFI_I4 is not set
+# CONFIG_MTD_CFI_I8 is not set
+# CONFIG_MTD_CFI_INTELEXT is not set
+CONFIG_MTD_CFI_AMDSTD=y
+# CONFIG_MTD_CFI_STAA is not set
+CONFIG_MTD_CFI_UTIL=y
+# CONFIG_MTD_RAM is not set
+# CONFIG_MTD_ROM is not set
+# CONFIG_MTD_ABSENT is not set
+
+#
+# Mapping drivers for chip access
+#
+# CONFIG_MTD_COMPLEX_MAPPINGS is not set
+CONFIG_MTD_PHYSMAP=y
+# CONFIG_MTD_PHYSMAP_COMPAT is not set
+# CONFIG_MTD_PLATRAM is not set
+
+#
+# Self-contained MTD device drivers
+#
+# CONFIG_MTD_DATAFLASH is not set
+# CONFIG_MTD_M25P80 is not set
+# CONFIG_MTD_SST25L is not set
+# CONFIG_MTD_SLRAM is not set
+# CONFIG_MTD_PHRAM is not set
+# CONFIG_MTD_MTDRAM is not set
+# CONFIG_MTD_BLOCK2MTD is not set
+
+#
+# Disk-On-Chip Device Drivers
+#
+# CONFIG_MTD_DOC2000 is not set
+# CONFIG_MTD_DOC2001 is not set
+# CONFIG_MTD_DOC2001PLUS is not set
+CONFIG_MTD_NAND=y
+# CONFIG_MTD_NAND_VERIFY_WRITE is not set
+# CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
+CONFIG_MTD_NAND_IDS=y
+# CONFIG_MTD_NAND_DISKONCHIP is not set
+# CONFIG_MTD_NAND_NANDSIM is not set
+CONFIG_MTD_NAND_PLATFORM=y
+# CONFIG_MTD_ONENAND is not set
+
+#
+# LPDDR flash memory drivers
+#
+# CONFIG_MTD_LPDDR is not set
+
+#
+# UBI - Unsorted block images
+#
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+CONFIG_BLK_DEV=y
+# CONFIG_BLK_DEV_COW_COMMON is not set
+CONFIG_BLK_DEV_LOOP=y
+# CONFIG_BLK_DEV_CRYPTOLOOP is not set
+# CONFIG_BLK_DEV_NBD is not set
+# CONFIG_BLK_DEV_RAM is not set
+# CONFIG_CDROM_PKTCDVD is not set
+# CONFIG_ATA_OVER_ETH is not set
+# CONFIG_BLK_DEV_HD is not set
+# CONFIG_MISC_DEVICES is not set
+CONFIG_HAVE_IDE=y
+CONFIG_IDE=y
+
+#
+# Please see Documentation/ide/ide.txt for help/info on IDE drives
+#
+# CONFIG_BLK_DEV_IDE_SATA is not set
+CONFIG_IDE_GD=y
+CONFIG_IDE_GD_ATA=y
+# CONFIG_IDE_GD_ATAPI is not set
+CONFIG_BLK_DEV_IDECS=y
+# CONFIG_BLK_DEV_IDECD is not set
+# CONFIG_BLK_DEV_IDETAPE is not set
+CONFIG_IDE_TASK_IOCTL=y
+# CONFIG_IDE_PROC_FS is not set
+
+#
+# IDE chipset support/bugfixes
+#
+# CONFIG_IDE_GENERIC is not set
+# CONFIG_BLK_DEV_PLATFORM is not set
+# CONFIG_BLK_DEV_IDEDMA is not set
+
+#
+# SCSI device support
+#
+# CONFIG_RAID_ATTRS is not set
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
+# CONFIG_SCSI_NETLINK is not set
+# CONFIG_ATA is not set
+# CONFIG_MD is not set
+CONFIG_NETDEVICES=y
+# CONFIG_DUMMY is not set
+# CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
+# CONFIG_EQUALIZER is not set
+# CONFIG_TUN is not set
+# CONFIG_VETH is not set
+CONFIG_PHYLIB=y
+
+#
+# MII PHY device drivers
+#
+# CONFIG_MARVELL_PHY is not set
+# CONFIG_DAVICOM_PHY is not set
+# CONFIG_QSEMI_PHY is not set
+# CONFIG_LXT_PHY is not set
+# CONFIG_CICADA_PHY is not set
+# CONFIG_VITESSE_PHY is not set
+CONFIG_SMSC_PHY=y
+# CONFIG_BROADCOM_PHY is not set
+# CONFIG_ICPLUS_PHY is not set
+# CONFIG_REALTEK_PHY is not set
+# CONFIG_NATIONAL_PHY is not set
+# CONFIG_STE10XP is not set
+# CONFIG_LSI_ET1011C_PHY is not set
+# CONFIG_FIXED_PHY is not set
+# CONFIG_MDIO_BITBANG is not set
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
+# CONFIG_MIPS_AU1X00_ENET is not set
+# CONFIG_SMC91X is not set
+# CONFIG_DM9000 is not set
+# CONFIG_ENC28J60 is not set
+# CONFIG_ETHOC is not set
+CONFIG_SMSC911X=y
+# CONFIG_DNET is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
+# CONFIG_B44 is not set
+# CONFIG_KS8842 is not set
+# CONFIG_KS8851 is not set
+# CONFIG_KS8851_MLL is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
+# CONFIG_WLAN is not set
+
+#
+# Enable WiMAX (Networking options) to see the WiMAX drivers
+#
+# CONFIG_NET_PCMCIA is not set
+# CONFIG_WAN is not set
+# CONFIG_PPP is not set
+# CONFIG_SLIP is not set
+# CONFIG_NETCONSOLE is not set
+# CONFIG_NETPOLL is not set
+# CONFIG_NET_POLL_CONTROLLER is not set
+# CONFIG_ISDN is not set
+# CONFIG_PHONE is not set
+
+#
+# Input device support
+#
+CONFIG_INPUT=y
+# CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
+
+#
+# Userland interfaces
+#
+# CONFIG_INPUT_MOUSEDEV is not set
+# CONFIG_INPUT_JOYDEV is not set
+CONFIG_INPUT_EVDEV=y
+# CONFIG_INPUT_EVBUG is not set
+
+#
+# Input Device Drivers
+#
+CONFIG_INPUT_KEYBOARD=y
+# CONFIG_KEYBOARD_ADP5588 is not set
+# CONFIG_KEYBOARD_ATKBD is not set
+# CONFIG_QT2160 is not set
+# CONFIG_KEYBOARD_LKKBD is not set
+CONFIG_KEYBOARD_GPIO=y
+# CONFIG_KEYBOARD_MATRIX is not set
+# CONFIG_KEYBOARD_MAX7359 is not set
+# CONFIG_KEYBOARD_NEWTON is not set
+# CONFIG_KEYBOARD_OPENCORES is not set
+# CONFIG_KEYBOARD_STOWAWAY is not set
+# CONFIG_KEYBOARD_SUNKBD is not set
+# CONFIG_KEYBOARD_XTKBD is not set
+# CONFIG_INPUT_MOUSE is not set
+# CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
+# CONFIG_INPUT_TOUCHSCREEN is not set
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_UINPUT=y
+# CONFIG_INPUT_GPIO_ROTARY_ENCODER is not set
+
+#
+# Hardware I/O ports
+#
+# CONFIG_SERIO is not set
+# CONFIG_GAMEPORT is not set
+
+#
+# Character devices
+#
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_DEVKMEM=y
+# CONFIG_SERIAL_NONSTANDARD is not set
+
+#
+# Serial drivers
+#
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+# CONFIG_SERIAL_8250_CS is not set
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+# CONFIG_SERIAL_8250_EXTENDED is not set
+CONFIG_SERIAL_8250_AU1X00=y
+
+#
+# Non-8250 serial port support
+#
+# CONFIG_SERIAL_MAX3100 is not set
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
+CONFIG_LEGACY_PTYS=y
+CONFIG_LEGACY_PTY_COUNT=256
+# CONFIG_IPMI_HANDLER is not set
+# CONFIG_HW_RANDOM is not set
+# CONFIG_R3964 is not set
+
+#
+# PCMCIA character devices
+#
+# CONFIG_SYNCLINK_CS is not set
+# CONFIG_CARDMAN_4000 is not set
+# CONFIG_CARDMAN_4040 is not set
+# CONFIG_IPWIRELESS is not set
+# CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+# CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_CHARDEV=y
+# CONFIG_I2C_HELPER_AUTO is not set
+
+#
+# I2C Algorithms
+#
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+
+#
+# I2C system bus drivers (mostly embedded / system-on-chip)
+#
+CONFIG_I2C_AU1550=y
+# CONFIG_I2C_GPIO is not set
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_SIMTEC is not set
+
+#
+# External I2C/SMBus adapter drivers
+#
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_TAOS_EVM is not set
+
+#
+# Other I2C/SMBus bus drivers
+#
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
+CONFIG_SPI_MASTER=y
+
+#
+# SPI Master Controller Drivers
+#
+# CONFIG_SPI_AU1550 is not set
+# CONFIG_SPI_BITBANG is not set
+# CONFIG_SPI_GPIO is not set
+
+#
+# SPI Protocol Masters
+#
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
+
+#
+# PPS support
+#
+# CONFIG_PPS is not set
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+CONFIG_GPIOLIB=y
+CONFIG_DEBUG_GPIO=y
+# CONFIG_GPIO_SYSFS is not set
+
+#
+# Memory mapped GPIO expanders:
+#
+
+#
+# I2C GPIO expanders:
+#
+# CONFIG_GPIO_MAX732X is not set
+# CONFIG_GPIO_PCA953X is not set
+# CONFIG_GPIO_PCF857X is not set
+
+#
+# PCI GPIO expanders:
+#
+
+#
+# SPI GPIO expanders:
+#
+# CONFIG_GPIO_MAX7301 is not set
+# CONFIG_GPIO_MCP23S08 is not set
+# CONFIG_GPIO_MC33880 is not set
+
+#
+# AC97 GPIO expanders:
+#
+# CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+CONFIG_HWMON=y
+CONFIG_HWMON_VID=y
+# CONFIG_HWMON_DEBUG_CHIP is not set
+
+#
+# Native drivers
+#
+# CONFIG_SENSORS_AD7414 is not set
+# CONFIG_SENSORS_AD7418 is not set
+# CONFIG_SENSORS_ADCXX is not set
+# CONFIG_SENSORS_ADM1021 is not set
+CONFIG_SENSORS_ADM1025=y
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1029 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ADM9240 is not set
+# CONFIG_SENSORS_ADT7462 is not set
+# CONFIG_SENSORS_ADT7470 is not set
+# CONFIG_SENSORS_ADT7473 is not set
+# CONFIG_SENSORS_ADT7475 is not set
+# CONFIG_SENSORS_ATXP1 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_F71805F is not set
+# CONFIG_SENSORS_F71882FG is not set
+# CONFIG_SENSORS_F75375S is not set
+# CONFIG_SENSORS_G760A is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM70 is not set
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+# CONFIG_SENSORS_LM90 is not set
+# CONFIG_SENSORS_LM92 is not set
+# CONFIG_SENSORS_LM93 is not set
+# CONFIG_SENSORS_LTC4215 is not set
+# CONFIG_SENSORS_LTC4245 is not set
+# CONFIG_SENSORS_LM95241 is not set
+# CONFIG_SENSORS_MAX1111 is not set
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_MAX6650 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_PC87427 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_SHT15 is not set
+# CONFIG_SENSORS_DME1737 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47M192 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_ADS7828 is not set
+# CONFIG_SENSORS_THMC50 is not set
+# CONFIG_SENSORS_TMP401 is not set
+# CONFIG_SENSORS_TMP421 is not set
+# CONFIG_SENSORS_VT1211 is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83791D is not set
+# CONFIG_SENSORS_W83792D is not set
+# CONFIG_SENSORS_W83793 is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83L786NG is not set
+# CONFIG_SENSORS_W83627HF is not set
+# CONFIG_SENSORS_W83627EHF is not set
+# CONFIG_SENSORS_LIS3_SPI is not set
+# CONFIG_THERMAL is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
+
+#
+# Sonics Silicon Backplane
+#
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_TPS65010 is not set
+# CONFIG_TWL4030_CORE is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM831X is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_MFD_MC13783 is not set
+# CONFIG_AB3100_CORE is not set
+# CONFIG_EZX_PCAP is not set
+# CONFIG_REGULATOR is not set
+# CONFIG_MEDIA_SUPPORT is not set
+
+#
+# Graphics support
+#
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
+# CONFIG_FB is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
+
+#
+# Console display driver support
+#
+# CONFIG_VGA_CONSOLE is not set
+CONFIG_DUMMY_CONSOLE=y
+# CONFIG_SOUND is not set
+# CONFIG_HID_SUPPORT is not set
+# CONFIG_USB_SUPPORT is not set
+# CONFIG_MMC is not set
+# CONFIG_MEMSTICK is not set
+# CONFIG_NEW_LEDS is not set
+# CONFIG_ACCESSIBILITY is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
+
+#
+# RTC interfaces
+#
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
+
+#
+# I2C RTC drivers
+#
+# CONFIG_RTC_DRV_DS1307 is not set
+# CONFIG_RTC_DRV_DS1374 is not set
+# CONFIG_RTC_DRV_DS1672 is not set
+# CONFIG_RTC_DRV_MAX6900 is not set
+# CONFIG_RTC_DRV_RS5C372 is not set
+# CONFIG_RTC_DRV_ISL1208 is not set
+# CONFIG_RTC_DRV_X1205 is not set
+# CONFIG_RTC_DRV_PCF8563 is not set
+# CONFIG_RTC_DRV_PCF8583 is not set
+# CONFIG_RTC_DRV_M41T80 is not set
+# CONFIG_RTC_DRV_S35390A is not set
+# CONFIG_RTC_DRV_FM3130 is not set
+# CONFIG_RTC_DRV_RX8581 is not set
+# CONFIG_RTC_DRV_RX8025 is not set
+
+#
+# SPI RTC drivers
+#
+# CONFIG_RTC_DRV_M41T94 is not set
+# CONFIG_RTC_DRV_DS1305 is not set
+# CONFIG_RTC_DRV_DS1390 is not set
+# CONFIG_RTC_DRV_MAX6902 is not set
+# CONFIG_RTC_DRV_R9701 is not set
+# CONFIG_RTC_DRV_RS5C348 is not set
+# CONFIG_RTC_DRV_DS3234 is not set
+# CONFIG_RTC_DRV_PCF2123 is not set
+
+#
+# Platform RTC drivers
+#
+# CONFIG_RTC_DRV_CMOS is not set
+# CONFIG_RTC_DRV_DS1286 is not set
+# CONFIG_RTC_DRV_DS1511 is not set
+# CONFIG_RTC_DRV_DS1553 is not set
+# CONFIG_RTC_DRV_DS1742 is not set
+# CONFIG_RTC_DRV_STK17TA8 is not set
+# CONFIG_RTC_DRV_M48T86 is not set
+# CONFIG_RTC_DRV_M48T35 is not set
+# CONFIG_RTC_DRV_M48T59 is not set
+# CONFIG_RTC_DRV_BQ4802 is not set
+# CONFIG_RTC_DRV_V3020 is not set
+
+#
+# on-CPU RTC drivers
+#
+CONFIG_RTC_DRV_AU1XXX=y
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
+
+#
+# TI VLYNQ
+#
+# CONFIG_STAGING is not set
+
+#
+# File systems
+#
+CONFIG_EXT2_FS=y
+# CONFIG_EXT2_FS_XATTR is not set
+# CONFIG_EXT2_FS_XIP is not set
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4_FS is not set
+# CONFIG_REISERFS_FS is not set
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+# CONFIG_XFS_FS is not set
+# CONFIG_OCFS2_FS is not set
+# CONFIG_BTRFS_FS is not set
+# CONFIG_NILFS2_FS is not set
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY=y
+CONFIG_INOTIFY_USER=y
+# CONFIG_QUOTA is not set
+# CONFIG_AUTOFS_FS is not set
+# CONFIG_AUTOFS4_FS is not set
+# CONFIG_FUSE_FS is not set
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
+
+#
+# CD-ROM/DVD Filesystems
+#
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
+
+#
+# DOS/FAT/NT Filesystems
+#
+# CONFIG_MSDOS_FS is not set
+# CONFIG_VFAT_FS is not set
+# CONFIG_NTFS_FS is not set
+
+#
+# Pseudo filesystems
+#
+CONFIG_PROC_FS=y
+# CONFIG_PROC_KCORE is not set
+CONFIG_PROC_SYSCTL=y
+# CONFIG_PROC_PAGE_MONITOR is not set
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+# CONFIG_TMPFS_POSIX_ACL is not set
+# CONFIG_HUGETLB_PAGE is not set
+# CONFIG_CONFIGFS_FS is not set
+# CONFIG_MISC_FILESYSTEMS is not set
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+# CONFIG_NFS_V3_ACL is not set
+# CONFIG_NFS_V4 is not set
+CONFIG_ROOT_NFS=y
+# CONFIG_NFSD is not set
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+# CONFIG_RPCSEC_GSS_KRB5 is not set
+# CONFIG_RPCSEC_GSS_SPKM3 is not set
+# CONFIG_SMB_FS is not set
+# CONFIG_CIFS is not set
+# CONFIG_NCP_FS is not set
+# CONFIG_CODA_FS is not set
+# CONFIG_AFS_FS is not set
+
+#
+# Partition Types
+#
+# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_MSDOS_PARTITION=y
+# CONFIG_NLS is not set
+# CONFIG_DLM is not set
+
+#
+# Kernel hacking
+#
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+# CONFIG_PRINTK_TIME is not set
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+# CONFIG_MAGIC_SYSRQ is not set
+CONFIG_STRIP_ASM_SYMS=y
+# CONFIG_UNUSED_SYMBOLS is not set
+# CONFIG_DEBUG_FS is not set
+# CONFIG_HEADERS_CHECK is not set
+CONFIG_DEBUG_KERNEL=y
+CONFIG_IRQ_DEBUG=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_DETECT_SOFTLOCKUP is not set
+# CONFIG_DETECT_HUNG_TASK is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+# CONFIG_TIMER_STATS is not set
+# CONFIG_DEBUG_OBJECTS is not set
+# CONFIG_DEBUG_RT_MUTEXES is not set
+# CONFIG_RT_MUTEX_TESTER is not set
+# CONFIG_DEBUG_SPINLOCK is not set
+# CONFIG_DEBUG_MUTEXES is not set
+# CONFIG_DEBUG_LOCK_ALLOC is not set
+# CONFIG_PROVE_LOCKING is not set
+# CONFIG_LOCK_STAT is not set
+# CONFIG_DEBUG_SPINLOCK_SLEEP is not set
+# CONFIG_DEBUG_LOCKING_API_SELFTESTS is not set
+# CONFIG_DEBUG_KOBJECT is not set
+CONFIG_DEBUG_INFO=y
+# CONFIG_DEBUG_VM is not set
+# CONFIG_DEBUG_WRITECOUNT is not set
+# CONFIG_DEBUG_MEMORY_INIT is not set
+# CONFIG_DEBUG_LIST is not set
+# CONFIG_DEBUG_SG is not set
+# CONFIG_DEBUG_NOTIFIERS is not set
+# CONFIG_DEBUG_CREDENTIALS is not set
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_DEBUG_FORCE_WEAK_PER_CPU is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_PAGE_POISONING is not set
+CONFIG_TRACING_SUPPORT=y
+# CONFIG_FTRACE is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+CONFIG_CMDLINE="console=ttyS2,115200 root=/dev/nfs nfsroot=192.168.0.242:/var/chroot/mips,v3,tcp ip=192.168.0.68:192.168.0.242:192.168.0.1:255.255.255.0:db1300:eth0:off init=/linuxrc"
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_RUNTIME_DEBUG is not set
+
+#
+# Security options
+#
+# CONFIG_KEYS is not set
+# CONFIG_SECURITY is not set
+CONFIG_SECURITYFS=y
+CONFIG_SECURITY_FILE_CAPABILITIES=y
+# CONFIG_CRYPTO is not set
+# CONFIG_BINARY_PRINTF is not set
+
+#
+# Library routines
+#
+CONFIG_BITREVERSE=y
+CONFIG_GENERIC_FIND_LAST_BIT=y
+# CONFIG_CRC_CCITT is not set
+# CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+# CONFIG_CRC_ITU_T is not set
+CONFIG_CRC32=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
diff --git a/arch/mips/include/asm/mach-db1x00/bcsr.h b/arch/mips/include/asm/mach-db1x00/bcsr.h
index 618d2de..3c741c3 100644
--- a/arch/mips/include/asm/mach-db1x00/bcsr.h
+++ b/arch/mips/include/asm/mach-db1x00/bcsr.h
@@ -34,6 +34,8 @@
 #define PB1200_BCSR_PHYS_ADDR	0x0D800000
 #define PB1200_BCSR_HEXLED_OFS	0x00400000
 
+#define DB1300_BCSR_PHYS_ADDR	0x19800000
+#define DB1300_BCSR_HEXLED_OFS	0x00400000
 
 enum bcsr_id {
 	/* BCSR base 1 */
@@ -105,6 +107,7 @@ enum bcsr_whoami_boards {
 	BCSR_WHOAMI_PB1200 = BCSR_WHOAMI_PB1200_DDR1,
 	BCSR_WHOAMI_PB1200_DDR2,
 	BCSR_WHOAMI_DB1200,
+	BCSR_WHOAMI_DB1300,
 };
 
 /* STATUS reg.  Unless otherwise noted, they're valid on all boards.
diff --git a/arch/mips/include/asm/mach-db1x00/db1300.h b/arch/mips/include/asm/mach-db1x00/db1300.h
new file mode 100644
index 0000000..ece8ae0
--- /dev/null
+++ b/arch/mips/include/asm/mach-db1x00/db1300.h
@@ -0,0 +1,37 @@
+/*
+ * RMI DB1300 board constants
+ */
+
+#ifndef _DB1300_H_
+#define _DB1300_H_
+
+#define DB1300_FIRST_INT	(AU1300_LAST_INT + 1)
+#define DB1300_IDE_INT		(DB1300_FIRST_INT + 0)
+#define DB1300_ETH_INT		(DB1300_FIRST_INT + 1)
+#define DB1300_CF_INT		(DB1300_FIRST_INT + 2)
+#define DB1300_VIDEO_INT	(DB1300_FIRST_INT + 4)
+#define DB1300_HDMI_INT		(DB1300_FIRST_INT + 5)
+#define DB1300_DC_INT		(DB1300_FIRST_INT + 6)
+#define DB1300_FLASH_INT	(DB1300_FIRST_INT + 7)
+#define DB1300_CF_INSERT_INT	(DB1300_FIRST_INT + 8)
+#define DB1300_CF_EJECT_INT	(DB1300_FIRST_INT + 9)
+#define DB1300_AC97_INT		(DB1300_FIRST_INT + 10)
+#define DB1300_AC97_PEN_INT	(DB1300_FIRST_INT + 11)
+#define DB1300_SD1_INSERT_INT	(DB1300_FIRST_INT + 12)
+#define DB1300_SD1_EJECT_INT	(DB1300_FIRST_INT + 13)
+#define DB1300_OTG_VBUS_OC_INT	(DB1300_FIRST_INT + 14)
+#define DB1300_HOST_VBUS_OC_INT	(DB1300_FIRST_INT + 15)
+#define DB1300_LAST_INT		(DB1300_FIRST_INT + 15)
+
+#define DB1300_ETH_PHYS_ADDR	0x19000000
+#define DB1300_ETH_PHYS_END	0x197fffff
+
+#define DB1300_IDE_PHYS_ADDR	0x18800000
+#define DB1300_IDE_REG_SHIFT	5
+#define DB1300_IDE_PHYS_LEN	(16 << DB1300_IDE_REG_SHIFT)
+
+#define DB1300_NAND_PHYS_ADDR	0x20000000
+#define DB1300_NAND_PHYS_END	0x20000fff
+
+#endif	/* _DB1300_H_ */
+
diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index b35b72b..8f94ef8 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -59,6 +59,7 @@ struct db1x_pcmcia_sock {
 #define BOARD_TYPE_DEFAULT	0	/* most boards */
 #define BOARD_TYPE_DB1200	1	/* IRQs aren't gpios */
 #define BOARD_TYPE_PB1100	2	/* VS bits slightly different */
+#define BOARD_TYPE_DB1300	3	/* no power control */
 	int	board_type;
 };
 
@@ -161,7 +162,8 @@ static int db1x_pcmcia_setup_irqs(struct db1x_pcmcia_sock *sock)
 	 * ejection handler have been registered and the currently
 	 * active one disabled.
 	 */
-	if (sock->board_type == BOARD_TYPE_DB1200) {
+	if ((sock->board_type == BOARD_TYPE_DB1200) ||
+	    (sock->board_type == BOARD_TYPE_DB1300)) {
 		local_irq_save(flags);
 
 		ret = request_irq(sock->insert_irq, db1200_pcmcia_cdirq,
@@ -276,7 +278,8 @@ static int db1x_pcmcia_configure(struct pcmcia_socket *skt,
 	}
 
 	/* create new voltage code */
-	cr_set |= ((v << 2) | p) << (sock->nr * 8);
+	if (sock->board_type != BOARD_TYPE_DB1300)
+		cr_set |= ((v << 2) | p) << (sock->nr * 8);
 
 	changed = state->flags ^ sock->old_flags;
 
@@ -352,6 +355,10 @@ static int db1x_pcmcia_get_status(struct pcmcia_socket *skt,
 	/* reset de-asserted? then we're ready */
 	status |= (GET_RESET(cr, sock->nr)) ? SS_READY : SS_RESET;
 
+	/* DB1300: power is always on */
+	if (sock->board_type == BOARD_TYPE_DB1300)
+		status |= SS_POWERON | SS_3VCARD;
+
 	*value = status;
 
 	return 0;
@@ -426,6 +433,9 @@ static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
 	case BCSR_WHOAMI_PB1200 ... BCSR_WHOAMI_DB1200:
 		sock->board_type = BOARD_TYPE_DB1200;
 		break;
+	case BCSR_WHOAMI_DB1300:
+		sock->board_type = BOARD_TYPE_DB1300;
+		break;
 	default:
 		printk(KERN_INFO "db1xxx-ss: unknown board %d!\n", bid);
 		ret = -ENODEV;
-- 
1.6.5.2
