Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Nov 2011 20:05:22 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:32904 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903691Ab1KATEH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 1 Nov 2011 20:04:07 +0100
Received: by mail-fx0-f49.google.com with SMTP id q17so947590faa.36
        for <multiple recipients>; Tue, 01 Nov 2011 12:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=0rHy6qv3HRnWGlf+svPp20vHytKLOJe0/i9NPpd3pDI=;
        b=BEV6DrNy23FFs8+SyVqtv4nduByegoQGXXl73B/mEbTEuEvmfSuCJpCbz9Q5Edr/VY
         Afd0bJ//gTmIhiMzpZHhuEWl9G3waxJES3H6lUfDLBd1x/5WXmkm+MP2/fk8KocCDbE5
         WU2GCBzAG4OSLjWEauLNKHljyOXWCwHxMwR9c=
Received: by 10.223.87.211 with SMTP id x19mr2346244fal.8.1320174246879;
        Tue, 01 Nov 2011 12:04:06 -0700 (PDT)
Received: from localhost.localdomain (188-22-150-81.adsl.highway.telekom.at. [188.22.150.81])
        by mx.google.com with ESMTPS id a8sm327916faa.11.2011.11.01.12.04.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 01 Nov 2011 12:04:06 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH 03/18] MIPS: Alchemy: devboards: remove unneeded BCSR IRQ reg acc
Date:   Tue,  1 Nov 2011 20:03:29 +0100
Message-Id: <1320174224-27305-4-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.1
In-Reply-To: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
References: <1320174224-27305-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31343
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 653

Initially I had to write to both the MASK and ENABLE registers,
otherwise the CPLD would generate tons of spurious interrupts.
With the change to the demux handler to disable the muxed line,
it is now sufficient to disable the interrupt by writing either
the enable or mask register.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/devboards/bcsr.c |   11 ++---------
 1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/arch/mips/alchemy/devboards/bcsr.c b/arch/mips/alchemy/devboards/bcsr.c
index 463d2c4..1e83ce2 100644
--- a/arch/mips/alchemy/devboards/bcsr.c
+++ b/arch/mips/alchemy/devboards/bcsr.c
@@ -97,14 +97,9 @@ static void bcsr_csc_handler(unsigned int irq, struct irq_desc *d)
 	enable_irq(irq);
 }
 
-/* NOTE: both the enable and mask bits must be cleared, otherwise the
- * CPLD generates tons of spurious interrupts (at least on my DB1200).
- *	-- mlau
- */
 static void bcsr_irq_mask(struct irq_data *d)
 {
 	unsigned short v = 1 << (d->irq - bcsr_csc_base);
-	__raw_writew(v, bcsr_virt + BCSR_REG_INTCLR);
 	__raw_writew(v, bcsr_virt + BCSR_REG_MASKCLR);
 	wmb();
 }
@@ -112,7 +107,6 @@ static void bcsr_irq_mask(struct irq_data *d)
 static void bcsr_irq_maskack(struct irq_data *d)
 {
 	unsigned short v = 1 << (d->irq - bcsr_csc_base);
-	__raw_writew(v, bcsr_virt + BCSR_REG_INTCLR);
 	__raw_writew(v, bcsr_virt + BCSR_REG_MASKCLR);
 	__raw_writew(v, bcsr_virt + BCSR_REG_INTSTAT);	/* ack */
 	wmb();
@@ -121,7 +115,6 @@ static void bcsr_irq_maskack(struct irq_data *d)
 static void bcsr_irq_unmask(struct irq_data *d)
 {
 	unsigned short v = 1 << (d->irq - bcsr_csc_base);
-	__raw_writew(v, bcsr_virt + BCSR_REG_INTSET);
 	__raw_writew(v, bcsr_virt + BCSR_REG_MASKSET);
 	wmb();
 }
@@ -137,9 +130,9 @@ void __init bcsr_init_irq(int csc_start, int csc_end, int hook_irq)
 {
 	unsigned int irq;
 
-	/* mask & disable & ack all */
-	__raw_writew(0xffff, bcsr_virt + BCSR_REG_INTCLR);
+	/* mask & enable & ack all */
 	__raw_writew(0xffff, bcsr_virt + BCSR_REG_MASKCLR);
+	__raw_writew(0xffff, bcsr_virt + BCSR_REG_INTSET);
 	__raw_writew(0xffff, bcsr_virt + BCSR_REG_INTSTAT);
 	wmb();
 
-- 
1.7.7.1
