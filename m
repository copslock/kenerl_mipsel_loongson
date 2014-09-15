Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:55:42 +0200 (CEST)
Received: from mail-qa0-f73.google.com ([209.85.216.73]:59652 "EHLO
        mail-qa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009025AbaIOXvrl6YLY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:47 +0200
Received: by mail-qa0-f73.google.com with SMTP id v10so481774qac.2
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=p5otGUqniEKK4YrsflIOWiQ/ItTIZ/D322K2QeHrkjU=;
        b=aV+GJrReL092z2IzIwqwB+m+FGC2ZAFTojlcS+TpEbwgwD/cgXXrSc/sDWZtiiv3lo
         6X/h0PQmJL85hrRun0Do8uLNF1desupvpaBXJsljv7517QsJI//VJaZ8qQORjhS+4vNO
         5x0ii5SZqMDAkKtmKLBVOaWDqVnUQDVZ79rxodTOV3CchKclttogupc5NcZOEhksUCNK
         xGYImjPLAmxNUSTde33smAGfTgSSuThVgl6oVmvx6jrZFJxccZzhtPhFTrIb08cdaPyk
         o+K9vik0VTez0yEe1oVhwoXq0wNPQc0q1+4C/9j6cEIDcvEQL/fktyTk8FClJGy87ofe
         AOQg==
X-Gm-Message-State: ALoCoQlq6TlVHoL/oYvVx12WOo+Xt/3pXmL2UfuyDIp2ArEPMd73gWU/tTx9pIyL0D5pX2FmT3/d
X-Received: by 10.236.191.37 with SMTP id f25mr17248404yhn.44.1410825101712;
        Mon, 15 Sep 2014 16:51:41 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id j25si632218yhb.0.2014.09.15.16.51.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:41 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id cogZdeeo.4; Mon, 15 Sep 2014 16:51:41 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 80D83220984; Mon, 15 Sep 2014 16:51:40 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Jonas Gorski <jogo@openwrt.org>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 14/24] irqchip: mips-gic: Implement generic irq_ack/irq_eoi callbacks
Date:   Mon, 15 Sep 2014 16:51:17 -0700
Message-Id: <1410825087-5497-15-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42632
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: abrestic@chromium.org
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

There's no need for platforms to have their own GIC irq_ack/irq_eoi
callbacks.  Move them to the GIC irqchip driver.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
 arch/mips/include/asm/gic.h     |  2 --
 arch/mips/mti-malta/malta-int.c | 16 ----------------
 arch/mips/mti-sead3/sead3-int.c | 21 ---------------------
 drivers/irqchip/irq-mips-gic.c  | 15 ++++++++++++---
 4 files changed, 12 insertions(+), 42 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 022d831..1bf7985 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -376,7 +376,5 @@ extern void gic_bind_eic_interrupt(int irq, int set);
 extern unsigned int gic_get_timer_pending(void);
 extern void gic_get_int_mask(unsigned long *dst, const unsigned long *src);
 extern unsigned int gic_get_int(void);
-extern void gic_irq_ack(struct irq_data *d);
-extern void gic_finish_irq(struct irq_data *d);
 extern void gic_platform_init(int irqs, struct irq_chip *irq_controller);
 #endif /* _ASM_GICREGS_H */
diff --git a/arch/mips/mti-malta/malta-int.c b/arch/mips/mti-malta/malta-int.c
index 5c31208..b60adfd 100644
--- a/arch/mips/mti-malta/malta-int.c
+++ b/arch/mips/mti-malta/malta-int.c
@@ -715,22 +715,6 @@ int malta_be_handler(struct pt_regs *regs, int is_fixup)
 	return retval;
 }
 
-void gic_irq_ack(struct irq_data *d)
-{
-	int irq = (d->irq - gic_irq_base);
-
-	GIC_CLR_INTR_MASK(irq);
-
-	if (gic_irq_flags[irq] & GIC_TRIG_EDGE)
-		GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
-}
-
-void gic_finish_irq(struct irq_data *d)
-{
-	/* Enable interrupts. */
-	GIC_SET_INTR_MASK(d->irq - gic_irq_base);
-}
-
 void __init gic_platform_init(int irqs, struct irq_chip *irq_controller)
 {
 	int i;
diff --git a/arch/mips/mti-sead3/sead3-int.c b/arch/mips/mti-sead3/sead3-int.c
index 9d5b5bd..03f9865 100644
--- a/arch/mips/mti-sead3/sead3-int.c
+++ b/arch/mips/mti-sead3/sead3-int.c
@@ -85,27 +85,6 @@ void __init arch_init_irq(void)
 			ARRAY_SIZE(gic_intr_map), MIPS_GIC_IRQ_BASE);
 }
 
-void gic_irq_ack(struct irq_data *d)
-{
-	GIC_CLR_INTR_MASK(d->irq - gic_irq_base);
-}
-
-void gic_finish_irq(struct irq_data *d)
-{
-	unsigned int irq = (d->irq - gic_irq_base);
-	unsigned int i, irq_source;
-
-	/* Clear edge detectors. */
-	for (i = 0; i < gic_shared_intr_map[irq].num_shared_intr; i++) {
-		irq_source = gic_shared_intr_map[irq].intr_list[i];
-		if (gic_irq_flags[irq_source] & GIC_TRIG_EDGE)
-			GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq_source);
-	}
-
-	/* Enable interrupts. */
-	GIC_SET_INTR_MASK(irq);
-}
-
 void __init gic_platform_init(int irqs, struct irq_chip *irq_controller)
 {
 	int i;
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 9e9d8b9..0dc2972 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -237,6 +237,15 @@ static void gic_unmask_irq(struct irq_data *d)
 	GIC_SET_INTR_MASK(d->irq - gic_irq_base);
 }
 
+static void gic_ack_irq(struct irq_data *d)
+{
+	GIC_CLR_INTR_MASK(d->irq - gic_irq_base);
+
+	/* Clear edge detector */
+	if (gic_irq_flags[d->irq - gic_irq_base] & GIC_TRIG_EDGE)
+		GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), d->irq - gic_irq_base);
+}
+
 #ifdef CONFIG_SMP
 static DEFINE_SPINLOCK(gic_lock);
 
@@ -272,11 +281,11 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 
 static struct irq_chip gic_irq_controller = {
 	.name			=	"MIPS GIC",
-	.irq_ack		=	gic_irq_ack,
+	.irq_ack		=	gic_ack_irq,
 	.irq_mask		=	gic_mask_irq,
-	.irq_mask_ack		=	gic_mask_irq,
+	.irq_mask_ack		=	gic_ack_irq,
 	.irq_unmask		=	gic_unmask_irq,
-	.irq_eoi		=	gic_finish_irq,
+	.irq_eoi		=	gic_unmask_irq,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	=	gic_set_affinity,
 #endif
-- 
2.1.0.rc2.206.gedb03e5
