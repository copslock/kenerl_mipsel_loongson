Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 02:18:05 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:36987 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831966Ab2LLBRsQtH8q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 02:17:48 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id EC3508F65;
        Wed, 12 Dec 2012 02:17:47 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id BTL5a0ziM33t; Wed, 12 Dec 2012 02:17:22 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 8717C8F64;
        Wed, 12 Dec 2012 02:17:20 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 1/2] bcma: add gpio_to_irq again
Date:   Wed, 12 Dec 2012 02:17:10 +0100
Message-Id: <1355275031-19297-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
X-archive-position: 35254
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

The old code had support for gpio_to_irq, but the new code did not
provide this function, but returned -ENXIO all the time. This patch
adds the missing function.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/bcma/driver_gpio.c |   11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/bcma/driver_gpio.c b/drivers/bcma/driver_gpio.c
index 9a6f585..212fda6 100644
--- a/drivers/bcma/driver_gpio.c
+++ b/drivers/bcma/driver_gpio.c
@@ -73,6 +73,16 @@ static void bcma_gpio_free(struct gpio_chip *chip, unsigned gpio)
 	bcma_chipco_gpio_pullup(cc, 1 << gpio, 0);
 }
 
+static int bcma_gpio_to_irq(struct gpio_chip *chip, unsigned gpio)
+{
+	struct bcma_drv_cc *cc = bcma_gpio_get_cc(chip);
+
+	if (cc->core->bus->hosttype == BCMA_HOSTTYPE_SOC)
+		return bcma_core_mips_irq(cc->core) + 2;
+	else
+		return -EINVAL;
+}
+
 int bcma_gpio_init(struct bcma_drv_cc *cc)
 {
 	struct gpio_chip *chip = &cc->gpio;
@@ -85,6 +95,7 @@ int bcma_gpio_init(struct bcma_drv_cc *cc)
 	chip->set		= bcma_gpio_set_value;
 	chip->direction_input	= bcma_gpio_direction_input;
 	chip->direction_output	= bcma_gpio_direction_output;
+	chip->to_irq		= bcma_gpio_to_irq;
 	chip->ngpio		= 16;
 	/* There is just one SoC in one device and its GPIO addresses should be
 	 * deterministic to address them more easily. The other buses could get
-- 
1.7.10.4
