Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 27 Apr 2007 19:43:24 +0100 (BST)
Received: from ug-out-1314.google.com ([66.249.92.175]:41364 "EHLO
	ug-out-1314.google.com") by ftp.linux-mips.org with ESMTP
	id S20021450AbXD0SnT (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 27 Apr 2007 19:43:19 +0100
Received: by ug-out-1314.google.com with SMTP id 40so749654uga
        for <linux-mips@linux-mips.org>; Fri, 27 Apr 2007 11:42:18 -0700 (PDT)
DKIM-Signature:	a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type;
        b=FvoogL413hfkm2+FlPke6MMMW2x17pqUwiP163dO9zqnjKjGpnVPQbBd21OEAz39peWPPn5ro+q3lWpLeqRmcS9HMw2JvUH27KMdQfVCAaCjUzb9DmDGcJ4/OO42rkrjuvSmADuyhGohiKblgozYsc9TTTjvN6l9bpI6acBuQ5k=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type;
        b=DiO+bH9RDz3NLsPtRULzY2vdqxLsGg7IOOZZuoAH+9JcKKnA5JDo+yy6q4EPSWwNku4E7MHTk5TrhBX64ebQhFqfUGJlOYw6LahNXuv7TlG0QgjBOwKQ++i0UOHusH4fu9cvtVWH89WkT+5hg2E6VjA5rECGQgiVsyuw0/iGdW8=
Received: by 10.82.175.2 with SMTP id x2mr6365371bue.1177699337750;
        Fri, 27 Apr 2007 11:42:17 -0700 (PDT)
Received: from ?194.132.8.27? ( [85.70.229.122])
        by mx.google.com with ESMTP id c22sm591760ika.2007.04.27.11.42.15;
        Fri, 27 Apr 2007 11:42:16 -0700 (PDT)
Message-ID: <46324403.4080606@gmail.com>
Date:	Fri, 27 Apr 2007 20:42:11 +0200
From:	Jan Nikitenko <jan.nikitenko@gmail.com>
User-Agent: Thunderbird 1.5.0.10 (X11/20070327)
MIME-Version: 1.0
To:	David Brownell <david-b@pacbell.net>
CC:	spi-devel-general@lists.sourceforge.net, linux-mips@linux-mips.org
Subject: spi: Add support for au1550 spi controller
Content-Type: multipart/mixed;
 boundary="------------060606060301060801020402"
Return-Path: <jan.nikitenko@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 14924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jan.nikitenko@gmail.com
Precedence: bulk
X-list: linux-mips

This is a multi-part message in MIME format.
--------------060606060301060801020402
Content-Type: text/plain; charset=ISO-8859-2; format=flowed
Content-Transfer-Encoding: 7bit

Here is a patch (for 2.6.21 git as of 2007-04-27) with complete support 
for alchemy au1550 psc spi controller.

It supports dma transfers using alchemy descriptor based dma controller 
for 4 to 8 bits per spi word transfers.
For 9 to 24 bits per spi word transfers, pio irq based mode is used to 
avoid setup of dma channels from scratch on each number of bits per word 
change.

Tested with au1550, may also work on other mips alchemy cpus, like 
au1200/au1210/au1250.
Used extensively with SD card connected via SPI, handles 8.1MHz spi 
clock transfers using dma without any problem (the highest spi clock 
freq possible to get internally with au1550 running on 324MHz).

The driver supports sharing of spi bus by multiple devices, all features 
of alchemy spi controller are supported (all spi modes, msb/lsb first, 
bits per word in 4 to 24 range).

As the spi clock of the controller depends on main input clock that 
shall be configured externally, platform data structure for au1550 spi 
controller driver contains mainclk_hz attribute to define the input 
clock hz - from this value, dividers of the controller for spi clock are 
set up for required frequency.

Jan

Signed-off-by: Jan Nikitenko <jan.nikitenko@gmail.com>

  drivers/spi/Kconfig                       |   11
  drivers/spi/Makefile                      |    1
  drivers/spi/au1550_spi.c                  |  959 
++++++++++++++++++++++++++++++
  include/asm-mips/mach-au1x00/au1550_spi.h |   16
  4 files changed, 987 insertions(+)




--------------060606060301060801020402
Content-Type: text/plain;
 name="au1550-spi.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="au1550-spi.patch"

diff -urN linux-git.orig/drivers/spi/au1550_spi.c linux-git/drivers/spi/au1550_spi.c
--- linux-git.orig/drivers/spi/au1550_spi.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-git/drivers/spi/au1550_spi.c	2007-04-27 20:20:32.000000000 +0200
@@ -0,0 +1,959 @@
+/*
+ * au1550_spi.c - au1550 psc spi controller driver
+ * may work also with au1200, au1210, au1250
+ * will not work on au1000, au1100 and au1500 (no full spi controller there)
+ *
+ * Copyright (c) 2006 ATRON electronic GmbH
+ * Author: Jan Nikitenko <jan.nikitenko@gmail.com>
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
+ * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#include <linux/init.h>
+#include <linux/interrupt.h>
+#include <linux/errno.h>
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/spi_bitbang.h>
+#include <linux/dma-mapping.h>
+#include <linux/completion.h>
+#include <asm/mach-au1x00/au1000.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+
+#include <asm/mach-au1x00/au1550_spi.h>
+
+static unsigned usedma = 1;
+module_param(usedma, uint, 0644);
+
+/*
+#define AU1550_SPI_DEBUG_LOOPBACK
+*/
+
+
+#define AU1550_SPI_DBDMA_DESCRIPTORS 1
+#define AU1550_SPI_DMA_RXTMP_MINSIZE 2048U
+
+struct au1550_spi {
+	struct spi_bitbang bitbang;
+
+	volatile psc_spi_t __iomem *regs;
+	int irq;
+	unsigned freq_max;
+	unsigned freq_min;
+	
+	unsigned len;
+	unsigned tx_count;
+	unsigned rx_count;
+	const u8 *tx;
+	u8 *rx;
+	
+	void (*rx_word)(struct au1550_spi *hw);
+	void (*tx_word)(struct au1550_spi *hw);
+	int (*txrx_bufs)(struct spi_device *spi, struct spi_transfer *t);
+	irqreturn_t (*irq_callback)(struct au1550_spi *hw);
+	
+	struct completion master_done;
+	
+	u32 dma_tx_id;
+	u32 dma_rx_id;
+	u32 dma_tx_ch;
+	u32 dma_rx_ch;
+
+	u8 *dma_rx_tmpbuf;
+	unsigned dma_rx_tmpbuf_size;
+	u32 dma_rx_tmpbuf_addr;
+
+	struct spi_master *master;
+	struct device *dev;
+	struct au1550_spi_info *pdata;
+};
+
+
+static u64 au1550_spi_dma_mask = ~(u32)0;
+
+/* we need 8-bit memory device for dma transfers to/from spi fifo */
+static dbdev_tab_t au1550_spi_mem_dbdev =
+{
+	DSCR_CMD0_ALWAYS, DEV_FLAGS_ANYUSE|DEV_FLAGS_SYNC,0,8,0x00000000,0,0
+};
+
+static void au1550_spi_bits_handlers_set(struct au1550_spi *hw, int bpw);
+
+
+/**
+ *  compute BRG and DIV bits to setup spi clock based on main input clock rate
+ *  that was specified in platform data structure
+ *  according to au1550 datasheet:
+ *    psc_tempclk = psc_mainclk / (2 << DIV)
+ *    spiclk = psc_tempclk / (2 * (BRG + 1))
+ *    BRG valid range is 4..63
+ *    DIV valid range is 0..3
+ */
+static u32 au1550_spi_baudcfg(struct au1550_spi *hw, unsigned speed_hz)
+{
+	u32 mainclk_hz = hw->pdata->mainclk_hz;
+	u32 div, brg;
+
+	for (div = 0; div < 4; div++) {
+		brg = mainclk_hz / speed_hz / (4 << div);
+		/* now we have BRG+1 in brg, so count with that */
+		if (brg < (4 + 1)) {
+			brg = (4 + 1);	/* speed_hz too big */
+			break;		/* set lowest brg (div is == 0) */
+		}
+		if (brg <= (63 + 1))
+			break;		/* we have valid brg and div */
+	}
+	if (div == 4) {
+		div = 3;		/* speed_hz too small */
+		brg = (63 + 1);		/* set highest brg and div */
+	}
+	brg--;
+	return PSC_SPICFG_SET_BAUD(brg) | PSC_SPICFG_SET_DIV(div);
+}
+
+static inline void au1550_spi_mask_ack_all(struct au1550_spi *hw)
+{
+	hw->regs->psc_spimsk =
+	    PSC_SPIMSK_MM | PSC_SPIMSK_RR | PSC_SPIMSK_RO |
+	    PSC_SPIMSK_RU | PSC_SPIMSK_TR | PSC_SPIMSK_TO |
+	    PSC_SPIMSK_TU | PSC_SPIMSK_SD | PSC_SPIMSK_MD;
+	au_sync();
+
+	hw->regs->psc_spievent = PSC_SPIEVNT_MM | PSC_SPIEVNT_RR
+	    | PSC_SPIEVNT_RO | PSC_SPIEVNT_RU | PSC_SPIEVNT_TR
+	    | PSC_SPIEVNT_TO | PSC_SPIEVNT_TU | PSC_SPIEVNT_SD
+	    | PSC_SPIEVNT_MD;
+	au_sync();
+}
+
+static void au1550_spi_reset_fifos(struct au1550_spi *hw)
+{
+	u32 pcr;
+	hw->regs->psc_spipcr = PSC_SPIPCR_RC | PSC_SPIPCR_TC;
+	au_sync();
+	do {
+		pcr = hw->regs->psc_spipcr;
+		au_sync();
+	} while (pcr != 0);
+}
+
+/*
+ * dma transfers are used for the most common spi word size of 8-bits
+ * we cannot easily change already set up dma channels' width, so if we wanted
+ * dma support for more than 8-bit words (up to 24 bits), we would need to
+ * setup dma channels from scratch on each spi transfer, based on bits_per_word
+ * instead we have pre set up 8 bit dma channels supporting spi 4 to 8 bits
+ * transfers, and 9 to 24 bits spi transfers will be done in pio irq based mode
+ * callbacks to handle dma or pio are set up in au1550_spi_bits_handlers_set()
+ */
+static void au1550_spi_chipsel(struct spi_device *spi, int value)
+{
+	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
+	unsigned cspol = spi->mode & SPI_CS_HIGH ? 1 : 0;
+	u32 cfg, stat;
+
+	switch (value) {
+	case BITBANG_CS_INACTIVE:
+		if (hw->pdata->deactivate_cs)
+			hw->pdata->deactivate_cs(hw->pdata, spi->chip_select,
+						 cspol);
+		break;
+
+	case BITBANG_CS_ACTIVE:
+		au1550_spi_bits_handlers_set(hw, spi->bits_per_word);
+		
+		cfg = hw->regs->psc_spicfg;
+		au_sync();
+		hw->regs->psc_spicfg = cfg & ~PSC_SPICFG_DE_ENABLE;
+		au_sync();
+
+		if (spi->mode & SPI_CPOL)
+			cfg |= PSC_SPICFG_BI;
+		else
+			cfg &= ~PSC_SPICFG_BI;
+		if (spi->mode & SPI_CPHA)
+			cfg &= ~PSC_SPICFG_CDE;
+		else
+			cfg |= PSC_SPICFG_CDE;
+			
+		if (spi->mode & SPI_LSB_FIRST)
+			cfg |= PSC_SPICFG_MLF;
+		else
+			cfg &= ~PSC_SPICFG_MLF;
+
+		if (usedma && spi->bits_per_word <= 8)
+			cfg &= ~PSC_SPICFG_DD_DISABLE;
+		else
+			cfg |= PSC_SPICFG_DD_DISABLE;
+		cfg = PSC_SPICFG_CLR_LEN(cfg);
+		cfg |= PSC_SPICFG_SET_LEN(spi->bits_per_word);
+
+		cfg = PSC_SPICFG_CLR_BAUD(cfg);
+		cfg &= ~PSC_SPICFG_SET_DIV(3);
+		cfg |= au1550_spi_baudcfg(hw, spi->max_speed_hz);
+
+		hw->regs->psc_spicfg = cfg | PSC_SPICFG_DE_ENABLE;
+		au_sync();
+		do {
+			stat = hw->regs->psc_spistat;
+			au_sync();
+		} while ((stat & PSC_SPISTAT_DR) == 0);
+
+		if (hw->pdata->activate_cs)
+			hw->pdata->activate_cs(hw->pdata, spi->chip_select,
+					       cspol);
+		break;
+	}
+}
+
+static int au1550_spi_setupxfer(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
+	unsigned bpw, hz;
+	u32 cfg, stat;
+
+	bpw = t ? t->bits_per_word : spi->bits_per_word;
+	hz = t ? t->speed_hz : spi->max_speed_hz;
+
+	if (bpw < 4 || bpw > 24) {
+		dev_err(&spi->dev, "setupxfer: invalid bits_per_word=%d\n",
+			bpw);
+		return -EINVAL;
+	}
+	if (hz > spi->max_speed_hz || hz > hw->freq_max || hz < hw->freq_min) {
+		dev_err(&spi->dev, "setupxfer: clock rate=%d out of range\n",
+			hz);
+		return -EINVAL;
+	}
+	
+	au1550_spi_bits_handlers_set(hw, spi->bits_per_word);
+
+	cfg = hw->regs->psc_spicfg;
+	au_sync();
+	hw->regs->psc_spicfg = cfg & ~PSC_SPICFG_DE_ENABLE;
+	au_sync();
+
+	if (usedma && bpw <= 8)
+		cfg &= ~PSC_SPICFG_DD_DISABLE;
+	else
+		cfg |= PSC_SPICFG_DD_DISABLE;
+	cfg = PSC_SPICFG_CLR_LEN(cfg);
+	cfg |= PSC_SPICFG_SET_LEN(bpw);
+
+	cfg = PSC_SPICFG_CLR_BAUD(cfg);
+	cfg &= ~PSC_SPICFG_SET_DIV(3);
+	cfg |= au1550_spi_baudcfg(hw, hz);
+
+	hw->regs->psc_spicfg = cfg;
+	au_sync();
+
+	if (cfg & PSC_SPICFG_DE_ENABLE) {
+		do {
+			stat = hw->regs->psc_spistat;
+			au_sync();
+		} while ((stat & PSC_SPISTAT_DR) == 0);
+	}
+
+	au1550_spi_reset_fifos(hw);
+	au1550_spi_mask_ack_all(hw);
+	return 0;
+}
+
+static int au1550_spi_setup(struct spi_device *spi)
+{
+	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
+
+	if (spi->bits_per_word == 0)
+		spi->bits_per_word = 8;
+	if (spi->bits_per_word < 4 || spi->bits_per_word > 24) {
+		dev_err(&spi->dev, "setup: invalid bits_per_word=%d\n",
+			spi->bits_per_word);
+		return -EINVAL;
+	}
+
+	if (spi->max_speed_hz == 0)
+		spi->max_speed_hz = hw->freq_max;
+	if (spi->max_speed_hz > hw->freq_max
+		|| spi->max_speed_hz < hw->freq_min)
+			return -EINVAL;
+	/*
+	 * NOTE: cannot change speed and other hw settings immediately,
+	 *       otherwise sharing of spi bus is not possible,
+	 *       so do not call setupxfer(spi, NULL) here
+	 */
+	return 0;
+}
+
+/*
+ * for dma spi transfers, we have to setup rx channel, otherwise there is
+ * no reliable way how to recognize that spi transfer is done
+ * dma complete callbacks are called before real spi transfer is finished
+ * and if only tx dma channel is set up (and rx fifo overflow event masked)
+ * spi master done event irq is not generated unless rx fifo is empty (emptied)
+ * so we need rx tmp buffer to use for rx dma if user does not provide one
+ */
+static int au1550_spi_dma_rxtmp_alloc(struct au1550_spi *hw, unsigned size)
+{
+	hw->dma_rx_tmpbuf = kmalloc(size, GFP_KERNEL);
+	if (!hw->dma_rx_tmpbuf)
+		return -ENOMEM;
+	hw->dma_rx_tmpbuf_size = size;
+	hw->dma_rx_tmpbuf_addr = dma_map_single(hw->dev, hw->dma_rx_tmpbuf,
+		size, DMA_FROM_DEVICE);
+	if (dma_mapping_error(hw->dma_rx_tmpbuf_addr)) {
+		kfree(hw->dma_rx_tmpbuf);
+		hw->dma_rx_tmpbuf = 0;
+		hw->dma_rx_tmpbuf_size = 0;
+		return -EFAULT;
+	}
+	return 0;
+}
+
+static void au1550_spi_dma_rxtmp_free(struct au1550_spi *hw)
+{
+	dma_unmap_single(hw->dev, hw->dma_rx_tmpbuf_addr,
+		hw->dma_rx_tmpbuf_size, DMA_FROM_DEVICE);
+	kfree(hw->dma_rx_tmpbuf);
+	hw->dma_rx_tmpbuf = 0;
+	hw->dma_rx_tmpbuf_size = 0;
+}
+
+static int au1550_spi_dma_txrxb(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
+	dma_addr_t dma_tx_addr;
+	dma_addr_t dma_rx_addr;
+	u32 res;
+
+	hw->len = t->len;
+	hw->tx_count = 0;
+	hw->rx_count = 0;
+	
+	hw->tx = t->tx_buf;
+	hw->rx = t->rx_buf;
+	dma_tx_addr = t->tx_dma;
+	dma_rx_addr = t->rx_dma;
+	
+	/*
+	 * check if buffers are already dma mapped, map them otherwise
+	 * use rx buffer in place of tx if tx buffer was not provided
+	 * use temp rx buffer (preallocated or realloc to fit) for rx dma
+	 */
+	if (t->rx_buf) {
+		if (t->rx_dma == 0) {	/* if DMA_ADDR_INVALID, map it */
+			dma_rx_addr = dma_map_single(hw->dev,
+				(void *)t->rx_buf, t->len, DMA_FROM_DEVICE);
+			if (dma_mapping_error(dma_rx_addr))
+				dev_err(hw->dev, "rx dma map error\n");
+		}
+	} else {
+		if (t->len > hw->dma_rx_tmpbuf_size) {
+			int ret;
+			au1550_spi_dma_rxtmp_free(hw);
+			ret = au1550_spi_dma_rxtmp_alloc(hw,
+				max(t->len, AU1550_SPI_DMA_RXTMP_MINSIZE));
+			if (ret < 0)
+				return ret;
+		}
+		hw->rx = hw->dma_rx_tmpbuf;
+		dma_rx_addr = hw->dma_rx_tmpbuf_addr;
+		dma_sync_single_for_device(hw->dev, dma_rx_addr,
+			t->len, DMA_FROM_DEVICE);
+	}
+	if (t->tx_buf) {
+		if (t->tx_dma == 0) {	/* if DMA_ADDR_INVALID, map it */
+			dma_tx_addr = dma_map_single(hw->dev,
+				(void *)t->tx_buf, t->len, DMA_TO_DEVICE);
+			if (dma_mapping_error(dma_tx_addr))
+				dev_err(hw->dev, "tx dma map error\n");
+		}
+	} else {
+		dma_sync_single_for_device(hw->dev, dma_rx_addr,
+			t->len, DMA_BIDIRECTIONAL);
+		hw->tx = hw->rx;
+	}
+	
+	/* put buffers on the ring */
+	res = au1xxx_dbdma_put_dest(hw->dma_rx_ch, hw->rx, t->len);
+	if (!res)
+		dev_err(hw->dev, "rx dma put dest error\n");
+
+	res = au1xxx_dbdma_put_source(hw->dma_tx_ch, (void *)hw->tx, t->len);
+	if (!res)
+		dev_err(hw->dev, "tx dma put source error\n");
+
+	au1xxx_dbdma_start(hw->dma_rx_ch);
+	au1xxx_dbdma_start(hw->dma_tx_ch);
+
+	/* by default enable nearly all events interrupt */
+	hw->regs->psc_spimsk = PSC_SPIMSK_SD;
+	au_sync();
+
+	/* start the transfer */
+	hw->regs->psc_spipcr = PSC_SPIPCR_MS;
+	au_sync();
+	
+	wait_for_completion(&hw->master_done);
+
+	au1xxx_dbdma_stop(hw->dma_tx_ch);
+	au1xxx_dbdma_stop(hw->dma_rx_ch);
+
+	if (!t->rx_buf) {
+		/* using the temporal preallocated and premapped buffer */
+		dma_sync_single_for_cpu(hw->dev, dma_rx_addr, t->len,
+			DMA_FROM_DEVICE);
+	}
+	/* unmap buffers if mapped above */
+	if (t->rx_buf && t->rx_dma == 0 )
+		dma_unmap_single(hw->dev, dma_rx_addr, t->len,
+			DMA_FROM_DEVICE);
+	if (t->tx_buf && t->tx_dma == 0 )
+		dma_unmap_single(hw->dev, dma_tx_addr, t->len,
+			DMA_TO_DEVICE);
+
+	return hw->rx_count < hw->tx_count ? hw->rx_count : hw->tx_count;
+}
+
+static irqreturn_t au1550_spi_dma_irq_callback(struct au1550_spi *hw)
+{
+	u32 stat, evnt;
+
+	stat = hw->regs->psc_spistat;
+	evnt = hw->regs->psc_spievent;
+	au_sync();
+	if ((stat & PSC_SPISTAT_DI) == 0) {
+		dev_err(hw->dev, "Unexpected IRQ!\n");
+		return IRQ_NONE;
+	}
+
+	if ((evnt &
+	     (PSC_SPIEVNT_MM | PSC_SPIEVNT_RO | PSC_SPIEVNT_RU | PSC_SPIEVNT_TO
+	      | PSC_SPIEVNT_TU | PSC_SPIEVNT_SD)) != 0) {
+		/*
+		 * due to an spi error we consider transfer as done,
+		 * so mask all events until before next transfer start
+		 * and stop the possibly running dma immediatelly
+		 */
+		au1550_spi_mask_ack_all(hw);
+		au1xxx_dbdma_stop(hw->dma_rx_ch);
+		au1xxx_dbdma_stop(hw->dma_tx_ch);
+
+		/* get number of transfered bytes */
+		hw->rx_count = hw->len - au1xxx_get_dma_residue(hw->dma_rx_ch);
+		hw->tx_count = hw->len - au1xxx_get_dma_residue(hw->dma_tx_ch);
+		
+		au1xxx_dbdma_reset(hw->dma_rx_ch);
+		au1xxx_dbdma_reset(hw->dma_tx_ch);
+		au1550_spi_reset_fifos(hw);
+
+		dev_err(hw->dev,
+			"Unexpected SPI error: event=0x%x stat=0x%x!\n",
+			evnt, stat);
+
+		complete(&hw->master_done);
+		return IRQ_HANDLED;
+	}
+
+	if ((evnt & PSC_SPIEVNT_MD) != 0) {
+		/* transfer completed successfully */
+		au1550_spi_mask_ack_all(hw);
+		hw->rx_count = hw->len;
+		hw->tx_count = hw->len;
+		complete(&hw->master_done);
+	}
+	return IRQ_HANDLED;
+}
+
+
+/* routines to handle different word sizes in pio mode */
+#define AU1550_SPI_RX_WORD(size, mask)					\
+static void au1550_spi_rx_word_##size(struct au1550_spi *hw)		\
+{									\
+	u32 fifoword = hw->regs->psc_spitxrx & (u32)(mask);		\
+	au_sync();							\
+	if (hw->rx)							\
+		*(u##size *)hw->rx = (u##size)fifoword;			\
+	hw->rx += (size) / 8;						\
+	hw->rx_count += (size) / 8;					\
+}
+
+#define AU1550_SPI_TX_WORD(size, mask)					\
+static void au1550_spi_tx_word_##size(struct au1550_spi *hw)		\
+{									\
+	u32 fifoword = 0;						\
+	if (hw->tx)							\
+		fifoword = *(u##size *)hw->tx & (u32)(mask);		\
+	hw->tx += (size) / 8;						\
+	hw->tx_count += (size) / 8;					\
+	if (hw->tx_count >= hw->len)					\
+		fifoword |= PSC_SPITXRX_LC;				\
+	hw->regs->psc_spitxrx = fifoword;				\
+	au_sync();							\
+}
+
+AU1550_SPI_RX_WORD(8,0xff)
+AU1550_SPI_RX_WORD(16,0xffff)
+AU1550_SPI_RX_WORD(32,0xffffff)
+AU1550_SPI_TX_WORD(8,0xff)
+AU1550_SPI_TX_WORD(16,0xffff)
+AU1550_SPI_TX_WORD(32,0xffffff)
+
+static int au1550_spi_pio_txrxb(struct spi_device *spi, struct spi_transfer *t)
+{
+	u32 stat, mask;
+	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
+
+	hw->tx = t->tx_buf;
+	hw->rx = t->rx_buf;
+	hw->len = t->len;
+	hw->tx_count = 0;
+	hw->rx_count = 0;
+
+	/* by default enable nearly all events after filling tx fifo */
+	mask = PSC_SPIMSK_SD;
+
+	/* fill the transmit FIFO */
+	while (hw->tx_count < hw->len) {
+		
+		hw->tx_word(hw);
+		
+		if (hw->tx_count >= hw->len) {
+			/* mask tx fifo request interrupt as we are done */
+			mask |= PSC_SPIMSK_TR;
+		}
+
+		stat = hw->regs->psc_spistat;
+		au_sync();
+		if (stat & PSC_SPISTAT_TF)
+			break;
+	}
+
+	/* enable event interrupts */
+	hw->regs->psc_spimsk = mask;
+	au_sync();
+
+	/* start the transfer */
+	hw->regs->psc_spipcr = PSC_SPIPCR_MS;
+	au_sync();
+
+	wait_for_completion(&hw->master_done);
+
+	return hw->rx_count < hw->tx_count ? hw->rx_count : hw->tx_count;
+}
+
+static irqreturn_t au1550_spi_pio_irq_callback(struct au1550_spi *hw)
+{
+	int busy;
+	u32 stat, evnt;
+
+	stat = hw->regs->psc_spistat;
+	evnt = hw->regs->psc_spievent;
+	au_sync();
+	if ((stat & PSC_SPISTAT_DI) == 0) {
+		dev_err(hw->dev, "Unexpected IRQ!\n");
+		return IRQ_NONE;
+	}
+
+	if ((evnt &
+	     (PSC_SPIEVNT_MM | PSC_SPIEVNT_RO | PSC_SPIEVNT_RU | PSC_SPIEVNT_TO
+	      | PSC_SPIEVNT_TU | PSC_SPIEVNT_SD)) != 0) {
+		dev_err(hw->dev,
+			"Unexpected SPI error: event=0x%x stat=0x%x!\n",
+			evnt, stat);
+		/*
+		 * due to an error we consider transfer as done,
+		 * so mask all events until before next transfer start
+		 */
+		au1550_spi_mask_ack_all(hw);
+		complete(&hw->master_done);
+		return IRQ_HANDLED;
+	}
+
+	/*
+	 * while there is something to read from rx fifo
+	 * or there is a space to write to tx fifo:
+	 */
+	do {
+		busy = 0;
+		stat = hw->regs->psc_spistat;
+		au_sync();
+
+		if ((stat & PSC_SPISTAT_RE) == 0 && hw->rx_count < hw->len) {
+			hw->rx_word(hw);
+			/* ack the receive request event */
+			hw->regs->psc_spievent = PSC_SPIEVNT_RR;
+			au_sync();
+			busy = 1;
+		}
+
+		if ((stat & PSC_SPISTAT_TF) == 0 && hw->tx_count < hw->len) {
+			hw->tx_word(hw);
+			/* ack the transmit request event */
+			hw->regs->psc_spievent = PSC_SPIEVNT_TR;
+			au_sync();
+			busy = 1;
+		}
+	} while (busy);
+
+	evnt = hw->regs->psc_spievent;
+	au_sync();
+
+	if (hw->rx_count >= hw->len || (evnt & PSC_SPIEVNT_MD) != 0) {
+		/* transfer completed successfully */
+		au1550_spi_mask_ack_all(hw);
+		complete(&hw->master_done);
+	}
+	return IRQ_HANDLED;
+}
+
+static int au1550_spi_txrx_bufs(struct spi_device *spi, struct spi_transfer *t)
+{
+	struct au1550_spi *hw = spi_master_get_devdata(spi->master);
+	return hw->txrx_bufs(spi, t);
+}
+
+static irqreturn_t au1550_spi_irq(int irq, void *dev, struct pt_regs *regs)
+{
+	struct au1550_spi *hw = dev;
+	return hw->irq_callback(hw);
+}
+
+static void au1550_spi_bits_handlers_set(struct au1550_spi *hw, int bpw)
+{
+	if (bpw <= 8) {
+		if (usedma) {
+			hw->txrx_bufs = &au1550_spi_dma_txrxb;
+			hw->irq_callback = &au1550_spi_dma_irq_callback;
+		} else {
+			hw->rx_word = &au1550_spi_rx_word_8;
+			hw->tx_word = &au1550_spi_tx_word_8;
+			hw->txrx_bufs = &au1550_spi_pio_txrxb;
+			hw->irq_callback = &au1550_spi_pio_irq_callback;
+		}
+	} else if (bpw <= 16) {
+		hw->rx_word = &au1550_spi_rx_word_16;
+		hw->tx_word = &au1550_spi_tx_word_16;
+		hw->txrx_bufs = &au1550_spi_pio_txrxb;
+		hw->irq_callback = &au1550_spi_pio_irq_callback;
+	} else {
+		hw->rx_word = &au1550_spi_rx_word_32;
+		hw->tx_word = &au1550_spi_tx_word_32;
+		hw->txrx_bufs = &au1550_spi_pio_txrxb;
+		hw->irq_callback = &au1550_spi_pio_irq_callback;
+	}
+}
+
+static void au1550_spi_setup_psc_as_spi(struct au1550_spi *hw)
+{
+	u32 stat, cfg;
+	
+	/* set up the PSC for SPI mode */
+	hw->regs->psc_ctrl = PSC_CTRL_DISABLE;
+	au_sync();
+	hw->regs->psc_sel = PSC_SEL_PS_SPIMODE;
+	au_sync();
+
+	hw->regs->psc_spicfg = 0;
+	au_sync();
+
+	hw->regs->psc_ctrl = PSC_CTRL_ENABLE;
+	au_sync();
+
+	do {
+		stat = hw->regs->psc_spistat;
+		au_sync();
+	} while ((stat & PSC_SPISTAT_SR) == 0);
+
+
+	cfg = usedma ? 0 : PSC_SPICFG_DD_DISABLE;
+	cfg |= PSC_SPICFG_SET_LEN(8);
+	cfg |= PSC_SPICFG_RT_FIFO8 | PSC_SPICFG_TT_FIFO8;
+	/* use minimal allowed brg and div values as initial setting: */
+	cfg |= PSC_SPICFG_SET_BAUD(4) | PSC_SPICFG_SET_DIV(0);
+
+#ifdef AU1550_SPI_DEBUG_LOOPBACK
+	cfg |= PSC_SPICFG_LB;
+#endif
+
+	hw->regs->psc_spicfg = cfg;
+	au_sync();
+
+	au1550_spi_mask_ack_all(hw);
+
+	hw->regs->psc_spicfg |= PSC_SPICFG_DE_ENABLE;
+	au_sync();
+
+	do {
+		stat = hw->regs->psc_spistat;
+		au_sync();
+	} while ((stat & PSC_SPISTAT_DR) == 0);
+}
+
+
+static int au1550_spi_probe(struct platform_device *pdev)
+{
+	struct au1550_spi *hw;
+	struct spi_master *master;
+	int err = 0;
+
+	master = spi_alloc_master(&pdev->dev, sizeof(struct au1550_spi));
+	if (master == NULL) {
+		dev_err(&pdev->dev, "No memory for spi_master\n");
+		err = -ENOMEM;
+		goto err_nomem;
+	}
+
+	hw = spi_master_get_devdata(master);
+	memset(hw, 0, sizeof(struct au1550_spi));
+
+	hw->master = spi_master_get(master);
+	hw->pdata = pdev->dev.platform_data;
+	hw->dev = &pdev->dev;
+
+	if (hw->pdata == NULL) {
+		dev_err(&pdev->dev, "No platform data supplied\n");
+		err = -ENOENT;
+		goto err_no_pdata;
+	}
+	
+	platform_set_drvdata(pdev, hw);
+
+	init_completion(&hw->master_done);
+	
+	hw->bitbang.master = hw->master;
+	hw->bitbang.setup_transfer = au1550_spi_setupxfer;
+	hw->bitbang.chipselect = au1550_spi_chipsel;
+	hw->bitbang.master->setup = au1550_spi_setup;
+	hw->bitbang.txrx_bufs = au1550_spi_txrx_bufs;
+
+	switch (hw->pdata->bus_num) {
+	case 0:
+		hw->irq = AU1550_PSC0_INT;
+		hw->regs = (volatile psc_spi_t *)PSC0_BASE_ADDR;
+		hw->dma_rx_id = DSCR_CMD0_PSC0_RX;
+		hw->dma_tx_id = DSCR_CMD0_PSC0_TX;
+		break;
+	case 1:
+		hw->irq = AU1550_PSC1_INT;
+		hw->regs = (volatile psc_spi_t *)PSC1_BASE_ADDR;
+		hw->dma_rx_id = DSCR_CMD0_PSC1_RX;
+		hw->dma_tx_id = DSCR_CMD0_PSC1_TX;
+		break;
+	case 2:
+		hw->irq = AU1550_PSC2_INT;
+		hw->regs = (volatile psc_spi_t *)PSC2_BASE_ADDR;
+		hw->dma_rx_id = DSCR_CMD0_PSC2_RX;
+		hw->dma_tx_id = DSCR_CMD0_PSC2_TX;
+		break;
+	case 3:
+		hw->irq = AU1550_PSC3_INT;
+		hw->regs = (volatile psc_spi_t *)PSC3_BASE_ADDR;
+		hw->dma_rx_id = DSCR_CMD0_PSC3_RX;
+		hw->dma_tx_id = DSCR_CMD0_PSC3_TX;
+		break;
+	default:
+		dev_err(&pdev->dev, "Wrong bus_num of SPI\n");
+		err = -ENOENT;
+		goto err_no_pdata;
+	}
+
+	if (request_mem_region((unsigned long)hw->regs, sizeof(psc_spi_t),
+			       pdev->name) == NULL) {
+		dev_err(&pdev->dev, "Cannot reserve iomem region\n");
+		err = -ENXIO;
+		goto err_no_iores;
+	}
+
+
+	if (usedma) {
+		/*
+		 * create memory device with 8 bits dev_devwidth
+		 * needed for proper byte ordering to spi fifo
+		 */
+		int memid = au1xxx_ddma_add_device(&au1550_spi_mem_dbdev);
+		if (!memid) {
+			dev_err(&pdev->dev,
+				"Cannot create dma 8 bit mem device\n");
+			err = -ENXIO;
+			goto err_dma_add_dev;
+		}
+
+		hw->dma_tx_ch = au1xxx_dbdma_chan_alloc(memid,
+			hw->dma_tx_id, NULL, (void *)hw);
+		if (hw->dma_tx_ch == 0) {
+			dev_err(&pdev->dev,
+				"Cannot allocate tx dma channel\n");
+			err = -ENXIO;
+			goto err_no_txdma;
+		}
+		au1xxx_dbdma_set_devwidth(hw->dma_tx_ch, 8);
+		if (au1xxx_dbdma_ring_alloc(hw->dma_tx_ch,
+			AU1550_SPI_DBDMA_DESCRIPTORS) == 0) {
+			dev_err(&pdev->dev,
+				"Cannot allocate tx dma descriptors\n");
+			err = -ENXIO;
+			goto err_no_txdma_descr;
+		}
+		
+
+		hw->dma_rx_ch = au1xxx_dbdma_chan_alloc(hw->dma_rx_id,
+			memid, NULL, (void *)hw);
+		if (hw->dma_rx_ch == 0) {
+			dev_err(&pdev->dev,
+				"Cannot allocate rx dma channel\n");
+			err = -ENXIO;
+			goto err_no_rxdma;
+		}
+		au1xxx_dbdma_set_devwidth(hw->dma_rx_ch, 8);
+		if (au1xxx_dbdma_ring_alloc(hw->dma_rx_ch,
+			AU1550_SPI_DBDMA_DESCRIPTORS) == 0) {
+			dev_err(&pdev->dev,
+				"Cannot allocate rx dma descriptors\n");
+			err = -ENXIO;
+			goto err_no_rxdma_descr;
+		}
+		
+		err = au1550_spi_dma_rxtmp_alloc(hw,
+			AU1550_SPI_DMA_RXTMP_MINSIZE);
+		if (err < 0) {
+			dev_err(&pdev->dev,
+				"Cannot allocate initial rx dma tmp buffer\n");
+			goto err_dma_rxtmp_alloc;
+		}
+
+		if (pdev->dev.dma_mask == NULL)
+			pdev->dev.dma_mask = &au1550_spi_dma_mask;
+	}
+	
+	au1550_spi_bits_handlers_set(hw, 8);
+	
+	err = request_irq(hw->irq, au1550_spi_irq, 0, pdev->name, hw);
+	if (err) {
+		dev_err(&pdev->dev, "Cannot claim IRQ\n");
+		goto err_no_irq;
+	}
+
+	master->bus_num = hw->pdata->bus_num;
+	master->num_chipselect = hw->pdata->num_chipselect;
+
+	/*
+	 *  precompute valid range for spi freq - from au1550 datasheet:
+	 *    psc_tempclk = psc_mainclk / (2 << DIV)
+	 *    spiclk = psc_tempclk / (2 * (BRG + 1))
+	 *    BRG valid range is 4..63
+	 *    DIV valid range is 0..3
+	 *  round the min and max frequencies to values that would still
+	 *  produce valid brg and div
+	 */
+	{
+		int min_div = (2 << 0) * (2 * (4 + 1));
+		int max_div = (2 << 3) * (2 * (63 + 1));
+		hw->freq_max = hw->pdata->mainclk_hz / min_div;
+		hw->freq_min = hw->pdata->mainclk_hz / (max_div + 1) + 1;
+	}
+
+	au1550_spi_setup_psc_as_spi(hw);
+
+	err = spi_bitbang_start(&hw->bitbang);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to register SPI master\n");
+		goto err_register;
+	}
+
+	dev_info(&pdev->dev,
+		 "spi master registered: bus_num=%d num_chipselect=%d\n",
+		 master->bus_num, master->num_chipselect);
+
+	return 0;
+
+      err_register:
+	free_irq(hw->irq, hw);
+
+      err_no_irq:
+	au1550_spi_dma_rxtmp_free(hw);
+
+      err_dma_rxtmp_alloc:
+      err_no_rxdma_descr:
+	if (usedma)
+		au1xxx_dbdma_chan_free(hw->dma_rx_ch);
+
+      err_no_rxdma:
+      err_no_txdma_descr:
+	if (usedma)
+		au1xxx_dbdma_chan_free(hw->dma_tx_ch);
+
+      err_no_txdma:
+      err_dma_add_dev:
+	release_mem_region((unsigned long)hw->regs, sizeof(psc_spi_t));
+
+      err_no_iores:
+      err_no_pdata:
+	spi_master_put(hw->master);
+
+      err_nomem:
+	return err;
+}
+
+static int au1550_spi_remove(struct platform_device *pdev)
+{
+	struct au1550_spi *hw = platform_get_drvdata(pdev);
+
+	dev_info(&pdev->dev, "spi master remove: bus_num=%d\n",
+		 hw->master->bus_num);
+
+	spi_bitbang_stop(&hw->bitbang);
+	free_irq(hw->irq, hw);
+	release_mem_region((unsigned long)hw->regs, sizeof(psc_spi_t));
+
+	if (usedma) {
+		au1550_spi_dma_rxtmp_free(hw);
+		au1xxx_dbdma_chan_free(hw->dma_rx_ch);
+		au1xxx_dbdma_chan_free(hw->dma_tx_ch);
+	}
+
+	platform_set_drvdata(pdev, NULL);
+
+	spi_master_put(hw->master);
+	return 0;
+}
+
+static struct platform_driver au1550_spi_drv = {
+	.probe = au1550_spi_probe,
+	.remove = au1550_spi_remove,
+	.driver = {
+		.name = "au1550-spi",
+		.owner = THIS_MODULE,
+	},
+};
+
+static int __init au1550_spi_init(void)
+{
+	return platform_driver_register(&au1550_spi_drv);
+}
+
+static void __exit au1550_spi_exit(void)
+{
+	platform_driver_unregister(&au1550_spi_drv);
+}
+
+module_init(au1550_spi_init);
+module_exit(au1550_spi_exit);
+
+MODULE_DESCRIPTION("Au1550 PSC SPI Driver");
+MODULE_AUTHOR("Jan Nikitenko <jan.nikitenko@gmail.com>");
+MODULE_LICENSE("GPL");
diff -urN linux-git.orig/drivers/spi/Kconfig linux-git/drivers/spi/Kconfig
--- linux-git.orig/drivers/spi/Kconfig	2007-03-02 08:59:28.000000000 +0100
+++ linux-git/drivers/spi/Kconfig	2007-04-27 19:18:34.000000000 +0200
@@ -58,6 +58,17 @@
 	  This selects a driver for the Atmel SPI Controller, present on
 	  many AT32 (AVR32) and AT91 (ARM) chips.
 
+config SPI_AU1550
+	tristate "Au1550/Au12x0 SPI Controller"
+	depends on SPI_MASTER && (SOC_AU1550 || SOC_AU1200) && EXPERIMENTAL
+	select SPI_BITBANG
+	help
+	  If you say yes to this option, support will be included for the
+	  Au1550 SPI controller (may also work with Au1200,Au1210,Au1250).
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called au1550_spi.
+
 config SPI_BITBANG
 	tristate "Bitbanging SPI master"
 	depends on SPI_MASTER && EXPERIMENTAL
diff -urN linux-git.orig/drivers/spi/Makefile linux-git/drivers/spi/Makefile
--- linux-git.orig/drivers/spi/Makefile	2007-03-02 08:59:28.000000000 +0100
+++ linux-git/drivers/spi/Makefile	2007-04-27 19:19:58.000000000 +0200
@@ -13,6 +13,7 @@
 # SPI master controller drivers (bus)
 obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
 obj-$(CONFIG_SPI_ATMEL)			+= atmel_spi.o
+obj-$(CONFIG_SPI_AU1550)		+= au1550_spi.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
 obj-$(CONFIG_SPI_IMX)			+= spi_imx.o
 obj-$(CONFIG_SPI_PXA2XX)		+= pxa2xx_spi.o
diff -urN linux-git.orig/include/asm-mips/mach-au1x00/au1550_spi.h linux-git/include/asm-mips/mach-au1x00/au1550_spi.h
--- linux-git.orig/include/asm-mips/mach-au1x00/au1550_spi.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-git/include/asm-mips/mach-au1x00/au1550_spi.h	2007-04-27 19:35:50.000000000 +0200
@@ -0,0 +1,16 @@
+/*
+ * au1550_spi.h - au1550 psc spi controller driver - platform data struct
+ */
+
+#ifndef _AU1550_SPI_H_
+#define _AU1550_SPI_H_
+
+struct au1550_spi_info {
+	s16 bus_num;		/* defines which PSC and IRQ to use */
+	u32 mainclk_hz;		/* main input clock frequency of PSC */
+	u16 num_chipselect;	/* number of chipselects supported */
+	void (*activate_cs)(struct au1550_spi_info *spi, int cs, int polarity);
+	void (*deactivate_cs)(struct au1550_spi_info *spi, int cs, int polarity);
+};
+
+#endif

--------------060606060301060801020402--
