Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2011 03:09:03 +0200 (CEST)
Received: from smtp-out-212.synserver.de ([212.40.185.212]:1449 "EHLO
        smtp-out-212.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491871Ab1FCBIe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jun 2011 03:08:34 +0200
Received: (qmail 8691 invoked by uid 0); 3 Jun 2011 01:08:29 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 8419
Received: from e177148193.adsl.alicedsl.de (HELO lars-laptop.nons.lan) [85.177.148.193]
  by 217.119.54.87 with SMTP; 3 Jun 2011 01:08:29 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 3/4] MIPS: JZ4740: GPIO: Simplify IRQ demuxer
Date:   Fri,  3 Jun 2011 03:06:50 +0200
Message-Id: <1307063211-10098-3-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1307063211-10098-1-git-send-email-lars@metafoo.de>
References: <1307063211-10098-1-git-send-email-lars@metafoo.de>
X-archive-position: 30205
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2245

We already know the base IRQ for a GPIO chip, so there is no need to recalculate
it in the demux handler.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/gpio.c |    8 +-------
 1 files changed, 1 insertions(+), 7 deletions(-)

diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
index ab583b8..f3590a2 100644
--- a/arch/mips/jz4740/gpio.c
+++ b/arch/mips/jz4740/gpio.c
@@ -301,22 +301,16 @@ static void jz_gpio_irq_demux_handler(unsigned int irq, struct irq_desc *desc)
 {
 	uint32_t flag;
 	unsigned int gpio_irq;
-	unsigned int gpio_bank;
 	struct jz_gpio_chip *chip = irq_desc_get_handler_data(desc);
 
-	gpio_bank = JZ4740_IRQ_GPIO0 - irq;
-
 	flag = readl(chip->base + JZ_REG_GPIO_FLAG);
-
 	if (!flag)
 		return;
 
-	gpio_irq = __fls(flag);
+	gpio_irq = chip->irq_base + __fls(flag);
 
 	jz_gpio_check_trigger_both(chip, irq);
 
-	gpio_irq += (gpio_bank << 5) + JZ4740_IRQ_GPIO(0);
-
 	generic_handle_irq(gpio_irq);
 };
 
-- 
1.7.2.5
