Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Mar 2011 17:07:25 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:40398 "EHLO linutronix.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491825Ab1C1PG5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Mar 2011 17:06:57 +0200
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1Q4E1s-0001LU-3m; Mon, 28 Mar 2011 17:06:52 +0200
Message-Id: <20110328150627.585686541@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Mon, 28 Mar 2011 15:06:51 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: [patch 1/3] genirq: Move INPROGRESS,
        MASKED and DISABLED state flags to irq_data
References: <20110328150330.110780523@linutronix.de>
Content-Disposition: inline; filename=genirq-inprogress-check.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Return-Path: <tglx@linutronix.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29600
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips

We really need these flags for some of the interrupt chips. Move it
from internal state to irq_data and provide proper accessors.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Cc: David Daney <ddaney@caviumnetworks.com>
---
 include/linux/irq.h    |   17 +++++++++++++++--
 kernel/irq/chip.c      |   40 +++++++++++++++++++---------------------
 kernel/irq/debug.h     |   10 +++++++---
 kernel/irq/handle.c    |    4 ++--
 kernel/irq/internals.h |    6 ------
 kernel/irq/irqdesc.c   |    2 --
 kernel/irq/manage.c    |   30 ++++++++++++++----------------
 kernel/irq/migration.c |    4 ++--
 kernel/irq/spurious.c  |   10 +++++-----
 9 files changed, 64 insertions(+), 59 deletions(-)

Index: linux-2.6-tip/include/linux/irq.h
===================================================================
--- linux-2.6-tip.orig/include/linux/irq.h
+++ linux-2.6-tip/include/linux/irq.h
@@ -174,8 +174,9 @@ struct irq_data {
  *				  from suspend
  * IRDQ_MOVE_PCNTXT		- Interrupt can be moved in process
  *				  context
- * IRQD_IRQ_DISABLED		- Some chip function need to know the
- *				  disabled state.
+ * IRQD_IRQ_DISABLED		- Disabled state of the interrupt
+ * IRQD_IRQ_MASKED		- Masked state of the interrupt
+ * IRQD_IRQ_INPROGRESS		- In progress state of the interrupt
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -187,6 +188,8 @@ enum {
 	IRQD_WAKEUP_STATE		= (1 << 14),
 	IRQD_MOVE_PCNTXT		= (1 << 15),
 	IRQD_IRQ_DISABLED		= (1 << 16),
+	IRQD_IRQ_MASKED			= (1 << 17),
+	IRQD_IRQ_INPROGRESS		= (1 << 18),
 };
 
 static inline bool irqd_is_setaffinity_pending(struct irq_data *d)
@@ -243,6 +246,16 @@ static inline bool irqd_irq_disabled(str
 	return d->state_use_accessors & IRQD_IRQ_DISABLED;
 }
 
+static inline bool irqd_irq_masked(struct irq_data *d)
+{
+	return d->state_use_accessors & IRQD_IRQ_MASKED;
+}
+
+static inline bool irqd_irq_inprogress(struct irq_data *d)
+{
+	return d->state_use_accessors & IRQD_IRQ_INPROGRESS;
+}
+
 /**
  * struct irq_chip - hardware interrupt chip descriptor
  *
Index: linux-2.6-tip/kernel/irq/chip.c
===================================================================
--- linux-2.6-tip.orig/kernel/irq/chip.c
+++ linux-2.6-tip/kernel/irq/chip.c
@@ -140,27 +140,25 @@ EXPORT_SYMBOL_GPL(irq_get_irq_data);
 
 static void irq_state_clr_disabled(struct irq_desc *desc)
 {
-	desc->istate &= ~IRQS_DISABLED;
 	irqd_clear(&desc->irq_data, IRQD_IRQ_DISABLED);
 	irq_compat_clr_disabled(desc);
 }
 
 static void irq_state_set_disabled(struct irq_desc *desc)
 {
-	desc->istate |= IRQS_DISABLED;
 	irqd_set(&desc->irq_data, IRQD_IRQ_DISABLED);
 	irq_compat_set_disabled(desc);
 }
 
 static void irq_state_clr_masked(struct irq_desc *desc)
 {
-	desc->istate &= ~IRQS_MASKED;
+	irqd_clear(&desc->irq_data, IRQD_IRQ_MASKED);
 	irq_compat_clr_masked(desc);
 }
 
 static void irq_state_set_masked(struct irq_desc *desc)
 {
-	desc->istate |= IRQS_MASKED;
+	irqd_set(&desc->irq_data, IRQD_IRQ_MASKED);
 	irq_compat_set_masked(desc);
 }
 
@@ -380,11 +378,11 @@ void handle_nested_irq(unsigned int irq)
 	kstat_incr_irqs_this_cpu(irq, desc);
 
 	action = desc->action;
-	if (unlikely(!action || (desc->istate & IRQS_DISABLED)))
+	if (unlikely(!action || irqd_irq_disabled(&desc->irq_data)))
 		goto out_unlock;
 
 	irq_compat_set_progress(desc);
-	desc->istate |= IRQS_INPROGRESS;
+	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 	raw_spin_unlock_irq(&desc->lock);
 
 	action_ret = action->thread_fn(action->irq, action->dev_id);
@@ -392,7 +390,7 @@ void handle_nested_irq(unsigned int irq)
 		note_interrupt(irq, desc, action_ret);
 
 	raw_spin_lock_irq(&desc->lock);
-	desc->istate &= ~IRQS_INPROGRESS;
+	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 	irq_compat_clr_progress(desc);
 
 out_unlock:
@@ -424,14 +422,14 @@ handle_simple_irq(unsigned int irq, stru
 {
 	raw_spin_lock(&desc->lock);
 
-	if (unlikely(desc->istate & IRQS_INPROGRESS))
+	if (unlikely(irqd_irq_inprogress(&desc->irq_data)))
 		if (!irq_check_poll(desc))
 			goto out_unlock;
 
 	desc->istate &= ~(IRQS_REPLAY | IRQS_WAITING);
 	kstat_incr_irqs_this_cpu(irq, desc);
 
-	if (unlikely(!desc->action || (desc->istate & IRQS_DISABLED)))
+	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data)))
 		goto out_unlock;
 
 	handle_irq_event(desc);
@@ -456,7 +454,7 @@ handle_level_irq(unsigned int irq, struc
 	raw_spin_lock(&desc->lock);
 	mask_ack_irq(desc);
 
-	if (unlikely(desc->istate & IRQS_INPROGRESS))
+	if (unlikely(irqd_irq_inprogress(&desc->irq_data)))
 		if (!irq_check_poll(desc))
 			goto out_unlock;
 
@@ -467,12 +465,12 @@ handle_level_irq(unsigned int irq, struc
 	 * If its disabled or no action available
 	 * keep it masked and get out of here
 	 */
-	if (unlikely(!desc->action || (desc->istate & IRQS_DISABLED)))
+	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data)))
 		goto out_unlock;
 
 	handle_irq_event(desc);
 
