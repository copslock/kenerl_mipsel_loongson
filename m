Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Nov 2012 00:24:50 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:45537 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6825923Ab2KTXYtonhEI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Nov 2012 00:24:49 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 003C38F69;
        Wed, 21 Nov 2012 00:24:48 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id DQbRCufJikvc; Wed, 21 Nov 2012 00:24:40 +0100 (CET)
Received: from hauke-desktop.lan (unknown [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id EEDF68F61;
        Wed, 21 Nov 2012 00:24:39 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        florian@openwrt.org, zajec5@gmail.com, m@bues.ch,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH v3 1/8] bcma: add locking around GPIO register accesses
Date:   Wed, 21 Nov 2012 00:24:27 +0100
Message-Id: <1353453874-523-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1353453874-523-1-git-send-email-hauke@hauke-m.de>
References: <1353453874-523-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35063
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

The GPIOs are access through some registers in the chip common core.
We need locking around these GPIO accesses, all GPIOs are accessed
through the same registers and parallel writes will cause problems.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/driver_chipcommon.c            |   47 ++++++++++++++++++++++++---
 include/linux/bcma/bcma_driver_chipcommon.h |    3 ++
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/bcma/driver_chipcommon.c b/drivers/bcma/driver_chipcommon.c
index a4c3ebc..c9b63d9 100644
--- a/drivers/bcma/driver_chipcommon.c
+++ b/drivers/bcma/driver_chipcommon.c
@@ -30,6 +30,8 @@ void bcma_core_chipcommon_init(struct bcma_drv_cc *cc)
 	if (cc->setup_done)
 		return;
 
+	spin_lock_init(&cc->gpio_lock);
+
 	if (cc->core->id.rev >= 11)
 		cc->status = bcma_cc_read32(cc, BCMA_CC_CHIPSTAT);
 	cc->capabilities = bcma_cc_read32(cc, BCMA_CC_CAP);
@@ -84,28 +86,63 @@ u32 bcma_chipco_gpio_in(struct bcma_drv_cc *cc, u32 mask)
 
 u32 bcma_chipco_gpio_out(struct bcma_drv_cc *cc, u32 mask, u32 value)
 {
-	return bcma_cc_write32_masked(cc, BCMA_CC_GPIOOUT, mask, value);
+	unsigned long flags;
+	u32 res;
+
+	spin_lock_irqsave(&cc->gpio_lock, flags);
+	res = bcma_cc_write32_masked(cc, BCMA_CC_GPIOOUT, mask, value);
+	spin_unlock_irqrestore(&cc->gpio_lock, flags);
+
+	return res;
 }
 
 u32 bcma_chipco_gpio_outen(struct bcma_drv_cc *cc, u32 mask, u32 value)
 {
-	return bcma_cc_write32_masked(cc, BCMA_CC_GPIOOUTEN, mask, value);
+	unsigned long flags;
+	u32 res;
+
+	spin_lock_irqsave(&cc->gpio_lock, flags);
+	res = bcma_cc_write32_masked(cc, BCMA_CC_GPIOOUTEN, mask, value);
+	spin_unlock_irqrestore(&cc->gpio_lock, flags);
+
+	return res;
 }
 
 u32 bcma_chipco_gpio_control(struct bcma_drv_cc *cc, u32 mask, u32 value)
 {
-	return bcma_cc_write32_masked(cc, BCMA_CC_GPIOCTL, mask, value);
+	unsigned long flags;
+	u32 res;
+
+	spin_lock_irqsave(&cc->gpio_lock, flags);
+	res = bcma_cc_write32_masked(cc, BCMA_CC_GPIOCTL, mask, value);
+	spin_unlock_irqrestore(&cc->gpio_lock, flags);
+
+	return res;
 }
 EXPORT_SYMBOL_GPL(bcma_chipco_gpio_control);
 
 u32 bcma_chipco_gpio_intmask(struct bcma_drv_cc *cc, u32 mask, u32 value)
 {
-	return bcma_cc_write32_masked(cc, BCMA_CC_GPIOIRQ, mask, value);
+	unsigned long flags;
+	u32 res;
+
+	spin_lock_irqsave(&cc->gpio_lock, flags);
+	res = bcma_cc_write32_masked(cc, BCMA_CC_GPIOIRQ, mask, value);
+	spin_unlock_irqrestore(&cc->gpio_lock, flags);
+
+	return res;
 }
 
 u32 bcma_chipco_gpio_polarity(struct bcma_drv_cc *cc, u32 mask, u32 value)
 {
-	return bcma_cc_write32_masked(cc, BCMA_CC_GPIOPOL, mask, value);
+	unsigned long flags;
+	u32 res;
+
+	spin_lock_irqsave(&cc->gpio_lock, flags);
+	res = bcma_cc_write32_masked(cc, BCMA_CC_GPIOPOL, mask, value);
+	spin_unlock_irqrestore(&cc->gpio_lock, flags);
+
+	return res;
 }
 
 #ifdef CONFIG_BCMA_DRIVER_MIPS
diff --git a/include/linux/bcma/bcma_driver_chipcommon.h b/include/linux/bcma/bcma_driver_chipcommon.h
index 1cf1749..a085d98 100644
--- a/include/linux/bcma/bcma_driver_chipcommon.h
+++ b/include/linux/bcma/bcma_driver_chipcommon.h
@@ -567,6 +567,9 @@ struct bcma_drv_cc {
 	int nr_serial_ports;
 	struct bcma_serial_port serial_ports[4];
 #endif /* CONFIG_BCMA_DRIVER_MIPS */
+
+	/* Lock for GPIO register access. */
+	spinlock_t gpio_lock;
 };
 
 /* Register access */
-- 
1.7.10.4
