Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 28 Nov 2008 19:43:43 +0000 (GMT)
Received: from orbit.nwl.cc ([81.169.176.177]:53151 "EHLO
	mail.ifyouseekate.net") by ftp.linux-mips.org with ESMTP
	id S23974383AbYK1Tnj (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 28 Nov 2008 19:43:39 +0000
Received: from nuty (localhost [127.0.0.1])
	by mail.ifyouseekate.net (Postfix) with ESMTP id B8090386B1A6;
	Fri, 28 Nov 2008 20:43:33 +0100 (CET)
From:	Phil Sutter <n0-1@freewrt.org>
To:	Ralf Baechle <ralf@linux-mips.org>
Cc:	linux-mips@linux-mips.org
Subject: [PATCH] MIPS: rb532: auto disable GPIO alternate function
Date:	Fri, 28 Nov 2008 20:46:09 +0100
X-Mailer: git-send-email 1.5.6.4
In-Reply-To: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
References: <20081128193322.D103C386DBBE@mail.ifyouseekate.net>
Message-Id: <20081128194333.B8090386B1A6@mail.ifyouseekate.net>
Return-Path: <phil@nwl.cc>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 21469
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: n0-1@freewrt.org
Precedence: bulk
X-list: linux-mips

When a driver calls gpio_set_direction_{input,output}(), it obviously
doesn't want the alternate function for that pin to be active (as the
direction would not matter in that case). This patch ensures alternate
function is disabled when the direction is being changed.

Signed-off-by: Phil Sutter <n0-1@freewrt.org>
---
 arch/mips/rb532/gpio.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/rb532/gpio.c b/arch/mips/rb532/gpio.c
index e35cb75..f5b15a1 100644
--- a/arch/mips/rb532/gpio.c
+++ b/arch/mips/rb532/gpio.c
@@ -169,8 +169,8 @@ static int rb532_gpio_direction_input(struct gpio_chip *chip, unsigned offset)
 
 	gpch = container_of(chip, struct rb532_gpio_chip, chip);
 
-	if (rb532_get_bit(offset, gpch->regbase + GPIOFUNC))
-		return 1;	/* alternate function, GPIOCFG is ignored */
+	/* disable alternate function in case it's set */
+	rb532_set_bit(0, offset, gpch->regbase + GPIOFUNC);
 
 	rb532_set_bit(0, offset, gpch->regbase + GPIOCFG);
 	return 0;
@@ -186,8 +186,8 @@ static int rb532_gpio_direction_output(struct gpio_chip *chip,
 
 	gpch = container_of(chip, struct rb532_gpio_chip, chip);
 
-	if (rb532_get_bit(offset, gpch->regbase + GPIOFUNC))
-		return 1;	/* alternate function, GPIOCFG is ignored */
+	/* disable alternate function in case it's set */
+	rb532_set_bit(0, offset, gpch->regbase + GPIOFUNC);
 
 	/* set the initial output value */
 	rb532_set_bit(value, offset, gpch->regbase + GPIOD);
-- 
1.5.6.4
