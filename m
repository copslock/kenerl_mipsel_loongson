Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jul 2011 14:43:19 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:60696 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491190Ab1GWMlY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jul 2011 14:41:24 +0200
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1QkbWG-0003uo-BE; Sat, 23 Jul 2011 14:41:24 +0200
Message-Id: <20110723124016.178327962@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Sat, 23 Jul 2011 12:41:24 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Wu Zhangjin <wuzhangjin@gmail.com>
Subject: [patch 4/7] MIPS: Make the die_lock be raw
References: <20110723123948.573545817@linutronix.de>
Content-Disposition: inline; filename=mips-make-die-lock-raw.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-archive-position: 30694
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16787

From: Wu Zhangjin <wuzhangjin@gmail.com>

On preempt-rt this lock needs to be raw, so it does not get converted
to a sleeping spinlock. Trying to sleep in a panic is not really
desireable.

Signed-off-by: Wu Zhangjin <wuzhangjin@gmail.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 arch/mips/kernel/traps.c |    6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

Index: linux-2.6/arch/mips/kernel/traps.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/traps.c
+++ linux-2.6/arch/mips/kernel/traps.c
@@ -364,7 +364,7 @@ static int regs_to_trapnr(struct pt_regs
 	return (regs->cp0_cause >> 2) & 0x1f;
 }
 
-static DEFINE_SPINLOCK(die_lock);
+static DEFINE_RAW_SPINLOCK(die_lock);
 
 void __noreturn die(const char *str, struct pt_regs *regs)
 {
@@ -378,7 +378,7 @@ void __noreturn die(const char *str, str
 		sig = 0;
 
 	console_verbose();
-	spin_lock_irq(&die_lock);
+	raw_spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
 #ifdef CONFIG_MIPS_MT_SMTC
 	mips_mt_regdump(dvpret);
@@ -387,7 +387,7 @@ void __noreturn die(const char *str, str
 	printk("%s[#%d]:\n", str, ++die_counter);
 	show_registers(regs);
 	add_taint(TAINT_DIE);
-	spin_unlock_irq(&die_lock);
+	raw_spin_unlock_irq(&die_lock);
 
 	if (in_interrupt())
 		panic("Fatal exception in interrupt");
