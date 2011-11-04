Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2011 09:35:51 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:54730 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1904080Ab1KDIfX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2011 09:35:23 +0100
Received: by faaq17 with SMTP id q17so3131510faa.36
        for <multiple recipients>; Fri, 04 Nov 2011 01:35:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=He5LRhHtuhNEIkGBHtCUB615XG4eoMGHY8PjITElHTU=;
        b=fm/Lv00d1eIgt+d9F+7MNKiKTBtrX0Sl7apaTKvY5GA7BEiwVPFN+alstEflXmx8kS
         IgKJlIegtis27FYsHPQ2cwS2UGr5WKoHCMWImorlikUydx0etR5aEhQXdDn4Drj3mrAO
         1W3KxpXgy4K78iV+B3iFlAILXUcgQQKHVLC1o=
Received: by 10.152.110.99 with SMTP id hz3mr663823lab.29.1320395717696;
        Fri, 04 Nov 2011 01:35:17 -0700 (PDT)
Received: from localhost.localdomain (188-22-154-168.adsl.highway.telekom.at. [188.22.154.168])
        by mx.google.com with ESMTPS id hm12sm1836934lab.9.2011.11.04.01.35.11
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 04 Nov 2011 01:35:15 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH v2 08/18] MIPS: Alchemy: merge devboard code into single per-board files.
Date:   Fri,  4 Nov 2011 09:35:07 +0100
Message-Id: <1320395707-26984-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1320174224-27305-9-git-send-email-manuel.lauss@googlemail.com>
References: <1320174224-27305-9-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31373
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3380

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
v2: rediffed against Linus' latest git.

 arch/mips/alchemy/devboards/Makefile             |   16 +-
 arch/mips/alchemy/devboards/db1200.c             |  705 ++++++++++++++++++++++
 arch/mips/alchemy/devboards/db1200/Makefile      |    1 -
 arch/mips/alchemy/devboards/db1200/platform.c    |  648 --------------------
 arch/mips/alchemy/devboards/db1200/setup.c       |   81 ---
 arch/mips/alchemy/devboards/db1x00.c             |  256 ++++++++
 arch/mips/alchemy/devboards/db1x00/Makefile      |    8 -
 arch/mips/alchemy/devboards/db1x00/board_setup.c |  108 ----
 arch/mips/alchemy/devboards/db1x00/platform.c    |  207 -------
 arch/mips/alchemy/devboards/pb1100.c             |  167 +++++
 arch/mips/alchemy/devboards/pb1100/Makefile      |    8 -
 arch/mips/alchemy/devboards/pb1100/board_setup.c |  127 ----
 arch/mips/alchemy/devboards/pb1100/platform.c    |   77 ---
 arch/mips/alchemy/devboards/pb1200.c             |  464 ++++++++++++++
 arch/mips/alchemy/devboards/pb1200/Makefile      |    5 -
 arch/mips/alchemy/devboards/pb1200/board_setup.c |  174 ------
 arch/mips/alchemy/devboards/pb1200/platform.c    |  339 -----------
 arch/mips/alchemy/devboards/pb1500.c             |  198 ++++++
 arch/mips/alchemy/devboards/pb1500/Makefile      |    8 -
 arch/mips/alchemy/devboards/pb1500/board_setup.c |  139 -----
 arch/mips/alchemy/devboards/pb1500/platform.c    |   94 ---
 arch/mips/alchemy/devboards/pb1550.c             |  178 ++++++
 arch/mips/alchemy/devboards/pb1550/Makefile      |    8 -
 arch/mips/alchemy/devboards/pb1550/board_setup.c |   80 ---
 arch/mips/alchemy/devboards/pb1550/platform.c    |  140 -----
 25 files changed, 1976 insertions(+), 2260 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/db1200.c
 delete mode 100644 arch/mips/alchemy/devboards/db1200/Makefile
 delete mode 100644 arch/mips/alchemy/devboards/db1200/platform.c
 delete mode 100644 arch/mips/alchemy/devboards/db1200/setup.c
 create mode 100644 arch/mips/alchemy/devboards/db1x00.c
 delete mode 100644 arch/mips/alchemy/devboards/db1x00/Makefile
 delete mode 100644 arch/mips/alchemy/devboards/db1x00/board_setup.c
 delete mode 100644 arch/mips/alchemy/devboards/db1x00/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1100.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1100/Makefile
 delete mode 100644 arch/mips/alchemy/devboards/pb1100/board_setup.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1100/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1200.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1200/Makefile
 delete mode 100644 arch/mips/alchemy/devboards/pb1200/board_setup.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1200/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1500.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1500/Makefile
 delete mode 100644 arch/mips/alchemy/devboards/pb1500/board_setup.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1500/platform.c
 create mode 100644 arch/mips/alchemy/devboards/pb1550.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1550/Makefile
 delete mode 100644 arch/mips/alchemy/devboards/pb1550/board_setup.c
 delete mode 100644 arch/mips/alchemy/devboards/pb1550/platform.c

diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index 3467ec9..f562852 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -4,13 +4,13 @@
 
 obj-y += prom.o bcsr.o platform.o
 obj-$(CONFIG_PM)		+= pm.o
-obj-$(CONFIG_MIPS_PB1100)	+= pb1100/
-obj-$(CONFIG_MIPS_PB1200)	+= pb1200/
-obj-$(CONFIG_MIPS_PB1500)	+= pb1500/
-obj-$(CONFIG_MIPS_PB1550)	+= pb1550/
-obj-$(CONFIG_MIPS_DB1000)	+= db1x00/
-obj-$(CONFIG_MIPS_DB1100)	+= db1x00/
-obj-$(CONFIG_MIPS_DB1200)	+= db1200/
+obj-$(CONFIG_MIPS_PB1100)	+= pb1100.o
+obj-$(CONFIG_MIPS_PB1200)	+= pb1200.o
+obj-$(CONFIG_MIPS_PB1500)	+= pb1500.o
+obj-$(CONFIG_MIPS_PB1550)	+= pb1550.o
+obj-$(CONFIG_MIPS_DB1000)	+= db1x00.o
+obj-$(CONFIG_MIPS_DB1100)	+= db1x00.o
+obj-$(CONFIG_MIPS_DB1200)	+= db1200.o
 obj-$(CONFIG_MIPS_DB1300)	+= db1300.o
-obj-$(CONFIG_MIPS_DB1500)	+= db1x00/
+obj-$(CONFIG_MIPS_DB1500)	+= db1x00.o
 obj-$(CONFIG_MIPS_DB1550)	+= db1550.o
