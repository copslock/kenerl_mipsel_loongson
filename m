Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Jun 2006 08:08:12 +0100 (BST)
Received: from deliver-2.mx.triera.net ([213.161.0.32]:6055 "EHLO
	deliver-2.mx.triera.net") by ftp.linux-mips.org with ESMTP
	id S8133361AbWF1HH6 (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 28 Jun 2006 08:07:58 +0100
Received: from localhost (in-2.mx.triera.net [213.161.0.26])
	by deliver-2.mx.triera.net (Postfix) with ESMTP id 9165BD6
	for <linux-mips@linux-mips.org>; Wed, 28 Jun 2006 09:07:47 +0200 (CEST)
Received: from smtp.triera.net (smtp.triera.net [213.161.0.30])
	by in-2.mx.triera.net (Postfix) with SMTP id BB24C1BC07B
	for <linux-mips@linux-mips.org>; Wed, 28 Jun 2006 09:07:48 +0200 (CEST)
Received: from localhost (unknown [213.161.20.162])
	by smtp.triera.net (Postfix) with ESMTP id 1DEA11A18A7
	for <linux-mips@linux-mips.org>; Wed, 28 Jun 2006 09:07:49 +0200 (CEST)
Date:	Wed, 28 Jun 2006 09:07:50 +0200
From:	Domen Puncer <domen.puncer@ultra.si>
To:	linux-mips@linux-mips.org
Subject: [patch rfc] au1xxx spi ported to spi layer
Message-ID: <20060628070750.GE31105@domen.ultra.si>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11+cvs20060126
X-Virus-Scanned: Triera AV Service
Return-Path: <domen.puncer@ultra.si>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 11878
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: domen.puncer@ultra.si
Precedence: bulk
X-list: linux-mips

This is a port of Jordan Crouse's SPI patch to the SPI layer.
Board definitions are only for dbau1200, flash should work with
in-kernel driver. If someone wants the simple tmp121 driver,
i can send it.

Hopefully someone finds this useful.

Signed-off-by: Domen Puncer <domen.puncer@ultra.si>

diffstat -p1:
 arch/mips/au1000/pb1200/Makefile         |    3 
 arch/mips/au1000/pb1200/spi_reg_boards.c |   50 ++
 drivers/spi/Kconfig                      |    4 
 drivers/spi/Makefile                     |    1 
 drivers/spi/au1xxx_spi.c                 |  586 +++++++++++++++++++++++++++++++
 5 files changed, 644 insertions(+)

Index: linux-mailed/drivers/spi/au1xxx_spi.c
===================================================================
--- /dev/null
+++ linux-mailed/drivers/spi/au1xxx_spi.c
@@ -0,0 +1,586 @@
+/*
+ *  Driver for Alchemy Au1550 SPI on the PSC.
+ *
+ * Copyright 2004 Embedded Edge, LLC.
+ *	dan@embeddededge.com
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ *  THIS  SOFTWARE  IS PROVIDED   ``AS  IS'' AND   ANY  EXPRESS OR IMPLIED
+ *  WARRANTIES,   INCLUDING, BUT NOT  LIMITED  TO, THE IMPLIED WARRANTIES OF
+ *  MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.  IN
+ *  NO  EVENT  SHALL   THE AUTHOR  BE	LIABLE FOR ANY   DIRECT, INDIRECT,
+ *  INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ *  NOT LIMITED   TO, PROCUREMENT OF  SUBSTITUTE GOODS  OR SERVICES; LOSS OF
+ *  USE, DATA,  OR PROFITS; OR  BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
+ *  ANY THEORY OF LIABILITY, WHETHER IN  CONTRACT, STRICT LIABILITY, OR TORT
+ *  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ *  THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/types.h>
+#include <linux/init.h>
+#include <linux/fs.h>
+
+#include <linux/device.h>
+#include <linux/platform_device.h>
+#include <linux/spi/spi.h>
+
+#include <asm/uaccess.h>
+#include <asm/io.h>
+#include <asm/mach-au1x00/au1xxx.h>
+#include <asm/mach-au1x00/au1xxx_psc.h>
+
+
+/* This is just a simple programmed I/O SPI interface on the PSC of the 1550.
+ * We support open, close, write, and ioctl.  The SPI is a full duplex
+ * interface, you can't read without writing.  So, the write system call
+ * copies the bytes out to the SPI, and whatever is returned is placed
+ * in the same buffer.  Kinda weird, maybe we'll change it, but for now
+ * it works OK.
+ * I didn't implement any DMA yet, and it's a debate about the necessity.
+ * The SPI clocks are usually quite fast, so data is sent/received as
+ * quickly as you can stuff the FIFO.  The overhead of DMA and interrupts
+ * are usually far greater than the data transfer itself.  If, however,
+ * we find applications that move large amounts of data, we may choose
+ * use the overhead of buffering and DMA to do the work.
+ */
+
+/* The maximum clock rate specified in the manual is 2mHz.
+*/
+#define MAX_BAUD_RATE	(2 * 1000000)
+#define PSC_INTCLK_RATE (32 * 1000000)
+
+/* We have to know what the user requested for the data length
+ * so we know how to stuff the fifo.  The FIFO is 32 bits wide,
+ * and we have to load it with the bits to go in a single transfer.
+ */
+static	uint	spi_datalen;
+
+static int
+au1550spi_master_done( int ms )
+{
+	int timeout=ms;
+	volatile psc_spi_t *sp;
+
+	sp = (volatile psc_spi_t *)SPI_PSC_BASE;
+
+	/* Loop until MD is set or timeout has expired */
+	while(!(sp->psc_spievent & PSC_SPIEVNT_MD) &&  timeout--) udelay(1000);
+
+	if ( !timeout )
+		return 0;
+	else
+		sp->psc_spievent |= PSC_SPIEVNT_MD;
+
+	return 1;
+}
+
+/* Set the baud rate closest to the request, then return the actual
+ * value we are using.
+ */
+static uint
+set_baud_rate(uint baud)
+{
+	uint	rate, tmpclk, brg, ctl, stat;
+	volatile psc_spi_t *sp;
+
+	if (baud > MAX_BAUD_RATE)
+		baud = MAX_BAUD_RATE;
+
+	/* For starters, the input clock is divided by two.
+	*/
+	tmpclk = PSC_INTCLK_RATE/2;
+
+	rate = tmpclk / baud;
+
+	/* The dividers work as follows:
+	 *	baud = tmpclk / (2 * (brg + 1))
+	 */
+	 brg = (rate/2) - 1;
+
+	 /* Test BRG to ensure it will fit into the 6 bits allocated.
+	 */
+
+	 /* Make sure the device is disabled while we make the change.
+	 */
+	sp = (volatile psc_spi_t *)SPI_PSC_BASE;
+	ctl = sp->psc_spicfg;
+	au_sync();
+	sp->psc_spicfg = ctl & ~PSC_SPICFG_DE_ENABLE;
+	au_sync();
+	ctl = PSC_SPICFG_CLR_BAUD(ctl);
+	ctl |= PSC_SPICFG_SET_BAUD(brg);
+	sp->psc_spicfg = ctl;
+	au_sync();
+
+	/* If the device was running prior to getting here, wait for
+	 * it to restart.
+	 */
+	if (ctl & PSC_SPICFG_DE_ENABLE) {
+		do {
+			stat = sp->psc_spistat;
+			au_sync();
+		} while ((stat & PSC_SPISTAT_DR) == 0);
+	}
+
+	/* Return the actual value.
+	*/
+	rate = tmpclk / (2 * (brg + 1));
+
+	return(rate);
+}
+
+#if 0
+static uint
+set_word_len(uint len)
+{
+	uint	ctl, stat;
+	volatile psc_spi_t *sp;
+
+	if ((len < 4) || (len > 24))
+		return -EINVAL;
+
+	 /* Make sure the device is disabled while we make the change.
+	 */
+	sp = (volatile psc_spi_t *)SPI_PSC_BASE;
+	ctl = sp->psc_spicfg;
+	au_sync();
+	sp->psc_spicfg = ctl & ~PSC_SPICFG_DE_ENABLE;
+	au_sync();
+	ctl = PSC_SPICFG_CLR_LEN(ctl);
+	ctl |= PSC_SPICFG_SET_LEN(len);
+	sp->psc_spicfg = ctl;
+	au_sync();
+
+	/* If the device was running prior to getting here, wait for
+	 * it to restart.
+	 */
+	if (ctl & PSC_SPICFG_DE_ENABLE) {
+		do {
+			stat = sp->psc_spistat;
+			au_sync();
+		} while ((stat & PSC_SPISTAT_DR) == 0);
+	}
+
+	return 0;
+}
+#endif
+
+static uint
+set_clk_src(void)
+{
+	uint	clk, rate;
+
+/* Wire up Freq3 as a clock for the SPI.  The PSC does
+	 * factor of 2 divisor, so run a higher rate so we can
+	 * get some granularity to the clock speeds.
+	 * We can't do this in board set up because the frequency
+	 * is computed too late.
+	 */
+	rate = get_au1x00_speed();
+	rate /= PSC_INTCLK_RATE;
+
+
+
+	/* The FRDIV in the frequency control is (FRDIV + 1) * 2
+	*/
+	rate /=2;
+	rate--;
+	clk = au_readl(SYS_FREQCTRL1);
+
+	au_sync();
+	clk &= ~SYS_FC_FRDIV3_MASK;
+	clk |= (rate << SYS_FC_FRDIV3_BIT);
+	clk |= SYS_FC_FE3;
+	au_writel(clk, SYS_FREQCTRL1);
+	au_sync();
+
+	/* Set up the clock source routing to get Freq3 to PSC0_intclk.
+	*/
+	clk = au_readl(SYS_CLKSRC);
+   	au_sync();
+#if defined(CONFIG_SOC_AU1200)
+	clk &= ~SYS_CS_ME0_MASK;
+	clk |= (5 << 22);
+#elif defined (CONFIG_SOC_AU1550)
+    clk &= ~0x03e0;
+	clk |= (5 << 7);
+#endif
+  	au_writel(clk, SYS_CLKSRC);
+	au_sync();
+
+	/* Set up GPIO pin function to drive PSC0_SYNC1, which is
+	 * the SPI Select.
+	 */
+	clk = au_readl(SYS_PINFUNC);
+	au_sync();
+#if defined(CONFIG_SOC_AU1200)
+	clk |= (0x1 <<17);
+	clk &= ~SYS_PINFUNC_P0B;
+#elif defined (CONFIG_SOC_AU1550)
+     clk |= 1;
+#endif
+   	au_writel(clk, SYS_PINFUNC);
+	au_sync();
+
+  return 0;
+}
+
+/* TODO into header */
+
+/* 16-bit register */
+#define BRD_REG_CONTROL 0xb980000c
+
+#define SPI_DEV_SEL (1<<14)
+#define PSC0_MUX_SEL (1<<12)
+
+struct au1550spi {
+	volatile psc_spi_t *sp;
+	struct spi_master *master;
+
+	spinlock_t lock; /* protect hardware accesses */
+	struct list_head queue;
+};
+
+static struct au1550spi *au1550spi;
+
+static int au1550spi_txrx(struct spi_device *spi, struct spi_message *m)
+{
+	/* TODO cs_change handling? */
+	int	bytelen, i;
+	uint	fifoword, stat, pcr;
+
+	struct au1550spi *auspi;
+	volatile psc_spi_t *sp;
+
+	int retval = 0;
+
+	/* dealing with list of transfers */
+	struct list_head *head = &m->transfers;
+	struct list_head *l = head->next;
+	struct list_head *lr = l;
+	struct spi_transfer *t = list_entry(l, struct spi_transfer, transfer_list);
+	struct spi_transfer *tr = t;
+	int last_t = (l->next == head);
+	int last_tr = (lr->next == head);
+
+	const unsigned char *wp = t->tx_buf;
+	unsigned char *rp = t->rx_buf;
+	size_t count, rcount;
+
+	count = rcount = t->len;
+	m->actual_length += t->len;
+
+	auspi = spi_master_get_devdata(spi->master);
+
+	/* Get the number of bytes per transfer.
+	*/
+	bytelen = ((spi_datalen - 1) / 8) + 1;
+
+	/* User needs to send us multiple of this count.
+	*/
+	if ((count % bytelen) != 0)
+		return -EINVAL;
+
+	spin_lock(&auspi->lock);
+	sp = auspi->sp;
+	sp->psc_spipcr = (PSC_SPIPCR_RC | PSC_SPIPCR_TC);
+	au_sync();
+	do {
+		pcr = sp->psc_spipcr;
+		au_sync();
+	} while (pcr != 0);
+	do {
+		stat = sp->psc_spistat;
+		au_sync();
+	} while ((stat & (PSC_SPISTAT_RE | PSC_SPISTAT_TE)) !=
+			(PSC_SPISTAT_RE | PSC_SPISTAT_TE));
+
+	udelay(1); /* why oh why? */
+//	au_sync(); au_sync(); au_sync(); /* WTF? some timing bug? */
+
+	/* Prime the transmit FIFO.
+	*/
+	/* XXX so... I just ignore wp or rp when they are NULL.
+	 * can whole loops be if'ed out or do fifos need to be fed? */
+	while (count > 0) {
+		fifoword = 0;
+		for (i=0; i<bytelen && wp; i++) {
+			fifoword <<= 8;
+			fifoword |= *wp;
+			wp++;
+		}
+		count -= bytelen;
+		if (count <= 0 && last_t)
+			fifoword |= PSC_SPITXRX_LC;
+		sp->psc_spitxrx = fifoword;
+		au_sync();
+		stat = sp->psc_spistat;
+		au_sync();
+		if (stat & PSC_SPISTAT_TF)
+			break;
+	}
+
+	/* Start the transfer.
+	*/
+	sp->psc_spipcr = PSC_SPIPCR_MS;
+	au_sync();
+
+	/* Now, just keep the transmit fifo full and empty the receive.
+	*/
+	while (rcount > 0 || count > 0 || !last_t || !last_tr) {
+		/* next tx buffer */
+		if (count == 0 && !last_t) {
+			l = l->next;
+			t = list_entry(l, struct spi_transfer, transfer_list);
+			wp = t->tx_buf;
+			count = t->len;
+
+			last_t = (l->next == head);
+		}
+		/* next rx buffer */
+		if (rcount == 0 && !last_tr) {
+			lr = lr->next;
+			tr = list_entry(lr, struct spi_transfer, transfer_list);
+			m->actual_length += tr->len;
+			rp = tr->rx_buf;
+			rcount = tr->len;
+
+			last_tr = (lr->next == head);
+		}
+
+		stat = sp->psc_spistat;
+		au_sync();
+		while (rcount && (stat & PSC_SPISTAT_RE) == 0) {
+			fifoword = sp->psc_spitxrx;
+			au_sync();
+			for (i=0; i<bytelen && rp; i++) {
+				*rp = fifoword & 0xff;
+				fifoword >>= 8;
+				rp++;
+			}
+			rcount -= bytelen;
+			stat = sp->psc_spistat;
+			au_sync();
+		}
+		if (count && (stat & PSC_SPISTAT_TF) == 0) {
+			fifoword = 0;
+			for (i=0; i<bytelen && wp; i++) {
+				fifoword <<= 8;
+				fifoword |= *wp;
+				wp++;
+			}
+			count -= bytelen;
+			if (count <= 0 && last_t)
+				fifoword |= PSC_SPITXRX_LC;
+			sp->psc_spitxrx = fifoword;
+			au_sync();
+		}
+	}
+
+	/* Wait for MasterDone event. 30ms timeout */
+	if (!au1550spi_master_done(30) ) retval = -EFAULT;
+	spin_unlock(&auspi->lock);
+
+	return retval;
+}
+
+int au1550spi_setup_transfer(struct spi_device *spi)
+{
+	struct au1550spi *auspi;
+	volatile psc_spi_t *sp;
+	unsigned int tmp, ctl;
+
+	auspi = spi_master_get_devdata(spi->master);
+	sp = auspi->sp;
+
+	spin_lock(&auspi->lock);
+
+	spi_datalen = spi->bits_per_word;
+	set_baud_rate(spi->max_speed_hz);
+
+	/* chip select */
+	au_sync();
+	tmp = au_readw(BRD_REG_CONTROL);
+	au_sync();
+	if (spi->chip_select == 0)
+		au_writew(tmp & ~SPI_DEV_SEL, BRD_REG_CONTROL); /* temperature */
+	else
+		au_writew(tmp | SPI_DEV_SEL, BRD_REG_CONTROL); /* flash */
+	au_sync();
+
+	/* disable device */
+	ctl = sp->psc_spicfg;
+	au_sync();
+	sp->psc_spicfg = ctl & ~PSC_SPICFG_DE_ENABLE;
+	au_sync();
+
+	/* set clock polarity and phase */
+	ctl &= ~(PSC_SPICFG_BI | PSC_SPICFG_CDE | PSC_SPICFG_MLF);
+	if (spi->mode & SPI_CPOL)
+		ctl |= PSC_SPICFG_BI;
+	if ((spi->mode & SPI_CPHA) == 0)
+		ctl |= PSC_SPICFG_CDE;
+	if (spi->mode & SPI_LSB_FIRST)
+		ctl |= PSC_SPICFG_MLF;
+
+	/* back to enabled state */
+	sp->psc_spicfg = ctl;
+	au_sync();
+
+	spin_unlock(&auspi->lock);
+	return 0;
+}
+
+int au1550spi_setup(struct spi_device *spi)
+{
+	if (!spi->max_speed_hz)
+		return -EINVAL;
+
+	if (!spi->bits_per_word)
+		spi->bits_per_word = 8;
+
+	return au1550spi_setup_transfer(spi);
+}
+
+void au1550spi_cleanup(const struct spi_device *spi)
+{
+	/* cleanup any per device structures you might have allocated */
+}
+
+/* no sleeping here */
+int au1550spi_transfer(struct spi_device *spi, struct spi_message *m)
+{
+	m->actual_length = 0;
+	m->status = -EINPROGRESS;
+
+	au1550spi_setup_transfer(spi);
+
+	m->status = au1550spi_txrx(spi, m);
+	/* signal to spi layer that we are done */
+	m->complete(m->context);
+	return 0;
+}
+
+
+int __init au1550spi_init(void)
+{
+	struct spi_master *master;
+	struct platform_device *pdev;
+	struct au1550spi *auspi;
+	int err = 0;
+	int tmp;
+
+	uint  stat;
+	volatile psc_spi_t *sp;
+
+	/* setup for spi bus framework */
+	pdev = platform_device_register_simple("au1550spi", -1, NULL, 0);
+
+	master = spi_alloc_master(&pdev->dev, sizeof(*auspi));
+	if (!master) {
+		err = -ENOMEM;
+		goto platform_unreg;
+	}
+	au1550spi = auspi = spi_master_get_devdata(master);
+
+	master->bus_num = 1;
+	master->num_chipselect = 2;
+
+	auspi->sp = (volatile psc_spi_t *)SPI_PSC_BASE;
+
+	spin_lock_init(&auspi->lock);
+
+	master->setup = au1550spi_setup;
+	master->cleanup = au1550spi_cleanup;
+	master->transfer = au1550spi_transfer;
+	auspi->master = spi_master_get(master);
+
+	/* setup hardware */
+
+	/* setup PSC0 as SPI */
+	au_sync();
+	tmp = au_readw(BRD_REG_CONTROL);
+	au_sync();
+	au_writew(tmp | PSC0_MUX_SEL, BRD_REG_CONTROL);
+	au_sync();
+
+	 /* Set clock Source*/
+	 set_clk_src();
+
+	/* Now, set up the PSC for SPI PIO mode.
+	*/
+	sp = auspi->sp;
+	sp->psc_ctrl = PSC_CTRL_DISABLE;
+	au_sync();
+	sp->psc_sel = PSC_SEL_PS_SPIMODE;
+   	sp->psc_spicfg = 0;
+	au_sync();
+	sp->psc_ctrl = PSC_CTRL_ENABLE;
+	au_sync();
+
+	do {
+		stat = sp->psc_spistat;
+		au_sync();
+	} while ((stat & PSC_SPISTAT_SR) == 0);
+
+
+	sp->psc_spicfg = (PSC_SPICFG_RT_FIFO8 | PSC_SPICFG_TT_FIFO8 |
+				PSC_SPICFG_DD_DISABLE | PSC_SPICFG_MO);
+	sp->psc_spicfg |= PSC_SPICFG_SET_LEN(8);
+	spi_datalen = 8;
+	sp->psc_spimsk = PSC_SPIMSK_ALLMASK;
+	au_sync();
+
+	set_baud_rate(1000000);
+
+	sp->psc_spicfg |= PSC_SPICFG_DE_ENABLE;
+
+	 do {
+		stat = sp->psc_spistat;
+		au_sync();
+	} while ((stat & PSC_SPISTAT_DR) == 0);
+
+
+
+	spi_register_master(master);
+
+	goto done;
+
+ platform_unreg:
+	platform_device_unregister(pdev);
+ done:
+	return err;
+}
+
+void __exit
+au1550spi_exit(void)
+{
+	struct spi_master *master;
+	struct platform_device *pdev;
+
+	master = au1550spi->master;
+
+	pdev = to_platform_device(master->cdev.dev);
+
+	platform_device_unregister(pdev);
+	spi_unregister_master(master);
+	spi_master_put(master);
+}
+
+module_init(au1550spi_init);
+module_exit(au1550spi_exit);
+
+MODULE_LICENSE("GPL");
Index: linux-mailed/arch/mips/au1000/pb1200/Makefile
===================================================================
--- linux-mailed.orig/arch/mips/au1000/pb1200/Makefile
+++ linux-mailed/arch/mips/au1000/pb1200/Makefile
@@ -3,3 +3,6 @@
 #
 
 lib-y := init.o board_setup.o irqmap.o
+ifneq ($(CONFIG_SPI_AU1XXX),)
+obj-y += spi_reg_boards.o
+endif
Index: linux-mailed/drivers/spi/Kconfig
===================================================================
--- linux-mailed.orig/drivers/spi/Kconfig
+++ linux-mailed/drivers/spi/Kconfig
@@ -51,6 +51,10 @@ config SPI_MASTER
 comment "SPI Master Controller Drivers"
 	depends on SPI_MASTER
 
+config SPI_AU1XXX
+	tristate "Alchemy Au1550/Au1200 PSC SPI support"
+	depends on MIPS && SOC_AU1X00 && !I2C_AU1550
+
 config SPI_BITBANG
 	tristate "Bitbanging SPI master"
 	depends on SPI_MASTER && EXPERIMENTAL
Index: linux-mailed/drivers/spi/Makefile
===================================================================
--- linux-mailed.orig/drivers/spi/Makefile
+++ linux-mailed/drivers/spi/Makefile
@@ -11,6 +11,7 @@ endif
 obj-$(CONFIG_SPI_MASTER)		+= spi.o
 
 # SPI master controller drivers (bus)
+obj-$(CONFIG_SPI_AU1XXX)		+= au1xxx_spi.o
 obj-$(CONFIG_SPI_BITBANG)		+= spi_bitbang.o
 obj-$(CONFIG_SPI_BUTTERFLY)		+= spi_butterfly.o
 obj-$(CONFIG_SPI_PXA2XX)		+= pxa2xx_spi.o
Index: linux-mailed/arch/mips/au1000/pb1200/spi_reg_boards.c
===================================================================
--- /dev/null
+++ linux-mailed/arch/mips/au1000/pb1200/spi_reg_boards.c
@@ -0,0 +1,50 @@
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/device.h>
+#include <linux/spi/spi.h>
+#include <linux/spi/flash.h>
+#include <linux/mtd/partitions.h>
+#include <mtd/mtd-abi.h>
+
+
+static struct mtd_partition au1200_flash_partition = {
+	.name		= "spi flash",
+	.size		= MTDPART_SIZ_FULL,
+	.offset		= MTDPART_OFS_APPEND,
+	.mask_flags	= MTD_WRITEABLE,
+};
+
+static struct flash_platform_data au1200_flash = {
+	.name		= "s25fl001d0fma",
+	.parts		= &au1200_flash_partition,
+	.nr_parts	= 1,
+	.type		= "m25p10",
+};
+
+
+static struct spi_board_info au1200_spi[2] = {
+{
+	.modalias	= "tmp121",
+	.irq		= -1,
+	.max_speed_hz	= 10*1000000,
+	.bus_num	= 1,
+	.chip_select	= 0,
+}, {
+	.modalias	= "m25p80",
+	.platform_data	= &au1200_flash,
+	.irq		= -1,
+	.max_speed_hz	= 25*1000000,
+	.bus_num	= 1,
+	.chip_select	= 1,
+},
+};
+
+static int __init spi_reg_boards_init(void)
+{
+	int ret;
+	ret = spi_register_board_info(au1200_spi, ARRAY_SIZE(au1200_spi));
+	return ret;
+}
+
+subsys_initcall(spi_reg_boards_init);
