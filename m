Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Oct 2008 16:08:45 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:58335 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S20367232AbYJBPIn (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 2 Oct 2008 16:08:43 +0100
Received: from localhost (p1084-ipad304funabasi.chiba.ocn.ne.jp [123.217.155.84])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2C904B670; Fri,  3 Oct 2008 00:08:35 +0900 (JST)
Date:	Fri, 03 Oct 2008 00:08:38 +0900 (JST)
Message-Id: <20081003.000838.27954527.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: [PATCH] ide: Add tx4939ide driver (v3)
From:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
X-Fingerprint: 6ACA 1623 39BD 9A94 9B1A  B746 CA77 FE94 2874 D52F
X-Pgp-Public-Key: http://wwwkeys.pgp.net/pks/lookup?op=get&search=0x2874D52F
X-Mailer: Mew version 5.2 on Emacs 21.4 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-Path: <anemo@mba.ocn.ne.jp>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20675
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This is the driver for the Toshiba TX4939 SoC ATA controller.

This controller has standard ATA taskfile registers and DMA
command/status registers, but the register layout is swapped on big
endian.  There are some other endian issue and some special registers
which requires many custom dma_ops/tp_ops routines and build_dmatable.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
This patch is against linux-next 20080919.

Changes since v2:
* more consistent symbol naming
* drop custom selectproc
* more reasonable delay values
* custom ide_build_dmatable for big endian
* cleanup irq handling
* use ide_host_alloc/ide_host_register instead of ide_host_alloc
* drop custom init_iops
* and so on  (Many many thanks to Sergei)

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
 drivers/ide/Kconfig          |    6 +
 drivers/ide/mips/Makefile    |    1 +
 drivers/ide/mips/tx4939ide.c |  775 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 782 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ide/mips/tx4939ide.c

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 325461c..0ed731a 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -736,6 +736,12 @@ config BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ
        default "128"
        depends on BLK_DEV_IDE_AU1XXX
 
+config BLK_DEV_IDE_TX4939
+	tristate "TX4939 internal IDE support"
+	depends on SOC_TX4939
+	select BLK_DEV_IDEDMA_SFF
+	select IDE_TIMINGS
+
 config IDE_ARM
 	tristate "ARM IDE support"
 	depends on ARM && (ARCH_CLPS7500 || ARCH_RPC || ARCH_SHARK)
diff --git a/drivers/ide/mips/Makefile b/drivers/ide/mips/Makefile
index 677c7b2..1e0ad98 100644
--- a/drivers/ide/mips/Makefile
+++ b/drivers/ide/mips/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_BLK_DEV_IDE_SWARM)		+= swarm.o
 obj-$(CONFIG_BLK_DEV_IDE_AU1XXX)	+= au1xxx-ide.o
+obj-$(CONFIG_BLK_DEV_IDE_TX4939)	+= tx4939ide.o
 
 EXTRA_CFLAGS    := -Idrivers/ide