diff --git a/arch/mips/alchemy/devboards/db1200.c b/arch/mips/alchemy/devboards/db1200.c
new file mode 100644
index 0000000..43f5f1b
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1200.c
@@ -0,0 +1,705 @@
+/*
+ * DBAu1200 board platform device registration
+ *
+ * Copyright (C) 2008-2011 Manuel Lauss
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/leds.h>
+#include <linux/mmc/host.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/platform_device.h>
+#include <linux/serial_8250.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
+#include <linux/smc91x.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1100_mmc.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/mach-au1x00/au1550_spi.h>
+#include <asm/mach-db1x00/bcsr.h>
+#include <asm/mach-db1x00/db1200.h>
+
+#include "platform.h"
+
+
+const char *get_system_type(void)
+{
+	return "DB1200";
+}
+
+void __init board_setup(void)
+{
+	unsigned long freq0, clksrc, div, pfc;
+	unsigned short whoami;
+
+	bcsr_init(DB1200_BCSR_PHYS_ADDR,
+		  DB1200_BCSR_PHYS_ADDR + DB1200_BCSR_HEXLED_OFS);
+
+	whoami = bcsr_read(BCSR_WHOAMI);
+	printk(KERN_INFO "Alchemy/AMD/RMI DB1200 Board, CPLD Rev %d"
+		"  Board-ID %d  Daughtercard ID %d\n",
+		(whoami >> 4) & 0xf, (whoami >> 8) & 0xf, whoami & 0xf);
+
+	/* SMBus/SPI on PSC0, Audio on PSC1 */
+	pfc = __raw_readl((void __iomem *)SYS_PINFUNC);
+	pfc &= ~(SYS_PINFUNC_P0A | SYS_PINFUNC_P0B);
+	pfc &= ~(SYS_PINFUNC_P1A | SYS_PINFUNC_P1B | SYS_PINFUNC_FS3);
+	pfc |= SYS_PINFUNC_P1C;	/* SPI is configured later */
+	__raw_writel(pfc, (void __iomem *)SYS_PINFUNC);
+	wmb();
+
+	/* Clock configurations: PSC0: ~50MHz via Clkgen0, derived from
+	 * CPU clock; all other clock generators off/unused.
+	 */
+	div = (get_au1x00_speed() + 25000000) / 50000000;
+	if (div & 1)
+		div++;
+	div = ((div >> 1) - 1) & 0xff;
+
+	freq0 = div << SYS_FC_FRDIV0_BIT;
+	__raw_writel(freq0, (void __iomem *)SYS_FREQCTRL0);
+	wmb();
+	freq0 |= SYS_FC_FE0;	/* enable F0 */
+	__raw_writel(freq0, (void __iomem *)SYS_FREQCTRL0);
+	wmb();
+
+	/* psc0_intclk comes 1:1 from F0 */
+	clksrc = SYS_CS_MUX_FQ0 << SYS_CS_ME0_BIT;
+	__raw_writel(clksrc, (void __iomem *)SYS_CLKSRC);
+	wmb();
+}
+
+/******************************************************************************/
+
+static struct mtd_partition db1200_spiflash_parts[] = {
+	{
+		.name	= "DB1200 SPI flash",
+		.offset	= 0,
+		.size	= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct flash_platform_data db1200_spiflash_data = {
+	.name		= "s25fl001",
+	.parts		= db1200_spiflash_parts,
+	.nr_parts	= ARRAY_SIZE(db1200_spiflash_parts),
+	.type		= "m25p10",
+};
+
+static struct spi_board_info db1200_spi_devs[] __initdata = {
+	{
+		/* TI TMP121AIDBVR temp sensor */
+		.modalias	= "tmp121",
+		.max_speed_hz	= 2000000,
+		.bus_num	= 0,
+		.chip_select	= 0,
+		.mode		= 0,
+	},
+	{
+		/* Spansion S25FL001D0FMA SPI flash */
+		.modalias	= "m25p80",
+		.max_speed_hz	= 50000000,
+		.bus_num	= 0,
+		.chip_select	= 1,
+		.mode		= 0,
+		.platform_data	= &db1200_spiflash_data,
+	},
+};
+
+static struct i2c_board_info db1200_i2c_devs[] __initdata = {
+	{ I2C_BOARD_INFO("24c04", 0x52),  }, /* AT24C04-10 I2C eeprom */
+	{ I2C_BOARD_INFO("ne1619", 0x2d), }, /* adm1025-compat hwmon */
+	{ I2C_BOARD_INFO("wm8731", 0x1b), }, /* I2S audio codec WM8731 */
+};
+
+/**********************************************************************/
+
+static void au1200_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
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
+static int au1200_nand_device_ready(struct mtd_info *mtd)
+{
+	return __raw_readl((void __iomem *)MEM_STSTAT) & 1;
+}
+
+static const char *db1200_part_probes[] = { "cmdlinepart", NULL };
+
+static struct mtd_partition db1200_nand_parts[] = {
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
+struct platform_nand_data db1200_nand_platdata = {
+	.chip = {
+		.nr_chips	= 1,
+		.chip_offset	= 0,
+		.nr_partitions	= ARRAY_SIZE(db1200_nand_parts),
+		.partitions	= db1200_nand_parts,
+		.chip_delay	= 20,
+		.part_probe_types = db1200_part_probes,
+	},
+	.ctrl = {
+		.dev_ready	= au1200_nand_device_ready,
+		.cmd_ctrl	= au1200_nand_cmd_ctrl,
+	},
+};
+
+static struct resource db1200_nand_res[] = {
+	[0] = {
+		.start	= DB1200_NAND_PHYS_ADDR,
+		.end	= DB1200_NAND_PHYS_ADDR + 0xff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device db1200_nand_dev = {
+	.name		= "gen_nand",
+	.num_resources	= ARRAY_SIZE(db1200_nand_res),
+	.resource	= db1200_nand_res,
+	.id		= -1,
+	.dev		= {
+		.platform_data = &db1200_nand_platdata,
+	}
+};
+
+/**********************************************************************/
+
+static struct smc91x_platdata db1200_eth_data = {
+	.flags	= SMC91X_NOWAIT | SMC91X_USE_16BIT,
+	.leda	= RPC_LED_100_10,
+	.ledb	= RPC_LED_TX_RX,
+};
+
+static struct resource db1200_eth_res[] = {
+	[0] = {
+		.start	= DB1200_ETH_PHYS_ADDR,
+		.end	= DB1200_ETH_PHYS_ADDR + 0xf,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= DB1200_ETH_INT,
+		.end	= DB1200_ETH_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+};
+
+static struct platform_device db1200_eth_dev = {
+	.dev	= {
+		.platform_data	= &db1200_eth_data,
+	},
+	.name		= "smc91x",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(db1200_eth_res),
+	.resource	= db1200_eth_res,
+};
+
+/**********************************************************************/
+
+static struct resource db1200_ide_res[] = {
+	[0] = {
+		.start	= DB1200_IDE_PHYS_ADDR,
+		.end	= DB1200_IDE_PHYS_ADDR + DB1200_IDE_PHYS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= DB1200_IDE_INT,
+		.end	= DB1200_IDE_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1200_DSCR_CMD0_DMA_REQ1,
+		.end	= AU1200_DSCR_CMD0_DMA_REQ1,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static u64 au1200_ide_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device db1200_ide_dev = {
+	.name		= "au1200-ide",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1200_ide_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(db1200_ide_res),
+	.resource	= db1200_ide_res,
+};
+
+/**********************************************************************/
+
+static struct platform_device db1200_rtc_dev = {
+	.name	= "rtc-au1xxx",
+	.id	= -1,
+};
+
+/**********************************************************************/
+
+/* SD carddetects:  they're supposed to be edge-triggered, but ack
+ * doesn't seem to work (CPLD Rev 2).  Instead, the screaming one
+ * is disabled and its counterpart enabled.  The 500ms timeout is
+ * because the carddetect isn't debounced in hardware.
+ */
+static irqreturn_t db1200_mmc_cd(int irq, void *ptr)
+{
+	void(*mmc_cd)(struct mmc_host *, unsigned long);
+
+	if (irq == DB1200_SD0_INSERT_INT) {
+		disable_irq_nosync(DB1200_SD0_INSERT_INT);
+		enable_irq(DB1200_SD0_EJECT_INT);
+	} else {
+		disable_irq_nosync(DB1200_SD0_EJECT_INT);
+		enable_irq(DB1200_SD0_INSERT_INT);
+	}
+
+	/* link against CONFIG_MMC=m */
+	mmc_cd = symbol_get(mmc_detect_change);
+	if (mmc_cd) {
+		mmc_cd(ptr, msecs_to_jiffies(500));
+		symbol_put(mmc_detect_change);
+	}
+
+	return IRQ_HANDLED;
+}
+
+static int db1200_mmc_cd_setup(void *mmc_host, int en)
+{
+	int ret;
+
+	if (en) {
+		ret = request_irq(DB1200_SD0_INSERT_INT, db1200_mmc_cd,
+				  IRQF_DISABLED, "sd_insert", mmc_host);
+		if (ret)
+			goto out;
+
+		ret = request_irq(DB1200_SD0_EJECT_INT, db1200_mmc_cd,
+				  IRQF_DISABLED, "sd_eject", mmc_host);
+		if (ret) {
+			free_irq(DB1200_SD0_INSERT_INT, mmc_host);
+			goto out;
+		}
+
+		if (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD0INSERT)
+			enable_irq(DB1200_SD0_EJECT_INT);
+		else
+			enable_irq(DB1200_SD0_INSERT_INT);
+
+	} else {
+		free_irq(DB1200_SD0_INSERT_INT, mmc_host);
+		free_irq(DB1200_SD0_EJECT_INT, mmc_host);
+	}
+	ret = 0;
+out:
+	return ret;
+}
+
+static void db1200_mmc_set_power(void *mmc_host, int state)
+{
+	if (state) {
+		bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_SD0PWR);
+		msleep(400);	/* stabilization time */
+	} else
+		bcsr_mod(BCSR_BOARD, BCSR_BOARD_SD0PWR, 0);
+}
+
+static int db1200_mmc_card_readonly(void *mmc_host)
+{
+	return (bcsr_read(BCSR_STATUS) & BCSR_STATUS_SD0WP) ? 1 : 0;
+}
+
+static int db1200_mmc_card_inserted(void *mmc_host)
+{
+	return (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD0INSERT) ? 1 : 0;
+}
+
+static void db1200_mmcled_set(struct led_classdev *led,
+			      enum led_brightness brightness)
+{
+	if (brightness != LED_OFF)
+		bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED0, 0);
+	else
+		bcsr_mod(BCSR_LEDS, 0, BCSR_LEDS_LED0);
+}
+
+static struct led_classdev db1200_mmc_led = {
+	.brightness_set	= db1200_mmcled_set,
+};
+
+static struct au1xmmc_platform_data db1200mmc_platdata = {
+	.cd_setup	= db1200_mmc_cd_setup,
+	.set_power	= db1200_mmc_set_power,
+	.card_inserted	= db1200_mmc_card_inserted,
+	.card_readonly	= db1200_mmc_card_readonly,
+	.led		= &db1200_mmc_led,
+};
+
+static struct resource au1200_mmc0_resources[] = {
+	[0] = {
+		.start	= AU1100_SD0_PHYS_ADDR,
+		.end	= AU1100_SD0_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_SD_INT,
+		.end	= AU1200_SD_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1200_DSCR_CMD0_SDMS_TX0,
+		.end	= AU1200_DSCR_CMD0_SDMS_TX0,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1200_DSCR_CMD0_SDMS_RX0,
+		.end	= AU1200_DSCR_CMD0_SDMS_RX0,
+		.flags	= IORESOURCE_DMA,
+	}
+};
+
+static u64 au1xxx_mmc_dmamask =  DMA_BIT_MASK(32);
+
+static struct platform_device db1200_mmc0_dev = {
+	.name		= "au1xxx-mmc",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1xxx_mmc_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &db1200mmc_platdata,
+	},
+	.num_resources	= ARRAY_SIZE(au1200_mmc0_resources),
+	.resource	= au1200_mmc0_resources,
+};
+
+/**********************************************************************/
+
+static struct resource au1200_lcd_res[] = {
+	[0] = {
+		.start	= AU1200_LCD_PHYS_ADDR,
+		.end	= AU1200_LCD_PHYS_ADDR + 0x800 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_LCD_INT,
+		.end	= AU1200_LCD_INT,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static u64 au1200_lcd_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device au1200_lcd_dev = {
+	.name		= "au1200-lcd",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1200_lcd_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(au1200_lcd_res),
+	.resource	= au1200_lcd_res,
+};
+
+/**********************************************************************/
+
+static struct resource au1200_psc0_res[] = {
+	[0] = {
+		.start	= AU1550_PSC0_PHYS_ADDR,
+		.end	= AU1550_PSC0_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_PSC0_INT,
+		.end	= AU1200_PSC0_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1200_DSCR_CMD0_PSC0_TX,
+		.end	= AU1200_DSCR_CMD0_PSC0_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1200_DSCR_CMD0_PSC0_RX,
+		.end	= AU1200_DSCR_CMD0_PSC0_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device db1200_i2c_dev = {
+	.name		= "au1xpsc_smbus",
+	.id		= 0,	/* bus number */
+	.num_resources	= ARRAY_SIZE(au1200_psc0_res),
+	.resource	= au1200_psc0_res,
+};
+
+static void db1200_spi_cs_en(struct au1550_spi_info *spi, int cs, int pol)
+{
+	if (cs)
+		bcsr_mod(BCSR_RESETS, 0, BCSR_RESETS_SPISEL);
+	else
+		bcsr_mod(BCSR_RESETS, BCSR_RESETS_SPISEL, 0);
+}
+
+static struct au1550_spi_info db1200_spi_platdata = {
+	.mainclk_hz	= 50000000,	/* PSC0 clock */
+	.num_chipselect = 2,
+	.activate_cs	= db1200_spi_cs_en,
+};
+
+static u64 spi_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device db1200_spi_dev = {
+	.dev	= {
+		.dma_mask		= &spi_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &db1200_spi_platdata,
+	},
+	.name		= "au1550-spi",
+	.id		= 0,	/* bus number */
+	.num_resources	= ARRAY_SIZE(au1200_psc0_res),
+	.resource	= au1200_psc0_res,
+};
+
+static struct resource au1200_psc1_res[] = {
+	[0] = {
+		.start	= AU1550_PSC1_PHYS_ADDR,
+		.end	= AU1550_PSC1_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_PSC1_INT,
+		.end	= AU1200_PSC1_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1200_DSCR_CMD0_PSC1_TX,
+		.end	= AU1200_DSCR_CMD0_PSC1_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1200_DSCR_CMD0_PSC1_RX,
+		.end	= AU1200_DSCR_CMD0_PSC1_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+/* AC97 or I2S device */
+static struct platform_device db1200_audio_dev = {
+	/* name assigned later based on switch setting */
+	.id		= 1,	/* PSC ID */
+	.num_resources	= ARRAY_SIZE(au1200_psc1_res),
+	.resource	= au1200_psc1_res,
+};
+
+/* DB1200 ASoC card device */
+static struct platform_device db1200_sound_dev = {
+	/* name assigned later based on switch setting */
+	.id		= 1,	/* PSC ID */
+};
+
+static struct platform_device db1200_stac_dev = {
+	.name		= "ac97-codec",
+	.id		= 1,	/* on PSC1 */
+};
+
+static struct platform_device db1200_audiodma_dev = {
+	.name		= "au1xpsc-pcm",
+	.id		= 1,	/* PSC ID */
+};
+
+static struct platform_device *db1200_devs[] __initdata = {
+	NULL,		/* PSC0, selected by S6.8 */
+	&db1200_ide_dev,
+	&db1200_mmc0_dev,
+	&au1200_lcd_dev,
+	&db1200_eth_dev,
+	&db1200_rtc_dev,
+	&db1200_nand_dev,
+	&db1200_audiodma_dev,
+	&db1200_audio_dev,
+	&db1200_stac_dev,
+	&db1200_sound_dev,
+};
+
+static int __init db1200_dev_init(void)
+{
+	unsigned long pfc;
+	unsigned short sw;
+	int swapped;
+
+	/* GPIO7 is low-level triggered CPLD cascade */
+	irq_set_irq_type(AU1200_GPIO7_INT, IRQF_TRIGGER_LOW);
+	bcsr_init_irq(DB1200_INT_BEGIN, DB1200_INT_END, AU1200_GPIO7_INT);
+
+	/* insert/eject pairs: one of both is always screaming.  To avoid
+	 * issues they must not be automatically enabled when initially
+	 * requested.
+	 */
+	irq_set_status_flags(DB1200_SD0_INSERT_INT, IRQ_NOAUTOEN);
+	irq_set_status_flags(DB1200_SD0_EJECT_INT, IRQ_NOAUTOEN);
+	irq_set_status_flags(DB1200_PC0_INSERT_INT, IRQ_NOAUTOEN);
+	irq_set_status_flags(DB1200_PC0_EJECT_INT, IRQ_NOAUTOEN);
+	irq_set_status_flags(DB1200_PC1_INSERT_INT, IRQ_NOAUTOEN);
+	irq_set_status_flags(DB1200_PC1_EJECT_INT, IRQ_NOAUTOEN);
+
+	i2c_register_board_info(0, db1200_i2c_devs,
+				ARRAY_SIZE(db1200_i2c_devs));
+	spi_register_board_info(db1200_spi_devs,
+				ARRAY_SIZE(db1200_i2c_devs));
+
+	/* SWITCHES:	S6.8 I2C/SPI selector  (OFF=I2C  ON=SPI)
+	 *		S6.7 AC97/I2S selector (OFF=AC97 ON=I2S)
+	 */
+
+	/* NOTE: GPIO215 controls OTG VBUS supply.  In SPI mode however
+	 * this pin is claimed by PSC0 (unused though, but pinmux doesn't
+	 * allow to free it without crippling the SPI interface).
+	 * As a result, in SPI mode, OTG simply won't work (PSC0 uses
+	 * it as an input pin which is pulled high on the boards).
+	 */
+	pfc = __raw_readl((void __iomem *)SYS_PINFUNC) & ~SYS_PINFUNC_P0A;
+
+	/* switch off OTG VBUS supply */
+	gpio_request(215, "otg-vbus");
+	gpio_direction_output(215, 1);
+
+	printk(KERN_INFO "DB1200 device configuration:\n");
+
+	sw = bcsr_read(BCSR_SWITCHES);
+	if (sw & BCSR_SWITCHES_DIP_8) {
+		db1200_devs[0] = &db1200_i2c_dev;
+		bcsr_mod(BCSR_RESETS, BCSR_RESETS_PSC0MUX, 0);
+
+		pfc |= (2 << 17);	/* GPIO2 block owns GPIO215 */
+
+		printk(KERN_INFO " S6.8 OFF: PSC0 mode I2C\n");
+		printk(KERN_INFO "   OTG port VBUS supply available!\n");
+	} else {
+		db1200_devs[0] = &db1200_spi_dev;
+		bcsr_mod(BCSR_RESETS, 0, BCSR_RESETS_PSC0MUX);
+
+		pfc |= (1 << 17);	/* PSC0 owns GPIO215 */
+
+		printk(KERN_INFO " S6.8 ON : PSC0 mode SPI\n");
+		printk(KERN_INFO "   OTG port VBUS supply disabled\n");
+	}
+	__raw_writel(pfc, (void __iomem *)SYS_PINFUNC);
+	wmb();
+
+	/* Audio: DIP7 selects I2S(0)/AC97(1), but need I2C for I2S!
+	 * so: DIP7=1 || DIP8=0 => AC97, DIP7=0 && DIP8=1 => I2S
+	 */
+	sw &= BCSR_SWITCHES_DIP_8 | BCSR_SWITCHES_DIP_7;
+	if (sw == BCSR_SWITCHES_DIP_8) {
+		bcsr_mod(BCSR_RESETS, 0, BCSR_RESETS_PSC1MUX);
+		db1200_audio_dev.name = "au1xpsc_i2s";
+		db1200_sound_dev.name = "db1200-i2s";
+		printk(KERN_INFO " S6.7 ON : PSC1 mode I2S\n");
+	} else {
+		bcsr_mod(BCSR_RESETS, BCSR_RESETS_PSC1MUX, 0);
+		db1200_audio_dev.name = "au1xpsc_ac97";
+		db1200_sound_dev.name = "db1200-ac97";
+		printk(KERN_INFO " S6.7 OFF: PSC1 mode AC97\n");
+	}
+
+	/* Audio PSC clock is supplied externally. (FIXME: platdata!!) */
+	__raw_writel(PSC_SEL_CLK_SERCLK,
+	    (void __iomem *)KSEG1ADDR(AU1550_PSC1_PHYS_ADDR) + PSC_SEL_OFFSET);
+	wmb();
+
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
+		DB1200_PC0_INT, DB1200_PC0_INSERT_INT,
+		/*DB1200_PC0_STSCHG_INT*/0, DB1200_PC0_EJECT_INT, 0);
+
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004000000,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
+		DB1200_PC1_INT, DB1200_PC1_INSERT_INT,
+		/*DB1200_PC1_STSCHG_INT*/0, DB1200_PC1_EJECT_INT, 1);
+
+	swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1200_SWAPBOOT;
+	db1x_register_norflash(64 << 20, 2, swapped);
+
+	return platform_add_devices(db1200_devs, ARRAY_SIZE(db1200_devs));
+}
+device_initcall(db1200_dev_init);
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
diff --git a/arch/mips/alchemy/devboards/db1200/Makefile b/arch/mips/alchemy/devboards/db1200/Makefile
deleted file mode 100644
index 17840a5..0000000
--- a/arch/mips/alchemy/devboards/db1200/Makefile
+++ /dev/null
@@ -1 +0,0 @@
-obj-y += setup.o platform.o
diff --git a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
deleted file mode 100644
index c61867c..0000000
--- a/arch/mips/alchemy/devboards/db1200/platform.c
+++ /dev/null
@@ -1,648 +0,0 @@
-/*
- * DBAu1200 board platform device registration
- *
- * Copyright (C) 2008-2009 Manuel Lauss
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/dma-mapping.h>
-#include <linux/gpio.h>
-#include <linux/i2c.h>
-#include <linux/init.h>
-#include <linux/io.h>
-#include <linux/leds.h>
-#include <linux/mmc/host.h>
-#include <linux/mtd/mtd.h>
-#include <linux/mtd/nand.h>
-#include <linux/mtd/partitions.h>
-#include <linux/platform_device.h>
-#include <linux/serial_8250.h>
-#include <linux/spi/spi.h>
-#include <linux/spi/flash.h>
-#include <linux/smc91x.h>
-
-#include <asm/mach-au1x00/au1100_mmc.h>
-#include <asm/mach-au1x00/au1xxx_dbdma.h>
-#include <asm/mach-au1x00/au1550_spi.h>
-#include <asm/mach-db1x00/bcsr.h>
-#include <asm/mach-db1x00/db1200.h>
-
-#include "../platform.h"
-
-static struct mtd_partition db1200_spiflash_parts[] = {
-	{
-		.name	= "DB1200 SPI flash",
-		.offset	= 0,
-		.size	= MTDPART_SIZ_FULL,
-	},
-};
-
-static struct flash_platform_data db1200_spiflash_data = {
-	.name		= "s25fl001",
-	.parts		= db1200_spiflash_parts,
-	.nr_parts	= ARRAY_SIZE(db1200_spiflash_parts),
-	.type		= "m25p10",
-};
-
-static struct spi_board_info db1200_spi_devs[] __initdata = {
-	{
-		/* TI TMP121AIDBVR temp sensor */
-		.modalias	= "tmp121",
-		.max_speed_hz	= 2000000,
-		.bus_num	= 0,
-		.chip_select	= 0,
-		.mode		= 0,
-	},
-	{
-		/* Spansion S25FL001D0FMA SPI flash */
-		.modalias	= "m25p80",
-		.max_speed_hz	= 50000000,
-		.bus_num	= 0,
-		.chip_select	= 1,
-		.mode		= 0,
-		.platform_data	= &db1200_spiflash_data,
-	},
-};
-
-static struct i2c_board_info db1200_i2c_devs[] __initdata = {
-	{
-		/* AT24C04-10 I2C eeprom */
-		I2C_BOARD_INFO("24c04", 0x52),
-	},
-	{
-		/* Philips NE1619 temp/voltage sensor (adm1025 drv) */
-		I2C_BOARD_INFO("ne1619", 0x2d),
-	},
-	{
-		/* I2S audio codec WM8731 */
-		I2C_BOARD_INFO("wm8731", 0x1b),
-	},
-};
-
-/**********************************************************************/
-
-static void au1200_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
-				 unsigned int ctrl)
-{
-	struct nand_chip *this = mtd->priv;
-	unsigned long ioaddr = (unsigned long)this->IO_ADDR_W;
-
-	ioaddr &= 0xffffff00;
-
-	if (ctrl & NAND_CLE) {
-		ioaddr += MEM_STNAND_CMD;
-	} else if (ctrl & NAND_ALE) {
-		ioaddr += MEM_STNAND_ADDR;
-	} else {
-		/* assume we want to r/w real data  by default */
-		ioaddr += MEM_STNAND_DATA;
-	}
-	this->IO_ADDR_R = this->IO_ADDR_W = (void __iomem *)ioaddr;
-	if (cmd != NAND_CMD_NONE) {
-		__raw_writeb(cmd, this->IO_ADDR_W);
-		wmb();
-	}
-}
-
-static int au1200_nand_device_ready(struct mtd_info *mtd)
-{
-	return __raw_readl((void __iomem *)MEM_STSTAT) & 1;
-}
-
-static const char *db1200_part_probes[] = { "cmdlinepart", NULL };
-
-static struct mtd_partition db1200_nand_parts[] = {
-	{
-		.name	= "NAND FS 0",
-		.offset	= 0,
-		.size	= 8 * 1024 * 1024,
-	},
-	{
-		.name	= "NAND FS 1",
-		.offset	= MTDPART_OFS_APPEND,
-		.size	= MTDPART_SIZ_FULL
-	},
-};
-
-struct platform_nand_data db1200_nand_platdata = {
-	.chip = {
-		.nr_chips	= 1,
-		.chip_offset	= 0,
-		.nr_partitions	= ARRAY_SIZE(db1200_nand_parts),
-		.partitions	= db1200_nand_parts,
-		.chip_delay	= 20,
-		.part_probe_types = db1200_part_probes,
-	},
-	.ctrl = {
-		.dev_ready	= au1200_nand_device_ready,
-		.cmd_ctrl	= au1200_nand_cmd_ctrl,
-	},
-};
-
-static struct resource db1200_nand_res[] = {
-	[0] = {
-		.start	= DB1200_NAND_PHYS_ADDR,
-		.end	= DB1200_NAND_PHYS_ADDR + 0xff,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct platform_device db1200_nand_dev = {
-	.name		= "gen_nand",
-	.num_resources	= ARRAY_SIZE(db1200_nand_res),
-	.resource	= db1200_nand_res,
-	.id		= -1,
-	.dev		= {
-		.platform_data = &db1200_nand_platdata,
-	}
-};
-
-/**********************************************************************/
-
-static struct smc91x_platdata db1200_eth_data = {
-	.flags	= SMC91X_NOWAIT | SMC91X_USE_16BIT,
-	.leda	= RPC_LED_100_10,
-	.ledb	= RPC_LED_TX_RX,
-};
-
-static struct resource db1200_eth_res[] = {
-	[0] = {
-		.start	= DB1200_ETH_PHYS_ADDR,
-		.end	= DB1200_ETH_PHYS_ADDR + 0xf,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DB1200_ETH_INT,
-		.end	= DB1200_ETH_INT,
-		.flags	= IORESOURCE_IRQ,
-	},
-};
-
-static struct platform_device db1200_eth_dev = {
-	.dev	= {
-		.platform_data	= &db1200_eth_data,
-	},
-	.name		= "smc91x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(db1200_eth_res),
-	.resource	= db1200_eth_res,
-};
-
-/**********************************************************************/
-
-static struct resource db1200_ide_res[] = {
-	[0] = {
-		.start	= DB1200_IDE_PHYS_ADDR,
-		.end 	= DB1200_IDE_PHYS_ADDR + DB1200_IDE_PHYS_LEN - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DB1200_IDE_INT,
-		.end	= DB1200_IDE_INT,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AU1200_DSCR_CMD0_DMA_REQ1,
-		.end	= AU1200_DSCR_CMD0_DMA_REQ1,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-static u64 ide_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device db1200_ide_dev = {
-	.name		= "au1200-ide",
-	.id		= 0,
-	.dev = {
-		.dma_mask 		= &ide_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(db1200_ide_res),
-	.resource	= db1200_ide_res,
-};
-
-/**********************************************************************/
-
-static struct platform_device db1200_rtc_dev = {
-	.name	= "rtc-au1xxx",
-	.id	= -1,
-};
-
-/**********************************************************************/
-
-/* SD carddetects:  they're supposed to be edge-triggered, but ack
- * doesn't seem to work (CPLD Rev 2).  Instead, the screaming one
- * is disabled and its counterpart enabled.  The 500ms timeout is
- * because the carddetect isn't debounced in hardware.
- */
-static irqreturn_t db1200_mmc_cd(int irq, void *ptr)
-{
-	void(*mmc_cd)(struct mmc_host *, unsigned long);
-
-	if (irq == DB1200_SD0_INSERT_INT) {
-		disable_irq_nosync(DB1200_SD0_INSERT_INT);
-		enable_irq(DB1200_SD0_EJECT_INT);
-	} else {
-		disable_irq_nosync(DB1200_SD0_EJECT_INT);
-		enable_irq(DB1200_SD0_INSERT_INT);
-	}
-
-	/* link against CONFIG_MMC=m */
-	mmc_cd = symbol_get(mmc_detect_change);
-	if (mmc_cd) {
-		mmc_cd(ptr, msecs_to_jiffies(500));
-		symbol_put(mmc_detect_change);
-	}
-
-	return IRQ_HANDLED;
-}
-
-static int db1200_mmc_cd_setup(void *mmc_host, int en)
-{
-	int ret;
-
-	if (en) {
-		ret = request_irq(DB1200_SD0_INSERT_INT, db1200_mmc_cd,
-				  IRQF_DISABLED, "sd_insert", mmc_host);
-		if (ret)
-			goto out;
-
-		ret = request_irq(DB1200_SD0_EJECT_INT, db1200_mmc_cd,
-				  IRQF_DISABLED, "sd_eject", mmc_host);
-		if (ret) {
-			free_irq(DB1200_SD0_INSERT_INT, mmc_host);
-			goto out;
-		}
-
-		if (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD0INSERT)
-			enable_irq(DB1200_SD0_EJECT_INT);
-		else
-			enable_irq(DB1200_SD0_INSERT_INT);
-
-	} else {
-		free_irq(DB1200_SD0_INSERT_INT, mmc_host);
-		free_irq(DB1200_SD0_EJECT_INT, mmc_host);
-	}
-	ret = 0;
-out:
-	return ret;
-}
-
-static void db1200_mmc_set_power(void *mmc_host, int state)
-{
-	if (state) {
-		bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_SD0PWR);
-		msleep(400);	/* stabilization time */
-	} else
-		bcsr_mod(BCSR_BOARD, BCSR_BOARD_SD0PWR, 0);
-}
-
-static int db1200_mmc_card_readonly(void *mmc_host)
-{
-	return (bcsr_read(BCSR_STATUS) & BCSR_STATUS_SD0WP) ? 1 : 0;
-}
-
-static int db1200_mmc_card_inserted(void *mmc_host)
-{
-	return (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD0INSERT) ? 1 : 0;
-}
-
-static void db1200_mmcled_set(struct led_classdev *led,
-			      enum led_brightness brightness)
-{
-	if (brightness != LED_OFF)
-		bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED0, 0);
-	else
-		bcsr_mod(BCSR_LEDS, 0, BCSR_LEDS_LED0);
-}
-
-static struct led_classdev db1200_mmc_led = {
-	.brightness_set	= db1200_mmcled_set,
-};
-
-static struct au1xmmc_platform_data db1200mmc_platdata = {
-	.cd_setup	= db1200_mmc_cd_setup,
-	.set_power	= db1200_mmc_set_power,
-	.card_inserted	= db1200_mmc_card_inserted,
-	.card_readonly	= db1200_mmc_card_readonly,
-	.led		= &db1200_mmc_led,
-};
-
-static struct resource au1200_mmc0_resources[] = {
-	[0] = {
-		.start	= AU1100_SD0_PHYS_ADDR,
-		.end	= AU1100_SD0_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1200_SD_INT,
-		.end	= AU1200_SD_INT,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AU1200_DSCR_CMD0_SDMS_TX0,
-		.end	= AU1200_DSCR_CMD0_SDMS_TX0,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= AU1200_DSCR_CMD0_SDMS_RX0,
-		.end	= AU1200_DSCR_CMD0_SDMS_RX0,
-		.flags	= IORESOURCE_DMA,
-	}
-};
-
-static u64 au1xxx_mmc_dmamask =  DMA_BIT_MASK(32);
-
-static struct platform_device db1200_mmc0_dev = {
-	.name		= "au1xxx-mmc",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &au1xxx_mmc_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &db1200mmc_platdata,
-	},
-	.num_resources	= ARRAY_SIZE(au1200_mmc0_resources),
-	.resource	= au1200_mmc0_resources,
-};
-
-/**********************************************************************/
-
-static struct resource au1200_lcd_res[] = {
-	[0] = {
-		.start	= AU1200_LCD_PHYS_ADDR,
-		.end	= AU1200_LCD_PHYS_ADDR + 0x800 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1200_LCD_INT,
-		.end	= AU1200_LCD_INT,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static u64 au1200_lcd_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device au1200_lcd_dev = {
-	.name		= "au1200-lcd",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &au1200_lcd_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(au1200_lcd_res),
-	.resource	= au1200_lcd_res,
-};
-
-/**********************************************************************/
-
-static struct resource au1200_psc0_res[] = {
-	[0] = {
-		.start	= AU1550_PSC0_PHYS_ADDR,
-		.end	= AU1550_PSC0_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1200_PSC0_INT,
-		.end	= AU1200_PSC0_INT,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AU1200_DSCR_CMD0_PSC0_TX,
-		.end	= AU1200_DSCR_CMD0_PSC0_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= AU1200_DSCR_CMD0_PSC0_RX,
-		.end	= AU1200_DSCR_CMD0_PSC0_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-static struct platform_device db1200_i2c_dev = {
-	.name		= "au1xpsc_smbus",
-	.id		= 0,	/* bus number */
-	.num_resources	= ARRAY_SIZE(au1200_psc0_res),
-	.resource	= au1200_psc0_res,
-};
-
-static void db1200_spi_cs_en(struct au1550_spi_info *spi, int cs, int pol)
-{
-	if (cs)
-		bcsr_mod(BCSR_RESETS, 0, BCSR_RESETS_SPISEL);
-	else
-		bcsr_mod(BCSR_RESETS, BCSR_RESETS_SPISEL, 0);
-}
-
-static struct au1550_spi_info db1200_spi_platdata = {
-	.mainclk_hz	= 50000000,	/* PSC0 clock */
-	.num_chipselect = 2,
-	.activate_cs	= db1200_spi_cs_en,
-};
-
-static u64 spi_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device db1200_spi_dev = {
-	.dev	= {
-		.dma_mask		= &spi_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &db1200_spi_platdata,
-	},
-	.name		= "au1550-spi",
-	.id		= 0,	/* bus number */
-	.num_resources	= ARRAY_SIZE(au1200_psc0_res),
-	.resource	= au1200_psc0_res,
-};
-
-static struct resource au1200_psc1_res[] = {
-	[0] = {
-		.start	= AU1550_PSC1_PHYS_ADDR,
-		.end	= AU1550_PSC1_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1200_PSC1_INT,
-		.end	= AU1200_PSC1_INT,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AU1200_DSCR_CMD0_PSC1_TX,
-		.end	= AU1200_DSCR_CMD0_PSC1_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= AU1200_DSCR_CMD0_PSC1_RX,
-		.end	= AU1200_DSCR_CMD0_PSC1_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-/* AC97 or I2S device */
-static struct platform_device db1200_audio_dev = {
-	/* name assigned later based on switch setting */
-	.id		= 1,	/* PSC ID */
-	.num_resources	= ARRAY_SIZE(au1200_psc1_res),
-	.resource	= au1200_psc1_res,
-};
-
-/* DB1200 ASoC card device */
-static struct platform_device db1200_sound_dev = {
-	/* name assigned later based on switch setting */
-	.id		= 1,	/* PSC ID */
-};
-
-static struct platform_device db1200_stac_dev = {
-	.name		= "ac97-codec",
-	.id		= 1,	/* on PSC1 */
-};
-
-static struct platform_device db1200_audiodma_dev = {
-	.name		= "au1xpsc-pcm",
-	.id		= 1,	/* PSC ID */
-};
-
-static struct platform_device *db1200_devs[] __initdata = {
-	NULL,		/* PSC0, selected by S6.8 */
-	&db1200_ide_dev,
-	&db1200_mmc0_dev,
-	&au1200_lcd_dev,
-	&db1200_eth_dev,
-	&db1200_rtc_dev,
-	&db1200_nand_dev,
-	&db1200_audiodma_dev,
-	&db1200_audio_dev,
-	&db1200_stac_dev,
-	&db1200_sound_dev,
-};
-
-static int __init db1200_dev_init(void)
-{
-	unsigned long pfc;
-	unsigned short sw;
-	int swapped;
-
-	i2c_register_board_info(0, db1200_i2c_devs,
-				ARRAY_SIZE(db1200_i2c_devs));
-	spi_register_board_info(db1200_spi_devs,
-				ARRAY_SIZE(db1200_i2c_devs));
-
-	/* SWITCHES:	S6.8 I2C/SPI selector  (OFF=I2C  ON=SPI)
-	 *		S6.7 AC97/I2S selector (OFF=AC97 ON=I2S)
-	 */
-
-	/* NOTE: GPIO215 controls OTG VBUS supply.  In SPI mode however
-	 * this pin is claimed by PSC0 (unused though, but pinmux doesn't
-	 * allow to free it without crippling the SPI interface).
-	 * As a result, in SPI mode, OTG simply won't work (PSC0 uses
-	 * it as an input pin which is pulled high on the boards).
-	 */
-	pfc = __raw_readl((void __iomem *)SYS_PINFUNC) & ~SYS_PINFUNC_P0A;
-
-	/* switch off OTG VBUS supply */
-	gpio_request(215, "otg-vbus");
-	gpio_direction_output(215, 1);
-
-	printk(KERN_INFO "DB1200 device configuration:\n");
-
-	sw = bcsr_read(BCSR_SWITCHES);
-	if (sw & BCSR_SWITCHES_DIP_8) {
-		db1200_devs[0] = &db1200_i2c_dev;
-		bcsr_mod(BCSR_RESETS, BCSR_RESETS_PSC0MUX, 0);
-
-		pfc |= (2 << 17);	/* GPIO2 block owns GPIO215 */
-
-		printk(KERN_INFO " S6.8 OFF: PSC0 mode I2C\n");
-		printk(KERN_INFO "   OTG port VBUS supply available!\n");
-	} else {
-		db1200_devs[0] = &db1200_spi_dev;
-		bcsr_mod(BCSR_RESETS, 0, BCSR_RESETS_PSC0MUX);
-
-		pfc |= (1 << 17);	/* PSC0 owns GPIO215 */
-
-		printk(KERN_INFO " S6.8 ON : PSC0 mode SPI\n");
-		printk(KERN_INFO "   OTG port VBUS supply disabled\n");
-	}
-	__raw_writel(pfc, (void __iomem *)SYS_PINFUNC);
-	wmb();
-
-	/* Audio: DIP7 selects I2S(0)/AC97(1), but need I2C for I2S!
-	 * so: DIP7=1 || DIP8=0 => AC97, DIP7=0 && DIP8=1 => I2S
-	 */
-	sw &= BCSR_SWITCHES_DIP_8 | BCSR_SWITCHES_DIP_7;
-	if (sw == BCSR_SWITCHES_DIP_8) {
-		bcsr_mod(BCSR_RESETS, 0, BCSR_RESETS_PSC1MUX);
-		db1200_audio_dev.name = "au1xpsc_i2s";
-		db1200_sound_dev.name = "db1200-i2s";
-		printk(KERN_INFO " S6.7 ON : PSC1 mode I2S\n");
-	} else {
-		bcsr_mod(BCSR_RESETS, BCSR_RESETS_PSC1MUX, 0);
-		db1200_audio_dev.name = "au1xpsc_ac97";
-		db1200_sound_dev.name = "db1200-ac97";
-		printk(KERN_INFO " S6.7 OFF: PSC1 mode AC97\n");
-	}
-
-	/* Audio PSC clock is supplied externally. (FIXME: platdata!!) */
-	__raw_writel(PSC_SEL_CLK_SERCLK,
-		(void __iomem *)KSEG1ADDR(AU1550_PSC1_PHYS_ADDR) + PSC_SEL_OFFSET);
-	wmb();
-
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-		DB1200_PC0_INT, DB1200_PC0_INSERT_INT,
-		/*DB1200_PC0_STSCHG_INT*/0, DB1200_PC0_EJECT_INT, 0);
-
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004000000,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
-		DB1200_PC1_INT, DB1200_PC1_INSERT_INT,
-		/*DB1200_PC1_STSCHG_INT*/0, DB1200_PC1_EJECT_INT, 1);
-
-	swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1200_SWAPBOOT;
-	db1x_register_norflash(64 << 20, 2, swapped);
-
-	return platform_add_devices(db1200_devs, ARRAY_SIZE(db1200_devs));
-}
-device_initcall(db1200_dev_init);
-
-/* au1200fb calls these: STERBT EINEN TRAGISCHEN TOD!!! */
-int board_au1200fb_panel(void)
-{
-	return (bcsr_read(BCSR_SWITCHES) >> 8) & 0x0f;
-}
-
-int board_au1200fb_panel_init(void)
-{
-	/* Apply power */
-	bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
-				BCSR_BOARD_LCDBL);
-	return 0;
-}
-
-int board_au1200fb_panel_shutdown(void)
-{
-	/* Remove power */
-	bcsr_mod(BCSR_BOARD, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
-			     BCSR_BOARD_LCDBL, 0);
-	return 0;
-}
diff --git a/arch/mips/alchemy/devboards/db1200/setup.c b/arch/mips/alchemy/devboards/db1200/setup.c
deleted file mode 100644
index 4a89800..0000000
--- a/arch/mips/alchemy/devboards/db1200/setup.c
+++ /dev/null
@@ -1,81 +0,0 @@
-/*
- * Alchemy/AMD/RMI DB1200 board setup.
- *
- * Licensed under the terms outlined in the file COPYING in the root of
- * this source archive.
- */
-
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/io.h>
-#include <linux/kernel.h>
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-db1x00/bcsr.h>
-#include <asm/mach-db1x00/db1200.h>
-
-const char *get_system_type(void)
-{
-	return "Alchemy Db1200";
-}
-
-void __init board_setup(void)
-{
-	unsigned long freq0, clksrc, div, pfc;
-	unsigned short whoami;
-
-	bcsr_init(DB1200_BCSR_PHYS_ADDR,
-		  DB1200_BCSR_PHYS_ADDR + DB1200_BCSR_HEXLED_OFS);
-
-	whoami = bcsr_read(BCSR_WHOAMI);
-	printk(KERN_INFO "Alchemy/AMD/RMI DB1200 Board, CPLD Rev %d"
-		"  Board-ID %d  Daughtercard ID %d\n",
-		(whoami >> 4) & 0xf, (whoami >> 8) & 0xf, whoami & 0xf);
-
-	/* SMBus/SPI on PSC0, Audio on PSC1 */
-	pfc = __raw_readl((void __iomem *)SYS_PINFUNC);
-	pfc &= ~(SYS_PINFUNC_P0A | SYS_PINFUNC_P0B);
-	pfc &= ~(SYS_PINFUNC_P1A | SYS_PINFUNC_P1B | SYS_PINFUNC_FS3);
-	pfc |= SYS_PINFUNC_P1C;	/* SPI is configured later */
-	__raw_writel(pfc, (void __iomem *)SYS_PINFUNC);
-	wmb();
-
-	/* Clock configurations: PSC0: ~50MHz via Clkgen0, derived from
-	 * CPU clock; all other clock generators off/unused.
-	 */
-	div = (get_au1x00_speed() + 25000000) / 50000000;
-	if (div & 1)
-		div++;
-	div = ((div >> 1) - 1) & 0xff;
-
-	freq0 = div << SYS_FC_FRDIV0_BIT;
-	__raw_writel(freq0, (void __iomem *)SYS_FREQCTRL0);
-	wmb();
-	freq0 |= SYS_FC_FE0;	/* enable F0 */
-	__raw_writel(freq0, (void __iomem *)SYS_FREQCTRL0);
-	wmb();
-
-	/* psc0_intclk comes 1:1 from F0 */
-	clksrc = SYS_CS_MUX_FQ0 << SYS_CS_ME0_BIT;
-	__raw_writel(clksrc, (void __iomem *)SYS_CLKSRC);
-	wmb();
-}
-
-static int __init db1200_arch_init(void)
-{
-	/* GPIO7 is low-level triggered CPLD cascade */
-	irq_set_irq_type(AU1200_GPIO7_INT, IRQF_TRIGGER_LOW);
-	bcsr_init_irq(DB1200_INT_BEGIN, DB1200_INT_END, AU1200_GPIO7_INT);
-
-	/* insert/eject pairs: one of both is always screaming.  To avoid
-	 * issues they must not be automatically enabled when initially
-	 * requested.
-	 */
-	irq_set_status_flags(DB1200_SD0_INSERT_INT, IRQ_NOAUTOEN);
-	irq_set_status_flags(DB1200_SD0_EJECT_INT, IRQ_NOAUTOEN);
-	irq_set_status_flags(DB1200_PC0_INSERT_INT, IRQ_NOAUTOEN);
-	irq_set_status_flags(DB1200_PC0_EJECT_INT, IRQ_NOAUTOEN);
-	irq_set_status_flags(DB1200_PC1_INSERT_INT, IRQ_NOAUTOEN);
-	irq_set_status_flags(DB1200_PC1_EJECT_INT, IRQ_NOAUTOEN);
-	return 0;
-}
-arch_initcall(db1200_arch_init);
diff --git a/arch/mips/alchemy/devboards/db1x00.c b/arch/mips/alchemy/devboards/db1x00.c
new file mode 100644
index 0000000..589ae24
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1x00.c
@@ -0,0 +1,256 @@
+/*
+ * DBAu1000/1500/1100 board support
+ *
+ * Copyright 2000, 2008 MontaVista Software Inc.
+ * Author: MontaVista Software, Inc. <source@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1000_dma.h>
+#include <asm/mach-db1x00/bcsr.h>
+#include <asm/reboot.h>
+#include <prom.h>
+#include "platform.h"
+
+struct pci_dev;
+
+const char *get_system_type(void)
+{
+	return "Alchemy Db1x00";
+}
+
+void __init board_setup(void)
+{
+#ifdef CONFIG_MIPS_DB1000
+	printk(KERN_INFO "AMD Alchemy Au1000/Db1000 Board\n");
+#endif
+#ifdef CONFIG_MIPS_DB1500
+	printk(KERN_INFO "AMD Alchemy Au1500/Db1500 Board\n");
+#endif
+#ifdef CONFIG_MIPS_DB1100
+	printk(KERN_INFO "AMD Alchemy Au1100/Db1100 Board\n");
+#endif
+	/* initialize board register space */
+	bcsr_init(DB1000_BCSR_PHYS_ADDR,
+		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
+
+#if defined(CONFIG_IRDA) && defined(CONFIG_AU1000_FIR)
+	{
+		u32 pin_func;
+
+		/* Set IRFIRSEL instead of GPIO15 */
+		pin_func = au_readl(SYS_PINFUNC) | SYS_PF_IRF;
+		au_writel(pin_func, SYS_PINFUNC);
+		/* Power off until the driver is in use */
+		bcsr_mod(BCSR_RESETS, BCSR_RESETS_IRDA_MODE_MASK,
+			 BCSR_RESETS_IRDA_MODE_OFF);
+	}
+#endif
+	bcsr_write(BCSR_PCMCIA, 0);	/* turn off PCMCIA power */
+
+	/* Enable GPIO[31:0] inputs */
+	alchemy_gpio1_input_enable();
+}
+
+/* DB1xxx PCMCIA interrupt sources:
+ * CD0/1	GPIO0/3
+ * STSCHG0/1	GPIO1/4
+ * CARD0/1	GPIO2/5
+ */
+
+#define F_SWAPPED (bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1000_SWAPBOOT)
+
+#if defined(CONFIG_MIPS_DB1000)
+#define DB1XXX_PCMCIA_CD0	AU1000_GPIO0_INT
+#define DB1XXX_PCMCIA_STSCHG0	AU1000_GPIO1_INT
+#define DB1XXX_PCMCIA_CARD0	AU1000_GPIO2_INT
+#define DB1XXX_PCMCIA_CD1	AU1000_GPIO3_INT
+#define DB1XXX_PCMCIA_STSCHG1	AU1000_GPIO4_INT
+#define DB1XXX_PCMCIA_CARD1	AU1000_GPIO5_INT
+#elif defined(CONFIG_MIPS_DB1100)
+#define DB1XXX_PCMCIA_CD0	AU1100_GPIO0_INT
+#define DB1XXX_PCMCIA_STSCHG0	AU1100_GPIO1_INT
+#define DB1XXX_PCMCIA_CARD0	AU1100_GPIO2_INT
+#define DB1XXX_PCMCIA_CD1	AU1100_GPIO3_INT
+#define DB1XXX_PCMCIA_STSCHG1	AU1100_GPIO4_INT
+#define DB1XXX_PCMCIA_CARD1	AU1100_GPIO5_INT
+#elif defined(CONFIG_MIPS_DB1500)
+#define DB1XXX_PCMCIA_CD0	AU1500_GPIO0_INT
+#define DB1XXX_PCMCIA_STSCHG0	AU1500_GPIO1_INT
+#define DB1XXX_PCMCIA_CARD0	AU1500_GPIO2_INT
+#define DB1XXX_PCMCIA_CD1	AU1500_GPIO3_INT
+#define DB1XXX_PCMCIA_STSCHG1	AU1500_GPIO4_INT
+#define DB1XXX_PCMCIA_CARD1	AU1500_GPIO5_INT
+
+static int db1500_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+{
+	if ((slot < 12) || (slot > 13) || pin == 0)
+		return -1;
+	if (slot == 12)
+		return (pin == 1) ? AU1500_PCI_INTA : 0xff;
+	if (slot == 13) {
+		switch (pin) {
+		case 1: return AU1500_PCI_INTA;
+		case 2: return AU1500_PCI_INTB;
+		case 3: return AU1500_PCI_INTC;
+		case 4: return AU1500_PCI_INTD;
+		}
+	}
+	return -1;
+}
+
+static struct resource alchemy_pci_host_res[] = {
+	[0] = {
+		.start	= AU1500_PCI_PHYS_ADDR,
+		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct alchemy_pci_platdata db1500_pci_pd = {
+	.board_map_irq	= db1500_map_pci_irq,
+};
+
+static struct platform_device db1500_pci_host_dev = {
+	.dev.platform_data = &db1500_pci_pd,
+	.name		= "alchemy-pci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
+	.resource	= alchemy_pci_host_res,
+};
+
+static int __init db1500_pci_init(void)
+{
+	return platform_device_register(&db1500_pci_host_dev);
+}
+/* must be arch_initcall; MIPS PCI scans busses in a subsys_initcall */
+arch_initcall(db1500_pci_init);
+#endif
+
+#ifdef CONFIG_MIPS_DB1100
+static struct resource au1100_lcd_resources[] = {
+	[0] = {
+		.start	= AU1100_LCD_PHYS_ADDR,
+		.end	= AU1100_LCD_PHYS_ADDR + 0x800 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1100_LCD_INT,
+		.end	= AU1100_LCD_INT,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static u64 au1100_lcd_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device au1100_lcd_device = {
+	.name		= "au1100-lcd",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1100_lcd_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(au1100_lcd_resources),
+	.resource	= au1100_lcd_resources,
+};
+#endif
+
+static struct resource alchemy_ac97c_res[] = {
+	[0] = {
+		.start	= AU1000_AC97_PHYS_ADDR,
+		.end	= AU1000_AC97_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= DMA_ID_AC97C_TX,
+		.end	= DMA_ID_AC97C_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[2] = {
+		.start	= DMA_ID_AC97C_RX,
+		.end	= DMA_ID_AC97C_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device alchemy_ac97c_dev = {
+	.name		= "alchemy-ac97c",
+	.id		= -1,
+	.resource	= alchemy_ac97c_res,
+	.num_resources	= ARRAY_SIZE(alchemy_ac97c_res),
+};
+
+static struct platform_device alchemy_ac97c_dma_dev = {
+	.name		= "alchemy-pcm-dma",
+	.id		= 0,
+};
+
+static struct platform_device db1x00_codec_dev = {
+	.name		= "ac97-codec",
+	.id		= -1,
+};
+
+static struct platform_device db1x00_audio_dev = {
+	.name		= "db1000-audio",
+};
+
+static int __init db1xxx_dev_init(void)
+{
+	irq_set_irq_type(DB1XXX_PCMCIA_CD0, IRQ_TYPE_EDGE_BOTH);
+	irq_set_irq_type(DB1XXX_PCMCIA_CD1, IRQ_TYPE_EDGE_BOTH);
+	irq_set_irq_type(DB1XXX_PCMCIA_CARD0, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(DB1XXX_PCMCIA_CARD1, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(DB1XXX_PCMCIA_STSCHG0, IRQ_TYPE_LEVEL_LOW);
+	irq_set_irq_type(DB1XXX_PCMCIA_STSCHG1, IRQ_TYPE_LEVEL_LOW);
+
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
+		DB1XXX_PCMCIA_CARD0, DB1XXX_PCMCIA_CD0,
+		/*DB1XXX_PCMCIA_STSCHG0*/0, 0, 0);
+
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004000000,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
+		DB1XXX_PCMCIA_CARD1, DB1XXX_PCMCIA_CD1,
+		/*DB1XXX_PCMCIA_STSCHG1*/0, 0, 1);
+#ifdef CONFIG_MIPS_DB1100
+	platform_device_register(&au1100_lcd_device);
+#endif
+	platform_device_register(&db1x00_codec_dev);
+	platform_device_register(&alchemy_ac97c_dma_dev);
+	platform_device_register(&alchemy_ac97c_dev);
+	platform_device_register(&db1x00_audio_dev);
+
+	db1x_register_norflash(32 << 20, 4 /* 32bit */, F_SWAPPED);
+	return 0;
+}
+device_initcall(db1xxx_dev_init);
diff --git a/arch/mips/alchemy/devboards/db1x00/Makefile b/arch/mips/alchemy/devboards/db1x00/Makefile
deleted file mode 100644
index 613c0c0..0000000
--- a/arch/mips/alchemy/devboards/db1x00/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-#
-#  Copyright 2000, 2008 MontaVista Software Inc.
-#  Author: MontaVista Software, Inc. <source@mvista.com>
-#
-# Makefile for the Alchemy Semiconductor DBAu1xx0 boards.
-#
-
-obj-y := board_setup.o platform.o
diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
deleted file mode 100644
index 2dbebcb..0000000
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ /dev/null
@@ -1,108 +0,0 @@
-/*
- *
- * BRIEF MODULE DESCRIPTION
- *	Alchemy Db1x00 board setup.
- *
- * Copyright 2000, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/gpio.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/pm.h>
-
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-au1x00/au1xxx_eth.h>
-#include <asm/mach-db1x00/db1x00.h>
-#include <asm/mach-db1x00/bcsr.h>
-#include <asm/reboot.h>
-
-#include <prom.h>
-
-const char *get_system_type(void)
-{
-	return "Alchemy Db1x00";
-}
-
-
-void __init board_setup(void)
-{
-#ifdef CONFIG_MIPS_DB1000
-	printk(KERN_INFO "AMD Alchemy Au1000/Db1000 Board\n");
-#endif
-#ifdef CONFIG_MIPS_DB1500
-	printk(KERN_INFO "AMD Alchemy Au1500/Db1500 Board\n");
-#endif
-#ifdef CONFIG_MIPS_DB1100
-	printk(KERN_INFO "AMD Alchemy Au1100/Db1100 Board\n");
-#endif
-	/* initialize board register space */
-	bcsr_init(DB1000_BCSR_PHYS_ADDR,
-		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
-
-#if defined(CONFIG_IRDA) && defined(CONFIG_AU1000_FIR)
-	{
-		u32 pin_func;
-
-		/* Set IRFIRSEL instead of GPIO15 */
-		pin_func = au_readl(SYS_PINFUNC) | SYS_PF_IRF;
-		au_writel(pin_func, SYS_PINFUNC);
-		/* Power off until the driver is in use */
-		bcsr_mod(BCSR_RESETS, BCSR_RESETS_IRDA_MODE_MASK,
-			 BCSR_RESETS_IRDA_MODE_OFF);
-	}
-#endif
-	bcsr_write(BCSR_PCMCIA, 0);	/* turn off PCMCIA power */
-
-	/* Enable GPIO[31:0] inputs */
-	alchemy_gpio1_input_enable();
-}
-
-static int __init db1x00_init_irq(void)
-{
-#if defined(CONFIG_MIPS_DB1500)
-	irq_set_irq_type(AU1500_GPIO0_INT, IRQF_TRIGGER_LOW); /* CD0# */
-	irq_set_irq_type(AU1500_GPIO3_INT, IRQF_TRIGGER_LOW); /* CD1# */
-	irq_set_irq_type(AU1500_GPIO2_INT, IRQF_TRIGGER_LOW); /* CARD0# */
-	irq_set_irq_type(AU1500_GPIO5_INT, IRQF_TRIGGER_LOW); /* CARD1# */
-	irq_set_irq_type(AU1500_GPIO1_INT, IRQF_TRIGGER_LOW); /* STSCHG0# */
-	irq_set_irq_type(AU1500_GPIO4_INT, IRQF_TRIGGER_LOW); /* STSCHG1# */
-#elif defined(CONFIG_MIPS_DB1100)
-	irq_set_irq_type(AU1100_GPIO0_INT, IRQF_TRIGGER_LOW); /* CD0# */
-	irq_set_irq_type(AU1100_GPIO3_INT, IRQF_TRIGGER_LOW); /* CD1# */
-	irq_set_irq_type(AU1100_GPIO2_INT, IRQF_TRIGGER_LOW); /* CARD0# */
-	irq_set_irq_type(AU1100_GPIO5_INT, IRQF_TRIGGER_LOW); /* CARD1# */
-	irq_set_irq_type(AU1100_GPIO1_INT, IRQF_TRIGGER_LOW); /* STSCHG0# */
-	irq_set_irq_type(AU1100_GPIO4_INT, IRQF_TRIGGER_LOW); /* STSCHG1# */
-#elif defined(CONFIG_MIPS_DB1000)
-	irq_set_irq_type(AU1000_GPIO0_INT, IRQF_TRIGGER_LOW); /* CD0# */
-	irq_set_irq_type(AU1000_GPIO3_INT, IRQF_TRIGGER_LOW); /* CD1# */
-	irq_set_irq_type(AU1000_GPIO2_INT, IRQF_TRIGGER_LOW); /* CARD0# */
-	irq_set_irq_type(AU1000_GPIO5_INT, IRQF_TRIGGER_LOW); /* CARD1# */
-	irq_set_irq_type(AU1000_GPIO1_INT, IRQF_TRIGGER_LOW); /* STSCHG0# */
-	irq_set_irq_type(AU1000_GPIO4_INT, IRQF_TRIGGER_LOW); /* STSCHG1# */
-#endif
-	return 0;
-}
-arch_initcall(db1x00_init_irq);
diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
deleted file mode 100644
index 67b36e8..0000000
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ /dev/null
@@ -1,207 +0,0 @@
-/*
- * DBAu1xxx board platform device registration
- *
- * Copyright (C) 2009 Manuel Lauss
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-au1x00/au1000_dma.h>
-#include <asm/mach-db1x00/bcsr.h>
-#include "../platform.h"
-
-struct pci_dev;
-
-/* DB1xxx PCMCIA interrupt sources:
- * CD0/1 	GPIO0/3
- * STSCHG0/1	GPIO1/4
- * CARD0/1	GPIO2/5
- */
-
-#define F_SWAPPED (bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1000_SWAPBOOT)
-
-#if defined(CONFIG_MIPS_DB1000)
-#define DB1XXX_PCMCIA_CD0	AU1000_GPIO0_INT
-#define DB1XXX_PCMCIA_STSCHG0	AU1000_GPIO1_INT
-#define DB1XXX_PCMCIA_CARD0	AU1000_GPIO2_INT
-#define DB1XXX_PCMCIA_CD1	AU1000_GPIO3_INT
-#define DB1XXX_PCMCIA_STSCHG1	AU1000_GPIO4_INT
-#define DB1XXX_PCMCIA_CARD1	AU1000_GPIO5_INT
-#elif defined(CONFIG_MIPS_DB1100)
-#define DB1XXX_PCMCIA_CD0	AU1100_GPIO0_INT
-#define DB1XXX_PCMCIA_STSCHG0	AU1100_GPIO1_INT
-#define DB1XXX_PCMCIA_CARD0	AU1100_GPIO2_INT
-#define DB1XXX_PCMCIA_CD1	AU1100_GPIO3_INT
-#define DB1XXX_PCMCIA_STSCHG1	AU1100_GPIO4_INT
-#define DB1XXX_PCMCIA_CARD1	AU1100_GPIO5_INT
-#elif defined(CONFIG_MIPS_DB1500)
-#define DB1XXX_PCMCIA_CD0	AU1500_GPIO0_INT
-#define DB1XXX_PCMCIA_STSCHG0	AU1500_GPIO1_INT
-#define DB1XXX_PCMCIA_CARD0	AU1500_GPIO2_INT
-#define DB1XXX_PCMCIA_CD1	AU1500_GPIO3_INT
-#define DB1XXX_PCMCIA_STSCHG1	AU1500_GPIO4_INT
-#define DB1XXX_PCMCIA_CARD1	AU1500_GPIO5_INT
-
-static int db1500_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
-{
-	if ((slot < 12) || (slot > 13) || pin == 0)
-		return -1;
-	if (slot == 12)
-		return (pin == 1) ? AU1500_PCI_INTA : 0xff;
-	if (slot == 13) {
-		switch (pin) {
-		case 1: return AU1500_PCI_INTA;
-		case 2: return AU1500_PCI_INTB;
-		case 3: return AU1500_PCI_INTC;
-		case 4: return AU1500_PCI_INTD;
-		}
-	}
-	return -1;
-}
-
-static struct resource alchemy_pci_host_res[] = {
-	[0] = {
-		.start	= AU1500_PCI_PHYS_ADDR,
-		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct alchemy_pci_platdata db1500_pci_pd = {
-	.board_map_irq	= db1500_map_pci_irq,
-};
-
-static struct platform_device db1500_pci_host_dev = {
-	.dev.platform_data = &db1500_pci_pd,
-	.name		= "alchemy-pci",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
-	.resource	= alchemy_pci_host_res,
-};
-
-static int __init db1500_pci_init(void)
-{
-	return platform_device_register(&db1500_pci_host_dev);
-}
-/* must be arch_initcall; MIPS PCI scans busses in a subsys_initcall */
-arch_initcall(db1500_pci_init);
-#endif
-
-#ifdef CONFIG_MIPS_DB1100
-static struct resource au1100_lcd_resources[] = {
-	[0] = {
-		.start	= AU1100_LCD_PHYS_ADDR,
-		.end	= AU1100_LCD_PHYS_ADDR + 0x800 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1100_LCD_INT,
-		.end	= AU1100_LCD_INT,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static u64 au1100_lcd_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device au1100_lcd_device = {
-	.name		= "au1100-lcd",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &au1100_lcd_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(au1100_lcd_resources),
-	.resource	= au1100_lcd_resources,
-};
-#endif
-
-static struct resource alchemy_ac97c_res[] = {
-	[0] = {
-		.start	= AU1000_AC97_PHYS_ADDR,
-		.end	= AU1000_AC97_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= DMA_ID_AC97C_TX,
-		.end	= DMA_ID_AC97C_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[2] = {
-		.start	= DMA_ID_AC97C_RX,
-		.end	= DMA_ID_AC97C_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-static struct platform_device alchemy_ac97c_dev = {
-	.name		= "alchemy-ac97c",
-	.id		= -1,
-	.resource	= alchemy_ac97c_res,
-	.num_resources	= ARRAY_SIZE(alchemy_ac97c_res),
-};
-
-static struct platform_device alchemy_ac97c_dma_dev = {
-	.name		= "alchemy-pcm-dma",
-	.id		= 0,
-};
-
-static struct platform_device db1x00_codec_dev = {
-	.name		= "ac97-codec",
-	.id		= -1,
-};
-
-static struct platform_device db1x00_audio_dev = {
-	.name		= "db1000-audio",
-};
-
-static int __init db1xxx_dev_init(void)
-{
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-		DB1XXX_PCMCIA_CARD0, DB1XXX_PCMCIA_CD0,
-		/*DB1XXX_PCMCIA_STSCHG0*/0, 0, 0);
-
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004000000,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
-		DB1XXX_PCMCIA_CARD1, DB1XXX_PCMCIA_CD1,
-		/*DB1XXX_PCMCIA_STSCHG1*/0, 0, 1);
-#ifdef CONFIG_MIPS_DB1100
-	platform_device_register(&au1100_lcd_device);
-#endif
-	platform_device_register(&db1x00_codec_dev);
-	platform_device_register(&alchemy_ac97c_dma_dev);
-	platform_device_register(&alchemy_ac97c_dev);
-	platform_device_register(&db1x00_audio_dev);
-
-	db1x_register_norflash(0x02000000, 4 /* 32bit */, F_SWAPPED);
-	return 0;
-}
-device_initcall(db1xxx_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1100.c b/arch/mips/alchemy/devboards/pb1100.c
new file mode 100644
index 0000000..cff50d0
--- /dev/null
+++ b/arch/mips/alchemy/devboards/pb1100.c
@@ -0,0 +1,167 @@
+/*
+ * Pb1100 board platform device registration
+ *
+ * Copyright (C) 2009 Manuel Lauss
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/delay.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/platform_device.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-db1x00/bcsr.h>
+#include <prom.h>
+#include "platform.h"
+
+const char *get_system_type(void)
+{
+	return "PB1100";
+}
+
+void __init board_setup(void)
+{
+	volatile void __iomem *base = (volatile void __iomem *)0xac000000UL;
+
+	bcsr_init(DB1000_BCSR_PHYS_ADDR,
+		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
+
+	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
+	au_writel(8, SYS_AUXPLL);
+	alchemy_gpio1_input_enable();
+	udelay(100);
+
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+	{
+		u32 pin_func, sys_freqctrl, sys_clksrc;
+
+		/* Configure pins GPIO[14:9] as GPIO */
+		pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_UR3;
+
+		/* Zero and disable FREQ2 */
+		sys_freqctrl = au_readl(SYS_FREQCTRL0);
+		sys_freqctrl &= ~0xFFF00000;
+		au_writel(sys_freqctrl, SYS_FREQCTRL0);
+
+		/* Zero and disable USBH/USBD/IrDA clock */
+		sys_clksrc = au_readl(SYS_CLKSRC);
+		sys_clksrc &= ~(SYS_CS_CIR | SYS_CS_DIR | SYS_CS_MIR_MASK);
+		au_writel(sys_clksrc, SYS_CLKSRC);
+
+		sys_freqctrl = au_readl(SYS_FREQCTRL0);
+		sys_freqctrl &= ~0xFFF00000;
+
+		sys_clksrc = au_readl(SYS_CLKSRC);
+		sys_clksrc &= ~(SYS_CS_CIR | SYS_CS_DIR | SYS_CS_MIR_MASK);
+
+		/* FREQ2 = aux / 2 = 48 MHz */
+		sys_freqctrl |= (0 << SYS_FC_FRDIV2_BIT) |
+				SYS_FC_FE2 | SYS_FC_FS2;
+		au_writel(sys_freqctrl, SYS_FREQCTRL0);
+
+		/*
+		 * Route 48 MHz FREQ2 into USBH/USBD/IrDA
+		 */
+		sys_clksrc |= SYS_CS_MUX_FQ2 << SYS_CS_MIR_BIT;
+		au_writel(sys_clksrc, SYS_CLKSRC);
+
+		/* Setup the static bus controller */
+		au_writel(0x00000002, MEM_STCFG3);  /* type = PCMCIA */
+		au_writel(0x280E3D07, MEM_STTIME3); /* 250ns cycle time */
+		au_writel(0x10000000, MEM_STADDR3); /* any PCMCIA select */
+
+		/*
+		 * Get USB Functionality pin state (device vs host drive pins).
+		 */
+		pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_USB;
+		/* 2nd USB port is USB host. */
+		pin_func |= SYS_PF_USB;
+		au_writel(pin_func, SYS_PINFUNC);
+	}
+#endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
+
+	/* Enable sys bus clock divider when IDLE state or no bus activity. */
+	au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
+
+	/* Enable the RTC if not already enabled. */
+	if (!(readb(base + 0x28) & 0x20)) {
+		writeb(readb(base + 0x28) | 0x20, base + 0x28);
+		au_sync();
+	}
+	/* Put the clock in BCD mode. */
+	if (readb(base + 0x2C) & 0x4) { /* reg B */
+		writeb(readb(base + 0x2c) & ~0x4, base + 0x2c);
+		au_sync();
+	}
+}
+
+/******************************************************************************/
+
+static struct resource au1100_lcd_resources[] = {
+	[0] = {
+		.start	= AU1100_LCD_PHYS_ADDR,
+		.end	= AU1100_LCD_PHYS_ADDR + 0x800 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1100_LCD_INT,
+		.end	= AU1100_LCD_INT,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static u64 au1100_lcd_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device au1100_lcd_device = {
+	.name		= "au1100-lcd",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1100_lcd_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(au1100_lcd_resources),
+	.resource	= au1100_lcd_resources,
+};
+
+static int __init pb1100_dev_init(void)
+{
+	int swapped;
+
+	irq_set_irq_type(AU1100_GPIO9_INT, IRQF_TRIGGER_LOW); /* PCCD# */
+	irq_set_irq_type(AU1100_GPIO10_INT, IRQF_TRIGGER_LOW); /* PCSTSCHG# */
+	irq_set_irq_type(AU1100_GPIO11_INT, IRQF_TRIGGER_LOW); /* PCCard# */
+	irq_set_irq_type(AU1100_GPIO13_INT, IRQF_TRIGGER_LOW); /* DC_IRQ# */
+
+	/* PCMCIA. single socket, identical to Pb1500 */
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
+		AU1100_GPIO11_INT, AU1100_GPIO9_INT,	 /* card / insert */
+		/*AU1100_GPIO10_INT*/0, 0, 0); /* stschg / eject / id */
+
+	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1000_SWAPBOOT;
+	db1x_register_norflash(64 * 1024 * 1024, 4, swapped);
+	platform_device_register(&au1100_lcd_device);
+
+	return 0;
+}
+device_initcall(pb1100_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1100/Makefile b/arch/mips/alchemy/devboards/pb1100/Makefile
deleted file mode 100644
index 7e3756c..0000000
--- a/arch/mips/alchemy/devboards/pb1100/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-#
-#  Copyright 2000, 2001, 2008 MontaVista Software Inc.
-#  Author: MontaVista Software, Inc. <source@mvista.com>
-#
-# Makefile for the Alchemy Semiconductor Pb1100 board.
-#
-
-obj-y := board_setup.o platform.o
diff --git a/arch/mips/alchemy/devboards/pb1100/board_setup.c b/arch/mips/alchemy/devboards/pb1100/board_setup.c
deleted file mode 100644
index d108fd5..0000000
--- a/arch/mips/alchemy/devboards/pb1100/board_setup.c
+++ /dev/null
@@ -1,127 +0,0 @@
-/*
- * Copyright 2002, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/gpio.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-db1x00/bcsr.h>
-
-#include <prom.h>
-
-
-const char *get_system_type(void)
-{
-	return "Alchemy Pb1100";
-}
-
-void __init board_setup(void)
-{
-	volatile void __iomem *base = (volatile void __iomem *)0xac000000UL;
-
-	bcsr_init(DB1000_BCSR_PHYS_ADDR,
-		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
-
-	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
-	au_writel(8, SYS_AUXPLL);
-	alchemy_gpio1_input_enable();
-	udelay(100);
-
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-	{
-		u32 pin_func, sys_freqctrl, sys_clksrc;
-
-		/* Configure pins GPIO[14:9] as GPIO */
-		pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_UR3;
-
-		/* Zero and disable FREQ2 */
-		sys_freqctrl = au_readl(SYS_FREQCTRL0);
-		sys_freqctrl &= ~0xFFF00000;
-		au_writel(sys_freqctrl, SYS_FREQCTRL0);
-
-		/* Zero and disable USBH/USBD/IrDA clock */
-		sys_clksrc = au_readl(SYS_CLKSRC);
-		sys_clksrc &= ~(SYS_CS_CIR | SYS_CS_DIR | SYS_CS_MIR_MASK);
-		au_writel(sys_clksrc, SYS_CLKSRC);
-
-		sys_freqctrl = au_readl(SYS_FREQCTRL0);
-		sys_freqctrl &= ~0xFFF00000;
-
-		sys_clksrc = au_readl(SYS_CLKSRC);
-		sys_clksrc &= ~(SYS_CS_CIR | SYS_CS_DIR | SYS_CS_MIR_MASK);
-
-		/* FREQ2 = aux / 2 = 48 MHz */
-		sys_freqctrl |= (0 << SYS_FC_FRDIV2_BIT) |
-				SYS_FC_FE2 | SYS_FC_FS2;
-		au_writel(sys_freqctrl, SYS_FREQCTRL0);
-
-		/*
-		 * Route 48 MHz FREQ2 into USBH/USBD/IrDA
-		 */
-		sys_clksrc |= SYS_CS_MUX_FQ2 << SYS_CS_MIR_BIT;
-		au_writel(sys_clksrc, SYS_CLKSRC);
-
-		/* Setup the static bus controller */
-		au_writel(0x00000002, MEM_STCFG3);  /* type = PCMCIA */
-		au_writel(0x280E3D07, MEM_STTIME3); /* 250ns cycle time */
-		au_writel(0x10000000, MEM_STADDR3); /* any PCMCIA select */
-
-		/*
-		 * Get USB Functionality pin state (device vs host drive pins).
-		 */
-		pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_USB;
-		/* 2nd USB port is USB host. */
-		pin_func |= SYS_PF_USB;
-		au_writel(pin_func, SYS_PINFUNC);
-	}
-#endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
-
-	/* Enable sys bus clock divider when IDLE state or no bus activity. */
-	au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
-
-	/* Enable the RTC if not already enabled. */
-	if (!(readb(base + 0x28) & 0x20)) {
-		writeb(readb(base + 0x28) | 0x20, base + 0x28);
-		au_sync();
-	}
-	/* Put the clock in BCD mode. */
-	if (readb(base + 0x2C) & 0x4) { /* reg B */
-		writeb(readb(base + 0x2c) & ~0x4, base + 0x2c);
-		au_sync();
-	}
-}
-
-static int __init pb1100_init_irq(void)
-{
-	irq_set_irq_type(AU1100_GPIO9_INT, IRQF_TRIGGER_LOW); /* PCCD# */
-	irq_set_irq_type(AU1100_GPIO10_INT, IRQF_TRIGGER_LOW); /* PCSTSCHG# */
-	irq_set_irq_type(AU1100_GPIO11_INT, IRQF_TRIGGER_LOW); /* PCCard# */
-	irq_set_irq_type(AU1100_GPIO13_INT, IRQF_TRIGGER_LOW); /* DC_IRQ# */
-
-	return 0;
-}
-arch_initcall(pb1100_init_irq);
diff --git a/arch/mips/alchemy/devboards/pb1100/platform.c b/arch/mips/alchemy/devboards/pb1100/platform.c
deleted file mode 100644
index 9c57c01..0000000
--- a/arch/mips/alchemy/devboards/pb1100/platform.c
+++ /dev/null
@@ -1,77 +0,0 @@
-/*
- * Pb1100 board platform device registration
- *
- * Copyright (C) 2009 Manuel Lauss
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/init.h>
-#include <linux/dma-mapping.h>
-#include <linux/platform_device.h>
-
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-db1x00/bcsr.h>
-
-#include "../platform.h"
-
-static struct resource au1100_lcd_resources[] = {
-	[0] = {
-		.start	= AU1100_LCD_PHYS_ADDR,
-		.end	= AU1100_LCD_PHYS_ADDR + 0x800 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1100_LCD_INT,
-		.end	= AU1100_LCD_INT,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static u64 au1100_lcd_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device au1100_lcd_device = {
-	.name		= "au1100-lcd",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &au1100_lcd_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(au1100_lcd_resources),
-	.resource	= au1100_lcd_resources,
-};
-
-static int __init pb1100_dev_init(void)
-{
-	int swapped;
-
-	/* PCMCIA. single socket, identical to Pb1500 */
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-		AU1100_GPIO11_INT, AU1100_GPIO9_INT,	 /* card / insert */
-		/*AU1100_GPIO10_INT*/0, 0, 0); /* stschg / eject / id */
-
-	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1000_SWAPBOOT;
-	db1x_register_norflash(64 * 1024 * 1024, 4, swapped);
-	platform_device_register(&au1100_lcd_device);
-
-	return 0;
-}
-device_initcall(pb1100_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1200.c b/arch/mips/alchemy/devboards/pb1200.c
new file mode 100644
index 0000000..a1b6497
--- /dev/null
+++ b/arch/mips/alchemy/devboards/pb1200.c
@@ -0,0 +1,464 @@
+/*
+ * Pb1200/DBAu1200 board platform device registration
+ *
+ * Copyright (C) 2008 MontaVista Software Inc. <source@mvista.com>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/leds.h>
+#include <linux/platform_device.h>
+#include <linux/smc91x.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1100_mmc.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/mach-db1x00/bcsr.h>
+#include <asm/mach-pb1x00/pb1200.h>
+#include <prom.h>
+#include "platform.h"
+
+
+const char *get_system_type(void)
+{
+	return "PB1200";
+}
+
+void __init board_setup(void)
+{
+	printk(KERN_INFO "AMD Alchemy Pb1200 Board\n");
+	bcsr_init(PB1200_BCSR_PHYS_ADDR,
+		  PB1200_BCSR_PHYS_ADDR + PB1200_BCSR_HEXLED_OFS);
+
+#if 0
+	{
+		u32 pin_func;
+
+		/*
+		 * Enable PSC1 SYNC for AC97.  Normaly done in audio driver,
+		 * but it is board specific code, so put it here.
+		 */
+		pin_func = au_readl(SYS_PINFUNC);
+		au_sync();
+		pin_func |= SYS_PF_MUST_BE_SET | SYS_PF_PSC1_S1;
+		au_writel(pin_func, SYS_PINFUNC);
+
+		au_writel(0, (u32)bcsr | 0x10); /* turn off PCMCIA power */
+		au_sync();
+	}
+#endif
+
+#if defined(CONFIG_I2C_AU1550)
+	{
+		u32 freq0, clksrc;
+		u32 pin_func;
+
+		/* Select SMBus in CPLD */
+		bcsr_mod(BCSR_RESETS, BCSR_RESETS_PSC0MUX, 0);
+
+		pin_func = au_readl(SYS_PINFUNC);
+		au_sync();
+		pin_func &= ~(SYS_PINFUNC_P0A | SYS_PINFUNC_P0B);
+		/* Set GPIOs correctly */
+		pin_func |= 2 << 17;
+		au_writel(pin_func, SYS_PINFUNC);
+		au_sync();
+
+		/* The I2C driver depends on 50 MHz clock */
+		freq0 = au_readl(SYS_FREQCTRL0);
+		au_sync();
+		freq0 &= ~(SYS_FC_FRDIV1_MASK | SYS_FC_FS1 | SYS_FC_FE1);
+		freq0 |= 3 << SYS_FC_FRDIV1_BIT;
+		/* 396 MHz / (3 + 1) * 2 == 49.5 MHz */
+		au_writel(freq0, SYS_FREQCTRL0);
+		au_sync();
+		freq0 |= SYS_FC_FE1;
+		au_writel(freq0, SYS_FREQCTRL0);
+		au_sync();
+
+		clksrc = au_readl(SYS_CLKSRC);
+		au_sync();
+		clksrc &= ~(SYS_CS_CE0 | SYS_CS_DE0 | SYS_CS_ME0_MASK);
+		/* Bit 22 is EXTCLK0 for PSC0 */
+		clksrc |= SYS_CS_MUX_FQ1 << SYS_CS_ME0_BIT;
+		au_writel(clksrc, SYS_CLKSRC);
+		au_sync();
+	}
+#endif
+
+	/*
+	 * The Pb1200 development board uses external MUX for PSC0 to
+	 * support SMB/SPI. bcsr_resets bit 12: 0=SMB 1=SPI
+	 */
+#ifdef CONFIG_I2C_AU1550
+	bcsr_mod(BCSR_RESETS, BCSR_RESETS_PSC0MUX, 0);
+#endif
+	au_sync();
+}
+
+/******************************************************************************/
+
+static int mmc_activity;
+
+static void pb1200mmc0_set_power(void *mmc_host, int state)
+{
+	if (state)
+		bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_SD0PWR);
+	else
+		bcsr_mod(BCSR_BOARD, BCSR_BOARD_SD0PWR, 0);
+
+	msleep(1);
+}
+
+static int pb1200mmc0_card_readonly(void *mmc_host)
+{
+	return (bcsr_read(BCSR_STATUS) & BCSR_STATUS_SD0WP) ? 1 : 0;
+}
+
+static int pb1200mmc0_card_inserted(void *mmc_host)
+{
+	return (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD0INSERT) ? 1 : 0;
+}
+
+static void pb1200_mmcled_set(struct led_classdev *led,
+			enum led_brightness brightness)
+{
+	if (brightness != LED_OFF) {
+		if (++mmc_activity == 1)
+			bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED0, 0);
+	} else {
+		if (--mmc_activity == 0)
+			bcsr_mod(BCSR_LEDS, 0, BCSR_LEDS_LED0);
+	}
+}
+
+static struct led_classdev pb1200mmc_led = {
+	.brightness_set	= pb1200_mmcled_set,
+};
+
+static void pb1200mmc1_set_power(void *mmc_host, int state)
+{
+	if (state)
+		bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_SD1PWR);
+	else
+		bcsr_mod(BCSR_BOARD, BCSR_BOARD_SD1PWR, 0);
+
+	msleep(1);
+}
+
+static int pb1200mmc1_card_readonly(void *mmc_host)
+{
+	return (bcsr_read(BCSR_STATUS) & BCSR_STATUS_SD1WP) ? 1 : 0;
+}
+
+static int pb1200mmc1_card_inserted(void *mmc_host)
+{
+	return (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD1INSERT) ? 1 : 0;
+}
+
+static struct au1xmmc_platform_data pb1200mmc_platdata[2] = {
+	[0] = {
+		.set_power	= pb1200mmc0_set_power,
+		.card_inserted	= pb1200mmc0_card_inserted,
+		.card_readonly	= pb1200mmc0_card_readonly,
+		.cd_setup	= NULL,		/* use poll-timer in driver */
+		.led		= &pb1200mmc_led,
+	},
+	[1] = {
+		.set_power	= pb1200mmc1_set_power,
+		.card_inserted	= pb1200mmc1_card_inserted,
+		.card_readonly	= pb1200mmc1_card_readonly,
+		.cd_setup	= NULL,		/* use poll-timer in driver */
+		.led		= &pb1200mmc_led,
+	},
+};
+
+static u64 au1xxx_mmc_dmamask =  DMA_BIT_MASK(32);
+
+static struct resource au1200_mmc0_res[] = {
+	[0] = {
+		.start	= AU1100_SD0_PHYS_ADDR,
+		.end	= AU1100_SD0_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_SD_INT,
+		.end	= AU1200_SD_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1200_DSCR_CMD0_SDMS_TX0,
+		.end	= AU1200_DSCR_CMD0_SDMS_TX0,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1200_DSCR_CMD0_SDMS_RX0,
+		.end	= AU1200_DSCR_CMD0_SDMS_RX0,
+		.flags	= IORESOURCE_DMA,
+	}
+};
+
+static struct platform_device pb1200_mmc0_dev = {
+	.name		= "au1xxx-mmc",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1xxx_mmc_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &pb1200mmc_platdata[0],
+	},
+	.num_resources	= ARRAY_SIZE(au1200_mmc0_res),
+	.resource	= au1200_mmc0_res,
+};
+
+static struct resource au1200_mmc1_res[] = {
+	[0] = {
+		.start	= AU1100_SD1_PHYS_ADDR,
+		.end	= AU1100_SD1_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_SD_INT,
+		.end	= AU1200_SD_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1200_DSCR_CMD0_SDMS_TX1,
+		.end	= AU1200_DSCR_CMD0_SDMS_TX1,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1200_DSCR_CMD0_SDMS_RX1,
+		.end	= AU1200_DSCR_CMD0_SDMS_RX1,
+		.flags	= IORESOURCE_DMA,
+	}
+};
+
+static struct platform_device pb1200_mmc1_dev = {
+	.name		= "au1xxx-mmc",
+	.id		= 1,
+	.dev = {
+		.dma_mask		= &au1xxx_mmc_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &pb1200mmc_platdata[1],
+	},
+	.num_resources	= ARRAY_SIZE(au1200_mmc1_res),
+	.resource	= au1200_mmc1_res,
+};
+
+
+static struct resource ide_resources[] = {
+	[0] = {
+		.start	= IDE_PHYS_ADDR,
+		.end	= IDE_PHYS_ADDR + IDE_PHYS_LEN - 1,
+		.flags	= IORESOURCE_MEM
+	},
+	[1] = {
+		.start	= IDE_INT,
+		.end	= IDE_INT,
+		.flags	= IORESOURCE_IRQ
+	},
+	[2] = {
+		.start	= AU1200_DSCR_CMD0_DMA_REQ1,
+		.end	= AU1200_DSCR_CMD0_DMA_REQ1,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static u64 au1200_ide_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device ide_device = {
+	.name		= "au1200-ide",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1200_ide_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(ide_resources),
+	.resource	= ide_resources
+};
+
+static struct smc91x_platdata smc_data = {
+	.flags	= SMC91X_NOWAIT | SMC91X_USE_16BIT,
+	.leda	= RPC_LED_100_10,
+	.ledb	= RPC_LED_TX_RX,
+};
+
+static struct resource smc91c111_resources[] = {
+	[0] = {
+		.name	= "smc91x-regs",
+		.start	= SMC91C111_PHYS_ADDR,
+		.end	= SMC91C111_PHYS_ADDR + 0xf,
+		.flags	= IORESOURCE_MEM
+	},
+	[1] = {
+		.start	= SMC91C111_INT,
+		.end	= SMC91C111_INT,
+		.flags	= IORESOURCE_IRQ
+	},
+};
+
+static struct platform_device smc91c111_device = {
+	.dev	= {
+		.platform_data	= &smc_data,
+	},
+	.name		= "smc91x",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(smc91c111_resources),
+	.resource	= smc91c111_resources
+};
+
+static struct resource au1200_psc0_res[] = {
+	[0] = {
+		.start	= AU1550_PSC0_PHYS_ADDR,
+		.end	= AU1550_PSC0_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_PSC0_INT,
+		.end	= AU1200_PSC0_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1200_DSCR_CMD0_PSC0_TX,
+		.end	= AU1200_DSCR_CMD0_PSC0_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1200_DSCR_CMD0_PSC0_RX,
+		.end	= AU1200_DSCR_CMD0_PSC0_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device pb1200_i2c_dev = {
+	.name		= "au1xpsc_smbus",
+	.id		= 0,	/* bus number */
+	.num_resources	= ARRAY_SIZE(au1200_psc0_res),
+	.resource	= au1200_psc0_res,
+};
+
+static struct resource au1200_lcd_res[] = {
+	[0] = {
+		.start	= AU1200_LCD_PHYS_ADDR,
+		.end	= AU1200_LCD_PHYS_ADDR + 0x800 - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_LCD_INT,
+		.end	= AU1200_LCD_INT,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static u64 au1200_lcd_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device au1200_lcd_dev = {
+	.name		= "au1200-lcd",
+	.id		= 0,
+	.dev = {
+		.dma_mask		= &au1200_lcd_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+	},
+	.num_resources	= ARRAY_SIZE(au1200_lcd_res),
+	.resource	= au1200_lcd_res,
+};
+
+static struct platform_device *board_platform_devices[] __initdata = {
+	&ide_device,
+	&smc91c111_device,
+	&pb1200_i2c_dev,
+	&pb1200_mmc0_dev,
+	&pb1200_mmc1_dev,
+	&au1200_lcd_dev,
+};
+
+static int __init board_register_devices(void)
+{
+	int swapped;
+
+	/* We have a problem with CPLD rev 3. */
+	if (BCSR_WHOAMI_CPLD(bcsr_read(BCSR_WHOAMI)) <= 3) {
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "Pb1200 must be at CPLD rev 4. Please have Pb1200\n");
+		printk(KERN_ERR "updated to latest revision. This software will\n");
+		printk(KERN_ERR "not work on anything less than CPLD rev 4.\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		printk(KERN_ERR "WARNING!!!\n");
+		panic("Game over.  Your score is 0.");
+	}
+
+	irq_set_irq_type(AU1200_GPIO7_INT, IRQF_TRIGGER_LOW);
+	bcsr_init_irq(PB1200_INT_BEGIN, PB1200_INT_END, AU1200_GPIO7_INT);
+
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
+		PB1200_PC0_INT, PB1200_PC0_INSERT_INT,
+		/*PB1200_PC0_STSCHG_INT*/0, PB1200_PC0_EJECT_INT, 0);
+
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008000000,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008000000,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008000000,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008010000 - 1,
+		PB1200_PC1_INT, PB1200_PC1_INSERT_INT,
+		/*PB1200_PC1_STSCHG_INT*/0, PB1200_PC1_EJECT_INT, 1);
+
+	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1200_SWAPBOOT;
+	db1x_register_norflash(128 * 1024 * 1024, 2, swapped);
+
+	return platform_add_devices(board_platform_devices,
+				    ARRAY_SIZE(board_platform_devices));
+}
+device_initcall(board_register_devices);
+
+
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
diff --git a/arch/mips/alchemy/devboards/pb1200/Makefile b/arch/mips/alchemy/devboards/pb1200/Makefile
deleted file mode 100644
index 18c1bd5..0000000
--- a/arch/mips/alchemy/devboards/pb1200/Makefile
+++ /dev/null
@@ -1,5 +0,0 @@
-#
-# Makefile for the Alchemy Semiconductor Pb1200/DBAu1200 boards.
-#
-
-obj-y := board_setup.o platform.o
diff --git a/arch/mips/alchemy/devboards/pb1200/board_setup.c b/arch/mips/alchemy/devboards/pb1200/board_setup.c
deleted file mode 100644
index 6d06b07..0000000
--- a/arch/mips/alchemy/devboards/pb1200/board_setup.c
+++ /dev/null
@@ -1,174 +0,0 @@
-/*
- *
- * BRIEF MODULE DESCRIPTION
- *	Alchemy Pb1200/Db1200 board setup.
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/interrupt.h>
-#include <linux/sched.h>
-
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-db1x00/bcsr.h>
-
-#ifdef CONFIG_MIPS_PB1200
-#include <asm/mach-pb1x00/pb1200.h>
-#endif
-
-#ifdef CONFIG_MIPS_DB1200
-#include <asm/mach-db1x00/db1200.h>
-#define PB1200_INT_BEGIN DB1200_INT_BEGIN
-#define PB1200_INT_END DB1200_INT_END
-#endif
-
-#include <prom.h>
-
-const char *get_system_type(void)
-{
-	return "Alchemy Pb1200";
-}
-
-void __init board_setup(void)
-{
-	printk(KERN_INFO "AMD Alchemy Pb1200 Board\n");
-	bcsr_init(PB1200_BCSR_PHYS_ADDR,
-		  PB1200_BCSR_PHYS_ADDR + PB1200_BCSR_HEXLED_OFS);
-
-#if 0
-	{
-		u32 pin_func;
-
-		/*
-		 * Enable PSC1 SYNC for AC97.  Normaly done in audio driver,
-		 * but it is board specific code, so put it here.
-		 */
-		pin_func = au_readl(SYS_PINFUNC);
-		au_sync();
-		pin_func |= SYS_PF_MUST_BE_SET | SYS_PF_PSC1_S1;
-		au_writel(pin_func, SYS_PINFUNC);
-
-		au_writel(0, (u32)bcsr | 0x10); /* turn off PCMCIA power */
-		au_sync();
-	}
-#endif
-
-#if defined(CONFIG_I2C_AU1550)
-	{
-		u32 freq0, clksrc;
-		u32 pin_func;
-
-		/* Select SMBus in CPLD */
-		bcsr_mod(BCSR_RESETS, BCSR_RESETS_PSC0MUX, 0);
-
-		pin_func = au_readl(SYS_PINFUNC);
-		au_sync();
-		pin_func &= ~(SYS_PINFUNC_P0A | SYS_PINFUNC_P0B);
-		/* Set GPIOs correctly */
-		pin_func |= 2 << 17;
-		au_writel(pin_func, SYS_PINFUNC);
-		au_sync();
-
-		/* The I2C driver depends on 50 MHz clock */
-		freq0 = au_readl(SYS_FREQCTRL0);
-		au_sync();
-		freq0 &= ~(SYS_FC_FRDIV1_MASK | SYS_FC_FS1 | SYS_FC_FE1);
-		freq0 |= 3 << SYS_FC_FRDIV1_BIT;
-		/* 396 MHz / (3 + 1) * 2 == 49.5 MHz */
-		au_writel(freq0, SYS_FREQCTRL0);
-		au_sync();
-		freq0 |= SYS_FC_FE1;
-		au_writel(freq0, SYS_FREQCTRL0);
-		au_sync();
-
-		clksrc = au_readl(SYS_CLKSRC);
-		au_sync();
-		clksrc &= ~(SYS_CS_CE0 | SYS_CS_DE0 | SYS_CS_ME0_MASK);
-		/* Bit 22 is EXTCLK0 for PSC0 */
-		clksrc |= SYS_CS_MUX_FQ1 << SYS_CS_ME0_BIT;
-		au_writel(clksrc, SYS_CLKSRC);
-		au_sync();
-	}
-#endif
-
-	/*
-	 * The Pb1200 development board uses external MUX for PSC0 to
-	 * support SMB/SPI. bcsr_resets bit 12: 0=SMB 1=SPI
-	 */
-#ifdef CONFIG_I2C_AU1550
-	bcsr_mod(BCSR_RESETS, BCSR_RESETS_PSC0MUX, 0);
-#endif
-	au_sync();
-}
-
-static int __init pb1200_init_irq(void)
-{
-	/* We have a problem with CPLD rev 3. */
-	if (BCSR_WHOAMI_CPLD(bcsr_read(BCSR_WHOAMI)) <= 3) {
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "Pb1200 must be at CPLD rev 4. Please have Pb1200\n");
-		printk(KERN_ERR "updated to latest revision. This software will\n");
-		printk(KERN_ERR "not work on anything less than CPLD rev 4.\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		printk(KERN_ERR "WARNING!!!\n");
-		panic("Game over.  Your score is 0.");
-	}
-
-	irq_set_irq_type(AU1200_GPIO7_INT, IRQF_TRIGGER_LOW);
-	bcsr_init_irq(PB1200_INT_BEGIN, PB1200_INT_END, AU1200_GPIO7_INT);
-
-	return 0;
-}
-arch_initcall(pb1200_init_irq);
-
-
-int board_au1200fb_panel(void)
-{
-	return (bcsr_read(BCSR_SWITCHES) >> 8) & 0x0f;
-}
-
-int board_au1200fb_panel_init(void)
-{
-	/* Apply power */
-	bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
-				BCSR_BOARD_LCDBL);
-	/* printk(KERN_DEBUG "board_au1200fb_panel_init()\n"); */
-	return 0;
-}
-
-int board_au1200fb_panel_shutdown(void)
-{
-	/* Remove power */
-	bcsr_mod(BCSR_BOARD, BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
-			     BCSR_BOARD_LCDBL, 0);
-	/* printk(KERN_DEBUG "board_au1200fb_panel_shutdown()\n"); */
-	return 0;
-}
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
deleted file mode 100644
index 54f7f7b..0000000
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ /dev/null
@@ -1,339 +0,0 @@
-/*
- * Pb1200/DBAu1200 board platform device registration
- *
- * Copyright (C) 2008 MontaVista Software Inc. <source@mvista.com>
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/dma-mapping.h>
-#include <linux/init.h>
-#include <linux/leds.h>
-#include <linux/platform_device.h>
-#include <linux/smc91x.h>
-
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-au1x00/au1100_mmc.h>
-#include <asm/mach-au1x00/au1xxx_dbdma.h>
-#include <asm/mach-db1x00/bcsr.h>
-#include <asm/mach-pb1x00/pb1200.h>
-
-#include "../platform.h"
-
-static int mmc_activity;
-
-static void pb1200mmc0_set_power(void *mmc_host, int state)
-{
-	if (state)
-		bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_SD0PWR);
-	else
-		bcsr_mod(BCSR_BOARD, BCSR_BOARD_SD0PWR, 0);
-
-	msleep(1);
-}
-
-static int pb1200mmc0_card_readonly(void *mmc_host)
-{
-	return (bcsr_read(BCSR_STATUS) & BCSR_STATUS_SD0WP) ? 1 : 0;
-}
-
-static int pb1200mmc0_card_inserted(void *mmc_host)
-{
-	return (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD0INSERT) ? 1 : 0;
-}
-
-static void pb1200_mmcled_set(struct led_classdev *led,
-			enum led_brightness brightness)
-{
-	if (brightness != LED_OFF) {
-		if (++mmc_activity == 1)
-			bcsr_mod(BCSR_LEDS, BCSR_LEDS_LED0, 0);
-	} else {
-		if (--mmc_activity == 0)
-			bcsr_mod(BCSR_LEDS, 0, BCSR_LEDS_LED0);
-	}
-}
-
-static struct led_classdev pb1200mmc_led = {
-	.brightness_set	= pb1200_mmcled_set,
-};
-
-static void pb1200mmc1_set_power(void *mmc_host, int state)
-{
-	if (state)
-		bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_SD1PWR);
-	else
-		bcsr_mod(BCSR_BOARD, BCSR_BOARD_SD1PWR, 0);
-
-	msleep(1);
-}
-
-static int pb1200mmc1_card_readonly(void *mmc_host)
-{
-	return (bcsr_read(BCSR_STATUS) & BCSR_STATUS_SD1WP) ? 1 : 0;
-}
-
-static int pb1200mmc1_card_inserted(void *mmc_host)
-{
-	return (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD1INSERT) ? 1 : 0;
-}
-
-static struct au1xmmc_platform_data pb1200mmc_platdata[2] = {
-	[0] = {
-		.set_power	= pb1200mmc0_set_power,
-		.card_inserted	= pb1200mmc0_card_inserted,
-		.card_readonly	= pb1200mmc0_card_readonly,
-		.cd_setup	= NULL,		/* use poll-timer in driver */
-		.led		= &pb1200mmc_led,
-	},
-	[1] = {
-		.set_power	= pb1200mmc1_set_power,
-		.card_inserted	= pb1200mmc1_card_inserted,
-		.card_readonly	= pb1200mmc1_card_readonly,
-		.cd_setup	= NULL,		/* use poll-timer in driver */
-		.led		= &pb1200mmc_led,
-	},
-};
-
-static u64 au1xxx_mmc_dmamask =  DMA_BIT_MASK(32);
-
-static struct resource au1200_mmc0_res[] = {
-	[0] = {
-		.start	= AU1100_SD0_PHYS_ADDR,
-		.end	= AU1100_SD0_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1200_SD_INT,
-		.end	= AU1200_SD_INT,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AU1200_DSCR_CMD0_SDMS_TX0,
-		.end	= AU1200_DSCR_CMD0_SDMS_TX0,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= AU1200_DSCR_CMD0_SDMS_RX0,
-		.end	= AU1200_DSCR_CMD0_SDMS_RX0,
-		.flags	= IORESOURCE_DMA,
-	}
-};
-
-static struct platform_device pb1200_mmc0_dev = {
-	.name		= "au1xxx-mmc",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &au1xxx_mmc_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &pb1200mmc_platdata[0],
-	},
-	.num_resources	= ARRAY_SIZE(au1200_mmc0_res),
-	.resource	= au1200_mmc0_res,
-};
-
-static struct resource au1200_mmc1_res[] = {
-	[0] = {
-		.start	= AU1100_SD1_PHYS_ADDR,
-		.end	= AU1100_SD1_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1200_SD_INT,
-		.end	= AU1200_SD_INT,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AU1200_DSCR_CMD0_SDMS_TX1,
-		.end	= AU1200_DSCR_CMD0_SDMS_TX1,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= AU1200_DSCR_CMD0_SDMS_RX1,
-		.end	= AU1200_DSCR_CMD0_SDMS_RX1,
-		.flags	= IORESOURCE_DMA,
-	}
-};
-
-static struct platform_device pb1200_mmc1_dev = {
-	.name		= "au1xxx-mmc",
-	.id		= 1,
-	.dev = {
-		.dma_mask		= &au1xxx_mmc_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-		.platform_data		= &pb1200mmc_platdata[1],
-	},
-	.num_resources	= ARRAY_SIZE(au1200_mmc1_res),
-	.resource	= au1200_mmc1_res,
-};
-
-
-static struct resource ide_resources[] = {
-	[0] = {
-		.start	= IDE_PHYS_ADDR,
-		.end 	= IDE_PHYS_ADDR + IDE_PHYS_LEN - 1,
-		.flags	= IORESOURCE_MEM
-	},
-	[1] = {
-		.start	= IDE_INT,
-		.end	= IDE_INT,
-		.flags	= IORESOURCE_IRQ
-	},
-	[2] = {
-		.start	= AU1200_DSCR_CMD0_DMA_REQ1,
-		.end	= AU1200_DSCR_CMD0_DMA_REQ1,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-static u64 ide_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device ide_device = {
-	.name		= "au1200-ide",
-	.id		= 0,
-	.dev = {
-		.dma_mask 		= &ide_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(ide_resources),
-	.resource	= ide_resources
-};
-
-static struct smc91x_platdata smc_data = {
-	.flags	= SMC91X_NOWAIT | SMC91X_USE_16BIT,
-	.leda	= RPC_LED_100_10,
-	.ledb	= RPC_LED_TX_RX,
-};
-
-static struct resource smc91c111_resources[] = {
-	[0] = {
-		.name	= "smc91x-regs",
-		.start	= SMC91C111_PHYS_ADDR,
-		.end	= SMC91C111_PHYS_ADDR + 0xf,
-		.flags	= IORESOURCE_MEM
-	},
-	[1] = {
-		.start	= SMC91C111_INT,
-		.end	= SMC91C111_INT,
-		.flags	= IORESOURCE_IRQ
-	},
-};
-
-static struct platform_device smc91c111_device = {
-	.dev	= {
-		.platform_data	= &smc_data,
-	},
-	.name		= "smc91x",
-	.id		= -1,
-	.num_resources	= ARRAY_SIZE(smc91c111_resources),
-	.resource	= smc91c111_resources
-};
-
-static struct resource au1200_psc0_res[] = {
-	[0] = {
-		.start	= AU1550_PSC0_PHYS_ADDR,
-		.end	= AU1550_PSC0_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1200_PSC0_INT,
-		.end	= AU1200_PSC0_INT,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AU1200_DSCR_CMD0_PSC0_TX,
-		.end	= AU1200_DSCR_CMD0_PSC0_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= AU1200_DSCR_CMD0_PSC0_RX,
-		.end	= AU1200_DSCR_CMD0_PSC0_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-static struct platform_device pb1200_i2c_dev = {
-	.name		= "au1xpsc_smbus",
-	.id		= 0,	/* bus number */
-	.num_resources	= ARRAY_SIZE(au1200_psc0_res),
-	.resource	= au1200_psc0_res,
-};
-
-static struct resource au1200_lcd_res[] = {
-	[0] = {
-		.start	= AU1200_LCD_PHYS_ADDR,
-		.end	= AU1200_LCD_PHYS_ADDR + 0x800 - 1,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1200_LCD_INT,
-		.end	= AU1200_LCD_INT,
-		.flags	= IORESOURCE_IRQ,
-	}
-};
-
-static u64 au1200_lcd_dmamask = DMA_BIT_MASK(32);
-
-static struct platform_device au1200_lcd_dev = {
-	.name		= "au1200-lcd",
-	.id		= 0,
-	.dev = {
-		.dma_mask		= &au1200_lcd_dmamask,
-		.coherent_dma_mask	= DMA_BIT_MASK(32),
-	},
-	.num_resources	= ARRAY_SIZE(au1200_lcd_res),
-	.resource	= au1200_lcd_res,
-};
-
-static struct platform_device *board_platform_devices[] __initdata = {
-	&ide_device,
-	&smc91c111_device,
-	&pb1200_i2c_dev,
-	&pb1200_mmc0_dev,
-	&pb1200_mmc1_dev,
-	&au1200_lcd_dev,
-};
-
-static int __init board_register_devices(void)
-{
-	int swapped;
-
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-		PB1200_PC0_INT, PB1200_PC0_INSERT_INT,
-		/*PB1200_PC0_STSCHG_INT*/0, PB1200_PC0_EJECT_INT, 0);
-
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008000000,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008000000,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008000000,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008010000 - 1,
-		PB1200_PC1_INT, PB1200_PC1_INSERT_INT,
-		/*PB1200_PC1_STSCHG_INT*/0, PB1200_PC1_EJECT_INT, 1);
-
-	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1200_SWAPBOOT;
-	db1x_register_norflash(128 * 1024 * 1024, 2, swapped);
-
-	return platform_add_devices(board_platform_devices,
-				    ARRAY_SIZE(board_platform_devices));
-}
-device_initcall(board_register_devices);
diff --git a/arch/mips/alchemy/devboards/pb1500.c b/arch/mips/alchemy/devboards/pb1500.c
new file mode 100644
index 0000000..e7b807b
--- /dev/null
+++ b/arch/mips/alchemy/devboards/pb1500.c
@@ -0,0 +1,198 @@
+/*
+ * Pb1500 board support.
+ *
+ * Copyright (C) 2009 Manuel Lauss
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/gpio.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-db1x00/bcsr.h>
+#include <prom.h>
+#include "platform.h"
+
+const char *get_system_type(void)
+{
+	return "PB1500";
+}
+
+void __init board_setup(void)
+{
+	u32 pin_func;
+	u32 sys_freqctrl, sys_clksrc;
+
+	bcsr_init(DB1000_BCSR_PHYS_ADDR,
+		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
+
+	sys_clksrc = sys_freqctrl = pin_func = 0;
+	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
+	au_writel(8, SYS_AUXPLL);
+	alchemy_gpio1_input_enable();
+	udelay(100);
+
+	/* GPIO201 is input for PCMCIA card detect */
+	/* GPIO203 is input for PCMCIA interrupt request */
+	alchemy_gpio_direction_input(201);
+	alchemy_gpio_direction_input(203);
+
+#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
+
+	/* Zero and disable FREQ2 */
+	sys_freqctrl = au_readl(SYS_FREQCTRL0);
+	sys_freqctrl &= ~0xFFF00000;
+	au_writel(sys_freqctrl, SYS_FREQCTRL0);
+
+	/* zero and disable USBH/USBD clocks */
+	sys_clksrc = au_readl(SYS_CLKSRC);
+	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
+			SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
+	au_writel(sys_clksrc, SYS_CLKSRC);
+
+	sys_freqctrl = au_readl(SYS_FREQCTRL0);
+	sys_freqctrl &= ~0xFFF00000;
+
+	sys_clksrc = au_readl(SYS_CLKSRC);
+	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
+			SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
+
+	/* FREQ2 = aux/2 = 48 MHz */
+	sys_freqctrl |= (0 << SYS_FC_FRDIV2_BIT) | SYS_FC_FE2 | SYS_FC_FS2;
+	au_writel(sys_freqctrl, SYS_FREQCTRL0);
+
+	/*
+	 * Route 48MHz FREQ2 into USB Host and/or Device
+	 */
+	sys_clksrc |= SYS_CS_MUX_FQ2 << SYS_CS_MUH_BIT;
+	au_writel(sys_clksrc, SYS_CLKSRC);
+
+	pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_USB;
+	/* 2nd USB port is USB host */
+	pin_func |= SYS_PF_USB;
+	au_writel(pin_func, SYS_PINFUNC);
+#endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
+
+#ifdef CONFIG_PCI
+	{
+		void __iomem *base =
+				(void __iomem *)KSEG1ADDR(AU1500_PCI_PHYS_ADDR);
+		/* Setup PCI bus controller */
+		__raw_writel(0x00003fff, base + PCI_REG_CMEM);
+		__raw_writel(0xf0000000, base + PCI_REG_MWMASK_DEV);
+		__raw_writel(0, base + PCI_REG_MWBASE_REV_CCL);
+		__raw_writel(0x02a00356, base + PCI_REG_STATCMD);
+		__raw_writel(0x00003c04, base + PCI_REG_PARAM);
+		__raw_writel(0x00000008, base + PCI_REG_MBAR);
+		wmb();
+	}
+#endif
+
+	/* Enable sys bus clock divider when IDLE state or no bus activity. */
+	au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
+
+	/* Enable the RTC if not already enabled */
+	if (!(au_readl(0xac000028) & 0x20)) {
+		printk(KERN_INFO "enabling clock ...\n");
+		au_writel((au_readl(0xac000028) | 0x20), 0xac000028);
+	}
+	/* Put the clock in BCD mode */
+	if (au_readl(0xac00002c) & 0x4) { /* reg B */
+		au_writel(au_readl(0xac00002c) & ~0x4, 0xac00002c);
+		au_sync();
+	}
+}
+
+/******************************************************************************/
+
+static int pb1500_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+{
+	if ((slot < 12) || (slot > 13) || pin == 0)
+		return -1;
+	if (slot == 12)
+		return (pin == 1) ? AU1500_PCI_INTA : 0xff;
+	if (slot == 13) {
+		switch (pin) {
+		case 1: return AU1500_PCI_INTA;
+		case 2: return AU1500_PCI_INTB;
+		case 3: return AU1500_PCI_INTC;
+		case 4: return AU1500_PCI_INTD;
+		}
+	}
+	return -1;
+}
+
+static struct resource alchemy_pci_host_res[] = {
+	[0] = {
+		.start	= AU1500_PCI_PHYS_ADDR,
+		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct alchemy_pci_platdata pb1500_pci_pd = {
+	.board_map_irq	= pb1500_map_pci_irq,
+	.pci_cfg_set	= PCI_CONFIG_AEN | PCI_CONFIG_R2H | PCI_CONFIG_R1H |
+			  PCI_CONFIG_CH |
+#if defined(__MIPSEB__)
+			  PCI_CONFIG_SIC_HWA_DAT | PCI_CONFIG_SM,
+#else
+			  0,
+#endif
+};
+
+static struct platform_device pb1500_pci_host = {
+	.dev.platform_data = &pb1500_pci_pd,
+	.name		= "alchemy-pci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
+	.resource	= alchemy_pci_host_res,
+};
+
+static int __init pb1500_dev_init(void)
+{
+	int swapped;
+
+	irq_set_irq_type(AU1500_GPIO9_INT,   IRQF_TRIGGER_LOW);   /* CD0# */
+	irq_set_irq_type(AU1500_GPIO10_INT,  IRQF_TRIGGER_LOW);  /* CARD0 */
+	irq_set_irq_type(AU1500_GPIO11_INT,  IRQF_TRIGGER_LOW);  /* STSCHG0# */
+	irq_set_irq_type(AU1500_GPIO204_INT, IRQF_TRIGGER_HIGH);
+	irq_set_irq_type(AU1500_GPIO201_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO202_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO203_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1500_GPIO205_INT, IRQF_TRIGGER_LOW);
+
+	/* PCMCIA. single socket, identical to Pb1100 */
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
+		AU1500_GPIO11_INT, AU1500_GPIO9_INT,	 /* card / insert */
+		/*AU1500_GPIO10_INT*/0, 0, 0); /* stschg / eject / id */
+
+	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1000_SWAPBOOT;
+	db1x_register_norflash(64 * 1024 * 1024, 4, swapped);
+	platform_device_register(&pb1500_pci_host);
+
+	return 0;
+}
+arch_initcall(pb1500_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1500/Makefile b/arch/mips/alchemy/devboards/pb1500/Makefile
deleted file mode 100644
index e83b151..0000000
--- a/arch/mips/alchemy/devboards/pb1500/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-#
-#  Copyright 2000, 2001, 2008 MontaVista Software Inc.
-#  Author: MontaVista Software, Inc. <source@mvista.com>
-#
-# Makefile for the Alchemy Semiconductor Pb1500 board.
-#
-
-obj-y := board_setup.o platform.o
diff --git a/arch/mips/alchemy/devboards/pb1500/board_setup.c b/arch/mips/alchemy/devboards/pb1500/board_setup.c
deleted file mode 100644
index 37c1883..0000000
--- a/arch/mips/alchemy/devboards/pb1500/board_setup.c
+++ /dev/null
@@ -1,139 +0,0 @@
-/*
- * Copyright 2000, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/delay.h>
-#include <linux/gpio.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-db1x00/bcsr.h>
-
-#include <prom.h>
-
-const char *get_system_type(void)
-{
-	return "Alchemy Pb1500";
-}
-
-void __init board_setup(void)
-{
-	u32 pin_func;
-	u32 sys_freqctrl, sys_clksrc;
-
-	bcsr_init(DB1000_BCSR_PHYS_ADDR,
-		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
-
-	sys_clksrc = sys_freqctrl = pin_func = 0;
-	/* Set AUX clock to 12 MHz * 8 = 96 MHz */
-	au_writel(8, SYS_AUXPLL);
-	alchemy_gpio1_input_enable();
-	udelay(100);
-
-	/* GPIO201 is input for PCMCIA card detect */
-	/* GPIO203 is input for PCMCIA interrupt request */
-	alchemy_gpio_direction_input(201);
-	alchemy_gpio_direction_input(203);
-
-#if defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE)
-
-	/* Zero and disable FREQ2 */
-	sys_freqctrl = au_readl(SYS_FREQCTRL0);
-	sys_freqctrl &= ~0xFFF00000;
-	au_writel(sys_freqctrl, SYS_FREQCTRL0);
-
-	/* zero and disable USBH/USBD clocks */
-	sys_clksrc = au_readl(SYS_CLKSRC);
-	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
-			SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
-	au_writel(sys_clksrc, SYS_CLKSRC);
-
-	sys_freqctrl = au_readl(SYS_FREQCTRL0);
-	sys_freqctrl &= ~0xFFF00000;
-
-	sys_clksrc = au_readl(SYS_CLKSRC);
-	sys_clksrc &= ~(SYS_CS_CUD | SYS_CS_DUD | SYS_CS_MUD_MASK |
-			SYS_CS_CUH | SYS_CS_DUH | SYS_CS_MUH_MASK);
-
-	/* FREQ2 = aux/2 = 48 MHz */
-	sys_freqctrl |= (0 << SYS_FC_FRDIV2_BIT) | SYS_FC_FE2 | SYS_FC_FS2;
-	au_writel(sys_freqctrl, SYS_FREQCTRL0);
-
-	/*
-	 * Route 48MHz FREQ2 into USB Host and/or Device
-	 */
-	sys_clksrc |= SYS_CS_MUX_FQ2 << SYS_CS_MUH_BIT;
-	au_writel(sys_clksrc, SYS_CLKSRC);
-
-	pin_func = au_readl(SYS_PINFUNC) & ~SYS_PF_USB;
-	/* 2nd USB port is USB host */
-	pin_func |= SYS_PF_USB;
-	au_writel(pin_func, SYS_PINFUNC);
-#endif /* defined(CONFIG_USB_OHCI_HCD) || defined(CONFIG_USB_OHCI_HCD_MODULE) */
-
-#ifdef CONFIG_PCI
-	{
-		void __iomem *base =
-				(void __iomem *)KSEG1ADDR(AU1500_PCI_PHYS_ADDR);
-		/* Setup PCI bus controller */
-		__raw_writel(0x00003fff, base + PCI_REG_CMEM);
-		__raw_writel(0xf0000000, base + PCI_REG_MWMASK_DEV);
-		__raw_writel(0, base + PCI_REG_MWBASE_REV_CCL);
-		__raw_writel(0x02a00356, base + PCI_REG_STATCMD);
-		__raw_writel(0x00003c04, base + PCI_REG_PARAM);
-		__raw_writel(0x00000008, base + PCI_REG_MBAR);
-		wmb();
-	}
-#endif
-
-	/* Enable sys bus clock divider when IDLE state or no bus activity. */
-	au_writel(au_readl(SYS_POWERCTRL) | (0x3 << 5), SYS_POWERCTRL);
-
-	/* Enable the RTC if not already enabled */
-	if (!(au_readl(0xac000028) & 0x20)) {
-		printk(KERN_INFO "enabling clock ...\n");
-		au_writel((au_readl(0xac000028) | 0x20), 0xac000028);
-	}
-	/* Put the clock in BCD mode */
-	if (au_readl(0xac00002c) & 0x4) { /* reg B */
-		au_writel(au_readl(0xac00002c) & ~0x4, 0xac00002c);
-		au_sync();
-	}
-}
-
-static int __init pb1500_init_irq(void)
-{
-	irq_set_irq_type(AU1500_GPIO9_INT, IRQF_TRIGGER_LOW);   /* CD0# */
-	irq_set_irq_type(AU1500_GPIO10_INT, IRQF_TRIGGER_LOW);  /* CARD0 */
-	irq_set_irq_type(AU1500_GPIO11_INT, IRQF_TRIGGER_LOW);  /* STSCHG0# */
-	irq_set_irq_type(AU1500_GPIO204_INT, IRQF_TRIGGER_HIGH);
-	irq_set_irq_type(AU1500_GPIO201_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO202_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO203_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1500_GPIO205_INT, IRQF_TRIGGER_LOW);
-
-	return 0;
-}
-arch_initcall(pb1500_init_irq);
diff --git a/arch/mips/alchemy/devboards/pb1500/platform.c b/arch/mips/alchemy/devboards/pb1500/platform.c
deleted file mode 100644
index 1e52a01..0000000
--- a/arch/mips/alchemy/devboards/pb1500/platform.c
+++ /dev/null
@@ -1,94 +0,0 @@
-/*
- * Pb1500 board platform device registration
- *
- * Copyright (C) 2009 Manuel Lauss
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/dma-mapping.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-db1x00/bcsr.h>
-
-#include "../platform.h"
-
-static int pb1500_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
-{
-	if ((slot < 12) || (slot > 13) || pin == 0)
-		return -1;
-	if (slot == 12)
-		return (pin == 1) ? AU1500_PCI_INTA : 0xff;
-	if (slot == 13) {
-		switch (pin) {
-		case 1: return AU1500_PCI_INTA;
-		case 2: return AU1500_PCI_INTB;
-		case 3: return AU1500_PCI_INTC;
-		case 4: return AU1500_PCI_INTD;
-		}
-	}
-	return -1;
-}
-
-static struct resource alchemy_pci_host_res[] = {
-	[0] = {
-		.start	= AU1500_PCI_PHYS_ADDR,
-		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct alchemy_pci_platdata pb1500_pci_pd = {
-	.board_map_irq	= pb1500_map_pci_irq,
-	.pci_cfg_set	= PCI_CONFIG_AEN | PCI_CONFIG_R2H | PCI_CONFIG_R1H |
-			  PCI_CONFIG_CH |
-#if defined(__MIPSEB__)
-			  PCI_CONFIG_SIC_HWA_DAT | PCI_CONFIG_SM,
-#else
-			  0,
-#endif
-};
-
-static struct platform_device pb1500_pci_host = {
-	.dev.platform_data = &pb1500_pci_pd,
-	.name		= "alchemy-pci",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
-	.resource	= alchemy_pci_host_res,
-};
-
-static int __init pb1500_dev_init(void)
-{
-	int swapped;
-
-	/* PCMCIA. single socket, identical to Pb1100 */
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-		AU1500_GPIO11_INT, AU1500_GPIO9_INT,	 /* card / insert */
-		/*AU1500_GPIO10_INT*/0, 0, 0); /* stschg / eject / id */
-
-	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1000_SWAPBOOT;
-	db1x_register_norflash(64 * 1024 * 1024, 4, swapped);
-	platform_device_register(&pb1500_pci_host);
-
-	return 0;
-}
-arch_initcall(pb1500_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1550.c b/arch/mips/alchemy/devboards/pb1550.c
new file mode 100644
index 0000000..e4a00a5
--- /dev/null
+++ b/arch/mips/alchemy/devboards/pb1550.c
@@ -0,0 +1,178 @@
+/*
+ * Pb1550 board support.
+ *
+ * Copyright (C) 2009-2011 Manuel Lauss
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/mach-au1x00/gpio.h>
+#include <asm/mach-db1x00/bcsr.h>
+#include "platform.h"
+
+const char *get_system_type(void)
+{
+	return "PB1550";
+}
+
+void __init board_setup(void)
+{
+	u32 pin_func;
+
+	bcsr_init(PB1550_BCSR_PHYS_ADDR,
+		  PB1550_BCSR_PHYS_ADDR + PB1550_BCSR_HEXLED_OFS);
+
+	alchemy_gpio2_enable();
+
+	/*
+	 * Enable PSC1 SYNC for AC'97.  Normaly done in audio driver,
+	 * but it is board specific code, so put it here.
+	 */
+	pin_func = au_readl(SYS_PINFUNC);
+	au_sync();
+	pin_func |= SYS_PF_MUST_BE_SET | SYS_PF_PSC1_S1;
+	au_writel(pin_func, SYS_PINFUNC);
+
+	bcsr_write(BCSR_PCMCIA, 0);	/* turn off PCMCIA power */
+
+	printk(KERN_INFO "AMD Alchemy Pb1550 Board\n");
+}
+
+/******************************************************************************/
+
+static int pb1550_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+{
+	if ((slot < 12) || (slot > 13) || pin == 0)
+		return -1;
+	if (slot == 12) {
+		switch (pin) {
+		case 1: return AU1500_PCI_INTB;
+		case 2: return AU1500_PCI_INTC;
+		case 3: return AU1500_PCI_INTD;
+		case 4: return AU1500_PCI_INTA;
+		}
+	}
+	if (slot == 13) {
+		switch (pin) {
+		case 1: return AU1500_PCI_INTA;
+		case 2: return AU1500_PCI_INTB;
+		case 3: return AU1500_PCI_INTC;
+		case 4: return AU1500_PCI_INTD;
+		}
+	}
+	return -1;
+}
+
+static struct resource alchemy_pci_host_res[] = {
+	[0] = {
+		.start	= AU1500_PCI_PHYS_ADDR,
+		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct alchemy_pci_platdata pb1550_pci_pd = {
+	.board_map_irq	= pb1550_map_pci_irq,
+};
+
+static struct platform_device pb1550_pci_host = {
+	.dev.platform_data = &pb1550_pci_pd,
+	.name		= "alchemy-pci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
+	.resource	= alchemy_pci_host_res,
+};
+
+static struct resource au1550_psc2_res[] = {
+	[0] = {
+		.start	= AU1550_PSC2_PHYS_ADDR,
+		.end	= AU1550_PSC2_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1550_PSC2_INT,
+		.end	= AU1550_PSC2_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1550_DSCR_CMD0_PSC2_TX,
+		.end	= AU1550_DSCR_CMD0_PSC2_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1550_DSCR_CMD0_PSC2_RX,
+		.end	= AU1550_DSCR_CMD0_PSC2_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device pb1550_i2c_dev = {
+	.name		= "au1xpsc_smbus",
+	.id		= 0,	/* bus number */
+	.num_resources	= ARRAY_SIZE(au1550_psc2_res),
+	.resource	= au1550_psc2_res,
+};
+
+static int __init pb1550_dev_init(void)
+{
+	int swapped;
+
+	irq_set_irq_type(AU1550_GPIO0_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1550_GPIO1_INT, IRQF_TRIGGER_LOW);
+	irq_set_irq_type(AU1550_GPIO201_205_INT, IRQF_TRIGGER_HIGH);
+
+	/* enable both PCMCIA card irqs in the shared line */
+	alchemy_gpio2_enable_int(201);
+	alchemy_gpio2_enable_int(202);
+
+	/* Pb1550, like all others, also has statuschange irqs; however they're
+	* wired up on one of the Au1550's shared GPIO201_205 line, which also
+	* services the PCMCIA card interrupts.  So we ignore statuschange and
+	* use the GPIO201_205 exclusively for card interrupts, since a) pcmcia
+	* drivers are used to shared irqs and b) statuschange isn't really use-
+	* ful anyway.
+	*/
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
+		AU1550_GPIO201_205_INT, AU1550_GPIO0_INT, 0, 0, 0);
+
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008000000,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008000000,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008000000,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008010000 - 1,
+		AU1550_GPIO201_205_INT, AU1550_GPIO1_INT, 0, 0, 1);
+
+	swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_PB1550_SWAPBOOT;
+	db1x_register_norflash(128 * 1024 * 1024, 4, swapped);
+	platform_device_register(&pb1550_pci_host);
+	platform_device_register(&pb1550_i2c_dev);
+
+	return 0;
+}
+arch_initcall(pb1550_dev_init);
diff --git a/arch/mips/alchemy/devboards/pb1550/Makefile b/arch/mips/alchemy/devboards/pb1550/Makefile
deleted file mode 100644
index 9661b6e..0000000
--- a/arch/mips/alchemy/devboards/pb1550/Makefile
+++ /dev/null
@@ -1,8 +0,0 @@
-#
-#  Copyright 2000, 2008 MontaVista Software Inc.
-#  Author: MontaVista Software, Inc. <source@mvista.com>
-#
-# Makefile for the Alchemy Semiconductor Pb1550 board.
-#
-
-obj-y := board_setup.o platform.o
diff --git a/arch/mips/alchemy/devboards/pb1550/board_setup.c b/arch/mips/alchemy/devboards/pb1550/board_setup.c
deleted file mode 100644
index 0f62d1e..0000000
--- a/arch/mips/alchemy/devboards/pb1550/board_setup.c
+++ /dev/null
@@ -1,80 +0,0 @@
-/*
- *
- * BRIEF MODULE DESCRIPTION
- *	Alchemy Pb1550 board setup.
- *
- * Copyright 2000, 2008 MontaVista Software Inc.
- * Author: MontaVista Software, Inc. <source@mvista.com>
- *
- *  This program is free software; you can redistribute  it and/or modify it
- *  under  the terms of  the GNU General  Public License as published by the
- *  Free Software Foundation;  either version 2 of the  License, or (at your
- *  option) any later version.
- *
- *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
- *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
- *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
- *  NO  EVENT  SHALL   THE AUTHOR  BE    LIABLE FOR ANY   DIRECT, INDIRECT,
- *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
- *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
- *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
- *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
- *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
- *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
- *
- *  You should have received a copy of the  GNU General Public License along
- *  with this program; if not, write  to the Free Software Foundation, Inc.,
- *  675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#include <linux/init.h>
-#include <linux/interrupt.h>
-
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-pb1x00/pb1550.h>
-#include <asm/mach-db1x00/bcsr.h>
-#include <asm/mach-au1x00/gpio.h>
-
-#include <prom.h>
-
-const char *get_system_type(void)
-{
-	return "Alchemy Pb1550";
-}
-
-void __init board_setup(void)
-{
-	u32 pin_func;
-
-	bcsr_init(PB1550_BCSR_PHYS_ADDR,
-		  PB1550_BCSR_PHYS_ADDR + PB1550_BCSR_HEXLED_OFS);
-
-	alchemy_gpio2_enable();
-
-	/*
-	 * Enable PSC1 SYNC for AC'97.  Normaly done in audio driver,
-	 * but it is board specific code, so put it here.
-	 */
-	pin_func = au_readl(SYS_PINFUNC);
-	au_sync();
-	pin_func |= SYS_PF_MUST_BE_SET | SYS_PF_PSC1_S1;
-	au_writel(pin_func, SYS_PINFUNC);
-
-	bcsr_write(BCSR_PCMCIA, 0);	/* turn off PCMCIA power */
-
-	printk(KERN_INFO "AMD Alchemy Pb1550 Board\n");
-}
-
-static int __init pb1550_init_irq(void)
-{
-	irq_set_irq_type(AU1550_GPIO0_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1550_GPIO1_INT, IRQF_TRIGGER_LOW);
-	irq_set_irq_type(AU1550_GPIO201_205_INT, IRQF_TRIGGER_HIGH);
-
-	/* enable both PCMCIA card irqs in the shared line */
-	alchemy_gpio2_enable_int(201);
-	alchemy_gpio2_enable_int(202);
-
-	return 0;
-}
-arch_initcall(pb1550_init_irq);
diff --git a/arch/mips/alchemy/devboards/pb1550/platform.c b/arch/mips/alchemy/devboards/pb1550/platform.c
deleted file mode 100644
index a4604b8..0000000
--- a/arch/mips/alchemy/devboards/pb1550/platform.c
+++ /dev/null
@@ -1,140 +0,0 @@
-/*
- * Pb1550 board platform device registration
- *
- * Copyright (C) 2009 Manuel Lauss
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2 of the License, or
- * (at your option) any later version.
- *
- * This program is distributed in the hope that it will be useful,
- * but WITHOUT ANY WARRANTY; without even the implied warranty of
- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- * GNU General Public License for more details.
- *
- * You should have received a copy of the GNU General Public License
- * along with this program; if not, write to the Free Software
- * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
- */
-
-#include <linux/dma-mapping.h>
-#include <linux/init.h>
-#include <linux/platform_device.h>
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-au1x00/au1xxx_dbdma.h>
-#include <asm/mach-pb1x00/pb1550.h>
-#include <asm/mach-db1x00/bcsr.h>
-
-#include "../platform.h"
-
-static int pb1550_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
-{
-	if ((slot < 12) || (slot > 13) || pin == 0)
-		return -1;
-	if (slot == 12) {
-		switch (pin) {
-		case 1: return AU1500_PCI_INTB;
-		case 2: return AU1500_PCI_INTC;
-		case 3: return AU1500_PCI_INTD;
-		case 4: return AU1500_PCI_INTA;
-		}
-	}
-	if (slot == 13) {
-		switch (pin) {
-		case 1: return AU1500_PCI_INTA;
-		case 2: return AU1500_PCI_INTB;
-		case 3: return AU1500_PCI_INTC;
-		case 4: return AU1500_PCI_INTD;
-		}
-	}
-	return -1;
-}
-
-static struct resource alchemy_pci_host_res[] = {
-	[0] = {
-		.start	= AU1500_PCI_PHYS_ADDR,
-		.end	= AU1500_PCI_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-};
-
-static struct alchemy_pci_platdata pb1550_pci_pd = {
-	.board_map_irq	= pb1550_map_pci_irq,
-};
-
-static struct platform_device pb1550_pci_host = {
-	.dev.platform_data = &pb1550_pci_pd,
-	.name		= "alchemy-pci",
-	.id		= 0,
-	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
-	.resource	= alchemy_pci_host_res,
-};
-
-static struct resource au1550_psc2_res[] = {
-	[0] = {
-		.start	= AU1550_PSC2_PHYS_ADDR,
-		.end	= AU1550_PSC2_PHYS_ADDR + 0xfff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-		.start	= AU1550_PSC2_INT,
-		.end	= AU1550_PSC2_INT,
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= AU1550_DSCR_CMD0_PSC2_TX,
-		.end	= AU1550_DSCR_CMD0_PSC2_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= AU1550_DSCR_CMD0_PSC2_RX,
-		.end	= AU1550_DSCR_CMD0_PSC2_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-static struct platform_device pb1550_i2c_dev = {
-	.name		= "au1xpsc_smbus",
-	.id		= 0,	/* bus number */
-	.num_resources	= ARRAY_SIZE(au1550_psc2_res),
-	.resource	= au1550_psc2_res,
-};
-
-static int __init pb1550_dev_init(void)
-{
-	int swapped;
-
-	/* Pb1550, like all others, also has statuschange irqs; however they're
-	* wired up on one of the Au1550's shared GPIO201_205 line, which also
-	* services the PCMCIA card interrupts.  So we ignore statuschange and
-	* use the GPIO201_205 exclusively for card interrupts, since a) pcmcia
-	* drivers are used to shared irqs and b) statuschange isn't really use-
-	* ful anyway.
-	*/
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
-		AU1550_GPIO201_205_INT, AU1550_GPIO0_INT, 0, 0, 0);
-
-	db1x_register_pcmcia_socket(
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008000000,
-		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x008400000 - 1,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008000000,
-		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x008400000 - 1,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008000000,
-		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x008010000 - 1,
-		AU1550_GPIO201_205_INT, AU1550_GPIO1_INT, 0, 0, 1);
-
-	swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_PB1550_SWAPBOOT;
-	db1x_register_norflash(128 * 1024 * 1024, 4, swapped);
-	platform_device_register(&pb1550_pci_host);
-	platform_device_register(&pb1550_i2c_dev);
-
-	return 0;
-}
-arch_initcall(pb1550_dev_init);
-- 
1.7.7.1
