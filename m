Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 20:06:54 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:32904 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903685Ab1KATEU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2011 20:04:20 +0100
Received: by mail-fx0-f49.google.com with SMTP id q17so947590faa.36
        for <multiple recipients>; Tue, 01 Nov 2011 12:04:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=BURN+l+VN+uFQdnSuLnfhpeMCIPeW7KlskFdcEsn/pI=;
        b=re1J8QFPjBU2nBF/XF2FOBMF/rBiOpNLyBaVqXgIYAKfSBzsM/oWOBPbZC1leVNzLk
         mFwxGiSn38+zq9U/+UK8mUBTPVgs1H2c/PaAiVXpU8Ta2LnYyaXialN5Ea+7vCwkrefU
         6KwhEXbNswqJKenB4iwAXFAEnbD7JJKD2qANs=
Received: by 10.223.5.66 with SMTP id 2mr2492101fau.26.1320174260013;
        Tue, 01 Nov 2011 12:04:20 -0700 (PDT)
Received: from localhost.localdomain (188-22-150-81.adsl.highway.telekom.at. [188.22.150.81])
        by mx.google.com with ESMTPS id a8sm327916faa.11.2011.11.01.12.04.16
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 12:04:18 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 06/18] MIPS: Alchemy: better DB1550 support
Date:   Tue,  1 Nov 2011 20:03:32 +0100
Message-Id: <1320174224-27305-7-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31346
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 656

Improved DB1550 support, with audio and serial busses.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/Kconfig                        |    2 +-
 arch/mips/alchemy/devboards/Makefile             |    2 +-
 arch/mips/alchemy/devboards/db1550.c             |  506 ++++++++++++++++++++++
 arch/mips/alchemy/devboards/db1x00/board_setup.c |   24 +-
 arch/mips/alchemy/devboards/db1x00/platform.c    |   61 +---
 arch/mips/configs/db1550_defconfig               |  288 +++++++++----
 arch/mips/include/asm/mach-db1x00/bcsr.h         |    2 +-
 arch/mips/include/asm/mach-db1x00/db1x00.h       |   16 -
 sound/soc/au1x/Kconfig                           |    4 +-
 sound/soc/au1x/db1200.c                          |   34 ++-
 10 files changed, 763 insertions(+), 176 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/db1550.c

diff --git a/arch/mips/alchemy/Kconfig b/arch/mips/alchemy/Kconfig
index f9a13be..a1b995f 100644
--- a/arch/mips/alchemy/Kconfig
+++ b/arch/mips/alchemy/Kconfig
@@ -71,7 +71,7 @@ config MIPS_DB1550
 	bool "Alchemy DB1550 board"
 	select ALCHEMY_GPIOINT_AU1000
 	select HW_HAS_PCI
-	select DMA_NONCOHERENT
+	select DMA_COHERENT
 	select MIPS_DISABLE_OBSOLETE_IDE
 	select SYS_SUPPORTS_LITTLE_ENDIAN
 	select SYS_HAS_EARLY_PRINTK
diff --git a/arch/mips/alchemy/devboards/Makefile b/arch/mips/alchemy/devboards/Makefile
index 2eb75c9..3467ec9 100644
--- a/arch/mips/alchemy/devboards/Makefile
+++ b/arch/mips/alchemy/devboards/Makefile
@@ -13,4 +13,4 @@ obj-$(CONFIG_MIPS_DB1100)	+= db1x00/
 obj-$(CONFIG_MIPS_DB1200)	+= db1200/
 obj-$(CONFIG_MIPS_DB1300)	+= db1300.o
 obj-$(CONFIG_MIPS_DB1500)	+= db1x00/
