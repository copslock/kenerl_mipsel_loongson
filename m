Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 02 Nov 2009 21:22:04 +0100 (CET)
Received: from mail-ew0-f214.google.com ([209.85.219.214]:62106 "EHLO
	mail-ew0-f214.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S1493948AbZKBUV6 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 2 Nov 2009 21:21:58 +0100
Received: by ewy10 with SMTP id 10so6099690ewy.33
        for <linux-mips@linux-mips.org>; Mon, 02 Nov 2009 12:21:53 -0800 (PST)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer;
        bh=jqE/i+EX1H2jqDvIc0yyOdSOu5opdoYLTMsPvJM/yQY=;
        b=D5am/0sB1/5qix9pDbheafuwQz/UbQahgYwgE2FIypqQSAiBl4Hx3ZznDDS1ikcYBZ
         VmCljGOswt1HOHSvVrK1Ayd3JQ+gAdo+84WYghxmOpaSPpqg3er4rK1Nas2m3EqaoaAR
         DLmHF2mlbWwU4M7hwJiJ20jsUU+1fIxsBTWNA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        b=hARQSJIG5dKzy40yyscUEUxLtKy2pVgYiYfY5U5oGQ+ob1vUe3HeZxhpc7Nci5J12y
         Pmc8ABmYzzz2mgsZzucSaBhJzoHbNipyOLHLTvn/3LXYe0sJMx0jwWrLojT5qjyvxeJC
         YfEfgx2S6kmcNpUpj83MyNZ6fK/OSE8fN8Vog=
Received: by 10.216.91.13 with SMTP id g13mr376891wef.36.1257193313154;
        Mon, 02 Nov 2009 12:21:53 -0800 (PST)
Received: from localhost.localdomain (p5496F7DD.dip.t-dialin.net [84.150.247.221])
        by mx.google.com with ESMTPS id m5sm15375gve.11.2009.11.02.12.21.50
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Mon, 02 Nov 2009 12:21:52 -0800 (PST)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH 1/3] MIPS: Alchemy: extended DB1200 board support.
Date:	Mon,  2 Nov 2009 21:21:43 +0100
Message-Id: <1257193305-29996-1-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.5.1
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 24619
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Create own directory for DB1200 code and update it with new features.

- SPI support:
  - tmp121 temperature sensor
  - SPI flash on DB1200
- I2C support
  - NE1619 sensor
  - AT24 eeprom
- I2C/SPI can be selected at boot time via switch S6.8
- Carddetect IRQs for SD cards.
- gen_nand based NAND support.
- hexleds count sleep/wake transitions.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
Against mips-queue; also depends on patch "Alchemy: physmap-flash for
all devboards" to build properly.

 arch/mips/alchemy/common/reset.c                 |    3 -
 arch/mips/alchemy/devboards/Makefile             |    2 +-
 arch/mips/alchemy/devboards/db1200/Makefile      |    1 +
 arch/mips/alchemy/devboards/db1200/platform.c    |  510 ++++++++++++++++++++++
 arch/mips/alchemy/devboards/db1200/setup.c       |  137 ++++++
 arch/mips/alchemy/devboards/pb1200/board_setup.c |    9 -
 arch/mips/alchemy/devboards/pb1200/platform.c    |   34 --
 arch/mips/include/asm/mach-db1x00/db1200.h       |   33 +--
 8 files changed, 654 insertions(+), 75 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/db1200/Makefile
 create mode 100644 arch/mips/alchemy/devboards/db1200/platform.c
 create mode 100644 arch/mips/alchemy/devboards/db1200/setup.c

diff --git a/arch/mips/alchemy/common/reset.c b/arch/mips/alchemy/common/reset.c
index 4791011..266afd4 100644
--- a/arch/mips/alchemy/common/reset.c
+++ b/arch/mips/alchemy/common/reset.c
@@ -164,9 +164,6 @@ void au1000_halt(void)
 #ifdef CONFIG_MIPS_MIRAGE
 	gpio_direction_output(210, 1);
 #endif
-#ifdef CONFIG_MIPS_DB1200
-	au_writew(au_readw(0xB980001C) | (1 << 14), 0xB980001C);
-#endif
 #ifdef CONFIG_PM
 	au_sleep();
 
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index c74ef80..ecbd37f 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -11,7 +11,7 @@ obj-$(CONFIG_MIPS_PB1500)	+= pb1500/
 obj-$(CONFIG_MIPS_PB1550)	+= pb1550/
 obj-$(CONFIG_MIPS_DB1000)	+= db1x00/
 obj-$(CONFIG_MIPS_DB1100)	+= db1x00/
