Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2012 00:25:26 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45562 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825936Ab2KTXZBNCVCz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2012 00:25:01 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id CC9FB8F6C;
        Wed, 21 Nov 2012 00:25:00 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id AaFEj7yMmhfh; Wed, 21 Nov 2012 00:24:55 +0100 (CET)
Received: from hauke-desktop.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 767448F62;
        Wed, 21 Nov 2012 00:24:40 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        florian@openwrt.org, zajec5@gmail.com, m@bues.ch,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 2/8] bcma: add bcma_chipco_gpio_pull{up,down}
Date:   Wed, 21 Nov 2012 00:24:28 +0100
Message-Id: <1353453874-523-3-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1353453874-523-1-git-send-email-hauke@hauke-m.de>
References: <1353453874-523-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35065
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

Add functions to access the GPIO registers for pullup and pulldown.
These are needed for handling gpio registration.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/driver_chipcommon.c            |   30 +++++++++++++++++++++++++++
 include/linux/bcma/bcma_driver_chipcommon.h |    2 ++
 2 files changed, 32 insertions(+)

diff --git a/drivers/bcma/driver_chipcommon.c b/drivers/bcma/driver_chipcommon.c
index c9b63d9..0945383 100644
--- a/drivers/bcma/driver_chipcommon.c
+++ b/drivers/bcma/driver_chipcommon.c
@@ -145,6 +145,36 @@ u32 bcma_chipco_gpio_polarity(struct bcma_drv_cc *cc, u32 mask, u32 value)
 	return res;
 }
 
+u32 bcma_chipco_gpio_pullup(struct bcma_drv_cc *cc, u32 mask, u32 value)
+{
+	unsigned long flags;
+	u32 res;
+
+	if (cc->core->id.rev < 20)
+		return 0;
+
+	spin_lock_irqsave(&cc->gpio_lock, flags);
+	res = bcma_cc_write32_masked(cc, BCMA_CC_GPIOPULLUP, mask, value);
+	spin_unlock_irqrestore(&cc->gpio_lock, flags);
+
+	return res;
+}
+
+u32 bcma_chipco_gpio_pulldown(struct bcma_drv_cc *cc, u32 mask, u32 value)
+{
+	unsigned long flags;
+	u32 res;
+
+	if (cc->core->id.rev < 20)
+		return 0;
+
+	spin_lock_irqsave(&cc->gpio_lock, flags);
+	res = bcma_cc_write32_masked(cc, BCMA_CC_GPIOPULLDOWN, mask, value);
+	spin_unlock_irqrestore(&cc->gpio_lock, flags);
+
+	return res;
+}
+
 #ifdef CONFIG_BCMA_DRIVER_MIPS
 void bcma_chipco_serial_init(struct bcma_drv_cc *cc)
 {
diff --git a/include/linux/bcma/bcma_driver_chipcommon.h b/include/linux/bcma/bcma_driver_chipcommon.h
index a085d98..2567026 100644
--- a/include/linux/bcma/bcma_driver_chipcommon.h
+++ b/include/linux/bcma/bcma_driver_chipcommon.h
@@ -606,6 +606,8 @@ u32 bcma_chipco_gpio_outen(struct bcma_drv_cc *cc, u32 mask, u32 value);
 u32 bcma_chipco_gpio_control(struct bcma_drv_cc *cc, u32 mask, u32 value);
 u32 bcma_chipco_gpio_intmask(struct bcma_drv_cc *cc, u32 mask, u32 value);
 u32 bcma_chipco_gpio_polarity(struct bcma_drv_cc *cc, u32 mask, u32 value);
+u32 bcma_chipco_gpio_pullup(struct bcma_drv_cc *cc, u32 mask, u32 value);
+u32 bcma_chipco_gpio_pulldown(struct bcma_drv_cc *cc, u32 mask, u32 value);
 
 /* PMU support */
 extern void bcma_pmu_init(struct bcma_drv_cc *cc);
-- 
1.7.10.4
