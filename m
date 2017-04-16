Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 16 Apr 2017 10:03:56 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:58078 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992517AbdDPIDrybHAO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 16 Apr 2017 10:03:47 +0200
Received: from localhost (LFbn-1-12060-104.w90-92.abo.wanadoo.fr [90.92.122.104])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 5CE9A480;
        Sun, 16 Apr 2017 08:03:41 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Matt Redfearn <matt.redfearn@imgtec.com>,
        "Jason A. Donenfeld" <jason@zx2c4.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chris Metcalf <cmetcalf@mellanox.com>,
        Petr Mladek <pmladek@suse.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paul Burton <paul.burton@imgtec.com>,
        Aaron Tomlin <atomlin@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Amit Pundir <amit.pundir@linaro.org>
Subject: [PATCH 4.4 05/18] MIPS: Introduce irq_stack
Date:   Sun, 16 Apr 2017 10:02:28 +0200
Message-Id: <20170416080213.004888942@linuxfoundation.org>
X-Mailer: git-send-email 2.12.2
In-Reply-To: <20170416080212.713469777@linuxfoundation.org>
References: <20170416080212.713469777@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57688
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Matt Redfearn <matt.redfearn@imgtec.com>

commit fe8bd18ffea5327344d4ec2bf11f47951212abd0 upstream.

Allocate a per-cpu irq stack for use within interrupt handlers.

Also add a utility function on_irq_stack to determine if a given stack
pointer is within the irq stack for that cpu.

Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
Acked-by: Jason A. Donenfeld <jason@zx2c4.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: Petr Mladek <pmladek@suse.com>
Cc: James Hogan <james.hogan@imgtec.com>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: Aaron Tomlin <atomlin@redhat.com>
Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: linux-kernel@vger.kernel.org
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/14740/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Amit Pundir <amit.pundir@linaro.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/irq.h    |   12 ++++++++++++
 arch/mips/kernel/asm-offsets.c |    1 +
 arch/mips/kernel/irq.c         |   11 +++++++++++
 3 files changed, 24 insertions(+)

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
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -101,6 +101,7 @@ void output_thread_info_defines(void)
 	OFFSET(TI_REGS, thread_info, regs);
 	DEFINE(_THREAD_SIZE, THREAD_SIZE);
 	DEFINE(_THREAD_MASK, THREAD_MASK);
+	DEFINE(_IRQ_STACK_SIZE, IRQ_STACK_SIZE);
 	BLANK();
 }
 
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
@@ -55,6 +57,15 @@ void __init init_IRQ(void)
 		irq_set_noprobe(i);
 
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
