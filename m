Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 29 Jul 2011 10:38:28 +0200 (CEST)
Received: from mail-fx0-f49.google.com ([209.85.161.49]:37130 "EHLO
        mail-fx0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491018Ab1G2Ih2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 29 Jul 2011 10:37:28 +0200
Received: by fxd20 with SMTP id 20so2661860fxd.36
        for <multiple recipients>; Fri, 29 Jul 2011 01:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=6cFt45ZTrf7Whm1U/gUAKOv6Bi6fRh1tVePpBmUKPuM=;
        b=GJC/hMT9P8Hlhrott7/ZEy0TtTA/uYlwCdkElxzgFg7oM30OGT9l0UErIohIKeDM2a
         5PJ02yYcuMJrJVn1E1kwa3lT3KmalJHVrV3NDrIGx5fN/7a8iDJgHhgUzFZ4D103+yRf
         XDTl910sDhbT/kPzGf5RAcdgr6we7x0By3qeQ=
Received: by 10.223.68.193 with SMTP id w1mr1449653fai.85.1311928643007;
        Fri, 29 Jul 2011 01:37:23 -0700 (PDT)
Received: from localhost.localdomain (178-191-3-196.adsl.highway.telekom.at [178.191.3.196])
        by mx.google.com with ESMTPS id q5sm955747fah.30.2011.07.29.01.37.21
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Jul 2011 01:37:22 -0700 (PDT)
From:   Manuel Lauss <manuel.lauss@googlemail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Manuel Lauss <manuel.lauss@googlemail.com>
Subject: [RFC PATCH 2/2] MIPS: Alchemy: make ICs chained handlers of MIPS ints.
Date:   Fri, 29 Jul 2011 10:37:16 +0200
Message-Id: <1311928636-18854-3-git-send-email-manuel.lauss@googlemail.com>
X-Mailer: git-send-email 1.7.6
In-Reply-To: <1311928636-18854-1-git-send-email-manuel.lauss@googlemail.com>
References: <1311928636-18854-1-git-send-email-manuel.lauss@googlemail.com>
X-archive-position: 30765
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@googlemail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 21491

This lets me get rid of plat_irq_dispatch, so I can build a kernel with both
Au1000 and Au1300 style IRQ controllers in a single image.

Signed-off-by: Manuel Lauss <manuel.lauss@googlemail.com>
---
 arch/mips/Kconfig              |    1 +
 arch/mips/alchemy/common/irq.c |   55 ++++++++++++++--------------------------
 2 files changed, 20 insertions(+), 36 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 43d9d7f..dc4ba0f 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -46,6 +46,7 @@ config MIPS_ALCHEMY
 	select GENERIC_GPIO
 	select ARCH_WANT_OPTIONAL_GPIOLIB
 	select SYS_SUPPORTS_ZBOOT
+	select MIPS_NO_PLAT_IRQ_DISPATCH
 
 config AR7
 	bool "Texas Instruments AR7"
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
-- 
1.7.6
