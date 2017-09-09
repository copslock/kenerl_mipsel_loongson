Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 10 Sep 2017 00:24:57 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38048 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994066AbdIIWYnSQne3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 10 Sep 2017 00:24:43 +0200
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1dqoB4-0000uS-5r; Sat, 09 Sep 2017 23:24:38 +0100
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1dqoAz-0006W4-Nk; Sat, 09 Sep 2017 23:24:33 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
        "Paul Burton" <paul.burton@imgtec.com>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Sat, 09 Sep 2017 22:47:40 +0100
Message-ID: <lsq.1504993660.280616914@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.2 096/106] MIPS: Fix IRQ tracing & lockdep when rescheduling
In-Reply-To: <lsq.1504993659.376385113@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59971
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.2.93-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit d8550860d910c6b7b70f830f59003b33daaa52c9 upstream.

When the scheduler sets TIF_NEED_RESCHED & we call into the scheduler
from arch/mips/kernel/entry.S we disable interrupts. This is true
regardless of whether we reach work_resched from syscall_exit_work,
resume_userspace or by looping after calling schedule(). Although we
disable interrupts in these paths we don't call trace_hardirqs_off()
before calling into C code which may acquire locks, and we therefore
leave lockdep with an inconsistent view of whether interrupts are
disabled or not when CONFIG_PROVE_LOCKING & CONFIG_DEBUG_LOCKDEP are
both enabled.

Without tracing this interrupt state lockdep will print warnings such
as the following once a task returns from a syscall via
syscall_exit_partial with TIF_NEED_RESCHED set:

[   49.927678] ------------[ cut here ]------------
[   49.934445] WARNING: CPU: 0 PID: 1 at kernel/locking/lockdep.c:3687 check_flags.part.41+0x1dc/0x1e8
[   49.946031] DEBUG_LOCKS_WARN_ON(current->hardirqs_enabled)
[   49.946355] CPU: 0 PID: 1 Comm: init Not tainted 4.10.0-00439-gc9fd5d362289-dirty #197
[   49.963505] Stack : 0000000000000000 ffffffff81bb5d6a 0000000000000006 ffffffff801ce9c4
[   49.974431]         0000000000000000 0000000000000000 0000000000000000 000000000000004a
[   49.985300]         ffffffff80b7e487 ffffffff80a24498 a8000000ff160000 ffffffff80ede8b8
[   49.996194]         0000000000000001 0000000000000000 0000000000000000 0000000077c8030c
[   50.007063]         000000007fd8a510 ffffffff801cd45c 0000000000000000 a8000000ff127c88
[   50.017945]         0000000000000000 ffffffff801cf928 0000000000000001 ffffffff80a24498
[   50.028827]         0000000000000000 0000000000000001 0000000000000000 0000000000000000
[   50.039688]         0000000000000000 a8000000ff127bd0 0000000000000000 ffffffff805509bc
[   50.050575]         00000000140084e0 0000000000000000 0000000000000000 0000000000040a00
[   50.061448]         0000000000000000 ffffffff8010e1b0 0000000000000000 ffffffff805509bc
[   50.072327]         ...
[   50.076087] Call Trace:
[   50.079869] [<ffffffff8010e1b0>] show_stack+0x80/0xa8
[   50.086577] [<ffffffff805509bc>] dump_stack+0x10c/0x190
[   50.093498] [<ffffffff8015dde0>] __warn+0xf0/0x108
[   50.099889] [<ffffffff8015de34>] warn_slowpath_fmt+0x3c/0x48
[   50.107241] [<ffffffff801c15b4>] check_flags.part.41+0x1dc/0x1e8
[   50.114961] [<ffffffff801c239c>] lock_is_held_type+0x8c/0xb0
[   50.122291] [<ffffffff809461b8>] __schedule+0x8c0/0x10f8
[   50.129221] [<ffffffff80946a60>] schedule+0x30/0x98
[   50.135659] [<ffffffff80106278>] work_resched+0x8/0x34
[   50.142397] ---[ end trace 0cb4f6ef5b99fe21 ]---
[   50.148405] possible reason: unannotated irqs-off.
[   50.154600] irq event stamp: 400463
[   50.159566] hardirqs last  enabled at (400463): [<ffffffff8094edc8>] _raw_spin_unlock_irqrestore+0x40/0xa8
[   50.171981] hardirqs last disabled at (400462): [<ffffffff8094eb98>] _raw_spin_lock_irqsave+0x30/0xb0
[   50.183897] softirqs last  enabled at (400450): [<ffffffff8016580c>] __do_softirq+0x4ac/0x6a8
[   50.195015] softirqs last disabled at (400425): [<ffffffff80165e78>] irq_exit+0x110/0x128

Fix this by using the TRACE_IRQS_OFF macro to call trace_hardirqs_off()
when CONFIG_TRACE_IRQFLAGS is enabled. This is done before invoking
schedule() following the work_resched label because:

 1) Interrupts are disabled regardless of the path we take to reach
    work_resched() & schedule().

 2) Performing the tracing here avoids the need to do it in paths which
    disable interrupts but don't call out to C code before hitting a
    path which uses the RESTORE_SOME macro that will call
    trace_hardirqs_on() or trace_hardirqs_off() as appropriate.

We call trace_hardirqs_on() using the TRACE_IRQS_ON macro before calling
syscall_trace_leave() for similar reasons, ensuring that lockdep has a
consistent view of state after we re-enable interrupts.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/15385/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.2: adjust context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kernel/entry.S | 3 +++
 1 file changed, 3 insertions(+)

--- a/arch/mips/kernel/entry.S
+++ b/arch/mips/kernel/entry.S
@@ -10,6 +10,7 @@
 
 #include <asm/asm.h>
 #include <asm/asmmacro.h>
+#include <asm/irqflags.h>
 #include <asm/regdef.h>
 #include <asm/mipsregs.h>
 #include <asm/stackframe.h>
@@ -145,6 +146,7 @@ work_pending:
 	andi	t0, a2, _TIF_NEED_RESCHED # a2 is preloaded with TI_FLAGS
 	beqz	t0, work_notifysig
 work_resched:
+	TRACE_IRQS_OFF
 	jal	schedule
 
 	local_irq_disable		# make sure need_resched and
@@ -172,6 +174,7 @@ syscall_exit_work:
 	beqz	t0, work_pending	# trace bit set?
 	local_irq_enable		# could let syscall_trace_leave()
 					# call schedule() instead
+	TRACE_IRQS_ON
 	move	a0, sp
 	jal	syscall_trace_leave
 	b	resume_userspace
