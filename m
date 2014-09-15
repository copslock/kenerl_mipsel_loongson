Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Sep 2014 01:57:24 +0200 (CEST)
Received: from mail-pa0-f73.google.com ([209.85.220.73]:52859 "EHLO
        mail-pa0-f73.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009035AbaIOXvvDd31y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Sep 2014 01:51:51 +0200
Received: by mail-pa0-f73.google.com with SMTP id kx10so1030126pab.2
        for <linux-mips@linux-mips.org>; Mon, 15 Sep 2014 16:51:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4YIkTB2ATdMrKPYiu6cgNhEk50NvZ/VOAqPvdDp4S7g=;
        b=V6ViJn8KpaM928kxkM9B1TGg141ElJoWlpK1/Ayk8h85N0WJihlwT9dUm9DjfGESuc
         pflUI1W/rAzHPaDyOlYgwgwhQtzlvsrZcPjoPc4UNbKK4ZSV0RAAYOXljuFT7pJiNmZO
         zMszrCcfg3MXmo+i2BhdCZZHP++yUCcFPy4JtvsMeMzupCqw4udFR8pBB0rH693nM+EZ
         Aj9c2SezYR39B/pYzL2Yqlace9GQJwzQUXJI3unaIisGbiKzeNBpX9a8Hj1wupLZtqyW
         r8MJAjUuhbFJBi3DighvikvmOWzqgyv7PFEKEyb+jjNlmB6Sp7VxASgKETDUcKt9kYjA
         +9DQ==
X-Gm-Message-State: ALoCoQn5WAPVPKq0wWEZc3sOPbtX6lFmOqEKyySSUtonfzSV/CTfaHlIu/A4jE2UpU5x24ZxJ/ju
X-Received: by 10.70.15.97 with SMTP id w1mr17177499pdc.2.1410825105075;
        Mon, 15 Sep 2014 16:51:45 -0700 (PDT)
Received: from corpmail-nozzle1-1.hot.corp.google.com ([100.108.1.104])
        by gmr-mx.google.com with ESMTPS id t28si630005yhb.4.2014.09.15.16.51.44
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 15 Sep 2014 16:51:45 -0700 (PDT)
Received: from abrestic.mtv.corp.google.com ([172.22.65.70])
        by corpmail-nozzle1-1.hot.corp.google.com with ESMTP id 1oB1jrOM.4; Mon, 15 Sep 2014 16:51:44 -0700
Received: by abrestic.mtv.corp.google.com (Postfix, from userid 137652)
        id D35C1220984; Mon, 15 Sep 2014 16:51:43 -0700 (PDT)
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
Subject: [PATCH 20/24] irqchip: mips-gic: Use separate edge/level irq_chips
Date:   Mon, 15 Sep 2014 16:51:23 -0700
Message-Id: <1410825087-5497-21-git-send-email-abrestic@chromium.org>
X-Mailer: git-send-email 2.1.0.rc2.206.gedb03e5
In-Reply-To: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
References: <1410825087-5497-1-git-send-email-abrestic@chromium.org>
Return-Path: <abrestic@google.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42638
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
---
 arch/mips/include/asm/gic.h    |  1 -
 drivers/irqchip/irq-mips-gic.c | 38 ++++++++++++++++++++++++--------------
 2 files changed, 24 insertions(+), 15 deletions(-)

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
index c9ba102..6682a4e 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -24,7 +24,6 @@
 unsigned int gic_frequency;
 unsigned int gic_present;
 unsigned long _gic_base;
-unsigned int gic_irq_flags[GIC_NUM_INTRS];
 unsigned int gic_cpu_pin;
 
 struct gic_pcpu_mask {
@@ -44,6 +43,7 @@ static struct gic_pending_regs pending_regs[NR_CPUS];
 static struct gic_intrmask_regs intrmask_regs[NR_CPUS];
 static struct irq_domain *gic_irq_domain;
 static int gic_shared_intrs;
+static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 
 static void __gic_irq_dispatch(void);
 
@@ -228,11 +228,7 @@ static void gic_ack_irq(struct irq_data *d)
 {
 	unsigned int irq = d->hwirq;
 
-	GIC_CLR_INTR_MASK(irq);
-
-	/* Clear edge detector */
-	if (gic_irq_flags[irq] & GIC_TRIG_EDGE)
-		GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
+	GICWRITE(GIC_REG(SHARED, GIC_SH_WEDGE), irq);
 }
 
 static int gic_set_type(struct irq_data *d, unsigned int type)
@@ -275,11 +271,13 @@ static int gic_set_type(struct irq_data *d, unsigned int type)
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
 
 	return 0;
@@ -318,11 +316,23 @@ static int gic_set_affinity(struct irq_data *d, const struct cpumask *cpumask,
 }
 #endif
 
-static struct irq_chip gic_irq_controller = {
+static struct irq_chip gic_level_irq_controller = {
+	.name			=	"MIPS GIC",
+	.irq_ack		=	gic_mask_irq,
+	.irq_mask		=	gic_mask_irq,
+	.irq_mask_ack		=	gic_mask_irq,
+	.irq_unmask		=	gic_unmask_irq,
+	.irq_eoi		=	gic_unmask_irq,
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
-	.irq_mask_ack		=	gic_ack_irq,
 	.irq_unmask		=	gic_unmask_irq,
 	.irq_eoi		=	gic_unmask_irq,
 	.irq_set_type		=	gic_set_type,
@@ -433,7 +443,6 @@ static void __init gic_basic_init(int numvpes)
 		GIC_SET_POLARITY(i, GIC_POL_POS);
 		GIC_SET_TRIGGER(i, GIC_TRIG_LEVEL);
 		GIC_CLR_INTR_MASK(i);
-		gic_irq_flags[i] = 0;
 	}
 
 	vpe_local_setup(numvpes);
@@ -442,7 +451,8 @@ static void __init gic_basic_init(int numvpes)
 static int gic_irq_domain_map(struct irq_domain *d, unsigned int virq,
 			      irq_hw_number_t hw)
 {
-	irq_set_chip_and_handler(virq, &gic_irq_controller, handle_level_irq);
+	irq_set_chip_and_handler(virq, &gic_level_irq_controller,
+				 handle_level_irq);
 
 	GICWRITE(GIC_REG_ADDR(SHARED, GIC_SH_MAP_TO_PIN(hw)),
 		 GIC_MAP_TO_PIN_MSK | gic_cpu_pin);
-- 
2.1.0.rc2.206.gedb03e5
