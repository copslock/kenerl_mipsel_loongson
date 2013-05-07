Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 May 2013 21:22:37 +0200 (CEST)
Received: from mail-pb0-f47.google.com ([209.85.160.47]:36973 "EHLO
        mail-pb0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825736Ab3EGTWdd94zu (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 May 2013 21:22:33 +0200
Received: by mail-pb0-f47.google.com with SMTP id uo1so630138pbc.6
        for <multiple recipients>; Tue, 07 May 2013 12:22:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=GauU81wE/yAvqtGYO2xIhDtYDRNl7ydEmiu6LCTkHlI=;
        b=Uk3I9RJvrhAwpJK1I/xemH9uQWHpBsFbsHEHJAa/X5u9l5YAPojVt+9oXibheRMDhe
         jxPWYXdfd4/q6j/5gNJHDgK7ljVYBktaoO7nd5aUOukSkqKMnBPh6IAB2p2IXm5fHUnI
         l0kMsqH28LwIQP+bq7HNv4TJyXTmBef4cq3HMvaTMNP2BsXCvLTZemh71+Bz+Bqgz5da
         sN3vvTzhYZPU8W6oKjQg0PuvlF46tANXrx9d7rtR/iGYpRyQcs6PZ+Y3ZuQIUFi5Bo2q
         x95WwqtWTK7QBBgxE5XOYcOhPijQ9IJWo1yF0r8h4D8wIiVENN28SlfMo0tPfUDAJ/nW
         viyA==
X-Received: by 10.66.26.71 with SMTP id j7mr4339828pag.209.1367954541456;
        Tue, 07 May 2013 12:22:21 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id k2sm31488628pat.7.2013.05.07.12.22.19
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 07 May 2013 12:22:20 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r47JMIu0026913;
        Tue, 7 May 2013 12:22:18 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r47JMI46026912;
        Tue, 7 May 2013 12:22:18 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     linux-kernel@vger.kernel.org, Sanjay Lal <sanjayl@kymasys.com>,
        kvm@vger.kernel.org, David Daney <david.daney@cavium.com>
Subject: [PATCH v2] mips/kvm: Fix ABI for compatibility with 64-bit guests.
Date:   Tue,  7 May 2013 12:22:16 -0700
Message-Id: <1367954536-26880-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36351
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

There are several parts to this:

o All registers are 64-bits wide, 32-bit guests use the least
  significant portion of the register storage fields.

o FPU register formats are defined.

o CP0 Registers are manipulated via the KVM_GET_MSRS/KVM_SET_MSRS
  mechanism.

The vcpu_ioctl_get_regs and vcpu_ioctl_set_regs function pointers
become unused so they were removed.

Some IOCTL functions were moved to kvm_trap_emul because the
implementations are only for that flavor of KVM host.  In the future, if
hardware based virtualization is added, they can be hidden behind
function pointers as appropriate.

Signed-off-by: David Daney <david.daney@cavium.com>
---

Difference from v1: Don't make unrelated change of s/gprs/gpr/


 arch/mips/include/asm/kvm.h      | 106 ++++++++++---
 arch/mips/include/asm/kvm_host.h |   4 -
 arch/mips/kvm/kvm_mips.c         | 102 +-----------
 arch/mips/kvm/kvm_trap_emul.c    | 330 ++++++++++++++++++++++++++++++++++-----
 4 files changed, 382 insertions(+), 160 deletions(-)

diff --git a/arch/mips/include/asm/kvm.h b/arch/mips/include/asm/kvm.h
index 85789ea..83c44d8 100644
--- a/arch/mips/include/asm/kvm.h
+++ b/arch/mips/include/asm/kvm.h
@@ -1,55 +1,113 @@
 /*
-* This file is subject to the terms and conditions of the GNU General Public
-* License.  See the file "COPYING" in the main directory of this archive
-* for more details.
-*
-* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
-* Authors: Sanjay Lal <sanjayl@kymasys.com>
-*/
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+ * Copyright (C) 2013 Cavium, Inc.
+ * Authors: Sanjay Lal <sanjayl@kymasys.com>
+ */
 
 #ifndef __LINUX_KVM_MIPS_H
 #define __LINUX_KVM_MIPS_H
 
 #include <linux/types.h>
 
-#define __KVM_MIPS
-
-#define N_MIPS_COPROC_REGS      32
-#define N_MIPS_COPROC_SEL   	8
+/*
+ * KVM MIPS specific structures and definitions.
+ *
+ * Some parts derived from the x86 version of this file.
+ */
 
 /* for KVM_GET_REGS and KVM_SET_REGS */
+/*
+ * If Config[AT] is zero (32-bit CPU), the register contents are
+ * stored in the lower 32-bits of the struct kvm_regs fields and sign
+ * extended to 64-bits.
+ */
 struct kvm_regs {
-	__u32 gprs[32];
-	__u32 hi;
-	__u32 lo;
-	__u32 pc;
+	/* out (KVM_GET_REGS) / in (KVM_SET_REGS) */
+	__u64 gpr[32];
+	__u64 hi, lo;
+	__u64 pc;
+};
 
-	__u32 cp0reg[N_MIPS_COPROC_REGS][N_MIPS_COPROC_SEL];
+/* for KVM_GET_FPU and KVM_SET_FPU */
+/*
+ * If Status[FR] is zero (32-bit FPU), the upper 32-bits of the FPRs
+ * are zero filled.
+ */
+struct kvm_fpu {
+	__u64 fpr[32];
+	__u32 fir;
+	__u32 fccr;
+	__u32 fexr;
+	__u32 fenr;
+	__u32 fcsr;
+	__u32 pad;
 };
 
-/* for KVM_GET_SREGS and KVM_SET_SREGS */
-struct kvm_sregs {
+
+/*
+ * For MIPS, we use the same APIs as x86, where 'msr' corresponds to a
+ * CP0 register.  The index field is broken down as follows:
+ *
+ *  bits[2..0]   - Register 'sel' index.
+ *  bits[7..3]   - Register 'rd'  index.
+ *  bits[15..8]  - Must be zero.
+ *  bits[31..16] - 0 -> CP0 registers.
+ *
+ * Other sets registers may be added in the future.  Each set would
+ * have its own identifier in bits[31..16].
+ *
+ * For MSRs that are narrower than 64-bits, the value is stored in the
+ * low order bits of the data field, and sign extended to 64-bits.
+ */
+#define KVM_MIPS_MSR_CP0 0
+struct kvm_msr_entry {
+	__u32 index;
+	__u32 reserved;
+	__u64 data;
 };
 
-/* for KVM_GET_FPU and KVM_SET_FPU */
-struct kvm_fpu {
+/* for KVM_GET_MSRS and KVM_SET_MSRS */
+struct kvm_msrs {
+	__u32 nmsrs; /* number of msrs in entries */
+	__u32 pad;
+
+	struct kvm_msr_entry entries[0];
 };
 
+/* for KVM_GET_MSR_INDEX_LIST */
+struct kvm_msr_list {
+	__u32 nmsrs; /* number of msrs in entries */
+	__u32 indices[0];
+};
+
+/*
+ * KVM MIPS specific structures and definitions
+ *
+ */
 struct kvm_debug_exit_arch {
+	__u64 epc;
 };
 
 /* for KVM_SET_GUEST_DEBUG */
 struct kvm_guest_debug_arch {
 };
 
+/* definition of registers in kvm_run */
+struct kvm_sync_regs {
+};
+
+/* dummy definition */
+struct kvm_sregs {
+};
+
 struct kvm_mips_interrupt {
 	/* in */
 	__u32 cpu;
 	__u32 irq;
 };
 
-/* definition of registers in kvm_run */
-struct kvm_sync_regs {
-};
-
 #endif /* __LINUX_KVM_MIPS_H */
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index e68781e..e3d49ec 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -496,10 +496,6 @@ struct kvm_mips_callbacks {
 			    uint32_t cause);
 	int (*irq_clear) (struct kvm_vcpu *vcpu, unsigned int priority,
 			  uint32_t cause);
-	int (*vcpu_ioctl_get_regs) (struct kvm_vcpu *vcpu,
-				    struct kvm_regs *regs);
-	int (*vcpu_ioctl_set_regs) (struct kvm_vcpu *vcpu,
-				    struct kvm_regs *regs);
 };
 extern struct kvm_mips_callbacks *kvm_mips_callbacks;
 int kvm_mips_emulation_init(struct kvm_mips_callbacks **install_callbacks);
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/kvm_mips.c
index 2e60b1c..73094b9 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/kvm_mips.c
@@ -51,16 +51,6 @@ struct kvm_stats_debugfs_item debugfs_entries[] = {
 	{NULL}
 };
 
-static int kvm_mips_reset_vcpu(struct kvm_vcpu *vcpu)
-{
-	int i;
-	for_each_possible_cpu(i) {
-		vcpu->arch.guest_kernel_asid[i] = 0;
-		vcpu->arch.guest_user_asid[i] = 0;
-	}
-	return 0;
-}
-
 gfn_t unalias_gfn(struct kvm *kvm, gfn_t gfn)
 {
 	return gfn;
@@ -192,12 +182,6 @@ void kvm_arch_destroy_vm(struct kvm *kvm)
 	}
 }
 
-long
-kvm_arch_dev_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
-{
-	return -EINVAL;
-}
-
 void kvm_arch_free_memslot(struct kvm_memory_slot *free,
 			   struct kvm_memory_slot *dont)
 {
@@ -435,42 +419,6 @@ int kvm_arch_vcpu_ioctl_run(struct kvm_vcpu *vcpu, struct kvm_run *run)
 
 	return r;
 }
-
-int
-kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq)
-{
-	int intr = (int)irq->irq;
-	struct kvm_vcpu *dvcpu = NULL;
-
-	if (intr == 3 || intr == -3 || intr == 4 || intr == -4)
-		kvm_debug("%s: CPU: %d, INTR: %d\n", __func__, irq->cpu,
-			  (int)intr);
-
-	if (irq->cpu == -1)
-		dvcpu = vcpu;
-	else
-		dvcpu = vcpu->kvm->vcpus[irq->cpu];
-
-	if (intr == 2 || intr == 3 || intr == 4) {
-		kvm_mips_callbacks->queue_io_int(dvcpu, irq);
-
-	} else if (intr == -2 || intr == -3 || intr == -4) {
-		kvm_mips_callbacks->dequeue_io_int(dvcpu, irq);
-	} else {
-		kvm_err("%s: invalid interrupt ioctl (%d:%d)\n", __func__,
-			irq->cpu, irq->irq);
-		return -EINVAL;
-	}
-
-	dvcpu->arch.wait = 0;
-
-	if (waitqueue_active(&dvcpu->wq)) {
-		wake_up_interruptible(&dvcpu->wq);
-	}
-
-	return 0;
-}
-
 int
 kvm_arch_vcpu_ioctl_get_mpstate(struct kvm_vcpu *vcpu,
 				struct kvm_mp_state *mp_state)
@@ -485,42 +433,6 @@ kvm_arch_vcpu_ioctl_set_mpstate(struct kvm_vcpu *vcpu,
 	return -EINVAL;
 }
 
-long
-kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
-{
-	struct kvm_vcpu *vcpu = filp->private_data;
-	void __user *argp = (void __user *)arg;
-	long r;
-	int intr;
-
-	switch (ioctl) {
-	case KVM_NMI:
-		/* Treat the NMI as a CPU reset */
-		r = kvm_mips_reset_vcpu(vcpu);
-		break;
-	case KVM_INTERRUPT:
-		{
-			struct kvm_mips_interrupt irq;
-			r = -EFAULT;
-			if (copy_from_user(&irq, argp, sizeof(irq)))
-				goto out;
-
-			intr = (int)irq.irq;
-
-			kvm_debug("[%d] %s: irq: %d\n", vcpu->vcpu_id, __func__,
-				  irq.irq);
-
-			r = kvm_vcpu_ioctl_interrupt(vcpu, &irq);
-			break;
-		}
-	default:
-		r = -EINVAL;
-	}
-
-out:
-	return r;
-}
-
 /*
  * Get (and clear) the dirty memory log for a memory slot.
  */
@@ -677,28 +589,28 @@ int kvm_arch_vcpu_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
-	for (i = 0; i < 32; i++)
-		vcpu->arch.gprs[i] = regs->gprs[i];
-
+	for (i = 1; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
+		vcpu->arch.gprs[i] = regs->gpr[i];
+	vcpu->arch.gprs[0] = 0; /* zero is special, and cannot be set. */
 	vcpu->arch.hi = regs->hi;
 	vcpu->arch.lo = regs->lo;
 	vcpu->arch.pc = regs->pc;
 
-	return kvm_mips_callbacks->vcpu_ioctl_set_regs(vcpu, regs);
+	return 0;
 }
 
 int kvm_arch_vcpu_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
 {
 	int i;
 
-	for (i = 0; i < 32; i++)
-		regs->gprs[i] = vcpu->arch.gprs[i];
+	for (i = 0; i < ARRAY_SIZE(vcpu->arch.gprs); i++)
+		regs->gpr[i] = vcpu->arch.gprs[i];
 
 	regs->hi = vcpu->arch.hi;
 	regs->lo = vcpu->arch.lo;
 	regs->pc = vcpu->arch.pc;
 
-	return kvm_mips_callbacks->vcpu_ioctl_get_regs(vcpu, regs);
+	return 0;
 }
 
 void kvm_mips_comparecount_func(unsigned long data)
diff --git a/arch/mips/kvm/kvm_trap_emul.c b/arch/mips/kvm/kvm_trap_emul.c
index 466aeef..df98dcb 100644
--- a/arch/mips/kvm/kvm_trap_emul.c
+++ b/arch/mips/kvm/kvm_trap_emul.c
@@ -13,7 +13,7 @@
 #include <linux/err.h>
 #include <linux/module.h>
 #include <linux/vmalloc.h>
-
+#include <linux/fs.h>
 #include <linux/kvm_host.h>
 
 #include "kvm_mips_opcode.h"
@@ -345,54 +345,312 @@ static int kvm_trap_emul_handle_break(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
-static int
-kvm_trap_emul_ioctl_set_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+#define MSR_MIPS_CP0_INDEX (8 * 0 + 0)
+#define MSR_MIPS_CP0_ENTRYLO0 (8 * 2 + 0)
+#define MSR_MIPS_CP0_ENTRYLO1 (8 * 3 + 0)
+#define MSR_MIPS_CP0_CONTEXT (8 * 4 + 0)
+#define MSR_MIPS_CP0_USERLOCAL (8 * 4 + 2)
+#define MSR_MIPS_CP0_PAGEMASK (8 * 5 + 0)
+#define MSR_MIPS_CP0_PAGEGRAIN (8 * 5 + 1)
+#define MSR_MIPS_CP0_WIRED (8 * 6 + 0)
+#define MSR_MIPS_CP0_HWRENA (8 * 7 + 0)
+#define MSR_MIPS_CP0_BADVADDR (8 * 8 + 0)
+#define MSR_MIPS_CP0_COUNT (8 * 9 + 0)
+#define MSR_MIPS_CP0_ENTRYHI (8 * 10 + 0)
+#define MSR_MIPS_CP0_COMPARE (8 * 11 + 0)
+#define MSR_MIPS_CP0_STATUS (8 * 12 + 0)
+#define MSR_MIPS_CP0_CAUSE (8 * 13 + 0)
+#define MSR_MIPS_CP0_EBASE (8 * 15 + 1)
+#define MSR_MIPS_CP0_CONFIG (8 * 16 + 0)
+#define MSR_MIPS_CP0_CONFIG1 (8 * 16 + 1)
+#define MSR_MIPS_CP0_CONFIG2 (8 * 16 + 2)
+#define MSR_MIPS_CP0_CONFIG3 (8 * 16 + 3)
+#define MSR_MIPS_CP0_CONFIG7 (8 * 16 + 7)
+#define MSR_MIPS_CP0_XCONTEXT (8 * 20 + 0)
+#define MSR_MIPS_CP0_ERROREPC (8 * 30 + 0)
+
+static u32 msrs_to_save[] = {
+	MSR_MIPS_CP0_INDEX,
+	MSR_MIPS_CP0_CONTEXT,
+	MSR_MIPS_CP0_PAGEMASK,
+	MSR_MIPS_CP0_WIRED,
+	MSR_MIPS_CP0_BADVADDR,
+	MSR_MIPS_CP0_ENTRYHI,
+	MSR_MIPS_CP0_STATUS,
+	MSR_MIPS_CP0_CAUSE,
+	/* EPC set via kvm_regs, et al. */
+	MSR_MIPS_CP0_CONFIG,
+	MSR_MIPS_CP0_CONFIG1,
+	MSR_MIPS_CP0_CONFIG2,
+	MSR_MIPS_CP0_CONFIG3,
+	MSR_MIPS_CP0_CONFIG7,
+	MSR_MIPS_CP0_XCONTEXT,
+	MSR_MIPS_CP0_ERROREPC
+};
+
+#define MAX_IO_MSRS 128
+
+static int mipsvz_get_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	s64 v;
 
-	kvm_write_c0_guest_index(cop0, regs->cp0reg[MIPS_CP0_TLB_INDEX][0]);
-	kvm_write_c0_guest_context(cop0, regs->cp0reg[MIPS_CP0_TLB_CONTEXT][0]);
-	kvm_write_c0_guest_badvaddr(cop0, regs->cp0reg[MIPS_CP0_BAD_VADDR][0]);
-	kvm_write_c0_guest_entryhi(cop0, regs->cp0reg[MIPS_CP0_TLB_HI][0]);
-	kvm_write_c0_guest_epc(cop0, regs->cp0reg[MIPS_CP0_EXC_PC][0]);
+	switch (index) {
+	case MSR_MIPS_CP0_INDEX:
+		v = (long)kvm_read_c0_guest_index(cop0);
+		break;
+	case MSR_MIPS_CP0_CONTEXT:
+		v = (long)kvm_read_c0_guest_context(cop0);
+		break;
+	case MSR_MIPS_CP0_PAGEMASK:
+		v = (long)kvm_read_c0_guest_pagemask(cop0);
+		break;
+	case MSR_MIPS_CP0_WIRED:
+		v = (long)kvm_read_c0_guest_wired(cop0);
+		break;
+	case MSR_MIPS_CP0_BADVADDR:
+		v = (long)kvm_read_c0_guest_badvaddr(cop0);
+		break;
+	case MSR_MIPS_CP0_ENTRYHI:
+		v = (long)kvm_read_c0_guest_entryhi(cop0);
+		break;
+	case MSR_MIPS_CP0_STATUS:
+		v = (long)kvm_read_c0_guest_status(cop0);
+		break;
+	case MSR_MIPS_CP0_CAUSE:
+		v = (long)kvm_read_c0_guest_cause(cop0);
+		break;
+	case MSR_MIPS_CP0_ERROREPC:
+		v = (long)kvm_read_c0_guest_errorepc(cop0);
+		break;
+	case MSR_MIPS_CP0_CONFIG:
+		v = (long)kvm_read_c0_guest_config(cop0);
+		break;
+	case MSR_MIPS_CP0_CONFIG1:
+		v = (long)kvm_read_c0_guest_config1(cop0);
+		break;
+	case MSR_MIPS_CP0_CONFIG2:
+		v = (long)kvm_read_c0_guest_config2(cop0);
+		break;
+	case MSR_MIPS_CP0_CONFIG3:
+		v = (long)kvm_read_c0_guest_config3(cop0);
+		break;
+	case MSR_MIPS_CP0_CONFIG7:
+		v = (long)kvm_read_c0_guest_config7(cop0);
+		break;
+	default:
+		return -EINVAL;
+	}
+	*data = v;
+	return 0;
+}
 
-	kvm_write_c0_guest_status(cop0, regs->cp0reg[MIPS_CP0_STATUS][0]);
-	kvm_write_c0_guest_cause(cop0, regs->cp0reg[MIPS_CP0_CAUSE][0]);
-	kvm_write_c0_guest_pagemask(cop0,
-				    regs->cp0reg[MIPS_CP0_TLB_PG_MASK][0]);
-	kvm_write_c0_guest_wired(cop0, regs->cp0reg[MIPS_CP0_TLB_WIRED][0]);
-	kvm_write_c0_guest_errorepc(cop0, regs->cp0reg[MIPS_CP0_ERROR_PC][0]);
+static int mipsvz_set_msr(struct kvm_vcpu *vcpu, unsigned index, u64 *data)
+{
+	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	u64 v = *data;
 
+	switch (index) {
+	case MSR_MIPS_CP0_INDEX:
+		kvm_write_c0_guest_index(cop0, v);
+		break;
+	case MSR_MIPS_CP0_CONTEXT:
+		kvm_write_c0_guest_context(cop0, v);
+		break;
+	case MSR_MIPS_CP0_PAGEMASK:
+		kvm_write_c0_guest_pagemask(cop0, v);
+		break;
+	case MSR_MIPS_CP0_WIRED:
+		kvm_write_c0_guest_wired(cop0, v);
+		break;
+	case MSR_MIPS_CP0_BADVADDR:
+		kvm_write_c0_guest_badvaddr(cop0, v);
+		break;
+	case MSR_MIPS_CP0_ENTRYHI:
+		kvm_write_c0_guest_entryhi(cop0, v);
+		break;
+	case MSR_MIPS_CP0_STATUS:
+		kvm_write_c0_guest_status(cop0, v);
+		break;
+	case MSR_MIPS_CP0_CAUSE:
+		kvm_write_c0_guest_cause(cop0, v);
+		break;
+	case MSR_MIPS_CP0_ERROREPC:
+		kvm_write_c0_guest_errorepc(cop0, v);
+		break;
+	default:
+		return -EINVAL;
+	}
 	return 0;
 }
 
-static int
-kvm_trap_emul_ioctl_get_regs(struct kvm_vcpu *vcpu, struct kvm_regs *regs)
+/*
+ * Read or write a bunch of msrs. Parameters are user addresses.
+ *
+ * @return number of msrs set successfully.
+ */
+static int msr_io(struct kvm_vcpu *vcpu, struct kvm_msrs __user *user_msrs,
+		  int (*do_msr)(struct kvm_vcpu *vcpu,
+				unsigned index, u64 *data),
+		  bool writeback)
 {
-	struct mips_coproc *cop0 = vcpu->arch.cop0;
+	struct kvm_msrs msrs;
+	struct kvm_msr_entry *entries;
+	int r, n;
+	unsigned size;
+
+	r = -EFAULT;
+	if (copy_from_user(&msrs, user_msrs, sizeof(msrs)))
+		goto out;
+
+	r = -E2BIG;
+	if (msrs.nmsrs >= MAX_IO_MSRS)
+		goto out;
+
+	size = sizeof(struct kvm_msr_entry) * msrs.nmsrs;
+	entries = memdup_user(user_msrs->entries, size);
+	if (IS_ERR(entries)) {
+		r = PTR_ERR(entries);
+		goto out;
+	}
 
-	regs->cp0reg[MIPS_CP0_TLB_INDEX][0] = kvm_read_c0_guest_index(cop0);
-	regs->cp0reg[MIPS_CP0_TLB_CONTEXT][0] = kvm_read_c0_guest_context(cop0);
-	regs->cp0reg[MIPS_CP0_BAD_VADDR][0] = kvm_read_c0_guest_badvaddr(cop0);
-	regs->cp0reg[MIPS_CP0_TLB_HI][0] = kvm_read_c0_guest_entryhi(cop0);
-	regs->cp0reg[MIPS_CP0_EXC_PC][0] = kvm_read_c0_guest_epc(cop0);
-
-	regs->cp0reg[MIPS_CP0_STATUS][0] = kvm_read_c0_guest_status(cop0);
-	regs->cp0reg[MIPS_CP0_CAUSE][0] = kvm_read_c0_guest_cause(cop0);
-	regs->cp0reg[MIPS_CP0_TLB_PG_MASK][0] =
-	    kvm_read_c0_guest_pagemask(cop0);
-	regs->cp0reg[MIPS_CP0_TLB_WIRED][0] = kvm_read_c0_guest_wired(cop0);
-	regs->cp0reg[MIPS_CP0_ERROR_PC][0] = kvm_read_c0_guest_errorepc(cop0);
-
-	regs->cp0reg[MIPS_CP0_CONFIG][0] = kvm_read_c0_guest_config(cop0);
-	regs->cp0reg[MIPS_CP0_CONFIG][1] = kvm_read_c0_guest_config1(cop0);
-	regs->cp0reg[MIPS_CP0_CONFIG][2] = kvm_read_c0_guest_config2(cop0);
-	regs->cp0reg[MIPS_CP0_CONFIG][3] = kvm_read_c0_guest_config3(cop0);
-	regs->cp0reg[MIPS_CP0_CONFIG][7] = kvm_read_c0_guest_config7(cop0);
+	for (n = 0; n < msrs.nmsrs; ++n)
+		if (do_msr(vcpu, entries[n].index, &entries[n].data))
+			break;
+
+	r = -EFAULT;
+	if (writeback && copy_to_user(user_msrs->entries, entries, size))
+		goto out_free;
+
+	r = n;
+
+out_free:
+	kfree(entries);
+out:
+	return r;
+}
+
+static int kvm_mips_reset_vcpu(struct kvm_vcpu *vcpu)
+{
+	int i;
+	for_each_possible_cpu(i) {
+		vcpu->arch.guest_kernel_asid[i] = 0;
+		vcpu->arch.guest_user_asid[i] = 0;
+	}
+	return 0;
+}
+
+int
+kvm_vcpu_ioctl_interrupt(struct kvm_vcpu *vcpu, struct kvm_mips_interrupt *irq)
+{
+	int intr = (int)irq->irq;
+	struct kvm_vcpu *dvcpu = NULL;
+
+	if (intr == 3 || intr == -3 || intr == 4 || intr == -4)
+		kvm_debug("%s: CPU: %d, INTR: %d\n", __func__, irq->cpu,
+			  (int)intr);
+
+	if (irq->cpu == -1)
+		dvcpu = vcpu;
+	else
+		dvcpu = vcpu->kvm->vcpus[irq->cpu];
+
+	if (intr == 2 || intr == 3 || intr == 4) {
+		kvm_mips_callbacks->queue_io_int(dvcpu, irq);
+
+	} else if (intr == -2 || intr == -3 || intr == -4) {
+		kvm_mips_callbacks->dequeue_io_int(dvcpu, irq);
+	} else {
+		kvm_err("%s: invalid interrupt ioctl (%d:%d)\n", __func__,
+			irq->cpu, irq->irq);
+		return -EINVAL;
+	}
+
+	dvcpu->arch.wait = 0;
+
+	if (waitqueue_active(&dvcpu->wq))
+		wake_up_interruptible(&dvcpu->wq);
 
 	return 0;
 }
 
+long
+kvm_arch_vcpu_ioctl(struct file *filp, unsigned int ioctl, unsigned long arg)
+{
+	struct kvm_vcpu *vcpu = filp->private_data;
+	void __user *argp = (void __user *)arg;
+	long r;
+
+	switch (ioctl) {
+	case KVM_GET_MSRS:
+		r = msr_io(vcpu, argp, mipsvz_get_msr, true);
+		break;
+	case KVM_SET_MSRS:
+		r = msr_io(vcpu, argp, mipsvz_set_msr, false);
+		break;
+	case KVM_NMI:
+		/* Treat the NMI as a CPU reset */
+		r = kvm_mips_reset_vcpu(vcpu);
+		break;
+	case KVM_INTERRUPT:
+		{
+			struct kvm_mips_interrupt irq;
+			r = -EFAULT;
+			if (copy_from_user(&irq, argp, sizeof(irq)))
+				goto out;
+
+			kvm_debug("[%d] %s: irq: %d\n", vcpu->vcpu_id, __func__,
+				  irq.irq);
+
+			r = kvm_vcpu_ioctl_interrupt(vcpu, &irq);
+			break;
+		}
+	default:
+		r = -ENOIOCTLCMD;
+	}
+
+out:
+	return r;
+}
+
+long kvm_arch_dev_ioctl(struct file *filp,
+			unsigned int ioctl, unsigned long arg)
+{
+	long r;
+	void __user *argp = (void __user *)arg;
+
+	switch (ioctl) {
+	case KVM_GET_MSR_INDEX_LIST: {
+		struct kvm_msr_list __user *user_msr_list = argp;
+		struct kvm_msr_list msr_list;
+		unsigned n;
+		unsigned num_msrs_to_save;
+
+		r = -EFAULT;
+		if (copy_from_user(&msr_list, user_msr_list, sizeof(msr_list)))
+			goto out;
+		n = msr_list.nmsrs;
+		msr_list.nmsrs = ARRAY_SIZE(msrs_to_save);
+		num_msrs_to_save = min(n, msr_list.nmsrs);
+		if (copy_to_user(user_msr_list, &msr_list, sizeof(msr_list)))
+			goto out;
+		r = -E2BIG;
+		if (n < msr_list.nmsrs)
+			goto out;
+		r = -EFAULT;
+		if (copy_to_user(user_msr_list->indices, &msrs_to_save,
+				 num_msrs_to_save * sizeof(u32)))
+			goto out;
+		r = 0;
+		break;
+	}
+	default:
+		r = -ENOIOCTLCMD;
+	}
+out:
+	return r;
+}
+
 static int kvm_trap_emul_vm_init(struct kvm *kvm)
 {
 	return 0;
@@ -471,8 +729,6 @@ static struct kvm_mips_callbacks kvm_trap_emul_callbacks = {
 	.dequeue_io_int = kvm_mips_dequeue_io_int_cb,
 	.irq_deliver = kvm_mips_irq_deliver_cb,
 	.irq_clear = kvm_mips_irq_clear_cb,
-	.vcpu_ioctl_get_regs = kvm_trap_emul_ioctl_get_regs,
-	.vcpu_ioctl_set_regs = kvm_trap_emul_ioctl_set_regs,
 };
 
 int kvm_mips_emulation_init(struct kvm_mips_callbacks **install_callbacks)
-- 
1.7.11.7
