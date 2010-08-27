Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Aug 2010 17:57:13 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:51968 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491821Ab0H0P4P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 27 Aug 2010 17:56:15 +0200
Received: by mail-bw0-f49.google.com with SMTP id 13so2526676bwz.36
        for <linux-mips@linux-mips.org>; Fri, 27 Aug 2010 08:56:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=U7KkxAfeabouqLXlQvhI2/tyILAmo6Rbk42qYs1JLV8=;
        b=LnBTZv6OpLYBakl+q2gdvNZ2YtqgSHy0Q4WGr8pKyODBDvPGHuZu+mT+RVKi0ZeOhE
         EwUkHcSIFvgtSFwsHY9QSisNBl72hAilBK6zvYc6puMWw6LkZCiiROuO70QN3mvgFe9r
         t/lTzi8m5sJ/esOf4OXBPIIOuizra5zM8yE+g=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=IlNRKsYApSry+qRNF3I9jtceTqZ4mWvpU0hEXxNxX6O1+M7x0WNwENJ0IgXFqC0ZYy
         JQsby2/jqyjRLj3YDNb2uRvyBxr+O+R3vZLGCg/0P9W+QJcd3uGyszlQS2Q87wP7gNJX
         oDJkZ7mCvYvycLAYinvXPkvlDGvYVj/MmpxJU=
Received: by 10.204.60.133 with SMTP id p5mr655967bkh.71.1282924575275;
        Fri, 27 Aug 2010 08:56:15 -0700 (PDT)
Received: from localhost.localdomain (fnoeppeil48.netpark.at [217.175.205.176])
        by mx.google.com with ESMTPS id 24sm2683051bkr.19.2010.08.27.08.56.13
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 27 Aug 2010 08:56:13 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 2/2] MIPS: Alchemy: DB1300 support
Date:   Fri, 27 Aug 2010 17:56:05 +0200
Message-Id: <1282924565-16024-3-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.2
In-Reply-To: <1282924565-16024-1-git-send-email-manuel.lauss@googlemail.com>
References: <1282924565-16024-1-git-send-email-manuel.lauss@googlemail.com>
Return-Path: <manuel.lauss@googlemail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27684
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips

Basic support for the DB1300 board.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
What works:
- Ethernet, PCMCIA, serial ports, IDE connector (PIO only),
  NOR/NAND flashes, the 5-way switch, RTC, I2C.
- Both AC97 and I2S also work, but depend on the ASoC multi-component
  work scheduled for 2.6.37.  A separate patch will be sent in time.
- other stuff still missing (MMC/SD needs driver updates,
  USB requires new glue code, display untested but I see no reason
  why it should not work).

 arch/mips/alchemy/Kconfig                     |    8 +
 arch/mips/alchemy/Platform                    |    7 +
 arch/mips/alchemy/devboards/Makefile          |    1 +
 arch/mips/alchemy/devboards/db1300/Makefile   |    1 +
 arch/mips/alchemy/devboards/db1300/platform.c |  605 +++++++++++++++++++++++++
 arch/mips/alchemy/devboards/db1300/setup.c    |  259 +++++++++++
 arch/mips/alchemy/devboards/prom.c            |    4 +
 arch/mips/boot/compressed/uart-alchemy.c      |    5 +-
 arch/mips/configs/db1300_defconfig            |  280 ++++++++++++
 arch/mips/include/asm/mach-db1x00/bcsr.h      |    5 +-
 arch/mips/include/asm/mach-db1x00/db1300.h    |   40 ++
 arch/mips/include/asm/mach-db1x00/irq.h       |   23 +
 drivers/pcmcia/Kconfig                        |    4 +-
 drivers/pcmcia/db1xxx_ss.c                    |   30 +-
 14 files changed, 1263 insertions(+), 9 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/db1300/Makefile
 create mode 100644 arch/mips/alchemy/devboards/db1300/platform.c
 create mode 100644 arch/mips/alchemy/devboards/db1300/setup.c
 create mode 100644 arch/mips/configs/db1300_defconfig
 create mode 100644 arch/mips/include/asm/mach-db1x00/db1300.h
 create mode 100644 arch/mips/include/asm/mach-db1x00/irq.h

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index 21b232c..ec3a8c4 100644
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
diff --git a/arch/mips/alchemy/Platform b/arch/mips/alchemy/Platform
index 96e9e41..85699c7 100644
--- a/arch/mips/alchemy/Platform
+++ b/arch/mips/alchemy/Platform
@@ -75,6 +75,13 @@ cflags-$(CONFIG_MIPS_DB1200)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
 load-$(CONFIG_MIPS_DB1200)	+= 0xffffffff80100000
 
 #
