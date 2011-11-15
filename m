Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Nov 2011 12:26:08 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:43080 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903606Ab1KOL0A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Nov 2011 12:26:00 +0100
Received: by faar25 with SMTP id r25so298364faa.36
        for <multiple recipients>; Tue, 15 Nov 2011 03:25:54 -0800 (PST)
Received: by 10.205.124.144 with SMTP id go16mr15918083bkc.119.1321356354576;
        Tue, 15 Nov 2011 03:25:54 -0800 (PST)
Received: from localhost.localdomain (host86-144-160-143.range86-144.btcentralplus.com. [86.144.160.143])
        by mx.google.com with ESMTPS id c12sm1798887fam.1.2011.11.15.03.25.51
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Nov 2011 03:25:53 -0800 (PST)
From:   Sangwook Lee <sangwook.lee@linaro.org>
To:     linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linux-wireless@vger.kernel.org, ath9k-devel@lists.ath9k.org
Cc:     ralf@linux-mips.org, juhosg@openwrt.org, rodrigue@qca.qualcomm.com,
        linville@tuxdriver.com, rmanohar@qca.qualcomm.com,
        patches@linaro.org, Sangwook Lee <sangwook.lee@linaro.org>
Subject: [PATCH] ath9k: rename ath9k_platform.h to ath_platform.h
Date:   Tue, 15 Nov 2011 11:23:44 +0000
Message-Id: <1321356224-5053-1-git-send-email-sangwook.lee@linaro.org>
X-Mailer: git-send-email 1.7.4.1
X-archive-position: 31602
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sangwook.lee@linaro.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12402

The patch series proposes to rename ath9k_platform.h to "ath_platform.h
This header file handles platform data used only for ath9k,
but it can used by ath6k as well. We can take "wl12xx.h" as
as a example. Please let us change this file name so that
other Atheors WLANs use this file for their own platform data

Signed-off-by: Sangwook Lee <sangwook.lee@linaro.org>
---
 arch/mips/ath79/dev-ar913x-wmac.c                  |    2 +-
 drivers/net/wireless/ath/ath9k/ahb.c               |    2 +-
 drivers/net/wireless/ath/ath9k/init.c              |    2 +-
 drivers/net/wireless/ath/ath9k/pci.c               |    2 +-
 include/linux/{ath9k_platform.h => ath_platform.h} |    0
 5 files changed, 4 insertions(+), 4 deletions(-)
 rename include/linux/{ath9k_platform.h => ath_platform.h} (100%)

diff --git a/arch/mips/ath79/dev-ar913x-wmac.c b/arch/mips/ath79/dev-ar913x-wmac.c
index 48f425a..bc8869c 100644
--- a/arch/mips/ath79/dev-ar913x-wmac.c
+++ b/arch/mips/ath79/dev-ar913x-wmac.c
@@ -13,7 +13,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/platform_device.h>
-#include <linux/ath9k_platform.h>
+#include <linux/ath_platform.h>
 
 #include <asm/mach-ath79/ath79.h>
 #include <asm/mach-ath79/ar71xx_regs.h>
diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
index 85a54cd..d84bee6 100644
--- a/drivers/net/wireless/ath/ath9k/ahb.c
+++ b/drivers/net/wireless/ath/ath9k/ahb.c
@@ -18,7 +18,7 @@
 
 #include <linux/nl80211.h>
 #include <linux/platform_device.h>
-#include <linux/ath9k_platform.h>
+#include <linux/ath_platform.h>
 #include "ath9k.h"
 
 static const struct platform_device_id ath9k_platform_id_table[] = {
diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wireless/ath/ath9k/init.c
index af1b325..0c82aea 100644
--- a/drivers/net/wireless/ath/ath9k/init.c
+++ b/drivers/net/wireless/ath/ath9k/init.c
@@ -16,7 +16,7 @@
 
 #include <linux/dma-mapping.h>
 #include <linux/slab.h>
-#include <linux/ath9k_platform.h>
+#include <linux/ath_platform.h>
 
 #include "ath9k.h"
 
diff --git a/drivers/net/wireless/ath/ath9k/pci.c b/drivers/net/wireless/ath/ath9k/pci.c
index edb0b4b..2f031b8 100644
--- a/drivers/net/wireless/ath/ath9k/pci.c
+++ b/drivers/net/wireless/ath/ath9k/pci.c
@@ -17,7 +17,7 @@
 #include <linux/nl80211.h>
 #include <linux/pci.h>
 #include <linux/pci-aspm.h>
-#include <linux/ath9k_platform.h>
+#include <linux/ath_platform.h>
 #include "ath9k.h"
 
 static DEFINE_PCI_DEVICE_TABLE(ath_pci_id_table) = {
diff --git a/include/linux/ath9k_platform.h b/include/linux/ath_platform.h
similarity index 100%
rename from include/linux/ath9k_platform.h
rename to include/linux/ath_platform.h
-- 
1.7.4.1
