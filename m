Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 23 Jul 2011 14:42:53 +0200 (CEST)
Received: from www.linutronix.de ([62.245.132.108]:60692 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491189Ab1GWMlY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 23 Jul 2011 14:41:24 +0200
Received: from localhost ([127.0.0.1] helo=localhost6.localdomain6)
        by Galois.linutronix.de with esmtp (Exim 4.72)
        (envelope-from <tglx@linutronix.de>)
        id 1QkbWF-0003ul-Ts; Sat, 23 Jul 2011 14:41:24 +0200
Message-Id: <20110723124016.118094411@linutronix.de>
User-Agent: quilt/0.48-1
Date:   Sat, 23 Jul 2011 12:41:23 -0000
From:   Thomas Gleixner <tglx@linutronix.de>
To:     linux-mips@linux-mips.org
Cc:     Ralf Baechle <ralf@linux-mips.org>
Subject: [patch 3/7] mips: Enable interrupts in do_signal()
References: <20110723123948.573545817@linutronix.de>
Content-Disposition: inline; filename=mips-enable-interrupts-in-signal.patch
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
X-archive-position: 30693
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tglx@linutronix.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 16786

do_signal() does __put_user() which can fault, resulting in a
might_sleep() warning in down_read(&mm->mmap_sem) and a "scheduling
while atomic" warning when mmap_sem is contented. On swarm this also
results in:

WARNING: at kernel/smp.c:459 smp_call_function_many+0x148/0x398()
Modules linked in:
Call Trace:

[<ffffffff804b48a4>] dump_stack+0x1c/0x50
[<ffffffff8013dc94>] warn_slowpath_common+0x8c/0xc8
[<ffffffff8013dcfc>] warn_slowpath_null+0x2c/0x40
[<ffffffff801864a0>] smp_call_function_many+0x148/0x398
[<ffffffff80186748>] smp_call_function+0x58/0xa8
[<ffffffff80119b5c>] r4k_flush_data_cache_page+0x54/0xd8
[<ffffffff801f39bc>] handle_pte_fault+0xa9c/0xad0
[<ffffffff801f40d0>] handle_mm_fault+0x158/0x200
[<ffffffff80115548>] do_page_fault+0x218/0x3b0
[<ffffffff80102744>] ret_from_exception+0x0/0x10
[<ffffffff8010eb18>] copy_siginfo_to_user32+0x50/0x298
[<ffffffff8010edf0>] setup_rt_frame_32+0x90/0x250
[<ffffffff80106414>] do_notify_resume+0x154/0x358
[<ffffffff80102930>] work_notifysig+0xc/0x14

Enable interrupts in do_signal() before delivering signals. Might be
done in the entry code before calling do_notify_resume(), but I leave
that for the MIPS ASM wizards.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/mips/kernel/signal.c |    2 ++
 1 file changed, 2 insertions(+)

Index: linux-2.6/arch/mips/kernel/signal.c
===================================================================
--- linux-2.6.orig/arch/mips/kernel/signal.c
+++ linux-2.6/arch/mips/kernel/signal.c
@@ -603,6 +603,8 @@ static void do_signal(struct pt_regs *re
 	if (!user_mode(regs))
 		return;
 
+	local_irq_enable();
+
 	if (test_thread_flag(TIF_RESTORE_SIGMASK))
 		oldset = &current->saved_sigmask;
 	else
