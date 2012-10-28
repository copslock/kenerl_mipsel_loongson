Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2012 13:50:41 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:56726 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823121Ab2J1MukNO2IE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Oct 2012 13:50:40 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so1438738bkw.36
        for <multiple recipients>; Sun, 28 Oct 2012 05:50:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=vXewmzsOTJpETxXLjqSauqm6FkM2kLqI9lrqbcd4WO4=;
        b=hBgBGEvpPlE8DqXBzKK3JjrMr6tObrCjEX9H3kAazuVmTl1QH3MX/FIGE6vzaweQoU
         c1gdo1ViLE4T5mcUUMzM6Jq36h9hNJxssfdsGgSZ7KB6+xwEHbst8m+VCfy5t9oBMQLV
         4/FZRjVE2oyj3mt1EshX861o9EpvZLzRqS68r9wMlkY7f1kAOzAQ8fzkltRM38NV5Lik
         Rm8eaQi2U5HL9lisJskjSVa5FlJWNY9IZ/HPZSp8jI6dJLDif4JQrCV+uWt0yiIatck0
         AXMeqIoAdcldR6nnBWwqhYgQxq9Ag0cySD1PlWC9rhO62YNFt7x5XoSLsJUGYdGSVBjU
         IDOg==
Received: by 10.204.7.88 with SMTP id c24mr8563518bkc.118.1351428634703;
        Sun, 28 Oct 2012 05:50:34 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id fm5sm2560095bkc.5.2012.10.28.05.50.33
        (version=SSLv3 cipher=OTHER);
        Sun, 28 Oct 2012 05:50:33 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH] MIPS: BCM63XX: add and use a clock for PCIe
Date:   Sun, 28 Oct 2012 13:49:53 +0100
Message-Id: <1351428593-13355-1-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 34782
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski@gmail.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Add a PCIe clock and use that instead of directly touching the clock
control register. While at it, fail if there is no such clock.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/clk.c     |   15 +++++++++++++++
 arch/mips/pci/pci-bcm63xx.c |   15 ++++++++++-----
 2 files changed, 25 insertions(+), 5 deletions(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index dff79ab..89a5fb0 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -253,6 +253,19 @@ static struct clk clk_ipsec = {
 };
 
 /*
+ * PCIe clock
+ */
+
+static void pcie_set(struct clk *clk, int enable)
+{
+	bcm_hwclock_set(CKCTL_6328_PCIE_EN, enable);
+}
+
+static struct clk clk_pcie = {
+	.set	= pcie_set,
+};
+
+/*
  * Internal peripheral clock
  */
 static struct clk clk_periph = {
@@ -313,6 +326,8 @@ struct clk *clk_get(struct device *dev, const char *id)
 		return &clk_pcm;
 	if (BCMCPU_IS_6368() && !strcmp(id, "ipsec"))
 		return &clk_ipsec;
+	if (BCMCPU_IS_6328() && !strcmp(id, "pcie"))
+		return &clk_pcie;
 	return ERR_PTR(-ENOENT);
 }
 
diff --git a/arch/mips/pci/pci-bcm63xx.c b/arch/mips/pci/pci-bcm63xx.c
index 8a48139..fa8c320 100644
--- a/arch/mips/pci/pci-bcm63xx.c
+++ b/arch/mips/pci/pci-bcm63xx.c
@@ -11,6 +11,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/delay.h>
+#include <linux/clk.h>
 #include <asm/bootinfo.h>
 
 #include "pci-bcm63xx.h"
@@ -119,11 +120,6 @@ static void __init bcm63xx_reset_pcie(void)
 {
 	u32 val;
 
-	/* enable clock */
-	val = bcm_perf_readl(PERF_CKCTL_REG);
-	val |= CKCTL_6328_PCIE_EN;
-	bcm_perf_writel(val, PERF_CKCTL_REG);
-
 	/* enable SERDES */
 	val = bcm_misc_readl(MISC_SERDES_CTRL_REG);
 	val |= SERDES_PCIE_EN | SERDES_PCIE_EXD_EN;
@@ -150,10 +146,19 @@ static void __init bcm63xx_reset_pcie(void)
 	mdelay(200);
 }
 
+static struct clk *pcie_clk;
+
 static int __init bcm63xx_register_pcie(void)
 {
 	u32 val;
 
+	/* enable clock */
+	pcie_clk = clk_get(NULL, "pcie");
+	if (IS_ERR_OR_NULL(pcie_clk))
+		return -ENODEV;
+
+	clk_prepare_enable(pcie_clk);
+
 	bcm63xx_reset_pcie();
 
 	/* configure the PCIe bridge */
-- 
1.7.2.5
