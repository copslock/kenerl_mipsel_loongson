Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Jun 2009 15:03:30 +0100 (WEST)
Received: from sakura.staff.proxad.net ([213.228.1.107]:55026 "EHLO
	sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
	by ftp.linux-mips.org with ESMTP id S20022862AbZFCOCd (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 3 Jun 2009 15:02:33 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
	id E058C1124090; Wed,  3 Jun 2009 16:02:27 +0200 (CEST)
From:	Maxime Bizon <mbizon@freebox.fr>
To:	linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Cc:	Florian Fainelli <florian@openwrt.org>,
	Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 4/8] bcm63xx: restore spinlock in gpio.
Date:	Wed,  3 Jun 2009 16:02:23 +0200
Message-Id: <1244037747-27144-5-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.0.4
In-Reply-To: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
References: <1244037747-27144-1-git-send-email-mbizon@freebox.fr>
Return-Path: <max@sakura.staff.proxad.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 23211
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips

gpiolib does not do any locking around chip callbacks, local_irq_save
is enough for now but try to stay future-proof.

Fix indentation too.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/gpio.c |   15 ++++++++-------
 1 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/arch/mips/bcm63xx/gpio.c b/arch/mips/bcm63xx/gpio.c
index 77636aa..53e4664 100644
--- a/arch/mips/bcm63xx/gpio.c
+++ b/arch/mips/bcm63xx/gpio.c
@@ -18,10 +18,11 @@
 #include <bcm63xx_io.h>
 #include <bcm63xx_regs.h>
 
+static DEFINE_SPINLOCK(bcm63xx_gpio_lock);
 static u32 gpio_out_low, gpio_out_high;
 
 static void bcm63xx_gpio_set(struct gpio_chip *chip,
-				unsigned gpio, int val)
+			     unsigned gpio, int val)
 {
 	u32 reg;
 	u32 mask;
@@ -41,13 +42,13 @@ static void bcm63xx_gpio_set(struct gpio_chip *chip,
 		v = &gpio_out_high;
 	}
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&bcm63xx_gpio_lock, flags);
 	if (val)
 		*v |= mask;
 	else
 		*v &= ~mask;
 	bcm_gpio_writel(*v, reg);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&bcm63xx_gpio_lock, flags);
 }
 
 static int bcm63xx_gpio_get(struct gpio_chip *chip, unsigned gpio)
@@ -70,7 +71,7 @@ static int bcm63xx_gpio_get(struct gpio_chip *chip, unsigned gpio)
 }
 
 static int bcm63xx_gpio_set_direction(struct gpio_chip *chip,
-					unsigned gpio, int dir)
+				      unsigned gpio, int dir)
 {
 	u32 reg;
 	u32 mask;
@@ -88,14 +89,14 @@ static int bcm63xx_gpio_set_direction(struct gpio_chip *chip,
 		mask = 1 << (gpio - 32);
 	}
 
-	local_irq_save(flags);
+	spin_lock_irqsave(&bcm63xx_gpio_lock, flags);
 	tmp = bcm_gpio_readl(reg);
 	if (dir == GPIO_DIR_IN)
 		tmp &= ~mask;
 	else
 		tmp |= mask;
 	bcm_gpio_writel(tmp, reg);
-	local_irq_restore(flags);
+	spin_unlock_irqrestore(&bcm63xx_gpio_lock, flags);
 
 	return 0;
 }
@@ -106,7 +107,7 @@ static int bcm63xx_gpio_direction_input(struct gpio_chip *chip, unsigned gpio)
 }
 
 static int bcm63xx_gpio_direction_output(struct gpio_chip *chip,
-					unsigned gpio, int value)
+					 unsigned gpio, int value)
 {
 	bcm63xx_gpio_set(chip, gpio, value);
 	return bcm63xx_gpio_set_direction(chip, gpio, GPIO_DIR_OUT);
-- 
1.6.0.4
