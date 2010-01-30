Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 18:38:05 +0100 (CET)
Received: from sakura.staff.proxad.net ([213.228.1.107]:53018 "EHLO
        sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1493006Ab0A3RfP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2010 18:35:15 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id 6DA81551082; Sat, 30 Jan 2010 18:35:15 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 7/7] MIPS: bcm63xx: initialize gpio_out_low & out_high to current value at boot.
Date:   Sat, 30 Jan 2010 18:34:58 +0100
Message-Id: <1264872898-28149-8-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
References: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 25764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19475

To avoid glitch during gpio initialisation, fetch gpio output
registers values left by bootloader.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/gpio.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/mips/bcm63xx/gpio.c b/arch/mips/bcm63xx/gpio.c
index 3725345..315bc7f 100644
--- a/arch/mips/bcm63xx/gpio.c
+++ b/arch/mips/bcm63xx/gpio.c
@@ -125,6 +125,8 @@ static struct gpio_chip bcm63xx_gpio_chip = {
 
 int __init bcm63xx_gpio_init(void)
 {
+	gpio_out_low = bcm_gpio_readl(GPIO_DATA_LO_REG);
+	gpio_out_high = bcm_gpio_readl(GPIO_DATA_HI_REG);
 	bcm63xx_gpio_chip.ngpio = bcm63xx_gpio_count();
 	pr_info("registering %d GPIOs\n", bcm63xx_gpio_chip.ngpio);
 
-- 
1.6.3.3
