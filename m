Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Apr 2009 14:02:27 +0100 (BST)
Received: from fnoeppeil48.netpark.at ([217.175.205.176]:17877 "EHLO
	roarinelk.homelinux.net") by ftp.linux-mips.org with ESMTP
	id S20024182AbZDINCT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 9 Apr 2009 14:02:19 +0100
Received: (qmail 32597 invoked from network); 9 Apr 2009 15:02:18 +0200
Received: from scarran.roarinelk.net (HELO localhost.localdomain) (192.168.0.242)
  by 192.168.0.1 with SMTP; 9 Apr 2009 15:02:18 +0200
From:	Manuel Lauss <mano@roarinelk.homelinux.net>
To:	Linux-MIPS <linux-mips@linux-mips.org>
Cc:	Manuel Lauss <mano@roarinelk.homelinux.net>
Subject: [PATCH] Alchemy: extended DB1200 board support.
Date:	Thu,  9 Apr 2009 15:02:17 +0200
Message-Id: <1239282137-15051-1-git-send-email-mano@roarinelk.homelinux.net>
X-Mailer: git-send-email 1.6.2
Return-Path: <mano@roarinelk.homelinux.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22309
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mano@roarinelk.homelinux.net
Precedence: bulk
X-list: linux-mips

Create own directory for DB1200 code and update it with new features.

- SPI support
  - tmp121 temperature sensor
  - SPI flash on DB1200 (untested, mine doesn't have this chip)
- I2C support
  - NE1619 sensor
  - AT24 eeprom
- Audio AC97 and I2S (I2S requires I2C)
- I2C/SPI and AC97/I2S can be selected at boot time via switches
  S6.8 and S6.7
- Carddetect IRQs for SD cards.
- gen_nand based NAND support.
- hexleds count sleep/wake transitions
- defconfig update

Signed-off-by: Manuel Lauss <mano@roarinelk.homelinux.net>
---
 arch/mips/alchemy/devboards/Makefile             |    2 +-
 arch/mips/alchemy/devboards/db1200/Makefile      |    1 +
 arch/mips/alchemy/devboards/db1200/platform.c    |  492 ++++++++
 arch/mips/alchemy/devboards/db1200/setup.c       |  186 +++
 arch/mips/alchemy/devboards/pb1200/board_setup.c |    5 -
 arch/mips/alchemy/devboards/pb1200/irqmap.c      |   19 +-
 arch/mips/alchemy/devboards/pb1200/platform.c    |    4 -
 arch/mips/configs/db1200_defconfig               | 1469 +++++++++++++---------
 arch/mips/include/asm/mach-db1x00/db1200.h       |   23 +-
 sound/soc/au1x/Kconfig                           |   10 +-
 sound/soc/au1x/Makefile                          |    4 +-
 sound/soc/au1x/db1200.c                          |  192 +++
 sound/soc/au1x/sample-ac97.c                     |  144 ---
 13 files changed, 1735 insertions(+), 816 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/db1200/Makefile
 create mode 100644 arch/mips/alchemy/devboards/db1200/platform.c
 create mode 100644 arch/mips/alchemy/devboards/db1200/setup.c
 create mode 100644 sound/soc/au1x/db1200.c
 delete mode 100644 sound/soc/au1x/sample-ac97.c

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
index 0000000..f4e8299
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1200/platform.c
@@ -0,0 +1,492 @@
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
+	 *		S6.7 AC97/I2S selector (OFF=AC97 ON=I2S)
+	 */
+
+	/* suck: GPIO215 drives the USB-device port power supply enable pin AND
+	 * acts as MOSI signal for PSC0 in SPI mode.  So selecting SPI means
+	 * no power for bus-powered devices on J10 (unless you continuously send
+	 * zeros over the SPI MOSI line ;-) ).
+	 */
+	pfc = au_readl(SYS_PINFUNC) & ~SYS_PINFUNC_P0A;
+
+	printk(KERN_INFO "DB1200 device configuration:\n");
+
+	if (bcsr->switches & BCSR_SWITCHES_DIP_8) {
+		db1200_devs[0] = &i2c_dev;
+		bcsr->resets &= ~BCSR_RESETS_PSC0MUX;
+
+		pfc |= (2 << 17);	/* GPIO2 block owns GPIO215 */
+
+		printk(KERN_INFO " S6.8 OFF: I2C  ENABLED  SPI disabled\n");
+	} else {
+		db1200_devs[0] = &spi_dev;
+		bcsr->resets |= BCSR_RESETS_PSC0MUX;
+
+		pfc |= (1 << 17);	/* PSC0 owns GPIO215 */
+
+		printk(KERN_INFO " S6.8 ON : I2C  disabled SPI ENABLED\n");
+	}
+	au_writel(pfc, SYS_PINFUNC);
+	au_sync();
+
+	/* audio is handled in sound/soc/au1x/db1200.c;
+	 * however we need I2C to talk to I2S codec.
+	 */
+	if ((bcsr->switches & 3) == BCSR_SWITCHES_DIP_8)
+		printk(KERN_INFO " S6.7 ON : AC97 disabled I2S ENABLED\n");
+	else
+		printk(KERN_INFO " S6.7 OFF: AC97 ENABLED  I2S disabled\n");
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
index 0000000..4c86a8a
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1200/setup.c
@@ -0,0 +1,186 @@
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
+extern int allow_au1k_wait;
+
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
+	if (!allow_au1k_wait)
+		return;
+
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
+	cpu_wait = db1200_wait;
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
index 0d68e19..98e64c2 100644
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
diff --git a/arch/mips/configs/db1200_defconfig b/arch/mips/configs/db1200_defconfig
index ab17973..f8f684f 100644
--- a/arch/mips/configs/db1200_defconfig
+++ b/arch/mips/configs/db1200_defconfig
@@ -1,79 +1,96 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.20
-# Tue Feb 20 21:47:25 2007
+# Linux kernel version: 2.6.29
+# Thu Apr  9 14:50:44 2009
 #
 CONFIG_MIPS=y
 
 #
 # Machine selection
 #
-CONFIG_ZONE_DMA=y
 CONFIG_MACH_ALCHEMY=y
-# CONFIG_MIPS_MTX1 is not set
-# CONFIG_MIPS_BOSPORUS is not set
-# CONFIG_MIPS_PB1000 is not set
-# CONFIG_MIPS_PB1100 is not set
-# CONFIG_MIPS_PB1500 is not set
-# CONFIG_MIPS_PB1550 is not set
-# CONFIG_MIPS_PB1200 is not set
-# CONFIG_MIPS_DB1000 is not set
-# CONFIG_MIPS_DB1100 is not set
-# CONFIG_MIPS_DB1500 is not set
-# CONFIG_MIPS_DB1550 is not set
-CONFIG_MIPS_DB1200=y
-# CONFIG_MIPS_MIRAGE is not set
 # CONFIG_BASLER_EXCITE is not set
+# CONFIG_BCM47XX is not set
 # CONFIG_MIPS_COBALT is not set
 # CONFIG_MACH_DECSTATION is not set
 # CONFIG_MACH_JAZZ is not set
+# CONFIG_LASAT is not set
+# CONFIG_LEMOTE_FULONG is not set
 # CONFIG_MIPS_MALTA is not set
-# CONFIG_WR_PPMC is not set
 # CONFIG_MIPS_SIM is not set
-# CONFIG_MOMENCO_JAGUAR_ATX is not set
-# CONFIG_MIPS_XXS1500 is not set
+# CONFIG_NEC_MARKEINS is not set
+# CONFIG_MACH_VR41XX is not set
+# CONFIG_NXP_STB220 is not set
+# CONFIG_NXP_STB225 is not set
 # CONFIG_PNX8550_JBS is not set
 # CONFIG_PNX8550_STB810 is not set
-# CONFIG_MACH_VR41XX is not set
+# CONFIG_PMC_MSP is not set
 # CONFIG_PMC_YOSEMITE is not set
-# CONFIG_MARKEINS is not set
 # CONFIG_SGI_IP22 is not set
 # CONFIG_SGI_IP27 is not set
+# CONFIG_SGI_IP28 is not set
 # CONFIG_SGI_IP32 is not set
-# CONFIG_SIBYTE_BIGSUR is not set
-# CONFIG_SIBYTE_SWARM is not set
-# CONFIG_SIBYTE_SENTOSA is not set
-# CONFIG_SIBYTE_RHONE is not set
-# CONFIG_SIBYTE_CARMEL is not set
-# CONFIG_SIBYTE_LITTLESUR is not set
 # CONFIG_SIBYTE_CRHINE is not set
+# CONFIG_SIBYTE_CARMEL is not set
 # CONFIG_SIBYTE_CRHONE is not set
+# CONFIG_SIBYTE_RHONE is not set
+# CONFIG_SIBYTE_SWARM is not set
+# CONFIG_SIBYTE_LITTLESUR is not set
+# CONFIG_SIBYTE_SENTOSA is not set
+# CONFIG_SIBYTE_BIGSUR is not set
 # CONFIG_SNI_RM is not set
-# CONFIG_TOSHIBA_JMR3927 is not set
-# CONFIG_TOSHIBA_RBTX4927 is not set
-# CONFIG_TOSHIBA_RBTX4938 is not set
+# CONFIG_MACH_TX39XX is not set
+# CONFIG_MACH_TX49XX is not set
+# CONFIG_MIKROTIK_RB532 is not set
+# CONFIG_WR_PPMC is not set
+# CONFIG_CAVIUM_OCTEON_SIMULATOR is not set
+# CONFIG_CAVIUM_OCTEON_REFERENCE_BOARD is not set
+# CONFIG_MIPS_MTX1 is not set
+# CONFIG_MIPS_BOSPORUS is not set
+# CONFIG_MIPS_DB1000 is not set
+# CONFIG_MIPS_DB1100 is not set
+CONFIG_MIPS_DB1200=y
+# CONFIG_MIPS_DB1500 is not set
+# CONFIG_MIPS_DB1550 is not set
+# CONFIG_MIPS_MIRAGE is not set
+# CONFIG_MIPS_PB1000 is not set
+# CONFIG_MIPS_PB1100 is not set
+# CONFIG_MIPS_PB1200 is not set
+# CONFIG_MIPS_PB1500 is not set
+# CONFIG_MIPS_PB1550 is not set
+# CONFIG_MIPS_XXS1500 is not set
+CONFIG_SOC_AU1200=y
+CONFIG_SOC_AU1X00=y
 CONFIG_RWSEM_GENERIC_SPINLOCK=y
 # CONFIG_ARCH_HAS_ILOG2_U32 is not set
 # CONFIG_ARCH_HAS_ILOG2_U64 is not set
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
 CONFIG_GENERIC_FIND_NEXT_BIT=y
 CONFIG_GENERIC_HWEIGHT=y
 CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
 CONFIG_GENERIC_TIME=y
-CONFIG_SCHED_NO_NO_OMIT_FRAME_POINTER=y
-# CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ is not set
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
+CONFIG_CEVT_R4K_LIB=y
+CONFIG_CSRC_R4K_LIB=y
 CONFIG_DMA_COHERENT=y
+# CONFIG_HOTPLUG_CPU is not set
 CONFIG_MIPS_DISABLE_OBSOLETE_IDE=y
+# CONFIG_NO_IOPORT is not set
+CONFIG_GENERIC_GPIO=y
 # CONFIG_CPU_BIG_ENDIAN is not set
 CONFIG_CPU_LITTLE_ENDIAN=y
 CONFIG_SYS_SUPPORTS_APM_EMULATION=y
 CONFIG_SYS_SUPPORTS_LITTLE_ENDIAN=y
-CONFIG_SOC_AU1200=y
-CONFIG_SOC_AU1X00=y
+CONFIG_IRQ_CPU=y
 CONFIG_MIPS_L1_CACHE_SHIFT=5
 
 #
 # CPU selection
 #
+# CONFIG_CPU_LOONGSON2 is not set
 CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_MIPS32_R2 is not set
 # CONFIG_CPU_MIPS64_R1 is not set
@@ -86,6 +103,7 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_TX49XX is not set
 # CONFIG_CPU_R5000 is not set
 # CONFIG_CPU_R5432 is not set
+# CONFIG_CPU_R5500 is not set
 # CONFIG_CPU_R6000 is not set
 # CONFIG_CPU_NEVADA is not set
 # CONFIG_CPU_R8000 is not set
@@ -93,11 +111,13 @@ CONFIG_CPU_MIPS32_R1=y
 # CONFIG_CPU_RM7000 is not set
 # CONFIG_CPU_RM9000 is not set
 # CONFIG_CPU_SB1 is not set
+# CONFIG_CPU_CAVIUM_OCTEON is not set
 CONFIG_SYS_HAS_CPU_MIPS32_R1=y
 CONFIG_CPU_MIPS32=y
 CONFIG_CPU_MIPSR1=y
 CONFIG_SYS_SUPPORTS_32BIT_KERNEL=y
 CONFIG_CPU_SUPPORTS_32BIT_KERNEL=y
+CONFIG_HARDWARE_WATCHPOINTS=y
 
 #
 # Kernel type
@@ -112,7 +132,6 @@ CONFIG_CPU_HAS_PREFETCH=y
 CONFIG_MIPS_MT_DISABLED=y
 # CONFIG_MIPS_MT_SMP is not set
 # CONFIG_MIPS_MT_SMTC is not set
-# CONFIG_MIPS_VPE_LOADER is not set
 CONFIG_64BIT_PHYS_ADDR=y
 CONFIG_CPU_HAS_LLSC=y
 CONFIG_CPU_HAS_SYNC=y
@@ -120,168 +139,181 @@ CONFIG_GENERIC_HARDIRQS=y
 CONFIG_GENERIC_IRQ_PROBE=y
 CONFIG_CPU_SUPPORTS_HIGHMEM=y
 CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
 CONFIG_FLATMEM_MANUAL=y
 # CONFIG_DISCONTIGMEM_MANUAL is not set
 # CONFIG_SPARSEMEM_MANUAL is not set
 CONFIG_FLATMEM=y
 CONFIG_FLAT_NODE_MEM_MAP=y
-# CONFIG_SPARSEMEM_STATIC is not set
+CONFIG_PAGEFLAGS_EXTENDED=y
 CONFIG_SPLIT_PTLOCK_CPUS=4
-# CONFIG_RESOURCES_64BIT is not set
-CONFIG_ZONE_DMA_FLAG=1
+# CONFIG_PHYS_ADDR_T_64BIT is not set
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+CONFIG_UNEVICTABLE_LRU=y
+CONFIG_HAVE_MLOCK=y
+CONFIG_HAVE_MLOCKED_PAGE_BIT=y
+CONFIG_TICK_ONESHOT=y
+CONFIG_NO_HZ=y
+CONFIG_HIGH_RES_TIMERS=y
+CONFIG_GENERIC_CLOCKEVENTS_BUILD=y
 # CONFIG_HZ_48 is not set
 # CONFIG_HZ_100 is not set
-# CONFIG_HZ_128 is not set
+CONFIG_HZ_128=y
 # CONFIG_HZ_250 is not set
 # CONFIG_HZ_256 is not set
-CONFIG_HZ_1000=y
+# CONFIG_HZ_1000 is not set
 # CONFIG_HZ_1024 is not set
 CONFIG_SYS_SUPPORTS_ARBIT_HZ=y
-CONFIG_HZ=1000
+CONFIG_HZ=128
 CONFIG_PREEMPT_NONE=y
 # CONFIG_PREEMPT_VOLUNTARY is not set
 # CONFIG_PREEMPT is not set
 # CONFIG_KEXEC is not set
+# CONFIG_SECCOMP is not set
 CONFIG_LOCKDEP_SUPPORT=y
 CONFIG_STACKTRACE_SUPPORT=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
-# Code maturity level options
+# General setup
 #
 CONFIG_EXPERIMENTAL=y
 CONFIG_BROKEN_ON_SMP=y
 CONFIG_INIT_ENV_ARG_LIMIT=32
-
-#
-# General setup
-#
-CONFIG_LOCALVERSION=""
+CONFIG_LOCALVERSION="-db1200"
 CONFIG_LOCALVERSION_AUTO=y
 CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
-# CONFIG_IPC_NS is not set
 CONFIG_SYSVIPC_SYSCTL=y
-# CONFIG_POSIX_MQUEUE is not set
+CONFIG_POSIX_MQUEUE=y
 # CONFIG_BSD_PROCESS_ACCT is not set
 # CONFIG_TASKSTATS is not set
-# CONFIG_UTS_NS is not set
 # CONFIG_AUDIT is not set
-CONFIG_IKCONFIG=y
-CONFIG_IKCONFIG_PROC=y
-CONFIG_SYSFS_DEPRECATED=y
+
+#
+# RCU Subsystem
+#
+CONFIG_CLASSIC_RCU=y
+# CONFIG_TREE_RCU is not set
+# CONFIG_PREEMPT_RCU is not set
+# CONFIG_TREE_RCU_TRACE is not set
+# CONFIG_PREEMPT_RCU_TRACE is not set
+# CONFIG_IKCONFIG is not set
+CONFIG_LOG_BUF_SHIFT=18
+# CONFIG_GROUP_SCHED is not set
+# CONFIG_CGROUPS is not set
+# CONFIG_SYSFS_DEPRECATED_V2 is not set
 # CONFIG_RELAY is not set
-# CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
+# CONFIG_NAMESPACES is not set
+# CONFIG_BLK_DEV_INITRD is not set
+CONFIG_CC_OPTIMIZE_FOR_SIZE=y
 CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
 CONFIG_EMBEDDED=y
-CONFIG_SYSCTL_SYSCALL=y
+# CONFIG_SYSCTL_SYSCALL is not set
 CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
 # CONFIG_KALLSYMS_EXTRA_PASS is not set
 CONFIG_HOTPLUG=y
 CONFIG_PRINTK=y
 CONFIG_BUG=y
 CONFIG_ELF_CORE=y
+# CONFIG_PCSPKR_PLATFORM is not set
 CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
+CONFIG_SIGNALFD=y
+CONFIG_TIMERFD=y
+CONFIG_EVENTFD=y
 CONFIG_SHMEM=y
-CONFIG_SLAB=y
-CONFIG_VM_EVENT_COUNTERS=y
+CONFIG_AIO=y
+# CONFIG_VM_EVENT_COUNTERS is not set
+# CONFIG_SLUB_DEBUG is not set
+# CONFIG_COMPAT_BRK is not set
+# CONFIG_SLAB is not set
+CONFIG_SLUB=y
+# CONFIG_SLOB is not set
+# CONFIG_PROFILING is not set
+# CONFIG_MARKERS is not set
+CONFIG_HAVE_OPROFILE=y
+# CONFIG_SLOW_WORK is not set
+# CONFIG_HAVE_GENERIC_DMA_COHERENT is not set
 CONFIG_RT_MUTEXES=y
-# CONFIG_TINY_SHMEM is not set
 CONFIG_BASE_SMALL=0
-# CONFIG_SLOB is not set
-
-#
-# Loadable module support
-#
 CONFIG_MODULES=y
+CONFIG_MODULE_FORCE_LOAD=y
 CONFIG_MODULE_UNLOAD=y
-# CONFIG_MODULE_FORCE_UNLOAD is not set
-CONFIG_MODVERSIONS=y
-CONFIG_MODULE_SRCVERSION_ALL=y
-CONFIG_KMOD=y
-
-#
-# Block layer
-#
+CONFIG_MODULE_FORCE_UNLOAD=y
+# CONFIG_MODVERSIONS is not set
+# CONFIG_MODULE_SRCVERSION_ALL is not set
 CONFIG_BLOCK=y
 # CONFIG_LBD is not set
-# CONFIG_BLK_DEV_IO_TRACE is not set
-# CONFIG_LSF is not set
+# CONFIG_BLK_DEV_BSG is not set
+# CONFIG_BLK_DEV_INTEGRITY is not set
 
 #
 # IO Schedulers
 #
 CONFIG_IOSCHED_NOOP=y
-CONFIG_IOSCHED_AS=y
+# CONFIG_IOSCHED_AS is not set
 CONFIG_IOSCHED_DEADLINE=y
-CONFIG_IOSCHED_CFQ=y
-CONFIG_DEFAULT_AS=y
-# CONFIG_DEFAULT_DEADLINE is not set
+# CONFIG_IOSCHED_CFQ is not set
+# CONFIG_DEFAULT_AS is not set
+CONFIG_DEFAULT_DEADLINE=y
 # CONFIG_DEFAULT_CFQ is not set
 # CONFIG_DEFAULT_NOOP is not set
-CONFIG_DEFAULT_IOSCHED="anticipatory"
+CONFIG_DEFAULT_IOSCHED="deadline"
+# CONFIG_FREEZER is not set
 
 #
 # Bus options (PCI, PCMCIA, EISA, ISA, TC)
 #
+# CONFIG_ARCH_SUPPORTS_MSI is not set
 CONFIG_MMU=y
-
-#
-# PCCARD (PCMCIA/CardBus) support
-#
-CONFIG_PCCARD=m
+CONFIG_PCCARD=y
 # CONFIG_PCMCIA_DEBUG is not set
-CONFIG_PCMCIA=m
+CONFIG_PCMCIA=y
 CONFIG_PCMCIA_LOAD_CIS=y
-CONFIG_PCMCIA_IOCTL=y
+# CONFIG_PCMCIA_IOCTL is not set
 
 #
 # PC-card bridges
 #
-CONFIG_PCMCIA_AU1X00=m
-
-#
-# PCI Hotplug Support
-#
+CONFIG_PCMCIA_AU1X00=y
 
 #
 # Executable file formats
 #
 CONFIG_BINFMT_ELF=y
-# CONFIG_BINFMT_MISC is not set
+CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
+# CONFIG_HAVE_AOUT is not set
+CONFIG_BINFMT_MISC=y
 CONFIG_TRAD_SIGNALS=y
 
 #
 # Power management options
 #
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
 # CONFIG_PM is not set
-
-#
-# Networking
-#
 CONFIG_NET=y
 
 #
 # Networking options
 #
-# CONFIG_NETDEBUG is not set
 CONFIG_PACKET=y
-# CONFIG_PACKET_MMAP is not set
+CONFIG_PACKET_MMAP=y
 CONFIG_UNIX=y
-CONFIG_XFRM=y
-CONFIG_XFRM_USER=m
-# CONFIG_XFRM_SUB_POLICY is not set
-CONFIG_XFRM_MIGRATE=y
-CONFIG_NET_KEY=y
-CONFIG_NET_KEY_MIGRATE=y
+# CONFIG_NET_KEY is not set
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 # CONFIG_IP_ADVANCED_ROUTER is not set
 CONFIG_IP_FIB_HASH=y
-# CONFIG_IP_PNP is not set
+CONFIG_IP_PNP=y
+# CONFIG_IP_PNP_DHCP is not set
+# CONFIG_IP_PNP_BOOTP is not set
+# CONFIG_IP_PNP_RARP is not set
 # CONFIG_NET_IPIP is not set
 # CONFIG_NET_IPGRE is not set
 # CONFIG_IP_MROUTE is not set
@@ -292,107 +324,24 @@ CONFIG_IP_FIB_HASH=y
 # CONFIG_INET_IPCOMP is not set
 # CONFIG_INET_XFRM_TUNNEL is not set
 # CONFIG_INET_TUNNEL is not set
-CONFIG_INET_XFRM_MODE_TRANSPORT=m
-CONFIG_INET_XFRM_MODE_TUNNEL=m
-CONFIG_INET_XFRM_MODE_BEET=m
-CONFIG_INET_DIAG=y
-CONFIG_INET_TCP_DIAG=y
+# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
+# CONFIG_INET_XFRM_MODE_TUNNEL is not set
+# CONFIG_INET_XFRM_MODE_BEET is not set
+CONFIG_INET_LRO=y
+# CONFIG_INET_DIAG is not set
 # CONFIG_TCP_CONG_ADVANCED is not set
 CONFIG_TCP_CONG_CUBIC=y
 CONFIG_DEFAULT_TCP_CONG="cubic"
-CONFIG_TCP_MD5SIG=y
-
-#
-# IP: Virtual Server Configuration
-#
-# CONFIG_IP_VS is not set
+# CONFIG_TCP_MD5SIG is not set
 # CONFIG_IPV6 is not set
-# CONFIG_INET6_XFRM_TUNNEL is not set
-# CONFIG_INET6_TUNNEL is not set
-CONFIG_NETWORK_SECMARK=y
-CONFIG_NETFILTER=y
-# CONFIG_NETFILTER_DEBUG is not set
-
-#
-# Core Netfilter Configuration
-#
-# CONFIG_NETFILTER_NETLINK is not set
-CONFIG_NF_CONNTRACK_ENABLED=m
-CONFIG_NF_CONNTRACK_SUPPORT=y
-# CONFIG_IP_NF_CONNTRACK_SUPPORT is not set
-CONFIG_NF_CONNTRACK=m
-CONFIG_NF_CT_ACCT=y
-CONFIG_NF_CONNTRACK_MARK=y
-CONFIG_NF_CONNTRACK_SECMARK=y
-CONFIG_NF_CONNTRACK_EVENTS=y
-CONFIG_NF_CT_PROTO_GRE=m
-CONFIG_NF_CT_PROTO_SCTP=m
-CONFIG_NF_CONNTRACK_AMANDA=m
-CONFIG_NF_CONNTRACK_FTP=m
-CONFIG_NF_CONNTRACK_H323=m
-CONFIG_NF_CONNTRACK_IRC=m
-# CONFIG_NF_CONNTRACK_NETBIOS_NS is not set
-CONFIG_NF_CONNTRACK_PPTP=m
-CONFIG_NF_CONNTRACK_SANE=m
-CONFIG_NF_CONNTRACK_SIP=m
-CONFIG_NF_CONNTRACK_TFTP=m
-CONFIG_NETFILTER_XTABLES=m
-CONFIG_NETFILTER_XT_TARGET_CLASSIFY=m
-CONFIG_NETFILTER_XT_TARGET_MARK=m
-CONFIG_NETFILTER_XT_TARGET_NFQUEUE=m
-CONFIG_NETFILTER_XT_TARGET_NFLOG=m
-CONFIG_NETFILTER_XT_TARGET_SECMARK=m
-CONFIG_NETFILTER_XT_TARGET_CONNSECMARK=m
-CONFIG_NETFILTER_XT_TARGET_TCPMSS=m
-CONFIG_NETFILTER_XT_MATCH_COMMENT=m
-CONFIG_NETFILTER_XT_MATCH_CONNBYTES=m
-CONFIG_NETFILTER_XT_MATCH_CONNMARK=m
-CONFIG_NETFILTER_XT_MATCH_CONNTRACK=m
-CONFIG_NETFILTER_XT_MATCH_DCCP=m
-CONFIG_NETFILTER_XT_MATCH_DSCP=m
-CONFIG_NETFILTER_XT_MATCH_ESP=m
-CONFIG_NETFILTER_XT_MATCH_HELPER=m
-CONFIG_NETFILTER_XT_MATCH_LENGTH=m
-CONFIG_NETFILTER_XT_MATCH_LIMIT=m
-CONFIG_NETFILTER_XT_MATCH_MAC=m
-CONFIG_NETFILTER_XT_MATCH_MARK=m
-CONFIG_NETFILTER_XT_MATCH_POLICY=m
-CONFIG_NETFILTER_XT_MATCH_MULTIPORT=m
-CONFIG_NETFILTER_XT_MATCH_PKTTYPE=m
-CONFIG_NETFILTER_XT_MATCH_QUOTA=m
-CONFIG_NETFILTER_XT_MATCH_REALM=m
-CONFIG_NETFILTER_XT_MATCH_SCTP=m
-CONFIG_NETFILTER_XT_MATCH_STATE=m
-CONFIG_NETFILTER_XT_MATCH_STATISTIC=m
-CONFIG_NETFILTER_XT_MATCH_STRING=m
-CONFIG_NETFILTER_XT_MATCH_TCPMSS=m
-CONFIG_NETFILTER_XT_MATCH_HASHLIMIT=m
-
-#
-# IP: Netfilter Configuration
-#
-CONFIG_NF_CONNTRACK_IPV4=m
-CONFIG_NF_CONNTRACK_PROC_COMPAT=y
-# CONFIG_IP_NF_QUEUE is not set
-# CONFIG_IP_NF_IPTABLES is not set
-# CONFIG_IP_NF_ARPTABLES is not set
-
-#
-# DCCP Configuration (EXPERIMENTAL)
-#
+# CONFIG_NETWORK_SECMARK is not set
+# CONFIG_NETFILTER is not set
 # CONFIG_IP_DCCP is not set
-
-#
-# SCTP Configuration (EXPERIMENTAL)
-#
 # CONFIG_IP_SCTP is not set
-
-#
-# TIPC Configuration (EXPERIMENTAL)
-#
 # CONFIG_TIPC is not set
 # CONFIG_ATM is not set
 # CONFIG_BRIDGE is not set
+# CONFIG_NET_DSA is not set
 # CONFIG_VLAN_8021Q is not set
 # CONFIG_DECNET is not set
 # CONFIG_LLC2 is not set
@@ -402,21 +351,23 @@ CONFIG_NF_CONNTRACK_PROC_COMPAT=y
 # CONFIG_LAPB is not set
 # CONFIG_ECONET is not set
 # CONFIG_WAN_ROUTER is not set
-
-#
-# QoS and/or fair queueing
-#
+# CONFIG_PHONET is not set
 # CONFIG_NET_SCHED is not set
-CONFIG_NET_CLS_ROUTE=y
+# CONFIG_DCB is not set
 
 #
 # Network testing
 #
 # CONFIG_NET_PKTGEN is not set
 # CONFIG_HAMRADIO is not set
+# CONFIG_CAN is not set
 # CONFIG_IRDA is not set
 # CONFIG_BT is not set
-# CONFIG_IEEE80211 is not set
+# CONFIG_AF_RXRPC is not set
+# CONFIG_WIRELESS is not set
+# CONFIG_WIMAX is not set
+# CONFIG_RFKILL is not set
+# CONFIG_NET_9P is not set
 
 #
 # Device Drivers
@@ -425,25 +376,24 @@ CONFIG_NET_CLS_ROUTE=y
 #
 # Generic Driver Options
 #
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
 CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+# CONFIG_DEBUG_DRIVER is not set
+# CONFIG_DEBUG_DEVRES is not set
 # CONFIG_SYS_HYPERVISOR is not set
-
-#
-# Connector - unified userspace <-> kernelspace linker
-#
 # CONFIG_CONNECTOR is not set
-
-#
-# Memory Technology Devices (MTD)
-#
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
-# CONFIG_MTD_CONCAT is not set
+CONFIG_MTD_CONCAT=y
 CONFIG_MTD_PARTITIONS=y
+# CONFIG_MTD_TESTS is not set
 # CONFIG_MTD_REDBOOT_PARTS is not set
 # CONFIG_MTD_CMDLINE_PARTS is not set
+# CONFIG_MTD_AR7_PARTS is not set
 
 #
 # User Modules And Translation Layers
@@ -456,6 +406,7 @@ CONFIG_MTD_BLOCK=y
 # CONFIG_INFTL is not set
 # CONFIG_RFD_FTL is not set
 # CONFIG_SSFDC is not set
+# CONFIG_MTD_OOPS is not set
 
 #
 # RAM/ROM/Flash chip drivers
@@ -481,7 +432,6 @@ CONFIG_MTD_CFI_UTIL=y
 # CONFIG_MTD_RAM is not set
 # CONFIG_MTD_ROM is not set
 # CONFIG_MTD_ABSENT is not set
-# CONFIG_MTD_OBSOLETE_CHIPS is not set
 
 #
 # Mapping drivers for chip access
@@ -494,6 +444,9 @@ CONFIG_MTD_ALCHEMY=y
 #
 # Self-contained MTD device drivers
 #
+# CONFIG_MTD_DATAFLASH is not set
+CONFIG_MTD_M25P80=y
+CONFIG_M25PXX_USE_FAST_READ=y
 # CONFIG_MTD_SLRAM is not set
 # CONFIG_MTD_PHRAM is not set
 # CONFIG_MTD_MTDRAM is not set
@@ -505,224 +458,133 @@ CONFIG_MTD_ALCHEMY=y
 # CONFIG_MTD_DOC2000 is not set
 # CONFIG_MTD_DOC2001 is not set
 # CONFIG_MTD_DOC2001PLUS is not set
-
-#
-# NAND Flash Device Drivers
-#
 CONFIG_MTD_NAND=y
 # CONFIG_MTD_NAND_VERIFY_WRITE is not set
 # CONFIG_MTD_NAND_ECC_SMC is not set
+# CONFIG_MTD_NAND_MUSEUM_IDS is not set
 CONFIG_MTD_NAND_IDS=y
 # CONFIG_MTD_NAND_AU1550 is not set
 # CONFIG_MTD_NAND_DISKONCHIP is not set
 # CONFIG_MTD_NAND_NANDSIM is not set
-
-#
-# OneNAND Flash Device Drivers
-#
+CONFIG_MTD_NAND_PLATFORM=y
+# CONFIG_MTD_ALAUDA is not set
 # CONFIG_MTD_ONENAND is not set
 
 #
-# Parallel port support
+# LPDDR flash memory drivers
 #
-# CONFIG_PARPORT is not set
+# CONFIG_MTD_LPDDR is not set
 
 #
-# Plug and Play support
-#
-# CONFIG_PNPACPI is not set
-
-#
-# Block devices
-#
-# CONFIG_BLK_DEV_COW_COMMON is not set
-CONFIG_BLK_DEV_LOOP=y
-# CONFIG_BLK_DEV_CRYPTOLOOP is not set
-# CONFIG_BLK_DEV_NBD is not set
-CONFIG_BLK_DEV_RAM=y
-CONFIG_BLK_DEV_RAM_COUNT=16
-CONFIG_BLK_DEV_RAM_SIZE=4096
-CONFIG_BLK_DEV_RAM_BLOCKSIZE=1024
-# CONFIG_BLK_DEV_INITRD is not set
-# CONFIG_CDROM_PKTCDVD is not set
-# CONFIG_ATA_OVER_ETH is not set
-
-#
-# Misc devices
+# UBI - Unsorted block images
 #
+# CONFIG_MTD_UBI is not set
+# CONFIG_PARPORT is not set
+# CONFIG_BLK_DEV is not set
+CONFIG_MISC_DEVICES=y
+# CONFIG_ICS932S401 is not set
+# CONFIG_ENCLOSURE_SERVICES is not set
+# CONFIG_ISL29003 is not set
+# CONFIG_C2PORT is not set
 
 #
-# ATA/ATAPI/MFM/RLL support
+# EEPROM support
 #
+CONFIG_EEPROM_AT24=y
+# CONFIG_EEPROM_AT25 is not set
+# CONFIG_EEPROM_LEGACY is not set
+# CONFIG_EEPROM_93CX6 is not set
+CONFIG_HAVE_IDE=y
 CONFIG_IDE=y
-CONFIG_IDE_MAX_HWIFS=4
-CONFIG_BLK_DEV_IDE=y
 
 #
-# Please see Documentation/ide.txt for help/info on IDE drives
+# Please see Documentation/ide/ide.txt for help/info on IDE drives
 #
+CONFIG_IDE_XFER_MODE=y
 # CONFIG_BLK_DEV_IDE_SATA is not set
-CONFIG_BLK_DEV_IDEDISK=y
-CONFIG_IDEDISK_MULTI_MODE=y
-CONFIG_BLK_DEV_IDECS=m
+CONFIG_IDE_GD=y
+CONFIG_IDE_GD_ATA=y
+# CONFIG_IDE_GD_ATAPI is not set
+CONFIG_BLK_DEV_IDECS=y
 # CONFIG_BLK_DEV_IDECD is not set
 # CONFIG_BLK_DEV_IDETAPE is not set
-# CONFIG_BLK_DEV_IDEFLOPPY is not set
-# CONFIG_BLK_DEV_IDESCSI is not set
-# CONFIG_IDE_TASK_IOCTL is not set
+CONFIG_IDE_TASK_IOCTL=y
+# CONFIG_IDE_PROC_FS is not set
 
 #
 # IDE chipset support/bugfixes
 #
-CONFIG_IDE_GENERIC=y
+# CONFIG_IDE_GENERIC is not set
+# CONFIG_BLK_DEV_PLATFORM is not set
 CONFIG_BLK_DEV_IDE_AU1XXX=y
 CONFIG_BLK_DEV_IDE_AU1XXX_PIO_DBDMA=y
 # CONFIG_BLK_DEV_IDE_AU1XXX_MDMA2_DBDMA is not set
-CONFIG_BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ=128
-# CONFIG_IDE_ARM is not set
 # CONFIG_BLK_DEV_IDEDMA is not set
-# CONFIG_IDEDMA_AUTO is not set
-# CONFIG_BLK_DEV_HD is not set
 
 #
 # SCSI device support
 #
 # CONFIG_RAID_ATTRS is not set
-CONFIG_SCSI=y
-CONFIG_SCSI_TGT=m
+# CONFIG_SCSI is not set
+# CONFIG_SCSI_DMA is not set
 # CONFIG_SCSI_NETLINK is not set
-CONFIG_SCSI_PROC_FS=y
-
-#
-# SCSI support type (disk, tape, CD-ROM)
-#
-CONFIG_BLK_DEV_SD=y
-# CONFIG_CHR_DEV_ST is not set
-# CONFIG_CHR_DEV_OSST is not set
-CONFIG_BLK_DEV_SR=y
-# CONFIG_BLK_DEV_SR_VENDOR is not set
-CONFIG_CHR_DEV_SG=y
-# CONFIG_CHR_DEV_SCH is not set
-
-#
-# Some SCSI devices (e.g. CD jukebox) support multiple LUNs
-#
-CONFIG_SCSI_MULTI_LUN=y
-# CONFIG_SCSI_CONSTANTS is not set
-# CONFIG_SCSI_LOGGING is not set
-CONFIG_SCSI_SCAN_ASYNC=y
-
-#
-# SCSI Transports
-#
-# CONFIG_SCSI_SPI_ATTRS is not set
-# CONFIG_SCSI_FC_ATTRS is not set
-# CONFIG_SCSI_ISCSI_ATTRS is not set
-# CONFIG_SCSI_SAS_ATTRS is not set
-# CONFIG_SCSI_SAS_LIBSAS is not set
-
-#
-# SCSI low-level drivers
-#
-# CONFIG_ISCSI_TCP is not set
-# CONFIG_SCSI_DEBUG is not set
-
-#
-# PCMCIA SCSI adapter support
-#
-# CONFIG_PCMCIA_AHA152X is not set
-# CONFIG_PCMCIA_FDOMAIN is not set
-# CONFIG_PCMCIA_NINJA_SCSI is not set
-# CONFIG_PCMCIA_QLOGIC is not set
-# CONFIG_PCMCIA_SYM53C500 is not set
-
-#
-# Serial ATA (prod) and Parallel ATA (experimental) drivers
-#
 # CONFIG_ATA is not set
-
-#
-# Multi-device support (RAID and LVM)
-#
 # CONFIG_MD is not set
-
-#
-# Fusion MPT device support
-#
-# CONFIG_FUSION is not set
-
-#
-# IEEE 1394 (FireWire) support
-#
-
-#
-# I2O device support
-#
-
-#
-# Network device support
-#
 CONFIG_NETDEVICES=y
+CONFIG_COMPAT_NET_DEV_OPS=y
 # CONFIG_DUMMY is not set
 # CONFIG_BONDING is not set
+# CONFIG_MACVLAN is not set
 # CONFIG_EQUALIZER is not set
 # CONFIG_TUN is not set
-
-#
-# PHY device support
-#
+# CONFIG_VETH is not set
 # CONFIG_PHYLIB is not set
-
-#
-# Ethernet (10 or 100Mbit)
-#
 CONFIG_NET_ETHERNET=y
-CONFIG_MII=m
+CONFIG_MII=y
+# CONFIG_AX88796 is not set
 # CONFIG_MIPS_AU1X00_ENET is not set
-# CONFIG_SMC91X is not set
+CONFIG_SMC91X=y
 # CONFIG_DM9000 is not set
+# CONFIG_ENC28J60 is not set
+# CONFIG_ETHOC is not set
+# CONFIG_DNET is not set
+# CONFIG_IBM_NEW_EMAC_ZMII is not set
+# CONFIG_IBM_NEW_EMAC_RGMII is not set
+# CONFIG_IBM_NEW_EMAC_TAH is not set
+# CONFIG_IBM_NEW_EMAC_EMAC4 is not set
+# CONFIG_IBM_NEW_EMAC_NO_FLOW_CTRL is not set
+# CONFIG_IBM_NEW_EMAC_MAL_CLR_ICINTSTAT is not set
+# CONFIG_IBM_NEW_EMAC_MAL_COMMON_ERR is not set
+# CONFIG_B44 is not set
+# CONFIG_NETDEV_1000 is not set
+# CONFIG_NETDEV_10000 is not set
 
 #
-# Ethernet (1000 Mbit)
+# Wireless LAN
 #
+# CONFIG_WLAN_PRE80211 is not set
+# CONFIG_WLAN_80211 is not set
 
 #
-# Ethernet (10000 Mbit)
+# Enable WiMAX (Networking options) to see the WiMAX drivers
 #
 
 #
-# Token Ring devices
-#
-
-#
-# Wireless LAN (non-hamradio)
-#
-# CONFIG_NET_RADIO is not set
-
-#
-# PCMCIA network device support
+# USB Network Adapters
 #
+# CONFIG_USB_CATC is not set
+# CONFIG_USB_KAWETH is not set
+# CONFIG_USB_PEGASUS is not set
+# CONFIG_USB_RTL8150 is not set
+# CONFIG_USB_USBNET is not set
 # CONFIG_NET_PCMCIA is not set
-
-#
-# Wan interfaces
-#
 # CONFIG_WAN is not set
 # CONFIG_PPP is not set
 # CONFIG_SLIP is not set
-# CONFIG_SHAPER is not set
 # CONFIG_NETCONSOLE is not set
 # CONFIG_NETPOLL is not set
 # CONFIG_NET_POLL_CONTROLLER is not set
-
-#
-# ISDN subsystem
-#
 # CONFIG_ISDN is not set
-
-#
-# Telephony Support
-#
 # CONFIG_PHONE is not set
 
 #
@@ -730,6 +592,7 @@ CONFIG_MII=m
 #
 CONFIG_INPUT=y
 # CONFIG_INPUT_FF_MEMLESS is not set
+# CONFIG_INPUT_POLLDEV is not set
 
 #
 # Userland interfaces
@@ -739,7 +602,6 @@ CONFIG_INPUT_MOUSEDEV_PSAUX=y
 CONFIG_INPUT_MOUSEDEV_SCREEN_X=1024
 CONFIG_INPUT_MOUSEDEV_SCREEN_Y=768
 # CONFIG_INPUT_JOYDEV is not set
-# CONFIG_INPUT_TSDEV is not set
 CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_EVBUG is not set
 
@@ -749,28 +611,33 @@ CONFIG_INPUT_EVDEV=y
 # CONFIG_INPUT_KEYBOARD is not set
 # CONFIG_INPUT_MOUSE is not set
 # CONFIG_INPUT_JOYSTICK is not set
+# CONFIG_INPUT_TABLET is not set
 # CONFIG_INPUT_TOUCHSCREEN is not set
-# CONFIG_INPUT_MISC is not set
+CONFIG_INPUT_MISC=y
+# CONFIG_INPUT_ATI_REMOTE is not set
+# CONFIG_INPUT_ATI_REMOTE2 is not set
+# CONFIG_INPUT_KEYSPAN_REMOTE is not set
+# CONFIG_INPUT_POWERMATE is not set
+# CONFIG_INPUT_YEALINK is not set
+# CONFIG_INPUT_CM109 is not set
+CONFIG_INPUT_UINPUT=y
 
 #
 # Hardware I/O ports
 #
-CONFIG_SERIO=y
-# CONFIG_SERIO_I8042 is not set
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_LIBPS2 is not set
-CONFIG_SERIO_RAW=y
+# CONFIG_SERIO is not set
 # CONFIG_GAMEPORT is not set
 
 #
 # Character devices
 #
 CONFIG_VT=y
+# CONFIG_CONSOLE_TRANSLATIONS is not set
 CONFIG_VT_CONSOLE=y
 CONFIG_HW_CONSOLE=y
-CONFIG_VT_HW_CONSOLE_BINDING=y
+# CONFIG_VT_HW_CONSOLE_BINDING is not set
+CONFIG_DEVKMEM=y
 # CONFIG_SERIAL_NONSTANDARD is not set
-# CONFIG_AU1X00_GPIO is not set
 
 #
 # Serial drivers
@@ -778,8 +645,8 @@ CONFIG_VT_HW_CONSOLE_BINDING=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
 # CONFIG_SERIAL_8250_CS is not set
-CONFIG_SERIAL_8250_NR_UARTS=4
-CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_8250_NR_UARTS=2
+CONFIG_SERIAL_8250_RUNTIME_UARTS=2
 # CONFIG_SERIAL_8250_EXTENDED is not set
 CONFIG_SERIAL_8250_AU1X00=y
 
@@ -789,22 +656,10 @@ CONFIG_SERIAL_8250_AU1X00=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
-CONFIG_LEGACY_PTYS=y
-CONFIG_LEGACY_PTY_COUNT=256
-
-#
-# IPMI
-#
+# CONFIG_DEVPTS_MULTIPLE_INSTANCES is not set
+# CONFIG_LEGACY_PTYS is not set
 # CONFIG_IPMI_HANDLER is not set
-
-#
-# Watchdog Cards
-#
-# CONFIG_WATCHDOG is not set
 # CONFIG_HW_RANDOM is not set
-# CONFIG_RTC is not set
-# CONFIG_GEN_RTC is not set
-# CONFIG_DTLK is not set
 # CONFIG_R3964 is not set
 
 #
@@ -813,223 +668,589 @@ CONFIG_LEGACY_PTY_COUNT=256
 # CONFIG_SYNCLINK_CS is not set
 # CONFIG_CARDMAN_4000 is not set
 # CONFIG_CARDMAN_4040 is not set
+# CONFIG_IPWIRELESS is not set
 # CONFIG_RAW_DRIVER is not set
+# CONFIG_TCG_TPM is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_CHARDEV=y
+# CONFIG_I2C_HELPER_AUTO is not set
 
 #
-# TPM devices
+# I2C Algorithms
 #
-# CONFIG_TCG_TPM is not set
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
+# CONFIG_I2C_TINY_USB is not set
 
 #
-# I2C support
+# Other I2C/SMBus bus drivers
 #
-# CONFIG_I2C is not set
+# CONFIG_I2C_PCA_PLATFORM is not set
+# CONFIG_I2C_STUB is not set
 
 #
-# SPI support
+# Miscellaneous I2C Chip support
 #
-# CONFIG_SPI is not set
-# CONFIG_SPI_MASTER is not set
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_PCF8575 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
+CONFIG_SPI=y
+# CONFIG_SPI_DEBUG is not set
+CONFIG_SPI_MASTER=y
 
 #
-# Dallas's 1-wire bus
+# SPI Master Controller Drivers
 #
+CONFIG_SPI_AU1550=y
+CONFIG_SPI_BITBANG=y
+# CONFIG_SPI_GPIO is not set
+
+#
+# SPI Protocol Masters
+#
+# CONFIG_SPI_SPIDEV is not set
+# CONFIG_SPI_TLE62X0 is not set
+CONFIG_ARCH_REQUIRE_GPIOLIB=y
+CONFIG_GPIOLIB=y
+# CONFIG_DEBUG_GPIO is not set
+CONFIG_GPIO_SYSFS=y
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
 # CONFIG_W1 is not set
+# CONFIG_POWER_SUPPLY is not set
+CONFIG_HWMON=y
+CONFIG_HWMON_VID=y
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
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM63 is not set
+CONFIG_SENSORS_LM70=y
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
+# CONFIG_SENSORS_DME1737 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_SMSC47M192 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_ADS7828 is not set
+# CONFIG_SENSORS_THMC50 is not set
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
+# CONFIG_HWMON_DEBUG_CHIP is not set
+# CONFIG_THERMAL is not set
+# CONFIG_THERMAL_HWMON is not set
+# CONFIG_WATCHDOG is not set
+CONFIG_SSB_POSSIBLE=y
 
 #
-# Hardware Monitoring support
+# Sonics Silicon Backplane
 #
-# CONFIG_HWMON is not set
-# CONFIG_HWMON_VID is not set
+# CONFIG_SSB is not set
+
+#
+# Multifunction device drivers
+#
+# CONFIG_MFD_CORE is not set
+# CONFIG_MFD_SM501 is not set
+# CONFIG_HTC_PASIC3 is not set
+# CONFIG_UCB1400_CORE is not set
+# CONFIG_TPS65010 is not set
+# CONFIG_TWL4030_CORE is not set
+# CONFIG_MFD_TMIO is not set
+# CONFIG_PMIC_DA903X is not set
+# CONFIG_MFD_WM8400 is not set
+# CONFIG_MFD_WM8350_I2C is not set
+# CONFIG_MFD_PCF50633 is not set
+# CONFIG_REGULATOR is not set
 
 #
 # Multimedia devices
 #
+
+#
+# Multimedia core support
+#
 # CONFIG_VIDEO_DEV is not set
+# CONFIG_DVB_CORE is not set
+# CONFIG_VIDEO_MEDIA is not set
 
 #
-# Digital Video Broadcasting Devices
+# Multimedia drivers
 #
-# CONFIG_DVB is not set
+# CONFIG_DAB is not set
 
 #
 # Graphics support
 #
-# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_VGASTATE is not set
+# CONFIG_VIDEO_OUTPUT_CONTROL is not set
 CONFIG_FB=y
+# CONFIG_FIRMWARE_EDID is not set
+# CONFIG_FB_DDC is not set
+# CONFIG_FB_BOOT_VESA_SUPPORT is not set
 CONFIG_FB_CFB_FILLRECT=y
 CONFIG_FB_CFB_COPYAREA=y
 CONFIG_FB_CFB_IMAGEBLIT=y
+# CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is not set
+# CONFIG_FB_SYS_FILLRECT is not set
+# CONFIG_FB_SYS_COPYAREA is not set
+# CONFIG_FB_SYS_IMAGEBLIT is not set
+# CONFIG_FB_FOREIGN_ENDIAN is not set
+# CONFIG_FB_SYS_FOPS is not set
 # CONFIG_FB_SVGALIB is not set
 # CONFIG_FB_MACMODES is not set
 # CONFIG_FB_BACKLIGHT is not set
 # CONFIG_FB_MODE_HELPERS is not set
 # CONFIG_FB_TILEBLITTING is not set
+
+#
+# Frame buffer hardware drivers
+#
 # CONFIG_FB_S1D13XXX is not set
 CONFIG_FB_AU1200=y
 # CONFIG_FB_VIRTUAL is not set
+# CONFIG_FB_METRONOME is not set
+# CONFIG_FB_MB862XX is not set
+# CONFIG_FB_BROADSHEET is not set
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+
+#
+# Display device support
+#
+# CONFIG_DISPLAY_SUPPORT is not set
 
 #
 # Console display driver support
 #
-CONFIG_VGA_CONSOLE=y
-# CONFIG_VGACON_SOFT_SCROLLBACK is not set
+# CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
-# CONFIG_FRAMEBUFFER_CONSOLE is not set
+CONFIG_FRAMEBUFFER_CONSOLE=y
+# CONFIG_FRAMEBUFFER_CONSOLE_DETECT_PRIMARY is not set
+# CONFIG_FRAMEBUFFER_CONSOLE_ROTATION is not set
+CONFIG_FONTS=y
+# CONFIG_FONT_8x8 is not set
+CONFIG_FONT_8x16=y
+# CONFIG_FONT_6x11 is not set
+# CONFIG_FONT_7x14 is not set
+# CONFIG_FONT_PEARL_8x8 is not set
+# CONFIG_FONT_ACORN_8x8 is not set
+# CONFIG_FONT_MINI_4x6 is not set
+# CONFIG_FONT_SUN8x16 is not set
+# CONFIG_FONT_SUN12x22 is not set
+# CONFIG_FONT_10x18 is not set
+# CONFIG_LOGO is not set
+CONFIG_SOUND=y
+# CONFIG_SOUND_OSS_CORE is not set
+CONFIG_SND=y
+CONFIG_SND_TIMER=y
+CONFIG_SND_PCM=y
+CONFIG_SND_JACK=y
+# CONFIG_SND_SEQUENCER is not set
+# CONFIG_SND_MIXER_OSS is not set
+# CONFIG_SND_PCM_OSS is not set
+CONFIG_SND_HRTIMER=y
+CONFIG_SND_DYNAMIC_MINORS=y
+# CONFIG_SND_SUPPORT_OLD_API is not set
+CONFIG_SND_VERBOSE_PROCFS=y
+CONFIG_SND_VERBOSE_PRINTK=y
+# CONFIG_SND_DEBUG is not set
+CONFIG_SND_VMASTER=y
+CONFIG_SND_AC97_CODEC=y
+# CONFIG_SND_DRIVERS is not set
+# CONFIG_SND_SPI is not set
+# CONFIG_SND_MIPS is not set
+# CONFIG_SND_USB is not set
+# CONFIG_SND_PCMCIA is not set
+CONFIG_SND_SOC=y
+CONFIG_SND_SOC_AC97_BUS=y
+CONFIG_SND_SOC_AU1XPSC=y
+CONFIG_SND_SOC_AU1XPSC_I2S=y
+CONFIG_SND_SOC_AU1XPSC_AC97=y
+CONFIG_SND_SOC_DB1200=y
+CONFIG_SND_SOC_I2C_AND_SPI=y
+# CONFIG_SND_SOC_ALL_CODECS is not set
+CONFIG_SND_SOC_AC97_CODEC=y
+CONFIG_SND_SOC_WM8731=y
+# CONFIG_SOUND_PRIME is not set
+CONFIG_AC97_BUS=y
+CONFIG_HID_SUPPORT=y
+CONFIG_HID=y
+# CONFIG_HID_DEBUG is not set
+CONFIG_HIDRAW=y
+
+#
+# USB Input Devices
+#
+CONFIG_USB_HID=y
+# CONFIG_HID_PID is not set
+CONFIG_USB_HIDDEV=y
+
+#
+# Special HID drivers
+#
+# CONFIG_HID_A4TECH is not set
+# CONFIG_HID_APPLE is not set
+# CONFIG_HID_BELKIN is not set
+# CONFIG_HID_CHERRY is not set
+# CONFIG_HID_CHICONY is not set
+# CONFIG_HID_CYPRESS is not set
+# CONFIG_DRAGONRISE_FF is not set
+# CONFIG_HID_EZKEY is not set
+# CONFIG_HID_KYE is not set
+# CONFIG_HID_GYRATION is not set
+# CONFIG_HID_KENSINGTON is not set
+# CONFIG_HID_LOGITECH is not set
+# CONFIG_HID_MICROSOFT is not set
+# CONFIG_HID_MONTEREY is not set
+# CONFIG_HID_NTRIG is not set
+# CONFIG_HID_PANTHERLORD is not set
+# CONFIG_HID_PETALYNX is not set
+# CONFIG_HID_SAMSUNG is not set
+# CONFIG_HID_SONY is not set
+# CONFIG_HID_SUNPLUS is not set
+# CONFIG_GREENASIA_FF is not set
+# CONFIG_HID_TOPSEED is not set
+# CONFIG_THRUSTMASTER_FF is not set
+# CONFIG_ZEROPLUS_FF is not set
+CONFIG_USB_SUPPORT=y
+CONFIG_USB_ARCH_HAS_HCD=y
+CONFIG_USB_ARCH_HAS_OHCI=y
+CONFIG_USB_ARCH_HAS_EHCI=y
+CONFIG_USB=y
+# CONFIG_USB_DEBUG is not set
+# CONFIG_USB_ANNOUNCE_NEW_DEVICES is not set
 
 #
-# Logo configuration
+# Miscellaneous USB options
 #
-CONFIG_LOGO=y
-CONFIG_LOGO_LINUX_MONO=y
-CONFIG_LOGO_LINUX_VGA16=y
-CONFIG_LOGO_LINUX_CLUT224=y
-# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
+CONFIG_USB_DEVICEFS=y
+# CONFIG_USB_DEVICE_CLASS is not set
+CONFIG_USB_DYNAMIC_MINORS=y
+# CONFIG_USB_OTG is not set
+# CONFIG_USB_OTG_WHITELIST is not set
+# CONFIG_USB_OTG_BLACKLIST_HUB is not set
+# CONFIG_USB_MON is not set
+# CONFIG_USB_WUSB is not set
+# CONFIG_USB_WUSB_CBAF is not set
 
 #
-# Sound
+# USB Host Controller Drivers
 #
-# CONFIG_SOUND is not set
+# CONFIG_USB_C67X00_HCD is not set
+CONFIG_USB_EHCI_HCD=y
+CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_EHCI_TT_NEWSCHED=y
+# CONFIG_USB_OXU210HP_HCD is not set
+# CONFIG_USB_ISP116X_HCD is not set
+# CONFIG_USB_ISP1760_HCD is not set
+CONFIG_USB_OHCI_HCD=y
+# CONFIG_USB_OHCI_BIG_ENDIAN_DESC is not set
+# CONFIG_USB_OHCI_BIG_ENDIAN_MMIO is not set
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+# CONFIG_USB_SL811_HCD is not set
+# CONFIG_USB_R8A66597_HCD is not set
+# CONFIG_USB_HWA_HCD is not set
 
 #
-# HID Devices
+# USB Device Class drivers
 #
-CONFIG_HID=y
-# CONFIG_HID_DEBUG is not set
+# CONFIG_USB_ACM is not set
+# CONFIG_USB_PRINTER is not set
+# CONFIG_USB_WDM is not set
+# CONFIG_USB_TMC is not set
 
 #
-# USB support
+# NOTE: USB_STORAGE depends on SCSI but BLK_DEV_SD may
 #
-CONFIG_USB_ARCH_HAS_HCD=y
-CONFIG_USB_ARCH_HAS_OHCI=y
-CONFIG_USB_ARCH_HAS_EHCI=y
-# CONFIG_USB is not set
 
 #
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support'
+# also be needed; see USB_STORAGE Help for more info
 #
+# CONFIG_USB_LIBUSUAL is not set
 
 #
-# USB Gadget Support
+# USB Imaging devices
 #
-CONFIG_USB_GADGET=m
-# CONFIG_USB_GADGET_DEBUG_FILES is not set
-# CONFIG_USB_GADGET_NET2280 is not set
-# CONFIG_USB_GADGET_PXA2XX is not set
-# CONFIG_USB_GADGET_GOKU is not set
-# CONFIG_USB_GADGET_LH7A40X is not set
-# CONFIG_USB_GADGET_OMAP is not set
-# CONFIG_USB_GADGET_AT91 is not set
-# CONFIG_USB_GADGET_DUMMY_HCD is not set
-# CONFIG_USB_GADGET_DUALSPEED is not set
+# CONFIG_USB_MDC800 is not set
 
 #
-# MMC/SD Card support
+# USB port drivers
 #
-CONFIG_MMC=y
-# CONFIG_MMC_DEBUG is not set
-CONFIG_MMC_BLOCK=y
-CONFIG_MMC_AU1X=y
+# CONFIG_USB_SERIAL is not set
 
 #
-# LED devices
+# USB Miscellaneous drivers
 #
-# CONFIG_NEW_LEDS is not set
+# CONFIG_USB_EMI62 is not set
+# CONFIG_USB_EMI26 is not set
+# CONFIG_USB_ADUTUX is not set
+# CONFIG_USB_SEVSEG is not set
+# CONFIG_USB_RIO500 is not set
+# CONFIG_USB_LEGOTOWER is not set
+# CONFIG_USB_LCD is not set
+# CONFIG_USB_BERRY_CHARGE is not set
+# CONFIG_USB_LED is not set
+# CONFIG_USB_CYPRESS_CY7C63 is not set
+# CONFIG_USB_CYTHERM is not set
+# CONFIG_USB_IDMOUSE is not set
+# CONFIG_USB_FTDI_ELAN is not set
+# CONFIG_USB_APPLEDISPLAY is not set
+# CONFIG_USB_SISUSBVGA is not set
+# CONFIG_USB_LD is not set
+# CONFIG_USB_TRANCEVIBRATOR is not set
+# CONFIG_USB_IOWARRIOR is not set
+# CONFIG_USB_TEST is not set
+# CONFIG_USB_ISIGHTFW is not set
+# CONFIG_USB_VST is not set
+# CONFIG_USB_GADGET is not set
 
 #
-# LED drivers
+# OTG and related infrastructure
 #
+# CONFIG_USB_GPIO_VBUS is not set
+# CONFIG_NOP_USB_XCEIV is not set
+CONFIG_MMC=y
+# CONFIG_MMC_DEBUG is not set
+# CONFIG_MMC_UNSAFE_RESUME is not set
 
 #
-# LED Triggers
+# MMC/SD/SDIO Card Drivers
+#
+CONFIG_MMC_BLOCK=y
+# CONFIG_MMC_BLOCK_BOUNCE is not set
+CONFIG_SDIO_UART=y
+# CONFIG_MMC_TEST is not set
+
 #
+# MMC/SD/SDIO Host Controller Drivers
+#
+# CONFIG_MMC_SDHCI is not set
+CONFIG_MMC_AU1X=y
+# CONFIG_MMC_SPI is not set
+# CONFIG_MEMSTICK is not set
+CONFIG_NEW_LEDS=y
+CONFIG_LEDS_CLASS=y
 
 #
-# InfiniBand support
+# LED drivers
 #
+# CONFIG_LEDS_PCA9532 is not set
+# CONFIG_LEDS_GPIO is not set
+# CONFIG_LEDS_LP5521 is not set
+# CONFIG_LEDS_PCA955X is not set
+# CONFIG_LEDS_DAC124S085 is not set
+# CONFIG_LEDS_BD2802 is not set
 
 #
-# EDAC - error detection and reporting (RAS) (EXPERIMENTAL)
+# LED Triggers
 #
+CONFIG_LEDS_TRIGGERS=y
+# CONFIG_LEDS_TRIGGER_TIMER is not set
+# CONFIG_LEDS_TRIGGER_IDE_DISK is not set
+# CONFIG_LEDS_TRIGGER_HEARTBEAT is not set
+# CONFIG_LEDS_TRIGGER_BACKLIGHT is not set
+# CONFIG_LEDS_TRIGGER_GPIO is not set
+# CONFIG_LEDS_TRIGGER_DEFAULT_ON is not set
 
 #
-# Real Time Clock
+# iptables trigger is under Netfilter config (LED target)
 #
-# CONFIG_RTC_CLASS is not set
+# CONFIG_ACCESSIBILITY is not set
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+# CONFIG_RTC_DEBUG is not set
 
 #
-# DMA Engine support
+# RTC interfaces
 #
-# CONFIG_DMA_ENGINE is not set
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+# CONFIG_RTC_INTF_DEV_UIE_EMUL is not set
+# CONFIG_RTC_DRV_TEST is not set
 
 #
-# DMA Clients
+# I2C RTC drivers
 #
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
 
 #
-# DMA Devices
+# SPI RTC drivers
 #
+# CONFIG_RTC_DRV_M41T94 is not set
+# CONFIG_RTC_DRV_DS1305 is not set
+# CONFIG_RTC_DRV_DS1390 is not set
+# CONFIG_RTC_DRV_MAX6902 is not set
+# CONFIG_RTC_DRV_R9701 is not set
+# CONFIG_RTC_DRV_RS5C348 is not set
+# CONFIG_RTC_DRV_DS3234 is not set
 
 #
-# Auxiliary Display support
+# Platform RTC drivers
 #
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
 
 #
-# Virtualization
+# on-CPU RTC drivers
 #
+CONFIG_RTC_DRV_AU1XXX=y
+# CONFIG_DMADEVICES is not set
+# CONFIG_AUXDISPLAY is not set
+# CONFIG_UIO is not set
+# CONFIG_STAGING is not set
 
 #
 # File systems
 #
 CONFIG_EXT2_FS=y
-CONFIG_EXT2_FS_XATTR=y
-CONFIG_EXT2_FS_POSIX_ACL=y
-# CONFIG_EXT2_FS_SECURITY is not set
+# CONFIG_EXT2_FS_XATTR is not set
 # CONFIG_EXT2_FS_XIP is not set
-CONFIG_EXT3_FS=y
-CONFIG_EXT3_FS_XATTR=y
-CONFIG_EXT3_FS_POSIX_ACL=y
-CONFIG_EXT3_FS_SECURITY=y
-# CONFIG_EXT4DEV_FS is not set
-CONFIG_JBD=y
-# CONFIG_JBD_DEBUG is not set
-CONFIG_FS_MBCACHE=y
+# CONFIG_EXT3_FS is not set
+# CONFIG_EXT4_FS is not set
 # CONFIG_REISERFS_FS is not set
-CONFIG_JFS_FS=y
-# CONFIG_JFS_POSIX_ACL is not set
-# CONFIG_JFS_SECURITY is not set
-# CONFIG_JFS_DEBUG is not set
-# CONFIG_JFS_STATISTICS is not set
-CONFIG_FS_POSIX_ACL=y
+# CONFIG_JFS_FS is not set
+# CONFIG_FS_POSIX_ACL is not set
+CONFIG_FILE_LOCKING=y
 # CONFIG_XFS_FS is not set
-# CONFIG_GFS2_FS is not set
 # CONFIG_OCFS2_FS is not set
-# CONFIG_MINIX_FS is not set
-# CONFIG_ROMFS_FS is not set
+# CONFIG_BTRFS_FS is not set
+CONFIG_DNOTIFY=y
 CONFIG_INOTIFY=y
 CONFIG_INOTIFY_USER=y
 # CONFIG_QUOTA is not set
-CONFIG_DNOTIFY=y
 # CONFIG_AUTOFS_FS is not set
 # CONFIG_AUTOFS4_FS is not set
 # CONFIG_FUSE_FS is not set
-CONFIG_GENERIC_ACL=y
+
+#
+# Caches
+#
+# CONFIG_FSCACHE is not set
 
 #
 # CD-ROM/DVD Filesystems
 #
-CONFIG_ISO9660_FS=m
-CONFIG_JOLIET=y
-CONFIG_ZISOFS=y
-CONFIG_UDF_FS=m
-CONFIG_UDF_NLS=y
+# CONFIG_ISO9660_FS is not set
+# CONFIG_UDF_FS is not set
 
 #
 # DOS/FAT/NT Filesystems
 #
-CONFIG_FAT_FS=m
-CONFIG_MSDOS_FS=m
-CONFIG_VFAT_FS=m
+CONFIG_FAT_FS=y
+# CONFIG_MSDOS_FS is not set
+CONFIG_VFAT_FS=y
 CONFIG_FAT_DEFAULT_CODEPAGE=437
 CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 # CONFIG_NTFS_FS is not set
@@ -1040,19 +1261,15 @@ CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
 CONFIG_PROC_FS=y
 CONFIG_PROC_KCORE=y
 CONFIG_PROC_SYSCTL=y
+# CONFIG_PROC_PAGE_MONITOR is not set
 CONFIG_SYSFS=y
 CONFIG_TMPFS=y
-CONFIG_TMPFS_POSIX_ACL=y
+# CONFIG_TMPFS_POSIX_ACL is not set
 # CONFIG_HUGETLB_PAGE is not set
-CONFIG_RAMFS=y
-CONFIG_CONFIGFS_FS=m
-
-#
-# Miscellaneous filesystems
-#
+# CONFIG_CONFIGFS_FS is not set
+CONFIG_MISC_FILESYSTEMS=y
 # CONFIG_ADFS_FS is not set
 # CONFIG_AFFS_FS is not set
-# CONFIG_ECRYPT_FS is not set
 # CONFIG_HFS_FS is not set
 # CONFIG_HFSPLUS_FS is not set
 # CONFIG_BEFS_FS is not set
@@ -1061,27 +1278,34 @@ CONFIG_CONFIGFS_FS=m
 CONFIG_JFFS2_FS=y
 CONFIG_JFFS2_FS_DEBUG=0
 CONFIG_JFFS2_FS_WRITEBUFFER=y
-# CONFIG_JFFS2_SUMMARY is not set
+# CONFIG_JFFS2_FS_WBUF_VERIFY is not set
+CONFIG_JFFS2_SUMMARY=y
 # CONFIG_JFFS2_FS_XATTR is not set
-# CONFIG_JFFS2_COMPRESSION_OPTIONS is not set
+CONFIG_JFFS2_COMPRESSION_OPTIONS=y
 CONFIG_JFFS2_ZLIB=y
+CONFIG_JFFS2_LZO=y
 CONFIG_JFFS2_RTIME=y
-# CONFIG_JFFS2_RUBIN is not set
-CONFIG_CRAMFS=m
+CONFIG_JFFS2_RUBIN=y
+# CONFIG_JFFS2_CMODE_NONE is not set
+CONFIG_JFFS2_CMODE_PRIORITY=y
+# CONFIG_JFFS2_CMODE_SIZE is not set
+# CONFIG_JFFS2_CMODE_FAVOURLZO is not set
+# CONFIG_CRAMFS is not set
+# CONFIG_SQUASHFS is not set
 # CONFIG_VXFS_FS is not set
+# CONFIG_MINIX_FS is not set
+# CONFIG_OMFS_FS is not set
 # CONFIG_HPFS_FS is not set
 # CONFIG_QNX4FS_FS is not set
+# CONFIG_ROMFS_FS is not set
 # CONFIG_SYSV_FS is not set
 # CONFIG_UFS_FS is not set
-
-#
-# Network File Systems
-#
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
 # CONFIG_NFS_V3_ACL is not set
 # CONFIG_NFS_V4 is not set
-# CONFIG_NFS_DIRECTIO is not set
+CONFIG_ROOT_NFS=y
 # CONFIG_NFSD is not set
 CONFIG_LOCKD=y
 CONFIG_LOCKD_V4=y
@@ -1089,91 +1313,139 @@ CONFIG_NFS_COMMON=y
 CONFIG_SUNRPC=y
 # CONFIG_RPCSEC_GSS_KRB5 is not set
 # CONFIG_RPCSEC_GSS_SPKM3 is not set
-CONFIG_SMB_FS=y
-# CONFIG_SMB_NLS_DEFAULT is not set
+# CONFIG_SMB_FS is not set
 # CONFIG_CIFS is not set
 # CONFIG_NCP_FS is not set
 # CONFIG_CODA_FS is not set
 # CONFIG_AFS_FS is not set
-# CONFIG_9P_FS is not set
 
 #
 # Partition Types
 #
-# CONFIG_PARTITION_ADVANCED is not set
+CONFIG_PARTITION_ADVANCED=y
+# CONFIG_ACORN_PARTITION is not set
+# CONFIG_OSF_PARTITION is not set
+# CONFIG_AMIGA_PARTITION is not set
+# CONFIG_ATARI_PARTITION is not set
+# CONFIG_MAC_PARTITION is not set
 CONFIG_MSDOS_PARTITION=y
-
-#
-# Native Language Support
-#
+# CONFIG_BSD_DISKLABEL is not set
+# CONFIG_MINIX_SUBPARTITION is not set
+# CONFIG_SOLARIS_X86_PARTITION is not set
+# CONFIG_UNIXWARE_DISKLABEL is not set
+CONFIG_LDM_PARTITION=y
+# CONFIG_LDM_DEBUG is not set
+# CONFIG_SGI_PARTITION is not set
+# CONFIG_ULTRIX_PARTITION is not set
+# CONFIG_SUN_PARTITION is not set
+# CONFIG_KARMA_PARTITION is not set
+CONFIG_EFI_PARTITION=y
+# CONFIG_SYSV68_PARTITION is not set
 CONFIG_NLS=y
 CONFIG_NLS_DEFAULT="iso8859-1"
-CONFIG_NLS_CODEPAGE_437=m
-CONFIG_NLS_CODEPAGE_737=m
-CONFIG_NLS_CODEPAGE_775=m
-CONFIG_NLS_CODEPAGE_850=m
-CONFIG_NLS_CODEPAGE_852=m
-CONFIG_NLS_CODEPAGE_855=m
-CONFIG_NLS_CODEPAGE_857=m
-CONFIG_NLS_CODEPAGE_860=m
-CONFIG_NLS_CODEPAGE_861=m
-CONFIG_NLS_CODEPAGE_862=m
-CONFIG_NLS_CODEPAGE_863=m
-CONFIG_NLS_CODEPAGE_864=m
-CONFIG_NLS_CODEPAGE_865=m
-CONFIG_NLS_CODEPAGE_866=m
-CONFIG_NLS_CODEPAGE_869=m
-CONFIG_NLS_CODEPAGE_936=m
-CONFIG_NLS_CODEPAGE_950=m
-CONFIG_NLS_CODEPAGE_932=m
-CONFIG_NLS_CODEPAGE_949=m
-CONFIG_NLS_CODEPAGE_874=m
-CONFIG_NLS_ISO8859_8=m
-CONFIG_NLS_CODEPAGE_1250=m
-CONFIG_NLS_CODEPAGE_1251=m
-CONFIG_NLS_ASCII=m
-CONFIG_NLS_ISO8859_1=m
-CONFIG_NLS_ISO8859_2=m
-CONFIG_NLS_ISO8859_3=m
-CONFIG_NLS_ISO8859_4=m
-CONFIG_NLS_ISO8859_5=m
-CONFIG_NLS_ISO8859_6=m
-CONFIG_NLS_ISO8859_7=m
-CONFIG_NLS_ISO8859_9=m
-CONFIG_NLS_ISO8859_13=m
-CONFIG_NLS_ISO8859_14=m
-CONFIG_NLS_ISO8859_15=m
-CONFIG_NLS_KOI8_R=m
-CONFIG_NLS_KOI8_U=m
-CONFIG_NLS_UTF8=m
-
-#
-# Distributed Lock Manager
-#
-CONFIG_DLM=m
-CONFIG_DLM_TCP=y
-# CONFIG_DLM_SCTP is not set
-# CONFIG_DLM_DEBUG is not set
-
-#
-# Profiling support
-#
-# CONFIG_PROFILING is not set
+CONFIG_NLS_CODEPAGE_437=y
+# CONFIG_NLS_CODEPAGE_737 is not set
+# CONFIG_NLS_CODEPAGE_775 is not set
+CONFIG_NLS_CODEPAGE_850=y
+CONFIG_NLS_CODEPAGE_852=y
+# CONFIG_NLS_CODEPAGE_855 is not set
+# CONFIG_NLS_CODEPAGE_857 is not set
+# CONFIG_NLS_CODEPAGE_860 is not set
+# CONFIG_NLS_CODEPAGE_861 is not set
+# CONFIG_NLS_CODEPAGE_862 is not set
+# CONFIG_NLS_CODEPAGE_863 is not set
+# CONFIG_NLS_CODEPAGE_864 is not set
+# CONFIG_NLS_CODEPAGE_865 is not set
+# CONFIG_NLS_CODEPAGE_866 is not set
+# CONFIG_NLS_CODEPAGE_869 is not set
+# CONFIG_NLS_CODEPAGE_936 is not set
+# CONFIG_NLS_CODEPAGE_950 is not set
+# CONFIG_NLS_CODEPAGE_932 is not set
+# CONFIG_NLS_CODEPAGE_949 is not set
+# CONFIG_NLS_CODEPAGE_874 is not set
+# CONFIG_NLS_ISO8859_8 is not set
+# CONFIG_NLS_CODEPAGE_1250 is not set
+# CONFIG_NLS_CODEPAGE_1251 is not set
+CONFIG_NLS_ASCII=y
+CONFIG_NLS_ISO8859_1=y
+# CONFIG_NLS_ISO8859_2 is not set
+# CONFIG_NLS_ISO8859_3 is not set
+# CONFIG_NLS_ISO8859_4 is not set
+# CONFIG_NLS_ISO8859_5 is not set
+# CONFIG_NLS_ISO8859_6 is not set
+# CONFIG_NLS_ISO8859_7 is not set
+# CONFIG_NLS_ISO8859_9 is not set
+# CONFIG_NLS_ISO8859_13 is not set
+# CONFIG_NLS_ISO8859_14 is not set
+CONFIG_NLS_ISO8859_15=y
+# CONFIG_NLS_KOI8_R is not set
+# CONFIG_NLS_KOI8_U is not set
+CONFIG_NLS_UTF8=y
+# CONFIG_DLM is not set
 
 #
 # Kernel hacking
 #
 CONFIG_TRACE_IRQFLAGS_SUPPORT=y
 # CONFIG_PRINTK_TIME is not set
-CONFIG_ENABLE_MUST_CHECK=y
-# CONFIG_MAGIC_SYSRQ is not set
+# CONFIG_ENABLE_WARN_DEPRECATED is not set
+# CONFIG_ENABLE_MUST_CHECK is not set
+CONFIG_FRAME_WARN=1024
+CONFIG_MAGIC_SYSRQ=y
 # CONFIG_UNUSED_SYMBOLS is not set
 # CONFIG_DEBUG_FS is not set
 # CONFIG_HEADERS_CHECK is not set
-# CONFIG_DEBUG_KERNEL is not set
-CONFIG_LOG_BUF_SHIFT=14
-CONFIG_CROSSCOMPILE=y
-CONFIG_CMDLINE="mem=48M"
+CONFIG_DEBUG_KERNEL=y
+# CONFIG_DEBUG_SHIRQ is not set
+# CONFIG_DETECT_SOFTLOCKUP is not set
+# CONFIG_SCHED_DEBUG is not set
+# CONFIG_SCHEDSTATS is not set
+CONFIG_TIMER_STATS=y
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
+# CONFIG_BOOT_PRINTK_DELAY is not set
+# CONFIG_RCU_TORTURE_TEST is not set
+# CONFIG_RCU_CPU_STALL_DETECTOR is not set
+# CONFIG_BACKTRACE_SELF_TEST is not set
+# CONFIG_DEBUG_BLOCK_EXT_DEVT is not set
+# CONFIG_FAULT_INJECTION is not set
+# CONFIG_PAGE_POISONING is not set
+CONFIG_TRACING_SUPPORT=y
+
+#
+# Tracers
+#
+# CONFIG_IRQSOFF_TRACER is not set
+# CONFIG_SCHED_TRACER is not set
+# CONFIG_CONTEXT_SWITCH_TRACER is not set
+# CONFIG_EVENT_TRACER is not set
+# CONFIG_BOOT_TRACER is not set
+# CONFIG_TRACE_BRANCH_PROFILING is not set
+# CONFIG_KMEMTRACE is not set
+# CONFIG_WORKQUEUE_TRACER is not set
+# CONFIG_BLK_DEV_IO_TRACE is not set
+# CONFIG_SAMPLES is not set
+CONFIG_HAVE_ARCH_KGDB=y
+# CONFIG_KGDB is not set
+CONFIG_CMDLINE="root=/dev/hda3 rootfstype=ext2 console=ttyS0,115200 console=tty video=au1200fb:panel:bs"
+# CONFIG_DEBUG_STACK_USAGE is not set
+# CONFIG_RUNTIME_DEBUG is not set
 
 #
 # Security options
@@ -1181,67 +1453,28 @@ CONFIG_CMDLINE="mem=48M"
 CONFIG_KEYS=y
 CONFIG_KEYS_DEBUG_PROC_KEYS=y
 # CONFIG_SECURITY is not set
-
-#
-# Cryptographic options
-#
-CONFIG_CRYPTO=y
-CONFIG_CRYPTO_ALGAPI=y
-CONFIG_CRYPTO_BLKCIPHER=m
-CONFIG_CRYPTO_HASH=m
-CONFIG_CRYPTO_MANAGER=m
-CONFIG_CRYPTO_HMAC=m
-CONFIG_CRYPTO_XCBC=m
-CONFIG_CRYPTO_NULL=m
-CONFIG_CRYPTO_MD4=m
-CONFIG_CRYPTO_MD5=y
-CONFIG_CRYPTO_SHA1=m
-CONFIG_CRYPTO_SHA256=m
-CONFIG_CRYPTO_SHA512=m
-CONFIG_CRYPTO_WP512=m
-CONFIG_CRYPTO_TGR192=m
-CONFIG_CRYPTO_GF128MUL=m
-CONFIG_CRYPTO_ECB=m
-CONFIG_CRYPTO_CBC=m
-CONFIG_CRYPTO_PCBC=m
-CONFIG_CRYPTO_LRW=m
-CONFIG_CRYPTO_DES=m
-CONFIG_CRYPTO_FCRYPT=m
-CONFIG_CRYPTO_BLOWFISH=m
-CONFIG_CRYPTO_TWOFISH=m
-CONFIG_CRYPTO_TWOFISH_COMMON=m
-CONFIG_CRYPTO_SERPENT=m
-CONFIG_CRYPTO_AES=m
-CONFIG_CRYPTO_CAST5=m
-CONFIG_CRYPTO_CAST6=m
-CONFIG_CRYPTO_TEA=m
-CONFIG_CRYPTO_ARC4=m
-CONFIG_CRYPTO_KHAZAD=m
-CONFIG_CRYPTO_ANUBIS=m
-CONFIG_CRYPTO_DEFLATE=m
-CONFIG_CRYPTO_MICHAEL_MIC=m
-CONFIG_CRYPTO_CRC32C=m
-CONFIG_CRYPTO_CAMELLIA=m
-# CONFIG_CRYPTO_TEST is not set
-
-#
-# Hardware crypto devices
-#
+CONFIG_SECURITYFS=y
+CONFIG_SECURITY_FILE_CAPABILITIES=y
+# CONFIG_CRYPTO is not set
+# CONFIG_BINARY_PRINTF is not set
 
 #
 # Library routines
 #
 CONFIG_BITREVERSE=y
-CONFIG_CRC_CCITT=y
+CONFIG_GENERIC_FIND_LAST_BIT=y
+# CONFIG_CRC_CCITT is not set
 # CONFIG_CRC16 is not set
+# CONFIG_CRC_T10DIF is not set
+# CONFIG_CRC_ITU_T is not set
 CONFIG_CRC32=y
-CONFIG_LIBCRC32C=y
+# CONFIG_CRC7 is not set
+# CONFIG_LIBCRC32C is not set
 CONFIG_ZLIB_INFLATE=y
 CONFIG_ZLIB_DEFLATE=y
-CONFIG_TEXTSEARCH=y
-CONFIG_TEXTSEARCH_KMP=m
-CONFIG_TEXTSEARCH_BM=m
-CONFIG_TEXTSEARCH_FSM=m
-CONFIG_PLIST=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
 CONFIG_HAS_IOMEM=y
 CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
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
diff --git a/sound/soc/au1x/Kconfig b/sound/soc/au1x/Kconfig
index 410a893..4b67140 100644
--- a/sound/soc/au1x/Kconfig
+++ b/sound/soc/au1x/Kconfig
@@ -22,11 +22,13 @@ config SND_SOC_AU1XPSC_AC97
 ##
 ## Boards
 ##
-config SND_SOC_SAMPLE_PSC_AC97
-	tristate "Sample Au12x0/Au1550 PSC AC97 sound machine"
+config SND_SOC_DB1200
+	tristate "DB1200 AC97+I2S audio support"
 	depends on SND_SOC_AU1XPSC
 	select SND_SOC_AU1XPSC_AC97
 	select SND_SOC_AC97_CODEC
+	select SND_SOC_AU1XPSC_I2S
+	select SND_SOC_WM8731
 	help
-	  This is a sample AC97 sound machine for use in Au12x0/Au1550
-	  based systems which have audio on PSC1 (e.g. Db1200 demoboard).
+	  Select this option to enable audio (AC97 or I2S) on the
+	  Alchemy/AMD/RMI DB1200 demoboard.
diff --git a/sound/soc/au1x/Makefile b/sound/soc/au1x/Makefile
index 6c6950b..1687307 100644
--- a/sound/soc/au1x/Makefile
+++ b/sound/soc/au1x/Makefile
@@ -8,6 +8,6 @@ obj-$(CONFIG_SND_SOC_AU1XPSC_I2S) += snd-soc-au1xpsc-i2s.o
 obj-$(CONFIG_SND_SOC_AU1XPSC_AC97) += snd-soc-au1xpsc-ac97.o
 
 # Boards
-snd-soc-sample-ac97-objs := sample-ac97.o
+snd-soc-db1200-objs := db1200.o
 
-obj-$(CONFIG_SND_SOC_SAMPLE_PSC_AC97) += snd-soc-sample-ac97.o
+obj-$(CONFIG_SND_SOC_DB1200) += snd-soc-db1200.o
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
new file mode 100644
index 0000000..a9d0512
--- /dev/null
+++ b/sound/soc/au1x/db1200.c
@@ -0,0 +1,192 @@
+/*
+ * DB1200 ASoC audio support code.
+ *
+ * (c) 2008 Manuel Lauss <mano@roarinelk.homelinux.net>
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/timer.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/soc-dapm.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+
+/* it sucks that the ASoC headers are not under include/ */
+#include "../codecs/ac97.h"
+#include "../codecs/wm8731.h"
+#include "psc.h"
+
+/*-------------------------  AC97 PART  ---------------------------*/
+
+static int db1200_ac97_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_sync(codec);
+	return 0;
+}
+
+static struct snd_soc_dai_link db1200_ac97_dai = {
+	.name		= "AC97",
+	.stream_name	= "AC97 HiFi",
+	.cpu_dai	= &au1xpsc_ac97_dai,
+	.codec_dai	= &ac97_dai,
+	.init		= db1200_ac97_init,
+};
+
+static struct snd_soc_card db1200_ac97_machine = {
+	.name		= "DB1200 AC97 Audio",
+	.dai_link	= &db1200_ac97_dai,
+	.num_links	= 1,
+	.platform	= &au1xpsc_soc_platform,
+};
+
+static struct snd_soc_device db1200_ac97_devdata = {
+	.card		= &db1200_ac97_machine,
+	.codec_dev	= &soc_codec_dev_ac97,
+};
+
+/*-------------------------  I2S PART  ---------------------------*/
+
+static int db1200_i2s_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_dai *cpu_dai = rtd->dai->cpu_dai;
+	int ret;
+
+	/* WM8731 has its own 12MHz crystal */
+	snd_soc_dai_set_sysclk(codec_dai, WM8731_SYSCLK,
+				12000000, SND_SOC_CLOCK_IN);
+
+	/* codec is bitclock and lrclk master */
+	ret = snd_soc_dai_set_fmt(codec_dai, SND_SOC_DAIFMT_LEFT_J |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		goto out;
+
+	ret = snd_soc_dai_set_fmt(cpu_dai, SND_SOC_DAIFMT_LEFT_J |
+			SND_SOC_DAIFMT_NB_NF | SND_SOC_DAIFMT_CBM_CFM);
+	if (ret < 0)
+		goto out;
+
+	ret = 0;
+out:
+	return ret;
+}
+
+static struct snd_soc_ops db1200_i2s_wm8731_ops = {
+	.startup	= db1200_i2s_startup,
+};
+
+static int db1200_i2s_init(struct snd_soc_codec *codec)
+{
+	snd_soc_dapm_sync(codec);
+	return 0;
+}
+
+static struct snd_soc_dai_link db1200_i2s_dai = {
+	.name		= "WM8731",
+	.stream_name	= "WM8731 PCM",
+	.cpu_dai	= &au1xpsc_i2s_dai,
+	.codec_dai	= &wm8731_dai,
+	.init		= db1200_i2s_init,
+	.ops		= &db1200_i2s_wm8731_ops,
+};
+
+static struct snd_soc_card db1200_i2s_machine = {
+	.name		= "DB1200 I2S Audio",
+	.dai_link	= &db1200_i2s_dai,
+	.num_links	= 1,
+	.platform	= &au1xpsc_soc_platform,
+};
+
+static struct snd_soc_device db1200_i2s_devdata = {
+	.card		= &db1200_i2s_machine,
+	.codec_dev	= &soc_codec_dev_wm8731,
+};
+
+/*-------------------------  COMMON PART  ---------------------------*/
+
+static struct resource psc1_res[] = {
+	[0] = {
+		.start	= CPHYSADDR(PSC1_BASE_ADDR),
+		.end	= CPHYSADDR(PSC1_BASE_ADDR) + 0x000fffff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1200_PSC1_INT,
+		.end	= AU1200_PSC1_INT,
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
+static struct platform_device *db1200_asoc_dev;
+
+static int __init db1200_audio_load(void)
+{
+	int ret;
+
+	/* clock comes from codecs */
+	au_writel(PSC_SEL_CLK_SERCLK, PSC1_BASE_ADDR + PSC_SEL_OFFSET);
+	au_sync();
+
+	ret = -ENOMEM;
+	db1200_asoc_dev = platform_device_alloc("soc-audio", -1);
+	if (!db1200_asoc_dev)
+		goto out;
+
+	db1200_asoc_dev->resource =
+		kmemdup(psc1_res, sizeof(struct resource) *
+			ARRAY_SIZE(psc1_res), GFP_KERNEL);
+	db1200_asoc_dev->num_resources = ARRAY_SIZE(psc1_res);
+	db1200_asoc_dev->id = 1;
+
+	/* I2S only when I2C is enabled too */
+	if ((bcsr->switches & 3) == BCSR_SWITCHES_DIP_8) {
+		bcsr->resets |= BCSR_RESETS_PSC1MUX;
+		platform_set_drvdata(db1200_asoc_dev, &db1200_i2s_devdata);
+	} else {
+		bcsr->resets &= ~BCSR_RESETS_PSC1MUX;
+		platform_set_drvdata(db1200_asoc_dev, &db1200_ac97_devdata);
+	}
+
+	db1200_ac97_devdata.dev = &db1200_asoc_dev->dev;
+	db1200_i2s_devdata.dev = &db1200_asoc_dev->dev;
+	ret = platform_device_add(db1200_asoc_dev);
+
+	if (ret) {
+		platform_device_put(db1200_asoc_dev);
+		db1200_asoc_dev = NULL;
+	}
+out:
+	return ret;
+}
+
+static void __exit db1200_audio_unload(void)
+{
+	platform_device_unregister(db1200_asoc_dev);
+}
+
+module_init(db1200_audio_load);
+module_exit(db1200_audio_unload);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("DB1200 ASoC audio support");
+MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
diff --git a/sound/soc/au1x/sample-ac97.c b/sound/soc/au1x/sample-ac97.c
deleted file mode 100644
index 27683eb..0000000
--- a/sound/soc/au1x/sample-ac97.c
+++ /dev/null
@@ -1,144 +0,0 @@
-/*
- * Sample Au12x0/Au1550 PSC AC97 sound machine.
- *
- * Copyright (c) 2007-2008 Manuel Lauss <mano@roarinelk.homelinux.net>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms outlined in the file COPYING at the root of this
- *  source archive.
- *
- * This is a very generic AC97 sound machine driver for boards which
- * have (AC97) audio at PSC1 (e.g. DB1200 demoboards).
- */
-
-#include <linux/module.h>
-#include <linux/moduleparam.h>
-#include <linux/timer.h>
-#include <linux/interrupt.h>
-#include <linux/platform_device.h>
-#include <sound/core.h>
-#include <sound/pcm.h>
-#include <sound/soc.h>
-#include <sound/soc-dapm.h>
-#include <asm/mach-au1x00/au1000.h>
-#include <asm/mach-au1x00/au1xxx_psc.h>
-#include <asm/mach-au1x00/au1xxx_dbdma.h>
-
-#include "../codecs/ac97.h"
-#include "psc.h"
-
-static int au1xpsc_sample_ac97_init(struct snd_soc_codec *codec)
-{
-	snd_soc_dapm_sync(codec);
-	return 0;
-}
-
-static struct snd_soc_dai_link au1xpsc_sample_ac97_dai = {
-	.name		= "AC97",
-	.stream_name	= "AC97 HiFi",
-	.cpu_dai	= &au1xpsc_ac97_dai,	/* see psc-ac97.c */
-	.codec_dai	= &ac97_dai,		/* see codecs/ac97.c */
-	.init		= au1xpsc_sample_ac97_init,
-	.ops		= NULL,
-};
-
-static struct snd_soc_card au1xpsc_sample_ac97_machine = {
-	.name		= "Au1xxx PSC AC97 Audio",
-	.dai_link	= &au1xpsc_sample_ac97_dai,
-	.num_links	= 1,
-};
-
-static struct snd_soc_device au1xpsc_sample_ac97_devdata = {
-	.card		= &au1xpsc_sample_ac97_machine,
-	.platform	= &au1xpsc_soc_platform, /* see dbdma2.c */
-	.codec_dev	= &soc_codec_dev_ac97,
-};
-
-static struct resource au1xpsc_psc1_res[] = {
-	[0] = {
-		.start	= CPHYSADDR(PSC1_BASE_ADDR),
-		.end	= CPHYSADDR(PSC1_BASE_ADDR) + 0x000fffff,
-		.flags	= IORESOURCE_MEM,
-	},
-	[1] = {
-#ifdef CONFIG_SOC_AU1200
-		.start	= AU1200_PSC1_INT,
-		.end	= AU1200_PSC1_INT,
-#elif defined(CONFIG_SOC_AU1550)
-		.start	= AU1550_PSC1_INT,
-		.end	= AU1550_PSC1_INT,
-#endif
-		.flags	= IORESOURCE_IRQ,
-	},
-	[2] = {
-		.start	= DSCR_CMD0_PSC1_TX,
-		.end	= DSCR_CMD0_PSC1_TX,
-		.flags	= IORESOURCE_DMA,
-	},
-	[3] = {
-		.start	= DSCR_CMD0_PSC1_RX,
-		.end	= DSCR_CMD0_PSC1_RX,
-		.flags	= IORESOURCE_DMA,
-	},
-};
-
-static struct platform_device *au1xpsc_sample_ac97_dev;
-
-static int __init au1xpsc_sample_ac97_load(void)
-{
-	int ret;
-
-#ifdef CONFIG_SOC_AU1200
-	unsigned long io;
-
-	/* modify sys_pinfunc for AC97 on PSC1 */
-	io = au_readl(SYS_PINFUNC);
-	io |= SYS_PINFUNC_P1C;
-	io &= ~(SYS_PINFUNC_P1A | SYS_PINFUNC_P1B);
-	au_writel(io, SYS_PINFUNC);
-	au_sync();
-#endif
-
-	ret = -ENOMEM;
-
-	/* setup PSC clock source for AC97 part: external clock provided
-	 * by codec.  The psc-ac97.c driver depends on this setting!
-	 */
-	au_writel(PSC_SEL_CLK_SERCLK, PSC1_BASE_ADDR + PSC_SEL_OFFSET);
-	au_sync();
-
-	au1xpsc_sample_ac97_dev = platform_device_alloc("soc-audio", -1);
-	if (!au1xpsc_sample_ac97_dev)
-		goto out;
-
-	au1xpsc_sample_ac97_dev->resource =
-		kmemdup(au1xpsc_psc1_res, sizeof(struct resource) *
-			ARRAY_SIZE(au1xpsc_psc1_res), GFP_KERNEL);
-	au1xpsc_sample_ac97_dev->num_resources = ARRAY_SIZE(au1xpsc_psc1_res);
-	au1xpsc_sample_ac97_dev->id = 1;
-
-	platform_set_drvdata(au1xpsc_sample_ac97_dev,
-			     &au1xpsc_sample_ac97_devdata);
-	au1xpsc_sample_ac97_devdata.dev = &au1xpsc_sample_ac97_dev->dev;
-	ret = platform_device_add(au1xpsc_sample_ac97_dev);
-
-	if (ret) {
-		platform_device_put(au1xpsc_sample_ac97_dev);
-		au1xpsc_sample_ac97_dev = NULL;
-	}
-
-out:
-	return ret;
-}
-
-static void __exit au1xpsc_sample_ac97_exit(void)
-{
-	platform_device_unregister(au1xpsc_sample_ac97_dev);
-}
-
-module_init(au1xpsc_sample_ac97_load);
-module_exit(au1xpsc_sample_ac97_exit);
-
-MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("Au1xxx PSC sample AC97 machine");
-MODULE_AUTHOR("Manuel Lauss <mano@roarinelk.homelinux.net>");
-- 
1.6.2
