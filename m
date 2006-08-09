Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Aug 2006 22:09:15 +0100 (BST)
Received: from 81-174-11-161.f5.ngi.it ([81.174.11.161]:28602 "EHLO
	mail.enneenne.com") by ftp.linux-mips.org with ESMTP
	id S20042657AbWHIVJN (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 9 Aug 2006 22:09:13 +0100
Received: from zaigor.enneenne.com ([192.168.32.1])
	by mail.enneenne.com with esmtp (Exim 4.50)
	id 1GAuJG-0002dY-NG
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 22:05:47 +0200
Received: from giometti by zaigor.enneenne.com with local (Exim 4.60)
	(envelope-from <giometti@enneenne.com>)
	id 1GAvJe-0000lw-Pm
	for linux-mips@linux-mips.org; Wed, 09 Aug 2006 23:10:14 +0200
Date:	Wed, 9 Aug 2006 23:10:14 +0200
From:	Rodolfo Giometti <giometti@linux.it>
To:	linux-mips@linux-mips.org
Message-ID: <20060809211014.GE13145@enneenne.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="48TaNjbzBVislYPb"
Content-Disposition: inline
Organization: GNU/Linux Device Drivers, Embedded Systems and Courses
X-PGP-Key: gpg --keyserver keyserver.linux.it --recv-keys D25A5633
User-Agent: Mutt/1.5.12-2006-07-14
X-SA-Exim-Connect-IP: 192.168.32.1
X-SA-Exim-Mail-From: giometti@enneenne.com
Subject: [PATCH] 4/7 AU1100 MMC support
X-SA-Exim-Version: 4.2 (built Thu, 03 Mar 2005 10:44:12 +0100)
X-SA-Exim-Scanned: Yes (on mail.enneenne.com)
Return-Path: <giometti@enneenne.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 12260
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: giometti@linux.it
Precedence: bulk
X-list: linux-mips


--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Better probe/remove functions implementation.

Signed-off-by: Rodolfo Giometti <giometti@linux.it>

-- 

GNU/Linux Solutions                  e-mail:    giometti@enneenne.com
Linux Device Driver                             giometti@gnudd.com
Embedded Systems                     		giometti@linux.it
UNIX programming                     phone:     +39 349 2432127

--48TaNjbzBVislYPb
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=patch-mmc-probe_remove

diff --git a/arch/mips/au1000/common/platform.c b/arch/mips/au1000/common/platform.c
index ec81d4b..a77be4f 100644
--- a/arch/mips/au1000/common/platform.c
+++ b/arch/mips/au1000/common/platform.c
@@ -13,6 +13,7 @@ #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/resource.h>
 
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-au1x00/au1xxx.h>
 
 #if defined(CONFIG_MIPS_AU1X00_ENET) || defined(CONFIG_MIPS_AU1X00_ENET_MODULE)
@@ -212,24 +213,6 @@ static struct resource au1xxx_usb_gdt_re
 	},
 };
 
