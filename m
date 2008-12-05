Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Dec 2008 23:10:45 +0000 (GMT)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:34974 "EHLO
	mail3.caviumnetworks.com") by ftp.linux-mips.org with ESMTP
	id S24153014AbYLEXKP (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 5 Dec 2008 23:10:15 +0000
Received: from exch4.caveonetworks.com (Not Verified[192.168.16.23]) by mail3.caviumnetworks.com with MailMarshal (v6,2,2,3503)
	id <B4939b4a70000>; Fri, 05 Dec 2008 18:09:30 -0500
Received: from exch4.caveonetworks.com ([192.168.16.23]) by exch4.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 5 Dec 2008 15:09:25 -0800
Received: from dd1.caveonetworks.com ([64.169.86.201]) by exch4.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 5 Dec 2008 15:09:25 -0800
Received: from dd1.caveonetworks.com (localhost.localdomain [127.0.0.1])
	by dd1.caveonetworks.com (8.14.2/8.14.2) with ESMTP id mB5N9NNV016270;
	Fri, 5 Dec 2008 15:09:23 -0800
Received: (from ddaney@localhost)
	by dd1.caveonetworks.com (8.14.2/8.14.2/Submit) id mB5N9NOn016269;
	Fri, 5 Dec 2008 15:09:23 -0800
From:	David Daney <ddaney@caviumnetworks.com>
To:	linux-ide@vger.kernel.org
Cc:	linux-mips@linux-mips.org, David Daney <ddaney@caviumnetworks.com>
Subject: [PATCH 2/2] libata: New driver for OCTEON SOC Compact Flash interface (v3).
Date:	Fri,  5 Dec 2008 15:09:21 -0800
Message-Id: <1228518561-16242-2-git-send-email-ddaney@caviumnetworks.com>
X-Mailer: git-send-email 1.5.6.5
In-Reply-To: <4939B402.9010004@caviumnetworks.com>
References: <4939B402.9010004@caviumnetworks.com>
X-OriginalArrivalTime: 05 Dec 2008 23:09:25.0798 (UTC) FILETIME=[84634460:01C9572E]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21539
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

As part of our efforts to get the Cavium OCTEON processor support
merged (see: http://marc.info/?l=linux-mips&m=122834773330212), we
have this CF driver for your consideration.

Most OCTEON variants have *no* DMA or interrupt support on the CF
interface so for these, only PIO is supported.  Although if DMA is
available, we do take advantage of it.

The register definitions are part of the chip support patch set
mentioned above, and are not included here.

In this third version, At the suggestion of Jeff Garzik, I ditched the
attempt to emulate sff bmdma.  For DMA transfers, we just hook the
.qc_issue port op and handle everything ourselves.

Also gone is the mwdmamodes module parameter that as was pointed out
is redundant.

Thanks,

Signed-off-by: David Daney <ddaney@caviumnetworks.com>
---
 drivers/ata/Kconfig          |    9 +
 drivers/ata/Makefile         |    1 +
 drivers/ata/pata_octeon_cf.c |  956 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 966 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ata/pata_octeon_cf.c

diff --git a/drivers/ata/Kconfig b/drivers/ata/Kconfig
index 78fbec8..b59904b 100644
--- a/drivers/ata/Kconfig
+++ b/drivers/ata/Kconfig
@@ -697,6 +697,15 @@ config PATA_IXP4XX_CF
 
 	  If unsure, say N.
 
+config PATA_OCTEON_CF
+	tristate "OCTEON Boot Bus Compact Flash support"
+	depends on CPU_CAVIUM_OCTEON
+	help
+	  This option enables a polled compact flash driver for use with
+	  compact flash cards attached to the OCTEON boot bus.
+
+	  If unsure, say N.
+
 config PATA_SCC
 	tristate "Toshiba's Cell Reference Set IDE support"
 	depends on PCI && PPC_CELLEB
diff --git a/drivers/ata/Makefile b/drivers/ata/Makefile
index 674965f..7f1ecf9 100644
--- a/drivers/ata/Makefile
+++ b/drivers/ata/Makefile
@@ -69,6 +69,7 @@ obj-$(CONFIG_PATA_IXP4XX_CF)	+= pata_ixp4xx_cf.o
 obj-$(CONFIG_PATA_SCC)		+= pata_scc.o
 obj-$(CONFIG_PATA_SCH)		+= pata_sch.o
 obj-$(CONFIG_PATA_BF54X)	+= pata_bf54x.o
+obj-$(CONFIG_PATA_OCTEON_CF)	+= pata_octeon_cf.o
 obj-$(CONFIG_PATA_PLATFORM)	+= pata_platform.o
 obj-$(CONFIG_PATA_OF_PLATFORM)	+= pata_of_platform.o
 obj-$(CONFIG_PATA_ICSIDE)	+= pata_icside.o
diff --git a/drivers/ata/pata_octeon_cf.c b/drivers/ata/pata_octeon_cf.c
new file mode 100644
index 0000000..3b565a5
--- /dev/null
+++ b/drivers/ata/pata_octeon_cf.c
@@ -0,0 +1,956 @@
+/*
+ * Driver for the Octeon bootbus compact flash.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2005-2008 Cavium Networks
+ * Copyright (C) 2008 Wind River Systems
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/libata.h>
+#include <linux/irq.h>
+#include <linux/platform_device.h>
+#include <scsi/scsi_host.h>
+
+#include <asm/octeon/octeon.h>
+
+/*
+ * The Octeon bootbus compact flash interface is connected in at least
+ * 3 different configurations on various evaluation boards:
+ *
+ * -- 8  bits no irq, no DMA
+ * -- 16 bits no irq, no DMA
+ * -- 16 bits True IDE mode with DMA, but no irq.
+ *
+ * In the last case the DMA engine can generate an interrupt when the
+ * transfer is complete.  For the first two cases only PIO is supported.
+ *
+ */
+
+#define DRV_NAME	"pata_octeon_cf"
+#define DRV_VERSION	"2.1"
+
+
+struct octeon_cf_port {
+	struct tasklet_struct delayed_finish_tasklet;
+	int dma_finished;
+};
+
+static struct scsi_host_template octeon_cf_sht = {
+	ATA_PIO_SHT(DRV_NAME),
+};
+
+/**
+ * Convert nanosecond based time to setting used in the
+ * boot bus timing register, based on timing multiple
+ */
+static unsigned int ns_to_tim_reg(unsigned int tim_mult, unsigned int nsecs)
+{
+	unsigned int val;
+
+	/*
+	 * Compute # of eclock periods to get desired duration in
+	 * nanoseconds.
+	 */
+	val = DIV_ROUND_UP(nsecs * (octeon_get_clock_rate() / 1000000),
+			  1000 * tim_mult);
+
+	return val;
+}
+
+static void octeon_cf_set_boot_reg_cfg(int cs)
+{
+	union cvmx_mio_boot_reg_cfgx reg_cfg;
+	reg_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_CFGX(cs));
+	reg_cfg.s.dmack = 0;	/* Don't assert DMACK on access */
+	reg_cfg.s.tim_mult = 2;	/* Timing mutiplier 2x */
+	reg_cfg.s.rd_dly = 0;	/* Sample on falling edge of BOOT_OE */
+	reg_cfg.s.sam = 0;	/* Don't combine write and output enable */
+	reg_cfg.s.we_ext = 0;	/* No write enable extension */
+	reg_cfg.s.oe_ext = 0;	/* No read enable extension */
+	reg_cfg.s.en = 1;	/* Enable this region */
+	reg_cfg.s.orbit = 0;	/* Don't combine with previos region */
+	reg_cfg.s.ale = 0;	/* Don't do address multiplexing */
+	cvmx_write_csr(CVMX_MIO_BOOT_REG_CFGX(cs), reg_cfg.u64);
+}
+
+/**
+ * Called after libata determines the needed PIO mode. This
+ * function programs the Octeon bootbus regions to support the
+ * timing requirements of the PIO mode.
+ *
+ * @ap:     ATA port information
+ * @dev:    ATA device
+ */
+static void octeon_cf_set_piomode(struct ata_port *ap, struct ata_device *dev)
+{
+	struct octeon_cf_data *ocd = ap->dev->platform_data;
+	union cvmx_mio_boot_reg_timx reg_tim;
+	unsigned int cs = ocd->base_region;
+	int T;
+	struct ata_timing timing;
+
+	int use_iordy;
+	/* These names are timing parameters from the ATA spec */
+	int t1;
+	int t2;
+	int t2i;
+	int t4;
+	int t6;
+	int t6z;
+
+	T = (int)(2000000000000LL / octeon_get_clock_rate());
+
+	if (ata_timing_compute(dev, dev->pio_mode, &timing, T, T))
+		BUG();
+
+	t1 = timing.setup;
+	if (t1)
+		t1--;
+	t2 = timing.active;
+	if (t2)
+		t2--;
+	t2i = timing.act8b;
+	if (t2i)
+		t2i--;
+	t4 = timing.write_hold;
+	if (t4)
+		t4--;
+	t6 = ns_to_tim_reg(2, 5);
+	if (t6)
+		t6--;
+	t6z = timing.read_holdz;
+	if (t6z)
+		t6z--;
+
+	octeon_cf_set_boot_reg_cfg(cs);
+	if (ocd->dma_engine >= 0)
+		/* True IDE mode, program both chip selects.  */
+		octeon_cf_set_boot_reg_cfg(cs + 1);
+
+
+	use_iordy = ata_pio_need_iordy(dev);
+	/* CF spec. r4.1 Table 22 says no iordy on PIO5 and PIO6.  */
+	if (dev->pio_mode == XFER_PIO_5 || dev->pio_mode == XFER_PIO_6)
+		use_iordy = 0;
+
+	reg_tim.u64 = cvmx_read_csr(CVMX_MIO_BOOT_REG_TIMX(cs));
+	/* Disable page mode */
+	reg_tim.s.pagem = 0;
+	/* Enable dynamic timing */
+	reg_tim.s.waitm = use_iordy;
+	/* Pages are disabled */
+	reg_tim.s.pages = 0;
+	/* We don't use multiplexed address mode */
+	reg_tim.s.ale = 0;
+	/* Not used */
+	reg_tim.s.page = 0;
+	/* Time after IORDY to coninue to assert the data */
+	reg_tim.s.wait = 0;
+	/* Time after CE that signals stay valid */
+	reg_tim.s.pause = t6z - t6;
+	/* How long to hold after a write */
+	reg_tim.s.wr_hld = t4;
+	/* How long to wait after a read to de-assert CE. */
+	reg_tim.s.rd_hld = t6;
+	/* How long write enable is asserted */
+	reg_tim.s.we = t2;
+	/* How long read enable is asserted */
+	reg_tim.s.oe = t2;
+	/* Time after CE that read/write starts */
+	reg_tim.s.ce = 0;
+	/* Time before CE that address is valid */
+	reg_tim.s.adr = 0;
+
+	/* Program the bootbus region timing for the data port chip select. */
+	cvmx_write_csr(CVMX_MIO_BOOT_REG_TIMX(cs), reg_tim.u64);
+	if (ocd->dma_engine >= 0)
+		/* True IDE mode, program both chip selects.  */
+		cvmx_write_csr(CVMX_MIO_BOOT_REG_TIMX(cs + 1), reg_tim.u64);
+}
+
+static void octeon_cf_set_dmamode(struct ata_port *ap, struct ata_device *dev)
+{
+	struct octeon_cf_data *ocd = dev->link->ap->dev->platform_data;
+	union cvmx_mio_boot_dma_timx dma_tim;
+	unsigned int oe_a;
+	unsigned int oe_n;
+	unsigned int dma_acks;
+	unsigned int dma_ackh;
+	unsigned int dma_arq;
+	unsigned int pause;
+	unsigned int To, Tkr, Td;
+	unsigned int tim_mult;
+
+	const struct ata_timing *timing;
+
+	timing = ata_timing_find_mode(dev->dma_mode);
+	To		= timing->cycle;
+	Td		= timing->active;
+	Tkr		= timing->recover;
+
+	if (dev->dma_mode == XFER_MW_DMA_0) {
+		Tkr = 50; /* for MWDMA0, it differes from the table. */
+		dma_ackh = 20;
+	} else {
+		dma_ackh = 5;
+	}
+
+	dma_tim.u64 = 0;
+	/* dma_tim.s.tim_mult = 0 --> 4x */
+	tim_mult = 4;
+
+	dma_acks = 0;	/*Ti */
+
+	/* not spec'ed, value in eclocks, not affected by tim_mult */
+	dma_arq = 8;
+	pause = 25 - dma_arq * 1000 /
+		(octeon_get_clock_rate() / 1000000); /* Tz */
+
+	/* Td (Seem to need more margin here.... */
+	oe_a = Td + 20;
+	/* Tkr from cf spec, lengthened to meet To */
+	oe_n = max(To - oe_a, Tkr);
+
+	dma_tim.s.dmack_pi = 1;
+
+	dma_tim.s.oe_n = ns_to_tim_reg(tim_mult, oe_n);
+	dma_tim.s.oe_a = ns_to_tim_reg(tim_mult, oe_a);
+
+	dma_tim.s.dmack_s = ns_to_tim_reg(tim_mult, dma_acks);
+	dma_tim.s.dmack_h = ns_to_tim_reg(tim_mult, dma_ackh);
+
+	dma_tim.s.dmarq = dma_arq;
+	dma_tim.s.pause = ns_to_tim_reg(tim_mult, pause);
+
+	dma_tim.s.rd_dly = 0;	/* Sample right on edge */
+
+	/*  writes only */
+	dma_tim.s.we_n = ns_to_tim_reg(tim_mult, oe_n);
+	dma_tim.s.we_a = ns_to_tim_reg(tim_mult, oe_a);
+
+#if 0
+	pr_info("ns to ticks (mult %d) of %d is: %d\n", tim_mult, 60,
+		     ns_to_tim_reg(tim_mult, 60));
+	pr_info("oe_n: %d, oe_a: %d, dmack_s: %d, dmack_h: "
+		"%d, dmarq: %d, pause: %d\n",
+		dma_tim.s.oe_n, dma_tim.s.oe_a, dma_tim.s.dmack_s,
+		dma_tim.s.dmack_h, dma_tim.s.dmarq, dma_tim.s.pause);
+#endif
+	cvmx_write_csr(CVMX_MIO_BOOT_DMA_TIMX(ocd->dma_engine),
+		       dma_tim.u64);
+
+}
+
+/**
+ * Handle an 8 bit I/O request.
+ *
+ * @dev:        Device to access
+ * @buffer:     Data buffer
+ * @buflen:     Length of the buffer.
+ * @rw:         True to write.
+ */
+static unsigned int octeon_cf_data_xfer8(struct ata_device *dev,
+					 unsigned char *buffer,
+					 unsigned int buflen,
+					 int rw)
+{
+	struct ata_port *ap		= dev->link->ap;
+	void __iomem *data_addr		= ap->ioaddr.data_addr;
+	unsigned int words;
+	unsigned int count;
+
+	words = buflen;
+	if (rw) {
+		count = 16;
+		while (words--) {
+			iowrite8(*buffer, data_addr);
+			buffer++;
+			/*
+			 * Every 16 writes do a read so the bootbus
+			 * FIFO doesn't fill up.
+			 */
+			if (--count == 0) {
+				ioread8(ap->ioaddr.altstatus_addr);
+				count = 16;
+			}
+		}
+	} else {
+		ioread8_rep(data_addr, buffer, words);
+	}
+	return buflen;
+}
+
+/**
+ * Handle a 16 bit I/O request.
+ *
+ * @dev:        Device to access
+ * @buffer:     Data buffer
+ * @buflen:     Length of the buffer.
+ * @rw:         True to write.
+ */
+static unsigned int octeon_cf_data_xfer16(struct ata_device *dev,
+					  unsigned char *buffer,
+					  unsigned int buflen,
+					  int rw)
+{
+	struct ata_port *ap		= dev->link->ap;
+	void __iomem *data_addr		= ap->ioaddr.data_addr;
+	unsigned int words;
+	unsigned int count;
+
+	words = buflen / 2;
+	if (rw) {
+		count = 16;
+		while (words--) {
+			iowrite16(*(uint16_t *)buffer, data_addr);
+			buffer += sizeof(uint16_t);
+			/*
+			 * Every 16 writes do a read so the bootbus
+			 * FIFO doesn't fill up.
+			 */
+			if (--count == 0) {
+				ioread8(ap->ioaddr.altstatus_addr);
+				count = 16;
+			}
+		}
+	} else {
+		while (words--) {
+			*(uint16_t *)buffer = ioread16(data_addr);
+			buffer += sizeof(uint16_t);
+		}
+	}
+	/* Transfer trailing 1 byte, if any. */
+	if (unlikely(buflen & 0x01)) {
+		__le16 align_buf[1] = { 0 };
+
+		if (rw == READ) {
+			align_buf[0] = cpu_to_le16(ioread16(data_addr));
+			memcpy(buffer, align_buf, 1);
+		} else {
+			memcpy(align_buf, buffer, 1);
+			iowrite16(le16_to_cpu(align_buf[0]), data_addr);
+		}
+		words++;
+	}
+	return buflen;
+}
+
+/**
+ * Read the taskfile for 16bit non-True IDE only.
+ */
+static void octeon_cf_tf_read16(struct ata_port *ap, struct ata_taskfile *tf)
+{
+	u16 blob;
+	/* The base of the registers is at ioaddr.data_addr. */
+	void __iomem *base = ap->ioaddr.data_addr;
+
+	blob = __raw_readw(base + 0xc);
+	tf->feature = blob >> 8;
+
+	blob = __raw_readw(base + 2);
+	tf->nsect = blob & 0xff;
+	tf->lbal = blob >> 8;
+
+	blob = __raw_readw(base + 4);
+	tf->lbam = blob & 0xff;
+	tf->lbah = blob >> 8;
+
+	blob = __raw_readw(base + 6);
+	tf->device = blob & 0xff;
+	tf->command = blob >> 8;
+
+	if (tf->flags & ATA_TFLAG_LBA48) {
+		if (likely(ap->ioaddr.ctl_addr)) {
+			iowrite8(tf->ctl | ATA_HOB, ap->ioaddr.ctl_addr);
+
+			blob = __raw_readw(base + 0xc);
+			tf->hob_feature = blob >> 8;
+
+			blob = __raw_readw(base + 2);
+			tf->hob_nsect = blob & 0xff;
+			tf->hob_lbal = blob >> 8;
+
+			blob = __raw_readw(base + 4);
+			tf->hob_lbam = blob & 0xff;
+			tf->hob_lbah = blob >> 8;
+
+			iowrite8(tf->ctl, ap->ioaddr.ctl_addr);
+			ap->last_ctl = tf->ctl;
+		} else {
+			WARN_ON(1);
+		}
+	}
+}
+
+static u8 octeon_cf_check_status16(struct ata_port *ap)
+{
+	u16 blob;
+	void __iomem *base = ap->ioaddr.data_addr;
+
+	blob = __raw_readw(base + 6);
+	return blob >> 8;
+}
+
+static int octeon_cf_softreset16(struct ata_link *link, unsigned int *classes,
+				 unsigned long deadline)
+{
+	struct ata_port *ap = link->ap;
+	void __iomem *base = ap->ioaddr.data_addr;
+	int rc;
+	u8 err;
+
+	DPRINTK("about to softreset\n");
+	__raw_writew(ap->ctl, base + 0xe);
+	udelay(20);
+	__raw_writew(ap->ctl | ATA_SRST, base + 0xe);
+	udelay(20);
+	__raw_writew(ap->ctl, base + 0xe);
+
+	rc = ata_sff_wait_after_reset(link, 1, deadline);
+	if (rc) {
+		ata_link_printk(link, KERN_ERR, "SRST failed (errno=%d)\n", rc);
+		return rc;
+	}
+
+	/* determine by signature whether we have ATA or ATAPI devices */
+	classes[0] = ata_sff_dev_classify(&link->device[0], 1, &err);
+	DPRINTK("EXIT, classes[0]=%u [1]=%u\n", classes[0], classes[1]);
+	return 0;
+}
+
+/**
+ * Load the taskfile for 16bit non-True IDE only.  The device_addr is
+ * not loaded, we do this as part of octeon_cf_exec_command16.
+ */
+static void octeon_cf_tf_load16(struct ata_port *ap,
+				const struct ata_taskfile *tf)
+{
+	unsigned int is_addr = tf->flags & ATA_TFLAG_ISADDR;
+	/* The base of the registers is at ioaddr.data_addr. */
+	void __iomem *base = ap->ioaddr.data_addr;
+
+	if (tf->ctl != ap->last_ctl) {
+		iowrite8(tf->ctl, ap->ioaddr.ctl_addr);
+		ap->last_ctl = tf->ctl;
+		ata_wait_idle(ap);
+	}
+	if (is_addr && (tf->flags & ATA_TFLAG_LBA48)) {
+		__raw_writew(tf->hob_feature << 8, base + 0xc);
+		__raw_writew(tf->hob_nsect | tf->hob_lbal << 8, base + 2);
+		__raw_writew(tf->hob_lbam | tf->hob_lbah << 8, base + 4);
+		VPRINTK("hob: feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
+			tf->hob_feature,
+			tf->hob_nsect,
+			tf->hob_lbal,
+			tf->hob_lbam,
+			tf->hob_lbah);
+	}
+	if (is_addr) {
+		__raw_writew(tf->feature << 8, base + 0xc);
+		__raw_writew(tf->nsect | tf->lbal << 8, base + 2);
+		__raw_writew(tf->lbam | tf->lbah << 8, base + 4);
+		VPRINTK("feat 0x%X nsect 0x%X, lba 0x%X 0x%X 0x%X\n",
+			tf->feature,
+			tf->nsect,
+			tf->lbal,
+			tf->lbam,
+			tf->lbah);
+	}
+	ata_wait_idle(ap);
+}
+
+
+static void octeon_cf_dev_select(struct ata_port *ap, unsigned int device)
+{
+/*  There is only one device, do nothing. */
+	return;
+}
+
+/*
+ * Issue ATA command to host controller.  The device_addr is also sent
+ * as it must be written in a combined write with the command.
+ */
+static void octeon_cf_exec_command16(struct ata_port *ap,
+				const struct ata_taskfile *tf)
+{
+	/* The base of the registers is at ioaddr.data_addr. */
+	void __iomem *base = ap->ioaddr.data_addr;
+	u16 blob;
+
+	if (tf->flags & ATA_TFLAG_DEVICE) {
+		VPRINTK("device 0x%X\n", tf->device);
+		blob = tf->device;
+	} else {
+		blob = 0;
+	}
+
+	DPRINTK("ata%u: cmd 0x%X\n", ap->print_id, tf->command);
+	blob |= (tf->command << 8);
+	__raw_writew(blob, base + 6);
+
+
+	ata_wait_idle(ap);
+}
+
+static u8 octeon_cf_irq_on(struct ata_port *ap)
+{
+	return 0;
+}
+
+static void octeon_cf_irq_clear(struct ata_port *ap)
+{
+	return;
+}
+
+static void octeon_cf_dma_setup(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+	struct octeon_cf_port *cf_port;
+
+	cf_port = (struct octeon_cf_port *)ap->private_data;
+	DPRINTK("ENTER\n");
+	/* issue r/w command */
+	qc->cursg = qc->sg;
+	cf_port->dma_finished = 0;
+	ap->ops->sff_exec_command(ap, &qc->tf);
+	DPRINTK("EXIT\n");
+}
+
+/**
+ * Start a DMA transfer that was already setup
+ *
+ * @qc:     Information about the DMA
+ */
+static void octeon_cf_dma_start(struct ata_queued_cmd *qc)
+{
+	struct octeon_cf_data *ocd = qc->ap->dev->platform_data;
+	union cvmx_mio_boot_dma_cfgx mio_boot_dma_cfg;
+	union cvmx_mio_boot_dma_intx mio_boot_dma_int;
+	struct scatterlist *sg;
+
+	VPRINTK("%d scatterlists\n", qc->n_elem);
+
+	/* Get the scatter list entry we need to DMA into */
+	sg = qc->cursg;
+	BUG_ON(!sg);
+
+	/*
+	 * Clear the DMA complete status.
+	 */
+	mio_boot_dma_int.u64 = 0;
+	mio_boot_dma_int.s.done = 1;
+	cvmx_write_csr(CVMX_MIO_BOOT_DMA_INTX(ocd->dma_engine),
+		       mio_boot_dma_int.u64);
+
+	/* Enable the interrupt.  */
+	cvmx_write_csr(CVMX_MIO_BOOT_DMA_INT_ENX(ocd->dma_engine),
+		       mio_boot_dma_int.u64);
+
+	/* Set the direction of the DMA */
+	mio_boot_dma_cfg.u64 = 0;
+	mio_boot_dma_cfg.s.en = 1;
+	mio_boot_dma_cfg.s.rw = ((qc->tf.flags & ATA_TFLAG_WRITE) != 0);
+
+	/*
+	 * Don't stop the DMA if the device deasserts DMARQ. Many
+	 * compact flashes deassert DMARQ for a short time between
+	 * sectors. Instead of stopping and restarting the DMA, we'll
+	 * let the hardware do it. If the DMA is really stopped early
+	 * due to an error condition, a later timeout will force us to
+	 * stop.
+	 */
+	mio_boot_dma_cfg.s.clr = 0;
+
+	/* Size is specified in 16bit words and minus one notation */
+	mio_boot_dma_cfg.s.size = sg_dma_len(sg) / 2 - 1;
+
+	/* We need to swap the high and low bytes of every 16 bits */
+	mio_boot_dma_cfg.s.swap8 = 1;
+
+	mio_boot_dma_cfg.s.adr = sg_dma_address(sg);
+
+	VPRINTK("%s %d bytes address=%p\n",
+		(mio_boot_dma_cfg.s.rw) ? "write" : "read", sg->length,
+		(void *)(unsigned long)mio_boot_dma_cfg.s.adr);
+
+	cvmx_write_csr(CVMX_MIO_BOOT_DMA_CFGX(ocd->dma_engine),
+		       mio_boot_dma_cfg.u64);
+}
+
+/**
+ *
+ *	LOCKING:
+ *	spin_lock_irqsave(host lock)
+ *
+ */
+static unsigned int octeon_cf_dma_finished(struct ata_port *ap,
+					struct ata_queued_cmd *qc)
+{
+	struct ata_eh_info *ehi = &ap->link.eh_info;
+	struct octeon_cf_data *ocd = ap->dev->platform_data;
+	union cvmx_mio_boot_dma_cfgx dma_cfg;
+	union cvmx_mio_boot_dma_intx dma_int;
+	struct octeon_cf_port *cf_port;
+	u8 status, astatus;
+
+	VPRINTK("ata%u: protocol %d task_state %d\n",
+		ap->print_id, qc->tf.protocol, ap->hsm_task_state);
+
+
+	if (ap->hsm_task_state != HSM_ST_LAST)
+		return 0;
+
+	cf_port = (struct octeon_cf_port *)ap->private_data;
+
+	dma_cfg.u64 = cvmx_read_csr(CVMX_MIO_BOOT_DMA_CFGX(ocd->dma_engine));
+	if (dma_cfg.s.size != 0xfffff) {
+		/* Error, the transfer was not complete.  */
+		qc->err_mask |= AC_ERR_HOST_BUS;
+		ap->hsm_task_state = HSM_ST_ERR;
+	}
+
+	/* Stop and clear the dma engine.  */
+	dma_cfg.u64 = 0;
+	dma_cfg.s.size = -1;
+	cvmx_write_csr(CVMX_MIO_BOOT_DMA_CFGX(ocd->dma_engine), dma_cfg.u64);
+
+	/* Disable the interrupt.  */
+	dma_int.u64 = 0;
+	cvmx_write_csr(CVMX_MIO_BOOT_DMA_INT_ENX(ocd->dma_engine), dma_int.u64);
+
+	/* Clear the DMA complete status */
+	dma_int.s.done = 1;
+	cvmx_write_csr(CVMX_MIO_BOOT_DMA_INTX(ocd->dma_engine), dma_int.u64);
+
+	astatus = ioread8(ap->ioaddr.altstatus_addr);
+	status = ap->ops->sff_check_status(ap);
+
+	ata_sff_hsm_move(ap, qc, status, 0);
+
+	if (unlikely(qc->err_mask) && (qc->tf.protocol == ATA_PROT_DMA))
+		ata_ehi_push_desc(ehi, "DMA stat 0x%x", status);
+
+	return 1;
+}
+
+/*
+ * Check if any queued commands have more DMAs, if so start the next
+ * transfer, else do end of transfer handling.
+ */
+static irqreturn_t octeon_cf_interrupt(int irq, void *dev_instance)
+{
+	struct ata_host *host = dev_instance;
+	struct octeon_cf_port *cf_port;
+	int i;
+	unsigned int handled = 0;
+	unsigned long flags;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	DPRINTK("ENTER\n");
+	for (i = 0; i < host->n_ports; i++) {
+		u8 status;
+		struct ata_port *ap;
+		struct ata_queued_cmd *qc;
+		union cvmx_mio_boot_dma_intx dma_int;
+		union cvmx_mio_boot_dma_cfgx dma_cfg;
+		struct octeon_cf_data *ocd;
+
+		ap = host->ports[i];
+		ocd = ap->dev->platform_data;
+		if (!ap || (ap->flags & ATA_FLAG_DISABLED))
+			continue;
+
+		ocd = ap->dev->platform_data;
+		cf_port = (struct octeon_cf_port *)ap->private_data;
+		dma_int.u64 =
+			cvmx_read_csr(CVMX_MIO_BOOT_DMA_INTX(ocd->dma_engine));
+		dma_cfg.u64 =
+			cvmx_read_csr(CVMX_MIO_BOOT_DMA_CFGX(ocd->dma_engine));
+
+		qc = ata_qc_from_tag(ap, ap->link.active_tag);
+
+		if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
+		    (qc->flags & ATA_QCFLAG_ACTIVE)) {
+			if (dma_int.s.done && !dma_cfg.s.en) {
+				if (!sg_is_last(qc->cursg)) {
+					qc->cursg = sg_next(qc->cursg);
+					handled = 1;
+					octeon_cf_dma_start(qc);
+					continue;
+				} else {
+					cf_port->dma_finished = 1;
+				}
+			}
+			if (!cf_port->dma_finished)
+				continue;
+			status = ioread8(ap->ioaddr.altstatus_addr);
+			if (status & (ATA_BUSY | ATA_DRQ)) {
+				/*
+				 * We are busy, try to handle it
+				 * later.  This is the DMA finished
+				 * interrupt, and it could take a
+				 * little while for the card to be
+				 * ready for more commands.
+				 */
+				/* Clear DMA irq. */
+				dma_int.u64 = 0;
+				dma_int.s.done = 1;
+				cvmx_write_csr(CVMX_MIO_BOOT_DMA_INTX(ocd->dma_engine),
+					       dma_int.u64);
+
+				tasklet_schedule(&cf_port->delayed_finish_tasklet);
+				handled = 1;
+			} else {
+				handled |= octeon_cf_dma_finished(ap, qc);
+			}
+		}
+	}
+	spin_unlock_irqrestore(&host->lock, flags);
+	DPRINTK("EXIT\n");
+	return IRQ_RETVAL(handled);
+}
+
+static void octeon_cf_delayed_finish(unsigned long data)
+{
+	struct ata_port *ap = (struct ata_port *)data;
+	struct octeon_cf_port *cf_port;
+	struct ata_host *host = ap->host;
+	struct ata_queued_cmd *qc;
+	unsigned long flags;
+	u8 status;
+
+	cf_port = (struct octeon_cf_port *)ap->private_data;
+
+	spin_lock_irqsave(&host->lock, flags);
+
+	/*
+	 * If the port is not waiting for completion, it must have
+	 * handled it previously.  The hsm_task_state is
+	 * protected by host->lock.
+	 */
+	if (ap->hsm_task_state != HSM_ST_LAST || !cf_port->dma_finished)
+		goto out;
+
+	status = ioread8(ap->ioaddr.altstatus_addr);
+	if (status & (ATA_BUSY | ATA_DRQ)) {
+		/* Still busy, try again. */
+		cf_port = (struct octeon_cf_port *)ap->private_data;
+		tasklet_schedule(&cf_port->delayed_finish_tasklet);
+		goto out;
+	}
+	qc = ata_qc_from_tag(ap, ap->link.active_tag);
+	if (qc && (!(qc->tf.flags & ATA_TFLAG_POLLING)) &&
+	    (qc->flags & ATA_QCFLAG_ACTIVE))
+		octeon_cf_dma_finished(ap, qc);
+out:
+	spin_unlock_irqrestore(&host->lock, flags);
+}
+
+static void octeon_cf_dev_config(struct ata_device *dev)
+{
+	/*
+	 * A maximum of 2^20 - 1 16 bit transfers are possible with
+	 * the bootbus DMA.  So we need to throttle max_sectors to
+	 * (2^12 - 1 == 4095) to assure that this can never happen.
+	 */
+	dev->max_sectors = min(dev->max_sectors, 4095U);
+}
+
+/*
+ * Trap if driver tries to do standard bmdma commands.  They are not
+ * supported.
+ */
+static void unreachable_qc(struct ata_queued_cmd *qc)
+{
+	BUG();
+}
+
+static u8 unreachable_port(struct ata_port *ap)
+{
+	BUG();
+}
+
+static unsigned int octeon_cf_qc_issue(struct ata_queued_cmd *qc)
+{
+	struct ata_port *ap = qc->ap;
+
+	switch (qc->tf.protocol) {
+	case ATA_PROT_DMA:
+		WARN_ON(qc->tf.flags & ATA_TFLAG_POLLING);
+
+		ap->ops->sff_tf_load(ap, &qc->tf);  /* load tf registers */
+		octeon_cf_dma_setup(qc);	    /* set up dma */
+		octeon_cf_dma_start(qc);	    /* initiate dma */
+		ap->hsm_task_state = HSM_ST_LAST;
+		break;
+
+	case ATAPI_PROT_DMA:
+		dev_err(ap->dev, "Error, ATAPI not supported\n");
+		BUG();
+
+	default:
+		return ata_sff_qc_issue(qc);
+	}
+
+	return 0;
+}
+
+static struct ata_port_operations octeon_cf_ops = {
+	.inherits	= &ata_sff_port_ops,
+	.qc_prep	= ata_noop_qc_prep,
+	.qc_issue	= octeon_cf_qc_issue,
+	.sff_dev_select	= octeon_cf_dev_select,
+	.sff_irq_on	= octeon_cf_irq_on,
+	.sff_irq_clear	= octeon_cf_irq_clear,
+	.bmdma_setup	= unreachable_qc,
+	.bmdma_start	= unreachable_qc,
+	.bmdma_stop	= unreachable_qc,
+	.bmdma_status	= unreachable_port,
+	.cable_detect	= ata_cable_40wire,
+	.set_piomode	= octeon_cf_set_piomode,
+	.set_dmamode	= octeon_cf_set_dmamode,
+	.dev_config	= octeon_cf_dev_config,
+};
+
+static int __devinit octeon_cf_probe(struct platform_device *pdev)
+{
+	struct resource *res_cs0, *res_cs1;
+
+	void __iomem *cs0;
+	void __iomem *cs1 = NULL;
+	struct ata_host *host;
+	struct ata_port *ap;
+	struct octeon_cf_data *ocd;
+	int irq = 0;
+	irq_handler_t irq_handler = NULL;
+	void __iomem *base;
+	struct octeon_cf_port *cf_port;
+
+	res_cs0 = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+
+	if (!res_cs0)
+		return -EINVAL;
+
+	ocd = pdev->dev.platform_data;
+
+	cs0 = devm_ioremap_nocache(&pdev->dev, res_cs0->start,
+				   res_cs0->end - res_cs0->start + 1);
+
+	if (!cs0)
+		return -ENOMEM;
+
+	/* Determine from availability of DMA if True IDE mode or not */
+	if (ocd->dma_engine >= 0) {
+		res_cs1 = platform_get_resource(pdev, IORESOURCE_MEM, 1);
+		if (!res_cs1)
+			return -EINVAL;
+
+		cs1 = devm_ioremap_nocache(&pdev->dev, res_cs1->start,
+					   res_cs0->end - res_cs1->start + 1);
+
+		if (!cs1)
+			return -ENOMEM;
+	}
+
+	cf_port = kzalloc(sizeof(*cf_port), GFP_KERNEL);
+	if (!cf_port)
+		return -ENOMEM;
+
+	/* allocate host */
+	host = ata_host_alloc(&pdev->dev, 1);
+	if (!host)
+		return -ENOMEM;
+
+	ap = host->ports[0];
+	ap->private_data = cf_port;
+	ap->ops = &octeon_cf_ops;
+	ap->pio_mask = 0x7f; /* Support PIO 0-6 */
+	ap->flags |= ATA_FLAG_MMIO | ATA_FLAG_NO_LEGACY
+		  | ATA_FLAG_NO_ATAPI | ATA_FLAG_PIO_POLLING;
+
+	tasklet_init(&cf_port->delayed_finish_tasklet,
+		     octeon_cf_delayed_finish,
+		     (unsigned long)ap);
+
+	base = cs0 + ocd->base_region_bias;
+	if (!ocd->is16bit) {
+		ap->ioaddr.cmd_addr	= base;
+		ata_sff_std_ports(&ap->ioaddr);
+
+		ap->ioaddr.altstatus_addr = base + 0xe;
+		ap->ioaddr.ctl_addr	= base + 0xe;
+		octeon_cf_ops.sff_data_xfer = octeon_cf_data_xfer8;
+	} else if (cs1) {
+		/* Presence of cs1 indicates True IDE mode.  */
+		ap->ioaddr.cmd_addr	= base + (ATA_REG_CMD << 1) + 1;
+		ap->ioaddr.data_addr	= base + (ATA_REG_DATA << 1);
+		ap->ioaddr.error_addr	= base + (ATA_REG_ERR << 1) + 1;
+		ap->ioaddr.feature_addr	= base + (ATA_REG_FEATURE << 1) + 1;
+		ap->ioaddr.nsect_addr	= base + (ATA_REG_NSECT << 1) + 1;
+		ap->ioaddr.lbal_addr	= base + (ATA_REG_LBAL << 1) + 1;
+		ap->ioaddr.lbam_addr	= base + (ATA_REG_LBAM << 1) + 1;
+		ap->ioaddr.lbah_addr	= base + (ATA_REG_LBAH << 1) + 1;
+		ap->ioaddr.device_addr	= base + (ATA_REG_DEVICE << 1) + 1;
+		ap->ioaddr.status_addr	= base + (ATA_REG_STATUS << 1) + 1;
+		ap->ioaddr.command_addr	= base + (ATA_REG_CMD << 1) + 1;
+		ap->ioaddr.altstatus_addr = cs1 + (6 << 1) + 1;
+		ap->ioaddr.ctl_addr	= cs1 + (6 << 1) + 1;
+		octeon_cf_ops.sff_data_xfer = octeon_cf_data_xfer16;
+
+		ap->mwdma_mask	= 0x1f; /* Support MWDMA 0-4 */
+		irq = platform_get_irq(pdev, 0);
+		irq_handler = octeon_cf_interrupt;
+	} else {
+		/* 16 bit but not True IDE */
+		octeon_cf_ops.sff_data_xfer	= octeon_cf_data_xfer16;
+		octeon_cf_ops.softreset		= octeon_cf_softreset16;
+		octeon_cf_ops.sff_check_status	= octeon_cf_check_status16;
+		octeon_cf_ops.sff_tf_read	= octeon_cf_tf_read16;
+		octeon_cf_ops.sff_tf_load	= octeon_cf_tf_load16;
+		octeon_cf_ops.sff_exec_command	= octeon_cf_exec_command16;
+
+		ap->ioaddr.data_addr	= base + ATA_REG_DATA;
+		ap->ioaddr.nsect_addr	= base + ATA_REG_NSECT;
+		ap->ioaddr.lbal_addr	= base + ATA_REG_LBAL;
+		ap->ioaddr.ctl_addr	= base + 0xe;
+		ap->ioaddr.altstatus_addr = base + 0xe;
+	}
+
+	ata_port_desc(ap, "cmd %p ctl %p", base, ap->ioaddr.ctl_addr);
+
+
+	dev_info(&pdev->dev, "version " DRV_VERSION" %d bit%s.\n",
+		 (ocd->is16bit) ? 16 : 8,
+		 (cs1) ? ", True IDE" : "");
+
+
+	return ata_host_activate(host, irq, irq_handler, 0, &octeon_cf_sht);
+}
+
+static struct platform_driver octeon_cf_driver = {
+	.probe		= octeon_cf_probe,
+	.driver		= {
+		.name	= DRV_NAME,
+		.owner	= THIS_MODULE,
+	},
+};
+
+static int __init octeon_cf_init(void)
+{
+	return platform_driver_register(&octeon_cf_driver);
+}
+
+
+MODULE_AUTHOR("David Daney <ddaney@caviumnetworks.com>");
+MODULE_DESCRIPTION("low-level driver for Cavium OCTEON Compact Flash PATA");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(DRV_VERSION);
+MODULE_ALIAS("platform:" DRV_NAME);
+
+module_init(octeon_cf_init);
-- 
1.5.6.5