-obj-$(CONFIG_MIPS_DB1550)	+= db1x00/
+obj-$(CONFIG_MIPS_DB1550)	+= db1550.o
diff --git a/arch/mips/alchemy/devboards/db1550.c b/arch/mips/alchemy/devboards/db1550.c
new file mode 100644
index 0000000..a4755b0
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1550.c
@@ -0,0 +1,506 @@
+/*
+ * Alchemy Db1550 board support
+ *
+ * (c) 2011 Manuel Lauss <manuel.lauss@googlemail.com>
+ */
+
+#include <linux/dma-mapping.h>
+#include <linux/gpio.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/interrupt.h>
+#include <linux/mtd/mtd.h>
+#include <linux/mtd/nand.h>
+#include <linux/mtd/partitions.h>
+#include <linux/platform_device.h>
+#include <linux/pm.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1xxx_eth.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
+#include <asm/mach-au1x00/au1550_spi.h>
+#include <asm/mach-db1x00/bcsr.h>
+#include <prom.h>
+#include "platform.h"
+
+
+const char *get_system_type(void)
+{
+	return "DB1550";
+}
+
+static void __init db1550_hw_setup(void)
+{
+	void __iomem *base;
+
+	alchemy_gpio_direction_output(203, 0);	/* red led on */
+
+	/* complete SPI setup: link psc0_intclk to a 48MHz source,
+	 * and assign GPIO16 to PSC0_SYNC1 (SPI cs# line)
+	 */
+	base = (void __iomem *)SYS_CLKSRC;
+	__raw_writel(__raw_readl(base) | 0x000001e0, base);
+	base = (void __iomem *)SYS_PINFUNC;
+	__raw_writel(__raw_readl(base) | 1, base);
+	wmb();
+
+	/* reset the AC97 codec now, the reset time in the psc-ac97 driver
+	 * is apparently too short although it's ridiculous as it is.
+	 */
+	base = (void __iomem *)KSEG1ADDR(AU1550_PSC1_PHYS_ADDR);
+	__raw_writel(PSC_SEL_CLK_SERCLK | PSC_SEL_PS_AC97MODE,
+		     base + PSC_SEL_OFFSET);
+	__raw_writel(PSC_CTRL_DISABLE, base + PSC_CTRL_OFFSET);
+	wmb();
+	__raw_writel(PSC_AC97RST_RST, base + PSC_AC97RST_OFFSET);
+	wmb();
+
+	alchemy_gpio_direction_output(202, 0);	/* green led on */
+}
+
+void __init board_setup(void)
+{
+	unsigned short whoami;
+
+	bcsr_init(DB1550_BCSR_PHYS_ADDR,
+		  DB1550_BCSR_PHYS_ADDR + DB1550_BCSR_HEXLED_OFS);
+
+	whoami = bcsr_read(BCSR_WHOAMI);
+	printk(KERN_INFO "Alchemy/AMD DB1550 Board, CPLD Rev %d"
+		"  Board-ID %d  Daughtercard ID %d\n",
+		(whoami >> 4) & 0xf, (whoami >> 8) & 0xf, whoami & 0xf);
+
+	db1550_hw_setup();
+}
+
+/*****************************************************************************/
+
+static struct mtd_partition db1550_spiflash_parts[] = {
+	{
+		.name	= "spi_flash",
+		.offset	= 0,
+		.size	= MTDPART_SIZ_FULL,
+	},
+};
+
+static struct flash_platform_data db1550_spiflash_data = {
+	.name		= "s25fl010",
+	.parts		= db1550_spiflash_parts,
+	.nr_parts	= ARRAY_SIZE(db1550_spiflash_parts),
+	.type		= "m25p10",
+};
+
+static struct spi_board_info db1550_spi_devs[] __initdata = {
+	{
+		/* TI TMP121AIDBVR temp sensor */
+		.modalias	= "tmp121",
+		.max_speed_hz	= 2400000,
+		.bus_num	= 0,
+		.chip_select	= 0,
+		.mode		= SPI_MODE_0,
+	},
+	{
+		/* Spansion S25FL001D0FMA SPI flash */
+		.modalias	= "m25p80",
+		.max_speed_hz	= 2400000,
+		.bus_num	= 0,
+		.chip_select	= 1,
+		.mode		= SPI_MODE_0,
+		.platform_data	= &db1550_spiflash_data,
+	},
+};
+
+static struct i2c_board_info db1550_i2c_devs[] __initdata = {
+	{ I2C_BOARD_INFO("24c04",  0x52),}, /* AT24C04-10 I2C eeprom */
+	{ I2C_BOARD_INFO("ne1619", 0x2d),}, /* adm1025-compat hwmon */
+	{ I2C_BOARD_INFO("wm8731", 0x1b),}, /* I2S audio codec WM8731 */
+};
+
+/**********************************************************************/
+
+static void au1550_nand_cmd_ctrl(struct mtd_info *mtd, int cmd,
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
+static int au1550_nand_device_ready(struct mtd_info *mtd)
+{
+	return __raw_readl((void __iomem *)MEM_STSTAT) & 1;
+}
+
+static const char *db1550_part_probes[] = { "cmdlinepart", NULL };
+
+static struct mtd_partition db1550_nand_parts[] = {
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
+struct platform_nand_data db1550_nand_platdata = {
+	.chip = {
+		.nr_chips	= 1,
+		.chip_offset	= 0,
+		.nr_partitions	= ARRAY_SIZE(db1550_nand_parts),
+		.partitions	= db1550_nand_parts,
+		.chip_delay	= 20,
+		.part_probe_types = db1550_part_probes,
+	},
+	.ctrl = {
+		.dev_ready	= au1550_nand_device_ready,
+		.cmd_ctrl	= au1550_nand_cmd_ctrl,
+	},
+};
+
+static struct resource db1550_nand_res[] = {
+	[0] = {
+		.start	= 0x20000000,
+		.end	= 0x200000ff,
+		.flags	= IORESOURCE_MEM,
+	},
+};
+
+static struct platform_device db1550_nand_dev = {
+	.name		= "gen_nand",
+	.num_resources	= ARRAY_SIZE(db1550_nand_res),
+	.resource	= db1550_nand_res,
+	.id		= -1,
+	.dev		= {
+		.platform_data = &db1550_nand_platdata,
+	}
+};
+
+/**********************************************************************/
+
+static struct resource au1550_psc0_res[] = {
+	[0] = {
+		.start	= AU1550_PSC0_PHYS_ADDR,
+		.end	= AU1550_PSC0_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1550_PSC0_INT,
+		.end	= AU1550_PSC0_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1550_DSCR_CMD0_PSC0_TX,
+		.end	= AU1550_DSCR_CMD0_PSC0_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1550_DSCR_CMD0_PSC0_RX,
+		.end	= AU1550_DSCR_CMD0_PSC0_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static void db1550_spi_cs_en(struct au1550_spi_info *spi, int cs, int pol)
+{
+	if (cs)
+		bcsr_mod(BCSR_BOARD, 0, BCSR_BOARD_SPISEL);
+	else
+		bcsr_mod(BCSR_BOARD, BCSR_BOARD_SPISEL, 0);
+}
+
+static struct au1550_spi_info db1550_spi_platdata = {
+	.mainclk_hz	= 48000000,	/* PSC0 clock: max. 2.4MHz SPI clk */
+	.num_chipselect = 2,
+	.activate_cs	= db1550_spi_cs_en,
+};
+
+static u64 spi_dmamask = DMA_BIT_MASK(32);
+
+static struct platform_device db1550_spi_dev = {
+	.dev	= {
+		.dma_mask		= &spi_dmamask,
+		.coherent_dma_mask	= DMA_BIT_MASK(32),
+		.platform_data		= &db1550_spi_platdata,
+	},
+	.name		= "au1550-spi",
+	.id		= 0,	/* bus number */
+	.num_resources	= ARRAY_SIZE(au1550_psc0_res),
+	.resource	= au1550_psc0_res,
+};
+
+/**********************************************************************/
+
+static struct resource au1550_psc1_res[] = {
+	[0] = {
+		.start	= AU1550_PSC1_PHYS_ADDR,
+		.end	= AU1550_PSC1_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1550_PSC1_INT,
+		.end	= AU1550_PSC1_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1550_DSCR_CMD0_PSC1_TX,
+		.end	= AU1550_DSCR_CMD0_PSC1_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1550_DSCR_CMD0_PSC1_RX,
+		.end	= AU1550_DSCR_CMD0_PSC1_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device db1550_ac97_dev = {
+	.name		= "au1xpsc_ac97",
+	.id		= 1,	/* PSC ID */
+	.num_resources	= ARRAY_SIZE(au1550_psc1_res),
+	.resource	= au1550_psc1_res,
+};
+
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
+static struct platform_device db1550_i2c_dev = {
+	.name		= "au1xpsc_smbus",
+	.id		= 0,	/* bus number */
+	.num_resources	= ARRAY_SIZE(au1550_psc2_res),
+	.resource	= au1550_psc2_res,
+};
+
+/**********************************************************************/
+
+static struct resource au1550_psc3_res[] = {
+	[0] = {
+		.start	= AU1550_PSC3_PHYS_ADDR,
+		.end	= AU1550_PSC3_PHYS_ADDR + 0xfff,
+		.flags	= IORESOURCE_MEM,
+	},
+	[1] = {
+		.start	= AU1550_PSC3_INT,
+		.end	= AU1550_PSC3_INT,
+		.flags	= IORESOURCE_IRQ,
+	},
+	[2] = {
+		.start	= AU1550_DSCR_CMD0_PSC3_TX,
+		.end	= AU1550_DSCR_CMD0_PSC3_TX,
+		.flags	= IORESOURCE_DMA,
+	},
+	[3] = {
+		.start	= AU1550_DSCR_CMD0_PSC3_RX,
+		.end	= AU1550_DSCR_CMD0_PSC3_RX,
+		.flags	= IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device db1550_i2s_dev = {
+	.name		= "au1xpsc_i2s",
+	.id		= 3,	/* PSC ID */
+	.num_resources	= ARRAY_SIZE(au1550_psc3_res),
+	.resource	= au1550_psc3_res,
+};
+
+/**********************************************************************/
+
+static struct platform_device db1550_stac_dev = {
+	.name		= "ac97-codec",
+	.id		= 1,	/* on PSC1 */
+};
+
+static struct platform_device db1550_ac97dma_dev = {
+	.name		= "au1xpsc-pcm",
+	.id		= 1,	/* on PSC3 */
+};
+
+static struct platform_device db1550_i2sdma_dev = {
+	.name		= "au1xpsc-pcm",
+	.id		= 3,	/* on PSC3 */
+};
+
+static struct platform_device db1550_sndac97_dev = {
+	.name		= "db1550-ac97",
+};
+
+static struct platform_device db1550_sndi2s_dev = {
+	.name		= "db1550-i2s",
+};
+
+/**********************************************************************/
+
+static struct platform_device db1550_rtc_dev = {
+	.name	= "rtc-au1xxx",
+	.id	= -1,
+};
+
+/**********************************************************************/
+
+static int db1550_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+{
+	if ((slot < 11) || (slot > 13) || pin == 0)
+		return -1;
+	if (slot == 11)
+		return (pin == 1) ? AU1550_PCI_INTC : 0xff;
+	if (slot == 12) {
+		switch (pin) {
+		case 1: return AU1550_PCI_INTB;
+		case 2: return AU1550_PCI_INTC;
+		case 3: return AU1550_PCI_INTD;
+		case 4: return AU1550_PCI_INTA;
+		}
+	}
+	if (slot == 13) {
+		switch (pin) {
+		case 1: return AU1550_PCI_INTA;
+		case 2: return AU1550_PCI_INTB;
+		case 3: return AU1550_PCI_INTC;
+		case 4: return AU1550_PCI_INTD;
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
+static struct alchemy_pci_platdata db1550_pci_pd = {
+	.board_map_irq	= db1550_map_pci_irq,
+};
+
+static struct platform_device db1550_pci_host_dev = {
+	.dev.platform_data = &db1550_pci_pd,
+	.name		= "alchemy-pci",
+	.id		= 0,
+	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
+	.resource	= alchemy_pci_host_res,
+};
+
+/**********************************************************************/
+
+static struct platform_device *db1550_devs[] __initdata = {
+	&db1550_rtc_dev,
+	&db1550_nand_dev,
+	&db1550_i2c_dev,
+	&db1550_ac97_dev,
+	&db1550_spi_dev,
+	&db1550_i2s_dev,
+	&db1550_stac_dev,
+	&db1550_ac97dma_dev,
+	&db1550_i2sdma_dev,
+	&db1550_sndac97_dev,
+	&db1550_sndi2s_dev,
+};
+
+/* must be arch_initcall; MIPS PCI scans busses in a subsys_initcall */
+static int __init db1550_pci_init(void)
+{
+	return platform_device_register(&db1550_pci_host_dev);
+}
+arch_initcall(db1550_pci_init);
+
+static int __init db1550_dev_init(void)
+{
+	int swapped;
+
+	irq_set_irq_type(AU1550_GPIO0_INT, IRQ_TYPE_EDGE_BOTH);  /* CD0# */
+	irq_set_irq_type(AU1550_GPIO1_INT, IRQ_TYPE_EDGE_BOTH);  /* CD1# */
+	irq_set_irq_type(AU1550_GPIO3_INT, IRQ_TYPE_LEVEL_LOW);  /* CARD0# */
+	irq_set_irq_type(AU1550_GPIO5_INT, IRQ_TYPE_LEVEL_LOW);  /* CARD1# */
+	irq_set_irq_type(AU1550_GPIO21_INT, IRQ_TYPE_LEVEL_LOW); /* STSCHG0# */
+	irq_set_irq_type(AU1550_GPIO22_INT, IRQ_TYPE_LEVEL_LOW); /* STSCHG1# */
+
+	i2c_register_board_info(0, db1550_i2c_devs,
+				ARRAY_SIZE(db1550_i2c_devs));
+	spi_register_board_info(db1550_spi_devs,
+				ARRAY_SIZE(db1550_i2c_devs));
+
+	/* Audio PSC clock is supplied by codecs (PSC1, 3) FIXME: platdata!! */
+	__raw_writel(PSC_SEL_CLK_SERCLK,
+	    (void __iomem *)KSEG1ADDR(AU1550_PSC1_PHYS_ADDR) + PSC_SEL_OFFSET);
+	wmb();
+	__raw_writel(PSC_SEL_CLK_SERCLK,
+	    (void __iomem *)KSEG1ADDR(AU1550_PSC3_PHYS_ADDR) + PSC_SEL_OFFSET);
+	wmb();
+	/* SPI/I2C use internally supplied 50MHz source */
+	__raw_writel(PSC_SEL_CLK_INTCLK,
+	    (void __iomem *)KSEG1ADDR(AU1550_PSC0_PHYS_ADDR) + PSC_SEL_OFFSET);
+	wmb();
+	__raw_writel(PSC_SEL_CLK_INTCLK,
+	    (void __iomem *)KSEG1ADDR(AU1550_PSC2_PHYS_ADDR) + PSC_SEL_OFFSET);
+	wmb();
+
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x000400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x000400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x000010000 - 1,
+		AU1550_GPIO3_INT, AU1550_GPIO0_INT,
+		/*AU1550_GPIO21_INT*/0, 0, 0);
+
+	db1x_register_pcmcia_socket(
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004000000,
+		AU1000_PCMCIA_ATTR_PHYS_ADDR + 0x004400000 - 1,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004000000,
+		AU1000_PCMCIA_MEM_PHYS_ADDR  + 0x004400000 - 1,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004000000,
+		AU1000_PCMCIA_IO_PHYS_ADDR   + 0x004010000 - 1,
+		AU1550_GPIO5_INT, AU1550_GPIO1_INT,
+		/*AU1550_GPIO22_INT*/0, 0, 1);
+
+	swapped = bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1000_SWAPBOOT;
+	db1x_register_norflash(128 << 20, 4, swapped);
+
+	return platform_add_devices(db1550_devs, ARRAY_SIZE(db1550_devs));
+}
+device_initcall(db1550_dev_init);
diff --git a/arch/mips/alchemy/devboards/db1x00/board_setup.c b/arch/mips/alchemy/devboards/db1x00/board_setup.c
index 8a222b3..2dbebcb 100644
--- a/arch/mips/alchemy/devboards/db1x00/board_setup.c
+++ b/arch/mips/alchemy/devboards/db1x00/board_setup.c
@@ -48,11 +48,6 @@ const char *get_system_type(void)
 
 void __init board_setup(void)
 {
-	unsigned long bcsr1, bcsr2;
-
-	bcsr1 = DB1000_BCSR_PHYS_ADDR;
-	bcsr2 = DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS;
-
 #ifdef CONFIG_MIPS_DB1000
 	printk(KERN_INFO "AMD Alchemy Au1000/Db1000 Board\n");
 #endif
@@ -62,15 +57,9 @@ void __init board_setup(void)
 #ifdef CONFIG_MIPS_DB1100
 	printk(KERN_INFO "AMD Alchemy Au1100/Db1100 Board\n");
 #endif
-#ifdef CONFIG_MIPS_DB1550
-	printk(KERN_INFO "AMD Alchemy Au1550/Db1550 Board\n");
-
-	bcsr1 = DB1550_BCSR_PHYS_ADDR;
-	bcsr2 = DB1550_BCSR_PHYS_ADDR + DB1550_BCSR_HEXLED_OFS;
-#endif
-
 	/* initialize board register space */
-	bcsr_init(bcsr1, bcsr2);
+	bcsr_init(DB1000_BCSR_PHYS_ADDR,
+		  DB1000_BCSR_PHYS_ADDR + DB1000_BCSR_HEXLED_OFS);
 
 #if defined(CONFIG_IRDA) && defined(CONFIG_AU1000_FIR)
 	{
@@ -92,14 +81,7 @@ void __init board_setup(void)
 
 static int __init db1x00_init_irq(void)
 {
-#if defined(CONFIG_MIPS_DB1550)
-	irq_set_irq_type(AU1550_GPIO0_INT, IRQF_TRIGGER_LOW);  /* CD0# */
-	irq_set_irq_type(AU1550_GPIO1_INT, IRQF_TRIGGER_LOW);  /* CD1# */
-	irq_set_irq_type(AU1550_GPIO3_INT, IRQF_TRIGGER_LOW);  /* CARD0# */
-	irq_set_irq_type(AU1550_GPIO5_INT, IRQF_TRIGGER_LOW);  /* CARD1# */
-	irq_set_irq_type(AU1550_GPIO21_INT, IRQF_TRIGGER_LOW); /* STSCHG0# */
-	irq_set_irq_type(AU1550_GPIO22_INT, IRQF_TRIGGER_LOW); /* STSCHG1# */
-#elif defined(CONFIG_MIPS_DB1500)
+#if defined(CONFIG_MIPS_DB1500)
 	irq_set_irq_type(AU1500_GPIO0_INT, IRQF_TRIGGER_LOW); /* CD0# */
 	irq_set_irq_type(AU1500_GPIO3_INT, IRQF_TRIGGER_LOW); /* CD1# */
 	irq_set_irq_type(AU1500_GPIO2_INT, IRQF_TRIGGER_LOW); /* CARD0# */
diff --git a/arch/mips/alchemy/devboards/db1x00/platform.c b/arch/mips/alchemy/devboards/db1x00/platform.c
index a8bb4fa..b439b4f 100644
--- a/arch/mips/alchemy/devboards/db1x00/platform.c
+++ b/arch/mips/alchemy/devboards/db1x00/platform.c
@@ -33,7 +33,6 @@ struct pci_dev;
  * CD0/1 	GPIO0/3
  * STSCHG0/1	GPIO1/4
  * CARD0/1	GPIO2/5
- * Db1550:	0/1, 21/22, 3/5
  */
 
 #define F_SWAPPED (bcsr_read(BCSR_STATUS) & BCSR_STATUS_DB1000_SWAPBOOT)
@@ -45,7 +44,6 @@ struct pci_dev;
 #define DB1XXX_PCMCIA_CD1	AU1000_GPIO3_INT
 #define DB1XXX_PCMCIA_STSCHG1	AU1000_GPIO4_INT
 #define DB1XXX_PCMCIA_CARD1	AU1000_GPIO5_INT
-#define BOARD_FLASH_SIZE	0x02000000 /* 32MB */
 #elif defined(CONFIG_MIPS_DB1100)
 #define DB1XXX_PCMCIA_CD0	AU1100_GPIO0_INT
 #define DB1XXX_PCMCIA_STSCHG0	AU1100_GPIO1_INT
@@ -53,7 +51,6 @@ struct pci_dev;
 #define DB1XXX_PCMCIA_CD1	AU1100_GPIO3_INT
 #define DB1XXX_PCMCIA_STSCHG1	AU1100_GPIO4_INT
 #define DB1XXX_PCMCIA_CARD1	AU1100_GPIO5_INT
-#define BOARD_FLASH_SIZE	0x02000000 /* 32MB */
 #elif defined(CONFIG_MIPS_DB1500)
 #define DB1XXX_PCMCIA_CD0	AU1500_GPIO0_INT
 #define DB1XXX_PCMCIA_STSCHG0	AU1500_GPIO1_INT
@@ -61,20 +58,8 @@ struct pci_dev;
 #define DB1XXX_PCMCIA_CD1	AU1500_GPIO3_INT
 #define DB1XXX_PCMCIA_STSCHG1	AU1500_GPIO4_INT
 #define DB1XXX_PCMCIA_CARD1	AU1500_GPIO5_INT
-#define BOARD_FLASH_SIZE	0x02000000 /* 32MB */
-#elif defined(CONFIG_MIPS_DB1550)
-#define DB1XXX_PCMCIA_CD0	AU1550_GPIO0_INT
-#define DB1XXX_PCMCIA_STSCHG0	AU1550_GPIO21_INT
-#define DB1XXX_PCMCIA_CARD0	AU1550_GPIO3_INT
-#define DB1XXX_PCMCIA_CD1	AU1550_GPIO1_INT
-#define DB1XXX_PCMCIA_STSCHG1	AU1550_GPIO22_INT
-#define DB1XXX_PCMCIA_CARD1	AU1550_GPIO5_INT
-#define BOARD_FLASH_SIZE	0x08000000 /* 128MB */
-#endif
 
-#ifdef CONFIG_PCI
-#ifdef CONFIG_MIPS_DB1500
-static int db1xxx_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
+static int db1500_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
 {
 	if ((slot < 12) || (slot > 13) || pin == 0)
 		return -1;
@@ -90,34 +75,6 @@ static int db1xxx_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
 	}
 	return -1;
 }
-#endif
-
-#ifdef CONFIG_MIPS_DB1550
-static int db1xxx_map_pci_irq(const struct pci_dev *d, u8 slot, u8 pin)
-{
-	if ((slot < 11) || (slot > 13) || pin == 0)
-		return -1;
-	if (slot == 11)
-		return (pin == 1) ? AU1550_PCI_INTC : 0xff;
-	if (slot == 12) {
-		switch (pin) {
-		case 1: return AU1550_PCI_INTB;
-		case 2: return AU1550_PCI_INTC;
-		case 3: return AU1550_PCI_INTD;
-		case 4: return AU1550_PCI_INTA;
-		}
-	}
-	if (slot == 13) {
-		switch (pin) {
-		case 1: return AU1550_PCI_INTA;
-		case 2: return AU1550_PCI_INTB;
-		case 3: return AU1550_PCI_INTC;
-		case 4: return AU1550_PCI_INTD;
-		}
-	}
-	return -1;
-}
-#endif
 
 static struct resource alchemy_pci_host_res[] = {
 	[0] = {
@@ -127,24 +84,24 @@ static struct resource alchemy_pci_host_res[] = {
 	},
 };
 
-static struct alchemy_pci_platdata db1xxx_pci_pd = {
-	.board_map_irq	= db1xxx_map_pci_irq,
+static struct alchemy_pci_platdata db1500_pci_pd = {
+	.board_map_irq	= db1500_map_pci_irq,
 };
 
-static struct platform_device db1xxx_pci_host_dev = {
-	.dev.platform_data = &db1xxx_pci_pd,
+static struct platform_device db1500_pci_host_dev = {
+	.dev.platform_data = &db1500_pci_pd,
 	.name		= "alchemy-pci",
 	.id		= 0,
 	.num_resources	= ARRAY_SIZE(alchemy_pci_host_res),
 	.resource	= alchemy_pci_host_res,
 };
 
-static int __init db15x0_pci_init(void)
+static int __init db1500_pci_init(void)
 {
-	return platform_device_register(&db1xxx_pci_host_dev);
+	return platform_device_register(&db1500_pci_host_dev);
 }
 /* must be arch_initcall; MIPS PCI scans busses in a subsys_initcall */
-arch_initcall(db15x0_pci_init);
+arch_initcall(db1500_pci_init);
 #endif
 
 #ifdef CONFIG_MIPS_DB1100
@@ -243,7 +200,7 @@ static int __init db1xxx_dev_init(void)
 	platform_device_register(&alchemy_ac97c_dev);
 	platform_device_register(&db1x00_audio_dev);
 
-	db1x_register_norflash(BOARD_FLASH_SIZE, 4 /* 32bit */, F_SWAPPED);
+	db1x_register_norflash(0x02000000, 4 /* 32bit */, F_SWAPPED);
 	return 0;
 }
 device_initcall(db1xxx_dev_init);
diff --git a/arch/mips/configs/db1550_defconfig b/arch/mips/configs/db1550_defconfig
index 798a553..36cda27 100644
--- a/arch/mips/configs/db1550_defconfig
+++ b/arch/mips/configs/db1550_defconfig
@@ -1,145 +1,262 @@
+CONFIG_MIPS=y
 CONFIG_MIPS_ALCHEMY=y
 CONFIG_MIPS_DB1550=y
+CONFIG_SCHED_OMIT_FRAME_POINTER=y
+CONFIG_GENERIC_GPIO=y
+CONFIG_TICK_ONESHOT=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
 CONFIG_HZ_100=y
-# CONFIG_SECCOMP is not set
+CONFIG_HZ=100
 CONFIG_EXPERIMENTAL=y
+CONFIG_BROKEN_ON_SMP=y
+CONFIG_INIT_ENV_ARG_LIMIT=32
 CONFIG_LOCALVERSION="-db1550"
+CONFIG_LOCALVERSION_AUTO=y
 CONFIG_KERNEL_LZMA=y
+CONFIG_DEFAULT_HOSTNAME="db1550"
+CONFIG_SWAP=y
 CONFIG_SYSVIPC=y
+CONFIG_SYSVIPC_SYSCTL=y
 CONFIG_POSIX_MQUEUE=y
+CONFIG_POSIX_MQUEUE_SYSCTL=y
+CONFIG_FHANDLE=y
+CONFIG_AUDIT=y
 CONFIG_TINY_RCU=y
-CONFIG_LOG_BUF_SHIFT=14
+CONFIG_LOG_BUF_SHIFT=18
+CONFIG_NAMESPACES=y
+CONFIG_UTS_NS=y
+CONFIG_IPC_NS=y
+CONFIG_USER_NS=y
+CONFIG_PID_NS=y
+CONFIG_NET_NS=y
 CONFIG_EXPERT=y
-# CONFIG_SYSCTL_SYSCALL is not set
-# CONFIG_KALLSYMS is not set
-# CONFIG_PCSPKR_PLATFORM is not set
-# CONFIG_VM_EVENT_COUNTERS is not set
-# CONFIG_COMPAT_BRK is not set
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
+CONFIG_PCI_QUIRKS=y
 CONFIG_SLAB=y
-CONFIG_MODULES=y
-CONFIG_MODULE_UNLOAD=y
-# CONFIG_IOSCHED_DEADLINE is not set
-# CONFIG_IOSCHED_CFQ is not set
+CONFIG_BLOCK=y
+CONFIG_LBDAF=y
+CONFIG_BLK_DEV_BSG=y
+CONFIG_BLK_DEV_BSGLIB=y
+CONFIG_IOSCHED_NOOP=y
+CONFIG_DEFAULT_NOOP=y
+CONFIG_DEFAULT_IOSCHED="noop"
 CONFIG_PCI=y
 CONFIG_PCCARD=y
-# CONFIG_CARDBUS is not set
+CONFIG_PCMCIA=y
+CONFIG_PCMCIA_LOAD_CIS=y
 CONFIG_PCMCIA_ALCHEMY_DEVBOARD=y
-CONFIG_PM=y
+CONFIG_BINFMT_ELF=y
+CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS=y
+CONFIG_BINFMT_MISC=y
+CONFIG_SUSPEND=y
+CONFIG_SUSPEND_FREEZER=y
+CONFIG_PM_SLEEP=y
 CONFIG_PM_RUNTIME=y
+CONFIG_PM=y
 CONFIG_NET=y
 CONFIG_PACKET=y
 CONFIG_UNIX=y
+CONFIG_XFRM=y
 CONFIG_INET=y
 CONFIG_IP_MULTICAST=y
 CONFIG_IP_PNP=y
 CONFIG_IP_PNP_DHCP=y
 CONFIG_IP_PNP_BOOTP=y
 CONFIG_IP_PNP_RARP=y
-# CONFIG_INET_XFRM_MODE_TRANSPORT is not set
-# CONFIG_INET_XFRM_MODE_TUNNEL is not set
-# CONFIG_INET_XFRM_MODE_BEET is not set
-# CONFIG_INET_DIAG is not set
-# CONFIG_IPV6 is not set
-# CONFIG_WIRELESS is not set
-CONFIG_UEVENT_HELPER_PATH="/sbin/hotplug"
+CONFIG_INET_TUNNEL=y
+CONFIG_INET_LRO=y
+CONFIG_TCP_CONG_CUBIC=y
+CONFIG_DEFAULT_TCP_CONG="cubic"
+CONFIG_IPV6=y
+CONFIG_INET6_XFRM_MODE_TRANSPORT=y
+CONFIG_INET6_XFRM_MODE_TUNNEL=y
+CONFIG_INET6_XFRM_MODE_BEET=y
+CONFIG_IPV6_SIT=y
+CONFIG_IPV6_NDISC_NODETYPE=y
+CONFIG_DNS_RESOLVER=y
+CONFIG_UEVENT_HELPER_PATH=""
+CONFIG_STANDALONE=y
+CONFIG_PREVENT_FIRMWARE_BUILD=y
+CONFIG_FW_LOADER=y
+CONFIG_FIRMWARE_IN_KERNEL=y
 CONFIG_MTD=y
-CONFIG_MTD_PARTITIONS=y
 CONFIG_MTD_CHAR=y
+CONFIG_MTD_BLKDEVS=y
 CONFIG_MTD_BLOCK=y
 CONFIG_MTD_CFI=y
+CONFIG_MTD_GEN_PROBE=y
+CONFIG_MTD_MAP_BANK_WIDTH_1=y
+CONFIG_MTD_MAP_BANK_WIDTH_2=y
+CONFIG_MTD_MAP_BANK_WIDTH_4=y
+CONFIG_MTD_CFI_I1=y
+CONFIG_MTD_CFI_I2=y
 CONFIG_MTD_CFI_AMDSTD=y
+CONFIG_MTD_CFI_UTIL=y
 CONFIG_MTD_PHYSMAP=y
+CONFIG_MTD_M25P80=y
+CONFIG_MTD_NAND_ECC=y
 CONFIG_MTD_NAND=y
-CONFIG_MTD_NAND_AU1550=y
-CONFIG_BLK_DEV_UB=y
-# CONFIG_MISC_DEVICES is not set
-CONFIG_IDE=y
-CONFIG_BLK_DEV_IDECS=y
-CONFIG_BLK_DEV_IDECD=y
-# CONFIG_BLK_DEV_IDECD_VERBOSE_ERRORS is not set
-CONFIG_IDE_TASK_IOCTL=y
-# CONFIG_IDEPCI_PCIBUS_ORDER is not set
-CONFIG_BLK_DEV_HPT366=y
+CONFIG_MTD_NAND_IDS=y
+CONFIG_MTD_NAND_PLATFORM=y
+CONFIG_MISC_DEVICES=y
+CONFIG_EEPROM_AT24=y
+CONFIG_SCSI_MOD=y
+CONFIG_SCSI=y
+CONFIG_SCSI_DMA=y
+CONFIG_BLK_DEV_SD=y
+CONFIG_CHR_DEV_SG=y
+CONFIG_SCSI_MULTI_LUN=y
+CONFIG_SCSI_SCAN_ASYNC=y
+CONFIG_ATA=y
+CONFIG_ATA_SFF=y
+CONFIG_ATA_BMDMA=y
+CONFIG_PATA_HPT37X=y
+CONFIG_PATA_PCMCIA=y
+CONFIG_MD=y
+CONFIG_BLK_DEV_DM=y
 CONFIG_NETDEVICES=y
-CONFIG_MARVELL_PHY=y
-CONFIG_DAVICOM_PHY=y
-CONFIG_QSEMI_PHY=y
-CONFIG_LXT_PHY=y
-CONFIG_CICADA_PHY=y
-CONFIG_VITESSE_PHY=y
-CONFIG_SMSC_PHY=y
-CONFIG_BROADCOM_PHY=y
-CONFIG_ICPLUS_PHY=y
-CONFIG_REALTEK_PHY=y
-CONFIG_NATIONAL_PHY=y
-CONFIG_STE10XP=y
-CONFIG_LSI_ET1011C_PHY=y
-CONFIG_NET_ETHERNET=y
 CONFIG_MII=y
+CONFIG_PHYLIB=y
+CONFIG_NET_ETHERNET=y
 CONFIG_MIPS_AU1X00_ENET=y
-# CONFIG_NETDEV_1000 is not set
-# CONFIG_NETDEV_10000 is not set
-# CONFIG_WLAN is not set
-# CONFIG_INPUT_MOUSEDEV is not set
+CONFIG_NET_PCMCIA=y
+CONFIG_PCMCIA_3C589=y
+CONFIG_PCMCIA_PCNET=y
+CONFIG_INPUT=y
 CONFIG_INPUT_EVDEV=y
-# CONFIG_INPUT_KEYBOARD is not set
-# CONFIG_INPUT_MOUSE is not set
-# CONFIG_SERIO is not set
+CONFIG_VT=y
+CONFIG_CONSOLE_TRANSLATIONS=y
+CONFIG_VT_CONSOLE=y
+CONFIG_HW_CONSOLE=y
+CONFIG_UNIX98_PTYS=y
+CONFIG_DEVPTS_MULTIPLE_INSTANCES=y
+CONFIG_DEVKMEM=y
 CONFIG_SERIAL_8250=y
 CONFIG_SERIAL_8250_CONSOLE=y
-# CONFIG_LEGACY_PTYS is not set
-# CONFIG_HW_RANDOM is not set
+CONFIG_SERIAL_8250_NR_UARTS=4
+CONFIG_SERIAL_8250_RUNTIME_UARTS=4
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
+CONFIG_DEVPORT=y
 CONFIG_I2C=y
-# CONFIG_I2C_COMPAT is not set
+CONFIG_I2C_BOARDINFO=y
 CONFIG_I2C_CHARDEV=y
-# CONFIG_I2C_HELPER_AUTO is not set
 CONFIG_I2C_AU1550=y
 CONFIG_SPI=y
+CONFIG_SPI_MASTER=y
 CONFIG_SPI_AU1550=y
-# CONFIG_HWMON is not set
-# CONFIG_VGA_ARB is not set
-# CONFIG_VGA_CONSOLE is not set
+CONFIG_SPI_BITBANG=y
+CONFIG_HWMON=y
+CONFIG_SENSORS_ADM1025=y
+CONFIG_SENSORS_LM70=y
+CONFIG_DUMMY_CONSOLE=y
 CONFIG_SOUND=y
 CONFIG_SND=y
-CONFIG_SND_HRTIMER=y
-CONFIG_SND_DYNAMIC_MINORS=y
-# CONFIG_SND_SUPPORT_OLD_API is not set
-# CONFIG_SND_VERBOSE_PROCFS is not set
-# CONFIG_SND_DRIVERS is not set
-# CONFIG_SND_PCI is not set
-# CONFIG_SND_SPI is not set
-# CONFIG_SND_MIPS is not set
-# CONFIG_SND_PCMCIA is not set
+CONFIG_SND_TIMER=y
+CONFIG_SND_PCM=y
+CONFIG_SND_JACK=y
+CONFIG_SND_VMASTER=y
+CONFIG_SND_AC97_CODEC=y
 CONFIG_SND_SOC=y
+CONFIG_SND_SOC_AC97_BUS=y
 CONFIG_SND_SOC_AU1XPSC=y
-# CONFIG_HID_SUPPORT is not set
+CONFIG_SND_SOC_AU1XPSC_I2S=y
+CONFIG_SND_SOC_AU1XPSC_AC97=y
+CONFIG_SND_SOC_DB1200=y
+CONFIG_SND_SOC_I2C_AND_SPI=y
+CONFIG_SND_SOC_AC97_CODEC=y
+CONFIG_SND_SOC_WM8731=y
+CONFIG_SND_SOC_WM9712=y
+CONFIG_AC97_BUS=y
 CONFIG_USB=y
-# CONFIG_USB_DEVICE_CLASS is not set
 CONFIG_USB_DYNAMIC_MINORS=y
-CONFIG_USB_SUSPEND=y
 CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_EHCI_ROOT_HUB_TT=y
+CONFIG_USB_EHCI_TT_NEWSCHED=y
 CONFIG_USB_OHCI_HCD=y
+CONFIG_USB_OHCI_LITTLE_ENDIAN=y
+CONFIG_USB_UHCI_HCD=y
+CONFIG_USB_STORAGE=y
+CONFIG_RTC_LIB=y
 CONFIG_RTC_CLASS=y
+CONFIG_RTC_HCTOSYS=y
+CONFIG_RTC_HCTOSYS_DEVICE="rtc0"
+CONFIG_RTC_INTF_SYSFS=y
+CONFIG_RTC_INTF_PROC=y
+CONFIG_RTC_INTF_DEV=y
 CONFIG_RTC_DRV_AU1XXX=y
-CONFIG_EXT2_FS=y
-# CONFIG_PROC_PAGE_MONITOR is not set
+CONFIG_EXT4_FS=y
+CONFIG_EXT4_USE_FOR_EXT23=y
+CONFIG_EXT4_FS_XATTR=y
+CONFIG_EXT4_FS_POSIX_ACL=y
+CONFIG_EXT4_FS_SECURITY=y
+CONFIG_JBD2=y
+CONFIG_FS_MBCACHE=y
+CONFIG_FS_POSIX_ACL=y
+CONFIG_EXPORTFS=y
+CONFIG_FILE_LOCKING=y
+CONFIG_FSNOTIFY=y
+CONFIG_DNOTIFY=y
+CONFIG_INOTIFY_USER=y
+CONFIG_PROC_FS=y
+CONFIG_PROC_SYSCTL=y
+CONFIG_SYSFS=y
 CONFIG_TMPFS=y
 CONFIG_CONFIGFS_FS=y
+CONFIG_MISC_FILESYSTEMS=y
 CONFIG_JFFS2_FS=y
+CONFIG_JFFS2_FS_DEBUG=0
+CONFIG_JFFS2_FS_WRITEBUFFER=y
 CONFIG_JFFS2_SUMMARY=y
 CONFIG_JFFS2_FS_XATTR=y
-# CONFIG_JFFS2_FS_POSIX_ACL is not set
-# CONFIG_JFFS2_FS_SECURITY is not set
 CONFIG_JFFS2_COMPRESSION_OPTIONS=y
+CONFIG_JFFS2_ZLIB=y
 CONFIG_JFFS2_LZO=y
+CONFIG_JFFS2_RTIME=y
 CONFIG_JFFS2_RUBIN=y
+CONFIG_JFFS2_CMODE_PRIORITY=y
 CONFIG_SQUASHFS=y
+CONFIG_SQUASHFS_ZLIB=y
+CONFIG_SQUASHFS_FRAGMENT_CACHE_SIZE=3
+CONFIG_NETWORK_FILESYSTEMS=y
 CONFIG_NFS_FS=y
 CONFIG_NFS_V3=y
+CONFIG_NFS_V3_ACL=y
+CONFIG_NFS_V4=y
+CONFIG_NFS_V4_1=y
+CONFIG_PNFS_FILE_LAYOUT=y
+CONFIG_PNFS_BLOCK=y
 CONFIG_ROOT_NFS=y
+CONFIG_NFS_USE_KERNEL_DNS=y
+CONFIG_NFS_USE_NEW_IDMAPPER=y
+CONFIG_NFSD=y
+CONFIG_NFSD_V2_ACL=y
+CONFIG_NFSD_V3=y
+CONFIG_NFSD_V3_ACL=y
+CONFIG_NFSD_V4=y
+CONFIG_LOCKD=y
+CONFIG_LOCKD_V4=y
+CONFIG_NFS_ACL_SUPPORT=y
+CONFIG_NFS_COMMON=y
+CONFIG_SUNRPC=y
+CONFIG_SUNRPC_GSS=y
+CONFIG_SUNRPC_BACKCHANNEL=y
+CONFIG_MSDOS_PARTITION=y
+CONFIG_NLS=y
+CONFIG_NLS_DEFAULT="iso8859-1"
 CONFIG_NLS_CODEPAGE_437=y
 CONFIG_NLS_CODEPAGE_850=y
 CONFIG_NLS_CODEPAGE_852=y
@@ -148,10 +265,21 @@ CONFIG_NLS_ASCII=y
 CONFIG_NLS_ISO8859_1=y
 CONFIG_NLS_ISO8859_15=y
 CONFIG_NLS_UTF8=y
-CONFIG_DEBUG_KERNEL=y
-# CONFIG_SCHED_DEBUG is not set
-# CONFIG_FTRACE is not set
-CONFIG_DEBUG_ZBOOT=y
+CONFIG_DEFAULT_MESSAGE_LOGLEVEL=4
+CONFIG_FRAME_WARN=1024
+CONFIG_CMDLINE_BOOL=y
+CONFIG_CMDLINE="noirqdebug console=ttyS0,115200 root=/dev/sda1 rootfstype=ext4"
 CONFIG_KEYS=y
-CONFIG_KEYS_DEBUG_PROC_KEYS=y
 CONFIG_SECURITYFS=y
+CONFIG_DEFAULT_SECURITY_DAC=y
+CONFIG_BITREVERSE=y
+CONFIG_CRC16=y
+CONFIG_CRC_ITU_T=y
+CONFIG_CRC32=y
+CONFIG_AUDIT_GENERIC=y
+CONFIG_ZLIB_INFLATE=y
+CONFIG_ZLIB_DEFLATE=y
+CONFIG_LZO_COMPRESS=y
+CONFIG_LZO_DECOMPRESS=y
+CONFIG_BCH=y
+CONFIG_NLATTR=y
diff --git a/arch/mips/include/asm/mach-db1x00/bcsr.h b/arch/mips/include/asm/mach-db1x00/bcsr.h
index 0ef6300..bb9fc23 100644
--- a/arch/mips/include/asm/mach-db1x00/bcsr.h
+++ b/arch/mips/include/asm/mach-db1x00/bcsr.h
@@ -163,7 +163,7 @@ enum bcsr_whoami_boards {
 #define BCSR_BOARD_GPIO200RST		0x0400
 #define BCSR_BOARD_PCICLKOUT		0x0800
 #define BCSR_BOARD_PCICFG		0x1000
-#define BCSR_BOARD_SPISEL		0x4000	/* PB/DB1550 */
+#define BCSR_BOARD_SPISEL		0x2000	/* PB/DB1550 */
 #define BCSR_BOARD_SD0WP		0x4000	/* DB1100 */
 #define BCSR_BOARD_SD1WP		0x8000	/* DB1100 */
 
diff --git a/arch/mips/include/asm/mach-db1x00/db1x00.h b/arch/mips/include/asm/mach-db1x00/db1x00.h
index a5affb0..51f1ebf 100644
--- a/arch/mips/include/asm/mach-db1x00/db1x00.h
+++ b/arch/mips/include/asm/mach-db1x00/db1x00.h
@@ -29,22 +29,6 @@
 
 #include <asm/mach-au1x00/au1xxx_psc.h>
 
-#ifdef CONFIG_MIPS_DB1550
-
-#define DBDMA_AC97_TX_CHAN	AU1550_DSCR_CMD0_PSC1_TX
-#define DBDMA_AC97_RX_CHAN	AU1550_DSCR_CMD0_PSC1_RX
-#define DBDMA_I2S_TX_CHAN	AU1550_DSCR_CMD0_PSC3_TX
-#define DBDMA_I2S_RX_CHAN	AU1550_DSCR_CMD0_PSC3_RX
-
-#define SPI_PSC_BASE		AU1550_PSC0_PHYS_ADDR
-#define AC97_PSC_BASE		AU1550_PSC1_PHYS_ADDR
-#define SMBUS_PSC_BASE		AU1550_PSC2_PHYS_ADDR
-#define I2S_PSC_BASE		AU1550_PSC3_PHYS_ADDR
-
-#define NAND_PHYS_ADDR		0x20000000
-
-#endif
-
 /*
  * NAND defines
  *
diff --git a/sound/soc/au1x/Kconfig b/sound/soc/au1x/Kconfig
index 5981ecc..c620cbf9 100644
--- a/sound/soc/au1x/Kconfig
+++ b/sound/soc/au1x/Kconfig
@@ -51,7 +51,7 @@ config SND_SOC_DB1000
 	  of boards (DB1000/DB1500/DB1100).
 
 config SND_SOC_DB1200
-	tristate "DB1200/DB1300 Audio support"
+	tristate "DB1200/DB1300/DB1550 Audio support"
 	select SND_SOC_AU1XPSC
 	select SND_SOC_AU1XPSC_AC97
 	select SND_SOC_AC97_CODEC
@@ -60,5 +60,5 @@ config SND_SOC_DB1200
 	select SND_SOC_WM8731
 	help
 	  Select this option to enable audio (AC97 and I2S) on the
-	  Alchemy/AMD/RMI/NetLogic Db1200 and Db1300 evaluation boards.
+	  Alchemy/AMD/RMI/NetLogic Db1200, Db1550 and Db1300 evaluation boards.
 	  If you need Db1300 touchscreen support, you definitely want to say Y.
diff --git a/sound/soc/au1x/db1200.c b/sound/soc/au1x/db1200.c
index ca2335a..44ad118 100644
--- a/sound/soc/au1x/db1200.c
+++ b/sound/soc/au1x/db1200.c
@@ -1,5 +1,5 @@
 /*
- * DB1200/DB1300 ASoC audio fabric support code.
+ * DB1200/DB1300/DB1550 ASoC audio fabric support code.
  *
  * (c) 2008-2011 Manuel Lauss <manuel.lauss@googlemail.com>
  *
@@ -34,6 +34,12 @@ static struct platform_device_id db1200_pids[] = {
 	}, {
 		.name		= "db1300-i2s",
 		.driver_data	= 3,
+	}, {
+		.name		= "db1550-ac97",
+		.driver_data	= 4,
+	}, {
+		.name		= "db1550-i2s",
+		.driver_data	= 5,
 	},
 	{},
 };
@@ -70,6 +76,12 @@ static struct snd_soc_card db1300_ac97_machine = {
 	.num_links	= 1,
 };
 
+static struct snd_soc_card db1550_ac97_machine = {
+	.name		= "DB1550_AC97",
+	.dai_link	= &db1200_ac97_dai,
+	.num_links	= 1,
+};
+
 /*-------------------------  I2S PART  ---------------------------*/
 
 static int db1200_i2s_startup(struct snd_pcm_substream *substream)
@@ -135,6 +147,22 @@ static struct snd_soc_card db1300_i2s_machine = {
 	.num_links	= 1,
 };
 
+static struct snd_soc_dai_link db1550_i2s_dai = {
+	.name		= "WM8731",
+	.stream_name	= "WM8731 PCM",
+	.codec_dai_name	= "wm8731-hifi",
+	.cpu_dai_name	= "au1xpsc_i2s.3",
+	.platform_name	= "au1xpsc-pcm.3",
+	.codec_name	= "wm8731.0-001b",
+	.ops		= &db1200_i2s_wm8731_ops,
+};
+
+static struct snd_soc_card db1550_i2s_machine = {
+	.name		= "DB1550_I2S",
+	.dai_link	= &db1550_i2s_dai,
+	.num_links	= 1,
+};
+
 /*-------------------------  COMMON PART  ---------------------------*/
 
 static struct snd_soc_card *db1200_cards[] __devinitdata = {
@@ -142,6 +170,8 @@ static struct snd_soc_card *db1200_cards[] __devinitdata = {
 	&db1200_i2s_machine,
 	&db1300_ac97_machine,
 	&db1300_i2s_machine,
+	&db1550_ac97_machine,
+	&db1550_i2s_machine,
 };
 
 static int __devinit db1200_audio_probe(struct platform_device *pdev)
@@ -186,5 +216,5 @@ module_init(db1200_audio_load);
 module_exit(db1200_audio_unload);
 
 MODULE_LICENSE("GPL");
-MODULE_DESCRIPTION("DB1200/DB1300 ASoC audio support");
+MODULE_DESCRIPTION("DB1200/DB1300/DB1550 ASoC audio support");
 MODULE_AUTHOR("Manuel Lauss");
-- 
1.7.7.1
