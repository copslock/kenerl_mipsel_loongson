Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Jul 2011 19:29:36 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:39948 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491168Ab1G1R3c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Jul 2011 19:29:32 +0200
Received: by fxd20 with SMTP id 20so1774474fxd.36
        for <linux-mips@linux-mips.org>; Thu, 28 Jul 2011 10:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=2yyRiv3P5ZIAyww9oSpMuv/4Hnss0snDzdIo3MahVDs=;
        b=H5sOgzUtRoLRCjCa9RWz5CbZ2dwZDU1+ulkzgJwKcZo1tb2r5awO+sL5keFEyYrM7j
         sSSpAjXk6TOFx6Vd0WSqKQRUe5cLcErvH8iuYpuJ2JvgSv6wT4PKW5oB2Bu+5bKRAYCk
         opoGW2Yvek/FQ3SaEYyoLdSRyQH1agMTGggis=
Received: by 10.223.58.79 with SMTP id f15mr348764fah.53.1311874166880;
        Thu, 28 Jul 2011 10:29:26 -0700 (PDT)
Received: from localhost.localdomain (188-22-11-75.adsl.highway.telekom.at [188.22.11.75])
        by mx.google.com with ESMTPS id o17sm601011fal.2.2011.07.28.10.29.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 28 Jul 2011 10:29:25 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [RFC PATCH] MIPS: Alchemy: make ICs chained handler of MIPS ints.
Date:   Thu, 28 Jul 2011 19:29:22 +0200
Message-Id: <1311874162-6447-1-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
X-archive-position: 30757
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 20931

This lets me get rid of plat_irq_dispatch, so I can later build a
kernel with both the Au1000- and Au1300-style interrupt controllers
selected at runtime.  And another stupid global function is gone as well.

Boots and runs on all my Alchemy boards.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/alchemy/common/irq.c |   55 ++++++++++++++--------------------------
 arch/mips/kernel/genex.S       |   12 ++++++++
 2 files changed, 31 insertions(+), 36 deletions(-)

diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index 8b60ba0..8cf7cc7 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -470,41 +470,6 @@ static int au1x_ic_settype(struct irq_data *d, unsigned int flow_type)
 	return ret;
 }
 
-asmlinkage void plat_irq_dispatch(void)
-{
-	unsigned int pending = read_c0_status() & read_c0_cause();
-	unsigned long s, off;
-
-	if (pending & CAUSEF_IP7) {
-		off = MIPS_CPU_IRQ_BASE + 7;
-		goto handle;
-	} else if (pending & CAUSEF_IP2) {
-		s = KSEG1ADDR(AU1000_IC0_PHYS_ADDR) + IC_REQ0INT;
-		off = AU1000_INTC0_INT_BASE;
-	} else if (pending & CAUSEF_IP3) {
-		s = KSEG1ADDR(AU1000_IC0_PHYS_ADDR) + IC_REQ1INT;
-		off = AU1000_INTC0_INT_BASE;
-	} else if (pending & CAUSEF_IP4) {
-		s = KSEG1ADDR(AU1000_IC1_PHYS_ADDR) + IC_REQ0INT;
-		off = AU1000_INTC1_INT_BASE;
-	} else if (pending & CAUSEF_IP5) {
-		s = KSEG1ADDR(AU1000_IC1_PHYS_ADDR) + IC_REQ1INT;
-		off = AU1000_INTC1_INT_BASE;
-	} else
-		goto spurious;
-
-	s = __raw_readl((void __iomem *)s);
-	if (unlikely(!s)) {
-spurious:
-		spurious_interrupt();
-		return;
-	}
-	off += __ffs(s);
-handle:
-	do_IRQ(off);
-}
-
-
 static inline void ic_init(void __iomem *base)
 {
 	/* initialize interrupt controller to a safe state */
@@ -521,6 +486,21 @@ static inline void ic_init(void __iomem *base)
 	wmb();
 }
 
+#define DISP(name, base, addr)						      \
+static void au1000_##name##_dispatch(unsigned int irq, struct irq_desc *d)    \
+{									      \
+	unsigned long r = __raw_readl((void __iomem *)KSEG1ADDR(addr));	      \
+	if (likely(r))							      \
+		generic_handle_irq(base + __ffs(r));			      \
+	else								      \
+		spurious_interrupt();					      \
+}
+
+DISP(ic0r0, AU1000_INTC0_INT_BASE, AU1000_IC0_PHYS_ADDR + IC_REQ0INT)
+DISP(ic0r1, AU1000_INTC0_INT_BASE, AU1000_IC0_PHYS_ADDR + IC_REQ1INT)
+DISP(ic1r0, AU1000_INTC1_INT_BASE, AU1000_IC1_PHYS_ADDR + IC_REQ0INT)
+DISP(ic1r1, AU1000_INTC1_INT_BASE, AU1000_IC1_PHYS_ADDR + IC_REQ1INT)
+
 static void __init au1000_init_irq(struct au1xxx_irqmap *map)
 {
 	unsigned int bit, irq_nr;
@@ -561,7 +541,10 @@ static void __init au1000_init_irq(struct au1xxx_irqmap *map)
 		++map;
 	}
 
-	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3);
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 2, au1000_ic0r0_dispatch);
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 3, au1000_ic0r1_dispatch);
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 4, au1000_ic1r0_dispatch);
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 5, au1000_ic1r1_dispatch);
 }
 
 void __init arch_init_irq(void)
diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
index 8882e57..306feaa 100644
--- a/arch/mips/kernel/genex.S
+++ b/arch/mips/kernel/genex.S
@@ -202,7 +202,19 @@ NESTED(handle_int, PT_SIZE, sp)
 	LONG_L	s0, TI_REGS($28)
 	LONG_S	sp, TI_REGS($28)
 	PTR_LA	ra, ret_from_irq
+#ifdef CONFIG_MIPS_ALCHEMY
+	mfc0	t0, CP0_STATUS
+	mfc0	v1, CP0_CAUSE
+	and	t0, v1, t0
+	sra	t0, t0, 8
+	andi	t0, t0, 0xff
+	li	a0, 31
+	clz	t0, t0
+	subu	a0, a0, t0
+	j	do_IRQ
+#else
 	j	plat_irq_dispatch
+#endif
 	END(handle_int)
 
 	__INIT
-- 
1.7.6
