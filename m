Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Jun 2015 01:27:25 +0200 (CEST)
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34724 "EHLO
        mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009019AbbFSX1HsMeOM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Jun 2015 01:27:07 +0200
Received: by pabvl15 with SMTP id vl15so47998299pab.1
        for <linux-mips@linux-mips.org>; Fri, 19 Jun 2015 16:27:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eYRxF5TH906EuIw55O/dMF5kMvHbB29E/EYJ3O4zjPg=;
        b=jDRtBLdSXK5PklvoNGZOwJCmzold1Xeev7jINN6rYW6c7+9zcn8diLk78uIipgqFp9
         Q1gQjAZhTSPZUwZm+zwBAgxnmsYXW4AKbGNMMB4gA4o24CWbFucd4rPOb/Ess5heVzfg
         urJqfFwAzU6g33imXeFgyiaNvnoti5CnIjXzzVaE6bIsdOSL8e2bXQXMjiQsqe73nm0t
         W+IvfdQTzPc0N09+vz+dXK7daIpj4dM09apUcd3+NBDDG/XJqeBPx+uwum2y02ywyRDu
         y0dI+g+UTpXo7AY6DmQEs+NfaC/iURsUpuzVYTt0NwHMw+L1/f/xfST2avp8eCzteTF+
         XgRg==
X-Received: by 10.70.54.7 with SMTP id f7mr35846353pdp.75.1434756420571;
        Fri, 19 Jun 2015 16:27:00 -0700 (PDT)
Received: from ld-irv-0074.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id tm3sm12390441pac.44.2015.06.19.16.26.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Jun 2015 16:27:00 -0700 (PDT)
From:   Brian Norris <computersforpeace@gmail.com>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Brian Norris <computersforpeace@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Gregory Fong <gregory.0xf0@gmail.com>,
        <bcm-kernel-feedback-list@broadcom.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Jason Cooper <jason@lakedaemon.net>
Subject: [PATCH 2/2] IRQCHIP: bcm7120-l2: perform suspend/resume even without installed child IRQs
Date:   Fri, 19 Jun 2015 16:26:43 -0700
Message-Id: <1434756403-379-2-git-send-email-computersforpeace@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1434756403-379-1-git-send-email-computersforpeace@gmail.com>
References: <20150619224123.GL4917@ld-irv-0074>
 <1434756403-379-1-git-send-email-computersforpeace@gmail.com>
Return-Path: <computersforpeace@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47989
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

Make use of the new irq_chip chip_{suspend,resume} callbacks.

This is required because if there are no installed child IRQs for
this chip, the irq_{suspend,resume} functions will not be called.
However, we still need to save/restore the forwarding mask, to enable
the top-level GIC interrupt; otherwise, we lose UART output after S3
resume.

In addition to refactoring the callbacks, we have to self-initialize the
mask cache, since the genirq core also doesn't initialize this until the
first child IRQ is installed.

The original problem report is described in extra detail here:
http://lkml.kernel.org/g/20150619224123.GL4917@ld-irv-0074

Signed-off-by: Brian Norris <computersforpeace@gmail.com>
---
 drivers/irqchip/irq-bcm7120-l2.c | 21 +++++++++++++--------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/irqchip/irq-bcm7120-l2.c b/drivers/irqchip/irq-bcm7120-l2.c
index 299d4de2deb5..98f0129fe843 100644
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
@@ -281,8 +279,15 @@ int __init bcm7120_l2_intc_probe(struct device_node *dn,
 		ct->chip.irq_mask = irq_gc_mask_clr_bit;
 		ct->chip.irq_unmask = irq_gc_mask_set_bit;
 		ct->chip.irq_ack = irq_gc_noop;
-		ct->chip.irq_suspend = bcm7120_l2_intc_suspend;
-		ct->chip.irq_resume = bcm7120_l2_intc_resume;
+		ct->chip.chip_suspend = bcm7120_l2_intc_suspend;
+		ct->chip.chip_resume = bcm7120_l2_intc_resume;
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
1.9.1
