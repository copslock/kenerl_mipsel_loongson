Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Dec 2007 11:13:47 +0000 (GMT)
Received: from elvis.franken.de ([193.175.24.41]:6113 "EHLO elvis.franken.de")
	by ftp.linux-mips.org with ESMTP id S20022282AbXLBLNj (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Sun, 2 Dec 2007 11:13:39 +0000
Received: from uucp (helo=solo.franken.de)
	by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
	id 1IymiQ-0000XZ-00; Sun, 02 Dec 2007 12:10:26 +0100
Received: by solo.franken.de (Postfix, from userid 1000)
	id 6A926C2EB4; Sun,  2 Dec 2007 11:33:09 +0100 (CET)
From:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:	linux-scsi@vger.kernel.org, linux-mips@linux-mips.org
cc:	ralf@linux-mips.org, James.Bottomley@HansenPartnership.com
Subject: [UPDATED PATCH] SGIWD93: use cached memory access to make driver work on IP28
Message-Id: <20071202103309.6A926C2EB4@solo.franken.de>
Date:	Sun,  2 Dec 2007 11:33:09 +0100 (CET)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17657
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
Precedence: bulk
X-list: linux-mips

SGI IP28 machines would need special treatment (enable adding addtional
wait states) when accessing memory uncached. To avoid this pain I
changed the driver to use only cached access to memory.

Signed-off-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
---

Changes to last version:

- added Kconfig change to make selection for similair SGI boxes easier

 drivers/scsi/Kconfig   |    2 +-
 drivers/scsi/sgiwd93.c |   64 +++++++++++++++++++++++++++++------------------
 2 files changed, 40 insertions(+), 26 deletions(-)

diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index a6676be..2a071b0 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -345,7 +345,7 @@ config ISCSI_TCP
 
 config SGIWD93_SCSI
 	tristate "SGI WD93C93 SCSI Driver"
-	depends on SGI_IP22 && SCSI
+	depends on SGI_HAS_WD93 && SCSI
   	help
 	  If you have a Western Digital WD93 SCSI controller on
 	  an SGI MIPS system, say Y.  Otherwise, say N.
diff --git a/drivers/scsi/sgiwd93.c b/drivers/scsi/sgiwd93.c
index eef8275..e64ddee 100644
--- a/drivers/scsi/sgiwd93.c
+++ b/drivers/scsi/sgiwd93.c
@@ -33,10 +33,9 @@
 
 struct ip22_hostdata {
 	struct WD33C93_hostdata wh;
-	struct hpc_data {
-		dma_addr_t      dma;
-		void		*cpu;
-	} hd;
+	dma_addr_t dma;
+	void *cpu;
+	void *dev;
 };
 
 #define host_to_hostdata(host) ((struct ip22_hostdata *)((host)->hostdata))
@@ -46,6 +45,11 @@ struct hpc_chunk {
 	u32 _padding;	/* align to quadword boundary */
 };
 
+/* space for hpc dma descriptors */
+#define HPC_DMA_SIZE   PAGE_SIZE
+
+#define DMA_DIR(d)   ((d == DATA_OUT_DIR) ? DMA_TO_DEVICE : DMA_FROM_DEVICE)
+
 static irqreturn_t sgiwd93_intr(int irq, void *dev_id)
 {
 	struct Scsi_Host * host = dev_id;
@@ -59,15 +63,17 @@ static irqreturn_t sgiwd93_intr(int irq, void *dev_id)
 }
 
 static inline
-void fill_hpc_entries(struct hpc_chunk *hcp, struct scsi_cmnd *cmd, int datainp)
+void fill_hpc_entries(struct ip22_hostdata *hd, struct scsi_cmnd *cmd, int din)
 {
 	unsigned long len = cmd->SCp.this_residual;
 	void *addr = cmd->SCp.ptr;
 	dma_addr_t physaddr;
 	unsigned long count;
+	struct hpc_chunk *hcp;
 
-	physaddr = dma_map_single(NULL, addr, len, cmd->sc_data_direction);
+	physaddr = dma_map_single(hd->dev, addr, len, DMA_DIR(din));
 	cmd->SCp.dma_handle = physaddr;
+	hcp = hd->cpu;
 
 	while (len) {
 		/*
@@ -89,6 +95,9 @@ void fill_hpc_entries(struct hpc_chunk *hcp, struct scsi_cmnd *cmd, int datainp)
 	 */
 	hcp->desc.pbuf = 0;
 	hcp->desc.cntinfo = HPCDMA_EOX;
+	dma_cache_sync(hd->dev, hd->cpu,
+		       (unsigned long)(hcp + 1) - (unsigned long)hd->cpu,
+		       DMA_TO_DEVICE);
 }
 
 static int dma_setup(struct scsi_cmnd *cmd, int datainp)
@@ -96,9 +105,8 @@ static int dma_setup(struct scsi_cmnd *cmd, int datainp)
 	struct ip22_hostdata *hdata = host_to_hostdata(cmd->device->host);
 	struct hpc3_scsiregs *hregs =
 		(struct hpc3_scsiregs *) cmd->device->host->base;
-	struct hpc_chunk *hcp = (struct hpc_chunk *) hdata->hd.cpu;
 
-	pr_debug("dma_setup: datainp<%d> hcp<%p> ", datainp, hcp);
+	pr_debug("dma_setup: datainp<%d> hcp<%p> ", datainp, hdata->cpu);
 
 	hdata->wh.dma_dir = datainp;
 
@@ -111,12 +119,12 @@ static int dma_setup(struct scsi_cmnd *cmd, int datainp)
 	if (cmd->SCp.ptr == NULL || cmd->SCp.this_residual == 0)
 		return 1;
 
-	fill_hpc_entries(hcp, cmd, datainp);
+	fill_hpc_entries(hdata, cmd, datainp);
 
 	pr_debug(" HPCGO\n");
 
 	/* Start up the HPC. */
-	hregs->ndptr = hdata->hd.dma;
+	hregs->ndptr = hdata->dma;
 	if (datainp)
 		hregs->ctrl = HPC3_SCTRL_ACTIVE;
 	else
@@ -134,6 +142,9 @@ static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
 	if (!SCpnt)
 		return;
 
+	if (SCpnt->SCp.ptr == NULL || SCpnt->SCp.this_residual == 0)
+		return;
+
 	hregs = (struct hpc3_scsiregs *) SCpnt->device->host->base;
 
 	pr_debug("dma_stop: status<%d> ", status);
@@ -145,8 +156,9 @@ static void dma_stop(struct Scsi_Host *instance, struct scsi_cmnd *SCpnt,
 			barrier();
 	}
 	hregs->ctrl = 0;
-	dma_unmap_single(NULL, SCpnt->SCp.dma_handle, SCpnt->SCp.this_residual,
-	                 SCpnt->sc_data_direction);
+	dma_unmap_single(hdata->dev, SCpnt->SCp.dma_handle,
+			 SCpnt->SCp.this_residual,
+			 DMA_DIR(hdata->wh.dma_dir));
 
 	pr_debug("\n");
 }
@@ -160,22 +172,23 @@ void sgiwd93_reset(unsigned long base)
 	hregs->ctrl = 0;
 }
 
