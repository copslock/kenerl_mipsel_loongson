Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Sep 2017 01:27:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:46407 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994818AbdIGX0nlfO8k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Sep 2017 01:26:43 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id D960DB84B0220;
        Fri,  8 Sep 2017 00:26:31 +0100 (IST)
Received: from localhost (10.20.1.88) by hhmail02.hh.imgtec.org (10.100.10.21)
 with Microsoft SMTP Server (TLS) id 14.3.294.0; Fri, 8 Sep 2017 00:26:36
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
Subject: [RFC PATCH v1 2/9] genirq: Support shared per_cpu_devid interrupts
Date:   Thu, 7 Sep 2017 16:25:35 -0700
Message-ID: <20170907232542.20589-3-paul.burton@imgtec.com>
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
X-archive-position: 59956
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

Up until now per_cpu_devid interrupts have not supported sharing. On
MIPS we have some percpu interrupts which are shared in many systems -
a single CPU interrupt line may be used to indicate a timer interrupt,
performance counter interrupt or fast debug channel interrupt. We have
up until now supported this with a series of hacks, wherein drivers call
each other's interrupt handlers & our MIPS GIC irqchip driver includes a
hack which configures the interrupt(s) for all CPUs. In order to allow
this mess to be cleaned up, this patch introduces support for shared
per_cpu_devid interrupts.

The major portion of this is supporting per_cpu_devid interrupts in
__handle_irq_event_percpu() and then making use of this, via
handle_irq_event_percpu(), from handler_percpu_devif_irq() to invoke the
handler for all actions associated with the shared interrupt. This does
have a few side effects worth noting:

 - per_cpu_devid interrupts will now add to the entropy pool via
   add_interrupt_randomness(), where they previously did not.

 - per_cpu_devid interrupts will record timings when IRQS_TIMINGS is
   set, via record_irq_time(), where they previously did not.

 - per_cpu_devid interrupts will handle an IRQ_WAKE_THREAD return from
   their handlers to wake a thread, where they previously did not.

I'm not aware of any reason the above should be bad side effects, so
sharing __handle_irq_event_percpu() for per_cpu_devid interrupts seems
like a positive.

The other area that requires work for shared per_cpu_devid interrupts is
__free_percpu_irq() which is adjusted to support removing the correct
struct irqaction from the list pointed to by the action field of struct
irqdesc, where it previously presumed only one action is present. The
new behaviour mirrors that of __free_irq().

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Jason Cooper <jason@lakedaemon.net>
Cc: Marc Zyngier <marc.zyngier@arm.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
---

 kernel/irq/chip.c   |  8 ++------
 kernel/irq/handle.c |  8 +++++++-
 kernel/irq/manage.c | 28 +++++++++++++++++++++-------
 3 files changed, 30 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/chip.c b/kernel/irq/chip.c
index f51b7b6d2451..063a125059b5 100644
--- a/kernel/irq/chip.c
+++ b/kernel/irq/chip.c
@@ -859,7 +859,6 @@ void handle_percpu_irq(struct irq_desc *desc)
 void handle_percpu_devid_irq(struct irq_desc *desc)
 {
 	struct irq_chip *chip = irq_desc_get_chip(desc);
-	struct irqaction *action = desc->action;
 	unsigned int irq = irq_desc_get_irq(desc);
 	irqreturn_t res;
 
@@ -868,11 +867,8 @@ void handle_percpu_devid_irq(struct irq_desc *desc)
 	if (chip->irq_ack)
 		chip->irq_ack(&desc->irq_data);
 
-	if (likely(action)) {
-		trace_irq_handler_entry(irq, action);
-		res = action->handler(irq, raw_cpu_ptr(action->percpu_dev_id));
-		trace_irq_handler_exit(irq, action, res);
-	} else {
+	res = handle_irq_event_percpu(desc);
+	if (unlikely(res == IRQ_NONE)) {
 		unsigned int cpu = smp_processor_id();
 		bool enabled = cpumask_test_cpu(cpu, desc->percpu_enabled);
 
diff --git a/kernel/irq/handle.c b/kernel/irq/handle.c
index 79f987b942b8..f0309679f2c8 100644
--- a/kernel/irq/handle.c
+++ b/kernel/irq/handle.c
@@ -142,9 +142,15 @@ irqreturn_t __handle_irq_event_percpu(struct irq_desc *desc, unsigned int *flags
 
 	for_each_action_of_desc(desc, action) {
 		irqreturn_t res;
+		void *dev_id;
+
+		if (irq_settings_is_per_cpu_devid(desc))
+			dev_id = raw_cpu_ptr(action->percpu_dev_id);
+		else
+			dev_id = action->dev_id;
 
 		trace_irq_handler_entry(irq, action);
-		res = action->handler(irq, action->dev_id);
+		res = action->handler(irq, dev_id);
 		trace_irq_handler_exit(irq, action, res);
 
 		if (WARN_ONCE(!irqs_disabled(),"irq %u handler %pF enabled interrupts\n",
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index fb5445a4a359..6b8a34971a0f 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -1929,7 +1929,7 @@ EXPORT_SYMBOL_GPL(disable_percpu_irq);
 static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_id)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
-	struct irqaction *action;
+	struct irqaction *action, **action_ptr;
 	unsigned long flags;
 
 	WARN(in_interrupt(), "Trying to free IRQ %d from IRQ context!\n", irq);
@@ -1939,20 +1939,34 @@ static struct irqaction *__free_percpu_irq(unsigned int irq, void __percpu *dev_
 
 	raw_spin_lock_irqsave(&desc->lock, flags);
 
-	action = desc->action;
-	if (!action || action->percpu_dev_id != dev_id) {
-		WARN(1, "Trying to free already-free IRQ %d\n", irq);
-		goto bad;
+	/*
+	 * There can be multiple actions per IRQ descriptor, find the right
+	 * one based on the dev_id:
+	 */
+	action_ptr = &desc->action;
+	for (;;) {
+		action = *action_ptr;
+
+		if (!action) {
+			WARN(1, "Trying to free already-free IRQ %d\n", irq);
+			goto bad;
+		}
+
+		if (action->percpu_dev_id == dev_id)
+			break;
+		action_ptr = &action->next;
 	}
 
-	if (!cpumask_empty(desc->percpu_enabled)) {
+	if ((action_ptr == &desc->action) &&
+	    !action->next &&
+	    !cpumask_empty(desc->percpu_enabled)) {
 		WARN(1, "percpu IRQ %d still enabled on CPU%d!\n",
 		     irq, cpumask_first(desc->percpu_enabled));
 		goto bad;
 	}
 
 	/* Found it - now remove it from the list of entries: */
-	desc->action = NULL;
+	*action_ptr = action->next;
 
 	raw_spin_unlock_irqrestore(&desc->lock, flags);
 
-- 
2.14.1
