Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Sep 2014 23:53:50 +0200 (CEST)
Received: from mail-ig0-f202.google.com ([209.85.213.202]:35266 "EHLO
        mail-ig0-f202.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009264AbaIRVrwS0LnH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Sep 2014 23:47:52 +0200
Received: by mail-ig0-f202.google.com with SMTP id h15so354783igd.1
        for <linux-mips@linux-mips.org>; Thu, 18 Sep 2014 14:47:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=EdHgFA93+Hmt9WXlTry/Oql9nUzLuPa096D2uI+k5po=;
        b=itHs7yeGYWlOBZ8JsKEpFl24C4NBXvV+ONbP2Asx7A8Rdfa+t3z146YyCGzu+McA/R
         mY0YLWLIBJCPWBIojflhSDMbWHDNMRBJPBy7Rq/WE7i7vjSpqisYVGHGg/gBCxosFazM
         fEctOAhRYRuQ2A1SCF1rM1QNqBH7RHfHj9Oc3c2VnPDM31cKUW6kjcBt2q/kLSWZRXTk
         N39VZ5Y5QG7W2enCP95gWqdFUkrQWYKTSayHv6+I6zdwpuQiM4SJrcVBCSRuTx8W6x13
         heJo4SNMTrxRwIkDTCZrxzjkjCLtQkOk44OhS7lxD/4vms9y5wE2N+Mil86nf2HbKAra
         saLQ==
X-Gm-Message-State: ALoCoQkwVaxi/2iwUT+2uyTcEv+IruBB2wacKFUtYkkR7wn9C/vBXQRe4KasI6DtYg2yjjSe2Dza
X-Received: by 10.182.230.133 with SMTP id sy5mr1232668obc.22.1411076866583;
        Thu, 18 Sep 2014 14:47:46 -0700 (PDT)
Received: from corpmail-nozzle1-2.hot.corp.google.com ([100.108.1.103])
        by gmr-mx.google.com with ESMTPS id m14si1196yhm.7.2014.09.18.14.47.45
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 18 Sep 2014 14:47:46 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-2.hot.corp.google.com with ESMTP id lBwURzVy.6; Thu, 18 Sep 2014 14:47:46 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id 67132220CC1; Thu, 18 Sep 2014 14:47:45 -0700 (PDT)
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
Subject: [PATCH V2 20/24] irqchip: mips-gic: Use separate edge/level irq_chips
Date:   Thu, 18 Sep 2014 14:47:26 -0700
Message-Id: <1411076851-28242-21-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
References: <1411076851-28242-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42700
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

GIC edge-triggered interrupts must be acknowledged by clearing the edge
detector via a write to GIC_SH_WEDGE.  Create a separate edge-triggered
irq_chip with the appropriate irq_ack() callback.  This also allows us
to get rid of gic_irq_flags.

Signed-off-by: Andrew Bresticker <abrestic@chromium.org>
Acked-by: Jason Cooper <jason@lakedaemon.net>
Reviewed-by: Qais Yousef <qais.yousef@imgtec.com>
Tested-by: Qais Yousef <qais.yousef@imgtec.com>
---
Changes from v1:
 - removed unnecessary irq_mask_ack, irq_ack, and irq_eoi callbacks
---
 arch/mips/include/asm/gic.h    |  1 -
 drivers/irqchip/irq-mips-gic.c | 32 +++++++++++++++++++++-----------
 2 files changed, 21 insertions(+), 12 deletions(-)

diff --git a/arch/mips/include/asm/gic.h b/arch/mips/include/asm/gic.h
index 8d1e457..f245395 100644
--- a/arch/mips/include/asm/gic.h
+++ b/arch/mips/include/asm/gic.h
@@ -345,7 +345,6 @@
 extern unsigned int gic_present;
 extern unsigned int gic_frequency;
 extern unsigned long _gic_base;
-extern unsigned int gic_irq_flags[];
 extern unsigned int gic_cpu_pin;
 
 extern void gic_init(unsigned long gic_base_addr,
diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 1349427..bfe8bfb 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -24,7 +24,6 @@
 unsigned int gic_frequency;
 unsigned int gic_present;
 unsigned long _gic_base;
-unsigned int gic_irq_flags[GIC_NUM_INTRS];
 unsigned int gic_cpu_pin;
 
 struct gic_pcpu_mask {
@@ -45,6 +44,7 @@ static struct gic_intrmask_regs intrmask_regs[NR_CPUS];
 static DEFINE_SPINLOCK(gic_lock);
 static struct irq_domain *gic_irq_domain;
 static int gic_shared_intrs;
+static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 
 static void __gic_irq_dispatch(void);
 
@@ -229,9 +229,7 @@ static void gic_ack_irq(struct irq_data *d)
 {
 	unsigned int irq = d->hwirq;
 
-	/* Clear edge detector */
-	if (gic_irq_flags[irq] & GIC_TRIG_EDGE)
-		GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
+	GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
 }
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
@@ -276,11 +274,13 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
 	}
 
 	if (is_edge) {
-		gic_irq_flags[irq] |= GIC_TRIG_EDGE;
-		__irq_set_handler_locked(d->irq, handle_edge_irq);
+		__irq_set_chip_handler_name_locked(d->irq,
+						   &gic_edge_irq_controller,
+						   handle_edge_irq, NULL);
 	} else {
-		gic_irq_flags[irq] &= ~GIC_TRIG_EDGE;
-		__irq_set_handler_locked(d->irq, handle_level_irq);
+		__irq_set_chip_handler_name_locked(d->irq,
+						   &gic_level_irq_controller,
+						   handle_level_irq, NULL);
 	}
 	spin_unlock_irqrestore(&gic_lock, flags);
 
@@ -318,7 +318,17 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 }
 #endif
 
-static struct irq_chip gic_irq_controller = {
+static struct irq_chip gic_level_irq_controller = {
+	.name			=	"MIPS GIC",
+	.irq_mask		=	gic_mask_irq,
+	.irq_unmask		=	gic_unmask_irq,
+	.irq_set_type		=	gic_set_type,
+#ifdef CONFIG_SMP
+	.irq_set_affinity	=	gic_set_affinity,
+#endif
+};
+
+static struct irq_chip gic_edge_irq_controller = {
 	.name			=	"MIPS GIC",
 	.irq_ack		=	gic_ack_irq,
 	.irq_mask		=	gic_mask_irq,
@@ -431,7 +441,6 @@ static void __init gic_basic_init(int numvpes)
 		GIC_SET_POLARITY(i, GIC_POL_POS);
 		GIC_SET_TRIGGER(i, GIC_TRIG_LEVEL);
 		GIC_CLR_INTR_MASK(i);
-		gic_irq_flags[i] = 0;
 	}
 
 	vpe_local_setup(numvpes);
@@ -442,7 +451,8 @@ static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 {
 	unsigned long flags;
 
-	irq_set_chip_and_handler(virq, &gic_irq_controller, handle_level_irq);
+	irq_set_chip_and_handler(virq, &gic_level_irq_controller,
+				 handle_level_irq);
 
 	spin_lock_irqsave(&gic_lock, flags);
 	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_PIN(hw)),
-- 
2.1.0.rc2.206.gedb03e5
