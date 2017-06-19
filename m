Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jun 2017 17:58:54 +0200 (CEST)
Received: from mx2.rt-rk.com ([89.216.37.149]:58939 "EHLO mail.rt-rk.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994786AbdFSPuaW2SAH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 19 Jun 2017 17:50:30 +0200
Received: from localhost (localhost [127.0.0.1])
        by mail.rt-rk.com (Postfix) with ESMTP id 19BA21A46B3;
        Mon, 19 Jun 2017 17:50:20 +0200 (CEST)
X-Virus-Scanned: amavisd-new at rt-rk.com
Received: from rtrkw197-lin.ba.imgtec.org (unknown [82.117.201.26])
        by mail.rt-rk.com (Postfix) with ESMTPSA id EBAF71A46A0;
        Mon, 19 Jun 2017 17:50:19 +0200 (CEST)
From:   Aleksandar Markovic <aleksandar.markovic@rt-rk.com>
To:     linux-mips@linux-mips.org, James.Hogan@imgtec.com,
        Paul.Burton@imgtec.com
Cc:     Raghu.Gandham@imgtec.com, Leonid.Yegoshin@imgtec.com,
        Douglas.Leung@imgtec.com, Petar.Jovanovic@imgtec.com,
        Miodrag.Dinic@imgtec.com, Goran.Ferenc@imgtec.com
Subject: [PATCH 7/8] tty: goldfish: Use streaming DMA for r/w operations on Ranchu platforms
Date:   Mon, 19 Jun 2017 17:50:14 +0200
Message-Id: <1497887415-13825-8-git-send-email-aleksandar.markovic@rt-rk.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
References: <1497887415-13825-1-git-send-email-aleksandar.markovic@rt-rk.com>
Return-Path: <aleksandar.markovic@rt-rk.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 58632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aleksandar.markovic@rt-rk.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

From: Miodrag Dinic <miodrag.dinic@imgtec.com>

Implement tty r/w operations using streaming DMA.

Goldfish tty for Ranchu platforms has been modified to use
streaming DMA mappings for read/write operations. This change
eliminates the need for snooping through the TLB in QEMU using
cpu_get_phys_page_debug() which does not guarantee that it will
return the valid va -> pa mapping.

The streaming DMA mapping is implemented using dma_map_single() per
transfer, while dma_unmap_single() is used for unmapping right after
the DMA transfer.

Using DMA API is the proper way for handling r/w transfers and
makes this driver more portable, thus effectively eliminating
the need for virt_to_page() and page_to_phys() conversions.

This change does not affect the old style Goldfish tty behaviour
which is still used by the Goldfish emulator. Version register has
been added and probed to see which platform is running this driver.
Reading from the new GOLDFISH_TTY_VERSION register using the Goldfish
emulator will return 0 and driver will work with virtual addresses.
Whereas if run on Ranchu it returns 1, and thus DMA is used.

Signed-off-by: Miodrag Dinic <miodrag.dinic@imgtec.com>
Signed-off-by: Goran Ferenc <goran.ferenc@imgtec.com>
Signed-off-by: Aleksandar Markovic <aleksandar.markovic@imgtech.com>
---
 drivers/tty/goldfish.c | 119 ++++++++++++++++++++++++++++++++++++++++++++-----
 1 file changed, 108 insertions(+), 11 deletions(-)

diff --git a/drivers/tty/goldfish.c b/drivers/tty/goldfish.c
index 996bd47..acd50fa 100644
--- a/drivers/tty/goldfish.c
+++ b/drivers/tty/goldfish.c
@@ -22,6 +22,8 @@
 #include <linux/io.h>
 #include <linux/module.h>
 #include <linux/goldfish.h>
+#include <linux/mm.h>
+#include <linux/dma-mapping.h>
 
 enum {
 	GOLDFISH_TTY_PUT_CHAR       = 0x00,
@@ -32,6 +34,8 @@ enum {
 	GOLDFISH_TTY_DATA_LEN       = 0x14,
 	GOLDFISH_TTY_DATA_PTR_HIGH  = 0x18,
 
+	GOLDFISH_TTY_VERSION		= 0x20,
+
 	GOLDFISH_TTY_CMD_INT_DISABLE    = 0,
 	GOLDFISH_TTY_CMD_INT_ENABLE     = 1,
 	GOLDFISH_TTY_CMD_WRITE_BUFFER   = 2,
@@ -45,6 +49,8 @@ struct goldfish_tty {
 	u32 irq;
 	int opencount;
 	struct console console;
+	u32 version;
+	struct device *dev;
 };
 
 static DEFINE_MUTEX(goldfish_tty_lock);
@@ -53,24 +59,94 @@ static u32 goldfish_tty_line_count = 8;
 static u32 goldfish_tty_current_line_count;
 static struct goldfish_tty *goldfish_ttys;
 
-static void goldfish_tty_do_write(int line, const char *buf, unsigned count)
+static inline void do_rw_io(struct goldfish_tty *qtty,
+				unsigned long address,
+				unsigned int count,
+				int is_write)
 {
 	unsigned long irq_flags;
-	struct goldfish_tty *qtty = &goldfish_ttys[line];
 	void __iomem *base = qtty->base;
+
 	spin_lock_irqsave(&qtty->lock, irq_flags);
-	gf_write_ptr(buf, base + GOLDFISH_TTY_DATA_PTR,
+	gf_write_ptr((void *)address, base + GOLDFISH_TTY_DATA_PTR,
 				base + GOLDFISH_TTY_DATA_PTR_HIGH);
 	writel(count, base + GOLDFISH_TTY_DATA_LEN);
-	writel(GOLDFISH_TTY_CMD_WRITE_BUFFER, base + GOLDFISH_TTY_CMD);
+
+	if (is_write)
+		writel(GOLDFISH_TTY_CMD_WRITE_BUFFER, base + GOLDFISH_TTY_CMD);
+	else
+		writel(GOLDFISH_TTY_CMD_READ_BUFFER, base + GOLDFISH_TTY_CMD);
+
 	spin_unlock_irqrestore(&qtty->lock, irq_flags);
 }
 
+static inline void goldfish_tty_rw(struct goldfish_tty *qtty,
+				unsigned long addr,
+				unsigned int count,
+				int is_write)
+{
+	dma_addr_t dma_handle;
+	enum dma_data_direction dma_dir;
+
+	dma_dir = (is_write ? DMA_TO_DEVICE : DMA_FROM_DEVICE);
+	if (qtty->version) {
+		/*
+		 * Goldfish TTY for Ranchu platform uses
+		 * physical addresses and DMA for read/write operations
+		 */
+		unsigned long addr_end = addr + count;
+
+		while (addr < addr_end) {
+			unsigned long pg_end = (addr & PAGE_MASK) + PAGE_SIZE;
+			unsigned long next =
+					pg_end < addr_end ? pg_end : addr_end;
+			unsigned long avail = next - addr;
+
+			/*
+			 * Map the buffer's virtual address to the DMA address
+			 * so the buffer can be accessed by the device.
+			 */
+			dma_handle = dma_map_single(qtty->dev,
+						(void *)addr, avail, dma_dir);
+
+			if (dma_mapping_error(qtty->dev, dma_handle)) {
+				dev_err(qtty->dev, "tty: DMA mapping error.\n");
+				return;
+			}
+			do_rw_io(qtty, dma_handle, avail, is_write);
+
+			/*
+			 * Unmap the previously mapped region after
+			 * the completion of the read/write operation.
+			 */
+			dma_unmap_single(qtty->dev, dma_handle, avail, dma_dir);
+
+			addr += avail;
+		}
+	} else {
+		/*
+		 * Old style Goldfish TTY used on the Goldfish platform
+		 * uses virtual addresses.
+		 */
+		do_rw_io(qtty, addr, count, is_write);
+	}
+
+}
+
+static void goldfish_tty_do_write(int line, const char *buf,
+				unsigned int count)
+{
+	struct goldfish_tty *qtty = &goldfish_ttys[line];
+	unsigned long address = (unsigned long)(void *)buf;
+
+	goldfish_tty_rw(qtty, address, count, 1);
+}
+
 static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
 {
 	struct goldfish_tty *qtty = dev_id;
 	void __iomem *base = qtty->base;
-	unsigned long irq_flags;
+	unsigned long address;
 	unsigned char *buf;
 	u32 count;
 
@@ -79,12 +155,10 @@ static irqreturn_t goldfish_tty_interrupt(int irq, void *dev_id)
 		return IRQ_NONE;
 
 	count = tty_prepare_flip_string(&qtty->port, &buf, count);
-	spin_lock_irqsave(&qtty->lock, irq_flags);
-	gf_write_ptr(buf, base + GOLDFISH_TTY_DATA_PTR,
-				base + GOLDFISH_TTY_DATA_PTR_HIGH);
-	writel(count, base + GOLDFISH_TTY_DATA_LEN);
-	writel(GOLDFISH_TTY_CMD_READ_BUFFER, base + GOLDFISH_TTY_CMD);
-	spin_unlock_irqrestore(&qtty->lock, irq_flags);
+
+	address = (unsigned long)(void *)buf;
+	goldfish_tty_rw(qtty, address, count, 0);
+
 	tty_schedule_flip(&qtty->port);
 	return IRQ_HANDLED;
 }
@@ -271,6 +345,29 @@ static int goldfish_tty_probe(struct platform_device *pdev)
 	qtty->port.ops = &goldfish_port_ops;
 	qtty->base = base;
 	qtty->irq = irq;
+	qtty->dev = &pdev->dev;
+
+	/* Goldfish TTY device used by the Goldfish emulator
+	 * should identify itself with 0, forcing the driver
+	 * to use virtual addresses. Goldfish TTY device
+	 * on Ranchu emulator (qemu2) returns 1 here and
+	 * driver will use physical addresses.
+	 */
+	qtty->version = readl(base + GOLDFISH_TTY_VERSION);
+
+	/* Goldfish TTY device on Ranchu emulator (qemu2)
+	 * will use DMA for read/write IO operations.
+	 */
+	if (qtty->version > 0) {
+		/* Initialize dma_mask to 32-bits.
+		 */
+		if (!pdev->dev.dma_mask)
+			pdev->dev.dma_mask = &pdev->dev.coherent_dma_mask;
+		if (dma_set_mask(&pdev->dev, DMA_BIT_MASK(32))) {
+			dev_err(&pdev->dev, "No suitable DMA available.\n");
+			goto err_create_driver_failed;
+		}
+	}
 
 	writel(GOLDFISH_TTY_CMD_INT_DISABLE, base + GOLDFISH_TTY_CMD);
 
-- 
2.7.4