-static struct resource au1xxx_mmc_resources[] = {
-	[0] = {
-		.start          = SD0_PHYS_ADDR,
-		.end            = SD0_PHYS_ADDR + 0x40,
-		.flags          = IORESOURCE_MEM,
-	},
-	[1] = {
-		.start		= SD1_PHYS_ADDR,
-		.end 		= SD1_PHYS_ADDR + 0x40,
-		.flags		= IORESOURCE_MEM,
-	},
-	[2] = {
-		.start          = AU1200_SD_INT,
-		.end            = AU1200_SD_INT,
-		.flags          = IORESOURCE_IRQ,
-	}
-};
-
 static u64 udc_dmamask = ~(u32)0;
 
 static struct platform_device au1xxx_usb_gdt_device = {
@@ -325,15 +308,68 @@ static struct platform_device au1200_ide
 
 static u64 au1xxx_mmc_dmamask =  ~(u32)0;
 
-static struct platform_device au1xxx_mmc_device = {
+static struct resource au1xxx_mmc0_resources[] = {
+	[0] = {
+		.name		= "mmc-base",
+		.start          = SD0_PHYS_ADDR,
+		.end            = SD0_PHYS_ADDR + 0x40,
+		.flags          = IORESOURCE_MEM,
+	},
+	[1] = {
+		.name		= "mmc-irq",
+		.start          = AU1200_SD_INT,
+		.end            = AU1200_SD_INT,
+		.flags          = IORESOURCE_IRQ,
+	},
+	[2] = {
+		.name		= "mmc-dma",
+		.start          = DSCR_CMD0_SDMS_TX0,
+		.end            = DSCR_CMD0_SDMS_RX0,
+		.flags          = IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device au1xxx_mmc0_device = {
 	.name = "au1xxx-mmc",
 	.id = 0,
 	.dev = {
 		.dma_mask               = &au1xxx_mmc_dmamask,
 		.coherent_dma_mask      = 0xffffffff,
 	},
-	.num_resources  = ARRAY_SIZE(au1xxx_mmc_resources),
-	.resource       = au1xxx_mmc_resources,
+	.num_resources  = ARRAY_SIZE(au1xxx_mmc0_resources),
+	.resource       = au1xxx_mmc0_resources,
+};
+
+static struct resource au1xxx_mmc1_resources[] = {
+	[0] = {
+		.name		= "mmc-base",
+		.start          = SD1_PHYS_ADDR,
+		.end            = SD1_PHYS_ADDR + 0x40,
+		.flags          = IORESOURCE_MEM,
+	},
+	[1] = {
+		.name		= "mmc-irq",
+		.start          = AU1200_SD_INT,
+		.end            = AU1200_SD_INT,
+		.flags          = IORESOURCE_IRQ,
+	},
+	[2] = {
+		.name		= "mmc-dma",
+		.start          = DSCR_CMD0_SDMS_TX1,
+		.end            = DSCR_CMD0_SDMS_RX1,
+		.flags          = IORESOURCE_DMA,
+	},
+};
+
+static struct platform_device au1xxx_mmc1_device = {
+	.name = "au1xxx-mmc",
+	.id = 1,
+	.dev = {
+		.dma_mask               = &au1xxx_mmc_dmamask,
+		.coherent_dma_mask      = 0xffffffff,
+	},
+	.num_resources  = ARRAY_SIZE(au1xxx_mmc1_resources),
+	.resource       = au1xxx_mmc1_resources,
 };
 #endif /* #ifdef CONFIG_SOC_AU1200 */
 
@@ -414,7 +450,8 @@ #ifdef CONFIG_SOC_AU1200
 	&au1xxx_usb_otg_device,
 	&au1200_lcd_device,
 	&au1200_ide0_device,
-	&au1xxx_mmc_device,
+	&au1xxx_mmc0_device,
+	&au1xxx_mmc1_device,
 #endif
 #ifdef CONFIG_MIPS_DB1200
 	&smc91x_device,
diff --git a/drivers/mmc/au1xmmc.c b/drivers/mmc/au1xmmc.c
index 560d6e3..10e8e06 100644
--- a/drivers/mmc/au1xmmc.c
+++ b/drivers/mmc/au1xmmc.c
@@ -44,12 +44,11 @@ #include <linux/dma-mapping.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/protocol.h>
 #include <asm/io.h>
-#include <asm/mach-au1x00/au1000.h>
+#include <au1xxx.h>
 #include <asm/mach-au1x00/au1xxx_dbdma.h>
 #include <asm/mach-au1x00/au1100_mmc.h>
 #include <asm/scatterlist.h>
 
-#include <au1xxx.h>
 #include "au1xmmc.h"
 
 #define DRIVER_NAME "au1xxx-mmc"
@@ -66,25 +65,16 @@ #define info(fmt, idx, args...) printk(K
 					fmt, DRIVER_NAME, idx, ##args)
 
 const struct {
-	u32 iobase;
-	u32 tx_devid, rx_devid;
-	u16 power;
-	u16 status;
-	u16 wpstatus;
+	u32 power;
+	u32 status;
+	u32 wpstatus;
 } au1xmmc_card_table[] = {
-	{ SD0_BASE, DSCR_CMD0_SDMS_TX0, DSCR_CMD0_SDMS_RX0,
-	  BCSR_BOARD_SD0PWR, BCSR_INT_SD0INSERT, BCSR_STATUS_SD0WP },
+	{ BCSR_BOARD_SD0PWR, BCSR_INT_SD0INSERT, BCSR_STATUS_SD0WP },
 #ifndef CONFIG_MIPS_DB1200
-	{ SD1_BASE, DSCR_CMD0_SDMS_TX1, DSCR_CMD0_SDMS_RX1,
-	  BCSR_BOARD_DS1PWR, BCSR_INT_SD1INSERT, BCSR_STATUS_SD1WP }
+	{ BCSR_BOARD_DS1PWR, BCSR_INT_SD1INSERT, BCSR_STATUS_SD1WP }
 #endif
 };
 
-#define AU1XMMC_CONTROLLER_COUNT \
-	(sizeof(au1xmmc_card_table) / sizeof(au1xmmc_card_table[0]))
-
-/* This array stores pointers for the hosts (used by the IRQ handler) */
-struct au1xmmc_host *au1xmmc_hosts[AU1XMMC_CONTROLLER_COUNT];
 static int dma = 1;
 
 #ifdef MODULE
@@ -780,67 +770,64 @@ #define STATUS_DATA_OUT (SD_STATUS_TH)
 
 static irqreturn_t au1xmmc_irq(int irq, void *dev_id, struct pt_regs *regs)
 {
-
+	struct au1xmmc_host *host = dev_id;
 	u32 status;
 	int i, ret = 0;
 
 	disable_irq(AU1100_SD_IRQ);
 
-	for(i = 0; i < AU1XMMC_CONTROLLER_COUNT; i++) {
-		struct au1xmmc_host * host = au1xmmc_hosts[i];
-		u32 handled = 1;
+	u32 handled = 1;
 
-		status = au_readl(HOST_STATUS(host));
+	status = au_readl(HOST_STATUS(host));
 
-		if (host->mrq && (status & STATUS_TIMEOUT)) {
-			if (status & SD_STATUS_RAT)
-				host->mrq->cmd->error = MMC_ERR_TIMEOUT;
+	if (host->mrq && (status & STATUS_TIMEOUT)) {
+		if (status & SD_STATUS_RAT)
+			host->mrq->cmd->error = MMC_ERR_TIMEOUT;
 
-			else if (status & SD_STATUS_DT)
-				host->mrq->data->error = MMC_ERR_TIMEOUT;
+		else if (status & SD_STATUS_DT)
+			host->mrq->data->error = MMC_ERR_TIMEOUT;
 
-			/* In PIO mode, interrupts might still be enabled */
-			IRQ_OFF(host, SD_CONFIG_NE | SD_CONFIG_TH);
+		/* In PIO mode, interrupts might still be enabled */
+		IRQ_OFF(host, SD_CONFIG_NE | SD_CONFIG_TH);
 
-			//IRQ_OFF(host, SD_CONFIG_TH|SD_CONFIG_RA|SD_CONFIG_RF);
-			tasklet_schedule(&host->finish_task);
-		}
+		//IRQ_OFF(host, SD_CONFIG_TH|SD_CONFIG_RA|SD_CONFIG_RF);
+		tasklet_schedule(&host->finish_task);
+	}
 #if 0
-		else if (status & SD_STATUS_DD) {
+	else if (status & SD_STATUS_DD) {
 
-			/* Sometimes we get a DD before a NE in PIO mode */
+		/* Sometimes we get a DD before a NE in PIO mode */
 
-			if (!(host->flags & HOST_F_DMA) &&
-					(status & SD_STATUS_NE))
-				au1xmmc_receive_pio(host);
-			else {
-				au1xmmc_data_complete(host, status);
-				//tasklet_schedule(&host->data_task);
-			}
+		if (!(host->flags & HOST_F_DMA) &&
+				(status & SD_STATUS_NE))
+			au1xmmc_receive_pio(host);
+		else {
+			au1xmmc_data_complete(host, status);
+			//tasklet_schedule(&host->data_task);
 		}
+	}
 #endif
-		else if (status & (SD_STATUS_CR)) {
-			if (host->status == HOST_S_CMD)
-				au1xmmc_cmd_complete(host,status);
-		}
-		else if (!(host->flags & HOST_F_DMA)) {
-			if ((host->flags & HOST_F_XMIT) &&
-			    (status & STATUS_DATA_OUT))
-				au1xmmc_send_pio(host);
-			else if ((host->flags & HOST_F_RECV) &&
-			    (status & STATUS_DATA_IN))
-				au1xmmc_receive_pio(host);
-		}
-		else if (status & 0x203FBC70) {
-			dbg("Unhandled status %8.8x\n", host->id, status);
-			handled = 0;
-		}
+	else if (status & (SD_STATUS_CR)) {
+		if (host->status == HOST_S_CMD)
+			au1xmmc_cmd_complete(host,status);
+	}
+	else if (!(host->flags & HOST_F_DMA)) {
+		if ((host->flags & HOST_F_XMIT) &&
+		    (status & STATUS_DATA_OUT))
+			au1xmmc_send_pio(host);
+		else if ((host->flags & HOST_F_RECV) &&
+		    (status & STATUS_DATA_IN))
+			au1xmmc_receive_pio(host);
+	}
+	else if (status & 0x203FBC70) {
+		dbg("Unhandled status %8.8x\n", host->id, status);
+		handled = 0;
+	}
 
-		au_writel(status, HOST_STATUS(host));
-		au_sync();
+	au_writel(status, HOST_STATUS(host));
+	au_sync();
 
-		ret |= handled;
-	}
+	ret |= handled;
 
 	enable_irq(AU1100_SD_IRQ);
 	return ret;
@@ -875,8 +862,8 @@ static void au1xmmc_init_dma(struct au1x
 
 	u32 rxchan, txchan;
 
-	int txid = au1xmmc_card_table[host->id].tx_devid;
-	int rxid = au1xmmc_card_table[host->id].rx_devid;
+	int txid = host->tx_devid;
+	int rxid = host->rx_devid;
 
 	/* DSCR_CMD0_ALWAYS has a stride of 32 bits, we need a stride
 	   of 8 bits.  And since devices are shared, we need to create
@@ -908,111 +895,152 @@ struct mmc_host_ops au1xmmc_ops = {
 
 static int __devinit au1xmmc_probe(struct platform_device *pdev)
 {
+	struct resource *res;
+	u32 base_addr_phys;
+	void *base_addr;
+	struct mmc_host *mmc;
+	struct au1xmmc_host *host = 0;
+	int irq, tx_devid = 0, rx_devid = 0, ret;
+
+	/* Get the resource info */
+	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mmc-base");
+	if (!res)
+		return -ENODEV;
+	base_addr_phys = res->start;
+	base_addr = ioremap(res->start, res->end - res->start);
+	if (!base_addr) {
+		err("unable to remap phys addr %x\n", pdev->id, base_addr_phys);
+		return -EINVAL;
+	}
 
-	int i, ret = 0;
+	res = platform_get_resource_byname(pdev, IORESOURCE_IRQ, "mmc-irq");
+	if (!res)
+		return -ENODEV;
+	irq = res->start;
+
+	res = platform_get_resource_byname(pdev, IORESOURCE_DMA, "mmc-dma");
+	if (!res)
+		return -ENODEV;
+	tx_devid = res->start;
+	rx_devid = res->end;
+
+	mmc = mmc_alloc_host(sizeof(struct au1xmmc_host), &pdev->dev);
+	if (!mmc) {
+		err("no mem for host\n", pdev->id);
+		return -ENOMEM;
+	}
 
-	/* THe interrupt is shared among all controllers */
-	ret = request_irq(AU1100_SD_IRQ, au1xmmc_irq, IRQF_DISABLED, "MMC", 0);
+	mmc->ops = &au1xmmc_ops;
 
-	if (ret) {
-		err("ERROR: Couldn't get int %d: %d\n",
-				AU1100_SD_IRQ, ret);
-		return -ENXIO;
-	}
+	mmc->f_min =   450000;
+	mmc->f_max = 24000000;
 
-	disable_irq(AU1100_SD_IRQ);
+	mmc->max_seg_size = AU1XMMC_DESCRIPTOR_SIZE;
+	mmc->max_phys_segs = AU1XMMC_DESCRIPTOR_COUNT;
 
-	for(i = 0; i < AU1XMMC_CONTROLLER_COUNT; i++) {
-		struct mmc_host *mmc = mmc_alloc_host(sizeof(struct au1xmmc_host), &pdev->dev);
-		struct au1xmmc_host *host = 0;
+	mmc->ocr_avail = AU1XMMC_OCR;
 
-		if (!mmc) {
-			err("ERROR: no mem for host %d\n", i);
-			au1xmmc_hosts[i] = 0;
-			continue;
-		}
+	host = mmc_priv(mmc);
+	host->mmc = mmc;
 
-		mmc->ops = &au1xmmc_ops;
+	host->id = pdev->id;
+	host->iobase = (u32) base_addr;
+	host->irq = irq;
+	host->tx_devid = tx_devid;
+	host->rx_devid = rx_devid;
+	host->clock = 0;
+	host->power_mode = MMC_POWER_OFF;
 
-		mmc->f_min =   450000;
-		mmc->f_max = 24000000;
+	host->flags = au1xmmc_card_inserted(host) ? HOST_F_ACTIVE : 0;
+	host->status = HOST_S_IDLE;
 
-		mmc->max_seg_size = AU1XMMC_DESCRIPTOR_SIZE;
-		mmc->max_phys_segs = AU1XMMC_DESCRIPTOR_COUNT;
+	init_timer(&host->timer);
 
-		mmc->ocr_avail = AU1XMMC_OCR;
+	host->timer.function = au1xmmc_poll_event;
+	host->timer.data = (unsigned long) host;
+	host->timer.expires = jiffies + AU1XMMC_DETECT_TIMEOUT;
 
-		host = mmc_priv(mmc);
-		host->mmc = mmc;
+	tasklet_init(&host->data_task, au1xmmc_tasklet_data,
+			(unsigned long) host);
 
-		host->id = i;
-		host->iobase = au1xmmc_card_table[host->id].iobase;
-		host->clock = 0;
-		host->power_mode = MMC_POWER_OFF;
+	tasklet_init(&host->finish_task, au1xmmc_tasklet_finish,
+			(unsigned long) host);
 
-		host->flags = au1xmmc_card_inserted(host) ? HOST_F_ACTIVE : 0;
-		host->status = HOST_S_IDLE;
+	spin_lock_init(&host->lock);
 
-		init_timer(&host->timer);
+	if (dma != 0)
+		au1xmmc_init_dma(host);
 
-		host->timer.function = au1xmmc_poll_event;
-		host->timer.data = (unsigned long) host;
-		host->timer.expires = jiffies + AU1XMMC_DETECT_TIMEOUT;
+	au1xmmc_reset_controller(host);
 
-		tasklet_init(&host->data_task, au1xmmc_tasklet_data,
-				(unsigned long) host);
+	mmc_add_host(mmc);
 
-		tasklet_init(&host->finish_task, au1xmmc_tasklet_finish,
-				(unsigned long) host);
+	add_timer(&host->timer);
 
-		spin_lock_init(&host->lock);
+	ret = request_irq(irq, au1xmmc_irq, IRQF_SHARED, "MMC", host);
+	if (ret) {
+		err("couldn't get int %d: %d\n", host->id, irq, ret);
+		ret = -ENXIO;
+		goto exit;
+	}
 
-		if (dma != 0)
-			au1xmmc_init_dma(host);
+	info("MMC controller set up at %x irq %d (mode=%s)\n",
+		host->id, base_addr_phys, host->irq, dma ? "dma" : "pio");
 
-		au1xmmc_reset_controller(host);
+	enable_irq(AU1100_SD_IRQ);
+	platform_set_drvdata(pdev, host);
 
-		mmc_add_host(mmc);
-		au1xmmc_hosts[i] = host;
+	return 0;
 
-		add_timer(&host->timer);
+exit :
+	iounmap(base_addr);
 
-		info("MMC Controller %d set up at %x (mode=%s)\n",
-		       host->id, host->iobase, dma ? "dma" : "pio");
-	}
+	tasklet_kill(&host->data_task);
+	tasklet_kill(&host->finish_task);
 
-	enable_irq(AU1100_SD_IRQ);
+	del_timer_sync(&host->timer);
+	au1xmmc_set_power(host, 0);
 
-	return 0;
+	mmc_remove_host(mmc);
+
+	au1xxx_dbdma_chan_free(host->tx_chan);
+	au1xxx_dbdma_chan_free(host->rx_chan);
+
+	au_writel(0x0, HOST_ENABLE(host));
+	au_sync();
+
+	return ret;
 }
 
 static int __devexit au1xmmc_remove(struct platform_device *pdev)
 {
+	struct au1xmmc_host *host = platform_get_drvdata(pdev);
+	struct mmc_host *mmc = host->mmc;
+	void *base_addr = (void *) host->iobase;
 
-	int i;
+	if (!host)
+		return 0;
 
 	disable_irq(AU1100_SD_IRQ);
 
-	for(i = 0; i < AU1XMMC_CONTROLLER_COUNT; i++) {
-		struct au1xmmc_host *host = au1xmmc_hosts[i];
-		if (!host) continue;
+	tasklet_kill(&host->data_task);
+	tasklet_kill(&host->finish_task);
 
-		tasklet_kill(&host->data_task);
-		tasklet_kill(&host->finish_task);
+	del_timer_sync(&host->timer);
+	au1xmmc_set_power(host, 0);
 
-		del_timer_sync(&host->timer);
-		au1xmmc_set_power(host, 0);
+	mmc_remove_host(mmc);
 
-		mmc_remove_host(host->mmc);
+	au1xxx_dbdma_chan_free(host->tx_chan);
+	au1xxx_dbdma_chan_free(host->rx_chan);
 
-		au1xxx_dbdma_chan_free(host->tx_chan);
-		au1xxx_dbdma_chan_free(host->rx_chan);
+	au_writel(0x0, HOST_ENABLE(host));
+	au_sync();
 
-		au_writel(0x0, HOST_ENABLE(host));
-		au_sync();
-	}
+	free_irq(host->irq, host);
+
+	iounmap(base_addr);
 
-	free_irq(AU1100_SD_IRQ, 0);
 	return 0;
 }
 
diff --git a/drivers/mmc/au1xmmc.h b/drivers/mmc/au1xmmc.h
index 341cbdf..8f7fec1 100644
--- a/drivers/mmc/au1xmmc.h
+++ b/drivers/mmc/au1xmmc.h
@@ -53,6 +53,9 @@ struct au1xmmc_host {
 
   u32 flags;
   u32 iobase;
+  int irq;
+  int tx_devid;
+  int rx_devid;
   u32 clock;
   u32 bus_width;
   u32 power_mode;

--48TaNjbzBVislYPb--
