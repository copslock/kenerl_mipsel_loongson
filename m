Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 07 Jun 2009 19:41:47 +0100 (WEST)
Received: from mail-fx0-f223.google.com ([209.85.220.223]:63501 "EHLO
	mail-fx0-f223.google.com" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20023099AbZFGSjW (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 7 Jun 2009 19:39:22 +0100
Received: by fxm23 with SMTP id 23so2654479fxm.0
        for <multiple recipients>; Sun, 07 Jun 2009 11:39:16 -0700 (PDT)
DKIM-Signature:	v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=KmhJYpitlRSf+V9ZaAJZ1h22QUb8inx0QfCkhnT5sSc=;
        b=Ze6pIJGy9FtB7GLXWuXbZCsPU9YTOAeLrCDcuaV9R9lFjFQOgt1jLpeHJuAVJ/zH+L
         kY6Juhtn2pYoBE5cyfeXBSFkOjQGAwjiwBH2xsvpV9rfMaB8uBgsp9u8jo+bNuyWMdiZ
         S4vWlAUtqRxum4O4x24uzOHhYYWKTlf9BBI4w=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=W0aggVH26tTe3I/IQA36tOR7bSudJ0nofl5g23gVaRAWWf1kDypo+GZfe2F4L1WM2x
         hhfrxIDk0ReFxa7Zu4RgUqC8TqZaB/OUPKgvfA9/jmPP1l1oT4B1c56ZAinDd5J86VUG
         FfNt8kXCw6YwqBIRhN2sMLT3bTdVPj4M/Ap30=
Received: by 10.86.57.9 with SMTP id f9mr6248008fga.57.1244399956803;
        Sun, 07 Jun 2009 11:39:16 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 12sm421510fgg.0.2009.06.07.11.39.15
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 07 Jun 2009 11:39:16 -0700 (PDT)
From:	Manuel Lauss <manuel.lauss@googlemail.com>
To:	Linux-MIPS <linux-mips@linux-mips.org>,
	Ralf Baechle <ralf@linux-mips.org>
Cc:	Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH 3/7] Alchemy: extended DB1200 board support.
Date:	Sun,  7 Jun 2009 20:39:00 +0200
Message-Id: <1244399944-29043-4-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.6.3.1
In-Reply-To: <1244399944-29043-3-git-send-email-manuel.lauss@gmail.com>
References: <1244399944-29043-1-git-send-email-manuel.lauss@gmail.com>
 <1244399944-29043-2-git-send-email-manuel.lauss@gmail.com>
 <1244399944-29043-3-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23323
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Create own directory for DB1200 code and update it with new features.

