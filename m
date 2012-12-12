Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Dec 2012 02:10:37 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:36929 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6831957Ab2LLBKeYN4UK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Dec 2012 02:10:34 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id CF38C8F67;
        Wed, 12 Dec 2012 02:10:31 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id HO-qkxwLvUy2; Wed, 12 Dec 2012 02:10:18 +0100 (CET)
Received: from hauke-desktop.lan (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 422E98F64;
        Wed, 12 Dec 2012 02:10:17 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     john@phrozen.org, ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org, Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: BCM47XX: fix compile error in wgt634u.c
Date:   Wed, 12 Dec 2012 02:10:12 +0100
Message-Id: <1355274612-19167-1-git-send-email-hauke@hauke-m.de>
X-Mailer: git-send-email 1.7.10.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-archive-position: 35252
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

After the new GPIO handling for the bcm47xx target was introduced
wgt634u.c was not changed.
This patch fixes the following compile error:

arch/mips/bcm47xx/wgt634u.c: In function ‘gpio_interrupt’:
arch/mips/bcm47xx/wgt634u.c:119:2: error: implicit declaration of function ‘gpio_polarity’ [-Werror=implicit-function-declaration]
arch/mips/bcm47xx/wgt634u.c: In function ‘wgt634u_init’:
arch/mips/bcm47xx/wgt634u.c:153:4: error: implicit declaration of function ‘gpio_intmask’ [-Werror=implicit-function-declaration]

Reported-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/bcm47xx/wgt634u.c |    8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

I am planing to remove this entire file, but I haven't come up with 
code adding support for most of the boards found in the wild.

diff --git a/arch/mips/bcm47xx/wgt634u.c b/arch/mips/bcm47xx/wgt634u.c
index e9f9ec8..6c28f6d 100644
--- a/arch/mips/bcm47xx/wgt634u.c
+++ b/arch/mips/bcm47xx/wgt634u.c
@@ -11,6 +11,7 @@
 #include <linux/leds.h>
 #include <linux/mtd/physmap.h>
 #include <linux/ssb/ssb.h>
+#include <linux/ssb/ssb_embedded.h>
 #include <linux/interrupt.h>
 #include <linux/reboot.h>
 #include <linux/gpio.h>
@@ -116,7 +117,8 @@ static irqreturn_t gpio_interrupt(int irq, void *ignored)
 
 	/* Interrupt are level triggered, revert the interrupt polarity
 	   to clear the interrupt. */
-	gpio_polarity(WGT634U_GPIO_RESET, state);
+	ssb_gpio_polarity(&bcm47xx_bus.ssb, 1 << WGT634U_GPIO_RESET,
+			  state ? 1 << WGT634U_GPIO_RESET : 0);
 
 	if (!state) {
 		printk(KERN_INFO "Reset button pressed");
@@ -150,7 +152,9 @@ static int __init wgt634u_init(void)
 				 gpio_interrupt, IRQF_SHARED,
 				 "WGT634U GPIO", &bcm47xx_bus.ssb.chipco)) {
 			gpio_direction_input(WGT634U_GPIO_RESET);
-			gpio_intmask(WGT634U_GPIO_RESET, 1);
+			ssb_gpio_intmask(&bcm47xx_bus.ssb,
+					 1 << WGT634U_GPIO_RESET,
+					 1 << WGT634U_GPIO_RESET);
 			ssb_chipco_irq_mask(&bcm47xx_bus.ssb.chipco,
 					    SSB_CHIPCO_IRQ_GPIO,
 					    SSB_CHIPCO_IRQ_GPIO);
-- 
1.7.10.4
