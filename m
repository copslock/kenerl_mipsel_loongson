Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 05 Sep 2014 19:32:50 +0200 (CEST)
Received: from mail-pd0-f201.google.com ([209.85.192.201]:62694 "EHLO
        mail-pd0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27025898AbaIERak0--ZW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 5 Sep 2014 19:30:40 +0200
Received: by mail-pd0-f201.google.com with SMTP id v10so497393pde.4
        for <linux-mips@linux-mips.org>; Fri, 05 Sep 2014 10:30:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qQz9qAXl/8nOsnra5zrqX/GNsMp/FX5yoAyx8gCdT5k=;
        b=IRsx3BUjFb3Bg7jwCIo9EFcTsqOYp37qte5X+oXp5nyJUPqV8t7xTh7ZHX7jsgrOh/
         dFgVnJmi2jpwOp2qqRCx7y5fFD1F/lm4sbu8crwKz3JsKqLU+1TUJdQ1W9jO0+TN+fsE
         XCj+fTfObF+FWV4ayYDTqQTn0bMjz9i9Q1XvRiEJ97lwEKMUdz+MsR6RUv1v5OSJSJ3S
         O+ubovbTh9rqblR4zb22jT/fWKPJftXoLoOyL9rVb5Qa9KSIVGZuI1riSBghCNBm6xZA
         pWM0yMcR83fhpZKmPQkUSRAK0uShNrY21LltnF1mtKJql+JDAJP16qZo7la4Ka83DqOH
         EkKQ==
X-Gm-Message-State: ALoCoQmHGAc47ZV8ohsqzLkik/cqu2hBCi006FAFAukuwEDIY+bw2ici8mXDh+NOw/IICvsCx9Vk
X-Received: by 10.66.66.196 with SMTP id h4mr7410345pat.18.1409938233450;
        Fri, 05 Sep 2014 10:30:33 -0700 (PDT)
Received: from corp2gmr1-2.hot.corp.google.com (corp2gmr1-2.hot.corp.google.com [172.24.189.93])
        by gmr-mx.google.com with ESMTPS id n22si508800yhd.1.2014.09.05.10.30.33
        for <multiple recipients>
        (version=TLSv1.1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 05 Sep 2014 10:30:33 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com (abrestic.mtv.corp.google.com [172.22.65.70])
        by corp2gmr1-2.hot.corp.google.com (Postfix) with ESMTP id 195745A427D;
        Fri,  5 Sep 2014 10:30:33 -0700 (PDT)
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id D20692209EA; Fri,  5 Sep 2014 10:30:32 -0700 (PDT)
From:   Andrew Bresticker <abrestic@chromium.org>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>
Cc:     Andrew Bresticker <abrestic@chromium.org>,
        Jeffrey Deans <jeffrey.deans@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Arnd Bergmann <arnd@arndb.de>,
        John Crispin <blogic@openwrt.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 07/16] irqchip: mips-gic: Implement irq_set_type callback
Date:   Fri,  5 Sep 2014 10:30:09 -0700
Message-Id: <1409938218-9026-8-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
References: <1409938218-9026-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42437
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

Implement an irq_set_type callback for the GIC which is used to set
the polarity and trigger type of GIC interrupts.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
---
Changes from v1:
 - fixed polarity setting for edge-triggered interrupts
---
 arch/mips/include/asm/gic.h    |  9 +++++++
 drivers/irqchip/irq-mips-gic.c | 53 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 62 insertions(+)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index d7699cf..3beb4eb 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -23,6 +23,8 @@
 #define GIC_POL_NEG			0
 #define GIC_TRIG_EDGE			1
 #define GIC_TRIG_LEVEL			0
+#define GIC_TRIG_DUAL_ENABLE		1
+#define GIC_TRIG_DUAL_DISABLE		0
 
 #define MSK(n) ((1 << (n)) - 1)
 #define REG32(addr)		(*(volatile unsigned int *) (addr))
@@ -179,6 +181,13 @@
 		GIC_INTR_OFS(intr)), (1 << GIC_INTR_BIT(intr)), \
 		(trig) << GIC_INTR_BIT(intr))
 
