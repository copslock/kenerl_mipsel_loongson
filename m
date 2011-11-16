Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Nov 2011 14:37:55 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:59562 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903823Ab1KPNhs (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Nov 2011 14:37:48 +0100
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, John Crispin <blogic@openwrt.org>,
        Thomas Langer <thomas.langer@lantiq.com>,
        spi-devel-general@lists.sourceforge.net
Subject: [PATCH] SPI: MIPS: lantiq: add FALC-ON spi driver
Date:   Wed, 16 Nov 2011 15:37:17 +0100
Message-Id: <1321454237-4041-1-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.7.1
X-archive-position: 31670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 13406

The external bus unit (EBU) found on the FALC-ON SoC has spi emulation that is
designed for serial flash access. This driver has only been tested with m25p80
type chips. The hardware has no support for other types of spi peripherals.

Signed-off-by: Thomas Langer <thomas.langer@lantiq.com>
Signed-off-by: John Crispin <blogic@openwrt.org>
Cc: spi-devel-general@lists.sourceforge.net
---

 arch/mips/lantiq/falcon/devices.c        |   13 +
 arch/mips/lantiq/falcon/devices.h        |    4 +
 arch/mips/lantiq/falcon/mach-easy98000.c |   27 ++
 drivers/spi/Kconfig                      |    4 +
 drivers/spi/Makefile                     |    1 +
 drivers/spi/spi-falcon.c                 |  483 ++++++++++++++++++++++++++++++
 6 files changed, 532 insertions(+), 0 deletions(-)
 create mode 100644 drivers/spi/spi-falcon.c

diff --git a/arch/mips/lantiq/falcon/devices.c b/arch/mips/lantiq/falcon/devices.c
index 4f47b44..4fc1069 100644
--- a/arch/mips/lantiq/falcon/devices.c
+++ b/arch/mips/lantiq/falcon/devices.c
@@ -126,3 +126,16 @@ falcon_register_gpio_extra(void)
 	ltq_sysctl_activate(SYSCTL_SYS1,
 		ACTS_PADCTRL3 | ACTS_PADCTRL4 | ACTS_P3 | ACTS_P4);
 }
+
+/* spi flash */
+static struct platform_device ltq_spi = {
+	.name			= "falcon_spi",
+	.num_resources		= 0,
+};
+
+void __init
+falcon_register_spi_flash(struct spi_board_info *data)
+{
+	spi_register_board_info(data, 1);
+	platform_device_register(&ltq_spi);
+}
diff --git a/arch/mips/lantiq/falcon/devices.h b/arch/mips/lantiq/falcon/devices.h
index 18be8b6..5e6f720 100644
--- a/arch/mips/lantiq/falcon/devices.h
+++ b/arch/mips/lantiq/falcon/devices.h
@@ -11,10 +11,14 @@
 #ifndef _FALCON_DEVICES_H__
 #define _FALCON_DEVICES_H__
 
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
+
 #include "../devices.h"
 
 extern void falcon_register_nand(void);
 extern void falcon_register_gpio(void);
 extern void falcon_register_gpio_extra(void);
+extern void falcon_register_spi_flash(struct spi_board_info *data);
 
 #endif
diff --git a/arch/mips/lantiq/falcon/mach-easy98000.c b/arch/mips/lantiq/falcon/mach-easy98000.c
index 361b8f0..1a7caad 100644
--- a/arch/mips/lantiq/falcon/mach-easy98000.c
+++ b/arch/mips/lantiq/falcon/mach-easy98000.c
@@ -40,6 +40,21 @@ struct physmap_flash_data easy98000_nor_flash_data = {
 	.parts		= easy98000_nor_partitions,
 };
 
