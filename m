Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:55:58 +0200 (CEST)
Received: from mail-ig0-f201.google.com ([209.85.213.201]:60732 "EHLO
        mail-ig0-f201.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009007AbaIOXvsFqw7H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:48 +0200
Received: by mail-ig0-f201.google.com with SMTP id l13so704562iga.0
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qm8UsnV58+N1zLdRYMbT/mSQGyYFIs3eMncr4P1Aghs=;
        b=gIRCfxFkNGkd3F735iEFtEqQxuq2XSqG07s5ugYL4yYztkI/9RGhEG5djz/j53PdkO
         TtXCARkKMSgejSiOKJDPsqjBdlwHe8ePzcepGGWiYU+l1vG+//ROrRju4gHNb9sOuzL7
         ZuFE/+Blfv/xc0F6gBd86tXR9YwLjkSTwUQx0GJqA4HNT/dzQjGbZ8zSahS+jLvMz6ii
         tcFlZpKTsLOhVkbcowck31fjmYYsgbiUicvVxje2xC5nl3fs6JdhFz6NxO8gEeEhFe1d
         vMuchlKm88Hj44QvHn07Fbc/x5fJMEmj7SZtAQ/1rvtQ/rJyXc+XYlJLZcD2tngix7MK
         VzWw==
X-Gm-Message-State: ALoCoQlMhPGacuqalVLuAWte3PONh8uaMCEY8dLeKmVhFnMf3IeIobnHIU7L1trV0J2Gx4v2wISb
X-Received: by 10.183.3.4 with SMTP id bs4mr3203290obd.47.1410825102279;
        Mon, 15 Sep 2014 16:51:42 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id n63si629296yho.5.2014.09.15.16.51.41
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:42 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id Mdj9PTay.4; Mon, 15 Sep 2014 16:51:42 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 111C9220868; Mon, 15 Sep 2014 16:51:41 -0700 (PDT)
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
Subject: [PATCH 15/24] irqchip: mips-gic: Implement irq_set_type callback
Date:   Mon, 15 Sep 2014 16:51:18 -0700
Message-Id: <1410825087-5497-16-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42633
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
 arch/mips/include/asm/gic.h    |  9 ++++++++
 drivers/irqchip/irq-mips-gic.c | 51 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 1bf7985..662b567 100644
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
index 0dc2972..cde743c 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -246,6 +246,56 @@ static void gic_ack_irq(struct irq_data *d)
 		GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), d->irq - gic_irq_base);
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
 
@@ -286,6 +336,7 @@ static struct irq_chip gic_irq_controller = {
 	.irq_mask_ack		=	gic_ack_irq,
 	.irq_unmask		=	gic_unmask_irq,
 	.irq_eoi		=	gic_unmask_irq,
+	.irq_set_type		=	gic_set_type,
 #ifdef CONFIG_SMP
 	.irq_set_affinity	=	gic_set_affinity,
 #endif
-- 
2.1.0.rc2.206.gedb03e5
