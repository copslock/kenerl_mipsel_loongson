Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 12 Apr 2011 18:10:20 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:58429 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491065Ab1DLQJq (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 12 Apr 2011 18:09:46 +0200
From:   John Crispin <blogic@openwrt.org>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <blogic@openwrt.org>,
        Ralph Hempel <ralph.hempel@lantiq.com>,
        linux-mips@linux-mips.org
Subject: [PATCH 3/3] MIPS: lantiq: add dma/etop board support
Date:   Tue, 12 Apr 2011 18:11:15 +0200
Message-Id: <1302624675-18652-4-git-send-email-blogic@openwrt.org>
X-Mailer: git-send-email 1.7.2.3
In-Reply-To: <1302624675-18652-1-git-send-email-blogic@openwrt.org>
References: <1302624675-18652-1-git-send-email-blogic@openwrt.org>
Return-Path: <blogic@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29739
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: blogic@openwrt.org
Precedence: bulk
X-list: linux-mips

This patch adds functions to register the etop and dma platform devices and
calls them from the board specific setup code.

Signed-off-by: John Crispin <blogic@openwrt.org>
Signed-off-by: Ralph Hempel <ralph.hempel@lantiq.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/lantiq/devices.c             |   13 +++++++++++++
 arch/mips/lantiq/devices.h             |    1 +
 arch/mips/lantiq/xway/devices.c        |   27 +++++++++++++++++++++++++++
 arch/mips/lantiq/xway/devices.h        |    1 +
 arch/mips/lantiq/xway/mach-easy50712.c |   10 ++++++++++
 5 files changed, 52 insertions(+), 0 deletions(-)

diff --git a/arch/mips/lantiq/devices.c b/arch/mips/lantiq/devices.c
index e758863..a10244e 100644
--- a/arch/mips/lantiq/devices.c
+++ b/arch/mips/lantiq/devices.c
@@ -31,6 +31,19 @@
 #define IRQ_RES(resname, irq) \
 	{.name = #resname, .start = (irq), .flags = IORESOURCE_IRQ}
 
+/* dma engine */
+static struct resource ltq_dma_resource = {
+	.name	= "dma",
+	.start	= LTQ_DMA_BASE_ADDR,
+	.end	= LTQ_DMA_BASE_ADDR + LTQ_DMA_SIZE - 1,
+	.flags  = IORESOURCE_MEM,
+};
+
+void __init ltq_register_dma(void)
+{
+	platform_device_register_simple("ltq_dma", 0, &ltq_dma_resource, 1);
+}
+
 /* nor flash */
 static struct resource ltq_nor_resource = {
 	.name	= "nor",
diff --git a/arch/mips/lantiq/devices.h b/arch/mips/lantiq/devices.h
index 069006c..d339963 100644
--- a/arch/mips/lantiq/devices.h
+++ b/arch/mips/lantiq/devices.h
@@ -12,6 +12,7 @@
 #include <lantiq_platform.h>
 #include <linux/mtd/physmap.h>
 
+extern void ltq_register_dma(void);
 extern void ltq_register_nor(struct physmap_flash_data *data);
 extern void ltq_register_wdt(void);
 extern void ltq_register_asc(int port);
diff --git a/arch/mips/lantiq/xway/devices.c b/arch/mips/lantiq/xway/devices.c
index 7d58ae5..99ff2ef 100644
--- a/arch/mips/lantiq/xway/devices.c
+++ b/arch/mips/lantiq/xway/devices.c
@@ -75,3 +75,30 @@ void __init ltq_register_gpio_stp(void)
 {
 	platform_device_register_simple("ltq_stp", 0, &ltq_stp_resource, 1);
 }
+
+/* ethernet */
+static struct resource ltq_ethernet_resources = {
+	.name   = "etop",
+	.start  = LTQ_ETOP_BASE_ADDR,
+	.end    = LTQ_ETOP_BASE_ADDR + LTQ_ETOP_SIZE - 1,
+	.flags  = IORESOURCE_MEM,
+};
+
+static struct platform_device ltq_ethernet = {
+	.name = "ltq_etop",
+	.resource = &ltq_ethernet_resources,
+	.num_resources  = 1,
+};
+
+void __init
+ltq_register_ethernet(struct ltq_eth_data *eth)
+{
+	if (!eth)
+		return;
+	if (!is_valid_ether_addr(eth->mac.sa_data)) {
+		pr_warn("etop: invalid MAC, using random\n");
+		random_ether_addr(eth->mac.sa_data);
+	}
+	ltq_ethernet.dev.platform_data = eth;
+	platform_device_register(&ltq_ethernet);
+}
diff --git a/arch/mips/lantiq/xway/devices.h b/arch/mips/lantiq/xway/devices.h
index 87ba61e..2095c3a 100644
--- a/arch/mips/lantiq/xway/devices.h
+++ b/arch/mips/lantiq/xway/devices.h
@@ -13,5 +13,6 @@
 
 extern void ltq_register_gpio(void);
 extern void ltq_register_gpio_stp(void);
+extern void ltq_register_ethernet(struct ltq_eth_data *eth);
 
 #endif
diff --git a/arch/mips/lantiq/xway/mach-easy50712.c b/arch/mips/lantiq/xway/mach-easy50712.c
index 5242a27..f69460c 100644
--- a/arch/mips/lantiq/xway/mach-easy50712.c
+++ b/arch/mips/lantiq/xway/mach-easy50712.c
@@ -59,13 +59,23 @@ static struct ltq_pci_data ltq_pci_data = {
 	},
 };
 
+static struct ltq_eth_data ltq_eth_data = {
+	.mii_mode = REV_MII_MODE,
+	.channel = {
+		[1] = 1,
+		[6] = 1,
+	},
+};
+
 static void __init easy50712_init(void)
 {
+	ltq_register_dma();
 	ltq_register_gpio();
 	ltq_register_gpio_stp();
 	ltq_register_nor(&easy50712_flash_data);
 	ltq_register_wdt();
 	ltq_register_pci(&ltq_pci_data);
+	ltq_register_ethernet(&ltq_eth_data);
 }
 
 MIPS_MACHINE(LTQ_MACH_EASY50712,
-- 
1.7.2.3
