Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2016 14:40:41 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:47648 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993058AbcLBNjl4EVU6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2016 14:39:41 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 80D403A6FD4AC;
        Fri,  2 Dec 2016 13:39:32 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Dec 2016 13:39:35 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Marcin Nowakowski <marcin.nowakowski@imgtec.com>,
        "Maciej W. Rozycki" <macro@imgtec.com>,
        Jiri Slaby <jslaby@suse.cz>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        <linux-kernel@vger.kernel.org>,
        Andrea Gelmini <andrea.gelmini@gelma.net>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 2/5] MIPS: Stack unwinding while on IRQ stack
Date:   Fri, 2 Dec 2016 13:39:14 +0000
Message-ID: <1480685957-18809-3-git-send-email-matt.redfearn@imgtec.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1480685957-18809-1-git-send-email-matt.redfearn@imgtec.com>
References: <1480685957-18809-1-git-send-email-matt.redfearn@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55927
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Within unwind stack, check if the stack pointer being unwound is within
the CPU's irq_stack and if so use that page rather than the task's stack
page.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
---

 arch/mips/kernel/process.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index 9514e5f2209f..4fdbf7078071 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -33,6 +33,7 @@
 #include <asm/dsemul.h>
 #include <asm/dsp.h>
 #include <asm/fpu.h>
+#include <asm/irq.h>
 #include <asm/msa.h>
 #include <asm/pgtable.h>
 #include <asm/mipsregs.h>
@@ -511,7 +512,19 @@ EXPORT_SYMBOL(unwind_stack_by_address);
 unsigned long unwind_stack(struct task_struct *task, unsigned long *sp,
 			   unsigned long pc, unsigned long *ra)
 {
-	unsigned long stack_page = (unsigned long)task_stack_page(task);
+	unsigned long stack_page = 0;
+	int cpu;
+
+	for_each_possible_cpu(cpu) {
+		if (on_irq_stack(cpu, *sp)) {
+			stack_page = (unsigned long)irq_stack[cpu];
+			break;
+		}
+	}
+
+	if (!stack_page)
+		stack_page = (unsigned long)task_stack_page(task);
+
 	return unwind_stack_by_address(stack_page, sp, pc, ra);
 }
 #endif
-- 
2.7.4
