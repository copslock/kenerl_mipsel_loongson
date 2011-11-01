Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 20:06:25 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:32904 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903692Ab1KATEQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2011 20:04:16 +0100
Received: by mail-fx0-f49.google.com with SMTP id q17so947590faa.36
        for <multiple recipients>; Tue, 01 Nov 2011 12:04:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Bv+1E5VcP+qMDgSIL1RxvwZH7TYLPJkG505FCFVLqz0=;
        b=H+GBH8m6NNxRIBZ45+6uIE/3YuP5stnKKwsNzJAst9TJN9vjilVqRo4ELcmeWx5B7v
         mdNmgrQSt/Axt7zT2igPHWVUQB0k5iNSWvMWL5A4QSvFzQN8ZSBUHtOyMqCcwKQV4krc
         CSfhT7/j7BA3Y+Rv9yG6pfCucxKafGzjwCZog=
Received: by 10.223.61.138 with SMTP id t10mr2501885fah.20.1320174256414;
        Tue, 01 Nov 2011 12:04:16 -0700 (PDT)
Received: from localhost.localdomain (188-22-150-81.adsl.highway.telekom.at. [188.22.150.81])
        by mx.google.com with ESMTPS id a8sm327916faa.11.2011.11.01.12.04.12
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 12:04:15 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 05/18] MIPS: Alchemy: DB1300 support
Date:   Tue,  1 Nov 2011 20:03:31 +0100
Message-Id: <1320174224-27305-6-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31345
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 655

Basic support for the DB1300 board.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/Kconfig                  |    8 +
 arch/mips/alchemy/Platform                 |    7 +
 arch/mips/alchemy/devboards/Makefile       |    1 +
 arch/mips/alchemy/devboards/db1300.c       |  786 ++++++++++++++++++++++++++++
 arch/mips/alchemy/devboards/prom.c         |    4 +
 arch/mips/boot/compressed/uart-alchemy.c   |    5 +-
 arch/mips/configs/db1300_defconfig         |  391 ++++++++++++++
 arch/mips/include/asm/mach-db1x00/bcsr.h   |   34 +-
 arch/mips/include/asm/mach-db1x00/db1300.h |   40 ++
 arch/mips/include/asm/mach-db1x00/irq.h    |   23 +
 drivers/pcmcia/Kconfig                     |    4 +-
 drivers/pcmcia/db1xxx_ss.c                 |   26 +-
 drivers/video/au1200fb.c                   |   36 ++
 sound/soc/au1x/Kconfig                     |   10 +-
 sound/soc/au1x/db1200.c                    |   43 ++-
 15 files changed, 1398 insertions(+), 20 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/db1300.c
 create mode 100644 arch/mips/configs/db1300_defconfig
 create mode 100644 arch/mips/include/asm/mach-db1x00/db1300.h
 create mode 100644 arch/mips/include/asm/mach-db1x00/irq.h

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 766bada..f9a13be 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -49,6 +49,14 @@ config MIPS_DB1200
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
 
+config MIPS_DB1300
+	bool "NetLogic DB1300 board"
+	select ALCHEMY_GPIOINT_AU1300
+	select DMA_COHERENT
+	select MIPS_DISABLE_OBSOLETE_IDE
+	select SYS_SUPPORTS_LITTLE_ENDIAN
+	select SYS_HAS_EARLY_PRINTK
+
 config MIPS_DB1500
 	bool "Alchemy DB1500 board"
 	select ALCHEMY_GPIOINT_AU1000
diff --git a/arch/mips/alchemy/Platform b/arch/mips/alchemy/Platform
index 2920af9..4d13e21 100644
--- a/arch/mips/alchemy/Platform
+++ b/arch/mips/alchemy/Platform
@@ -68,6 +68,13 @@ cflags-$(CONFIG_MIPS_DB1200)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
 load-$(CONFIG_MIPS_DB1200)	+= 0xffffffff80100000
 
 #
+# NetLogic DBAu1300 development platform
+#
+platform-$(CONFIG_MIPS_DB1300)	+= alchemy/devboards/
+cflags-$(CONFIG_MIPS_DB1300)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_DB1300)	+= 0xffffffff80100000
+
+#
 # 4G-Systems eval board
 #
 platform-$(CONFIG_MIPS_MTX1)	+= alchemy/mtx-1/
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index 5afaf94..2eb75c9 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -11,5 +11,6 @@ obj-$(CONFIG_MIPS_PB1550)	+= pb1550/
 obj-$(CONFIG_MIPS_DB1000)	+= db1x00/
 obj-$(CONFIG_MIPS_DB1100)	+= db1x00/
 obj-$(CONFIG_MIPS_DB1200)	+= db1200/
+obj-$(CONFIG_MIPS_DB1300)	+= db1300.o
 obj-$(CONFIG_MIPS_DB1500)	+= db1x00/
 obj-$(CONFIG_MIPS_DB1550)	+= db1x00/
