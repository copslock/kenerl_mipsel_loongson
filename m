Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Sep 2017 01:26:48 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10333 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994806AbdIGX00cbZgk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Sep 2017 01:26:26 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 4B6B0D89A3BB2;
        Fri,  8 Sep 2017 00:26:14 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 8 Sep 2017 00:26:18
 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Thomas Gleixner <tglx@linutronix.de>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     <dianders@chromium.org>, James Hogan <james.hogan@imgtec.com>,
        Brian Norris <briannorris@chromium.org>,
        Jason Cooper <jason@lakedaemon.net>,
        <jeffy.chen@rock-chips.com>, Marc Zyngier <marc.zyngier@arm.com>,
        <linux-kernel@vger.kernel.org>, <linux-mips@linux-mips.org>,
        <tfiga@chromium.org>, Paul Burton <paul.burton@imgtec.com>
Subject: [RFC PATCH v1 1/9] genirq: Allow shared interrupt users to opt into IRQ_NOAUTOEN
Date:   Thu, 7 Sep 2017 16:25:34 -0700
Message-ID: <20170907232542.20589-2-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20170907232542.20589-1-paul.burton@imgtec.com>
References: <1682867.tATABVWsV9@np-p-burton>
 <20170907232542.20589-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.1.88]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59955
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Shared interrupts which aren't automatically enabled during setup (ie.
which have the IRQ_NOAUTOEN flag set) can be problematic if one or more
users of the shared interrupt aren't expecting the IRQ_NOAUTOEN
behaviour. This led to a warning being added when a combination of
IRQ_NOAUTOEN & IRQF_SHARED are used by commit 04c848d39879 ("genirq:
Warn when IRQ_NOAUTOEN is used with shared interrupts").

There are however legitimate cases where a shared interrupt which isn't
automatically enabled may make sense. One such case is shared percpu
interrupts, which we don't currently support but will with subsequent
patches. For percpu interrupts the IRQ_NOAUTOEN flag is automatically
set by irq_set_percpu_devid_flags() because it would be inconsistent to
automatically enable the interrupt on the CPU that calls
setup_percpu_irq() but not on others, and anything else would at best be
an expensive operation with few legitimate uses. The use of IRQ_NOAUTOEN
means that percpu interrupts cannot currently be shared without running
into the warning that commit 04c848d39879 ("genirq: Warn when
IRQ_NOAUTOEN is used with shared interrupts") introduced.

This patch allows for the future possibility of shared interrupts that
are not automatically enabled, by introducing an IRQF_NOAUTOEN flag
which users of a shared interrupt can set to state that they are
prepared for the IRQ_NOAUTOEN behaviour. We then require that all
actions associated with the shared interrupt share the same value for
the IRQF_NOAUTOEN flag, and that if IRQ_NOAUTOEN is set before any
actions with IRQF_SHARED are associated with the interrupt then any
actions without the IRQF_NOAUTOEN flag set are rejected, with
__setup_irq() returning -EINVAL.

In some ways this means that we go further than commit 04c848d39879
("genirq: Warn when IRQ_NOAUTOEN is used with shared interrupts") did,
in that any existing users of shared interrupts with IRQ_NOAUTOEN won't
only trigger a warning but will fail to setup their interrupt handler
entirely. In others this leaves us with an out for legitimate users
which will be able to opt-in to the IRQ_NOAUTOEN behaviour by setting
IRQF_NOAUTOEN.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---

 include/linux/interrupt.h |  2 ++
 kernel/irq/manage.c       | 58 ++++++++++++++++++++++++++++++++++++-----------
 kernel/irq/settings.h     |  5 ++++
 3 files changed, 52 insertions(+), 13 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 59ba11661b6e..a27e22275ca7 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -62,6 +62,7 @@
  *                interrupt handler after suspending interrupts. For system
  *                wakeup devices users need to implement wakeup detection in
  *                their interrupt handlers.
+ * IRQF_NOAUTOEN - Don't automatically enable the interrupt during setup.
  */
 #define IRQF_SHARED		0x00000080
 #define IRQF_PROBE_SHARED	0x00000100
@@ -75,6 +76,7 @@
 #define IRQF_NO_THREAD		0x00010000
 #define IRQF_EARLY_RESUME	0x00020000
 #define IRQF_COND_SUSPEND	0x00040000
+#define IRQF_NOAUTOEN		0x00080000
 
 #define IRQF_TIMER		(__IRQF_TIMER | IRQF_NO_SUSPEND | IRQF_NO_THREAD)
 
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 573dc52b0806..fb5445a4a359 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1229,15 +1229,19 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		 * agree on ONESHOT.
 		 */
 		unsigned int oldtype = irqd_get_trigger_type(&desc->irq_data);
+		unsigned int must_match;
+
+		/*
+		 * These flags must have the same value for all actions
+		 * registered for a shared interrupt.
+		 */
+		must_match = IRQF_ONESHOT |
+			     IRQF_PERCPU |
+			     IRQF_NOAUTOEN;
 
 		if (!((old->flags & new->flags) & IRQF_SHARED) ||
 		    (oldtype != (new->flags & IRQF_TRIGGER_MASK)) ||
-		    ((old->flags ^ new->flags) & IRQF_ONESHOT))
-			goto mismatch;
-
-		/* All handlers must agree on per-cpuness */
-		if ((old->flags & IRQF_PERCPU) !=
-		    (new->flags & IRQF_PERCPU))
+		    ((old->flags ^ new->flags) & must_match))
 			goto mismatch;
 
 		/* add new interrupt at end of irq queue */
@@ -1313,6 +1317,38 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 		goto out_unlock;
 	}
 
