Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 30 Oct 2014 03:21:11 +0100 (CET)
Received: from mail-pd0-f171.google.com ([209.85.192.171]:36926 "EHLO
        mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012247AbaJ3CTu2Ifof (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 30 Oct 2014 03:19:50 +0100
Received: by mail-pd0-f171.google.com with SMTP id r10so4160543pdi.30
        for <multiple recipients>; Wed, 29 Oct 2014 19:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=VVMaWP/+ASVWWTid3tKrbaN3WQaaLgqhfPQFQzhlFX4=;
        b=lqB6N3W790ync5upTWVhC8JQpI5bWuv2X4dOg3gE6XCAVizf3sJN6ygePz4D2XdIuw
         T6uZLSHn0iAdvRdph8UJ85R92aFpYv0FTfxLFY+JEtV3r6hBR87odm8vZ1b1+geY4/AI
         m9t8JixOtQHg/hHLwaNL9F+VStgasxyZRwQuXtWBLSwCG5UgzllKc0/6radBRepXRWTx
         zHx7l+9E54PIGXyj7pPNG5CT2IwgSQzle1BynU1L824sq7HO0fYHqJom3S/AhH/2hRUC
         FzZV/jJlrjV7u++dxromMhQ+2B0llm2D6K6LGoOr3pelzPvL/Te+7SaRKwp/G9pJS+AE
         e+3w==
X-Received: by 10.70.48.175 with SMTP id m15mr450057pdn.153.1414635584346;
        Wed, 29 Oct 2014 19:19:44 -0700 (PDT)
Received: from localhost (b32.net. [192.81.132.72])
        by mx.google.com with ESMTPSA id d17sm5524269pdj.32.2014.10.29.19.19.42
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Wed, 29 Oct 2014 19:19:43 -0700 (PDT)
From:   Kevin Cernekee <cernekee@gmail.com>
To:     arnd@arndb.de, f.fainelli@gmail.com, tglx@linutronix.de,
        jason@lakedaemon.net, ralf@linux-mips.org, lethal@linux-sh.org
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        mbizon@freebox.fr, jogo@openwrt.org, linux-mips@linux-mips.org
Subject: [PATCH V2 04/15] genirq: Generic chip: Change irq_reg_{readl,writel} arguments
Date:   Wed, 29 Oct 2014 19:17:57 -0700
Message-Id: <1414635488-14137-5-git-send-email-cernekee@gmail.com>
X-Mailer: git-send-email 2.1.1
In-Reply-To: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
References: <1414635488-14137-1-git-send-email-cernekee@gmail.com>
Return-Path: <cernekee@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43743
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: cernekee@gmail.com
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

Instead of taking a raw register virtual address, we will take an
irq_chip_generic struct and a register offset.  This makes it possible to
implement different behavior on different irqchips.

Signed-off-by: Kevin Cernekee <cernekee@gmail.com>
---
 kernel/irq/generic-chip.c | 30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/generic-chip.c b/kernel/irq/generic-chip.c
index 380595f..b2ee65d 100644
--- a/kernel/irq/generic-chip.c
+++ b/kernel/irq/generic-chip.c
@@ -17,14 +17,16 @@
 static LIST_HEAD(gc_list);
 static DEFINE_RAW_SPINLOCK(gc_lock);
 
-static void irq_reg_writel(u32 val, void __iomem *addr)
+static void irq_reg_writel(struct irq_chip_generic *gc,
+			   u32 val, int reg_offset)
 {
-	writel(val, addr);
+	writel(val, gc->reg_base + reg_offset);
 }
 
-static u32 irq_reg_readl(void __iomem *addr)
+static u32 irq_reg_readl(struct irq_chip_generic *gc,
+			 int reg_offset)
 {
-	return readl(addr);
+	return readl(gc->reg_base + reg_offset);
 }
 
 /**
@@ -49,7 +51,7 @@ void irq_gc_mask_disable_reg(struct irq_data *d)
 	u32 mask = d->mask;
 
 	irq_gc_lock(gc);
-	irq_reg_writel(mask, gc->reg_base + ct->regs.disable);
+	irq_reg_writel(gc, mask, ct->regs.disable);
 	*ct->mask_cache &= ~mask;
 	irq_gc_unlock(gc);
 }
@@ -69,7 +71,7 @@ void irq_gc_mask_set_bit(struct irq_data *d)
 
 	irq_gc_lock(gc);
 	*ct->mask_cache |= mask;
-	irq_reg_writel(*ct->mask_cache, gc->reg_base + ct->regs.mask);
+	irq_reg_writel(gc, *ct->mask_cache, ct->regs.mask);
 	irq_gc_unlock(gc);
 }
 EXPORT_SYMBOL_GPL(irq_gc_mask_set_bit);
@@ -89,7 +91,7 @@ void irq_gc_mask_clr_bit(struct irq_data *d)
 
 	irq_gc_lock(gc);
 	*ct->mask_cache &= ~mask;
-	irq_reg_writel(*ct->mask_cache, gc->reg_base + ct->regs.mask);
+	irq_reg_writel(gc, *ct->mask_cache, ct->regs.mask);
 	irq_gc_unlock(gc);
 }
 EXPORT_SYMBOL_GPL(irq_gc_mask_clr_bit);
@@ -108,7 +110,7 @@ void irq_gc_unmask_enable_reg(struct irq_data *d)
 	u32 mask = d->mask;
 
 	irq_gc_lock(gc);
-	irq_reg_writel(mask, gc->reg_base + ct->regs.enable);
+	irq_reg_writel(gc, mask, ct->regs.enable);
 	*ct->mask_cache |= mask;
 	irq_gc_unlock(gc);
 }
@@ -124,7 +126,7 @@ void irq_gc_ack_set_bit(struct irq_data *d)
 	u32 mask = d->mask;
 
 	irq_gc_lock(gc);
-	irq_reg_writel(mask, gc->reg_base + ct->regs.ack);
+	irq_reg_writel(gc, mask, ct->regs.ack);
 	irq_gc_unlock(gc);
 }
 EXPORT_SYMBOL_GPL(irq_gc_ack_set_bit);
@@ -140,7 +142,7 @@ void irq_gc_ack_clr_bit(struct irq_data *d)
 	u32 mask = ~d->mask;
 
 	irq_gc_lock(gc);
-	irq_reg_writel(mask, gc->reg_base + ct->regs.ack);
+	irq_reg_writel(gc, mask, ct->regs.ack);
 	irq_gc_unlock(gc);
 }
 
@@ -155,8 +157,8 @@ void irq_gc_mask_disable_reg_and_ack(struct irq_data *d)
 	u32 mask = d->mask;
 
 	irq_gc_lock(gc);
-	irq_reg_writel(mask, gc->reg_base + ct->regs.mask);
-	irq_reg_writel(mask, gc->reg_base + ct->regs.ack);
+	irq_reg_writel(gc, mask, ct->regs.mask);
+	irq_reg_writel(gc, mask, ct->regs.ack);
 	irq_gc_unlock(gc);
 }
 
@@ -171,7 +173,7 @@ void irq_gc_eoi(struct irq_data *d)
 	u32 mask = d->mask;
 
 	irq_gc_lock(gc);
-	irq_reg_writel(mask, gc->reg_base + ct->regs.eoi);
+	irq_reg_writel(gc, mask, ct->regs.eoi);
 	irq_gc_unlock(gc);
 }
 
@@ -255,7 +257,7 @@ irq_gc_init_mask_cache(struct irq_chip_generic *gc, enum irq_gc_flags flags)
 		}
 		ct[i].mask_cache = mskptr;
 		if (flags & IRQ_GC_INIT_MASK_CACHE)
-			*mskptr = irq_reg_readl(gc->reg_base + mskreg);
+			*mskptr = irq_reg_readl(gc, mskreg);
 	}
 }
 
-- 
2.1.1
