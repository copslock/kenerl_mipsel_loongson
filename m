Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Sep 2011 15:43:15 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:50310 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491874Ab1IUNkf (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 21 Sep 2011 15:40:35 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id BF9F232D673;
        Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id WiYMPuFrE6BS; Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
Received: from flexo.priv.staff.proxad.net (bobafett.staff.proxad.net [213.228.1.121])
        by zmc.proxad.net (Postfix) with ESMTPSA id 72B5E32D67D;
        Wed, 21 Sep 2011 15:40:33 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <ffainelli@freebox.fr>,
        Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 5/5] MIPS: bcm63xx: fix GPIO set/get for BCM6345
Date:   Wed, 21 Sep 2011 15:39:50 +0200
Message-Id: <1316612390-6367-8-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.4.1
In-Reply-To: <1316612390-6367-1-git-send-email-florian@openwrt.org>
References: <1316612390-6367-1-git-send-email-florian@openwrt.org>
X-archive-position: 31121
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 11656

From: Florian Fainelli <ffainelli@freebox.fr>

On BCM6345, the register offsets for the set/get GPIO registers is wrong
in order not add more complexity, use the HI_* variants for BCM6345
which results in reading/writing from/to the right register offsets.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/gpio.c |   18 ++++++++++++++----
 1 files changed, 14 insertions(+), 4 deletions(-)

diff --git a/arch/mips/bcm63xx/gpio.c b/arch/mips/bcm63xx/gpio.c
index f560fe7..154353f 100644
--- a/arch/mips/bcm63xx/gpio.c
+++ b/arch/mips/bcm63xx/gpio.c
@@ -4,7 +4,7 @@
  * for more details.
  *
  * Copyright (C) 2008 Maxime Bizon <mbizon@freebox.fr>
- * Copyright (C) 2008 Florian Fainelli <florian@openwrt.org>
+ * Copyright (C) 2008-2011 Florian Fainelli <florian@openwrt.org>
  */
 
 #include <linux/kernel.h>
@@ -33,7 +33,10 @@ static void bcm63xx_gpio_set(struct gpio_chip *chip,
 		BUG();
 
 	if (gpio < 32) {
-		reg = GPIO_DATA_LO_REG;
+		if (!BCMCPU_IS_6345())
+			reg = GPIO_DATA_LO_REG;
+		else
+			reg = GPIO_DATA_HI_REG;
 		mask = 1 << gpio;
 		v = &gpio_out_low;
 	} else {
@@ -60,7 +63,10 @@ static int bcm63xx_gpio_get(struct gpio_chip *chip, unsigned gpio)
 		BUG();
 
 	if (gpio < 32) {
-		reg = GPIO_DATA_LO_REG;
+		if (!BCMCPU_IS_6345())
+			reg = GPIO_DATA_LO_REG;
+		else
+			reg = GPIO_DATA_HI_REG;
 		mask = 1 << gpio;
 	} else {
 		reg = GPIO_DATA_HI_REG;
@@ -125,7 +131,11 @@ static struct gpio_chip bcm63xx_gpio_chip = {
 
 int __init bcm63xx_gpio_init(void)
 {
-	gpio_out_low = bcm_gpio_readl(GPIO_DATA_LO_REG);
+	if (!BCMCPU_IS_6345())
+		gpio_out_low = bcm_gpio_readl(GPIO_DATA_LO_REG);
+	else
+		gpio_out_low = bcm_gpio_readl(GPIO_DATA_HI_REG);
+
 	gpio_out_high = bcm_gpio_readl(GPIO_DATA_HI_REG);
 	bcm63xx_gpio_chip.ngpio = bcm63xx_gpio_count();
 	pr_info("registering %d GPIOs\n", bcm63xx_gpio_chip.ngpio);
-- 
1.7.4.1
