Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jul 2015 01:22:43 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:36344 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010761AbbGVXWZKhVQ1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jul 2015 01:22:25 +0200
Received: by pachj5 with SMTP id hj5so145980503pac.3
        for <linux-mips@linux-mips.org>; Wed, 22 Jul 2015 16:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=henZqWObQJd6tcb6K0RQNI6AAIbPQg00FBw1dd7xgUo=;
        b=q6oYPrwK1FfhOUqGwR/Dpv0wBV7oy+KliAtG9rycsarlbjFaEPmsmuRYiRH8/PTU4+
         e6ZshSssY/FQ7ogDfG7uDBfK2zxtqQIFhUu/gBZNbsAVST2AqUF4s8Py30orQfdeL023
         Xq/vAHCczGk+OCmoMlp8DvZeqiemeQsowfeTASFCFyuHFRsFV5iPn0XK1lJklNc6bLIy
         KHc652voBV9dIOJxdB25qIX6efkktYQaDuyS6zSPMjRx7E3fJKVoq6lDgIa/unnZHRip
         IK1nYB5DL3XPkNJ9d0lNf2DOPeYBt0mtPb0EdI3mMsWNfbSyMLW2VFqT7cphxMJW2RdR
         qqGQ==
X-Received: by 10.70.102.209 with SMTP id fq17mr11297027pdb.77.1437607338711;
        Wed, 22 Jul 2015 16:22:18 -0700 (PDT)
Received: from ban.mtv.corp.google.com ([172.22.64.120])
        by smtp.gmail.com with ESMTPSA id o7sm5249786pdi.16.2015.07.22.16.22.17
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Wed, 22 Jul 2015 16:22:18 -0700 (PDT)
From:   Brian Norris <computersforpeace@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        Kevin Cernekee <cernekee@chromium.org>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH v2 2/2] IRQCHIP: bcm7120-l2: perform suspend/resume even without installed child IRQs
Date:   Wed, 22 Jul 2015 16:21:40 -0700
Message-Id: <1437607300-40858-2-git-send-email-computersforpeace@gmail.com>
X-Mailer: git-send-email 2.4.3.573.g4eafbef
In-Reply-To: <1437607300-40858-1-git-send-email-computersforpeace@gmail.com>
References: <1434756403-379-1-git-send-email-computersforpeace@gmail.com>
 <1437607300-40858-1-git-send-email-computersforpeace@gmail.com>
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: computersforpeace@gmail.com
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

Make use of the new irq_chip_generic suspend/resume callbacks.

This is required because if there are no installed child IRQs for this
chip, the irq_chip::irq_{suspend,resume} functions will not be called.
However, we still need to save/restore the forwarding mask, to enable
the top-level GIC interrupt; otherwise, we lose UART output after S3
resume.

In addition to refactoring the callbacks, we have to self-initialize the
mask cache, since the genirq core also doesn't initialize this until the
first child IRQ is installed.

The original problem report is described in extra detail here:
http://lkml.kernel.org/g/20150619224123.GL4917@ld-irv-0074

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
Tested-by: Florian Fainelli <f.fainelli@gmail.com>
---
v1: https://lkml.org/lkml/2015/6/19/761

v1 -> v2: adapt to changes in patch 1

 drivers/irqchip/irq-bcm7120-l2.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 3ba5cc780fcb..e5e51bd9fa48 100644
--- a/drivers/irqchip/irq-bcm7120-l2.c
+++ b/drivers/irqchip/irq-bcm7120-l2.c
@@ -81,10 +81,9 @@ static void bcm7120_l2_intc_irq_handle(unsigned int irq, struct irq_desc *desc)
 	chained_irq_exit(chip, desc);
 }
 
-static void bcm7120_l2_intc_suspend(struct irq_data *d)
+static void bcm7120_l2_intc_suspend(struct irq_chip_generic *gc)
 {
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	struct irq_chip_type *ct = gc->chip_types;
 	struct bcm7120_l2_intc_data *b = gc->private;
 
 	irq_gc_lock(gc);
@@ -94,10 +93,9 @@ static void bcm7120_l2_intc_suspend(struct irq_data *d)
 	irq_gc_unlock(gc);
 }
 
-static void bcm7120_l2_intc_resume(struct irq_data *d)
+static void bcm7120_l2_intc_resume(struct irq_chip_generic *gc)
 {
-	struct irq_chip_generic *gc = irq_data_get_irq_chip_data(d);
-	struct irq_chip_type *ct = irq_data_get_chip_type(d);
+	struct irq_chip_type *ct = gc->chip_types;
 
 	/* Restore the saved mask */
 	irq_gc_lock(gc);
@@ -280,8 +278,15 @@ int __init bcm7120_l2_intc_probe(struct device_node *dn,
 		ct->chip.irq_mask = irq_gc_mask_clr_bit;
 		ct->chip.irq_unmask = irq_gc_mask_set_bit;
 		ct->chip.irq_ack = irq_gc_noop;
-		ct->chip.irq_suspend = bcm7120_l2_intc_suspend;
-		ct->chip.irq_resume = bcm7120_l2_intc_resume;
+		gc->suspend = bcm7120_l2_intc_suspend;
+		gc->resume = bcm7120_l2_intc_resume;
+
+		/*
+		 * Initialize mask-cache, in case we need it for
+		 * saving/restoring fwd mask even w/o any child interrupts
+		 * installed
+		 */
+		gc->mask_cache = irq_reg_readl(gc, ct->regs.mask);
 
 		if (data->can_wake) {
 			/* This IRQ chip can wake the system, set all
-- 
2.4.3.573.g4eafbef
