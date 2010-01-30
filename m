Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Jan 2010 18:36:27 +0100 (CET)
Received: from sakura.staff.proxad.net ([213.228.1.107]:53010 "EHLO
        sakura.staff.proxad.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492994Ab0A3RfM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Jan 2010 18:35:12 +0100
Received: by sakura.staff.proxad.net (Postfix, from userid 1000)
        id 30AA6551082; Sat, 30 Jan 2010 18:35:12 +0100 (CET)
From:   Maxime Bizon <mbizon@freebox.fr>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     Maxime Bizon <mbizon@freebox.fr>
Subject: [PATCH 3/7] MIPS: bcm63xx: fix double gpio registration.
Date:   Sat, 30 Jan 2010 18:34:54 +0100
Message-Id: <1264872898-28149-4-git-send-email-mbizon@freebox.fr>
X-Mailer: git-send-email 1.6.3.3
In-Reply-To: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
References: <1264872898-28149-1-git-send-email-mbizon@freebox.fr>
X-archive-position: 25760
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mbizon@freebox.fr
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 19471

bcm63xx_gpio_init is already called from prom_init to allow board to
use them early, so we can remove the unneeded arch_initcall.

Signed-off-by: Maxime Bizon <mbizon@freebox.fr>
---
 arch/mips/bcm63xx/gpio.c |    2 --
 1 files changed, 0 insertions(+), 2 deletions(-)

diff --git a/arch/mips/bcm63xx/gpio.c b/arch/mips/bcm63xx/gpio.c
index 87ca390..3725345 100644
--- a/arch/mips/bcm63xx/gpio.c
+++ b/arch/mips/bcm63xx/gpio.c
@@ -130,5 +130,3 @@ int __init bcm63xx_gpio_init(void)
 
 	return gpiochip_add(&bcm63xx_gpio_chip);
 }
-
-arch_initcall(bcm63xx_gpio_init);
-- 
1.6.3.3