+static struct flash_platform_data easy98000_spi_flash_platform_data = {
+	.name = "sflash",
+	.parts = easy98000_nor_partitions,
+	.nr_parts = ARRAY_SIZE(easy98000_nor_partitions)
+};
+
+static struct spi_board_info easy98000_spi_flash_data __initdata = {
+	.modalias		= "m25p80",
+	.bus_num		= 0,
+	.chip_select		= 0,
+	.max_speed_hz		= 10 * 1000 * 1000,
+	.mode			= SPI_MODE_3,
+	.platform_data		= &easy98000_spi_flash_platform_data
+};
+
 /* setup gpio based spi bus/device for access to the eeprom on the board */
 #define SPI_GPIO_MRST		102
 #define SPI_GPIO_MTSR		103
@@ -93,6 +108,13 @@ easy98000_init(void)
 }
 
 static void __init
+easy98000sf_init(void)
+{
+	easy98000_init_common();
+	falcon_register_spi_flash(&easy98000_spi_flash_data);
+}
+
+static void __init
 easy98000nand_init(void)
 {
 	easy98000_init_common();
@@ -104,6 +126,11 @@ MIPS_MACHINE(LANTIQ_MACH_EASY98000,
 			"EASY98000 Eval Board",
 			easy98000_init);
 
+MIPS_MACHINE(LANTIQ_MACH_EASY98000SF,
+			"EASY98000SF",
+			"EASY98000 Eval Board (Serial Flash)",
+			easy98000sf_init);
+
 MIPS_MACHINE(LANTIQ_MACH_EASY98000NAND,
 			"EASY98000NAND",
 			"EASY98000 Eval Board (NAND Flash)",
diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
index a1fd73d..f244553 100644
--- a/drivers/spi/Kconfig
+++ b/drivers/spi/Kconfig
@@ -180,6 +180,10 @@ config SPI_MPC52xx
 	  This drivers supports the MPC52xx SPI controller in master SPI
 	  mode.
 
+config SPI_FALCON
+	tristate "Falcon SPI controller support"
+	depends on SOC_FALCON
+
 config SPI_MPC52xx_PSC
 	tristate "Freescale MPC52xx PSC SPI controller"
 	depends on PPC_MPC52xx && EXPERIMENTAL
diff --git a/drivers/spi/Makefile b/drivers/spi/Makefile
index 61c3261..570894c 100644
--- a/drivers/spi/Makefile
+++ b/drivers/spi/Makefile
@@ -25,6 +25,7 @@ obj-$(CONFIG_SPI_DW_MMIO)		+= spi-dw-mmio.o
 obj-$(CONFIG_SPI_DW_PCI)		+= spi-dw-midpci.o
 spi-dw-midpci-objs			:= spi-dw-pci.o spi-dw-mid.o
 obj-$(CONFIG_SPI_EP93XX)		+= spi-ep93xx.o
+obj-$(CONFIG_SPI_FALCON)		+= spi-falcon.o
 obj-$(CONFIG_SPI_FSL_LIB)		+= spi-fsl-lib.o
 obj-$(CONFIG_SPI_FSL_ESPI)		+= spi-fsl-espi.o
 obj-$(CONFIG_SPI_FSL_SPI)		+= spi-fsl-spi.o
diff --git a/drivers/spi/spi-falcon.c b/drivers/spi/spi-falcon.c
new file mode 100644
index 0000000..8b81aa2
--- /dev/null
+++ b/drivers/spi/spi-falcon.c
@@ -0,0 +1,483 @@
+/*
+ *  This program is free software; you can redistribute it and/or modify it
+ *  under the terms of the GNU General Public License version 2 as published
+ *  by the Free Software Foundation.
+ *
+ *  Copyright (C) 2010 Thomas Langer <thomas.langer@lantiq.com>
+ */
+
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/delay.h>
+#include <linux/workqueue.h>
+
+#include <lantiq_soc.h>
+
+#define DRV_NAME			"falcon_spi"
+
+#define FALCON_SPI_XFER_BEGIN		(1 << 0)
+#define FALCON_SPI_XFER_END		(1 << 1)
+
+/* Bus Read Configuration Register0 */
+#define LTQ_BUSRCON0	0x00000010
+/* Bus Write Configuration Register0 */
+#define LTQ_BUSWCON0	0x00000018
+/* Serial Flash Configuration Register */
+#define LTQ_SFCON	0x00000080
+/* Serial Flash Time Register */
+#define LTQ_SFTIME	0x00000084
+/* Serial Flash Status Register */
+#define LTQ_SFSTAT	0x00000088
+/* Serial Flash Command Register */
+#define LTQ_SFCMD	0x0000008C
+/* Serial Flash Address Register */
+#define LTQ_SFADDR	0x00000090
+/* Serial Flash Data Register */
+#define LTQ_SFDATA	0x00000094
+/* Serial Flash I/O Control Register */
+#define LTQ_SFIO	0x00000098
+/* EBU Clock Control Register */
+#define LTQ_EBUCC	0x000000C4
+
+/* Dummy Phase Length */
+#define SFCMD_DUMLEN_OFFSET	16
+#define SFCMD_DUMLEN_MASK	0x000F0000
+/* Chip Select */
+#define SFCMD_CS_OFFSET		24
+#define SFCMD_CS_MASK		0x07000000
+/* field offset */
+#define SFCMD_ALEN_OFFSET	20
+#define SFCMD_ALEN_MASK		0x00700000
+/* SCK Rise-edge Position */
+#define SFTIME_SCKR_POS_OFFSET	8
+#define SFTIME_SCKR_POS_MASK	0x00000F00
+/* SCK Period */
+#define SFTIME_SCK_PER_OFFSET	0
+#define SFTIME_SCK_PER_MASK	0x0000000F
+/* SCK Fall-edge Position */
+#define SFTIME_SCKF_POS_OFFSET	12
+#define SFTIME_SCKF_POS_MASK	0x0000F000
+/* Device Size */
+#define SFCON_DEV_SIZE_A23_0	0x03000000
+#define SFCON_DEV_SIZE_MASK	0x0F000000
+/* Read Data Position */
+#define SFTIME_RD_POS_MASK	0x000F0000
+/* Data Output */
+#define SFIO_UNUSED_WD_MASK	0x0000000F
+/* Command Opcode mask */
+#define SFCMD_OPC_MASK		0x000000FF
+/* dlen bytes of data to write */
+#define SFCMD_DIR_WRITE		0x00000100
+/* Data Length offset */
+#define SFCMD_DLEN_OFFSET	9
+/* Command Error */
+#define SFSTAT_CMD_ERR		0x20000000
+/* Access Command Pending */
+#define SFSTAT_CMD_PEND		0x00400000
+/* Frequency set to 100MHz. */
+#define EBUCC_EBUDIV_SELF100	0x00000001
+/* Serial Flash */
+#define BUSRCON0_AGEN_SERIAL_FLASH	0xF0000000
+/* 8-bit multiplexed */
+#define BUSRCON0_PORTW_8_BIT_MUX	0x00000000
+/* Serial Flash */
+#define BUSWCON0_AGEN_SERIAL_FLASH	0xF0000000
+/* Chip Select after opcode */
+#define SFCMD_KEEP_CS_KEEP_SELECTED	0x00008000
+
+struct falcon_spi {
+	u32 sfcmd; /* for caching of opcode, direction, ... */
+	struct spi_master *master;
+};
+
+int
+falcon_spi_xfer(struct spi_device *spi,
+		    struct spi_transfer *t,
+		    unsigned long flags)
+{
+	struct device *dev = &spi->dev;
+	struct falcon_spi *priv = spi_master_get_devdata(spi->master);
+	const u8 *txp = t->tx_buf;
+	u8 *rxp = t->rx_buf;
+	unsigned int bytelen = ((8 * t->len + 7) / 8);
+	unsigned int len, alen, dumlen;
+	u32 val;
+	enum {
+		state_init,
+		state_command_prepare,
+		state_write,
+		state_read,
+		state_disable_cs,
+		state_end
+	} state = state_init;
+
+	do {
+		switch (state) {
+		case state_init: /* detect phase of upper layer sequence */
+		{
+			/* initial write ? */
+			if (flags & FALCON_SPI_XFER_BEGIN) {
+				if (!txp) {
+					dev_err(dev,
+						"BEGIN without tx data!\n");
+					return -1;
+				}
+				/*
+				 * Prepare the parts of the sfcmd register,
+				 * which should not
+				 * change during a sequence!
+				 * Only exception are the length fields,
+				 * especially alen and dumlen.
+				 */
+
+				priv->sfcmd = ((spi->chip_select
+						<< SFCMD_CS_OFFSET)
+					       & SFCMD_CS_MASK);
+				priv->sfcmd |= SFCMD_KEEP_CS_KEEP_SELECTED;
+				priv->sfcmd |= *txp;
+				txp++;
+				bytelen--;
+				if (bytelen) {
+					/*
+					 * more data:
+					 * maybe address and/or dummy
+					 */
+					state = state_command_prepare;
+					break;
+				} else {
+					dev_dbg(dev, "write cmd %02X\n",
+						priv->sfcmd & SFCMD_OPC_MASK);
+				}
+			}
+			/* continued write ? */
+			if (txp && bytelen) {
+				state = state_write;
+				break;
+			}
+			/* read data? */
+			if (rxp && bytelen) {
+				state = state_read;
+				break;
+			}
+			/* end of sequence? */
+			if (flags & FALCON_SPI_XFER_END)
+				state = state_disable_cs;
+			else
+				state = state_end;
+			break;
+		}
+		/* collect tx data for address and dummy phase */
+		case state_command_prepare:
+		{
+			/* txp is valid, already checked */
+			val = 0;
+			alen = 0;
+			dumlen = 0;
+			while (bytelen > 0) {
+				if (alen < 3) {
+					val = (val<<8)|(*txp++);
+					alen++;
+				} else if ((dumlen < 15) && (*txp == 0)) {
+					/*
+					 * assume dummy bytes are set to 0
+					 * from upper layer
+					 */
+					dumlen++;
+					txp++;
+				} else
+					break;
+				bytelen--;
+			}
+			priv->sfcmd &= ~(SFCMD_ALEN_MASK | SFCMD_DUMLEN_MASK);
+			priv->sfcmd |= (alen << SFCMD_ALEN_OFFSET) |
+					 (dumlen << SFCMD_DUMLEN_OFFSET);
+			if (alen > 0)
+				ltq_ebu_w32(val, LTQ_SFADDR);
+
+			dev_dbg(dev, "write cmd %02X, alen=%d "
+				"(addr=%06X) dumlen=%d\n",
+				priv->sfcmd & SFCMD_OPC_MASK,
+				alen, val, dumlen);
+
+			if (bytelen > 0) {
+				/* continue with write */
+				state = state_write;
+			} else if (flags & FALCON_SPI_XFER_END) {
+				/* end of sequence? */
+				state = state_disable_cs;
+			} else {
+				/*
+				 * go to end and expect another
+				 * call (read or write)
+				 */
+				state = state_end;
+			}
+			break;
+		}
+		case state_write:
+		{
+			/* txp still valid */
+			priv->sfcmd |= SFCMD_DIR_WRITE;
+			len = 0;
+			val = 0;
+			do {
+				if (bytelen--)
+					val |= (*txp++) << (8 * len++);
+				if ((flags & FALCON_SPI_XFER_END)
+				    && (bytelen == 0)) {
+					priv->sfcmd &=
+						~SFCMD_KEEP_CS_KEEP_SELECTED;
+				}
+				if ((len == 4) || (bytelen == 0)) {
+					ltq_ebu_w32(val, LTQ_SFDATA);
+					ltq_ebu_w32(priv->sfcmd
+						| (len<<SFCMD_DLEN_OFFSET),
+						LTQ_SFCMD);
+					len = 0;
+					val = 0;
+					priv->sfcmd &= ~(SFCMD_ALEN_MASK
+							 | SFCMD_DUMLEN_MASK);
+				}
+			} while (bytelen);
+			state = state_end;
+			break;
+		}
+		case state_read:
+		{
+			/* read data */
+			priv->sfcmd &= ~SFCMD_DIR_WRITE;
+			do {
+				if ((flags & FALCON_SPI_XFER_END)
+				    && (bytelen <= 4)) {
+					priv->sfcmd &=
+						~SFCMD_KEEP_CS_KEEP_SELECTED;
+				}
+				len = (bytelen > 4) ? 4 : bytelen;
+				bytelen -= len;
+				ltq_ebu_w32(priv->sfcmd
+					|(len<<SFCMD_DLEN_OFFSET), LTQ_SFCMD);
+				priv->sfcmd &= ~(SFCMD_ALEN_MASK
+						 | SFCMD_DUMLEN_MASK);
+				do {
+					val = ltq_ebu_r32(LTQ_SFSTAT);
+					if (val & SFSTAT_CMD_ERR) {
+						/* reset error status */
+						dev_err(dev, "SFSTAT: CMD_ERR "
+							"(%x)\n", val);
+						ltq_ebu_w32(SFSTAT_CMD_ERR,
+							LTQ_SFSTAT);
+						return -1;
+					}
+				} while (val & SFSTAT_CMD_PEND);
+				val = ltq_ebu_r32(LTQ_SFDATA);
+				do {
+					*rxp = (val & 0xFF);
+					rxp++;
+					val >>= 8;
+					len--;
+				} while (len);
+			} while (bytelen);
+			state = state_end;
+			break;
+		}
+		case state_disable_cs:
+		{
+			priv->sfcmd &= ~SFCMD_KEEP_CS_KEEP_SELECTED;
+			ltq_ebu_w32(priv->sfcmd | (0 << SFCMD_DLEN_OFFSET),
+				LTQ_SFCMD);
+			val = ltq_ebu_r32(LTQ_SFSTAT);
+			if (val & SFSTAT_CMD_ERR) {
+				/* reset error status */
+				dev_err(dev, "SFSTAT: CMD_ERR (%x)\n", val);
+				ltq_ebu_w32(SFSTAT_CMD_ERR, LTQ_SFSTAT);
+				return -1;
+			}
+			state = state_end;
+			break;
+		}
+		case state_end:
+			break;
+		}
+	} while (state != state_end);
+
+	return 0;
+}
+
+static int
+falcon_spi_setup(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+	const u32 ebuclk = CLOCK_100M;
+	unsigned int i;
+	unsigned long flags;
+
+	dev_dbg(dev, "setup\n");
+
+	if (spi->master->bus_num > 0 || spi->chip_select > 0)
+		return -ENODEV;
+
+	spin_lock_irqsave(&ebu_lock, flags);
+
+	if (ebuclk < spi->max_speed_hz) {
+		/* set EBU clock to 100 MHz */
+		ltq_sys1_w32_mask(0, EBUCC_EBUDIV_SELF100, LTQ_EBUCC);
+		i = 1; /* divider */
+	} else {
+		/* set EBU clock to 50 MHz */
+		ltq_sys1_w32_mask(EBUCC_EBUDIV_SELF100, 0, LTQ_EBUCC);
+
+		/* search for suitable divider */
+		for (i = 1; i < 7; i++) {
+			if (ebuclk / i <= spi->max_speed_hz)
+				break;
+		}
+	}
+
+	/* setup period of serial clock */
+	ltq_ebu_w32_mask(SFTIME_SCKF_POS_MASK
+		     | SFTIME_SCKR_POS_MASK
+		     | SFTIME_SCK_PER_MASK,
+		     (i << SFTIME_SCKR_POS_OFFSET)
+		     | (i << (SFTIME_SCK_PER_OFFSET + 1)),
+		     LTQ_SFTIME);
+
+	/*
+	 * set some bits of unused_wd, to not trigger HOLD/WP
+	 * signals on non QUAD flashes
+	 */
+	ltq_ebu_w32((SFIO_UNUSED_WD_MASK & (0x8 | 0x4)), LTQ_SFIO);
+
+	ltq_ebu_w32(BUSRCON0_AGEN_SERIAL_FLASH | BUSRCON0_PORTW_8_BIT_MUX,
+		LTQ_BUSRCON0);
+	ltq_ebu_w32(BUSWCON0_AGEN_SERIAL_FLASH, LTQ_BUSWCON0);
+	/* set address wrap around to maximum for 24-bit addresses */
+	ltq_ebu_w32_mask(SFCON_DEV_SIZE_MASK, SFCON_DEV_SIZE_A23_0, LTQ_SFCON);
+
+	spin_unlock_irqrestore(&ebu_lock, flags);
+
+	return 0;
+}
+
+static int
+falcon_spi_transfer(struct spi_device *spi, struct spi_message *m)
+{
+	struct falcon_spi *priv = spi_master_get_devdata(spi->master);
+	struct spi_transfer *t;
+	unsigned long spi_flags;
+	unsigned long flags;
+	int ret = 0;
+
+	priv->sfcmd = 0;
+	m->actual_length = 0;
+
+	spi_flags = FALCON_SPI_XFER_BEGIN;
+	list_for_each_entry(t, &m->transfers, transfer_list) {
+		if (list_is_last(&t->transfer_list, &m->transfers))
+			spi_flags |= FALCON_SPI_XFER_END;
+
+		spin_lock_irqsave(&ebu_lock, flags);
+		ret = falcon_spi_xfer(spi, t, spi_flags);
+		spin_unlock_irqrestore(&ebu_lock, flags);
+
+		if (ret)
+			break;
+
+		m->actual_length += t->len;
+
+		if (t->delay_usecs || t->cs_change)
+			BUG();
+
+		spi_flags = 0;
+	}
+
+	m->status = ret;
+	m->complete(m->context);
+
+	return 0;
+}
+
+static void
+falcon_spi_cleanup(struct spi_device *spi)
+{
+	struct device *dev = &spi->dev;
+
+	dev_dbg(dev, "cleanup\n");
+}
+
+static int __devinit
+falcon_spi_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct falcon_spi *priv;
+	struct spi_master *master;
+	int ret;
+
+	dev_dbg(dev, "probing\n");
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*priv));
+	if (!master) {
+		dev_err(dev, "no memory for spi_master\n");
+		return -ENOMEM;
+	}
+
+	priv = spi_master_get_devdata(master);
+	priv->master = master;
+
+	master->mode_bits = SPI_MODE_3;
+	master->num_chipselect = 1;
+	master->bus_num = 0;
+
+	master->setup = falcon_spi_setup;
+	master->transfer = falcon_spi_transfer;
+	master->cleanup = falcon_spi_cleanup;
+
+	platform_set_drvdata(pdev, priv);
+
+	ret = spi_register_master(master);
+	if (ret)
+		spi_master_put(master);
+
+	return ret;
+}
+
+static int __devexit
+falcon_spi_remove(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct falcon_spi *priv = platform_get_drvdata(pdev);
+
+	dev_dbg(dev, "removed\n");
+
+	spi_unregister_master(priv->master);
+
+	return 0;
+}
+
+static struct platform_driver falcon_spi_driver = {
+	.probe	= falcon_spi_probe,
+	.remove	= __devexit_p(falcon_spi_remove),
+	.driver = {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE
+	}
+};
+
+static int __init
+falcon_spi_init(void)
+{
+	return platform_driver_register(&falcon_spi_driver);
+}
+
+static void __exit
+falcon_spi_exit(void)
+{
+	platform_driver_unregister(&falcon_spi_driver);
+}
+
+module_init(falcon_spi_init);
+module_exit(falcon_spi_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("Lantiq Falcon SPI controller driver");
-- 
1.7.7.1
