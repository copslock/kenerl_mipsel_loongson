Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Mar 2011 20:56:15 +0100 (CET)
Received: from mail.perches.com ([173.55.12.10]:4260 "EHLO mail.perches.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491891Ab1CWTzw (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 23 Mar 2011 20:55:52 +0100
Received: from Joe-Laptop.home (unknown [192.168.1.162])
        by mail.perches.com (Postfix) with ESMTP id DB7912436B;
        Wed, 23 Mar 2011 11:55:31 -0800 (PST)
From:   Joe Perches <joe@perches.com>
To:     Jiri Kosina <trivial@kernel.org>,
        Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
        Linus Walleij <linus.walleij@stericsson.com>,
        David Brown <davidb@codeaurora.org>,
        Daniel Walker <dwalker@fifo99.com>,
        Bryan Huntsman <bryanh@codeaurora.org>,
        Wim Van Sebroeck <wim@iguana.be>
Cc:     Russell King <linux@arm.linux.org.uk>,
        Ralf Baechle <ralf@linux-mips.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@linux-mips.org, linux-arm-msm@vger.kernel.org,
        linux-fbdev@vger.kernel.org, linux-watchdog@vger.kernel.org
Subject: [trivial PATCH 1/2] treewide: Fix iomap resource size miscalculations
Date:   Wed, 23 Mar 2011 12:55:36 -0700
Message-Id: <c4422b4a8ee132d3adac95fd86237c61b2f8b364.1300909446.git.joe@perches.com>
X-Mailer: git-send-email 1.7.4.2.g597a6.dirty
In-Reply-To: <cover.1300909445.git.joe@perches.com>
References: <cover.1300909445.git.joe@perches.com>
Return-Path: <joe@perches.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29426
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: joe@perches.com
Precedence: bulk
X-list: linux-mips

Convert off-by-1 r->end - r->start to resource_size(r)

Signed-off-by: Joe Perches <joe@perches.com>
---
 arch/arm/mach-ux500/mbox-db5500.c |    6 ++----
 arch/mips/rb532/gpio.c            |    2 +-
 drivers/video/msm/mddi.c          |    2 +-
 drivers/watchdog/bcm63xx_wdt.c    |    2 +-
 4 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/arch/arm/mach-ux500/mbox-db5500.c b/arch/arm/mach-ux500/mbox-db5500.c
index a4ffb9f..2b2d51c 100644
--- a/arch/arm/mach-ux500/mbox-db5500.c
+++ b/arch/arm/mach-ux500/mbox-db5500.c
@@ -416,8 +416,7 @@ struct mbox *mbox_setup(u8 mbox_id, mbox_recv_cb_t *mbox_cb, void *priv)
 	dev_dbg(&(mbox->pdev->dev),
 		"Resource name: %s start: 0x%X, end: 0x%X\n",
 		resource->name, resource->start, resource->end);
-	mbox->virtbase_peer =
-		ioremap(resource->start, resource->end - resource->start);
+	mbox->virtbase_peer = ioremap(resource->start, resource_size(resource));
 	if (!mbox->virtbase_peer) {
 		dev_err(&(mbox->pdev->dev), "Unable to ioremap peer mbox\n");
 		mbox = NULL;
@@ -440,8 +439,7 @@ struct mbox *mbox_setup(u8 mbox_id, mbox_recv_cb_t *mbox_cb, void *priv)
 	dev_dbg(&(mbox->pdev->dev),
 		"Resource name: %s start: 0x%X, end: 0x%X\n",
 		resource->name, resource->start, resource->end);
-	mbox->virtbase_local =
-		ioremap(resource->start, resource->end - resource->start);
+	mbox->virtbase_local = ioremap(resource->start, resource_size(resource));
 	if (!mbox->virtbase_local) {
 		dev_err(&(mbox->pdev->dev), "Unable to ioremap local mbox\n");
 		mbox = NULL;
diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index 37de05d..6c47dfe 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -185,7 +185,7 @@ int __init rb532_gpio_init(void)
 	struct resource *r;
 
 	r = rb532_gpio_reg0_res;
-	rb532_gpio_chip->regbase = ioremap_nocache(r->start, r->end - r->start);
+	rb532_gpio_chip->regbase = ioremap_nocache(r->start, resource_size(r));
 
 	if (!rb532_gpio_chip->regbase) {
 		printk(KERN_ERR "rb532: cannot remap GPIO register 0\n");
diff --git a/drivers/video/msm/mddi.c b/drivers/video/msm/mddi.c
index b66d86a..178b072 100644
--- a/drivers/video/msm/mddi.c
+++ b/drivers/video/msm/mddi.c
@@ -679,7 +679,7 @@ static int __devinit mddi_probe(struct platform_device *pdev)
 		printk(KERN_ERR "mddi: no associated mem resource!\n");
 		return -ENOMEM;
 	}
-	mddi->base = ioremap(resource->start, resource->end - resource->start);
+	mddi->base = ioremap(resource->start, resource_size(resource));
 	if (!mddi->base) {
 		printk(KERN_ERR "mddi: failed to remap base!\n");
 		ret = -EINVAL;
diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
index 3c5045a..5064e83 100644
--- a/drivers/watchdog/bcm63xx_wdt.c
+++ b/drivers/watchdog/bcm63xx_wdt.c
@@ -248,7 +248,7 @@ static int __devinit bcm63xx_wdt_probe(struct platform_device *pdev)
 		return -ENODEV;
 	}
 
-	bcm63xx_wdt_device.regs = ioremap_nocache(r->start, r->end - r->start);
+	bcm63xx_wdt_device.regs = ioremap_nocache(r->start, resource_size(r));
 	if (!bcm63xx_wdt_device.regs) {
 		dev_err(&pdev->dev, "failed to remap I/O resources\n");
 		return -ENXIO;
-- 
1.7.4.2.g597a6.dirty
