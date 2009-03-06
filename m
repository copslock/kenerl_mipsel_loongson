Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Mar 2009 16:22:49 +0000 (GMT)
Received: from mx1.rmicorp.com ([63.111.213.197]:35445 "EHLO mx1.rmicorp.com")
	by ftp.linux-mips.org with ESMTP id S21366487AbZCFQUV (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 6 Mar 2009 16:20:21 +0000
Received: from sark.razamicroelectronics.com ([10.8.0.254]) by mx1.rmicorp.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 6 Mar 2009 08:20:09 -0800
Received: from localhost.localdomain (unknown [10.8.0.23])
	by sark.razamicroelectronics.com (Postfix) with ESMTP id D573CEE76AA;
	Fri,  6 Mar 2009 09:42:10 -0600 (CST)
From:	Kevin Hickey <khickey@rmicorp.com>
To:	ralf@linux-mips.org, linux-mips@linux-mips.org
Cc:	Kevin Hickey <khickey@rmicorp.com>
Subject: [PATCH 05/10] Alchemy: Au1300/DB1300 MMC support
Date:	Fri,  6 Mar 2009 10:20:04 -0600
Message-Id: <394c116b9fa5bd1865ac21d11185f09e07bd2ab5.1236354153.git.khickey@rmicorp.com>
X-Mailer: git-send-email 1.5.4.3
In-Reply-To: <0946334bbaf9883076889fe060a362b72d31e6f4.1236354153.git.khickey@rmicorp.com>
References: <>
 <1236356409-32357-1-git-send-email-khickey@rmicorp.com>
 <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
 <0b447f7e26be90a9179bdf89ca2cfd1f34c5d16e.1236354153.git.khickey@rmicorp.com>
 <7afc5c84989c4bc0f94181397369f284f2bb6924.1236354153.git.khickey@rmicorp.com>
 <0946334bbaf9883076889fe060a362b72d31e6f4.1236354153.git.khickey@rmicorp.com>
In-Reply-To: <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
References: <788248524efc28ba2608ed79bfb7080ee476b12d.1236354153.git.khickey@rmicorp.com>
X-OriginalArrivalTime: 06 Mar 2009 16:20:09.0903 (UTC) FILETIME=[6B864BF0:01C99E77]
Return-Path: <khickey@rmicorp.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22023
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: khickey@rmicorp.com
Precedence: bulk
X-list: linux-mips

Supports the MMC/SD controller on Au1300 and the single slot on the DB1300
board.

Signed-off-by: Kevin Hickey <khickey@rmicorp.com>
---
 arch/mips/alchemy/devboards/db1300/mmc.c |  154 ++++++++++++++++++++++++++++++
 drivers/mmc/host/Kconfig                 |    2 +-
 drivers/mmc/host/au1xmmc.c               |   18 ++--
 3 files changed, 164 insertions(+), 10 deletions(-)
 create mode 100644 arch/mips/alchemy/devboards/db1300/mmc.c

diff --git a/arch/mips/alchemy/devboards/db1300/mmc.c b/arch/mips/alchemy/devboards/db1300/mmc.c
new file mode 100644
index 0000000..821658c
--- /dev/null
+++ b/arch/mips/alchemy/devboards/db1300/mmc.c
@@ -0,0 +1,154 @@
+/*
+ * Copyright 2003-2008 RMI Corporation. All rights reserved.
+ * Author: Kevin Hickey <khickey@rmicorp.com>
+ *
+ *  This program is free software; you can redistribute  it and/or modify it
+ *  under  the terms of  the GNU General  Public License as published by the
+ *  Free Software Foundation;  either version 2 of the  License, or (at your
+ *  option) any later version.
+ *
+ * THIS SOFTWARE IS PROVIDED BY RMI Corporation 'AS IS' AND ANY EXPRESS OR
+ * IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
+ * OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN
+ * NO EVENT SHALL RMI OR CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT,
+ * INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
+ * NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
+ * DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
+ * THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
+ * (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
+ * THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
+ *
+ *  You should have received a copy of the  GNU General Public License along
+ *  with this program; if not, write  to the Free Software Foundation, Inc.,
+ *  675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#include <linux/leds.h>
+#include <linux/platform_device.h>
+#include <asm/mips-boards/db1300.h>
+#include <asm/mach-au1x00/au1100_mmc.h>
+#include <asm/mach-au1x00/au1xxx_dbdma.h>
+#include <linux/dma-mapping.h>
+
+static volatile struct bcsr_regs *const bcsr =
+	(struct bcsr_regs *)(DB1300_BCSR_REGS_PHYS_ADDR + KSEG1_OFFSET);
+
+static int mmc_activity;
+static u64 au1xxx_mmc_dmamask =  DMA_32BIT_MASK;
+
+
+static void db1300_mmcled_set(struct led_classdev *led,
+                       enum led_brightness brightness)
+{
+       if (brightness != LED_OFF) {
+               if (++mmc_activity == 1)
+                       bcsr->disk_leds &= ~(1 << 8);
+       } else {
+               if (--mmc_activity == 0)
+                       bcsr->disk_leds |= (1 << 8);
+       }
+}
+
+static struct led_classdev db1300mmc_led = {
+       .brightness_set = db1300_mmcled_set,
+};
+
+
+static int db1300mmc1_card_readonly(void *mmc_host)
+{
+       return (bcsr->status & BCSR_STATUS_SD1_WP) ? 1 : 0;
+}
+
+static int db1300mmc1_card_inserted(void *mmc_host)
+{
+	int retval;
+	retval =  (bcsr->sig_status & BCSR_INT_SD1_INSERT) ? 1 : 0;
+	return retval;
+}
+
+struct au1xmmc_platform_data au1xmmc_platdata[2] = {
+       [0] = {
+               .set_power      = NULL,
+               .card_inserted  = NULL,
+               .card_readonly  = NULL,
+               .cd_setup       = NULL,         /* use poll-timer in driver */
+               .led            = &db1300mmc_led,
+       },
+       [1] = {
+               .set_power      = NULL,
+               .card_inserted  = db1300mmc1_card_inserted,
+               .card_readonly  = db1300mmc1_card_readonly,
+               .cd_setup       = NULL,         /* use poll-timer in driver */
+               .led            = &db1300mmc_led,
+       },
+};
+
+static struct resource au13xx_mmc0_resources[] = {
+       [0] = {
+               .start          = SD0_PHYS_ADDR,
+               .end            = SD0_PHYS_ADDR + 0x7ffff,
+               .flags          = IORESOURCE_MEM,
+       },
+       [1] = {
+               .start          = AU1300_IRQ_SD0 + GPINT_LINUX_IRQ_OFFSET,
+               .end            = AU1300_IRQ_SD0 + GPINT_LINUX_IRQ_OFFSET,
+               .flags          = IORESOURCE_IRQ,
+       },
+       [2] = {
+               .start          = DSCR_CMD0_SDMS_TX0,
+               .end            = DSCR_CMD0_SDMS_TX0,
+               .flags          = IORESOURCE_DMA,
+       },
+       [3] = {
+               .start          = DSCR_CMD0_SDMS_RX0,
+               .end            = DSCR_CMD0_SDMS_RX0,
+               .flags          = IORESOURCE_DMA,
+       }
+};
+
+struct platform_device au13xx_mmc0_device = {
+	.name = "au1xxx-mmc",
+	.id = 0,
+	.dev = {
+		.dma_mask               = &au1xxx_mmc_dmamask,
+		.coherent_dma_mask      = DMA_32BIT_MASK,
+		.platform_data          = &au1xmmc_platdata[0],
+	},
+	.num_resources  = ARRAY_SIZE(au13xx_mmc0_resources),
+	.resource       = au13xx_mmc0_resources,
+};
+
+static struct resource au13xx_mmc1_resources[] = {
+       [0] = {
+               .start          = SD1_PHYS_ADDR,
+               .end            = SD1_PHYS_ADDR + 0x7ffff,
+               .flags          = IORESOURCE_MEM,
+       },
+       [1] = {
+               .start          = AU1300_IRQ_SD1 + GPINT_LINUX_IRQ_OFFSET,
+               .end            = AU1300_IRQ_SD1 + GPINT_LINUX_IRQ_OFFSET,
+               .flags          = IORESOURCE_IRQ,
+       },
+       [2] = {
+               .start          = DSCR_CMD0_SDMS_TX1,
+               .end            = DSCR_CMD0_SDMS_TX1,
+               .flags          = IORESOURCE_DMA,
+       },
+       [3] = {
+               .start          = DSCR_CMD0_SDMS_RX1,
+               .end            = DSCR_CMD0_SDMS_RX1,
+               .flags          = IORESOURCE_DMA,
+       }
+};
+
+struct platform_device au13xx_mmc1_device = {
+       .name = "au1xxx-mmc",
+       .id = 1,
+       .dev = {
+               .dma_mask               = &au1xxx_mmc_dmamask,
+               .coherent_dma_mask      = DMA_32BIT_MASK,
+               .platform_data          = &au1xmmc_platdata[1],
+       },
+       .num_resources  = ARRAY_SIZE(au13xx_mmc1_resources),
+       .resource       = au13xx_mmc1_resources,
+};
diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
index 99d4b28..a37bfee 100644
--- a/drivers/mmc/host/Kconfig
+++ b/drivers/mmc/host/Kconfig
@@ -99,7 +99,7 @@ config MMC_WBSD
 
 config MMC_AU1X
 	tristate "Alchemy AU1XX0 MMC Card Interface support"