- SPI support
  - tmp121 temperature sensor
  - SPI flash on DB1200 (untested, mine doesn't have this chip)
- I2C support
  - NE1619 sensor
  - AT24 eeprom
- I2C/SPI can be selected at boot time via switch S6.8
- Carddetect IRQs for SD cards.
- gen_nand based NAND support.
- hexleds count sleep/wake transitions

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/alchemy/common/reset.c                 |    3 -
 arch/mips/alchemy/devboards/Makefile             |    2 +-
 arch/mips/alchemy/devboards/db1200/Makefile      |    1 +
 arch/mips/alchemy/devboards/db1200/platform.c    |  493 ++++++++++++++++++++++
 arch/mips/alchemy/devboards/db1200/setup.c       |  181 ++++++++
 arch/mips/alchemy/devboards/pb1200/board_setup.c |    5 -
 arch/mips/alchemy/devboards/pb1200/irqmap.c      |   19 +-
 arch/mips/alchemy/devboards/pb1200/platform.c    |    4 -
 arch/mips/include/asm/mach-db1x00/db1200.h       |   23 +-
 9 files changed, 680 insertions(+), 51 deletions(-)
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
index 730f9f2..ed2bd04 100644
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
index 0000000..cc3f663
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1200/platform.c
@@ -0,0 +1,493 @@
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
+#include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-au1x00/au1100_mmc.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/mach-au1x00/au1550_spi.h>
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
+		au_writeb(cmd, ioaddr);
+		au_sync();
+	}
+}
+
+static int au1200_nand_device_ready(struct mtd_info *mtd)
+{
+	return au_readl(MEM_STSTAT) & 1;
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
+		.hwcontrol	= 0,
+		.dev_ready	= au1200_nand_device_ready,
+		.select_chip	= 0,
+		.cmd_ctrl	= au1200_nand_cmd_ctrl,
+	},
+};
+
+static struct resource db1200_nand_res[] = {
+	[0] = {
+		.start	= 0x20000000,
+		.end	= 0x200000ff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device nand_dev = {
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
+static struct smc91x_platdata smc_data = {
+	.flags	= SMC91X_NOWAIT | SMC91X_USE_16BIT,
+	.leda	= RPC_LED_100_10,
+	.ledb	= RPC_LED_TX_RX,
+};
+
+static struct resource smc91x_res[] = {
+	[0] = {
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
+static struct platform_device smc91x_dev = {
+	.dev	= {
+		.platform_data	= &smc_data,
+	},
+	.name		= "smc91x",
+	.id		= -1,
+	.num_resources	= ARRAY_SIZE(smc91x_res),
+	.resource	= smc91x_res
+};
+
+/**********************************************************************/
+
+static struct resource ide_resources[] = {
+	[0] = {
+		.start	= IDE_PHYS_ADDR,
+		.end 	= IDE_PHYS_ADDR + IDE_PHYS_LEN - 1,
+		.flags	= IORESOURCE_MEM
+	},
+	[1] = {
+		.start	= IDE_INT,
+		.end	= IDE_INT,
+		.flags	= IORESOURCE_IRQ
+	}
+};
+
+static u64 ide_dmamask = DMA_32BIT_MASK;
+
+static struct platform_device ide_dev = {
+	.name		= "au1200-ide",
+	.id		= 0,
+	.dev = {
+		.dma_mask 		= &ide_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+	},
+	.num_resources	= ARRAY_SIZE(ide_resources),
+	.resource	= ide_resources
+};
+
+/**********************************************************************/
+
+static struct platform_device rtc_dev = {
+	.name	= "rtc-au1xxx",
+	.id	= -1,
+};
+
+/**********************************************************************/
+
+/* SD Carddetect irqs.  Although the manual says they're supposed to be
+ * edge, they stay asserted as long as the card is inserted/removed,
+ * regardless of how many times the bit gets acked.  So depending on
+ * which IRQ has triggered, one gets masked and the other unmasked.
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
+	/* account for modular mmc_core, to avoid link errors */
+	mmc_cd = symbol_get(mmc_detect_change);
+	if (mmc_cd) {
+		mmc_cd(ptr, msecs_to_jiffies(500));
+		symbol_put(mmc_detect_change);
+	}
+	return IRQ_HANDLED;
+}
+
+static int db1200_mmc_cd_setup(void *mmc_host, int en)
+{
+	unsigned long flags;
+	int ret;
+
+	/* kill irqs until both handlers have been registered, since one
+	 * will always trigger immediately and leave nasty warnings in
+	 * the kernel log.
+	 */
+	raw_local_irq_save(flags);
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
+		/* disable the one which is currently triggering;
+		 * the MMC layer will detect the card anyway.
+		 */
+		if (bcsr->sig_status & BCSR_INT_SD0INSERT)
+			disable_irq_nosync(DB1200_SD0_INSERT_INT);
+		else
+			disable_irq_nosync(DB1200_SD0_EJECT_INT);
+
+	} else {
+		free_irq(DB1200_SD0_INSERT_INT, mmc_host);
+		free_irq(DB1200_SD0_EJECT_INT, mmc_host);
+	}
+	ret = 0;
+out:
+	raw_local_irq_restore(flags);
+	return ret;
+}
+
+static void db1200_mmc_set_power(void *mmc_host, int state)
+{
+	if (state)
+		bcsr->board |= BCSR_BOARD_SD0PWR;
+	else
+		bcsr->board &= ~BCSR_BOARD_SD0PWR;
+
+	au_sync();
+	if (state)
+		msleep(400);	/* give card time to initialize */
+}
+
+static int db1200_mmc_card_readonly(void *mmc_host)
+{
+	return (bcsr->status & BCSR_STATUS_SD0WP) ? 1 : 0;
+}
+
+static int db1200_mmc_card_inserted(void *mmc_host)
+{
+	return (bcsr->sig_status & BCSR_INT_SD0INSERT) ? 1 : 0;
+}
+
+static void db1200_mmcled_set(struct led_classdev *led,
+			      enum led_brightness brightness)
+{
+	if (brightness != LED_OFF)
+		bcsr->disk_leds &= ~(1 << 8);
+	else
+		bcsr->disk_leds |= (1 << 8);
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
+static struct resource psc0_res[] = {
+	[0] = {
+		.start	= CPHYSADDR(PSC0_BASE_ADDR),
+		.end	= CPHYSADDR(PSC0_BASE_ADDR) + 0x000fffff,
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
+static struct platform_device i2c_dev = {
+	.name		= "au1xpsc_smbus",
+	.id		= 0,	/* bus number */
+	.num_resources	= ARRAY_SIZE(psc0_res),
+	.resource	= psc0_res,
+};
+
+static void db1200_spi_cs_en(struct au1550_spi_info *spi, int cs, int pol)
+{
+	if (cs)
+		bcsr->resets |= BCSR_RESETS_SPISEL;
+	else
+		bcsr->resets &= ~BCSR_RESETS_SPISEL;
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
+static struct platform_device spi_dev = {
+	.dev	= {
+		.dma_mask		= &spi_dmamask,
+		.coherent_dma_mask	= DMA_32BIT_MASK,
+		.platform_data		= &db1200_spi_platdata,
+	},
+	.name		= "au1550-spi",
+	.id		= 0,	/* bus number */
+	.num_resources	= ARRAY_SIZE(psc0_res),
+	.resource	= psc0_res,
+};
+
+static struct platform_device *db1200_devs[] __initdata = {
+	NULL,		/* PSC0, selected by S6.8 */
+	&ide_dev,
+	&smc91x_dev,
+	&rtc_dev,
+	&nand_dev,
+};
+
+static int __init db1200_dev_init(void)
+{
+	unsigned long pfc;
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
+	pfc = au_readl(SYS_PINFUNC) & ~SYS_PINFUNC_P0A;
+
+	/* switch off OTG VBUS supply */
+#ifdef CONFIG_GPIOLIB
+	gpio_request(215, "otg-vbus");
+#endif
+	gpio_direction_output(215, 1);
+
+	printk(KERN_INFO "DB1200 device configuration:\n");
+
+	if (bcsr->switches & BCSR_SWITCHES_DIP_8) {
+		db1200_devs[0] = &i2c_dev;
+		bcsr->resets &= ~BCSR_RESETS_PSC0MUX;
+
+		pfc |= (2 << 17);	/* GPIO2 block owns GPIO215 */
+
+		printk(KERN_INFO " S6.8 OFF: PSC0 mode I2C\n");
+		printk(KERN_INFO "   OTG port VBUS supply available!\n");
+	} else {
+		db1200_devs[0] = &spi_dev;
+		bcsr->resets |= BCSR_RESETS_PSC0MUX;
+
+		pfc |= (1 << 17);	/* PSC0 owns GPIO215 */
+
+		printk(KERN_INFO " S6.8 ON : PSC0 mode SPI\n");
+		printk(KERN_INFO "   OTG port VBUS supply disabled\n");
+	}
+	au_writel(pfc, SYS_PINFUNC);
+	au_sync();
+
+	return platform_add_devices(db1200_devs, ARRAY_SIZE(db1200_devs));
+}
+device_initcall(db1200_dev_init);
+
+/* au1200fb calls these */
+int board_au1200fb_panel(void)
+{
+	return ((bcsr->switches) >> 8) & 0xf;	/* rotary switch */
+}
+
+int board_au1200fb_panel_init(void)
+{
+	/* Apply power */
+	bcsr->board |= BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
+		       BCSR_BOARD_LCDBL;
+	return 0;
+}
+
+int board_au1200fb_panel_shutdown(void)
+{
+	/* Remove power */
+	bcsr->board &= ~(BCSR_BOARD_LCDVEE | BCSR_BOARD_LCDVDD |
+			 BCSR_BOARD_LCDBL);
+	return 0;
+}
diff --git a/arch/mips/alchemy/devboards/db1200/setup.c b/arch/mips/alchemy/devboards/db1200/setup.c
new file mode 100644
index 0000000..422b703
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1200/setup.c
@@ -0,0 +1,181 @@
+/*
+ * Alchemy/AMD/RMI DB1200 board setup.
+ *
+ * Licensed under the terms outlined in the file COPYING in the root of
+ * this source archive.
+ */
+
+#include <linux/init.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/pm.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-db1x00/db1200.h>
+#include <asm/processor.h>
+#include <asm/reboot.h>
+
+static void db1200_irq_cascade(unsigned int irq, struct irq_desc *desc)
+{
+	unsigned short bisr = bcsr->int_status;
+
+	while (bisr) {
+		generic_handle_irq(DB1200_INT_BEGIN + __ffs(bisr));
+		bisr &= bisr - 1;
+	}
+}
+
+/* both the enable (intset) and mask (inset_mask) bits must be modified,
+ * otherwise the CPLD triggers tons of spurious interrupts.
+ */
+static void db1200_mask_irq(unsigned int irq_nr)
+{
+	bcsr->intclr_mask = 1 << (irq_nr - DB1200_INT_BEGIN);
+	bcsr->intclr = 1 << (irq_nr - DB1200_INT_BEGIN);
+	au_sync();
+}
+
+static void db1200_maskack_irq(unsigned int irq_nr)
+{
+	bcsr->intclr_mask = 1 << (irq_nr - DB1200_INT_BEGIN);
+	bcsr->intclr = 1 << (irq_nr - DB1200_INT_BEGIN);
+	bcsr->int_status = 1 << (irq_nr - DB1200_INT_BEGIN);  /* ack */
+	au_sync();
+}
+
+static void db1200_unmask_irq(unsigned int irq_nr)
+{
+	bcsr->intset = 1 << (irq_nr - DB1200_INT_BEGIN);
+	bcsr->intset_mask = 1 << (irq_nr - DB1200_INT_BEGIN);
+	au_sync();
+}
+
+static struct irq_chip db1200_cpld_irq = {
+	.name		= "DB1200-CPLD",
+	.mask		= db1200_mask_irq,
+	.mask_ack	= db1200_maskack_irq,
+	.unmask		= db1200_unmask_irq,
+};
+
+void __init board_init_irq(void)
+{
+	unsigned int i;
+
+	/* mask & disable & ack all */
+	bcsr->intclr_mask = 0xffff;
+	bcsr->intclr = 0xffff;
+	bcsr->int_status = 0xffff;
+	au_sync();
+
+	for (i = DB1200_INT_BEGIN; i <= DB1200_INT_END; i++)
+		set_irq_chip_and_handler_name(i, &db1200_cpld_irq,
+					 handle_level_irq, "level");
+
+	/* GPIO7 is low-level triggered CPLD cascade */
+	set_irq_type(AU1000_GPIO_7, IRQF_TRIGGER_LOW);
+	set_irq_chained_handler(AU1000_GPIO_7, db1200_irq_cascade);
+}
+
+const char *get_system_type(void)
+{
+	return "Alchemy Db1200";
+}
+
+static void board_power_off(void)
+{
+	bcsr->resets = 0;
+	bcsr->system = BCSR_SYSTEM_POWEROFF | BCSR_SYSTEM_RESET;
+}
+
+void board_reset(void)
+{
+	bcsr->resets = 0;
+	bcsr->system = 0;
+}
+
+void __init board_setup(void)
+{
+	u32 freq0, clksrc, div;
+	u32 pfc;
+
+	printk(KERN_INFO "Alchemy/AMD/RMI DB1200 Board, CPLD Rev %d"
+		"  Board-ID %d  Daughtercard ID %d\n",
+		(bcsr->whoami >> 4) & 0xf, (bcsr->whoami >> 8) & 0xf,
+		bcsr->whoami & 0xf);
+
+	/* SMBus/SPI on PSC0, Audio on PSC1 */
+	pfc = au_readl(SYS_PINFUNC);
+	pfc &= ~(SYS_PINFUNC_P0A | SYS_PINFUNC_P0B);
+	pfc &= ~(SYS_PINFUNC_P1A | SYS_PINFUNC_P1B | SYS_PINFUNC_FS3);
+	pfc |= SYS_PINFUNC_P1C;	/* SPI is configured later */
+	au_writel(pfc, SYS_PINFUNC);
+	au_sync();
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
+	au_writel(freq0, SYS_FREQCTRL0);
+	au_sync();
+	freq0 |= SYS_FC_FE0;	/* enable F0 */
+	au_writel(freq0, SYS_FREQCTRL0);
+	au_sync();
+
+	/* psc0_intclk comes 1:1 from F0 */
+	clksrc = SYS_CS_MUX_FQ0 << SYS_CS_ME0_BIT;
+	au_writel(clksrc, SYS_CLKSRC);
+	au_sync();
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
+static int __init db1200_wait_init(void)
+{
+	if (cpu_wait)
+		cpu_wait = db1200_wait;
+	return 0;
+}
+arch_initcall(db1200_wait_init);
diff --git a/arch/mips/alchemy/devboards/pb1200/board_setup.c b/arch/mips/alchemy/devboards/pb1200/board_setup.c
index 94e6b7e..2829f45 100644
--- a/arch/mips/alchemy/devboards/pb1200/board_setup.c
+++ b/arch/mips/alchemy/devboards/pb1200/board_setup.c
@@ -123,12 +123,7 @@ void __init board_setup(void)
 #endif
 	au_sync();
 
-#ifdef CONFIG_MIPS_PB1200
 	printk(KERN_INFO "AMD Alchemy Pb1200 Board\n");
-#endif
-#ifdef CONFIG_MIPS_DB1200
-	printk(KERN_INFO "AMD Alchemy Db1200 Board\n");
-#endif
 }
 
 int board_au1200fb_panel(void)
diff --git a/arch/mips/alchemy/devboards/pb1200/irqmap.c b/arch/mips/alchemy/devboards/pb1200/irqmap.c
index fe47498..453e18b 100644
--- a/arch/mips/alchemy/devboards/pb1200/irqmap.c
+++ b/arch/mips/alchemy/devboards/pb1200/irqmap.c
@@ -27,16 +27,7 @@
 #include <linux/interrupt.h>
 
 #include <asm/mach-au1x00/au1000.h>
-
-#ifdef CONFIG_MIPS_PB1200
 #include <asm/mach-pb1x00/pb1200.h>
-#endif
-
-#ifdef CONFIG_MIPS_DB1200
-#include <asm/mach-db1x00/db1200.h>
-#define PB1200_INT_BEGIN DB1200_INT_BEGIN
-#define PB1200_INT_END DB1200_INT_END
-#endif
 
 struct au1xxx_irqmap __initdata au1xxx_irq_map[] = {
 	/* This is external interrupt cascade */
@@ -82,12 +73,7 @@ static void pb1200_unmask_irq(unsigned int irq_nr)
 }
 
 static struct irq_chip pb1200_cpld_irq_type = {
-#ifdef CONFIG_MIPS_PB1200
-	.name = "Pb1200 Ext",
-#endif
-#ifdef CONFIG_MIPS_DB1200
-	.name = "Db1200 Ext",
-#endif
+	.name		= "Pb1200 Ext",
 	.mask		= pb1200_mask_irq,
 	.mask_ack	= pb1200_maskack_irq,
 	.unmask		= pb1200_unmask_irq,
@@ -99,7 +85,6 @@ void __init board_init_irq(void)
 
 	au1xxx_setup_irqmap(au1xxx_irq_map, ARRAY_SIZE(au1xxx_irq_map));
 
-#ifdef CONFIG_MIPS_PB1200
 	/* We have a problem with CPLD rev 3. */
 	if (((bcsr->whoami & BCSR_WHOAMI_CPLD) >> 4) <= 3) {
 		printk(KERN_ERR "WARNING!!!\n");
@@ -119,7 +104,7 @@ void __init board_init_irq(void)
 		printk(KERN_ERR "WARNING!!!\n");
 		panic("Game over.  Your score is 0.");
 	}
-#endif
+
 	/* mask & disable & ack all */
 	bcsr->intclr_mask = 0xffff;
 	bcsr->intclr = 0xffff;
diff --git a/arch/mips/alchemy/devboards/pb1200/platform.c b/arch/mips/alchemy/devboards/pb1200/platform.c
index b93dff4..4d6edd8 100644
--- a/arch/mips/alchemy/devboards/pb1200/platform.c
+++ b/arch/mips/alchemy/devboards/pb1200/platform.c
@@ -65,7 +65,6 @@ static struct led_classdev pb1200mmc_led = {
 	.brightness_set	= pb1200_mmcled_set,
 };
 
-#ifndef CONFIG_MIPS_DB1200
 static void pb1200mmc1_set_power(void *mmc_host, int state)
 {
 	if (state)
@@ -85,7 +84,6 @@ static int pb1200mmc1_card_inserted(void *mmc_host)
 {
 	return (bcsr->sig_status & BCSR_INT_SD1INSERT) ? 1 : 0;
 }
-#endif
 
 const struct au1xmmc_platform_data au1xmmc_platdata[2] = {
 	[0] = {
@@ -95,7 +93,6 @@ const struct au1xmmc_platform_data au1xmmc_platdata[2] = {
 		.cd_setup	= NULL,		/* use poll-timer in driver */
 		.led		= &pb1200mmc_led,
 	},
-#ifndef CONFIG_MIPS_DB1200
 	[1] = {
 		.set_power	= pb1200mmc1_set_power,
 		.card_inserted	= pb1200mmc1_card_inserted,
@@ -103,7 +100,6 @@ const struct au1xmmc_platform_data au1xmmc_platdata[2] = {
 		.cd_setup	= NULL,		/* use poll-timer in driver */
 		.led		= &pb1200mmc_led,
 	},
-#endif
 };
 
 static struct resource ide_resources[] = {
diff --git a/arch/mips/include/asm/mach-db1x00/db1200.h b/arch/mips/include/asm/mach-db1x00/db1200.h
index 27f2610..2a54103 100644
--- a/arch/mips/include/asm/mach-db1x00/db1200.h
+++ b/arch/mips/include/asm/mach-db1x00/db1200.h
@@ -25,25 +25,6 @@
 #define __ASM_DB1200_H
 
 #include <linux/types.h>
-#include <asm/mach-au1x00/au1xxx_psc.h>
-
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
 
 #define BCSR_KSEG1_ADDR 	0xB9800000
 
@@ -123,8 +104,8 @@ static BCSR * const bcsr = (BCSR *)BCSR_KSEG1_ADDR;
 #define BCSR_RESETS_TV		0x0010
 /* Not resets but in the same register */
 #define BCSR_RESETS_PWMR1MUX	0x0800
-#define BCSR_RESETS_PCS0MUX	0x1000
-#define BCSR_RESETS_PCS1MUX	0x2000
+#define BCSR_RESETS_PSC0MUX	0x1000
+#define BCSR_RESETS_PSC1MUX	0x2000
 #define BCSR_RESETS_SPISEL	0x4000
 
 #define BCSR_PCMCIA_PC0VPP	0x0003
-- 
1.6.3.1