-	if (!(desc->istate & (IRQS_DISABLED | IRQS_ONESHOT)))
+	if (!irqd_irq_disabled(&desc->irq_data) && !(desc->istate & IRQS_ONESHOT))
 		unmask_irq(desc);
 out_unlock:
 	raw_spin_unlock(&desc->lock);
@@ -504,7 +502,7 @@ handle_fasteoi_irq(unsigned int irq, str
 {
 	raw_spin_lock(&desc->lock);
 
-	if (unlikely(desc->istate & IRQS_INPROGRESS))
+	if (unlikely(irqd_irq_inprogress(&desc->irq_data)))
 		if (!irq_check_poll(desc))
 			goto out;
 
@@ -515,7 +513,7 @@ handle_fasteoi_irq(unsigned int irq, str
 	 * If its disabled or no action available
 	 * then mask it and get out of here:
 	 */
-	if (unlikely(!desc->action || (desc->istate & IRQS_DISABLED))) {
+	if (unlikely(!desc->action || irqd_irq_disabled(&desc->irq_data))) {
 		irq_compat_set_pending(desc);
 		desc->istate |= IRQS_PENDING;
 		mask_irq(desc);
@@ -566,8 +564,8 @@ handle_edge_irq(unsigned int irq, struct
 	 * we shouldn't process the IRQ. Mark it pending, handle
 	 * the necessary masking and go out
 	 */
-	if (unlikely((desc->istate & (IRQS_DISABLED | IRQS_INPROGRESS) ||
-		      !desc->action))) {
+	if (unlikely(irqd_irq_disabled(&desc->irq_data) ||
+		     irqd_irq_inprogress(&desc->irq_data) || !desc->action)) {
 		if (!irq_check_poll(desc)) {
 			irq_compat_set_pending(desc);
 			desc->istate |= IRQS_PENDING;
@@ -592,15 +590,15 @@ handle_edge_irq(unsigned int irq, struct
 		 * Renable it, if it was not disabled in meantime.
 		 */
 		if (unlikely(desc->istate & IRQS_PENDING)) {
-			if (!(desc->istate & IRQS_DISABLED) &&
-			    (desc->istate & IRQS_MASKED))
+			if (!irqd_irq_disabled(&desc->irq_data) &&
+			    irqd_irq_masked(&desc->irq_data))
 				unmask_irq(desc);
 		}
 
 		handle_irq_event(desc);
 
 	} while ((desc->istate & IRQS_PENDING) &&
-		 !(desc->istate & IRQS_DISABLED));
+		 !irqd_irq_disabled(&desc->irq_data));
 
 out_unlock:
 	raw_spin_unlock(&desc->lock);
@@ -720,7 +718,7 @@ void irq_cpu_online(void)
 		chip = irq_data_get_irq_chip(&desc->irq_data);
 		if (chip && chip->irq_cpu_online &&
 		    (!(chip->flags & IRQCHIP_ONOFFLINE_ENABLED) ||
-		     !(desc->istate & IRQS_DISABLED)))
+		     !irqd_irq_disabled(&desc->irq_data)))
 			chip->irq_cpu_online(&desc->irq_data);
 
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
@@ -750,7 +748,7 @@ void irq_cpu_offline(void)
 		chip = irq_data_get_irq_chip(&desc->irq_data);
 		if (chip && chip->irq_cpu_offline &&
 		    (!(chip->flags & IRQCHIP_ONOFFLINE_ENABLED) ||
-		     !(desc->istate & IRQS_DISABLED)))
+		     !irqd_irq_disabled(&desc->irq_data)))
 			chip->irq_cpu_offline(&desc->irq_data);
 
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
Index: linux-2.6-tip/kernel/irq/debug.h
===================================================================
--- linux-2.6-tip.orig/kernel/irq/debug.h
+++ linux-2.6-tip/kernel/irq/debug.h
@@ -6,6 +6,8 @@
 
 #define P(f) if (desc->status & f) printk("%14s set\n", #f)
 #define PS(f) if (desc->istate & f) printk("%14s set\n", #f)
+/* FIXME */
+#define PD(f) do { } while (0)
 
 static inline void print_irq_desc(unsigned int irq, struct irq_desc *desc)
 {
@@ -28,13 +30,15 @@ static inline void print_irq_desc(unsign
 	P(IRQ_NOAUTOEN);
 
 	PS(IRQS_AUTODETECT);
-	PS(IRQS_INPROGRESS);
 	PS(IRQS_REPLAY);
 	PS(IRQS_WAITING);
-	PS(IRQS_DISABLED);
 	PS(IRQS_PENDING);
-	PS(IRQS_MASKED);
+
+	PD(IRQS_INPROGRESS);
+	PD(IRQS_DISABLED);
+	PD(IRQS_MASKED);
 }
 
 #undef P
 #undef PS
+#undef PD
Index: linux-2.6-tip/kernel/irq/handle.c
===================================================================
--- linux-2.6-tip.orig/kernel/irq/handle.c
+++ linux-2.6-tip/kernel/irq/handle.c
@@ -178,13 +178,13 @@ irqreturn_t handle_irq_event(struct irq_
 	irq_compat_clr_pending(desc);
 	desc->istate &= ~IRQS_PENDING;
 	irq_compat_set_progress(desc);
-	desc->istate |= IRQS_INPROGRESS;
+	irqd_set(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 	raw_spin_unlock(&desc->lock);
 
 	ret = handle_irq_event_percpu(desc, action);
 
 	raw_spin_lock(&desc->lock);
-	desc->istate &= ~IRQS_INPROGRESS;
+	irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 	irq_compat_clr_progress(desc);
 	return ret;
 }
Index: linux-2.6-tip/kernel/irq/internals.h
===================================================================
--- linux-2.6-tip.orig/kernel/irq/internals.h
+++ linux-2.6-tip/kernel/irq/internals.h
@@ -44,26 +44,20 @@ enum {
  * IRQS_SPURIOUS_DISABLED	- was disabled due to spurious interrupt
  *				  detection
  * IRQS_POLL_INPROGRESS		- polling in progress
- * IRQS_INPROGRESS		- Interrupt in progress
  * IRQS_ONESHOT			- irq is not unmasked in primary handler
  * IRQS_REPLAY			- irq is replayed
  * IRQS_WAITING			- irq is waiting
- * IRQS_DISABLED		- irq is disabled
  * IRQS_PENDING			- irq is pending and replayed later
- * IRQS_MASKED			- irq is masked
  * IRQS_SUSPENDED		- irq is suspended
  */
 enum {
 	IRQS_AUTODETECT		= 0x00000001,
 	IRQS_SPURIOUS_DISABLED	= 0x00000002,
 	IRQS_POLL_INPROGRESS	= 0x00000008,
-	IRQS_INPROGRESS		= 0x00000010,
 	IRQS_ONESHOT		= 0x00000020,
 	IRQS_REPLAY		= 0x00000040,
 	IRQS_WAITING		= 0x00000080,
-	IRQS_DISABLED		= 0x00000100,
 	IRQS_PENDING		= 0x00000200,
-	IRQS_MASKED		= 0x00000400,
 	IRQS_SUSPENDED		= 0x00000800,
 };
 
Index: linux-2.6-tip/kernel/irq/irqdesc.c
===================================================================
--- linux-2.6-tip.orig/kernel/irq/irqdesc.c
+++ linux-2.6-tip/kernel/irq/irqdesc.c
@@ -81,7 +81,6 @@ static void desc_set_defaults(unsigned i
 	desc->irq_data.msi_desc = NULL;
 	irq_settings_clr_and_set(desc, ~0, _IRQ_DEFAULT_INIT_FLAGS);
 	irqd_set(&desc->irq_data, IRQD_IRQ_DISABLED);
-	desc->istate = IRQS_DISABLED;
 	desc->handle_irq = handle_bad_irq;
 	desc->depth = 1;
 	desc->irq_count = 0;
@@ -239,7 +238,6 @@ int __init early_irq_init(void)
 
 struct irq_desc irq_desc[NR_IRQS] __cacheline_aligned_in_smp = {
 	[0 ... NR_IRQS-1] = {
-		.istate		= IRQS_DISABLED,
 		.handle_irq	= handle_bad_irq,
 		.depth		= 1,
 		.lock		= __RAW_SPIN_LOCK_UNLOCKED(irq_desc->lock),
Index: linux-2.6-tip/kernel/irq/manage.c
===================================================================
--- linux-2.6-tip.orig/kernel/irq/manage.c
+++ linux-2.6-tip/kernel/irq/manage.c
@@ -41,7 +41,7 @@ early_param("threadirqs", setup_forced_i
 void synchronize_irq(unsigned int irq)
 {
 	struct irq_desc *desc = irq_to_desc(irq);
-	unsigned int state;
+	bool inprogress;
 
 	if (!desc)
 		return;
@@ -53,16 +53,16 @@ void synchronize_irq(unsigned int irq)
 		 * Wait until we're out of the critical section.  This might
 		 * give the wrong answer due to the lack of memory barriers.
 		 */
-		while (desc->istate & IRQS_INPROGRESS)
+		while (irqd_irq_inprogress(&desc->irq_data))
 			cpu_relax();
 
 		/* Ok, that indicated we're done: double-check carefully. */
 		raw_spin_lock_irqsave(&desc->lock, flags);
-		state = desc->istate;
+		inprogress = irqd_irq_inprogress(&desc->irq_data);
 		raw_spin_unlock_irqrestore(&desc->lock, flags);
 
 		/* Oops, that failed? */
-	} while (state & IRQS_INPROGRESS);
+	} while (inprogress);
 
 	/*
 	 * We made sure that no hardirq handler is running. Now verify
@@ -563,9 +563,9 @@ int __irq_set_trigger(struct irq_desc *d
 	flags &= IRQ_TYPE_SENSE_MASK;
 
 	if (chip->flags & IRQCHIP_SET_TYPE_MASKED) {
-		if (!(desc->istate & IRQS_MASKED))
+		if (!irqd_irq_masked(&desc->irq_data))
 			mask_irq(desc);
-		if (!(desc->istate & IRQS_DISABLED))
+		if (!irqd_irq_disabled(&desc->irq_data))
 			unmask = 1;
 	}
 
@@ -663,7 +663,7 @@ again:
 	 * irq_wake_thread(). See the comment there which explains the
 	 * serialization.
 	 */
-	if (unlikely(desc->istate & IRQS_INPROGRESS)) {
+	if (unlikely(irqd_irq_inprogress(&desc->irq_data))) {
 		raw_spin_unlock_irq(&desc->lock);
 		chip_bus_sync_unlock(desc);
 		cpu_relax();
@@ -680,12 +680,10 @@ again:
 
 	desc->threads_oneshot &= ~action->thread_mask;
 
-	if (!desc->threads_oneshot && !(desc->istate & IRQS_DISABLED) &&
-	    (desc->istate & IRQS_MASKED)) {
-		irq_compat_clr_masked(desc);
-		desc->istate &= ~IRQS_MASKED;
-		desc->irq_data.chip->irq_unmask(&desc->irq_data);
-	}
+	if (!desc->threads_oneshot && !irqd_irq_disabled(&desc->irq_data) &&
+	    irqd_irq_masked(&desc->irq_data))
+		unmask_irq(desc);
+
 out_unlock:
 	raw_spin_unlock_irq(&desc->lock);
 	chip_bus_sync_unlock(desc);
@@ -779,7 +777,7 @@ static int irq_thread(void *data)
 		atomic_inc(&desc->threads_active);
 
 		raw_spin_lock_irq(&desc->lock);
-		if (unlikely(desc->istate & IRQS_DISABLED)) {
+		if (unlikely(irqd_irq_disabled(&desc->irq_data))) {
 			/*
 			 * CHECKME: We might need a dedicated
 			 * IRQ_THREAD_PENDING flag here, which
@@ -997,8 +995,8 @@ __setup_irq(unsigned int irq, struct irq
 		}
 
 		desc->istate &= ~(IRQS_AUTODETECT | IRQS_SPURIOUS_DISABLED | \
-				  IRQS_INPROGRESS | IRQS_ONESHOT | \
-				  IRQS_WAITING);
+				  IRQS_ONESHOT | IRQS_WAITING);
+		irqd_clear(&desc->irq_data, IRQD_IRQ_INPROGRESS);
 
 		if (new->flags & IRQF_PERCPU) {
 			irqd_set(&desc->irq_data, IRQD_PER_CPU);
Index: linux-2.6-tip/kernel/irq/migration.c
===================================================================
--- linux-2.6-tip.orig/kernel/irq/migration.c
+++ linux-2.6-tip/kernel/irq/migration.c
@@ -66,7 +66,7 @@ void irq_move_irq(struct irq_data *idata
 	if (likely(!irqd_is_setaffinity_pending(idata)))
 		return;
 
-	if (unlikely(desc->istate & IRQS_DISABLED))
+	if (unlikely(irqd_irq_disabled(idata)))
 		return;
 
 	/*
@@ -74,7 +74,7 @@ void irq_move_irq(struct irq_data *idata
 	 * threaded interrupt with ONESHOT set, we can end up with an
 	 * interrupt storm.
 	 */
-	masked = desc->istate & IRQS_MASKED;
+	masked = irqd_irq_masked(idata);
 	if (!masked)
 		idata->chip->irq_mask(idata);
 	irq_move_masked_irq(idata);
Index: linux-2.6-tip/kernel/irq/spurious.c
===================================================================
--- linux-2.6-tip.orig/kernel/irq/spurious.c
+++ linux-2.6-tip/kernel/irq/spurious.c
@@ -45,12 +45,12 @@ bool irq_wait_for_poll(struct irq_desc *
 #ifdef CONFIG_SMP
 	do {
 		raw_spin_unlock(&desc->lock);
-		while (desc->istate & IRQS_INPROGRESS)
+		while (irqd_irq_inprogress(&desc->irq_data))
 			cpu_relax();
 		raw_spin_lock(&desc->lock);
-	} while (desc->istate & IRQS_INPROGRESS);
+	} while irqd_irq_inprogress(&desc->irq_data);
 	/* Might have been disabled in meantime */
-	return !(desc->istate & IRQS_DISABLED) && desc->action;
+	return !irqd_irq_disabled(&desc->irq_data) && desc->action;
 #else
 	return false;
 #endif
@@ -75,7 +75,7 @@ static int try_one_irq(int irq, struct i
 	 * Do not poll disabled interrupts unless the spurious
 	 * disabled poller asks explicitely.
 	 */
-	if ((desc->istate & IRQS_DISABLED) && !force)
+	if (irqd_irq_disabled(&desc->irq_data) && !force)
 		goto out;
 
 	/*
@@ -88,7 +88,7 @@ static int try_one_irq(int irq, struct i
 		goto out;
 
 	/* Already running on another processor */
-	if (desc->istate & IRQS_INPROGRESS) {
+	if (irqd_irq_inprogress(&desc->irq_data)) {
 		/*
 		 * Already running: If it is shared get the other
 		 * CPU to go looking for our mystery interrupt too