+/* Dual edge triggering : Reset Value is always 0 */
+#define GIC_SH_SET_DUAL_OFS		0x0200
+#define GIC_SET_DUAL(intr, dual) \
+	GICBIS(GIC_REG_ADDR(SHARED, GIC_SH_SET_DUAL_OFS + \
+		GIC_INTR_OFS(intr)), (1 << GIC_INTR_BIT(intr)), \
+		(dual) << GIC_INTR_BIT(intr))
+
 /* Mask manipulation */
 #define GIC_SH_SMASK_OFS		0x0380
 #define GIC_SET_INTR_MASK(intr) \
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 9e9d8b9..f29bb4e 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -44,6 +44,8 @@ static struct gic_pcpu_mask pcpu_masks[NR_CPUS];
 static struct gic_pending_regs pending_regs[NR_CPUS];
 static struct gic_intrmask_regs intrmask_regs[NR_CPUS];
 
+static struct irq_chip gic_irq_controller;
+
 #if defined(CONFIG_CSRC_GIC) || defined(CONFIG_CEVT_GIC)
 cycle_t gic_read_count(void)
 {
@@ -237,6 +239,56 @@ static void gic_unmask_irq(struct irq_data *d)
 	GIC_SET_INTR_MASK(d->irq - gic_irq_base);
 }
 
+static int gic_set_type(struct irq_data *d, unsigned int type)
+{
+	unsigned int irq = d->irq - gic_irq_base;
+	bool is_edge;
+
+	switch (type & IRQ_TYPE_SENSE_MASK) {
+	case IRQ_TYPE_EDGE_FALLING:
+		GIC_SET_POLARITY(irq, GIC_POL_NEG);
+		GIC_SET_TRIGGER(irq, GIC_TRIG_EDGE);
+		GIC_SET_DUAL(irq, GIC_TRIG_DUAL_DISABLE);
+		is_edge = true;
+		break;
+	case IRQ_TYPE_EDGE_RISING:
+		GIC_SET_POLARITY(irq, GIC_POL_POS);
+		GIC_SET_TRIGGER(irq, GIC_TRIG_EDGE);
+		GIC_SET_DUAL(irq, GIC_TRIG_DUAL_DISABLE);
+		is_edge = true;
+		break;
+	case IRQ_TYPE_EDGE_BOTH:
+		/* polarity is irrelevant in this case */
+		GIC_SET_TRIGGER(irq, GIC_TRIG_EDGE);
+		GIC_SET_DUAL(irq, GIC_TRIG_DUAL_ENABLE);
+		is_edge = true;
+		break;
+	case IRQ_TYPE_LEVEL_LOW:
+		GIC_SET_POLARITY(irq, GIC_POL_NEG);
+		GIC_SET_TRIGGER(irq, GIC_TRIG_LEVEL);
+		GIC_SET_DUAL(irq, GIC_TRIG_DUAL_DISABLE);
+		is_edge = false;
+		break;
+	case IRQ_TYPE_LEVEL_HIGH:
+	default:
+		GIC_SET_POLARITY(irq, GIC_POL_POS);
+		GIC_SET_TRIGGER(irq, GIC_TRIG_LEVEL);
+		GIC_SET_DUAL(irq, GIC_TRIG_DUAL_DISABLE);
+		is_edge = false;
+		break;
+	}
+
+	if (is_edge) {
+		gic_irq_flags[irq] |= GIC_TRIG_EDGE;
+		__irq_set_handler_locked(d->irq, handle_edge_irq);
+	} else {
+		gic_irq_flags[irq] &= ~GIC_TRIG_EDGE;
+		__irq_set_handler_locked(d->irq, handle_level_irq);
+	}
+
+	return 0;
+}
+
 #ifdef CONFIG_SMP
 static DEFINE_SPINLOCK(gic_lock);
 
@@ -277,6 +329,7 @@ static struct irq_chip gic_irq_controller = {
 	.irq_mask_ack		=	gic_mask_irq,
 	.irq_unmask		=	gic_unmask_irq,
 	.irq_eoi		=	gic_finish_irq,
+	.irq_set_type		=	gic_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	=	gic_set_affinity,
 #endif
-- 
2.1.0.rc2.206.gedb03e5
