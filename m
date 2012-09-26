Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Sep 2012 18:16:35 +0200 (CEST)
Received: from zmc.proxad.net ([212.27.53.206]:45517 "EHLO zmc.proxad.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903843Ab2IZQPz (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 26 Sep 2012 18:15:55 +0200
Received: from localhost (localhost [127.0.0.1])
        by zmc.proxad.net (Postfix) with ESMTP id A6104A194F;
        Wed, 26 Sep 2012 18:15:54 +0200 (CEST)
X-Virus-Scanned: amavisd-new at localhost
Received: from zmc.proxad.net ([127.0.0.1])
        by localhost (zmc.proxad.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 3CVK4UqGoaFt; Wed, 26 Sep 2012 18:15:54 +0200 (CEST)
Received: from flexo.iliad.local (freebox.vlq16.iliad.fr [213.36.7.13])
        by zmc.proxad.net (Postfix) with ESMTPSA id 3C1CAA1A64;
        Wed, 26 Sep 2012 18:15:54 +0200 (CEST)
From:   Florian Fainelli <florian@openwrt.org>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Florian Fainelli <florian@openwrt.org>
Subject: [PATCH 2/2] MIPS: BCM63XX: remove "registering %d GPIOs" message
Date:   Wed, 26 Sep 2012 18:15:02 +0200
Message-Id: <1348676102-5651-2-git-send-email-florian@openwrt.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1348676102-5651-1-git-send-email-florian@openwrt.org>
References: <1348676102-5651-1-git-send-email-florian@openwrt.org>
X-archive-position: 34552
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

gpiolib already prints something similar, so let's get rid of this
duplicate message.

Signed-off-by: Florian Fainelli <florian@openwrt.org>
---
 arch/mips/bcm63xx/gpio.c |    1 -
 1 file changed, 1 deletion(-)

diff --git a/arch/mips/bcm63xx/gpio.c b/arch/mips/bcm63xx/gpio.c
index a6c2135..323c9e4 100644
--- a/arch/mips/bcm63xx/gpio.c
+++ b/arch/mips/bcm63xx/gpio.c
@@ -159,7 +159,6 @@ int __init bcm63xx_gpio_init(void)
 	if (!BCMCPU_IS_6345())
 		gpio_out_high = bcm_gpio_readl(GPIO_DATA_HI_REG);
 	bcm63xx_gpio_chip.ngpio = bcm63xx_gpio_count();
-	pr_info("registering %d GPIOs\n", bcm63xx_gpio_chip.ngpio);
 
 	return gpiochip_add(&bcm63xx_gpio_chip);
 }
-- 
1.7.9.5
