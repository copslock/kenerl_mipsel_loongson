Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 02:17:48 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:36983 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831957Ab2LLBRrqCH0m (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 02:17:47 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 1174F8F69;
        Wed, 12 Dec 2012 02:17:46 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id c84WLB66ot6v; Wed, 12 Dec 2012 02:17:24 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 1812F8F65;
        Wed, 12 Dec 2012 02:17:22 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, linux-wireless@vger.kernel.org,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH 2/2] ssb: add gpio_to_irq again
Date:   Wed, 12 Dec 2012 02:17:11 +0100
Message-Id: <1355275031-19297-2-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1355275031-19297-1-git-send-email-hauke@hauke-m.de>
References: <1355275031-19297-1-git-send-email-hauke@hauke-m.de>
X-archive-position: 35253
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

arch/mips/bcm47xx/wgt634u.c calls gpio_to_irq() and got the correct irq
number with the old gpio handling code. With this patch the code in
wgt634u.c should work again. I do not have a wgt634u to test this.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 drivers/ssb/driver_gpio.c |   22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
index 97ac0a3..accabe3 100644
--- a/drivers/ssb/driver_gpio.c
+++ b/drivers/ssb/driver_gpio.c
@@ -74,6 +74,16 @@ static void ssb_gpio_chipco_free(struct gpio_chip *chip, unsigned gpio)
 	ssb_chipco_gpio_pullup(&bus->chipco, 1 << gpio, 0);
 }
 
+static int ssb_gpio_chipco_to_irq(struct gpio_chip *chip, unsigned gpio)
+{
+	struct ssb_bus *bus = ssb_gpio_get_bus(chip);
+
+	if (bus->bustype == SSB_BUSTYPE_SSB)
+		return ssb_mips_irq(bus->chipco.dev) + 2;
+	else
+		return -EINVAL;
+}
+
 static int ssb_gpio_chipco_init(struct ssb_bus *bus)
 {
 	struct gpio_chip *chip = &bus->gpio;
@@ -86,6 +96,7 @@ static int ssb_gpio_chipco_init(struct ssb_bus *bus)
 	chip->set		= ssb_gpio_chipco_set_value;
 	chip->direction_input	= ssb_gpio_chipco_direction_input;
 	chip->direction_output	= ssb_gpio_chipco_direction_output;
+	chip->to_irq		= ssb_gpio_chipco_to_irq;
 	chip->ngpio		= 16;
 	/* There is just one SoC in one device and its GPIO addresses should be
 	 * deterministic to address them more easily. The other buses could get
@@ -134,6 +145,16 @@ static int ssb_gpio_extif_direction_output(struct gpio_chip *chip,
 	return 0;
 }
 
+static int ssb_gpio_extif_to_irq(struct gpio_chip *chip, unsigned gpio)
+{
+	struct ssb_bus *bus = ssb_gpio_get_bus(chip);
+
+	if (bus->bustype == SSB_BUSTYPE_SSB)
+		return ssb_mips_irq(bus->extif.dev) + 2;
+	else
+		return -EINVAL;
+}
+
 static int ssb_gpio_extif_init(struct ssb_bus *bus)
 {
 	struct gpio_chip *chip = &bus->gpio;
@@ -144,6 +165,7 @@ static int ssb_gpio_extif_init(struct ssb_bus *bus)
 	chip->set		= ssb_gpio_extif_set_value;
 	chip->direction_input	= ssb_gpio_extif_direction_input;
 	chip->direction_output	= ssb_gpio_extif_direction_output;
+	chip->to_irq		= ssb_gpio_extif_to_irq;
 	chip->ngpio		= 5;
 	/* There is just one SoC in one device and its GPIO addresses should be
 	 * deterministic to address them more easily. The other buses could get
-- 
1.7.10.4
