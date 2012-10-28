Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 28 Oct 2012 14:18:39 +0100 (CET)
Received: from mail-bk0-f49.google.com ([209.85.214.49]:59878 "EHLO
        mail-bk0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823124Ab2J1NSVFpV90 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 28 Oct 2012 14:18:21 +0100
Received: by mail-bk0-f49.google.com with SMTP id j4so1441542bkw.36
        for <multiple recipients>; Sun, 28 Oct 2012 06:18:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=lLsLSsszVtj8hbyzwwyvazVk9TlIoQHJFDPuOEi64h8=;
        b=Szk4JPcg1pp3aQsdogFAFzbGvbNJLpaTXoiSYmfn+9FiqwrSCcq1vgt/Fq9qqKZUVB
         x0cWCHlVl+lia3me99I4ERRWuNeTMzJdKnL+P1J35gv57EDVQuVCTrDDtCYVKuVrJrkd
         oM11cDmO8Et3PWlhxF86mhEvleMn8gybn2b5fjJksut+oLRfcDCIlK4OdbxNH/BCi2uT
         TlPE87/ANp2sYpMngt/XOfsWvOEczDzMNZ3eNF9Z1qowYsOBtuPImkV30ztwhRcjiLt6
         UX8NamGWnbRl8u0BVE94K1/7VLlBRDD5XewGLuXrdtRv9ZVBQEI/kYZtGuwakeTUK3wy
         3Xpg==
Received: by 10.204.149.135 with SMTP id t7mr8330340bkv.103.1351430300860;
        Sun, 28 Oct 2012 06:18:20 -0700 (PDT)
Received: from shaker64.lan (dslb-088-073-158-247.pools.arcor-ip.net. [88.73.158.247])
        by mx.google.com with ESMTPS id j24sm2575695bkv.0.2012.10.28.06.18.19
        (version=SSLv3 cipher=OTHER);
        Sun, 28 Oct 2012 06:18:20 -0700 (PDT)
From:   Jonas Gorski <jonas.gorski@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <blogic@openwrt.org>,
        Maxime Bizon <mbizon@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>,
        Kevin Cernekee <cernekee@gmail.com>
Subject: [PATCH 3/3] MIPS: BCM63XX: use the new reset helper
Date:   Sun, 28 Oct 2012 14:17:55 +0100
Message-Id: <1351430275-14509-4-git-send-email-jonas.gorski@gmail.com>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1351430275-14509-1-git-send-email-jonas.gorski@gmail.com>
References: <1351430275-14509-1-git-send-email-jonas.gorski@gmail.com>
X-archive-position: 34784
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

Use the new reset helper where appropriate.

Signed-off-by: Jonas Gorski <jonas.gorski@gmail.com>
---
 arch/mips/bcm63xx/clk.c     |   19 +++++--------------
 arch/mips/pci/pci-bcm63xx.c |   19 ++++++-------------
 2 files changed, 11 insertions(+), 27 deletions(-)

diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
index 89a5fb0..b9e948d 100644
--- a/arch/mips/bcm63xx/clk.c
+++ b/arch/mips/bcm63xx/clk.c
@@ -14,6 +14,7 @@
 #include <bcm63xx_cpu.h>
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
+#include <bcm63xx_reset.h>
 #include <bcm63xx_clk.h>
 
 static DEFINE_MUTEX(clocks_mutex);
@@ -124,15 +125,10 @@ static void enetsw_set(struct clk *clk, int enable)
 			CKCTL_6368_SWPKT_USB_EN |
 			CKCTL_6368_SWPKT_SAR_EN, enable);
 	if (enable) {
-		u32 val;
-
 		/* reset switch core afer clock change */
-		val = bcm_perf_readl(PERF_SOFTRESET_6368_REG);
-		val &= ~SOFTRESET_6368_ENETSW_MASK;
-		bcm_perf_writel(val, PERF_SOFTRESET_6368_REG);
+		bcm63xx_core_set_reset(BCM63XX_RESET_ENETSW, 1);
 		msleep(10);
-		val |= SOFTRESET_6368_ENETSW_MASK;
-		bcm_perf_writel(val, PERF_SOFTRESET_6368_REG);
+		bcm63xx_core_set_reset(BCM63XX_RESET_ENETSW, 0);
 		msleep(10);
 	}
 }
@@ -222,15 +218,10 @@ static void xtm_set(struct clk *clk, int enable)
 			CKCTL_6368_SWPKT_SAR_EN, enable);
 
 	if (enable) {
-		u32 val;
-
 		/* reset sar core afer clock change */
-		val = bcm_perf_readl(PERF_SOFTRESET_6368_REG);
-		val &= ~SOFTRESET_6368_SAR_MASK;
-		bcm_perf_writel(val, PERF_SOFTRESET_6368_REG);
+		bcm63xx_core_set_reset(BCM63XX_RESET_SAR, 1);
 		mdelay(1);
-		val |= SOFTRESET_6368_SAR_MASK;
-		bcm_perf_writel(val, PERF_SOFTRESET_6368_REG);
+		bcm63xx_core_set_reset(BCM63XX_RESET_SAR, 0);
 		mdelay(1);
 	}
 }
diff --git a/arch/mips/pci/pci-bcm63xx.c b/arch/mips/pci/pci-bcm63xx.c
index fa8c320..ca179b6 100644
--- a/arch/mips/pci/pci-bcm63xx.c
+++ b/arch/mips/pci/pci-bcm63xx.c
@@ -14,6 +14,8 @@
 #include <linux/clk.h>
 #include <asm/bootinfo.h>
 
+#include <bcm63xx_reset.h>
+
 #include "pci-bcm63xx.h"
 
 /*
@@ -126,23 +128,14 @@ static void __init bcm63xx_reset_pcie(void)
 	bcm_misc_writel(val, MISC_SERDES_CTRL_REG);
 
 	/* reset the PCIe core */
-	val = bcm_perf_readl(PERF_SOFTRESET_6328_REG);
-
-	val &= ~SOFTRESET_6328_PCIE_MASK;
-	val &= ~SOFTRESET_6328_PCIE_CORE_MASK;
-	val &= ~SOFTRESET_6328_PCIE_HARD_MASK;
-	val &= ~SOFTRESET_6328_PCIE_EXT_MASK;
-	bcm_perf_writel(val, PERF_SOFTRESET_6328_REG);
+	bcm63xx_core_set_reset(BCM63XX_RESET_PCIE, 1);
+	bcm63xx_core_set_reset(BCM63XX_RESET_PCIE_EXT, 1);
 	mdelay(10);
 
-	val |= SOFTRESET_6328_PCIE_MASK;
-	val |= SOFTRESET_6328_PCIE_CORE_MASK;
-	val |= SOFTRESET_6328_PCIE_HARD_MASK;
-	bcm_perf_writel(val, PERF_SOFTRESET_6328_REG);
+	bcm63xx_core_set_reset(BCM63XX_RESET_PCIE, 0);
 	mdelay(10);
 
-	val |= SOFTRESET_6328_PCIE_EXT_MASK;
-	bcm_perf_writel(val, PERF_SOFTRESET_6328_REG);
+	bcm63xx_core_set_reset(BCM63XX_RESET_PCIE_EXT, 0);
 	mdelay(200);
 }
 
-- 
1.7.2.5
