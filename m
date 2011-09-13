Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Sep 2011 00:29:10 +0200 (CEST)
Received: from smtp-out-188.synserver.de ([212.40.185.188]:1073 "HELO
        smtp-out-180.synserver.de" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with SMTP id S1491123Ab1IMW3D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Sep 2011 00:29:03 +0200
Received: (qmail 21905 invoked by uid 0); 13 Sep 2011 22:28:48 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 21634
Received: from e177164147.adsl.alicedsl.de (HELO lars-laptop.nons.lan) [85.177.164.147]
  by 217.119.54.73 with SMTP; 13 Sep 2011 22:28:45 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org,
        Maarten ter Huurne <maarten@treewalker.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH] MIPS: JZ4740: GPIO: Use new name for generic ack function.
Date:   Wed, 14 Sep 2011 00:28:30 +0200
Message-Id: <1315952910-6485-1-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.7.2.5
X-archive-position: 31068
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 6828

From: Maarten ter Huurne <maarten@treewalker.org>

In commit 659fb32d1b6("genirq: replace irq_gc_ack() with {set,clr}_bit variants
(fwd)"), irq_gc_ack was renamed to irq_gc_ack_set_bit.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
Ralf, it would be good if you could merge this into "MIPS: JZ4740: Use generic
irq chip" which should be in your 3.2 queue.

Thanks
- Lars
---
 arch/mips/jz4740/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
index 7179c78..e1ddb95 100644
--- a/arch/mips/jz4740/gpio.c
+++ b/arch/mips/jz4740/gpio.c
@@ -441,7 +441,7 @@ static void jz4740_gpio_chip_init(struct jz_gpio_chip *chip, unsigned int id)
 	ct->chip.name = "GPIO";
 	ct->chip.irq_mask = irq_gc_mask_disable_reg;
 	ct->chip.irq_unmask = jz_gpio_irq_unmask;
-	ct->chip.irq_ack = irq_gc_ack;
+	ct->chip.irq_ack = irq_gc_ack_set_bit;
 	ct->chip.irq_suspend = jz4740_irq_suspend;
 	ct->chip.irq_resume = jz4740_irq_resume;
 	ct->chip.irq_startup = jz_gpio_irq_startup;
-- 
1.7.2.5
