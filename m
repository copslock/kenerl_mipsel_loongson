Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 15:03:54 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:55024 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022860AbZFCOCd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 15:02:33 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id E6A54112408D; Wed,  3 Jun 2009 16:02:27 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 3/8] bcm63xx: fix gpio set.
Date:	Wed,  3 Jun 2009 16:02:22 +0200
Message-Id: <1244037747-27144-4-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
References: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

Previously set gpio value can not be read back from register, we're
reading pin value instead. Keep cached value and always use it.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/gpio.c |   13 ++++++++-----
 1 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/arch/mips/bcm63xx/gpio.c b/arch/mips/bcm63xx/gpio.c
index 97e3730..77636aa 100644
--- a/arch/mips/bcm63xx/gpio.c
+++ b/arch/mips/bcm63xx/gpio.c
@@ -18,12 +18,14 @@
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
 
+static u32 gpio_out_low, gpio_out_high;
+
 static void bcm63xx_gpio_set(struct gpio_chip *chip,
 				unsigned gpio, int val)
 {
 	u32 reg;
 	u32 mask;
-	u32 tmp;
+	u32 *v;
 	unsigned long flags;
 
 	if (gpio >= chip->ngpio)
@@ -32,18 +34,19 @@ static void bcm63xx_gpio_set(struct gpio_chip *chip,
 	if (gpio < 32) {
 		reg = GPIO_DATA_LO_REG;
 		mask = 1 << gpio;
+		v = &gpio_out_low;
 	} else {
 		reg = GPIO_DATA_HI_REG;
 		mask = 1 << (gpio - 32);
+		v = &gpio_out_high;
 	}
 
 	local_irq_save(flags);
-	tmp = bcm_gpio_readl(reg);
 	if (val)
-		tmp |= mask;
+		*v |= mask;
 	else
-		tmp &= ~mask;
-	bcm_gpio_writel(tmp, reg);
+		*v &= ~mask;
+	bcm_gpio_writel(*v, reg);
 	local_irq_restore(flags);
 }
 
-- 
1.6.0.4