diff --git a/arch/mips/alchemy/devboards/db1300.c b/arch/mips/alchemy/devboards/db1300.c
new file mode 100644
index 0000000..bf0d1c4
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1300.c
@@ -0,0 +1,786 @@
+/*
+ * DBAu1300 init and platform device setup.
+ *
+ * (c) 2009 Manuel Lauss <manuel.lauss@googlemail.com>
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/gpio.h>
+#include <linux/gpio_keys.h>
+#include <linux/init.h>
+#include <linux/input.h>	/* KEY_* codes */
+#include <linux/i2c.h>
+#include <linux/io.h>
+#include <linux/leds.h>
+#include <linux/ata_platform.h>
+#include <linux/mmc/host.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/platform_device.h>
+#include <linux/smsc911x.h>
+
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1100_mmc.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
+#include <asm/mach-db1x00/db1300.h>
+#include <asm/mach-db1x00/bcsr.h>
+#include <asm/mach-au1x00/prom.h>
+
+#include "platform.h"
+
+static struct i2c_board_info db1300_i2c_devs[] __initdata = {
+	{ I2C_BOARD_INFO("wm8731", 0x1b), },	/* I2S audio codec */
+	{ I2C_BOARD_INFO("ne1619", 0x2d), },	/* adm1025-compat hwmon */
+};
+
+/* multifunction pins to assign to GPIO controller */
+static int db1300_gpio_pins[] __initdata = {
+	AU1300_PIN_LCDPWM0, AU1300_PIN_PSC2SYNC1, AU1300_PIN_WAKE1,
+	AU1300_PIN_WAKE2, AU1300_PIN_WAKE3, AU1300_PIN_FG3AUX,
+	AU1300_PIN_EXTCLK1,
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
+	return "DB1300";
+}
+
+/**********************************************************************/
+
+static void au1300_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
+				 unsigned int ctrl)
+{
+	struct nand_chip *this = mtd->priv;
+	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
+
+	ioaddr &= 0xffffff00;
+
+	if (ctrl & NAND_CLE) {
+		ioaddr += MEM_STNAND_CMD;
+	} else if (ctrl & NAND_ALE) {
+		ioaddr += MEM_STNAND_ADDR;
+	} else {
+		/* assume we want to r/w real data  by default */
+		ioaddr += MEM_STNAND_DATA;
+	}
+	this->IO_ADDR_R = this->IO_ADDR_W = (void __iomem *)ioaddr;
+	if (cmd != NAND_CMD_NONE) {
+		__raw_writeb(cmd, this->IO_ADDR_W);
+		wmb();
+	}
+}
+
+static int au1300_nand_device_ready(struct mtd_info *mtd)
+{
+	return __raw_readl((void __iomem *)MEM_STSTAT) & 1;
+}
+
+static const char *db1300_part_probes[] = { "cmdlinepart", NULL };
+
+static struct mtd_partition db1300_nand_parts[] = {
+	{
+		.name	= "NAND FS 0",
+		.offset	= 0,
+		.size	= 8 * 1024 * 1024,
+	},
+	{
+		.name	= "NAND FS 1",
+		.offset	= MTDPART_OFS_APPEND,
+		.size	= MTDPART_SIZ_FULL
+	},
+};
+
+struct platform_nand_data db1300_nand_platdata = {
+	.chip = {
+		.nr_chips	= 1,
+		.chip_offset	= 0,
+		.nr_partitions	= ARRAY_SIZE(db1300_nand_parts),
+		.partitions	= db1300_nand_parts,
+		.chip_delay	= 20,
+		.part_probe_types = db1300_part_probes,
+	},
+	.ctrl = {
+		.dev_ready	= au1300_nand_device_ready,
+		.cmd_ctrl	= au1300_nand_cmd_ctrl,
+	},
+};
+
+static struct resource db1300_nand_res[] = {
+	[0] = {
+		.start	= DB1300_NAND_PHYS_ADDR,
+		.end	= DB1300_NAND_PHYS_ADDR + 0xff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device db1300_nand_dev = {
+	.name		= "gen_nand",
+	.num_resources	= ARRAY_SIZE(db1300_nand_res),
+	.resource	= db1300_nand_res,
+	.id		= -1,
+	.dev		= {
+		.platform_data = &db1300_nand_platdata,
+	}
+};
+
+/**********************************************************************/
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
+		.platform_data	= &db1300_eth_config,
+	},
+};
+
+/**********************************************************************/
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
+		.start	= AU1300_DSCR_CMD0_PSC1_TX,
+		.end	= AU1300_DSCR_CMD0_PSC1_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1300_DSCR_CMD0_PSC1_RX,
+		.end	= AU1300_DSCR_CMD0_PSC1_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device db1300_ac97_dev = {
+	.name		= "au1xpsc_ac97",
+	.id		= 1,	/* PSC ID. match with AC97 codec ID! */
+	.num_resources	= ARRAY_SIZE(au1300_psc1_res),
+	.resource	= au1300_psc1_res,
+};
+
+/**********************************************************************/
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
+		.start	= AU1300_DSCR_CMD0_PSC2_TX,
+		.end	= AU1300_DSCR_CMD0_PSC2_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1300_DSCR_CMD0_PSC2_RX,
+		.end	= AU1300_DSCR_CMD0_PSC2_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device db1300_i2s_dev = {
+	.name		= "au1xpsc_i2s",
+	.id		= 2,	/* PSC ID */
+	.num_resources	= ARRAY_SIZE(au1300_psc2_res),
+	.resource	= au1300_psc2_res,
+};
+
+/**********************************************************************/
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
+		.start	= AU1300_DSCR_CMD0_PSC3_TX,
+		.end	= AU1300_DSCR_CMD0_PSC3_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1300_DSCR_CMD0_PSC3_RX,
+		.end	= AU1300_DSCR_CMD0_PSC3_RX,
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
+/**********************************************************************/
+
+/* proper key assignments when facing the LCD panel.  For key assignments
+ * according to the schematics swap up with down and left with right.
+ * I chose to use it to emulate the arrow keys of a keyboard.
+ */
+static struct gpio_keys_button db1300_5waysw_arrowkeys[] = {
+	{
+		.code			= KEY_DOWN,
+		.gpio			= AU1300_PIN_LCDPWM0,
+		.type			= EV_KEY,
+		.debounce_interval	= 1,
+		.active_low		= 1,
+		.desc			= "5waysw-down",
+	},
+	{
+		.code			= KEY_UP,
+		.gpio			= AU1300_PIN_PSC2SYNC1,
+		.type			= EV_KEY,
+		.debounce_interval	= 1,
+		.active_low		= 1,
+		.desc			= "5waysw-up",
+	},
+	{
+		.code			= KEY_RIGHT,
+		.gpio			= AU1300_PIN_WAKE3,
+		.type			= EV_KEY,
+		.debounce_interval	= 1,
+		.active_low		= 1,
+		.desc			= "5waysw-right",
+	},
+	{
+		.code			= KEY_LEFT,
+		.gpio			= AU1300_PIN_WAKE2,
+		.type			= EV_KEY,
+		.debounce_interval	= 1,
+		.active_low		= 1,
+		.desc			= "5waysw-left",
+	},
+	{
+		.code			= KEY_ENTER,
+		.gpio			= AU1300_PIN_WAKE1,
+		.type			= EV_KEY,
+		.debounce_interval	= 1,
+		.active_low		= 1,
+		.desc			= "5waysw-push",
+	},
+};
+
+static struct gpio_keys_platform_data db1300_5waysw_data = {
+	.buttons	= db1300_5waysw_arrowkeys,
+	.nbuttons	= ARRAY_SIZE(db1300_5waysw_arrowkeys),
+	.rep		= 1,
+	.name		= "db1300-5wayswitch",
+};
+
+static struct platform_device db1300_5waysw_dev = {
+	.name		= "gpio-keys",
+	.dev	= {
+		.platform_data	= &db1300_5waysw_data,
+	},
+};
+
+/**********************************************************************/
+
+static struct platform_device db1300_rtc_dev = {
+	.name	= "rtc-au1xxx",
+	.id	= -1,
+};
+
+/**********************************************************************/
+
+static struct pata_platform_info db1300_ide_info = {
+	.ioport_shift	= DB1300_IDE_REG_SHIFT,
+};
+
+#define IDE_ALT_START	(14 << DB1300_IDE_REG_SHIFT)
+static struct resource db1300_ide_res[] = {
+	[0] = {
+		.start	= DB1300_IDE_PHYS_ADDR,
+		.end	= DB1300_IDE_PHYS_ADDR + IDE_ALT_START - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= DB1300_IDE_PHYS_ADDR + IDE_ALT_START,
+		.end	= DB1300_IDE_PHYS_ADDR + DB1300_IDE_PHYS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[2] = {
+		.start	= DB1300_IDE_INT,
+		.end	= DB1300_IDE_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device db1300_ide_dev = {
+	.dev	= {
+		.platform_data	= &db1300_ide_info,
+	},
+	.name		= "pata_platform",
+	.resource	= db1300_ide_res,
+	.num_resources	= ARRAY_SIZE(db1300_ide_res),
+};
+
+/**********************************************************************/
+
+static irqreturn_t db1300_mmc_cd(int irq, void *ptr)
+{
+	void(*mmc_cd)(struct mmc_host *, unsigned long);
+
+	/* disable the one currently screaming. No other way to shut it up */
+	if (irq == DB1300_SD1_INSERT_INT) {
+		disable_irq_nosync(DB1300_SD1_INSERT_INT);
+		enable_irq(DB1300_SD1_EJECT_INT);
+	} else {
+		disable_irq_nosync(DB1300_SD1_EJECT_INT);
+		enable_irq(DB1300_SD1_INSERT_INT);
+	}
+
+	/* link against CONFIG_MMC=m.  We can only be called once MMC core has
+	 * initialized the controller, so symbol_get() should always succeed.
+	 */
+	mmc_cd = symbol_get(mmc_detect_change);
+	mmc_cd(ptr, msecs_to_jiffies(500));
+	symbol_put(mmc_detect_change);
+
+	return IRQ_HANDLED;
+}
+
+static int db1300_mmc_card_readonly(void *mmc_host)
+{
+	/* it uses SD1 interface, but the DB1200's SD0 bit in the CPLD */
+	return bcsr_read(BCSR_STATUS) & BCSR_STATUS_SD0WP;
+}
+
+static int db1300_mmc_card_inserted(void *mmc_host)
+{
+	return bcsr_read(BCSR_SIGSTAT) & (1 << 12); /* insertion irq signal */
+}
+
+static int db1300_mmc_cd_setup(void *mmc_host, int en)
+{
+	int ret;
+
+	if (en) {
+		ret = request_irq(DB1300_SD1_INSERT_INT, db1300_mmc_cd, 0,
+				  "sd_insert", mmc_host);
+		if (ret)
+			goto out;
+
+		ret = request_irq(DB1300_SD1_EJECT_INT, db1300_mmc_cd, 0,
+				  "sd_eject", mmc_host);
+		if (ret) {
+			free_irq(DB1300_SD1_INSERT_INT, mmc_host);
+			goto out;
+		}
+
+		if (db1300_mmc_card_inserted(mmc_host))
+			enable_irq(DB1300_SD1_EJECT_INT);
+		else
+			enable_irq(DB1300_SD1_INSERT_INT);
+
+	} else {
+		free_irq(DB1300_SD1_INSERT_INT, mmc_host);
+		free_irq(DB1300_SD1_EJECT_INT, mmc_host);
+	}
+	ret = 0;
+out:
+	return ret;
+}
+
+static void db1300_mmcled_set(struct led_classdev *led,
+			      enum led_brightness brightness)
+{
+	if (brightness != LED_OFF)
+		bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED0, 0);
+	else
+		bcsr_mod(BCSR_LEDS, 0, BCSR_LEDS_LED0);
+}
+
+static struct led_classdev db1300_mmc_led = {
+	.brightness_set	= db1300_mmcled_set,
+};
+
+struct au1xmmc_platform_data db1300_sd1_platdata = {
+	.cd_setup	= db1300_mmc_cd_setup,
+	.card_inserted	= db1300_mmc_card_inserted,
+	.card_readonly	= db1300_mmc_card_readonly,
+	.led		= &db1300_mmc_led,
+};
+
+static struct resource au1300_sd1_res[] = {
+	[0] = {
+		.start	= AU1300_SD1_PHYS_ADDR,
+		.end	= AU1300_SD1_PHYS_ADDR,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1300_SD1_INT,
+		.end	= AU1300_SD1_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1300_DSCR_CMD0_SDMS_TX1,
+		.end	= AU1300_DSCR_CMD0_SDMS_TX1,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1300_DSCR_CMD0_SDMS_RX1,
+		.end	= AU1300_DSCR_CMD0_SDMS_RX1,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device db1300_sd1_dev = {
+	.dev = {
+		.platform_data	= &db1300_sd1_platdata,
+	},
+	.name		= "au1xxx-mmc",
+	.id		= 1,
+	.resource	= au1300_sd1_res,
+	.num_resources	= ARRAY_SIZE(au1300_sd1_res),
+};
+
+/**********************************************************************/
+
+static int db1300_movinand_inserted(void *mmc_host)
+{
+	return 0; /* disable for now, it doesn't work yet */
+}
+
+static int db1300_movinand_readonly(void *mmc_host)
+{
+	return 0;
+}
+
+static void db1300_movinand_led_set(struct led_classdev *led,
+				    enum led_brightness brightness)
+{
+	if (brightness != LED_OFF)
+		bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED1, 0);
+	else
+		bcsr_mod(BCSR_LEDS, 0, BCSR_LEDS_LED1);
+}
+
+static struct led_classdev db1300_movinand_led = {
+	.brightness_set		= db1300_movinand_led_set,
+};
+
+struct au1xmmc_platform_data db1300_sd0_platdata = {
+	.card_inserted		= db1300_movinand_inserted,
+	.card_readonly		= db1300_movinand_readonly,
+	.led			= &db1300_movinand_led,
+	.mask_host_caps		= MMC_CAP_NEEDS_POLL,
+};
+
+static struct resource au1300_sd0_res[] = {
+	[0] = {
+		.start	= AU1100_SD0_PHYS_ADDR,
+		.end	= AU1100_SD0_PHYS_ADDR,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1300_SD0_INT,
+		.end	= AU1300_SD0_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1300_DSCR_CMD0_SDMS_TX0,
+		.end	= AU1300_DSCR_CMD0_SDMS_TX0,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1300_DSCR_CMD0_SDMS_RX0,
+		.end	= AU1300_DSCR_CMD0_SDMS_RX0,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device db1300_sd0_dev = {
+	.dev = {
+		.platform_data	= &db1300_sd0_platdata,
+	},
+	.name		= "au1xxx-mmc",
+	.id		= 0,
+	.resource	= au1300_sd0_res,
+	.num_resources	= ARRAY_SIZE(au1300_sd0_res),
+};
+
+/**********************************************************************/
+
+static struct platform_device db1300_wm9715_dev = {
+	.name		= "wm9712-codec",
+	.id		= 1,	/* ID of PSC for AC97 audio, see asoc glue! */
+};
+
+static struct platform_device db1300_ac97dma_dev = {
+	.name		= "au1xpsc-pcm",
+	.id		= 1,	/* PSC ID */
+};
+
+static struct platform_device db1300_i2sdma_dev = {
+	.name		= "au1xpsc-pcm",
+	.id		= 2,	/* PSC ID */
+};
+
+static struct platform_device db1300_sndac97_dev = {
+	.name		= "db1300-ac97",
+};
+
+static struct platform_device db1300_sndi2s_dev = {
+	.name		= "db1300-i2s",
+};
+
+/**********************************************************************/
+
+static struct resource au1300_lcd_res[] = {
+	[0] = {
+		.start	= AU1200_LCD_PHYS_ADDR,
+		.end	= AU1200_LCD_PHYS_ADDR + 0x800 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1300_LCD_INT,
+		.end	= AU1300_LCD_INT,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static u64 au1300_lcd_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device db1300_lcd_dev = {
+	.name		= "au1200-lcd",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1300_lcd_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(au1300_lcd_res),
+	.resource	= au1300_lcd_res,
+};
+
+/**********************************************************************/
+
+static struct platform_device *db1300_dev[] __initdata = {
+	&db1300_eth_dev,
+	&db1300_i2c_dev,
+	&db1300_5waysw_dev,
+	&db1300_rtc_dev,
+	&db1300_nand_dev,
+	&db1300_ide_dev,
+	&db1300_sd0_dev,
+	&db1300_sd1_dev,
+	&db1300_lcd_dev,
+	&db1300_ac97_dev,
+	&db1300_i2s_dev,
+	&db1300_wm9715_dev,
+	&db1300_ac97dma_dev,
+	&db1300_i2sdma_dev,
+	&db1300_sndac97_dev,
+	&db1300_sndi2s_dev,
+};
+
+static int __init db1300_device_init(void)
+{
+	int swapped, cpldirq;
+
+	/* setup CPLD IRQ muxer */
+	cpldirq = au1300_gpio_to_irq(AU1300_PIN_EXTCLK1);
+	irq_set_irq_type(cpldirq, IRQ_TYPE_LEVEL_HIGH);
+	bcsr_init_irq(DB1300_FIRST_INT, DB1300_LAST_INT, cpldirq);
+
+	/* insert/eject IRQs: one always triggers so don't enable them
+	 * when doing request_irq() on them.  DB1200 has this bug too.
+	 */
+	irq_set_status_flags(DB1300_SD1_INSERT_INT, IRQ_NOAUTOEN);
+	irq_set_status_flags(DB1300_SD1_EJECT_INT, IRQ_NOAUTOEN);
+	irq_set_status_flags(DB1300_CF_INSERT_INT, IRQ_NOAUTOEN);
+	irq_set_status_flags(DB1300_CF_EJECT_INT, IRQ_NOAUTOEN);
+
+	/*
+	 * setup board
+	 */
+	prom_get_ethernet_addr(&db1300_eth_config.mac[0]);
+
+	i2c_register_board_info(0, db1300_i2c_devs,
+				ARRAY_SIZE(db1300_i2c_devs));
+
+	/* Audio PSC clock is supplied by codecs (PSC1, 2) */
+	__raw_writel(PSC_SEL_CLK_SERCLK,
+	    (void __iomem *)KSEG1ADDR(AU1300_PSC1_PHYS_ADDR) + PSC_SEL_OFFSET);
+	wmb();
+	__raw_writel(PSC_SEL_CLK_SERCLK,
+	    (void __iomem *)KSEG1ADDR(AU1300_PSC2_PHYS_ADDR) + PSC_SEL_OFFSET);
+	wmb();
+	/* I2C uses internal 48MHz EXTCLK1 */
+	__raw_writel(PSC_SEL_CLK_INTCLK,
+	    (void __iomem *)KSEG1ADDR(AU1300_PSC3_PHYS_ADDR) + PSC_SEL_OFFSET);
+	wmb();
+
+	/* enable power to USB ports */
+	bcsr_mod(BCSR_RESETS, 0, BCSR_RESETS_USBHPWR | BCSR_RESETS_OTGPWR);
+
+	/* although it is socket #0, it uses the CPLD bits which previous boards
+	 * have used for socket #1.
+	 */
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x00400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x00400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x00010000 - 1,
+		DB1300_CF_INT, DB1300_CF_INSERT_INT, 0, DB1300_CF_EJECT_INT, 1);
+
+	swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1200_SWAPBOOT;
+	db1x_register_norflash(64 << 20, 2, swapped);
+
+	return platform_add_devices(db1300_dev, ARRAY_SIZE(db1300_dev));
+}
+device_initcall(db1300_device_init);
+
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
+	printk(KERN_INFO "NetLogic DBAu1300 Development Platform.\n\t"
+		"BoardID %d   CPLD Rev %d   DaughtercardID %d\n",
+		BCSR_WHOAMI_BOARD(whoami), BCSR_WHOAMI_CPLD(whoami),
+		BCSR_WHOAMI_DCID(whoami));
+
+	/* enable UARTs, YAMON only enables #2 */
+	alchemy_uart_enable(AU1300_UART0_PHYS_ADDR);
+	alchemy_uart_enable(AU1300_UART1_PHYS_ADDR);
+	alchemy_uart_enable(AU1300_UART3_PHYS_ADDR);
+}
+
+
+/* au1200fb calls these: STERBT EINEN TRAGISCHEN TOD!!! */
+int board_au1200fb_panel(void)
+{
+	return 9;	/* DB1300_800x480 */
+}
+
+int board_au1200fb_panel_init(void)
+{
+	/* Apply power (Vee/Vdd logic is inverted on Panel DB1300_800x480) */
+	bcsr_mod(BCSR_BOARD, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD,
+			     BCSR_BOARD_LCDBL);
+	return 0;
+}
+
+int board_au1200fb_panel_shutdown(void)
+{
+	/* Remove power (Vee/Vdd logic is inverted on Panel DB1300_800x480) */
+	bcsr_mod(BCSR_BOARD, BCSR_BOARD_LCDBL,
+			     BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD);
+	return 0;
+}
diff --git a/arch/mips/alchemy/devboards/prom.c b/arch/mips/alchemy/devboards/prom.c
index f734833..3a73f96 100644
--- a/arch/mips/alchemy/devboards/prom.c
+++ b/arch/mips/alchemy/devboards/prom.c
@@ -61,5 +61,9 @@ void __init prom_init(void)
 
 void prom_putchar(unsigned char c)
 {
+#ifdef CONFIG_MIPS_DB1300
+	alchemy_uart_putchar(AU1300_UART2_PHYS_ADDR, c);
+#else
 	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
+#endif
 }
diff --git a/arch/mips/boot/compressed/uart-alchemy.c b/arch/mips/boot/compressed/uart-alchemy.c
index eb063e6..3112df8 100644
--- a/arch/mips/boot/compressed/uart-alchemy.c
+++ b/arch/mips/boot/compressed/uart-alchemy.c
@@ -2,6 +2,9 @@
 
 void putc(char c)
 {
-	/* all current (Jan. 2010) in-kernel boards */
+#ifdef CONFIG_MIPS_DB1300
+	alchemy_uart_putchar(AU1300_UART2_PHYS_ADDR, c);
+#else
 	alchemy_uart_putchar(AU1000_UART0_PHYS_ADDR, c);
+#endif
 }
diff --git a/arch/mips/configs/db1300_defconfig b/arch/mips/configs/db1300_defconfig
new file mode 100644
index 0000000..c38b190
--- /dev/null
+++ b/arch/mips/configs/db1300_defconfig
@@ -0,0 +1,391 @@
+CONFIG_MIPS=y
+CONFIG_MIPS_ALCHEMY=y
+CONFIG_ALCHEMY_GPIOINT_AU1300=y
+CONFIG_MIPS_DB1300=y
+CONFIG_SOC_AU1300=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_CEVT_R4K_LIB=y
+CONFIG_CSRC_R4K_LIB=y
+CONFIG_DMA_COHERENT=y
+CONFIG_SYS_HAS_EARLY_PRINTK=y
+CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
+CONFIG_GENERIC_GPIO=y
+CONFIG_CPU_LITTLE_ENDIAN=y
+CONFIG_SYS_SUPPORTS_APM_EMULATION=y
+CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
+CONFIG_IRQ_CPU=y
+CONFIG_MIPS_L1_CACHE_SHIFT=5
+CONFIG_CPU_MIPS32_R1=y
+CONFIG_SYS_SUPPORTS_ZBOOT=y
+CONFIG_SYS_HAS_CPU_MIPS32_R1=y
+CONFIG_CPU_MIPS32=y
+CONFIG_CPU_MIPSR1=y
+CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
+CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_HARDWARE_WATCHPOINTS=y
+CONFIG_32BIT=y
+CONFIG_PAGE_SIZE_4KB=y
+CONFIG_FORCE_MAX_ZONEORDER=11
+CONFIG_CPU_HAS_PREFETCH=y
+CONFIG_MIPS_MT_DISABLED=y
+CONFIG_64BIT_PHYS_ADDR=y
+CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
+CONFIG_CPU_HAS_SYNC=y
+CONFIG_CPU_SUPPORTS_HIGHMEM=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_COMPACTION=y
+CONFIG_MIGRATION=y
+CONFIG_PHYS_ADDR_T_64BIT=y
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
+CONFIG_NEED_PER_CPU_KM=y
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
+CONFIG_HZ_100=y
+CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
+CONFIG_HZ=100
+CONFIG_PREEMPT_NONE=y
+CONFIG_LOCKDEP_SUPPORT=y
+CONFIG_STACKTRACE_SUPPORT=y
+CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
+CONFIG_CONSTRUCTORS=y
+CONFIG_HAVE_IRQ_WORK=y
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE=""
+CONFIG_LOCALVERSION="-db1300"
+CONFIG_LOCALVERSION_AUTO=y
+CONFIG_HAVE_KERNEL_GZIP=y
+CONFIG_HAVE_KERNEL_BZIP2=y
+CONFIG_HAVE_KERNEL_LZMA=y
+CONFIG_HAVE_KERNEL_LZO=y
+CONFIG_KERNEL_LZMA=y
+CONFIG_SWAP=y
+CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
+CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
+CONFIG_FHANDLE=y
+CONFIG_HAVE_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_GENERIC_IRQ_SHOW=y
+CONFIG_TINY_RCU=y
+CONFIG_LOG_BUF_SHIFT=19
+CONFIG_NAMESPACES=y
+CONFIG_UTS_NS=y
+CONFIG_IPC_NS=y
+CONFIG_USER_NS=y
+CONFIG_PID_NS=y
+CONFIG_NET_NS=y
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
+CONFIG_EXPERT=y
+CONFIG_SYSCTL_SYSCALL=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_HOTPLUG=y
+CONFIG_PRINTK=y
+CONFIG_BUG=y
+CONFIG_ELF_CORE=y
+CONFIG_BASE_FULL=y
+CONFIG_FUTEX=y
+CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
+CONFIG_SHMEM=y
+CONFIG_AIO=y
+CONFIG_EMBEDDED=y
+CONFIG_HAVE_PERF_EVENTS=y
+CONFIG_PERF_USE_VMALLOC=y
+CONFIG_SLAB=y
+CONFIG_HAVE_OPROFILE=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_DMA_ATTRS=y
+CONFIG_HAVE_DMA_API_DEBUG=y
+CONFIG_HAVE_ARCH_JUMP_LABEL=y
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
+CONFIG_BLOCK=y
+CONFIG_LBDAF=y
+CONFIG_BLK_DEV_BSG=y
+CONFIG_IOSCHED_NOOP=y
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
+CONFIG_INLINE_SPIN_UNLOCK=y
+CONFIG_INLINE_SPIN_UNLOCK_IRQ=y
+CONFIG_INLINE_READ_UNLOCK=y
+CONFIG_INLINE_READ_UNLOCK_IRQ=y
+CONFIG_INLINE_WRITE_UNLOCK=y
+CONFIG_INLINE_WRITE_UNLOCK_IRQ=y
+CONFIG_MMU=y
+CONFIG_PCCARD=y
+CONFIG_PCMCIA=y
+CONFIG_PCMCIA_LOAD_CIS=y
+CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
+CONFIG_BINFMT_ELF=y
+CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
+CONFIG_TRAD_SIGNALS=y
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_XFRM=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_IP_PNP_BOOTP=y
+CONFIG_IP_PNP_RARP=y
+CONFIG_INET_TUNNEL=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+CONFIG_IPV6=y
+CONFIG_INET6_XFRM_MODE_TRANSPORT=y
+CONFIG_INET6_XFRM_MODE_TUNNEL=y
+CONFIG_INET6_XFRM_MODE_BEET=y
+CONFIG_IPV6_SIT=y
+CONFIG_IPV6_NDISC_NODETYPE=y
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+CONFIG_MTD=y
+CONFIG_MTD_CMDLINE_PARTS=y
+CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
+CONFIG_MTD_BLOCK=y
+CONFIG_MTD_CFI=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
+CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_UTIL=y
+CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_NAND_ECC=y
+CONFIG_MTD_NAND=y
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_PLATFORM=y
+CONFIG_BLK_DEV=y
+CONFIG_BLK_DEV_LOOP=y
+CONFIG_BLK_DEV_UB=y
+CONFIG_HAVE_IDE=y
+CONFIG_IDE=y
+CONFIG_IDE_GD=y
+CONFIG_IDE_GD_ATA=y
+CONFIG_BLK_DEV_IDECS=y
+CONFIG_IDE_TASK_IOCTL=y
+CONFIG_IDE_PROC_FS=y
+CONFIG_BLK_DEV_PLATFORM=y
+CONFIG_SCSI_MOD=y
+CONFIG_NETDEVICES=y
+CONFIG_MII=y
+CONFIG_PHYLIB=y
+CONFIG_SMSC_PHY=y
+CONFIG_NET_ETHERNET=y
+CONFIG_SMSC911X=y
+CONFIG_INPUT=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_GPIO=y
+CONFIG_INPUT_TOUCHSCREEN=y
+CONFIG_TOUCHSCREEN_WM97XX=y
+CONFIG_TOUCHSCREEN_WM9712=y
+CONFIG_TOUCHSCREEN_WM9713=y
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_UINPUT=y
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_SMBUS=y
+CONFIG_I2C_AU1550=y
+CONFIG_SPI=y
+CONFIG_SPI_MASTER=y
+CONFIG_SPI_AU1550=y
+CONFIG_SPI_BITBANG=y
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+CONFIG_HWMON=y
+CONFIG_HWMON_VID=y
+CONFIG_SENSORS_ADM1025=y
+CONFIG_FB=y
+CONFIG_FB_AU1200=y
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_FRAMEBUFFER_CONSOLE=y
+CONFIG_FONTS=y
+CONFIG_FONT_ACORN_8x8=y
+CONFIG_LOGO=y
+CONFIG_LOGO_LINUX_CLUT224=y
+CONFIG_SOUND=y
+CONFIG_SND=y
+CONFIG_SND_TIMER=y
+CONFIG_SND_PCM=y
+CONFIG_SND_JACK=y
+CONFIG_SND_HRTIMER=y
+CONFIG_SND_DYNAMIC_MINORS=y
+CONFIG_SND_VERBOSE_PROCFS=y
+CONFIG_SND_VERBOSE_PRINTK=y
+CONFIG_SND_VMASTER=y
+CONFIG_SND_AC97_CODEC=y
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_CACHE_LZO=y
+CONFIG_SND_SOC_AC97_BUS=y
+CONFIG_SND_SOC_AU1XPSC=y
+CONFIG_SND_SOC_AU1XPSC_I2S=y
+CONFIG_SND_SOC_AU1XPSC_AC97=y
+CONFIG_SND_SOC_DB1300=y
+CONFIG_SND_SOC_I2C_AND_SPI=y
+CONFIG_SND_SOC_WM8731=y
+CONFIG_SND_SOC_WM9712=y
+CONFIG_AC97_BUS=y
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+CONFIG_HIDRAW=y
+CONFIG_USB_HID=y
+CONFIG_USB_HIDDEV=y
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+CONFIG_USB=y
+CONFIG_USB_DYNAMIC_MINORS=y
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_EHCI_TT_NEWSCHED=y
+CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+CONFIG_RTC_INTF_DEV_UIE_EMUL=y
+CONFIG_RTC_DRV_AU1XXX=y
+CONFIG_EXT2_FS=y
+CONFIG_FS_POSIX_ACL=y
+CONFIG_EXPORTFS=y
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY_USER=y
+CONFIG_GENERIC_ACL=y
+CONFIG_FAT_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+CONFIG_PROC_FS=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_PROC_PAGE_MONITOR=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
+CONFIG_TMPFS_POSIX_ACL=y
+CONFIG_TMPFS_XATTR=y
+CONFIG_MISC_FILESYSTEMS=y
+CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
+CONFIG_JFFS2_SUMMARY=y
+CONFIG_JFFS2_FS_XATTR=y
+CONFIG_JFFS2_FS_POSIX_ACL=y
+CONFIG_JFFS2_FS_SECURITY=y
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_LZO=y
+CONFIG_JFFS2_RTIME=y
+CONFIG_JFFS2_RUBIN=y
+CONFIG_JFFS2_CMODE_PRIORITY=y
+CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_XZ=y
+CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
+CONFIG_NETWORK_FILESYSTEMS=y
+CONFIG_NFS_FS=y
+CONFIG_NFS_V3=y
+CONFIG_ROOT_NFS=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_MSDOS_PARTITION=y
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
+CONFIG_NLS_CODEPAGE_437=y
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+CONFIG_NLS_ISO8859_15=y
+CONFIG_NLS_UTF8=y
+CONFIG_TRACE_IRQFLAGS_SUPPORT=y
+CONFIG_PRINTK_TIME=y
+CONFIG_DEFAULT_MESSAGE_LOGLEVEL=4
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+CONFIG_MAGIC_SYSRQ=y
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_HAVE_C_RECORDMCOUNT=y
+CONFIG_TRACING_SUPPORT=y
+CONFIG_HAVE_ARCH_KGDB=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="video=au1200fb:panel:bs console=tty console=ttyS2,115200"
+CONFIG_DEBUG_ZBOOT=y
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+CONFIG_CRYPTO=y
+CONFIG_BITREVERSE=y
+CONFIG_CRC32=y
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
+CONFIG_XZ_DEC=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
+CONFIG_GENERIC_ATOMIC64=y
diff --git a/arch/mips/include/asm/mach-db1x00/bcsr.h b/arch/mips/include/asm/mach-db1x00/bcsr.h
index 618d2de..0ef6300 100644
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
@@ -118,12 +121,12 @@ enum bcsr_whoami_boards {
 #define BCSR_STATUS_SRAMWIDTH		0x0080
 #define BCSR_STATUS_FLASHBUSY		0x0100
 #define BCSR_STATUS_ROMBUSY		0x0400
-#define BCSR_STATUS_SD0WP		0x0400	/* DB1200 */
+#define BCSR_STATUS_SD0WP		0x0400	/* DB1200/DB1300:SD1 */
 #define BCSR_STATUS_SD1WP		0x0800
 #define BCSR_STATUS_USBOTGID		0x0800	/* PB/DB1550 */
 #define BCSR_STATUS_DB1000_SWAPBOOT	0x2000
-#define BCSR_STATUS_DB1200_SWAPBOOT	0x0040	/* DB1200 */
-#define BCSR_STATUS_IDECBLID		0x0200	/* DB1200 */
+#define BCSR_STATUS_DB1200_SWAPBOOT	0x0040	/* DB1200/1300 */
+#define BCSR_STATUS_IDECBLID		0x0200	/* DB1200/1300 */
 #define BCSR_STATUS_DB1200_U0RXD	0x1000	/* DB1200 */
 #define BCSR_STATUS_DB1200_U1RXD	0x2000	/* DB1200 */
 #define BCSR_STATUS_FLASHDEN		0xC000
@@ -133,6 +136,11 @@ enum bcsr_whoami_boards {
 #define BCSR_STATUS_PB1550_U1RXD	0x2000	/* PB1550 */
 #define BCSR_STATUS_PB1550_U3RXD	0x8000	/* PB1550 */
 
+#define BCSR_STATUS_CFWP		0x4000	/* DB1300 */
+#define BCSR_STATUS_USBOCn		0x2000	/* DB1300 */
+#define BCSR_STATUS_OTGOCn		0x1000	/* DB1300 */
+#define BCSR_STATUS_DCDMARQ		0x0010	/* DB1300 */
+#define BCSR_STATUS_IDEDMARQ		0x0020	/* DB1300 */
 
 /* DB/PB1000,1100,1500,1550 */
 #define BCSR_RESETS_PHY0		0x0001
@@ -160,12 +168,12 @@ enum bcsr_whoami_boards {
 #define BCSR_BOARD_SD1WP		0x8000	/* DB1100 */
 
 
-/* DB/PB1200 */
+/* DB/PB1200/1300 */
 #define BCSR_RESETS_ETH			0x0001
 #define BCSR_RESETS_CAMERA		0x0002
 #define BCSR_RESETS_DC			0x0004
 #define BCSR_RESETS_IDE			0x0008
-#define BCSR_RESETS_TV			0x0010	/* DB1200 */
+#define BCSR_RESETS_TV			0x0010	/* DB1200/1300 */
 /* Not resets but in the same register */
 #define BCSR_RESETS_PWMR1MUX		0x0800	/* DB1200 */
 #define BCSR_RESETS_PB1200_WSCFSM	0x0800	/* PB1200 */
@@ -174,13 +182,22 @@ enum bcsr_whoami_boards {
 #define BCSR_RESETS_SPISEL		0x4000
 #define BCSR_RESETS_SD1MUX		0x8000	/* PB1200 */
 
+#define BCSR_RESETS_VDDQSHDN		0x0200	/* DB1300 */
+#define BCSR_RESETS_OTPPGM		0x0400	/* DB1300 */
+#define BCSR_RESETS_OTPSCLK		0x0800	/* DB1300 */
+#define BCSR_RESETS_OTPWRPROT		0x1000	/* DB1300 */
+#define BCSR_RESETS_OTPCSB		0x2000	/* DB1300 */
+#define BCSR_RESETS_OTGPWR		0x4000	/* DB1300 */
+#define BCSR_RESETS_USBHPWR		0x8000  /* DB1300 */
+
 #define BCSR_BOARD_LCDVEE		0x0001
 #define BCSR_BOARD_LCDVDD		0x0002
 #define BCSR_BOARD_LCDBL		0x0004
 #define BCSR_BOARD_CAMSNAP		0x0010
 #define BCSR_BOARD_CAMPWR		0x0020
 #define BCSR_BOARD_SD0PWR		0x0040
-
+#define BCSR_BOARD_CAMCS		0x0010	/* DB1300 */
+#define BCSR_BOARD_HDMI_DE		0x0040	/* DB1300 */
 
 #define BCSR_SWITCHES_DIP		0x00FF
 #define BCSR_SWITCHES_DIP_1		0x0080
@@ -214,7 +231,10 @@ enum bcsr_whoami_boards {
 #define BCSR_SYSTEM_RESET		0x8000	/* clear to reset */
 #define BCSR_SYSTEM_PWROFF		0x4000	/* set to power off */
 #define BCSR_SYSTEM_VDDI		0x001F	/* PB1xxx boards */
-
+#define BCSR_SYSTEM_DEBUGCSMASK		0x003F	/* DB1300 */
+#define BCSR_SYSTEM_UDMAMODE		0x0100	/* DB1300 */
+#define BCSR_SYSTEM_WAKEONIRQ		0x0200	/* DB1300 */
+#define BCSR_SYSTEM_VDDI1300		0x3C00	/* DB1300 */
 
 
 
diff --git a/arch/mips/include/asm/mach-db1x00/db1300.h b/arch/mips/include/asm/mach-db1x00/db1300.h
new file mode 100644
index 0000000..7fe5fb3
--- /dev/null
+++ b/arch/mips/include/asm/mach-db1x00/db1300.h
@@ -0,0 +1,40 @@
+/*
+ * NetLogic DB1300 board constants
+ */
+
+#ifndef _DB1300_H_
+#define _DB1300_H_
+
+/* FPGA (external mux) interrupt sources */
+#define DB1300_FIRST_INT	(ALCHEMY_GPIC_INT_LAST + 1)
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
+/* SMSC9210 CS */
+#define DB1300_ETH_PHYS_ADDR	0x19000000
+#define DB1300_ETH_PHYS_END	0x197fffff
+
+/* ATA CS */
+#define DB1300_IDE_PHYS_ADDR	0x18800000
+#define DB1300_IDE_REG_SHIFT	5
+#define DB1300_IDE_PHYS_LEN	(16 << DB1300_IDE_REG_SHIFT)
+
+/* NAND CS */
+#define DB1300_NAND_PHYS_ADDR	0x20000000
+#define DB1300_NAND_PHYS_END	0x20000fff
+
+#endif	/* _DB1300_H_ */
diff --git a/arch/mips/include/asm/mach-db1x00/irq.h b/arch/mips/include/asm/mach-db1x00/irq.h
new file mode 100644
index 0000000..15b2669
--- /dev/null
+++ b/arch/mips/include/asm/mach-db1x00/irq.h
@@ -0,0 +1,23 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2003 by Ralf Baechle
+ */
+#ifndef __ASM_MACH_GENERIC_IRQ_H
+#define __ASM_MACH_GENERIC_IRQ_H
+
+
+#ifdef NR_IRQS
+#undef NR_IRQS
+#endif
+
+#ifndef MIPS_CPU_IRQ_BASE
+#define MIPS_CPU_IRQ_BASE 0
+#endif
+
+/* 8 (MIPS) + 128 (au1300) + 16 (cpld) */
+#define NR_IRQS 152
+
+#endif /* __ASM_MACH_GENERIC_IRQ_H */
diff --git a/drivers/pcmcia/Kconfig b/drivers/pcmcia/Kconfig
index c022b5c..f9e3fb3 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -161,8 +161,8 @@ config PCMCIA_ALCHEMY_DEVBOARD
 	select 64BIT_PHYS_ADDR
 	help
 	  Enable this driver of you want PCMCIA support on your Alchemy
-	  Db1000, Db/Pb1100, Db/Pb1500, Db/Pb1550, Db/Pb1200 board.
-	  NOT suitable for the PB1000!
+	  Db1000, Db/Pb1100, Db/Pb1500, Db/Pb1550, Db/Pb1200, DB1300
+	  board.  NOT suitable for the PB1000!
 
 	  This driver is also available as a module called db1xxx_ss.ko
 
diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index 01757f1..984f431 100644
--- a/drivers/pcmcia/db1xxx_ss.c
+++ b/drivers/pcmcia/db1xxx_ss.c
@@ -7,7 +7,7 @@
 
 /* This is a fairly generic PCMCIA socket driver suitable for the
  * following Alchemy Development boards:
- *  Db1000, Db/Pb1500, Db/Pb1100, Db/Pb1550, Db/Pb1200.
+ *  Db1000, Db/Pb1500, Db/Pb1100, Db/Pb1550, Db/Pb1200, Db1300
  *
  * The Db1000 is used as a reference:  Per-socket card-, carddetect- and
  *  statuschange IRQs connected to SoC GPIOs, control and status register
@@ -18,6 +18,7 @@
  *	- Pb1100/Pb1500:  single socket only; voltage key bits VS are
  *			  at STATUS[5:4] (instead of STATUS[1:0]).
  *	- Au1200-based:	  additional card-eject irqs, irqs not gpios!
+ *	- Db1300:	  Db1200-like, no pwr ctrl, single socket (#1).
  */
 
 #include <linux/delay.h>
@@ -58,11 +59,17 @@ struct db1x_pcmcia_sock {
 #define BOARD_TYPE_DEFAULT	0	/* most boards */
 #define BOARD_TYPE_DB1200	1	/* IRQs aren't gpios */
 #define BOARD_TYPE_PB1100	2	/* VS bits slightly different */
+#define BOARD_TYPE_DB1300	3	/* no power control */
 	int	board_type;
 };
 
 #define to_db1x_socket(x) container_of(x, struct db1x_pcmcia_sock, socket)
 
+static int db1300_card_inserted(struct db1x_pcmcia_sock *sock)
+{
+	return bcsr_read(BCSR_SIGSTAT) & (1 << 8);
+}
+
 /* DB/PB1200: check CPLD SIGSTATUS register bit 10/12 */
 static int db1200_card_inserted(struct db1x_pcmcia_sock *sock)
 {
@@ -83,6 +90,8 @@ static int db1x_card_inserted(struct db1x_pcmcia_sock *sock)
 	switch (sock->board_type) {
 	case BOARD_TYPE_DB1200:
 		return db1200_card_inserted(sock);
+	case BOARD_TYPE_DB1300:
+		return db1300_card_inserted(sock);
 	default:
 		return db1000_card_inserted(sock);
 	}
@@ -159,7 +168,8 @@ static int db1x_pcmcia_setup_irqs(struct db1x_pcmcia_sock *sock)
 	 * ejection handler have been registered and the currently
 	 * active one disabled.
 	 */
-	if (sock->board_type == BOARD_TYPE_DB1200) {
+	if ((sock->board_type == BOARD_TYPE_DB1200) ||
+	    (sock->board_type == BOARD_TYPE_DB1300)) {
 		ret = request_irq(sock->insert_irq, db1200_pcmcia_cdirq,
 				  IRQF_DISABLED, "pcmcia_insert", sock);
 		if (ret)
@@ -173,7 +183,7 @@ static int db1x_pcmcia_setup_irqs(struct db1x_pcmcia_sock *sock)
 		}
 
 		/* enable the currently silent one */
-		if (db1200_card_inserted(sock))
+		if (db1x_card_inserted(sock))
 			enable_irq(sock->eject_irq);
 		else
 			enable_irq(sock->insert_irq);
@@ -269,7 +279,8 @@ static int db1x_pcmcia_configure(struct pcmcia_socket *skt,
 	}
 
 	/* create new voltage code */
-	cr_set |= ((v << 2) | p) << (sock->nr * 8);
+	if (sock->board_type != BOARD_TYPE_DB1300)
+		cr_set |= ((v << 2) | p) << (sock->nr * 8);
 
 	changed = state->flags ^ sock->old_flags;
 
@@ -342,6 +353,10 @@ static int db1x_pcmcia_get_status(struct pcmcia_socket *skt,
 	/* if Vcc is not zero, we have applied power to a card */
 	status |= GET_VCC(cr, sock->nr) ? SS_POWERON : 0;
 
+	/* DB1300: power always on, but don't tell when no card present */
+	if ((sock->board_type == BOARD_TYPE_DB1300) && (status & SS_DETECT))
+		status = SS_POWERON | SS_3VCARD | SS_DETECT;
+
 	/* reset de-asserted? then we're ready */
 	status |= (GET_RESET(cr, sock->nr)) ? SS_READY : SS_RESET;
 
@@ -418,6 +433,9 @@ static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
 	case BCSR_WHOAMI_PB1200 ... BCSR_WHOAMI_DB1200:
 		sock->board_type = BOARD_TYPE_DB1200;
 		break;
+	case BCSR_WHOAMI_DB1300:
+		sock->board_type = BOARD_TYPE_DB1300;
+		break;
 	default:
 		printk(KERN_INFO "db1xxx-ss: unknown board %d!\n", bid);
 		ret = -ENODEV;
diff --git a/drivers/video/au1200fb.c b/drivers/video/au1200fb.c
index 7200559..6c4342f 100644
--- a/drivers/video/au1200fb.c
+++ b/drivers/video/au1200fb.c
@@ -639,6 +639,42 @@ static struct panel_settings known_lcd_panels[] =
 		856, 856,
 		480, 480,
 	},
+	[9] = {
+		.name = "DB1300_800x480",
+		.monspecs = {
+			.modedb = NULL,
+			.modedb_len = 0,
+			.hfmin = 30000,
+			.hfmax = 70000,
+			.vfmin = 60,
+			.vfmax = 60,
+			.dclkmin = 6000000,
+			.dclkmax = 28000000,
+			.input = FB_DISP_RGB,
+		},
+		.mode_screen		= LCD_SCREEN_SX_N(800) |
+					  LCD_SCREEN_SY_N(480),
+		.mode_horztiming	= LCD_HORZTIMING_HPW_N(5) |
+					  LCD_HORZTIMING_HND1_N(16) |
+					  LCD_HORZTIMING_HND2_N(8),
+		.mode_verttiming	= LCD_VERTTIMING_VPW_N(4) |
+					  LCD_VERTTIMING_VND1_N(8) |
+					  LCD_VERTTIMING_VND2_N(5),
+		.mode_clkcontrol	= LCD_CLKCONTROL_PCD_N(1) |
+					  LCD_CLKCONTROL_IV |
+					  LCD_CLKCONTROL_IH,
+		.mode_pwmdiv		= 0x00000000,
+		.mode_pwmhi		= 0x00000000,
+		.mode_outmask		= 0x00FFFFFF,
+		.mode_fifoctrl		= 0x2f2f2f2f,
+		.mode_toyclksrc		= 0x00000004, /* AUXPLL directly */
+		.mode_backlight		= 0x00000000,
+		.mode_auxpll		= (48/12) * 2,
+		.device_init		= board_au1200fb_panel_init,
+		.device_shutdown	= board_au1200fb_panel_shutdown,
+		800, 800,
+		480, 480,
+	},
 };
 
 #define NUM_PANELS (ARRAY_SIZE(known_lcd_panels))
diff --git a/sound/soc/au1x/Kconfig b/sound/soc/au1x/Kconfig
index 93323cc..5981ecc 100644
--- a/sound/soc/au1x/Kconfig
+++ b/sound/soc/au1x/Kconfig
@@ -51,12 +51,14 @@ config SND_SOC_DB1000
 	  of boards (DB1000/DB1500/DB1100).
 
 config SND_SOC_DB1200
-	tristate "DB1200 AC97+I2S audio support"
-	depends on SND_SOC_AU1XPSC
+	tristate "DB1200/DB1300 Audio support"
+	select SND_SOC_AU1XPSC
 	select SND_SOC_AU1XPSC_AC97
 	select SND_SOC_AC97_CODEC
+	select SND_SOC_WM9712
 	select SND_SOC_AU1XPSC_I2S
 	select SND_SOC_WM8731
 	help
-	  Select this option to enable audio (AC97 or I2S) on the
-	  Alchemy/AMD/RMI DB1200 demoboard.
+	  Select this option to enable audio (AC97 and I2S) on the
+	  Alchemy/AMD/RMI/NetLogic Db1200 and Db1300 evaluation boards.
+	  If you need Db1300 touchscreen support, you definitely want to say Y.
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index 289312c..ca2335a 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -1,5 +1,5 @@
 /*
- * DB1200 ASoC audio fabric support code.
+ * DB1200/DB1300 ASoC audio fabric support code.
  *
  * (c) 2008-2011 Manuel Lauss <manuel.lauss@googlemail.com>
  *
@@ -28,6 +28,12 @@ static struct platform_device_id db1200_pids[] = {
 	}, {
 		.name		= "db1200-i2s",
 		.driver_data	= 1,
+	}, {
+		.name		= "db1300-ac97",
+		.driver_data	= 2,
+	}, {
+		.name		= "db1300-i2s",
+		.driver_data	= 3,
 	},
 	{},
 };
@@ -49,6 +55,21 @@ static struct snd_soc_card db1200_ac97_machine = {
 	.num_links	= 1,
 };
 
+static struct snd_soc_dai_link db1300_ac97_dai = {
+	.name		= "AC97",
+	.stream_name	= "AC97 HiFi",
+	.codec_dai_name	= "wm9712-hifi",
+	.cpu_dai_name	= "au1xpsc_ac97.1",
+	.platform_name	= "au1xpsc-pcm.1",
+	.codec_name	= "wm9712-codec.1",
+};
+
+static struct snd_soc_card db1300_ac97_machine = {
+	.name		= "DB1300_AC97",
+	.dai_link	= &db1300_ac97_dai,
+	.num_links	= 1,
+};
+
 /*-------------------------  I2S PART  ---------------------------*/
 
 static int db1200_i2s_startup(struct snd_pcm_substream *substream)
@@ -98,11 +119,29 @@ static struct snd_soc_card db1200_i2s_machine = {
 	.num_links	= 1,
 };
 
+static struct snd_soc_dai_link db1300_i2s_dai = {
+	.name		= "WM8731",
+	.stream_name	= "WM8731 PCM",
+	.codec_dai_name	= "wm8731-hifi",
+	.cpu_dai_name	= "au1xpsc_i2s.2",
+	.platform_name	= "au1xpsc-pcm.2",
+	.codec_name	= "wm8731.0-001b",
+	.ops		= &db1200_i2s_wm8731_ops,
+};
+
+static struct snd_soc_card db1300_i2s_machine = {
+	.name		= "DB1300_I2S",
+	.dai_link	= &db1300_i2s_dai,
+	.num_links	= 1,
+};
+
 /*-------------------------  COMMON PART  ---------------------------*/
 
 static struct snd_soc_card *db1200_cards[] __devinitdata = {
 	&db1200_ac97_machine,
 	&db1200_i2s_machine,
+	&db1300_ac97_machine,
+	&db1300_i2s_machine,
 };
 
 static int __devinit db1200_audio_probe(struct platform_device *pdev)
@@ -147,5 +186,5 @@ module_init(db1200_audio_load);
 module_exit(db1200_audio_unload);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("DB1200 ASoC audio support");
+MODULE_DESCRIPTION("DB1200/DB1300 ASoC audio support");
 MODULE_AUTHOR("Manuel Lauss");
-- 
1.7.7.1