-obj-$(CONFIG_MIPS_DB1200)	+= pb1200/
+obj-$(CONFIG_MIPS_DB1200)	+= db1200/
 obj-$(CONFIG_MIPS_DB1500)	+= db1x00/
 obj-$(CONFIG_MIPS_DB1550)	+= db1x00/
 obj-$(CONFIG_MIPS_BOSPORUS)	+= db1x00/
diff --git a/arch/mips/alchemy/devboards/db1200/Makefile b/arch/mips/alchemy/devboards/db1200/Makefile
new file mode 100644
index 0000000..17840a5
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1200/Makefile
@@ -0,0 +1 @@
+obj-y += setup.o platform.o
diff --git a/arch/mips/alchemy/devboards/db1200/platform.c b/arch/mips/alchemy/devboards/db1200/platform.c
new file mode 100644
index 0000000..5a6ef8d
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1200/platform.c
@@ -0,0 +1,510 @@
+/*
+ * DBAu1200 board platform device registration
+ *
+ * Copyright (C) 2008-2009 Manuel Lauss
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
+
+#include <asm/mach-au1x00/au1100_mmc.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/mach-au1x00/au1550_spi.h>
+#include <asm/mach-db1x00/bcsr.h>
+#include <asm/mach-db1x00/db1200.h>
+
+#include "../platform.h"
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
+	{
+		/* AT24C04-10 I2C eeprom */
+		I2C_BOARD_INFO("24c04", 0x52),
+	},
+	{
+		/* Philips NE1619 temp/voltage sensor (adm1025 drv) */
+		I2C_BOARD_INFO("ne1619", 0x2d),
+	},
+	{
+		/* I2S audio codec WM8731 */
+		I2C_BOARD_INFO("wm8731", 0x1b),
+	},
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
+		.end 	= DB1200_IDE_PHYS_ADDR + DB1200_IDE_PHYS_LEN - 1,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= DB1200_IDE_INT,
+		.end	= DB1200_IDE_INT,
+		.flags	= IORESOURCE_IRQ,
+	}
+};
+
+static u64 ide_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device db1200_ide_dev = {
+	.name		= "au1200-ide",
+	.id		= 0,
+	.dev = {
+		.dma_mask 		= &ide_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
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
+/* needed by arch/mips/alchemy/common/platform.c */
+struct au1xmmc_platform_data au1xmmc_platdata[] = {
+	[0] = {
+		.cd_setup	= db1200_mmc_cd_setup,
+		.set_power	= db1200_mmc_set_power,
+		.card_inserted	= db1200_mmc_card_inserted,
+		.card_readonly	= db1200_mmc_card_readonly,
+		.led		= &db1200_mmc_led,
+	},
+};
+
+/**********************************************************************/
+
+static struct resource au1200_psc0_res[] = {
+	[0] = {
+		.start	= PSC0_PHYS_ADDR,
+		.end	= PSC0_PHYS_ADDR + 0x000fffff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_PSC0_INT,
+		.end	= AU1200_PSC0_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= DSCR_CMD0_PSC0_TX,
+		.end	= DSCR_CMD0_PSC0_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= DSCR_CMD0_PSC0_RX,
+		.end	= DSCR_CMD0_PSC0_RX,
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
+static u64 spi_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device db1200_spi_dev = {
+	.dev	= {
+		.dma_mask		= &spi_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+		.platform_data		= &db1200_spi_platdata,
+	},
+	.name		= "au1550-spi",
+	.id		= 0,	/* bus number */
+	.num_resources	= ARRAY_SIZE(au1200_psc0_res),
+	.resource	= au1200_psc0_res,
+};
+
+static struct platform_device *db1200_devs[] __initdata = {
+	NULL,		/* PSC0, selected by S6.8 */
+	&db1200_ide_dev,
+	&db1200_eth_dev,
+	&db1200_rtc_dev,
+	&db1200_nand_dev,
+};
+
+static int __init db1200_dev_init(void)
+{
+	unsigned long pfc;
+	unsigned short sw;
+	int swapped;
+
+	i2c_register_board_info(0, db1200_i2c_devs,
+				ARRAY_SIZE(db1200_i2c_devs));
+	spi_register_board_info(db1200_spi_devs,
+				ARRAY_SIZE(db1200_i2c_devs));
+
+	/* SWITCHES:	S6.8 I2C/SPI selector  (OFF=I2C  ON=SPI)
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
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
+				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
+				    PCMCIA_MEM_PSEUDO_PHYS,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
+				    PCMCIA_IO_PSEUDO_PHYS,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
+				    DB1200_PC0_INT,
+				    DB1200_PC0_INSERT_INT,
+				    /*DB1200_PC0_STSCHG_INT*/0,
+				    DB1200_PC0_EJECT_INT,
+				    0);
+
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS + 0x00400000,
+				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00440000 - 1,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00400000,
+				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00440000 - 1,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00400000,
+				    PCMCIA_IO_PSEUDO_PHYS   + 0x00401000 - 1,
+				    DB1200_PC1_INT,
+				    DB1200_PC1_INSERT_INT,
+				    /*DB1200_PC1_STSCHG_INT*/0,
+				    DB1200_PC1_EJECT_INT,
+				    1);
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
diff --git a/arch/mips/alchemy/devboards/db1200/setup.c b/arch/mips/alchemy/devboards/db1200/setup.c
new file mode 100644
index 0000000..a3458c0
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1200/setup.c
@@ -0,0 +1,137 @@
+/*
+ * Alchemy/AMD/RMI DB1200 board setup.
+ *
+ * Licensed under the terms outlined in the file COPYING in the root of
+ * this source archive.
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/io.h>
+#include <linux/kernel.h>
+#include <linux/pm.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-db1x00/bcsr.h>
+#include <asm/mach-db1x00/db1200.h>
+#include <asm/processor.h>
+#include <asm/reboot.h>
+
+const char *get_system_type(void)
+{
+	return "Alchemy Db1200";
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
+
+	pm_power_off = board_power_off;
+	_machine_halt = board_power_off;
+	_machine_restart = (void(*)(char *))board_reset;
+}
+
+/* use the hexleds to count the number of times the cpu has entered
+ * wait, the dots to indicate whether the CPU is currently idle or
+ * active (dots off = sleeping, dots on = working) for cases where
+ * the number doesn't change for a long(er) period of time.
+ */
+static void db1200_wait(void)
+{
+	__asm__("	.set	push			\n"
+		"	.set	mips3			\n"
+		"	.set	noreorder		\n"
+		"	cache	0x14, 0(%0)		\n"
+		"	cache	0x14, 32(%0)		\n"
+		"	cache	0x14, 64(%0)		\n"
+		/* dots off: we're about to call wait */
+		"	lui	$26, 0xb980		\n"
+		"	ori	$27, $0, 3		\n"
+		"	sb	$27, 0x18($26)		\n"
+		"	sync				\n"
+		"	nop				\n"
+		"	wait				\n"
+		"	nop				\n"
+		"	nop				\n"
+		"	nop				\n"
+		"	nop				\n"
+		"	nop				\n"
+		/* dots on: there's work to do, increment cntr */
+		"	lui	$26, 0xb980		\n"
+		"	sb	$0, 0x18($26)		\n"
+		"	lui	$26, 0xb9c0		\n"
+		"	lb	$27, 0($26)		\n"
+		"	addiu	$27, $27, 1		\n"
+		"	sb	$27, 0($26)		\n"
+		"	sync				\n"
+		"	.set	pop			\n"
+		: : "r" (db1200_wait));
+}
+
+static int __init db1200_arch_init(void)
+{
+	/* GPIO7 is low-level triggered CPLD cascade */
+	set_irq_type(AU1200_GPIO7_INT, IRQF_TRIGGER_LOW);
+	bcsr_init_irq(DB1200_INT_BEGIN, DB1200_INT_END, AU1200_GPIO7_INT);
+
+	/* do not autoenable these: CPLD has broken edge int handling,
+	 * and the CD handler setup requires manual enabling to work
+	 * around that.
+	 */
+	irq_to_desc(DB1200_SD0_INSERT_INT)->status |= IRQ_NOAUTOEN;
+	irq_to_desc(DB1200_SD0_EJECT_INT)->status |= IRQ_NOAUTOEN;
+
+	if (cpu_wait)
+		cpu_wait = db1200_wait;
+
+	return 0;
+}
+arch_initcall(db1200_arch_init);
diff --git a/arch/mips/alchemy/devboards/pb1200/board_setup.c b/arch/mips/alchemy/devboards/pb1200/board_setup.c
index e709b9e..906b6cd 100644
--- a/arch/mips/alchemy/devboards/pb1200/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1200/board_setup.c
@@ -60,16 +60,9 @@ void __init board_setup(void)
 {
 	char *argptr;
 
-#ifdef CONFIG_MIPS_PB1200
 	printk(KERN_INFO "AMD Alchemy Pb1200 Board\n");
 	bcsr_init(PB1200_BCSR_PHYS_ADDR,
 		  PB1200_BCSR_PHYS_ADDR + PB1200_BCSR_HEXLED_OFS);
-#endif
-#ifdef CONFIG_MIPS_DB1200
-	printk(KERN_INFO "AMD Alchemy Db1200 Board\n");
-	bcsr_init(DB1200_BCSR_PHYS_ADDR,
-		  DB1200_BCSR_PHYS_ADDR + DB1200_BCSR_HEXLED_OFS);
-#endif
 
 	argptr = prom_getcmdline();
 #ifdef CONFIG_SERIAL_8250_CONSOLE
@@ -151,7 +144,6 @@ void __init board_setup(void)
 
 static int __init pb1200_init_irq(void)
 {
-#ifdef CONFIG_MIPS_PB1200
 	/* We have a problem with CPLD rev 3. */
 	if (BCSR_WHOAMI_CPLD(bcsr_read(BCSR_WHOAMI)) <= 3) {
 		printk(KERN_ERR "WARNING!!!\n");
@@ -171,7 +163,6 @@ static int __init pb1200_init_irq(void)
 		printk(KERN_ERR "WARNING!!!\n");
 		panic("Game over.  Your score is 0.");
 	}
-#endif
 
 	set_irq_type(AU1200_GPIO7_INT, IRQF_TRIGGER_LOW);
 	bcsr_init_irq(PB1200_INT_BEGIN, PB1200_INT_END, AU1200_GPIO7_INT);
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index 736d647..14e889f 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -68,7 +68,6 @@ static struct led_classdev pb1200mmc_led = {
 	.brightness_set	= pb1200_mmcled_set,
 };
 
-#ifndef CONFIG_MIPS_DB1200
 static void pb1200mmc1_set_power(void *mmc_host, int state)
 {
 	if (state)
@@ -88,7 +87,6 @@ static int pb1200mmc1_card_inserted(void *mmc_host)
 {
 	return (bcsr_read(BCSR_SIGSTAT) & BCSR_INT_SD1INSERT) ? 1 : 0;
 }
-#endif
 
 const struct au1xmmc_platform_data au1xmmc_platdata[2] = {
 	[0] = {
@@ -98,7 +96,6 @@ const struct au1xmmc_platform_data au1xmmc_platdata[2] = {
 		.cd_setup	= NULL,		/* use poll-timer in driver */
 		.led		= &pb1200mmc_led,
 	},
-#ifndef CONFIG_MIPS_DB1200
 	[1] = {
 		.set_power	= pb1200mmc1_set_power,
 		.card_inserted	= pb1200mmc1_card_inserted,
@@ -106,7 +103,6 @@ const struct au1xmmc_platform_data au1xmmc_platdata[2] = {
 		.cd_setup	= NULL,		/* use poll-timer in driver */
 		.led		= &pb1200mmc_led,
 	},
-#endif
 };
 
 static struct resource ide_resources[] = {
@@ -174,7 +170,6 @@ static int __init board_register_devices(void)
 {
 	int swapped;
 
-#ifdef CONFIG_MIPS_PB1200
 	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
 				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
 				    PCMCIA_MEM_PSEUDO_PHYS,
@@ -198,38 +193,9 @@ static int __init board_register_devices(void)
 				    /*PB1200_PC1_STSCHG_INT*/0,
 				    PB1200_PC1_EJECT_INT,
 				    1);
-#else
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS,
-				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00040000 - 1,
-				    PCMCIA_MEM_PSEUDO_PHYS,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00040000 - 1,
-				    PCMCIA_IO_PSEUDO_PHYS,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00001000 - 1,
-				    DB1200_PC0_INT,
-				    DB1200_PC0_INSERT_INT,
-				    /*DB1200_PC0_STSCHG_INT*/0,
-				    DB1200_PC0_EJECT_INT,
-				    0);
-
-	db1x_register_pcmcia_socket(PCMCIA_ATTR_PSEUDO_PHYS + 0x00400000,
-				    PCMCIA_ATTR_PSEUDO_PHYS + 0x00440000 - 1,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00400000,
-				    PCMCIA_MEM_PSEUDO_PHYS  + 0x00440000 - 1,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00400000,
-				    PCMCIA_IO_PSEUDO_PHYS   + 0x00401000 - 1,
-				    DB1200_PC1_INT,
-				    DB1200_PC1_INSERT_INT,
-				    /*DB1200_PC1_STSCHG_INT*/0,
-				    DB1200_PC1_EJECT_INT,
-				    1);
-#endif
 
 	swapped = bcsr_read(BCSR_STATUS) &  BCSR_STATUS_DB1200_SWAPBOOT;
-#ifdef CONFIG_MIPS_PB1200
 	db1x_register_norflash(128 * 1024 * 1024, 2, swapped);
-#else
-	db1x_register_norflash(64 * 1024 * 1024, 2, swapped);
-#endif
 
 	return platform_add_devices(board_platform_devices,
 				    ARRAY_SIZE(board_platform_devices));
diff --git a/arch/mips/include/asm/mach-db1x00/db1200.h b/arch/mips/include/asm/mach-db1x00/db1200.h
index 52b1d84..3404248 100644
--- a/arch/mips/include/asm/mach-db1x00/db1200.h
+++ b/arch/mips/include/asm/mach-db1x00/db1200.h
@@ -28,24 +28,6 @@
 #include <asm/mach-au1x00/au1000.h>
 #include <asm/mach-au1x00/au1xxx_psc.h>
 
-#define DBDMA_AC97_TX_CHAN	DSCR_CMD0_PSC1_TX
-#define DBDMA_AC97_RX_CHAN	DSCR_CMD0_PSC1_RX
-#define DBDMA_I2S_TX_CHAN	DSCR_CMD0_PSC1_TX
-#define DBDMA_I2S_RX_CHAN	DSCR_CMD0_PSC1_RX
-
-/*
- * SPI and SMB are muxed on the DBAu1200 board.
- * Refer to board documentation.
- */
-#define SPI_PSC_BASE		PSC0_BASE_ADDR
-#define SMBUS_PSC_BASE		PSC0_BASE_ADDR
-/*
- * AC'97 and I2S are muxed on the DBAu1200 board.
- * Refer to board documentation.
- */
-#define AC97_PSC_BASE		PSC1_BASE_ADDR
-#define I2S_PSC_BASE		PSC1_BASE_ADDR
-
 /* Bit positions for the different interrupt sources */
 #define BCSR_INT_IDE		0x0001
 #define BCSR_INT_ETH		0x0002
@@ -62,17 +44,15 @@
 #define BCSR_INT_SD0INSERT	0x1000
 #define BCSR_INT_SD0EJECT	0x2000
 
-#define SMC91C111_PHYS_ADDR	0x19000300
-#define SMC91C111_INT		DB1200_ETH_INT
-
 #define IDE_PHYS_ADDR		0x18800000
 #define IDE_REG_SHIFT		5
-#define IDE_PHYS_LEN		(16 << IDE_REG_SHIFT)
-#define IDE_INT 		DB1200_IDE_INT
 #define IDE_DDMA_REQ		DSCR_CMD0_DMA_REQ1
 #define IDE_RQSIZE		128
 
-#define NAND_PHYS_ADDR		0x20000000
+#define DB1200_IDE_PHYS_ADDR	IDE_PHYS_ADDR
+#define DB1200_IDE_PHYS_LEN	(16 << IDE_REG_SHIFT)
+#define DB1200_ETH_PHYS_ADDR	0x19000300
+#define DB1200_NAND_PHYS_ADDR	0x20000000
 
 /*
  * External Interrupts for DBAu1200 as of 8/6/2004.
@@ -82,7 +62,7 @@
  *   Example: IDE bis pos is  = 64 - 64
  *            ETH bit pos is  = 65 - 64
  */
-enum external_pb1200_ints {
+enum external_db1200_ints {
 	DB1200_INT_BEGIN	= AU1000_MAX_INTR + 1,
 
 	DB1200_IDE_INT		= DB1200_INT_BEGIN,
@@ -103,7 +83,4 @@ enum external_pb1200_ints {
 	DB1200_INT_END		= DB1200_INT_BEGIN + 15,
 };
 
-/* NAND chip select */
-#define NAND_CS 1
-
 #endif /* __ASM_DB1200_H */
-- 
1.6.5.1
