Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 02 Dec 2016 14:40:13 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13962 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993048AbcLBNjlRzHL6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 2 Dec 2016 14:39:41 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id B3D5EAFC7215E;
        Fri,  2 Dec 2016 13:39:31 +0000 (GMT)
Received: from mredfearn-linux.le.imgtec.org (10.150.130.83) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 2 Dec 2016 13:39:35 +0000
From:   Matt Redfearn <matt.redfearn@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        "Jason A . Donenfeld" <Jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Petr Mladek <pmladek@suse.com>, <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [PATCH 1/5] MIPS: Introduce irq_stack
Date:   Fri, 2 Dec 2016 13:39:13 +0000
Message-ID: <1480685957-18809-2-git-send-email-matt.redfearn@imgtec.com>
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
X-archive-position: 55926
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

Allocate a per-cpu irq stack for use within interrupt handlers.

Also add a utility function on_irq_stack to determine if a given stack
pointer is within the irq stack for that cpu.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>

---

 arch/mips/include/asm/irq.h    | 12 ++++++++++++
 arch/mips/kernel/asm-offsets.c |  1 +
 arch/mips/kernel/irq.c         | 11 +++++++++++
 3 files changed, 24 insertions(+)

diff --git a/arch/mips/include/asm/irq.h b/arch/mips/include/asm/irq.h
index 6bf10e796553..956db6e201d1 100644
--- a/arch/mips/include/asm/irq.h
+++ b/arch/mips/include/asm/irq.h
@@ -17,6 +17,18 @@
 
 #include <irq.h>
 
+#define IRQ_STACK_SIZE			THREAD_SIZE
+
+extern void *irq_stack[NR_CPUS];
+
+static inline bool on_irq_stack(int cpu, unsigned long sp)
+{
+	unsigned long low = (unsigned long)irq_stack[cpu];
+	unsigned long high = low + IRQ_STACK_SIZE;
+
+	return (low <= sp && sp <= high);
+}
+
 #ifdef CONFIG_I8259
 static inline int irq_canonicalize(int irq)
 {
diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index fae2f9447792..4be2763f835d 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -102,6 +102,7 @@ void output_thread_info_defines(void)
 	OFFSET(TI_REGS, thread_info, regs);
 	DEFINE(_THREAD_SIZE, THREAD_SIZE);
 	DEFINE(_THREAD_MASK, THREAD_MASK);
+	DEFINE(_IRQ_STACK_SIZE, IRQ_STACK_SIZE);
 	BLANK();
 }
 
diff --git a/arch/mips/kernel/irq.c b/arch/mips/kernel/irq.c
index f25f7eab7307..2b0a371b42af 100644
--- a/arch/mips/kernel/irq.c
+++ b/arch/mips/kernel/irq.c
@@ -25,6 +25,8 @@
 #include <linux/atomic.h>
 #include <asm/uaccess.h>
 
+void *irq_stack[NR_CPUS];
+
 /*
  * 'what should we do if we get a hw irq event on an illegal vector'.
  * each architecture has to answer this themselves.
@@ -58,6 +60,15 @@ void __init init_IRQ(void)
 		clear_c0_status(ST0_IM);
 
 	arch_init_irq();
+
+	for_each_possible_cpu(i) {
+		int irq_pages = IRQ_STACK_SIZE / PAGE_SIZE;
+		void *s = (void *)__get_free_pages(GFP_KERNEL, irq_pages);
+
+		irq_stack[i] = s;
+		pr_debug("CPU%d IRQ stack at 0x%p - 0x%p\n", i,
+			irq_stack[i], irq_stack[i] + IRQ_STACK_SIZE);
+	}
 }
 
 #ifdef CONFIG_DEBUG_STACKOVERFLOW
-- 
2.7.4
