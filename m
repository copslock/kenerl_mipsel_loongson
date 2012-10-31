Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 16:24:28 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:36957 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6825663Ab2JaPUcQ721u convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2012 16:20:32 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 31 Oct 2012 08:20:22 -0700
From:   Sanjay Lal <sanjayl@kymasys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 11/20] KVM/MIPS32: Guest interrupt delivery.
Date:   Wed, 31 Oct 2012 11:20:19 -0400
Message-Id: <1104E3AC-C69D-4BA7-B47A-531BC988DA5C@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Mime-Version: 1.0 (Apple Message framework v1283)
X-Mailer: Apple Mail (2.1283)
X-archive-position: 34824
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_mips_int.c | 251 +++++++++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/kvm_mips_int.h |  49 +++++++++
 2 files changed, 300 insertions(+)
 create mode 100644 arch/mips/kvm/kvm_mips_int.c
 create mode 100644 arch/mips/kvm/kvm_mips_int.h

diff --git a/arch/mips/kvm/kvm_mips_int.c b/arch/mips/kvm/kvm_mips_int.c
new file mode 100644
index 0000000..2771446
--- /dev/null
+++ b/arch/mips/kvm/kvm_mips_int.c
@@ -0,0 +1,251 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+* KVM/MIPS: Interrupt delivery
+*
+* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+* Authors: Sanjay Lal <sanjayl@kymasys.com>
+*/
+
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/fs.h>
+#include <linux/bootmem.h>
+#include <asm/page.h>
+#include <asm/cacheflush.h>
+
+#include <linux/kvm_host.h>
+
+#include "kvm_mips_int.h"
+
+
+void
+kvm_mips_queue_irq(struct kvm_vcpu *vcpu, uint32_t priority)
+{
+    set_bit(priority, &vcpu->arch.pending_exceptions);
+}
+
+void
+kvm_mips_dequeue_irq(struct kvm_vcpu *vcpu, uint32_t priority)
+{
+    clear_bit(priority, &vcpu->arch.pending_exceptions);
+}
+
+void
+kvm_mips_queue_timer_int_cb(struct kvm_vcpu *vcpu)
+{
+    /* Cause bits to reflect the pending timer interrupt, 
+     * the EXC code will be set when we are actually
+     * delivering the interrupt:
+     */
+    kvm_set_c0_guest_cause(vcpu->arch.cop0, (C_IRQ5 | C_TI));
+
+    /* Queue up an INT exception for the core */
+    kvm_mips_queue_irq(vcpu, MIPS_EXC_INT_TIMER);
+
+}
+
+void
+kvm_mips_dequeue_timer_int_cb(struct kvm_vcpu *vcpu)
+{
+    kvm_clear_c0_guest_cause(vcpu->arch.cop0, (C_IRQ5 | C_TI));
+    kvm_mips_dequeue_irq(vcpu, MIPS_EXC_INT_TIMER);
+}
+
+void
+kvm_mips_queue_io_int_cb(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq)
+{
+    int intr = (int) irq->irq;
+
+    /* Cause bits to reflect the pending IO interrupt, 
+     * the EXC code will be set when we are actually
+     * delivering the interrupt:
+     */
+    switch (intr) {
+        case 2:
+            kvm_set_c0_guest_cause(vcpu->arch.cop0, (C_IRQ0));
+            /* Queue up an INT exception for the core */
+            kvm_mips_queue_irq(vcpu, MIPS_EXC_INT_IO);
+            break;
+
+        case 3:
+            kvm_set_c0_guest_cause(vcpu->arch.cop0, (C_IRQ1));
+            kvm_mips_queue_irq(vcpu, MIPS_EXC_INT_IPI_1);
+            break;
+
+        case 4:
+            kvm_set_c0_guest_cause(vcpu->arch.cop0, (C_IRQ2));
+            kvm_mips_queue_irq(vcpu, MIPS_EXC_INT_IPI_2);
+            break;
+
+        default:
+            break;
+    }
+
+}
+
+void
+kvm_mips_dequeue_io_int_cb(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq)
+{
+    int intr = (int) irq->irq;
+    switch (intr) {
+        case -2:
+            kvm_clear_c0_guest_cause(vcpu->arch.cop0, (C_IRQ0));
+            kvm_mips_dequeue_irq(vcpu, MIPS_EXC_INT_IO);
+            break;
+
+        case -3:
+            kvm_clear_c0_guest_cause(vcpu->arch.cop0, (C_IRQ1));
+            kvm_mips_dequeue_irq(vcpu, MIPS_EXC_INT_IPI_1);
+            break;
+
+        case -4:
+            kvm_clear_c0_guest_cause(vcpu->arch.cop0, (C_IRQ2));
+            kvm_mips_dequeue_irq(vcpu, MIPS_EXC_INT_IPI_2);
+            break;
+
+        default:
+            break;
+    }
+
+}
+
+/* Deliver the interrupt of the corresponding priority, if possible. */
+int
+kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority,
+                        uint32_t cause)
+{
+    int allowed = 0;
+    uint32_t exccode;
+
+    struct kvm_vcpu_arch *arch = &vcpu->arch;
+    struct mips_coproc *cop0 __unused = vcpu->arch.cop0;
+
+    switch (priority) {
+    case MIPS_EXC_INT_TIMER:
+        if ((kvm_read_c0_guest_status(cop0) & ST0_IE)
+            && (!(kvm_read_c0_guest_status(cop0) & (ST0_EXL | ST0_ERL)))
+            && (kvm_read_c0_guest_status(cop0) & IE_IRQ5)) {
+            allowed = 1;
+            exccode = T_INT;
+        }
+        break;
+
+    case MIPS_EXC_INT_IO:
+        if ((kvm_read_c0_guest_status(cop0) & ST0_IE)
+            && (!(kvm_read_c0_guest_status(cop0) & (ST0_EXL | ST0_ERL)))
+            && (kvm_read_c0_guest_status(cop0) & IE_IRQ0)) {
+            allowed = 1;
+            exccode = T_INT;
+        }
+        break;
+
+    case MIPS_EXC_INT_IPI_1:
+        if ((kvm_read_c0_guest_status(cop0) & ST0_IE)
+            && (!(kvm_read_c0_guest_status(cop0) & (ST0_EXL | ST0_ERL)))
+            && (kvm_read_c0_guest_status(cop0) & IE_IRQ1)) {
+            allowed = 1;
+            exccode = T_INT;
+        }
+        break;
+
+    case MIPS_EXC_INT_IPI_2:
+        if ((kvm_read_c0_guest_status(cop0) & ST0_IE)
+            && (!(kvm_read_c0_guest_status(cop0) & (ST0_EXL | ST0_ERL)))
+            && (kvm_read_c0_guest_status(cop0) & IE_IRQ2)) {
+            allowed = 1;
+            exccode = T_INT;
+        }
+        break;
+
+
+    default:
+        break;
+    }
+
+    /* Are we allowed to deliver the interrupt ??? */
+    if (allowed) {
+
+        if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
+            /* save old pc */
+            kvm_write_c0_guest_epc(cop0, arch->pc);
+            kvm_set_c0_guest_status(cop0, ST0_EXL);
+
+            if (cause & CAUSEF_BD)
+                kvm_set_c0_guest_cause(cop0, CAUSEF_BD);
+            else
+                kvm_clear_c0_guest_cause(cop0, CAUSEF_BD);
+
+            kvm_debug("Delivering INT @ pc %#lx\n", arch->pc);
+
+        }
+        else
+            panic("Trying to deliver interrupt when EXL is already set\n");
+
+        kvm_change_c0_guest_cause(cop0, CAUSEF_EXCCODE, (exccode << CAUSEB_EXCCODE));
+
+        /* XXXSL Set PC to the interrupt exception entry point */
+        if (kvm_read_c0_guest_cause(cop0) & CAUSEF_IV)
+            arch->pc = KVM_GUEST_KSEG0 + 0x200;
+        else
+            arch->pc = KVM_GUEST_KSEG0 + 0x180;
+
+        clear_bit(priority, &vcpu->arch.pending_exceptions);
+    }
+
+    return allowed;
+}
+
+int
+kvm_mips_irq_clear_cb(struct kvm_vcpu *vcpu, unsigned int priority, uint32_t cause)
+{
+    return 1;
+}
+
+void
+kvm_mips_deliver_interrupts(struct kvm_vcpu *vcpu, uint32_t cause)
+{
+    unsigned long *pending = &vcpu->arch.pending_exceptions;
+    unsigned long *pending_clr = &vcpu->arch.pending_exceptions_clr;
+    unsigned int priority;
+
+    if (!(*pending) && !(*pending_clr))
+        return;
+
+    priority = __ffs(*pending_clr);
+    while (priority <= MIPS_EXC_MAX) {
+        if (kvm_mips_callbacks->irq_clear(vcpu, priority, cause)) {
+            if (!KVM_MIPS_IRQ_CLEAR_ALL_AT_ONCE) {
+                break;
+            }
+        }
+
+        priority = find_next_bit(pending_clr,
+                                 BITS_PER_BYTE * sizeof(*pending_clr),
+                                 priority + 1);
+    }
+
+    priority = __ffs(*pending);
+    while (priority <= MIPS_EXC_MAX) {
+        if (kvm_mips_callbacks->irq_deliver(vcpu, priority, cause)) {
+            if (!KVM_MIPS_IRQ_DELIVER_ALL_AT_ONCE) {
+                break;
+            }
+        }
+
+        priority = find_next_bit(pending,
+                                 BITS_PER_BYTE * sizeof(*pending),
+                                 priority + 1);
+    }
+
+}
+
+int
+kvm_mips_pending_timer(struct kvm_vcpu *vcpu)
+{
+    return test_bit(MIPS_EXC_INT_TIMER, &vcpu->arch.pending_exceptions);
+}
diff --git a/arch/mips/kvm/kvm_mips_int.h b/arch/mips/kvm/kvm_mips_int.h
new file mode 100644
index 0000000..09a1a5e
--- /dev/null
+++ b/arch/mips/kvm/kvm_mips_int.h
@@ -0,0 +1,49 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+* KVM/MIPS: Exception/Interrupt priorities
+*
+* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+* Authors: Sanjay Lal <sanjayl@kymasys.com>
+*/
+
+
+/* MIPS Exception Priorities, exceptions (including interrupts) are queued up
+ * for the guest in the order specified by their priorities 
+ */
+
+#define MIPS_EXC_RESET              0
+#define MIPS_EXC_SRESET             1
+#define MIPS_EXC_DEBUG_ST           2
+#define MIPS_EXC_DEBUG              3
+#define MIPS_EXC_DDB                4
+#define MIPS_EXC_NMI                5
+#define MIPS_EXC_MCHK               6
+#define MIPS_EXC_INT_TIMER          7
+#define MIPS_EXC_INT_IO             8
+#define MIPS_EXC_EXECUTE            9
+#define MIPS_EXC_INT_IPI_1          10
+#define MIPS_EXC_INT_IPI_2          11 
+#define MIPS_EXC_MAX                12
+/* XXXSL More to follow */
+
+
+#define C_TI        (_ULCAST_(1) << 30)
+
+#define KVM_MIPS_IRQ_DELIVER_ALL_AT_ONCE (0)
+#define KVM_MIPS_IRQ_CLEAR_ALL_AT_ONCE   (0)
+
+void kvm_mips_queue_irq(struct kvm_vcpu *vcpu, uint32_t priority);
+void kvm_mips_dequeue_irq(struct kvm_vcpu *vcpu, uint32_t priority);
+int kvm_mips_pending_timer(struct kvm_vcpu *vcpu);
+
+void kvm_mips_queue_timer_int_cb(struct kvm_vcpu *vcpu);
+void kvm_mips_dequeue_timer_int_cb(struct kvm_vcpu *vcpu);
+void kvm_mips_queue_io_int_cb(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq);
+void kvm_mips_dequeue_io_int_cb(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq);
+int kvm_mips_irq_deliver_cb(struct kvm_vcpu *vcpu, unsigned int priority, uint32_t cause);
+int kvm_mips_irq_clear_cb(struct kvm_vcpu *vcpu, unsigned int priority, uint32_t cause);
+void kvm_mips_deliver_interrupts(struct kvm_vcpu *vcpu, uint32_t cause);
+
-- 
1.7.11.3
