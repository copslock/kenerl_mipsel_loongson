Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 11 Nov 2014 14:34:09 +0100 (CET)
Received: from down.free-electrons.com ([37.187.137.238]:50695 "EHLO
        mail.free-electrons.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27013367AbaKKNeHomqcE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 11 Nov 2014 14:34:07 +0100
Received: by mail.free-electrons.com (Postfix, from userid 106)
        id 1DC9F748; Tue, 11 Nov 2014 14:34:10 +0100 (CET)
Received: from localhost.localdomain (col31-4-88-188-80-5.fbx.proxad.net [88.188.80.5])
        by mail.free-electrons.com (Postfix) with ESMTPSA id 2B25B74D;
        Tue, 11 Nov 2014 14:33:48 +0100 (CET)
From:   Boris Brezillon <boris.brezillon@free-electrons.com>
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Kevin Hilman <khilman@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>, linux-sh@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Maxime Bizon <mbizon@freebox.fr>,
        Jonas Gorski <jogo@openwrt.org>, linux-mips@linux-mips.org,
        Nicolas Ferre <nicolas.ferre@atmel.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        Boris Brezillon <boris.brezillon@free-electrons.com>
Subject: [PATCH] irqchip: atmel-aic: fix irqdomain initialization
Date:   Tue, 11 Nov 2014 14:33:36 +0100
Message-Id: <1415712816-9202-1-git-send-email-boris.brezillon@free-electrons.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <20141110230301.GV4068@piout.net>
References: <20141110230301.GV4068@piout.net>
Return-Path: <boris.brezillon@free-electrons.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44000
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: boris.brezillon@free-electrons.com
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

First of all IRQCHIP_SKIP_SET_WAKE is not a valid irq_gc_flags and thus
should not be passed as the last argument of
irq_alloc_domain_generic_chips.

Then pass the correct handler (handle_fasteoi_irq) to
irq_alloc_domain_generic_chips instead of manually re-setting it in the
initialization loop.

And eventually initialize default irq flags to the pseudo standard:
IRQ_REQUEST | IRQ_PROBE | IRQ_AUTOEN.

Signed-off-by: Boris Brezillon <boris.brezillon@free-electrons.com>
---
Hello Kevin,

This patch has not been tested yet but it should solve the issue you've
experienced with the IRQ_GC_BE_IO flag and the atmel-aic driver.

I'll test it tomorrow and let you know if it actually works.

Regards,

Boris

 drivers/irqchip/irq-atmel-aic-common.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/irqchip/irq-atmel-aic-common.c b/drivers/irqchip/irq-atmel-aic-common.c
index 656cfe3..d111ac7 100644
--- a/drivers/irqchip/irq-atmel-aic-common.c
+++ b/drivers/irqchip/irq-atmel-aic-common.c
@@ -243,8 +243,9 @@ struct irq_domain *__init aic_common_of_init(struct device_node *node,
 	}
 
 	ret = irq_alloc_domain_generic_chips(domain, 32, 1, name,
-					     handle_level_irq, 0, 0,
-					     IRQCHIP_SKIP_SET_WAKE);
+					     handle_fasteoi_irq,
+					     IRQ_NOREQUEST | IRQ_NOPROBE |
+					     IRQ_NOAUTOEN, 0, 0);
 	if (ret)
 		goto err_domain_remove;
 
@@ -256,7 +257,6 @@ struct irq_domain *__init aic_common_of_init(struct device_node *node,
 		gc->unused = 0;
 		gc->wake_enabled = ~0;
 		gc->chip_types[0].type = IRQ_TYPE_SENSE_MASK;
-		gc->chip_types[0].handler = handle_fasteoi_irq;
 		gc->chip_types[0].chip.irq_eoi = irq_gc_eoi;
 		gc->chip_types[0].chip.irq_set_wake = irq_gc_set_wake;
 		gc->chip_types[0].chip.irq_shutdown = aic_common_shutdown;
-- 
1.9.1
