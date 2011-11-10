Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 10 Nov 2011 20:10:34 +0100 (CET)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:37584 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903679Ab1KJTKE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 10 Nov 2011 20:10:04 +0100
Received: by mail-fx0-f49.google.com with SMTP id r25so119238faa.36
        for <multiple recipients>; Thu, 10 Nov 2011 11:10:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=PbmqBhN1hWw683xM00B13ghDkME12iHNKEbxWYbkmSo=;
        b=hWfmYNKi/kP6Xgaqy76yCy0RVnSx/oQJwkOe4ZNyoUUTxLzkV5opetqt6zQRbs+11s
         ssVcP+EmoU4GyaDCglbSZ25njCsEvOQ2OhDn1qwjLeAKSGOgP91W2Yo9rB4xevmFHSyZ
         5GcpnhBeWqpJTuyGCyXM07EtPDzB6ZyoyVhQ8=
Received: by 10.152.132.39 with SMTP id or7mr5229514lab.14.1320952204401;
        Thu, 10 Nov 2011 11:10:04 -0800 (PST)
Received: from flagship.roarinelk.net (188-22-13-175.adsl.highway.telekom.at. [188.22.13.175])
        by mx.google.com with ESMTPS id tu2sm8213580lab.11.2011.11.10.11.10.01
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 10 Nov 2011 11:10:03 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [PATCH mips-next 2/3] MIPS: Alchemy: chain IRQ controllers to MIPS IRQ controller
Date:   Thu, 10 Nov 2011 20:09:37 +0100
Message-Id: <1320952178-14228-3-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.7.2
In-Reply-To: <1320952178-14228-1-git-send-email-manuel.lauss@googlemail.com>
References: <1320952178-14228-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 31507
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 9697

IC and GPIC are now chain handlers of the traditional MIPS IRQ controller.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
Even the C0 timer works with this.

 arch/mips/alchemy/common/gpioint.c |   26 +++++++-------
 arch/mips/alchemy/common/irq.c     |   62 +++++++++++++++---------------------
 2 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/arch/mips/alchemy/common/gpioint.c b/arch/mips/alchemy/common/gpioint.c
index 5d7729a..daaaab0 100644
--- a/arch/mips/alchemy/common/gpioint.c
+++ b/arch/mips/alchemy/common/gpioint.c
@@ -349,6 +349,12 @@ static struct syscore_ops alchemy_gpic_pmops = {
 	.resume		= alchemy_gpic_resume,
 };
 
+static void alchemy_gpic_dispatch(unsigned int irq, struct irq_desc *d)
+{
+	int i = __raw_readl(AU1300_GPIC_ADDR + AU1300_GPIC_PRIENC);
+	generic_handle_irq(ALCHEMY_GPIC_INT_BASE + i);
+}
+
 static void __init alchemy_gpic_init_irq(const struct gpic_devint_data *dints)
 {
 	int i;
@@ -383,7 +389,10 @@ static void __init alchemy_gpic_init_irq(const struct gpic_devint_data *dints)
 		dints++;
 	}
 
-	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3);
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 2, alchemy_gpic_dispatch);
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 3, alchemy_gpic_dispatch);
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 4, alchemy_gpic_dispatch);
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 5, alchemy_gpic_dispatch);
 }
 
 /**********************************************************************/
@@ -397,17 +406,8 @@ void __init arch_init_irq(void)
 	}
 }
 
-#define CAUSEF_GPIC (CAUSEF_IP2 | CAUSEF_IP3 | CAUSEF_IP4 | CAUSEF_IP5)
-
-void plat_irq_dispatch(void)
+asmlinkage void plat_irq_dispatch(void)
 {
-	unsigned long i, c = read_c0_cause() & read_c0_status();
-
-	if (c & CAUSEF_IP7)				/* c0 timer */
-		do_IRQ(MIPS_CPU_IRQ_BASE + 7);
-	else if (likely(c & CAUSEF_GPIC)) {
-		i = __raw_readl(AU1300_GPIC_ADDR + AU1300_GPIC_PRIENC);
-		do_IRQ(i + ALCHEMY_GPIC_INT_BASE);
-	} else
-		spurious_interrupt();
+	unsigned long r = (read_c0_status() & read_c0_cause()) >> 8;
+	do_IRQ(MIPS_CPU_IRQ_BASE + __ffs(r & 0xff));
 }
diff --git a/arch/mips/alchemy/common/irq.c b/arch/mips/alchemy/common/irq.c
index f206e24..ee80a32 100644
--- a/arch/mips/alchemy/common/irq.c
+++ b/arch/mips/alchemy/common/irq.c
@@ -459,41 +459,6 @@ static int au1x_ic_settype(struct irq_data *d, unsigned int flow_type)
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
@@ -562,6 +527,22 @@ static struct syscore_ops alchemy_ic_syscore_ops = {
 	.resume		= alchemy_ic_resume,
 };
 
+/* create chained handlers for the 4 IC requests to the MIPS IRQ ctrl */
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
@@ -603,7 +584,10 @@ static void __init au1000_init_irq(struct au1xxx_irqmap *map)
 		++map;
 	}
 
-	set_c0_status(IE_IRQ0 | IE_IRQ1 | IE_IRQ2 | IE_IRQ3);
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 2, au1000_ic0r0_dispatch);
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 3, au1000_ic0r1_dispatch);
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 4, au1000_ic1r0_dispatch);
+	irq_set_chained_handler(MIPS_CPU_IRQ_BASE + 5, au1000_ic1r1_dispatch);
 }
 
 void __init arch_init_irq(void)
@@ -626,3 +610,9 @@ void __init arch_init_irq(void)
 		break;
 	}
 }
+
+asmlinkage void plat_irq_dispatch(void)
+{
+	unsigned long r = (read_c0_status() & read_c0_cause()) >> 8;
+	do_IRQ(MIPS_CPU_IRQ_BASE + __ffs(r & 0xff));
+}
-- 
1.7.7.2
