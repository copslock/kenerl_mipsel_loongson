Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 13 Jul 2015 22:46:24 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:56949 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011028AbbGMUqB23QOV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 13 Jul 2015 22:46:01 +0200
Received: from localhost ([127.0.0.1] helo=[127.0.1.1])
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1ZEkbw-0006V5-2M; Mon, 13 Jul 2015 22:46:00 +0200
Message-Id: <20150713200714.511675588@linutronix.de>
User-Agent: quilt/0.63-1
Date:   Mon, 13 Jul 2015 20:45:53 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Jiang Liu <jiang.liu@linux.intel.com>,
        linux-mips@linux-mips.org,
        Russell King <rmk+kernel@arm.linux.org.uk>,
        Julia Lawall <Julia.Lawall@lip6.fr>
Subject: [patch 01/12] MIPS/jz4740: Consolidate chained IRQ handler
 install/remove
References: <20150713200602.799079101@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Disposition: inline;
 filename=MIPS-jz4740-Consolidate-chained-IRQ-handler-install-.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001,URIBL_BLOCKED=0.001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48233
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
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

Chained irq handlers usually set up handler data as well. We now have
a function to set both under irq_desc->lock. Replace the two calls
with one.

Search and conversion was done with coccinelle.

Reported-by: Russell King <rmk+kernel@arm.linux.org.uk>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: Julia Lawall <Julia.Lawall@lip6.fr>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/jz4740/gpio.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

Index: tip/arch/mips/jz4740/gpio.c
===================================================================
--- tip.orig/arch/mips/jz4740/gpio.c
+++ tip/arch/mips/jz4740/gpio.c
@@ -423,8 +423,8 @@ static void jz4740_gpio_chip_init(struct
 	chip->base = ioremap(JZ4740_GPIO_BASE_ADDR + (id * 0x100), 0x100);
 
 	chip->irq = JZ4740_IRQ_INTC_GPIO(id);
-	irq_set_handler_data(chip->irq, chip);
-	irq_set_chained_handler(chip->irq, jz_gpio_irq_demux_handler);
+	irq_set_chained_handler_and_data(chip->irq,
+					 jz_gpio_irq_demux_handler, chip);
 
 	gc = irq_alloc_generic_chip(chip->gpio_chip.label, 1, chip->irq_base,
 		chip->base, handle_level_irq);
