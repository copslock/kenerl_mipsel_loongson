Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2007 18:43:37 +0000 (GMT)
Received: from localhost.localdomain ([127.0.0.1]:12992 "EHLO
	dl5rb.ham-radio-op.net") by ftp.linux-mips.org with ESMTP
	id S20026352AbXKVSne (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Thu, 22 Nov 2007 18:43:34 +0000
Received: from denk.linux-mips.net (denk.linux-mips.net [127.0.0.1])
	by dl5rb.ham-radio-op.net (8.14.1/8.13.8) with ESMTP id lAMIhF3k014284;
	Thu, 22 Nov 2007 18:43:15 GMT
Received: (from ralf@localhost)
	by denk.linux-mips.net (8.14.1/8.14.1/Submit) id lAMIhEIH014283;
	Thu, 22 Nov 2007 18:43:14 GMT
Date:	Thu, 22 Nov 2007 18:43:14 +0000
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc:	linux-mips@linux-mips.org
Subject: Re: [MIPS] irq_cpu: use handle_percpu_irq handler to avoid
	dropping interrupts.
Message-ID: <20071122184314.GA14223@linux-mips.org>
References: <S20032632AbXKOURg/20071115201736Z+24020@ftp.linux-mips.org> <20071123.004132.61510296.anemo@mba.ocn.ne.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20071123.004132.61510296.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17564
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, Nov 23, 2007 at 12:41:32AM +0900, Atsushi Nemoto wrote:

> This might broke probe_irq_on()/probe_irq_off(), since
> handle_percpu_irq() does not check IRQ_WAITING bit.
> 
> This is a quick fix.  But I'm not sure where is the right place to fix...

Here's a cleaner version.  I guess I should scatter a few more
set_irq_noprobe calls over arch/mips - just not into i8259.c.

  Ralf

diff --git a/arch/mips/kernel/irq-rm7000.c b/arch/mips/kernel/irq-rm7000.c
index 971adf6..a92f2d0 100644
--- a/arch/mips/kernel/irq-rm7000.c
+++ b/arch/mips/kernel/irq-rm7000.c
@@ -42,7 +42,9 @@ void __init rm7k_cpu_irq_init(void)
 
 	clear_c0_intcontrol(0x00000f00);		/* Mask all */
 
-	for (i = base; i < base + 4; i++)
+	for (i = base; i < base + 4; i++) {
 		set_irq_chip_and_handler(i, &rm7k_irq_controller,
 					 handle_percpu_irq);
+		set_irq_noprobe(i);
+	}
 }
diff --git a/arch/mips/kernel/irq-rm9000.c b/arch/mips/kernel/irq-rm9000.c
index 7b04583..3f21538 100644
--- a/arch/mips/kernel/irq-rm9000.c
+++ b/arch/mips/kernel/irq-rm9000.c
@@ -105,4 +105,5 @@ void __init rm9k_cpu_irq_init(void)
 	rm9000_perfcount_irq = base + 1;
 	set_irq_chip_and_handler(rm9000_perfcount_irq, &rm9k_perfcounter_irq,
 				 handle_percpu_irq);
+	set_irq_noprobe(rm9000_perfcount_irq);
 }
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index d06e9c9..c2e3279 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -130,6 +130,24 @@ asmlinkage void spurious_interrupt(void)
 	atomic_inc(&irq_err_count);
 }
 
+void set_irq_noprobe(unsigned int irq)
+{
+	unsigned long flags;
+	struct irq_desc *desc;
+
+	if (irq >= NR_IRQS) {
+		printk(KERN_ERR
+		       "Trying to install type control for IRQ%d\n", irq);
+		return;
+	}
+
+	desc = irq_desc + irq;
+
+	spin_lock_irqsave(&desc->lock, flags);
+	desc->status |= IRQ_NOPROBE;
+	spin_unlock_irqrestore(&desc->lock, flags);
+}
+
 #ifdef CONFIG_KGDB
 extern void breakpoint(void);
 extern void set_debug_traps(void);
diff --git a/arch/mips/kernel/irq_cpu.c b/arch/mips/kernel/irq_cpu.c
index 0ee2567..810f65d 100644
--- a/arch/mips/kernel/irq_cpu.c
+++ b/arch/mips/kernel/irq_cpu.c
@@ -114,7 +114,9 @@ void __init mips_cpu_irq_init(void)
 		for (i = irq_base; i < irq_base + 2; i++)
 			set_irq_chip(i, &mips_mt_cpu_irq_controller);
 
-	for (i = irq_base + 2; i < irq_base + 8; i++)
+	for (i = irq_base + 2; i < irq_base + 8; i++) {
 		set_irq_chip_and_handler(i, &mips_cpu_irq_controller,
 					 handle_percpu_irq);
+		set_irq_noprobe(i);
+	}
 }
diff --git a/include/asm-mips/irq.h b/include/asm-mips/irq.h
index a58f0ee..6b60d2a 100644
--- a/include/asm-mips/irq.h
+++ b/include/asm-mips/irq.h
@@ -160,4 +160,6 @@ extern void free_irqno(unsigned int irq);
 extern int cp0_compare_irq;
 extern int cp0_perfcount_irq;
 
+extern void set_irq_noprobe(unsigned int irq);
+
 #endif /* _ASM_IRQ_H */