-	depends on SOC_AU1200
+	depends on (SOC_AU1200 || SOC_AU13XX)
 	help
 	  This selects the AMD Alchemy(R) Multimedia card interface.
 	  If you have a Alchemy platform with a MMC slot, say Y or M here.
diff --git a/drivers/mmc/host/au1xmmc.c b/drivers/mmc/host/au1xmmc.c
index d3f5561..a3b8ac7 100644
--- a/drivers/mmc/host/au1xmmc.c
+++ b/drivers/mmc/host/au1xmmc.c
@@ -353,7 +353,7 @@ static void au1xmmc_data_complete(struct au1xmmc_host *host, u32 status)
 
 	if (!data->error) {
 		if (host->flags & HOST_F_DMA) {
-#ifdef CONFIG_SOC_AU1200	/* DBDMA */
+#if defined(CONFIG_SOC_AU1200) || defined(CONFIG_SOC_AU13XX)	/* DBDMA */
 			u32 chan = DMA_CHANNEL(host);
 
 			chan_tab_t *c = *((chan_tab_t **)chan);
@@ -570,7 +570,7 @@ static void au1xmmc_cmd_complete(struct au1xmmc_host *host, u32 status)
 	host->status = HOST_S_DATA;
 
 	if (host->flags & HOST_F_DMA) {
-#ifdef CONFIG_SOC_AU1200	/* DBDMA */
+#if defined(CONFIG_SOC_AU1200) || defined(CONFIG_SOC_AU13XX)	/* DBDMA */
 		u32 channel = DMA_CHANNEL(host);
 
 		/* Start the DMA as soon as the buffer gets something in it */
@@ -633,7 +633,7 @@ static int au1xmmc_prepare_data(struct au1xmmc_host *host,
 	au_writel(data->blksz - 1, HOST_BLKSIZE(host));
 
 	if (host->flags & HOST_F_DMA) {
-#ifdef CONFIG_SOC_AU1200	/* DBDMA */
+#if defined(CONFIG_SOC_AU1200) || defined(CONFIG_SOC_AU13XX)	/* DBDMA */
 		int i;
 		u32 channel = DMA_CHANNEL(host);
 
@@ -837,7 +837,7 @@ static irqreturn_t au1xmmc_irq(int irq, void *dev_id)
 	return IRQ_HANDLED;
 }
 
-#ifdef CONFIG_SOC_AU1200
+#if defined(CONFIG_SOC_AU1200) || defined(CONFIG_SOC_AU13XX)
 /* 8bit memory DMA device */
 static dbdev_tab_t au1xmmc_mem_dbdev = {
 	.dev_id		= DSCR_CMD0_ALWAYS,
@@ -1023,7 +1023,7 @@ static int __devinit au1xmmc_probe(struct platform_device *pdev)
 	tasklet_init(&host->finish_task, au1xmmc_tasklet_finish,
 			(unsigned long)host);
 
-#ifdef CONFIG_SOC_AU1200
+#if defined(CONFIG_SOC_AU1200) || defined(CONFIG_SOC_AU13XX)
 	ret = au1xmmc_dbdma_init(host);
 	if (ret)
 		printk(KERN_INFO DRIVER_NAME ": DBDMA init failed; using PIO\n");
@@ -1068,7 +1068,7 @@ out5:
 	au_writel(0, HOST_CONFIG2(host));
 	au_sync();
 
-#ifdef CONFIG_SOC_AU1200
+#if defined(CONFIG_SOC_AU1200) || defined(CONFIG_SOC_AU13XX)
 	au1xmmc_dbdma_shutdown(host);
 #endif
 
@@ -1115,7 +1115,7 @@ static int __devexit au1xmmc_remove(struct platform_device *pdev)
 		tasklet_kill(&host->data_task);
 		tasklet_kill(&host->finish_task);
 
-#ifdef CONFIG_SOC_AU1200
+#if defined(CONFIG_SOC_AU1200) || defined(CONFIG_SOC_AU13XX)
 		au1xmmc_dbdma_shutdown(host);
 #endif
 		au1xmmc_set_power(host, 0);
@@ -1176,7 +1176,7 @@ static struct platform_driver au1xmmc_driver = {
 
 static int __init au1xmmc_init(void)
 {
-#ifdef CONFIG_SOC_AU1200
+#if defined(CONFIG_SOC_AU1200) || defined(CONFIG_SOC_AU13XX)
 	/* DSCR_CMD0_ALWAYS has a stride of 32 bits, we need a stride
 	 * of 8 bits.  And since devices are shared, we need to create
 	 * our own to avoid freaking out other devices.
@@ -1190,7 +1190,7 @@ static int __init au1xmmc_init(void)
 
 static void __exit au1xmmc_exit(void)
 {
-#ifdef CONFIG_SOC_AU1200
+#if defined(CONFIG_SOC_AU1200) || defined(CONFIG_SOC_AU13XX)
 	if (memid)
 		au1xxx_ddma_del_device(memid);
 #endif
-- 
1.5.4.3