+	/*
+	 * Using shared interrupts with the IRQ_NOAUTOEN flag can be risky if
+	 * the flag is set when one or more of the drivers sharing the IRQ
+	 * don't expect it. For example if driver A does:
+	 *
+	 *   irq_set_status_flags(shared_irq, IRQ_NOAUTOEN);
+	 *   request_irq(shared_irq, handler_a, IRQF_SHARED, "a", dev_a);
+	 *
+	 * Then driver B does:
+	 *
+	 *   request_irq(shared_irq, handler_b, IRQF_SHARED, "b", dev_b);
+	 *
+	 * Driver B has no idea that driver A set the IRQ_NOAUTOEN flag, and
+	 * thus may expect that the shared_irq is enabled after its call to
+	 * request_irq(). It may then miss interrupts that it was expecting to
+	 * receive.
+	 *
+	 * We therefore require that if a shared IRQ is used with IRQ_NOAUTOEN
+	 * then all drivers sharing it explicitly declare that they are aware
+	 * of the fact that the interrupt won't be automatically enabled, by
+	 * setting the IRQF_NOAUTOEN flag in their struct irqaction or
+	 * providing it to request_irq().
+	 */
+	if (WARN((new->flags && IRQF_SHARED) &&
+		 !irq_settings_can_autoenable(desc) &&
+		 !(new->flags & IRQF_NOAUTOEN),
+		 "shared irq %d isn't automatically enabled, but the caller doesn't set IRQF_NOAUTOEN",
+		 irq)) {
+		ret = -EINVAL;
+		goto out_unlock;
+	}
+
 	if (!shared) {
 		init_waitqueue_head(&desc->wait_for_threads);
 
@@ -1343,16 +1379,12 @@ __setup_irq(unsigned int irq, struct irq_desc *desc, struct irqaction *new)
 			irqd_set(&desc->irq_data, IRQD_NO_BALANCING);
 		}
 
+		if (new->flags & IRQF_NOAUTOEN)
+			irq_settings_set_noautoenable(desc);
+
 		if (irq_settings_can_autoenable(desc)) {
 			irq_startup(desc, IRQ_RESEND, IRQ_START_COND);
 		} else {
-			/*
-			 * Shared interrupts do not go well with disabling
-			 * auto enable. The sharing interrupt might request
-			 * it while it's still disabled and then wait for
-			 * interrupts forever.
-			 */
-			WARN_ON_ONCE(new->flags & IRQF_SHARED);
 			/* Undo nested disables: */
 			desc->depth = 1;
 		}
diff --git a/kernel/irq/settings.h b/kernel/irq/settings.h
index 320579d89091..97edef1bd781 100644
--- a/kernel/irq/settings.h
+++ b/kernel/irq/settings.h
@@ -147,6 +147,11 @@ static inline bool irq_settings_can_autoenable(struct irq_desc *desc)
 	return !(desc->status_use_accessors & _IRQ_NOAUTOEN);
 }
 
+static inline void irq_settings_set_noautoenable(struct irq_desc *desc)
+{
+	desc->status_use_accessors |= _IRQ_NOAUTOEN;
+}
+
 static inline bool irq_settings_is_nested_thread(struct irq_desc *desc)
 {
 	return desc->status_use_accessors & _IRQ_NESTED_THREAD;
-- 
2.14.1
