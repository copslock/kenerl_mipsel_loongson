Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Jan 2014 19:01:19 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:47260 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6821116AbaABSBRWsq0r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Jan 2014 19:01:17 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 63C848F61;
        Thu,  2 Jan 2014 19:01:16 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id ak09ejjYT2nQ; Thu,  2 Jan 2014 19:01:13 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 4416D857F;
        Thu,  2 Jan 2014 19:01:13 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, blogic@openwrt.org
Cc:     linux-mips@linux-mips.org, zajec5@gmail.com,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] bcma: prevent irq handler from firing when registered
Date:   Thu,  2 Jan 2014 19:01:08 +0100
Message-Id: <1388685668-19616-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 38838
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

With this patch we prevent the irq from being fired when it is
registered. The Hardware fires an IRQ when input signal XOR polarity
AND gpio mask is 1. Now we are setting polarity to a vlaue so that is
is 0 when we register it.

In addition we also set the irq mask register to 0 when the irq handler
is initialized, so all gpio irqs are masked and there will be no
unexpected irq.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
Tested-by: Rafał Miłecki <zajec5@gmail.com>
---
 drivers/bcma/driver_gpio.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index ec422a9..c2728a0 100644
--- a/drivers/bcma/driver_gpio.c
+++ b/drivers/bcma/driver_gpio.c
@@ -91,7 +91,9 @@ static void bcma_gpio_irq_unmask(struct irq_data *d)
 {
 	struct bcma_drv_cc *cc = irq_data_get_irq_chip_data(d);
 	int gpio = irqd_to_hwirq(d);
+	u32 val = bcma_chipco_gpio_in(cc, BIT(gpio));
 
+	bcma_chipco_gpio_polarity(cc, BIT(gpio), val);
 	bcma_chipco_gpio_intmask(cc, BIT(gpio), BIT(gpio));
 }
 
@@ -156,6 +158,7 @@ static int bcma_gpio_irq_domain_init(struct bcma_drv_cc *cc)
 	if (err)
 		goto err_req_irq;
 
+	bcma_chipco_gpio_intmask(cc, ~0, 0);
 	bcma_cc_set32(cc, BCMA_CC_IRQMASK, BCMA_CC_IRQ_GPIO);
 
 	return 0;
-- 
1.7.10.4
