Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 19 Jan 2015 16:38:53 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:44549 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011834AbbASPiwLjH3W (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 19 Jan 2015 16:38:52 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id AA5E3FDD6C2EC;
        Mon, 19 Jan 2015 15:38:42 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 19 Jan 2015 15:38:45 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 19 Jan 2015 15:38:45 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Andrew Bresticker <abrestic@chromium.org>,
        Qais Yousef <qais.yousef@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "Thomas Gleixner" <tglx@linutronix.de>
Subject: [PATCH] irqchip: mips-gic: Avoid rerouting timer IRQs for smp-cmp
Date:   Mon, 19 Jan 2015 15:38:24 +0000
Message-ID: <1421681904-20881-1-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.0.5
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45316
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Commit e9de688dac65 ("irqchip: mips-gic: Support local interrupts")
changed the GIC irqchip driver so that all local interrupts were routed
to the same CPU pin used for external interrupts. Unfortunately this
causes a regression when smp-cmp is used. The CPUs are started by the
bootloader and put in a timer based waiting poll loop, but when their
timer interrupts are rerouted to a different IRQ pin which is not
unmasked they never wake up.

Since smp-cmp support is deprecated and everybody who was using it
should be switching to smp-cps which brings up the secondary CPUs
without bootloader assistance, I've gone for the simple fix which can be
easily removed once smp-cmp is removed, rather than a fully generic fix.

In __gic_init() the local GIC_VPE_TIMER_MAP register is read to find the
boot-time routing of the local timer interrupt, and a chained handler is
added to that CPU pin as well as the normal one.

Fixes: e9de688dac65 ("irqchip: mips-gic: Support local interrupts")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Andrew Bresticker <abrestic@chromium.org>
Cc: Qais Yousef <qais.yousef@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-mips@linux-mips.org
---
 drivers/irqchip/irq-mips-gic.c | 27 +++++++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/irqchip/irq-mips-gic.c b/drivers/irqchip/irq-mips-gic.c
index 2b0468e3df6a..56b96c63dc4b 100644
--- a/drivers/irqchip/irq-mips-gic.c
+++ b/drivers/irqchip/irq-mips-gic.c
@@ -37,6 +37,7 @@ static struct irq_domain *gic_irq_domain;
 static int gic_shared_intrs;
 static int gic_vpes;
 static unsigned int gic_cpu_pin;
+static unsigned int timer_cpu_pin;
 static struct irq_chip gic_level_irq_controller, gic_edge_irq_controller;
 
 static void __gic_irq_dispatch(void);
@@ -616,6 +617,8 @@ static int gic_local_irq_domain_map(struct irq_domain *d, unsigned int virq,
 			gic_write(GIC_REG(VPE_OTHER, GIC_VPE_COMPARE_MAP), val);
 			break;
 		case GIC_LOCAL_INT_TIMER:
+			/* CONFIG_MIPS_CMP workaround (see __gic_init) */
+			val = GIC_MAP_TO_PIN_MSK | timer_cpu_pin;
 			gic_write(GIC_REG(VPE_OTHER, GIC_VPE_TIMER_MAP), val);
 			break;
 		case GIC_LOCAL_INT_PERFCTR:
@@ -713,12 +716,36 @@ static void __init __gic_init(unsigned long gic_base_addr,
 	if (cpu_has_veic) {
 		/* Always use vector 1 in EIC mode */
 		gic_cpu_pin = 0;
+		timer_cpu_pin = gic_cpu_pin;
 		set_vi_handler(gic_cpu_pin + GIC_PIN_TO_VEC_OFFSET,
 			       __gic_irq_dispatch);
 	} else {
 		gic_cpu_pin = cpu_vec - GIC_CPU_PIN_OFFSET;
 		irq_set_chained_handler(MIPS_CPU_IRQ_BASE + cpu_vec,
 					gic_irq_dispatch);
+		/*
+		 * With the CMP implementation of SMP (deprecated), other CPUs
+		 * are started by the bootloader and put into a timer based
+		 * waiting poll loop. We must not re-route those CPU's local
+		 * timer interrupts as the wait instruction will never finish,
+		 * so just handle whatever CPU interrupt it is routed to by
+		 * default.
+		 *
+		 * This workaround should be removed when CMP support is
+		 * dropped.
+		 */
+		if (IS_ENABLED(CONFIG_MIPS_CMP) &&
+		    gic_local_irq_is_routable(GIC_LOCAL_INT_TIMER)) {
+			timer_cpu_pin = gic_read(GIC_REG(VPE_LOCAL,
+							 GIC_VPE_TIMER_MAP)) &
+					GIC_MAP_MSK;
+			irq_set_chained_handler(MIPS_CPU_IRQ_BASE +
+						GIC_CPU_PIN_OFFSET +
+						timer_cpu_pin,
+						gic_irq_dispatch);
+		} else {
+			timer_cpu_pin = gic_cpu_pin;
+		}
 	}
 
 	gic_irq_domain = irq_domain_add_simple(node, GIC_NUM_LOCAL_INTRS +
-- 
2.0.5
