Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 31 Jan 2012 18:21:37 +0100 (CET)
Received: from zmc.proxad.net ([212.27.53.206]:57811 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1904033Ab2AaRTb (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 31 Jan 2012 18:19:31 +0100
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id 9F02144775B;
        Tue, 31 Jan 2012 18:19:30 +0100 (CET)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 6hXin7x7tuyv; Tue, 31 Jan 2012 18:19:30 +0100 (CET)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 092A3448589;
        Tue, 31 Jan 2012 18:19:30 +0100 (CET)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 3/6] MIPS: TXX9: use IS_ENABLED() macro
Date:   Tue, 31 Jan 2012 18:19:05 +0100
Message-Id: <1328030348-21967-4-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.5.4
In-Reply-To: <1328030348-21967-1-git-send-email-florian@openwrt.org>
References: <1328030348-21967-1-git-send-email-florian@openwrt.org>
X-archive-position: 32371
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/txx9/generic/setup.c        |   12 +++++-------
 arch/mips/txx9/generic/setup_tx4939.c |    2 +-
 arch/mips/txx9/rbtx4939/setup.c       |   11 +++++------
 3 files changed, 11 insertions(+), 14 deletions(-)

diff --git a/arch/mips/txx9/generic/setup.c b/arch/mips/txx9/generic/setup.c
index ae77a79..560fe89 100644
--- a/arch/mips/txx9/generic/setup.c
+++ b/arch/mips/txx9/generic/setup.c
@@ -632,7 +632,7 @@ void __init txx9_physmap_flash_init(int no, unsigned long addr,
 				    unsigned long size,
 				    const struct physmap_flash_data *pdata)
 {
-#if defined(CONFIG_MTD_PHYSMAP) || defined(CONFIG_MTD_PHYSMAP_MODULE)
+#if IS_ENABLED(CONFIG_MTD_PHYSMAP)
 	struct resource res = {
 		.start = addr,
 		.end = addr + size - 1,
@@ -670,8 +670,7 @@ void __init txx9_physmap_flash_init(int no, unsigned long addr,
 void __init txx9_ndfmc_init(unsigned long baseaddr,
 			    const struct txx9ndfmc_platform_data *pdata)
 {
-#if defined(CONFIG_MTD_NAND_TXX9NDFMC) || \
-	defined(CONFIG_MTD_NAND_TXX9NDFMC_MODULE)
+#if IS_ENABLED(CONFIG_MTD_NAND_TXX9NDFMC)
 	struct resource res = {
 		.start = baseaddr,
 		.end = baseaddr + 0x1000 - 1,
@@ -687,7 +686,7 @@ void __init txx9_ndfmc_init(unsigned long baseaddr,
 #endif
 }
 
-#if defined(CONFIG_LEDS_GPIO) || defined(CONFIG_LEDS_GPIO_MODULE)
+#if IS_ENABLED(CONFIG_LEDS_GPIO)
 static DEFINE_SPINLOCK(txx9_iocled_lock);
 
 #define TXX9_IOCLED_MAXLEDS 8
@@ -810,7 +809,7 @@ void __init txx9_iocled_init(unsigned long baseaddr,
 void __init txx9_dmac_init(int id, unsigned long baseaddr, int irq,
 			   const struct txx9dmac_platform_data *pdata)
 {
-#if defined(CONFIG_TXX9_DMAC) || defined(CONFIG_TXX9_DMAC_MODULE)
+#if IS_ENABLED(CONFIG_TXX9_DMAC)
 	struct resource res[] = {
 		{
 			.start = baseaddr,
@@ -866,8 +865,7 @@ void __init txx9_aclc_init(unsigned long baseaddr, int irq,
 			   unsigned int dma_chan_out,
 			   unsigned int dma_chan_in)
 {
-#if defined(CONFIG_SND_SOC_TXX9ACLC) || \
-	defined(CONFIG_SND_SOC_TXX9ACLC_MODULE)
+#if IS_ENABLED(CONFIG_SND_SOC_TXX9ACLC)
 	unsigned int dma_base = dmac_id * TXX9_DMA_MAX_NR_CHANNELS;
 	struct resource res[] = {
 		{
diff --git a/arch/mips/txx9/generic/setup_tx4939.c b/arch/mips/txx9/generic/setup_tx4939.c
index 6567895..5ff7a95 100644
--- a/arch/mips/txx9/generic/setup_tx4939.c
+++ b/arch/mips/txx9/generic/setup_tx4939.c
@@ -317,7 +317,7 @@ void __init tx4939_sio_init(unsigned int sclk, unsigned int cts_mask)
 	}
 }
 
-#if defined(CONFIG_TC35815) || defined(CONFIG_TC35815_MODULE)
+#if IS_ENABLED(CONFIG_TC35815)
 static u32 tx4939_get_eth_speed(struct net_device *dev)
 {
 	struct ethtool_cmd cmd;
diff --git a/arch/mips/txx9/rbtx4939/setup.c b/arch/mips/txx9/rbtx4939/setup.c
index 2ad8973..e15641d 100644
--- a/arch/mips/txx9/rbtx4939/setup.c
+++ b/arch/mips/txx9/rbtx4939/setup.c
@@ -40,8 +40,7 @@ static void __init rbtx4939_time_init(void)
 	tx4939_time_init(0);
 }
 
-#if defined(__BIG_ENDIAN) && \
-	(defined(CONFIG_SMC91X) || defined(CONFIG_SMC91X_MODULE))
+#if defined(__BIG_ENDIAN) && IS_ENABLED(CONFIG_SMC91X)
 #define HAVE_RBTX4939_IOSWAB
 #define IS_CE1_ADDR(addr) \
 	((((unsigned long)(addr) - IO_BASE) & 0xfff00000) == TXX9_CE(1))
@@ -187,7 +186,7 @@ static void __init rbtx4939_update_ioc_pen(void)
 
 #define RBTX4939_MAX_7SEGLEDS	8
 
-#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
+#if IS_ENABLED(CONFIG_LEDS_CLASS)
 static u8 led_val[RBTX4939_MAX_7SEGLEDS];
 struct rbtx4939_led_data {
 	struct led_classdev cdev;
@@ -263,7 +262,7 @@ static inline void rbtx4939_led_setup(void)
 
 static void __rbtx4939_7segled_putc(unsigned int pos, unsigned char val)
 {
-#if defined(CONFIG_LEDS_CLASS) || defined(CONFIG_LEDS_CLASS_MODULE)
+#if IS_ENABLED(CONFIG_LEDS_CLASS)
 	unsigned long flags;
 	local_irq_save(flags);
 	/* bit7: reserved for LED class */
@@ -287,7 +286,7 @@ static void rbtx4939_7segled_putc(unsigned int pos, unsigned char val)
 	__rbtx4939_7segled_putc(pos, val);
 }
 
-#if defined(CONFIG_MTD_RBTX4939) || defined(CONFIG_MTD_RBTX4939_MODULE)
+#if IS_ENABLED(CONFIG_MTD_RBTX4939)
 /* special mapping for boot rom */
 static unsigned long rbtx4939_flash_fixup_ofs(unsigned long ofs)
 {
@@ -463,7 +462,7 @@ static void __init rbtx4939_device_init(void)
 		.flags = SMC91X_USE_16BIT,
 	};
 	struct platform_device *pdev;
-#if defined(CONFIG_TC35815) || defined(CONFIG_TC35815_MODULE)
+#if IS_ENABLED(CONFIG_TC35815)
 	int i, j;
 	unsigned char ethaddr[2][6];
 	u8 bdipsw = readb(rbtx4939_bdipsw_addr) & 0x0f;
-- 
1.7.5.4