-static inline void init_hpc_chain(struct hpc_data *hd)
+static inline void init_hpc_chain(void *dev, struct ip22_hostdata *hdata)
 {
-	struct hpc_chunk *hcp = (struct hpc_chunk *) hd->cpu;
-	struct hpc_chunk *dma = (struct hpc_chunk *) hd->dma;
+	struct hpc_chunk *hcp = (struct hpc_chunk *)hdata->cpu;
+	dma_addr_t dma = hdata->dma;
 	unsigned long start, end;
 
 	start = (unsigned long) hcp;
-	end = start + PAGE_SIZE;
+	end = start + HPC_DMA_SIZE;
 	while (start < end) {
-		hcp->desc.pnext = (u32) (dma + 1);
+		hcp->desc.pnext = (u32) (dma + sizeof(struct hpc_chunk));
 		hcp->desc.cntinfo = HPCDMA_EOX;
-		hcp++; dma++;
+		hcp++;
+		dma += sizeof(struct hpc_chunk);
 		start += sizeof(struct hpc_chunk);
 	};
 	hcp--;
-	hcp->desc.pnext = hd->dma;
+	hcp->desc.pnext = hdata->dma;
 }
 
 static int sgiwd93_bus_reset(struct scsi_cmnd *cmd)
@@ -234,16 +247,17 @@ static int __init sgiwd93_probe(struct platform_device *pdev)
 	host->irq = irq;
 
 	hdata = host_to_hostdata(host);
-	hdata->hd.cpu = dma_alloc_coherent(&pdev->dev, PAGE_SIZE,
-	                                   &hdata->hd.dma, GFP_KERNEL);
-	if (!hdata->hd.cpu) {
+	hdata->dev = &pdev->dev;
+	hdata->cpu = dma_alloc_noncoherent(&pdev->dev, HPC_DMA_SIZE,
+					   &hdata->dma, GFP_KERNEL);
+	if (!hdata->cpu) {
 		printk(KERN_WARNING "sgiwd93: Could not allocate memory for "
 		       "host %d buffer.\n", unit);
 		err = -ENOMEM;
 		goto out_put;
 	}
 
-	init_hpc_chain(&hdata->hd);
+	init_hpc_chain(&pdev->dev, hdata);
 
 	regs.SASR = wdregs + 3;
 	regs.SCMD = wdregs + 7;
@@ -273,7 +287,7 @@ static int __init sgiwd93_probe(struct platform_device *pdev)
 out_irq:
 	free_irq(irq, host);
 out_free:
-	dma_free_coherent(NULL, PAGE_SIZE, hdata->hd.cpu, hdata->hd.dma);
+	dma_free_noncoherent(NULL, HPC_DMA_SIZE, hdata->cpu, hdata->dma);
 out_put:
 	scsi_host_put(host);
 out:
@@ -289,7 +303,7 @@ static void __exit sgiwd93_remove(struct platform_device *pdev)
 
 	scsi_remove_host(host);
 	free_irq(pd->irq, host);
-	dma_free_coherent(&pdev->dev, PAGE_SIZE, hdata->hd.cpu, hdata->hd.dma);
+	dma_free_noncoherent(&pdev->dev, HPC_DMA_SIZE, hdata->cpu, hdata->dma);
 	scsi_host_put(host);
 }
 