diff --git a/drivers/ide/mips/tx4939ide.c b/drivers/ide/mips/tx4939ide.c
new file mode 100644
index 0000000..6671d64
--- /dev/null
+++ b/drivers/ide/mips/tx4939ide.c
@@ -0,0 +1,775 @@
+/*
+ * TX4939 internal IDE driver
+ * Based on RBTX49xx patch from CELF patch archive.
+ *
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * (C) Copyright TOSHIBA CORPORATION 2005-2007
+ */
+
+#include <linux/module.h>
+#include <linux/types.h>
+#include <linux/ide.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <linux/scatterlist.h>
+
+#define MODNAME	"tx4939ide"
+
+/* ATA Shadow Registers (8-bit except for DATA which is 16-bit) */
+#define TX4939IDE_DATA			0x000
+#define TX4939IDE_Error_Feature		0x001
+#define TX4939IDE_Sec			0x002
+#define TX4939IDE_LBA0			0x003
+#define TX4939IDE_LBA1			0x004
+#define TX4939IDE_LBA2			0x005
+#define TX4939IDE_DevHead		0x006
+#define TX4939IDE_Stat_Cmd		0x007
+#define TX4939IDE_AltStat_DevCtl	0x402
+/* H/W DMA Registers  */
+#define TX4939IDE_DMA_Cmd	0x800	/* 8-bit */
+#define TX4939IDE_DMA_stat	0x802	/* 8-bit */
+#define TX4939IDE_PRD_Ptr	0x804	/* 32-bit */
+/* ATA100 CORE Registers (16-bit) */
+#define TX4939IDE_Sys_Ctl	0xc00
+#define TX4939IDE_Xfer_Cnt_1	0xc08
+#define TX4939IDE_Xfer_Cnt_2	0xc0a
+#define TX4939IDE_Sec_Cnt	0xc10
+#define TX4939IDE_Start_Lo_Addr	0xc18
+#define TX4939IDE_Start_Up_Addr	0xc20
+#define TX4939IDE_Add_Ctl	0xc28
+#define TX4939IDE_Lo_Burst_Cnt	0xc30
+#define TX4939IDE_Up_Burst_Cnt	0xc38
+#define TX4939IDE_PIO_Addr	0xc88
+#define TX4939IDE_H_Rst_Tim	0xc90
+#define TX4939IDE_Int_Ctl	0xc98
+#define TX4939IDE_Pkt_Cmd	0xcb8
+#define TX4939IDE_Bxfer_Cnt_Hi	0xcc0
+#define TX4939IDE_Bxfer_Cnt_Lo	0xcc8
+#define TX4939IDE_Dev_TErr	0xcd0
+#define TX4939IDE_Pkt_Xfer_Ctl	0xcd8
+#define TX4939IDE_Start_TAddr	0xce0
+
+/* bits for Int_Ctl */
+#define TX4939IDE_INT_ADDRERR	0x80
+#define TX4939IDE_INT_REACHMUL	0x40
+#define TX4939IDE_INT_DEVTIMING	0x20
+#define TX4939IDE_INT_UDMATERM	0x10
+#define TX4939IDE_INT_TIMER	0x08
+#define TX4939IDE_INT_BUSERR	0x04
+#define TX4939IDE_INT_XFEREND	0x02
+#define TX4939IDE_INT_HOST	0x01
+
+#define TX4939IDE_IGNORE_INTS	\
+	(TX4939IDE_INT_ADDRERR | TX4939IDE_INT_REACHMUL | \
+	 TX4939IDE_INT_DEVTIMING | TX4939IDE_INT_UDMATERM | \
+	 TX4939IDE_INT_TIMER | TX4939IDE_INT_XFEREND)
+
+#ifdef __BIG_ENDIAN
+#define tx4939ide_swizzlel(a)	((a) ^ 4)
+#define tx4939ide_swizzlew(a)	((a) ^ 6)
+#define tx4939ide_swizzleb(a)	((a) ^ 7)
+#else
+#define tx4939ide_swizzlel(a)	(a)
+#define tx4939ide_swizzlew(a)	(a)
+#define tx4939ide_swizzleb(a)	(a)
+#endif
+
+static u16 tx4939ide_readw(void __iomem *base, u32 reg)
+{
+	return __raw_readw(base + tx4939ide_swizzlew(reg));
+}
+static u8 tx4939ide_readb(void __iomem *base, u32 reg)
+{
+	return __raw_readb(base + tx4939ide_swizzleb(reg));
+}
+static void tx4939ide_writel(u32 val, void __iomem *base, u32 reg)
+{
+	__raw_writel(val, base + tx4939ide_swizzlel(reg));
+}
+static void tx4939ide_writew(u16 val, void __iomem *base, u32 reg)
+{
+	__raw_writew(val, base + tx4939ide_swizzlew(reg));
+}
+static void tx4939ide_writeb(u8 val, void __iomem *base, u32 reg)
+{
+	__raw_writeb(val, base + tx4939ide_swizzleb(reg));
+}
+
+#define TX4939IDE_BASE(hwif)	((void __iomem *)(hwif)->extra_base)
+
+static void tx4939ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	int is_slave = drive->dn & 1;
+	u32 mask, val;
+	u8 safe = pio;
+	ide_drive_t *pair;
+
+	pair = ide_get_pair_dev(drive);
+	if (pair)
+		safe = min(safe, ide_get_best_pio_mode(pair, 255, 4));
+	/*
+	 * Update Command Transfer Mode for master/slave and Data
+	 * Transfer Mode for this drive.
+	 */
+	mask = is_slave ? 0x07f00000 : 0x000007f0;
+	val = ((safe << 8) | (pio << 4)) << (is_slave ? 16 : 0);
+	hwif->select_data = (hwif->select_data & ~mask) | val;
+	/* tx4939ide_tf_load_fixup() will set the Sys_Ctl register */
+}
+
+static void tx4939ide_set_dma_mode(ide_drive_t *drive, const u8 mode)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	u32 mask, val;
+
+	/* Update Data Transfer Mode for this drive. */
+	if (mode >= XFER_UDMA_0)
+		val = mode - XFER_UDMA_0 + 8;
+	else if (mode >= XFER_MW_DMA_0)
+		val = mode - XFER_MW_DMA_0 + 5;
+	else
+		val = mode - XFER_PIO_0;
+	if (drive->dn & 1) {
+		mask = 0x00f00000;
+		val <<= 20;
+	} else {
+		mask = 0x000000f0;
+		val <<= 4;
+	}
+	hwif->select_data = (hwif->select_data & ~mask) | val;
+	/* tx4939ide_tf_load_fixup() will set the Sys_Ctl register */
+}
+
+static u16 tx4939ide_check_error_ints(ide_hwif_t *hwif)
+{
+	void __iomem *base = TX4939IDE_BASE(hwif);
+	u16 ctl = tx4939ide_readw(base, TX4939IDE_Int_Ctl);
+
+	if (ctl & TX4939IDE_INT_BUSERR) {
+		/* reset FIFO */
+		u16 sysctl = tx4939ide_readw(base, TX4939IDE_Sys_Ctl);
+		tx4939ide_writew(sysctl | 0x4000, base, TX4939IDE_Sys_Ctl);
+		mmiowb();
+		/* wait 12GBUSCLK (typ. 60ns @ GBUS200MHz, max 270ns) */
+		ndelay(270);
+		tx4939ide_writew(sysctl, base, TX4939IDE_Sys_Ctl);
+	}
+	if (ctl & (TX4939IDE_INT_ADDRERR |
+		    TX4939IDE_INT_DEVTIMING | TX4939IDE_INT_BUSERR))
+		pr_err("%s: Error interrupt %#x (%s%s%s )\n",
+		       hwif->name, ctl,
+		       (ctl & TX4939IDE_INT_ADDRERR) ?
+		       " Address-Error" : "",
+		       (ctl & TX4939IDE_INT_DEVTIMING) ?
+		       " DEV-Timing" : "",
+		       (ctl & TX4939IDE_INT_BUSERR) ?
+		       " Bus-Error" : "");
+	return ctl;
+}
+
+static void tx4939ide_clear_irq(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif;
+	void __iomem *base;
+	u16 ctl;
+
+	/*
+	 * tx4939ide_dma_test_irq() and tx4939ide_dma_end() do all
+	 * jobs for DMA case.
+	 */
+	if (drive->waiting_for_dma)
+		return;
+	hwif = drive->hwif;
+	base = TX4939IDE_BASE(hwif);
+	ctl = tx4939ide_check_error_ints(hwif);
+	tx4939ide_writew(ctl, base, TX4939IDE_Int_Ctl);
+}
+
+static u8 tx4939ide_cable_detect(ide_hwif_t *hwif)
+{
+	void __iomem *base = TX4939IDE_BASE(hwif);
+
+	return (tx4939ide_readw(base, TX4939IDE_Sys_Ctl) & 0x2000) ?
+		ATA_CBL_PATA40 : ATA_CBL_PATA80;
+}
+
+#ifdef __BIG_ENDIAN
+static void tx4939ide_dma_host_set(ide_drive_t *drive, int on)
+{
+	ide_hwif_t *hwif	= drive->hwif;
+	u8 unit			= drive->dn & 1;
+	void __iomem *base = TX4939IDE_BASE(hwif);
+	u8 dma_stat = tx4939ide_readb(base, TX4939IDE_DMA_stat);
+
+	if (on)
+		dma_stat |= (1 << (5 + unit));
+	else
+		dma_stat &= ~(1 << (5 + unit));
+
+	tx4939ide_writeb(dma_stat, base, TX4939IDE_DMA_stat);
+}
+#else
+#define tx4939ide_dma_host_set	ide_dma_host_set
+#endif
+
+static u8 tx4939ide_read_and_clear_dma_status(void __iomem *base)
+{
+	u8 dma_stat;
+
+	/* read DMA status for INTR & ERROR flags */
+	dma_stat = tx4939ide_readb(base, TX4939IDE_DMA_stat);
+	/* clear INTR & ERROR flags */
+	tx4939ide_writeb(dma_stat | 6, base, TX4939IDE_DMA_stat);
+	/* recover intmask cleared by writing to bit2 of DMA_stat */
+	tx4939ide_writew(TX4939IDE_IGNORE_INTS << 8, base, TX4939IDE_Int_Ctl);
+	return dma_stat;
+}
+
+#ifdef __BIG_ENDIAN
+/* custom ide_build_dmatable to handle swapped layout */
+static int tx4939ide_build_dmatable(ide_drive_t *drive, struct request *rq)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	u32 *table = (u32 *)hwif->dmatable_cpu;
+	unsigned int count = 0;
+	int i;
+	struct scatterlist *sg;
+
+	hwif->sg_nents = ide_build_sglist(drive, rq);
+	if (hwif->sg_nents == 0)
+		return 0;
+
+	for_each_sg(hwif->sg_table, sg, hwif->sg_nents, i) {
+		u32 cur_addr, cur_len, xcount, bcount;
+
+		cur_addr = sg_dma_address(sg);
+		cur_len = sg_dma_len(sg);
+
+		/*
+		 * Fill in the dma table, without crossing any 64kB boundaries.
+		 */
+
+		while (cur_len) {
+			if (count++ >= PRD_ENTRIES)
+				goto use_pio_instead;
+
+			bcount = 0x10000 - (cur_addr & 0xffff);
+			if (bcount > cur_len)
+				bcount = cur_len;
+			xcount = bcount & 0xffff;
+			if (xcount == 0x0000) {
+				if (count++ >= PRD_ENTRIES)
+					goto use_pio_instead;
+				*table++ = 0x8000;
+				*table++ = cur_addr;
+				*table++ = 0x8000;
+				*table++ = cur_addr + 0x8000;
+			} else {
+				*table++ = xcount;
+				*table++ = cur_addr;
+			}
+			cur_addr += bcount;
+			cur_len -= bcount;
+		}
+	}
+
+	if (count) {
+		*(table - 2) |= 0x80000000;
+		return count;
+	}
+
+use_pio_instead:
+	printk(KERN_ERR "%s: %s\n", drive->name,
+		count ? "DMA table too small" : "empty DMA table?");
+
+	ide_destroy_dmatable(drive);
+
+	return 0; /* revert to PIO for this request */
+}
+#else
+#define tx4939ide_build_dmatable	ide_build_dmatable
+#endif
+
+static int tx4939ide_dma_setup(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	void __iomem *base = TX4939IDE_BASE(hwif);
+	struct request *rq = hwif->hwgroup->rq;
+	unsigned int reading;
+	int nent;
+
+	if (rq_data_dir(rq))
+		reading = 0;
+	else
+		reading = 1 << 3;
+
+	/* fall back to pio! */
+	nent = tx4939ide_build_dmatable(drive, rq);
+	if (!nent) {
+		ide_map_sg(drive, rq);
+		return 1;
+	}
+
+	/* PRD table */
+	tx4939ide_writel(hwif->dmatable_dma, base, TX4939IDE_PRD_Ptr);
+
+	/* specify r/w */
+	tx4939ide_writeb(reading, base, TX4939IDE_DMA_Cmd);
+
+	/* clear INTR & ERROR flags */
+	tx4939ide_read_and_clear_dma_status(base);
+
+	drive->waiting_for_dma = 1;
+
+	tx4939ide_writew(SECTOR_SIZE / 2, base, (drive->dn & 1) ?
+			 TX4939IDE_Xfer_Cnt_2 : TX4939IDE_Xfer_Cnt_1);
+	tx4939ide_writew(rq->nr_sectors, base, TX4939IDE_Sec_Cnt);
+	return 0;
+}
+
+static int tx4939ide_dma_end(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	u8 dma_stat, dma_cmd;
+	void __iomem *base = TX4939IDE_BASE(hwif);
+	u16 ctl = tx4939ide_readw(base, TX4939IDE_Int_Ctl);
+
+	drive->waiting_for_dma = 0;
+
+	/* get DMA command mode */
+	dma_cmd = tx4939ide_readb(base, TX4939IDE_DMA_Cmd);
+	/* stop DMA */
+	tx4939ide_writeb(dma_cmd & ~1, base, TX4939IDE_DMA_Cmd);
+
+	/* read and clear the INTR & ERROR bits */
+	dma_stat = tx4939ide_read_and_clear_dma_status(base);
+
+	/* purge DMA mappings */
+	ide_destroy_dmatable(drive);
+	/* verify good DMA status */
+	wmb();
+
+	if ((dma_stat & 7) == 0 &&
+	    (ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST)) ==
+	    (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST))
+		/* INT_IDE lost... bug? */
+		return 0;
+	return (dma_stat & 7) != 4 ? (0x10 | dma_stat) : 0;
+}
+
+/* returns 1 if dma irq issued, 0 otherwise */
+static int tx4939ide_dma_test_irq(ide_drive_t *drive)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	void __iomem *base = TX4939IDE_BASE(hwif);
+	u16 ctl;
+	u8 dma_stat, stat;
+	u16 ide_int;
+	int found = 0;
+
+	ctl = tx4939ide_check_error_ints(hwif);
+	ide_int = ctl & (TX4939IDE_INT_XFEREND | TX4939IDE_INT_HOST);
+	switch (ide_int) {
+	case TX4939IDE_INT_HOST:
+		/* On error, XFEREND might not be asserted. */
+		stat = tx4939ide_readb(base, TX4939IDE_AltStat_DevCtl);
+		if ((stat & (ATA_BUSY|ATA_DRQ|ATA_ERR)) == ATA_ERR)
+			found = 1;
+		else {
+			/* Wait for XFERINT (Mask HOST and unmask XFERINT) */
+			ctl &= ~TX4939IDE_INT_XFEREND << 8;
+			ctl |= TX4939IDE_INT_HOST << 8;
+		}
+		ctl |= ide_int << 8;
+		break;
+	case TX4939IDE_INT_HOST | TX4939IDE_INT_XFEREND:
+		dma_stat = tx4939ide_readb(base, TX4939IDE_DMA_stat);
+		if (!(dma_stat & 4))
+			pr_warning("%s: weird interrupt status. "
+				   "DMA_stat %#02x int_ctl %#04x\n",
+				   hwif->name, dma_stat, ctl);
+		found = 1;
+		break;
+	}
+	/*
+	 * Do not clear XFERINT, HOST now.  They will be cleared by
+	 * clearing bit2 of DMA_stat.
+	 */
+	ctl &= ~ide_int;
+	tx4939ide_writew(ctl, base, TX4939IDE_Int_Ctl);
+	return found;
+}
+
+static void tx4939ide_init_hwif(ide_hwif_t *hwif)
+{
+	void __iomem *base = TX4939IDE_BASE(hwif);
+
+	/* Soft Reset */
+	tx4939ide_writew(0x8000, base, TX4939IDE_Sys_Ctl);
+	mmiowb();
+	/* at least 20 UPSCLK (typ. 100ns @ GBUS200MHz, max 450ns) */
+	ndelay(450);
+	tx4939ide_writew(0x0000, base, TX4939IDE_Sys_Ctl);
+	/* mask some interrupts and clear all interrupts */
+	tx4939ide_writew((TX4939IDE_IGNORE_INTS << 8) | 0xff, base,
+			 TX4939IDE_Int_Ctl);
+
+	tx4939ide_writew(0x0008, base, TX4939IDE_Lo_Burst_Cnt);
+	tx4939ide_writew(0, base, TX4939IDE_Up_Burst_Cnt);
+}
+
+static int tx4939ide_init_dma(ide_hwif_t *hwif, const struct ide_port_info *d)
+{
+	hwif->dma_base = (unsigned long)TX4939IDE_BASE(hwif) +
+		tx4939ide_swizzleb(TX4939IDE_DMA_Cmd);
+	/*
+	 * Note that we cannot use ATA_DMA_TABLE_OFS,ATA_DMA_STATUS
+	 * for big endian.
+	 */
+	return ide_allocate_dma_engine(hwif);
+}
+
+static u8 tx4939ide_read_sff_dma_status(ide_hwif_t *hwif)
+{
+	void __iomem *base = TX4939IDE_BASE(hwif);
+	return tx4939ide_readb(base, TX4939IDE_DMA_stat);
+}
+
+static void tx4939ide_tf_load_fixup(ide_drive_t *drive, ide_task_t *task)
+{
+	if (task->tf_flags & IDE_TFLAG_OUT_DEVICE) {
+		ide_hwif_t *hwif = drive->hwif;
+		void __iomem *base = TX4939IDE_BASE(hwif);
+		u16 sysctl = hwif->select_data >> ((drive->dn & 1) ? 16 : 0);
+
+		/*
+		 * Fix ATA100 CORE System Control Register. (The write
+		 * to the Device/Head register may write wrong data to
+		 * the System Control Register)
+		 * While Sys_Ctl is written here, selectproc is not needed.
+		 */
+		tx4939ide_writew(sysctl, base, TX4939IDE_Sys_Ctl);
+	}
+}
+
+#ifdef __BIG_ENDIAN
+
+/* custom iops (independent from SWAP_IO_SPACE) */
+static u8 tx4939ide_inb(unsigned long port)
+{
+	return (u8)__raw_readb((void __iomem *)port);
+}
+
+static void tx4939ide_outb(u8 value, unsigned long port)
+{
+	__raw_writeb(value, (void __iomem *)port);
+}
+
+static void tx4939ide_tf_load(ide_drive_t *drive, ide_task_t *task)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	struct ide_taskfile *tf = &task->tf;
+	u8 HIHI = (task->tf_flags & IDE_TFLAG_LBA48) ? 0xE0 : 0xEF;
+
+	if (task->tf_flags & IDE_TFLAG_FLAGGED)
+		HIHI = 0xFF;
+
+	if (task->tf_flags & IDE_TFLAG_OUT_DATA) {
+		u16 data = (tf->hob_data << 8) | tf->data;
+
+		/* no endian swap */
+		__raw_writew(data, (void __iomem *)io_ports->data_addr);
+	}
+
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_FEATURE)
+		tx4939ide_outb(tf->hob_feature, io_ports->feature_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
+		tx4939ide_outb(tf->hob_nsect, io_ports->nsect_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAL)
+		tx4939ide_outb(tf->hob_lbal, io_ports->lbal_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAM)
+		tx4939ide_outb(tf->hob_lbam, io_ports->lbam_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAH)
+		tx4939ide_outb(tf->hob_lbah, io_ports->lbah_addr);
+
+	if (task->tf_flags & IDE_TFLAG_OUT_FEATURE)
+		tx4939ide_outb(tf->feature, io_ports->feature_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_NSECT)
+		tx4939ide_outb(tf->nsect, io_ports->nsect_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAL)
+		tx4939ide_outb(tf->lbal, io_ports->lbal_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAM)
+		tx4939ide_outb(tf->lbam, io_ports->lbam_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAH)
+		tx4939ide_outb(tf->lbah, io_ports->lbah_addr);
+
+	if (task->tf_flags & IDE_TFLAG_OUT_DEVICE)
+		tx4939ide_outb((tf->device & HIHI) | drive->select,
+			       io_ports->device_addr);
+
+	tx4939ide_tf_load_fixup(drive, task);
+}
+
+static void tx4939ide_tf_read(ide_drive_t *drive, ide_task_t *task)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	struct ide_taskfile *tf = &task->tf;
+
+	if (task->tf_flags & IDE_TFLAG_IN_DATA) {
+		u16 data;
+
+		/* no endian swap */
+		data = __raw_readw((void __iomem *)io_ports->data_addr);
+		tf->data = data & 0xff;
+		tf->hob_data = (data >> 8) & 0xff;
+	}
+
+	/* be sure we're looking at the low order bits */
+	tx4939ide_outb(ATA_DEVCTL_OBS & ~0x80, io_ports->ctl_addr);
+
+	if (task->tf_flags & IDE_TFLAG_IN_FEATURE)
+		tf->feature = tx4939ide_inb(io_ports->feature_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_NSECT)
+		tf->nsect  = tx4939ide_inb(io_ports->nsect_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAL)
+		tf->lbal   = tx4939ide_inb(io_ports->lbal_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAM)
+		tf->lbam   = tx4939ide_inb(io_ports->lbam_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAH)
+		tf->lbah   = tx4939ide_inb(io_ports->lbah_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_DEVICE)
+		tf->device = tx4939ide_inb(io_ports->device_addr);
+
+	if (task->tf_flags & IDE_TFLAG_LBA48) {
+		tx4939ide_outb(ATA_DEVCTL_OBS | 0x80, io_ports->ctl_addr);
+
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
+			tf->hob_feature =
+				tx4939ide_inb(io_ports->feature_addr);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
+			tf->hob_nsect   = tx4939ide_inb(io_ports->nsect_addr);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
+			tf->hob_lbal    = tx4939ide_inb(io_ports->lbal_addr);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
+			tf->hob_lbam    = tx4939ide_inb(io_ports->lbam_addr);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
+			tf->hob_lbah    = tx4939ide_inb(io_ports->lbah_addr);
+	}
+}
+
+static void tx4939ide_insw_swap(unsigned long port, void *addr, u32 count)
+{
+	unsigned short *ptr = addr;
+	unsigned long size = count * 2;
+	while (count--)
+		*ptr++ = cpu_to_le16(__raw_readw((void __iomem *)port));
+	__ide_flush_dcache_range((unsigned long)addr, size);
+}
+
+static void tx4939ide_outsw_swap(unsigned long port, void *addr, u32 count)
+{
+	unsigned short *ptr = addr;
+	unsigned long size = count * 2;
+	while (count--) {
+		__raw_writew(le16_to_cpu(*ptr), (void __iomem *)port);
+		ptr++;
+	}
+	__ide_flush_dcache_range((unsigned long)addr, size);
+}
+
+static void tx4939ide_input_data_swap(ide_drive_t *drive, struct request *rq,
+				 void *buf, unsigned int len)
+{
+	tx4939ide_insw_swap(drive->hwif->io_ports.data_addr,
+			    buf, (len + 1) / 2);
+}
+
+static void tx4939ide_output_data_swap(ide_drive_t *drive, struct request *rq,
+				  void *buf, unsigned int len)
+{
+	tx4939ide_outsw_swap(drive->hwif->io_ports.data_addr,
+			     buf, (len + 1) / 2);
+}
+
+static const struct ide_tp_ops tx4939ide_tp_ops = {
+	.exec_command		= ide_exec_command,
+	.read_status		= ide_read_status,
+	.read_altstatus		= ide_read_altstatus,
+	.read_sff_dma_status	= tx4939ide_read_sff_dma_status,
+
+	.set_irq		= ide_set_irq,
+
+	.tf_load		= tx4939ide_tf_load,
+	.tf_read		= tx4939ide_tf_read,
+
+	.input_data		= tx4939ide_input_data_swap,
+	.output_data		= tx4939ide_output_data_swap,
+};
+
+#else	/* __LITTLE_ENDIAN */
+
+static void tx4939ide_tf_load(ide_drive_t *drive, ide_task_t *task)
+{
+	ide_tf_load(drive, task);
+	tx4939ide_tf_load_fixup(drive, task);
+}
+
+static const struct ide_tp_ops tx4939ide_tp_ops = {
+	.exec_command		= ide_exec_command,
+	.read_status		= ide_read_status,
+	.read_altstatus		= ide_read_altstatus,
+	.read_sff_dma_status	= tx4939ide_read_sff_dma_status,
+
+	.set_irq		= ide_set_irq,
+
+	.tf_load		= tx4939ide_tf_load,
+	.tf_read		= ide_tf_read,
+
+	.input_data		= ide_input_data,
+	.output_data		= ide_output_data,
+};
+
+#endif	/* __LITTLE_ENDIAN */
+
+static const struct ide_port_ops tx4939ide_port_ops = {
+	.set_pio_mode = tx4939ide_set_pio_mode,
+	.set_dma_mode = tx4939ide_set_dma_mode,
+	.clear_irq = tx4939ide_clear_irq,
+	.cable_detect = tx4939ide_cable_detect,
+};
+
+static const struct ide_dma_ops tx4939ide_dma_ops = {
+	.dma_host_set = tx4939ide_dma_host_set,
+	.dma_setup = tx4939ide_dma_setup,
+	.dma_exec_cmd = ide_dma_exec_cmd,
+	.dma_start = ide_dma_start,
+	.dma_end = tx4939ide_dma_end,
+	.dma_test_irq = tx4939ide_dma_test_irq,
+	.dma_lost_irq = ide_dma_lost_irq,
+	.dma_timeout = ide_dma_timeout,
+};
+
+static const struct ide_port_info tx4939ide_port_info __initdata = {
+	.init_hwif = tx4939ide_init_hwif,
+	.init_dma = tx4939ide_init_dma,
+	.port_ops = &tx4939ide_port_ops,
+	.dma_ops = &tx4939ide_dma_ops,
+	.tp_ops = &tx4939ide_tp_ops,
+	.host_flags = IDE_HFLAG_MMIO,
+	.pio_mask = ATA_PIO4,
+	.mwdma_mask = ATA_MWDMA2,
+	.udma_mask = ATA_UDMA5,
+};
+
+static int __init tx4939ide_probe(struct platform_device *pdev)
+{
+	hw_regs_t hw;
+	hw_regs_t *hws[] = { &hw, NULL, NULL, NULL };
+	struct ide_host *host;
+	struct resource *res;
+	int irq;
+	unsigned long mapbase;
+	int ret;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -ENODEV;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	mapbase = (unsigned long)devm_ioremap(&pdev->dev, res->start,
+					      res->end - res->start + 1);
+	if (!mapbase)
+		return -EBUSY;
+	memset(&hw, 0, sizeof(hw));
+	hw.io_ports.data_addr =
+		mapbase + tx4939ide_swizzlew(TX4939IDE_DATA);
+	hw.io_ports.error_addr =
+		mapbase + tx4939ide_swizzleb(TX4939IDE_Error_Feature);
+	hw.io_ports.nsect_addr =
+		mapbase + tx4939ide_swizzleb(TX4939IDE_Sec);
+	hw.io_ports.lbal_addr =
+		mapbase + tx4939ide_swizzleb(TX4939IDE_LBA0);
+	hw.io_ports.lbam_addr =
+		mapbase + tx4939ide_swizzleb(TX4939IDE_LBA1);
+	hw.io_ports.lbah_addr =
+		mapbase + tx4939ide_swizzleb(TX4939IDE_LBA2);
+	hw.io_ports.device_addr =
+		mapbase + tx4939ide_swizzleb(TX4939IDE_DevHead);
+	hw.io_ports.command_addr =
+		mapbase + tx4939ide_swizzleb(TX4939IDE_Stat_Cmd);
+	hw.io_ports.ctl_addr =
+		mapbase + tx4939ide_swizzleb(TX4939IDE_AltStat_DevCtl);
+	hw.irq = irq;
+	hw.dev = &pdev->dev;
+
+	pr_info("TX4939 IDE interface (%lx,%d)\n", mapbase, irq);
+	host = ide_host_alloc(&tx4939ide_port_info, hws);
+	if (!host)
+		return -ENOMEM;
+	/* use extra_base for base address of the all registers */
+	host->ports[0]->extra_base = mapbase;
+	ret = ide_host_register(host, &tx4939ide_port_info, hws);
+	if (ret) {
+		ide_host_free(host);
+		return ret;
+	}
+	platform_set_drvdata(pdev, host);
+	return 0;
+}
+
+static int __exit tx4939ide_remove(struct platform_device *pdev)
+{
+	struct ide_host *host = platform_get_drvdata(pdev);
+
+	ide_host_remove(host);
+	return 0;
+}
+
+#ifdef CONFIG_PM
+static int tx4939ide_resume(struct platform_device *dev)
+{
+	struct ide_host *host = platform_get_drvdata(dev);
+	ide_hwif_t *hwif = host->ports[0];
+
+	tx4939ide_init_hwif(hwif);
+	return 0;
+}
+#else
+#define tx4939ide_resume	NULL
+#endif
+
+static struct platform_driver tx4939ide_driver = {
+	.driver = {
+		.name = MODNAME,
+		.owner = THIS_MODULE,
+	},
+	.remove = __exit_p(tx4939ide_remove),
+	.resume = tx4939ide_resume,
+};
+
+static int __init tx4939ide_init(void)
+{
+	return platform_driver_probe(&tx4939ide_driver, tx4939ide_probe);
+}
+
+static void __exit tx4939ide_exit(void)
+{
+	platform_driver_unregister(&tx4939ide_driver);
+}
+
+module_init(tx4939ide_init);
+module_exit(tx4939ide_exit);
+
+MODULE_DESCRIPTION("TX4939 internal IDE driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:tx4939ide");
-- 
1.5.6.3
