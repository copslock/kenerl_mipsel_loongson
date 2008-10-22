Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Oct 2008 17:20:08 +0100 (BST)
Received: from mba.ocn.ne.jp ([122.1.235.107]:2547 "HELO smtp.mba.ocn.ne.jp")
	by ftp.linux-mips.org with SMTP id S22144048AbYJVQUD (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 22 Oct 2008 17:20:03 +0100
Received: from localhost (p3012-ipad305funabasi.chiba.ocn.ne.jp [123.217.165.12])
	by smtp.mba.ocn.ne.jp (Postfix) with ESMTP
	id 2EA2AAE4B; Thu, 23 Oct 2008 01:19:58 +0900 (JST)
Date:	Thu, 23 Oct 2008 01:20:13 +0900 (JST)
Message-Id: <20081023.012013.52129771.anemo@mba.ocn.ne.jp>
To:	linux-mips@linux-mips.org
Cc:	linux-ide@vger.kernel.org,
	Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>,
	ralf@linux-mips.org, sshtylyov@ru.mvista.com
Subject: [PATCH] ide: Add tx4938ide driver (v2)
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
X-archive-position: 20842
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anemo@mba.ocn.ne.jp
Precedence: bulk
X-list: linux-mips

This is the driver for the Toshiba TX4938 SoC EBUS controller ATA mode.
It has custom set_pio_mode and some hacks for big endian.

Signed-off-by: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
---
Changes since v1:
* fix wait-cycle calculation.
* get the base address from platform_device resource.
* request and ioremap whole CS0/1 regions.
* some cosmetic changes.

 drivers/ide/Kconfig          |    5 +
 drivers/ide/mips/Makefile    |    1 +
 drivers/ide/mips/tx4938ide.c |  310 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 316 insertions(+), 0 deletions(-)
 create mode 100644 drivers/ide/mips/tx4938ide.c

diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 1f0eeba..decafcf 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -746,6 +746,11 @@ config BLK_DEV_IDE_AU1XXX_SEQTS_PER_RQ
        default "128"
        depends on BLK_DEV_IDE_AU1XXX
 
+config BLK_DEV_IDE_TX4938
+	tristate "TX4938 internal IDE support"
+	depends on SOC_TX4938
+	select IDE_TIMINGS
+
 config BLK_DEV_IDE_TX4939
 	tristate "TX4939 internal IDE support"
 	depends on SOC_TX4939
diff --git a/drivers/ide/mips/Makefile b/drivers/ide/mips/Makefile
index 04e5d86..7b217e6 100644
--- a/drivers/ide/mips/Makefile
+++ b/drivers/ide/mips/Makefile
@@ -1,4 +1,5 @@
 obj-$(CONFIG_BLK_DEV_IDE_AU1XXX)	+= au1xxx-ide.o
 
+obj-$(CONFIG_BLK_DEV_IDE_TX4938)	+= tx4938ide.o
 obj-$(CONFIG_BLK_DEV_IDE_TX4939)	+= tx4939ide.o
 EXTRA_CFLAGS    := -Idrivers/ide
diff --git a/drivers/ide/mips/tx4938ide.c b/drivers/ide/mips/tx4938ide.c
new file mode 100644
index 0000000..fa660f9
--- /dev/null
+++ b/drivers/ide/mips/tx4938ide.c
@@ -0,0 +1,310 @@
+/*
+ * TX4938 internal IDE driver
+ * Based on tx4939ide.c.
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
+#include <linux/platform_device.h>
+#include <linux/io.h>
+#include <asm/txx9/tx4938.h>
+
+static void tx4938ide_tune_ebusc(unsigned int ebus_ch,
+				 unsigned int gbus_clock,
+				 u8 pio)
+{
+	struct ide_timing *t = ide_timing_find_mode(XFER_PIO_0 + pio);
+	u64 cr = __raw_readq(&tx4938_ebuscptr->cr[ebus_ch]);
+	unsigned int sp = (cr >> 4) & 3;
+	unsigned int clock = gbus_clock / (4 - sp);
+	unsigned int cycle = 1000000000 / clock;
+	unsigned int wt, shwt;
+
+	/* Minimum DIOx- active time */
+	wt = DIV_ROUND_UP(t->act8b, cycle) - 2;
+	/* IORDY setup time: 35ns */
+	wt = max(wt, DIV_ROUND_UP(35, cycle));
+	/* actual wait-cycle is max(wt & ~1, 1) */
+	if (wt > 2 && (wt & 1))
+		wt++;
+	wt &= ~1;
+	/* Address-valid to DIOR/DIOW setup */
+	shwt = DIV_ROUND_UP(t->setup, cycle);
+
+	pr_debug("tx4938ide: ebus %d, bus cycle %dns, WT %d, SHWT %d\n",
+		 ebus_ch, cycle, wt, shwt);
+
+	__raw_writeq((cr & ~(0x3f007ull)) | (wt << 12) | shwt,
+		     &tx4938_ebuscptr->cr[ebus_ch]);
+}
+
+static void tx4938ide_set_pio_mode(ide_drive_t *drive, const u8 pio)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct tx4938ide_platform_info *pdata = hwif->dev->platform_data;
+	u8 safe = pio;
+	ide_drive_t *pair;
+
+	pair = ide_get_pair_dev(drive);
+	if (pair)
+		safe = min(safe, ide_get_best_pio_mode(pair, 255, 5));
+	tx4938ide_tune_ebusc(pdata->ebus_ch, pdata->gbus_clock, safe);
+}
+
+#ifdef __BIG_ENDIAN
+
+/* custom iops (independent from SWAP_IO_SPACE) */
+static u8 tx4938ide_inb(unsigned long port)
+{
+	return __raw_readb((void __iomem *)port);
+}
+
+static void tx4938ide_outb(u8 value, unsigned long port)
+{
+	__raw_writeb(value, (void __iomem *)port);
+}
+
+static void tx4938ide_tf_load(ide_drive_t *drive, ide_task_t *task)
+{
+	ide_hwif_t *hwif = drive->hwif;
+	struct ide_io_ports *io_ports = &hwif->io_ports;
+	struct ide_taskfile *tf = &task->tf;
+	u8 HIHI = task->tf_flags & IDE_TFLAG_LBA48 ? 0xE0 : 0xEF;
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
+		tx4938ide_outb(tf->hob_feature, io_ports->feature_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_NSECT)
+		tx4938ide_outb(tf->hob_nsect, io_ports->nsect_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAL)
+		tx4938ide_outb(tf->hob_lbal, io_ports->lbal_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAM)
+		tx4938ide_outb(tf->hob_lbam, io_ports->lbam_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_HOB_LBAH)
+		tx4938ide_outb(tf->hob_lbah, io_ports->lbah_addr);
+
+	if (task->tf_flags & IDE_TFLAG_OUT_FEATURE)
+		tx4938ide_outb(tf->feature, io_ports->feature_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_NSECT)
+		tx4938ide_outb(tf->nsect, io_ports->nsect_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAL)
+		tx4938ide_outb(tf->lbal, io_ports->lbal_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAM)
+		tx4938ide_outb(tf->lbam, io_ports->lbam_addr);
+	if (task->tf_flags & IDE_TFLAG_OUT_LBAH)
+		tx4938ide_outb(tf->lbah, io_ports->lbah_addr);
+
+	if (task->tf_flags & IDE_TFLAG_OUT_DEVICE)
+		tx4938ide_outb((tf->device & HIHI) | drive->select,
+			       io_ports->device_addr);
+}
+
+static void tx4938ide_tf_read(ide_drive_t *drive, ide_task_t *task)
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
+	tx4938ide_outb(ATA_DEVCTL_OBS & ~0x80, io_ports->ctl_addr);
+
+	if (task->tf_flags & IDE_TFLAG_IN_FEATURE)
+		tf->feature = tx4938ide_inb(io_ports->feature_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_NSECT)
+		tf->nsect  = tx4938ide_inb(io_ports->nsect_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAL)
+		tf->lbal   = tx4938ide_inb(io_ports->lbal_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAM)
+		tf->lbam   = tx4938ide_inb(io_ports->lbam_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_LBAH)
+		tf->lbah   = tx4938ide_inb(io_ports->lbah_addr);
+	if (task->tf_flags & IDE_TFLAG_IN_DEVICE)
+		tf->device = tx4938ide_inb(io_ports->device_addr);
+
+	if (task->tf_flags & IDE_TFLAG_LBA48) {
+		tx4938ide_outb(ATA_DEVCTL_OBS | 0x80, io_ports->ctl_addr);
+
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_FEATURE)
+			tf->hob_feature =
+				tx4938ide_inb(io_ports->feature_addr);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_NSECT)
+			tf->hob_nsect   = tx4938ide_inb(io_ports->nsect_addr);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAL)
+			tf->hob_lbal    = tx4938ide_inb(io_ports->lbal_addr);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAM)
+			tf->hob_lbam    = tx4938ide_inb(io_ports->lbam_addr);
+		if (task->tf_flags & IDE_TFLAG_IN_HOB_LBAH)
+			tf->hob_lbah    = tx4938ide_inb(io_ports->lbah_addr);
+	}
+}
+
+static void tx4938ide_input_data_swap(ide_drive_t *drive, struct request *rq,
+				void *buf, unsigned int len)
+{
+	unsigned long port = drive->hwif->io_ports.data_addr;
+	unsigned short *ptr = buf;
+	unsigned int count = (len + 1) / 2;
+
+	while (count--)
+		*ptr++ = cpu_to_le16(__raw_readw((void __iomem *)port));
+	__ide_flush_dcache_range((unsigned long)buf, count * 2);
+}
+
+static void tx4938ide_output_data_swap(ide_drive_t *drive, struct request *rq,
+				void *buf, unsigned int len)
+{
+	unsigned long port = drive->hwif->io_ports.data_addr;
+	unsigned short *ptr = buf;
+	unsigned int count = (len + 1) / 2;
+
+	while (count--) {
+		__raw_writew(le16_to_cpu(*ptr), (void __iomem *)port);
+		ptr++;
+	}
+	__ide_flush_dcache_range((unsigned long)buf, count * 2);
+}
+
+static const struct ide_tp_ops tx4938ide_tp_ops = {
+	.exec_command		= ide_exec_command,
+	.read_status		= ide_read_status,
+	.read_altstatus		= ide_read_altstatus,
+	.read_sff_dma_status	= ide_read_sff_dma_status,
+
+	.set_irq		= ide_set_irq,
+
+	.tf_load		= tx4938ide_tf_load,
+	.tf_read		= tx4938ide_tf_read,
+
+	.input_data		= tx4938ide_input_data_swap,
+	.output_data		= tx4938ide_output_data_swap,
+};
+
+#endif	/* __BIG_ENDIAN */
+
+static const struct ide_port_ops tx4938ide_port_ops = {
+	.set_pio_mode = tx4938ide_set_pio_mode,
+};
+
+static const struct ide_port_info tx4938ide_port_info __initdata = {
+	.port_ops = &tx4938ide_port_ops,
+#ifdef __BIG_ENDIAN
+	.tp_ops = &tx4938ide_tp_ops,
+#endif
+	.host_flags = IDE_HFLAG_MMIO | IDE_HFLAG_NO_DMA,
+	.pio_mask = ATA_PIO5,
+};
+
+static int __init tx4938ide_probe(struct platform_device *pdev)
+{
+	hw_regs_t hw;
+	hw_regs_t *hws[] = { &hw, NULL, NULL, NULL };
+	struct ide_host *host;
+	struct resource *res;
+	struct tx4938ide_platform_info *pdata = pdev->dev.platform_data;
+	int irq, ret, i;
+	unsigned long mapbase;
+	struct ide_port_info d = tx4938ide_port_info;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return -ENODEV;
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	if (!devm_request_mem_region(&pdev->dev, res->start,
+				     res->end - res->start + 1, "tx4938ide"))
+		return -EBUSY;
+	mapbase = (unsigned long)devm_ioremap(&pdev->dev, res->start,
+					      res->end - res->start + 1);
+	if (!mapbase)
+		return -EBUSY;
+
+	memset(&hw, 0, sizeof(hw));
+	if (pdata->ioport_shift) {
+		unsigned long port = mapbase;
+
+		hw.io_ports_array[0] = port;
+#ifdef __BIG_ENDIAN
+		port++;
+#endif
+		for (i = 1; i <= 7; i++)
+			hw.io_ports_array[i] =
+				port + (i << pdata->ioport_shift);
+		hw.io_ports.ctl_addr =
+			port + 0x10000 + (6 << pdata->ioport_shift);
+	} else
+		ide_std_init_ports(&hw, mapbase, mapbase + 0x10006);
+	hw.irq = irq;
+	hw.dev = &pdev->dev;
+
+	pr_info("TX4938 IDE interface (base %#lx, irq %d)\n", mapbase, hw.irq);
+	if (pdata->gbus_clock)
+		tx4938ide_tune_ebusc(pdata->ebus_ch, pdata->gbus_clock, 0);
+	else
+		d.port_ops = NULL;
+	ret = ide_host_add(&d, hws, &host);
+	if (ret)
+		return ret;
+	platform_set_drvdata(pdev, host);
+	return 0;
+}
+
+static int __exit tx4938ide_remove(struct platform_device *pdev)
+{
+	struct ide_host *host = platform_get_drvdata(pdev);
+
+	ide_host_remove(host);
+	return 0;
+}
+
+static struct platform_driver tx4938ide_driver = {
+	.driver		= {
+		.name	= "tx4938ide",
+		.owner	= THIS_MODULE,
+	},
+	.remove = __exit_p(tx4938ide_remove),
+};
+
+static int __init tx4938ide_init(void)
+{
+	return platform_driver_probe(&tx4938ide_driver, tx4938ide_probe);
+}
+
+static void __exit tx4938ide_exit(void)
+{
+	platform_driver_unregister(&tx4938ide_driver);
+}
+
+module_init(tx4938ide_init);
+module_exit(tx4938ide_exit);
+
+MODULE_DESCRIPTION("TX4938 internal IDE driver");
+MODULE_LICENSE("GPL");
+MODULE_ALIAS("platform:tx4938ide");
-- 
1.5.6.3
