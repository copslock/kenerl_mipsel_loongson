Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2011 03:09:28 +0200 (CEST)
Received: from smtp-out-212.synserver.de ([212.40.185.212]:1398 "EHLO
        smtp-out-212.synserver.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491873Ab1FCBIe (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jun 2011 03:08:34 +0200
Received: (qmail 8720 invoked by uid 0); 3 Jun 2011 01:08:30 -0000
X-SynServer-TrustedSrc: 1
X-SynServer-AuthUser: lars@laprican.de
X-SynServer-PPID: 8419
Received: from e177148193.adsl.alicedsl.de (HELO lars-laptop.nons.lan) [85.177.148.193]
  by 217.119.54.87 with SMTP; 3 Jun 2011 01:08:30 -0000
From:   Lars-Peter Clausen <lars@metafoo.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH 4/4] MIPS: JZ4740: GPIO: Check correct IRQ in demux handler
Date:   Fri,  3 Jun 2011 03:06:51 +0200
Message-Id: <1307063211-10098-4-git-send-email-lars@metafoo.de>
X-Mailer: git-send-email 1.7.2.5
In-Reply-To: <1307063211-10098-1-git-send-email-lars@metafoo.de>
References: <1307063211-10098-1-git-send-email-lars@metafoo.de>
X-archive-position: 30206
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 2246

Check the trigger direction for the triggered IRQ instead of the parent IRQ.

Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
---
 arch/mips/jz4740/gpio.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/mips/jz4740/gpio.c b/arch/mips/jz4740/gpio.c
index f3590a2..7179c78 100644
--- a/arch/mips/jz4740/gpio.c
+++ b/arch/mips/jz4740/gpio.c
@@ -309,7 +309,7 @@ static void jz_gpio_irq_demux_handler(unsigned int irq, struct irq_desc *desc)
 
 	gpio_irq = chip->irq_base + __fls(flag);
 
-	jz_gpio_check_trigger_both(chip, irq);
+	jz_gpio_check_trigger_both(chip, gpio_irq);
 
 	generic_handle_irq(gpio_irq);
 };
-- 
1.7.2.5