+# NetLogic DBAu1300 development platform
+#
+platform-$(CONFIG_MIPS_DB1300)	+= alchemy/devboards/
+cflags-$(CONFIG_MIPS_DB1300)	+= -I$(srctree)/arch/mips/include/asm/mach-db1x00
+load-$(CONFIG_MIPS_DB1300)	+= 0xffffffff80100000
+
+#
 # AMD Alchemy Bosporus eval board
 #
 platform-$(CONFIG_MIPS_BOSPORUS) += alchemy/devboards/
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index 826449c..18193c2 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -16,3 +16,4 @@ obj-$(CONFIG_MIPS_DB1500)	+= db1x00/
 obj-$(CONFIG_MIPS_DB1550)	+= db1x00/
 obj-$(CONFIG_MIPS_BOSPORUS)	+= db1x00/
 obj-$(CONFIG_MIPS_MIRAGE)	+= db1x00/
+obj-$(CONFIG_MIPS_DB1300)	+= db1300/
diff --git a/arch/mips/alchemy/devboards/db1300/Makefile b/arch/mips/alchemy/devboards/db1300/Makefile
new file mode 100644
index 0000000..b07e182
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1300/Makefile
@@ -0,0 +1 @@
+obj-y := setup.o platform.o
diff --git a/arch/mips/alchemy/devboards/db1300/platform.c b/arch/mips/alchemy/devboards/db1300/platform.c
new file mode 100644
index 0000000..745f715
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1300/platform.c
@@ -0,0 +1,605 @@
+/*
+ * DBAu1300 platform initialization
+ *
+ * (c) 2009 Manuel Lauss <manuel.lauss@gmail.com>
+ */
+
+#include <linux/dma-mapping.h>
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
+#include "../platform.h"
+
+static struct i2c_board_info db1300_i2c_devs[] __initdata = {
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
+	.id		= 1,
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
+	.id		= 2,
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
+/**********************************************************************/
+
+/* key assignment according to db1300 schematic sheet #4 */
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
+		.gpio			= AU1300_PIN_WAKE3,
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
+		.gpio			= AU1300_PIN_WAKE1,
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
+/* same bugs as its 5-year-old predecessor, the db1200 */
+static irqreturn_t db1300_mmc_cd(int irq, void *ptr)
+{
+	void(*mmc_cd)(struct mmc_host *, unsigned long);
+
+	if (irq == DB1300_SD1_INSERT_INT) {
+		disable_irq_nosync(DB1300_SD1_INSERT_INT);
+		enable_irq(DB1300_SD1_EJECT_INT);
+	} else {
+		disable_irq_nosync(DB1300_SD1_EJECT_INT);
+		enable_irq(DB1300_SD1_INSERT_INT);
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
+static int db1300_mmc_cd_setup(void *mmc_host, int en)
+{
+	int ret;
+
+	if (en) {
+		ret = request_irq(DB1300_SD1_INSERT_INT, db1300_mmc_cd,
+				  IRQF_DISABLED, "sd_insert", mmc_host);
+		if (ret)
+			goto out;
+
+		ret = request_irq(DB1300_SD1_EJECT_INT, db1300_mmc_cd,
+				  IRQF_DISABLED, "sd_eject", mmc_host);
+		if (ret) {
+			free_irq(DB1300_SD1_INSERT_INT, mmc_host);
+			goto out;
+		}
+
+		if (bcsr_read(BCSR_SIGSTAT) & (1 << 12))
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
+static int db1300_mmc_card_readonly(void *mmc_host)
+{
+	return !!(bcsr_read(BCSR_STATUS) & (1 << 10));
+}
+
+static int db1300_mmc_card_inserted(void *mmc_host)
+{
+	return !!(bcsr_read(BCSR_SIGSTAT) & (1 << 12));
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
+		.start	= DSCR_CMD0_SDMS_TX1,
+		.end	= DSCR_CMD0_SDMS_TX1,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= DSCR_CMD0_SDMS_RX1,
+		.end	= DSCR_CMD0_SDMS_RX1,
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
+	return 1;	/* it's soldered on */
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
+		.start	= AU1300_SD0_PHYS_ADDR,
+		.end	= AU1300_SD0_PHYS_ADDR,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1300_SD0_INT,
+		.end	= AU1300_SD0_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= DSCR_CMD0_SDMS_TX0,
+		.end	= DSCR_CMD0_SDMS_TX0,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= DSCR_CMD0_SDMS_RX0,
+		.end	= DSCR_CMD0_SDMS_RX0,
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
+	.id		= 1,	/* ID of PSC with AC97 controller on it */
+};
+
+/**********************************************************************/
+
+static struct platform_device *db1300_devs[] = {
+	&db1300_eth_dev,
+	&db1300_i2c_dev,
+	&db1300_5waysw_dev,
+	&db1300_rtc_dev,
+	&db1300_nand_dev,
+	&db1300_ide_dev,
+	&db1300_sd0_dev,
+	&db1300_sd1_dev,
+	&db1300_ac97_dev,
+	&db1300_i2s_dev,
+	&db1300_wm9715_dev,
+};
+
+static int __init db1300_device_init(void)
+{
+	int swapped;
+
+	/* MAC address is stored by YAMON */
+	prom_get_ethernet_addr(&db1300_eth_config.mac[0]);
+
+	i2c_register_board_info(0, db1300_i2c_devs,
+				ARRAY_SIZE(db1300_i2c_devs));
+
+	/* Audio PSC clock is supplied by codecs (PSC1, 2) */
+	__raw_writel(PSC_SEL_CLK_SERCLK,
+		(void __iomem *)KSEG1ADDR(AU1300_PSC1_PHYS_ADDR) + PSC_SEL_OFFSET);
+	__raw_writel(PSC_SEL_CLK_SERCLK,
+		(void __iomem *)KSEG1ADDR(AU1300_PSC2_PHYS_ADDR) + PSC_SEL_OFFSET);
+	/* I2C uses internal 48MHz EXTCLK1 */
+	__raw_writel(PSC_SEL_CLK_INTCLK,
+		(void __iomem *)KSEG1ADDR(AU1300_PSC3_PHYS_ADDR) + PSC_SEL_OFFSET);
+	wmb();
+
+	db1x_register_pcmcia_socket(PCMCIA_ATTR_PHYS_ADDR,
+				    PCMCIA_ATTR_PHYS_ADDR + 0x00400000 - 1,
+				    PCMCIA_MEM_PHYS_ADDR,
+				    PCMCIA_MEM_PHYS_ADDR  + 0x00400000 - 1,
+				    PCMCIA_IO_PHYS_ADDR,
+				    PCMCIA_IO_PHYS_ADDR   + 0x00010000 - 1,
+				    DB1300_CF_INT,
+				    DB1300_CF_INSERT_INT,
+				    0,
+				    DB1300_CF_EJECT_INT,
+				    1);	/* regbits of socket 1 */
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
index 0000000..b6ff01c
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1300/setup.c
@@ -0,0 +1,259 @@
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
+static inline void enable_uart(unsigned long phys)
+{
+	void __iomem *addr = (void __iomem *)KSEG1ADDR(phys);
+
+	/* reset, enable clock, deassert reset */
+	__raw_writel(0, addr + 0x100);
+	wmb();
+	__raw_writel(1, addr + 0x100);
+	wmb();
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
+}
+
+/**********************************************************************/
+
+/*
+ * This code, taken from the RMI sources, seems to be the only way to get
+ * the DB1300 CPLD irq multiplexer to work reliably under linux.
+ */
+static struct mutex __cscmtx;
+static int __cscirq, __cscfirst, __cscusecnt;
+static void __iomem *__bcsr_virt;
+
+static irqreturn_t db1300_csc_handler(int irq, void *dev_id)
+{
+	unsigned short bisr = __raw_readw(__bcsr_virt + BCSR_REG_INTSTAT);
+
+	__raw_writew(bisr, __bcsr_virt + BCSR_REG_INTSTAT);
+	wmb();
+
+	for ( ; bisr; bisr &= bisr - 1)
+		generic_handle_irq(__cscfirst + __ffs(bisr));
+
+	return IRQ_HANDLED;
+}
+static void db1300_csc_mask(unsigned int irq)
+{
+	__raw_writew(1 << (irq - __cscfirst), __bcsr_virt + BCSR_REG_MASKCLR);
+	wmb();
+}
+
+static void db1300_csc_unmask(unsigned int irq)
+{
+	__raw_writew(1 << (irq - __cscfirst), __bcsr_virt + BCSR_REG_MASKSET);
+	wmb();
+}
+
+static void db1300_csc_enable(unsigned int irq)
+{
+	__raw_writew(1 << (irq - __cscfirst), __bcsr_virt + BCSR_REG_INTSET);
+	db1300_csc_unmask(irq);
+}
+
+static void db1300_csc_disable(unsigned int irq)
+{
+	__raw_writew(1 << (irq - __cscfirst), __bcsr_virt + BCSR_REG_INTCLR);
+	db1300_csc_mask(irq);
+}
+
+static unsigned int db1300_csc_startup(unsigned int irq)
+{
+	int retval = 0;
+
+	mutex_lock(&__cscmtx);
+	if ((++__cscusecnt) == 1)
+		retval = request_irq(__cscirq, &db1300_csc_handler,
+				     IRQF_TRIGGER_HIGH, "csc", 0);
+	mutex_unlock(&__cscmtx);
+
+	db1300_csc_enable(irq);
+	db1300_csc_unmask(irq);
+
+	return retval;
+}
+
+static void db1300_csc_shutdown(unsigned int irq)
+{
+	db1300_csc_mask(irq);
+	db1300_csc_disable(irq);
+
+	mutex_lock(&__cscmtx);
+	if ((--__cscusecnt) == 0)
+		free_irq(__cscirq, &db1300_csc_handler);
+	mutex_unlock(&__cscmtx);
+}
+
+static struct irq_chip db1300_csc_irq_type = {
+	.name		= "DB1300",
+	.startup	= db1300_csc_startup,
+	.shutdown	= db1300_csc_shutdown,
+	.mask		= db1300_csc_mask,
+	.enable		= db1300_csc_enable,
+	.disable	= db1300_csc_disable,
+	.unmask		= db1300_csc_unmask,
+	.mask_ack	= db1300_csc_mask
+};
+
+static void __init db1300_init_irq(int first, int last, int csc)
+{
+	int irq;
+
+	__bcsr_virt = (void __iomem *)KSEG1ADDR(DB1300_BCSR_PHYS_ADDR);
+	__cscirq = csc;
+	__cscfirst = first;
+	mutex_init(&__cscmtx);
+
+	__raw_writew(0xffff, __bcsr_virt + BCSR_REG_INTCLR);
+	__raw_writew(0xffff, __bcsr_virt + BCSR_REG_MASKCLR);
+	__raw_writew(0xffff, __bcsr_virt + BCSR_REG_INTSTAT);
+	wmb();
+
+	for (irq = first; irq <= last; irq++) {
+		set_irq_chip_and_handler(irq, &db1300_csc_irq_type,
+					 handle_level_irq);
+		db1300_csc_disable(irq);
+	}
+}
+
+
+static int __init db1300_arch_init(void)
+{
+	int cpldirq;
+
+	cpldirq = au1300_gpio_to_irq(AU1300_PIN_EXTCLK1);
+
+	set_irq_type(cpldirq, IRQF_TRIGGER_HIGH);
+	au1300_set_irq_priority(cpldirq, 3);
+
+	db1300_init_irq(DB1300_FIRST_INT, DB1300_LAST_INT, cpldirq);
+
+	/* insert/eject IRQs: one always triggers so don't enable them
+	 * when doing request_irq() on them.  DB1200 has this bug too.
+	 */
+	irq_to_desc(DB1300_SD1_INSERT_INT)->status |= IRQ_NOAUTOEN;
+	irq_to_desc(DB1300_SD1_EJECT_INT)->status |= IRQ_NOAUTOEN;
+	irq_to_desc(DB1300_CF_INSERT_INT)->status |= IRQ_NOAUTOEN;
+	irq_to_desc(DB1300_CF_EJECT_INT)->status |= IRQ_NOAUTOEN;
+
+	return 0;
+}
+arch_initcall(db1300_arch_init);
diff --git a/arch/mips/alchemy/devboards/prom.c b/arch/mips/alchemy/devboards/prom.c
index b30df5c..80aef08 100644
--- a/arch/mips/alchemy/devboards/prom.c
+++ b/arch/mips/alchemy/devboards/prom.c
@@ -63,5 +63,9 @@ void __init prom_init(void)
 
 void prom_putchar(unsigned char c)
 {
+#ifdef CONFIG_MIPS_DB1300
+	alchemy_uart_putchar(AU1300_UART2_PHYS_ADDR, c);
+#else
     alchemy_uart_putchar(UART0_PHYS_ADDR, c);
+#endif
 }
diff --git a/arch/mips/boot/compressed/uart-alchemy.c b/arch/mips/boot/compressed/uart-alchemy.c
index 1bff22f..e7b1150 100644
--- a/arch/mips/boot/compressed/uart-alchemy.c
+++ b/arch/mips/boot/compressed/uart-alchemy.c
@@ -2,6 +2,9 @@
 
 void putc(char c)
 {
-	/* all current (Jan. 2010) in-kernel boards */
+#ifndef CONFIG_MIPS_DB1300
 	alchemy_uart_putchar(UART0_PHYS_ADDR, c);
+#else
+	alchemy_uart_putchar(AU1300_UART2_PHYS_ADDR, c);
+#endif
 }
diff --git a/arch/mips/configs/db1300_defconfig b/arch/mips/configs/db1300_defconfig
new file mode 100644
index 0000000..a11be75
--- /dev/null
+++ b/arch/mips/configs/db1300_defconfig
@@ -0,0 +1,280 @@
+CONFIG_MIPS=y
+CONFIG_MIPS_ALCHEMY=y
+CONFIG_ALCHEMY_GPIOINT_AU1300=y
+CONFIG_MIPS_DB1300=y
+CONFIG_SOC_AU1300=y
+CONFIG_LOONGSON_UART_BASE=y
+CONFIG_RWSEM_GENERIC_SPINLOCK=y
+CONFIG_ARCH_SUPPORTS_OPROFILE=y
+CONFIG_GENERIC_FIND_NEXT_BIT=y
+CONFIG_GENERIC_HWEIGHT=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
+CONFIG_GENERIC_CLOCKEVENTS=y
+CONFIG_GENERIC_CMOS_UPDATE=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_GENERIC_HARDIRQS_NO__DO_IRQ=y
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
+CONFIG_CPU_HAS_PREFETCH=y
+CONFIG_MIPS_MT_DISABLED=y
+CONFIG_64BIT_PHYS_ADDR=y
+CONFIG_ARCH_PHYS_ADDR_T_64BIT=y
+CONFIG_CPU_HAS_SYNC=y
+CONFIG_GENERIC_HARDIRQS=y
+CONFIG_GENERIC_IRQ_PROBE=y
+CONFIG_CPU_SUPPORTS_HIGHMEM=y
+CONFIG_ARCH_FLATMEM_ENABLE=y
+CONFIG_ARCH_POPULATES_NODE_MAP=y
+CONFIG_SELECT_MEMORY_MODEL=y
+CONFIG_FLATMEM_MANUAL=y
+CONFIG_FLATMEM=y
+CONFIG_FLAT_NODE_MEM_MAP=y
+CONFIG_PAGEFLAGS_EXTENDED=y
+CONFIG_SPLIT_PTLOCK_CPUS=4
+CONFIG_PHYS_ADDR_T_64BIT=y
+CONFIG_ZONE_DMA_FLAG=0
+CONFIG_VIRT_TO_BUS=y
+CONFIG_DEFAULT_MMAP_MIN_ADDR=4096
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
+CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
+CONFIG_CROSS_COMPILE=""
+CONFIG_LOCALVERSION=""
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
+CONFIG_TINY_RCU=y
+CONFIG_LOG_BUF_SHIFT=17
+CONFIG_SYSCTL=y
+CONFIG_ANON_INODES=y
+CONFIG_EMBEDDED=y
+CONFIG_KALLSYMS=y
+CONFIG_KALLSYMS_ALL=y
+CONFIG_KALLSYMS_EXTRA_PASS=y
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
+CONFIG_SLAB=y
+CONFIG_HAVE_OPROFILE=y
+CONFIG_HAVE_KPROBES=y
+CONFIG_HAVE_KRETPROBES=y
+CONFIG_HAVE_GENERIC_DMA_COHERENT=y
+CONFIG_SLABINFO=y
+CONFIG_RT_MUTEXES=y
+CONFIG_BASE_SMALL=0
+CONFIG_MODULES=y
+CONFIG_MODULE_UNLOAD=y
+CONFIG_BLOCK=y
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
+CONFIG_TRAD_SIGNALS=y
+CONFIG_ARCH_HIBERNATION_POSSIBLE=y
+CONFIG_ARCH_SUSPEND_POSSIBLE=y
+CONFIG_NET=y
+CONFIG_PACKET=y
+CONFIG_UNIX=y
+CONFIG_INET=y
+CONFIG_IP_MULTICAST=y
+CONFIG_IP_FIB_HASH=y
+CONFIG_IP_PNP=y
+CONFIG_IP_PNP_DHCP=y
+CONFIG_INET_LRO=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
+CONFIG_EXTRA_FIRMWARE=""
+CONFIG_MTD=y
+CONFIG_MTD_PARTITIONS=y
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
+CONFIG_HAVE_IDE=y
+CONFIG_IDE=y
+CONFIG_IDE_GD=y
+CONFIG_IDE_GD_ATA=y
+CONFIG_BLK_DEV_IDECS=y
+CONFIG_IDE_TASK_IOCTL=y
+CONFIG_BLK_DEV_PLATFORM=y
+CONFIG_SCSI_MOD=y
+CONFIG_NETDEVICES=y
+CONFIG_PHYLIB=y
+CONFIG_SMSC_PHY=y
+CONFIG_NET_ETHERNET=y
+CONFIG_MII=y
+CONFIG_SMSC911X=y
+CONFIG_INPUT=y
+CONFIG_INPUT_EVDEV=y
+CONFIG_INPUT_KEYBOARD=y
+CONFIG_KEYBOARD_GPIO=y
+CONFIG_INPUT_MISC=y
+CONFIG_INPUT_UINPUT=y
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+CONFIG_VT_HW_CONSOLE_BINDING=y
+CONFIG_DEVKMEM=y
+CONFIG_SERIAL_8250=y
+CONFIG_SERIAL_8250_CONSOLE=y
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+CONFIG_I2C_CHARDEV=y
+CONFIG_I2C_AU1550=y
+CONFIG_ARCH_WANT_OPTIONAL_GPIOLIB=y
+CONFIG_HWMON=y
+CONFIG_HWMON_VID=y
+CONFIG_SENSORS_ADM1025=y
+CONFIG_DUMMY_CONSOLE=y
+CONFIG_RTC_LIB=y
+CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
+CONFIG_RTC_DRV_AU1XXX=y
+CONFIG_EXT2_FS=y
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY_USER=y
+CONFIG_FAT_FS=y
+CONFIG_VFAT_FS=y
+CONFIG_FAT_DEFAULT_CODEPAGE=437
+CONFIG_FAT_DEFAULT_IOCHARSET="iso8859-1"
+CONFIG_PROC_FS=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_SYSFS=y
+CONFIG_TMPFS=y
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
+CONFIG_ENABLE_WARN_DEPRECATED=y
+CONFIG_ENABLE_MUST_CHECK=y
+CONFIG_FRAME_WARN=1024
+CONFIG_STRIP_ASM_SYMS=y
+CONFIG_DEBUG_KERNEL=y
+CONFIG_DEBUG_INFO=y
+CONFIG_HAVE_FUNCTION_TRACER=y
+CONFIG_HAVE_FUNCTION_GRAPH_TRACER=y
+CONFIG_HAVE_FUNCTION_TRACE_MCOUNT_TEST=y
+CONFIG_HAVE_DYNAMIC_FTRACE=y
+CONFIG_HAVE_FTRACE_MCOUNT_RECORD=y
+CONFIG_TRACING_SUPPORT=y
+CONFIG_HAVE_ARCH_KGDB=y
+CONFIG_EARLY_PRINTK=y
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="console=ttyS2,115200"
+CONFIG_DEBUG_ZBOOT=y
+CONFIG_SECURITYFS=y
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_DEFAULT_SECURITY=""
+CONFIG_BITREVERSE=y
+CONFIG_GENERIC_FIND_LAST_BIT=y
+CONFIG_CRC32=y
+CONFIG_HAS_IOMEM=y
+CONFIG_HAS_IOPORT=y
+CONFIG_HAS_DMA=y
+CONFIG_NLATTR=y
diff --git a/arch/mips/include/asm/mach-db1x00/bcsr.h b/arch/mips/include/asm/mach-db1x00/bcsr.h
index 618d2de..c8d9820 100644
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
@@ -118,7 +121,7 @@ enum bcsr_whoami_boards {
 #define BCSR_STATUS_SRAMWIDTH		0x0080
 #define BCSR_STATUS_FLASHBUSY		0x0100
 #define BCSR_STATUS_ROMBUSY		0x0400
-#define BCSR_STATUS_SD0WP		0x0400	/* DB1200 */
+#define BCSR_STATUS_SD0WP		0x0400	/* DB1200/DB1300:SD1 */
 #define BCSR_STATUS_SD1WP		0x0800
 #define BCSR_STATUS_USBOTGID		0x0800	/* PB/DB1550 */
 #define BCSR_STATUS_DB1000_SWAPBOOT	0x2000
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
index c80a7a6..fb247b5 100644
--- a/drivers/pcmcia/Kconfig
+++ b/drivers/pcmcia/Kconfig
@@ -165,8 +165,8 @@ config PCMCIA_ALCHEMY_DEVBOARD
 	select 64BIT_PHYS_ADDR
 	help
 	  Enable this driver of you want PCMCIA support on your Alchemy
-	  Db1000, Db/Pb1100, Db/Pb1500, Db/Pb1550, Db/Pb1200 board.
-	  NOT suitable for the PB1000!
+	  Db1000, Db/Pb1100, Db/Pb1500, Db/Pb1550, Db/Pb1200, DB1300
+	  board.  NOT suitable for the PB1000!
 
 	  This driver is also available as a module called db1xxx_ss.ko
 
diff --git a/drivers/pcmcia/db1xxx_ss.c b/drivers/pcmcia/db1xxx_ss.c
index 27575e63..7c9ce38 100644
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
 
@@ -319,7 +330,7 @@ static int db1x_pcmcia_get_status(struct pcmcia_socket *skt,
 	unsigned short cr, sr;
 	unsigned int status;
 
-	status = db1x_card_inserted(sock) ? SS_DETECT : 0;
+	status = 0;
 
 	cr = bcsr_read(BCSR_PCMCIA);
 	sr = bcsr_read(BCSR_STATUS);
@@ -342,6 +353,12 @@ static int db1x_pcmcia_get_status(struct pcmcia_socket *skt,
 	/* if Vcc is not zero, we have applied power to a card */
 	status |= GET_VCC(cr, sock->nr) ? SS_POWERON : 0;
 
+	/* DB1300: power is always on */
+	if (sock->board_type == BOARD_TYPE_DB1300)
+		status = SS_POWERON | SS_3VCARD;
+
+	status |= db1x_card_inserted(sock) ? SS_DETECT : 0;
+
 	/* reset de-asserted? then we're ready */
 	status |= (GET_RESET(cr, sock->nr)) ? SS_READY : SS_RESET;
 
@@ -418,6 +435,9 @@ static int __devinit db1x_pcmcia_socket_probe(struct platform_device *pdev)
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
1.7.2
