Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2012 03:40:30 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:54565 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6828082Ab2KVCfqdRI1V (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Nov 2012 03:35:46 +0100
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 21 Nov 2012 18:35:37 -0800
Received: by agni.kymasys.com (Postfix, from userid 500)
        id B97B0630287; Wed, 21 Nov 2012 18:34:18 -0800 (PST)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 18/18] KVM/MIPS32: Binary patching of select privileged instructions.
Date:   Wed, 21 Nov 2012 18:34:16 -0800
Message-Id: <1353551656-23579-19-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
X-archive-position: 35093
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

Currently, the following instructions are translated:
- CACHE (indexed)
- CACHE (va based): translated to a synci, overkill on D-CACHE operations, but still much faster than a trap.
- mfc0/mtc0: the virtual COP0 registers for the guest are implemented as 2-D array
  [COP#][SEL] and this is mapped into the guest kernel address space @ VA 0x0.
  mfc0/mtc0 operations are transformed to load/stores.

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_mips_comm.h     |  23 ++++++
 arch/mips/kvm/kvm_mips_commpage.c |  37 ++++++++++
 arch/mips/kvm/kvm_mips_dyntrans.c | 149 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 209 insertions(+)
 create mode 100644 arch/mips/kvm/kvm_mips_comm.h
 create mode 100644 arch/mips/kvm/kvm_mips_commpage.c
 create mode 100644 arch/mips/kvm/kvm_mips_dyntrans.c

diff --git a/arch/mips/kvm/kvm_mips_comm.h b/arch/mips/kvm/kvm_mips_comm.h
new file mode 100644
index 0000000..7e903ec
--- /dev/null
+++ b/arch/mips/kvm/kvm_mips_comm.h
@@ -0,0 +1,23 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+* KVM/MIPS: commpage: mapped into get kernel space 
+*
+* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+* Authors: Sanjay Lal <sanjayl@kymasys.com>
+*/
+
+#ifndef __KVM_MIPS_COMMPAGE_H__
+#define __KVM_MIPS_COMMPAGE_H__
+
+struct kvm_mips_commpage {
+	struct mips_coproc cop0;	/* COP0 state is mapped into Guest kernel via commpage */
+};
+
+#define KVM_MIPS_COMM_EIDI_OFFSET       0x0
+
+extern void kvm_mips_commpage_init(struct kvm_vcpu *vcpu);
+
+#endif /* __KVM_MIPS_COMMPAGE_H__ */
diff --git a/arch/mips/kvm/kvm_mips_commpage.c b/arch/mips/kvm/kvm_mips_commpage.c
new file mode 100644
index 0000000..3873b1e
--- /dev/null
+++ b/arch/mips/kvm/kvm_mips_commpage.c
@@ -0,0 +1,37 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+* commpage, currently used for Virtual COP0 registers.
+* Mapped into the guest kernel @ 0x0.
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
+#include <asm/mmu_context.h>
+
+#include <linux/kvm_host.h>
+
+#include "kvm_mips_comm.h"
+
+void kvm_mips_commpage_init(struct kvm_vcpu *vcpu)
+{
+	struct kvm_mips_commpage *page = vcpu->arch.kseg0_commpage;
+	memset(page, 0, sizeof(struct kvm_mips_commpage));
+
+	/* Specific init values for fields */
+	vcpu->arch.cop0 = &page->cop0;
+	memset(vcpu->arch.cop0, 0, sizeof(struct mips_coproc));
+
+	return;
+}
diff --git a/arch/mips/kvm/kvm_mips_dyntrans.c b/arch/mips/kvm/kvm_mips_dyntrans.c
new file mode 100644
index 0000000..c657b37
--- /dev/null
+++ b/arch/mips/kvm/kvm_mips_dyntrans.c
@@ -0,0 +1,149 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+* KVM/MIPS: Binary Patching for privileged instructions, reduces traps.
+*
+* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+* Authors: Sanjay Lal <sanjayl@kymasys.com>
+*/
+
+#include <linux/errno.h>
+#include <linux/err.h>
+#include <linux/kvm_host.h>
+#include <linux/module.h>
+#include <linux/vmalloc.h>
+#include <linux/fs.h>
+#include <linux/bootmem.h>
+
+#include "kvm_mips_comm.h"
+
+#define SYNCI_TEMPLATE  0x041f0000
+#define SYNCI_BASE(x)   (((x) >> 21) & 0x1f)
+#define SYNCI_OFFSET    ((x) & 0xffff)
+
+#define LW_TEMPLATE     0x8c000000
+#define CLEAR_TEMPLATE  0x00000020
+#define SW_TEMPLATE     0xac000000
+
+int
+kvm_mips_trans_cache_index(uint32_t inst, uint32_t *opc,
+			   struct kvm_vcpu *vcpu)
+{
+	int result = 0;
+	ulong kseg0_opc;
+	uint32_t synci_inst = 0x0;
+
+	/* Replace the CACHE instruction, with a NOP */
+	kseg0_opc =
+	    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
+		       (vcpu, (ulong) opc));
+	memcpy((void *)kseg0_opc, (void *)&synci_inst, sizeof(uint32_t));
+	mips32_SyncICache(kseg0_opc, 32);
+
+	return result;
+}
+
+/*
+ *  Address based CACHE instructions are transformed into synci(s). A little heavy
+ * for just D-cache invalidates, but avoids an expensive trap
+ */
+int
+kvm_mips_trans_cache_va(uint32_t inst, uint32_t *opc,
+			struct kvm_vcpu *vcpu)
+{
+	int result = 0;
+	ulong kseg0_opc;
+	uint32_t synci_inst = SYNCI_TEMPLATE, base, offset;
+
+	base = (inst >> 21) & 0x1f;
+	offset = inst & 0xffff;
+	synci_inst |= (base << 21);
+	synci_inst |= offset;
+
+	kseg0_opc =
+	    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
+		       (vcpu, (ulong) opc));
+	memcpy((void *)kseg0_opc, (void *)&synci_inst, sizeof(uint32_t));
+	mips32_SyncICache(kseg0_opc, 32);
+
+	return result;
+}
+
+int
+kvm_mips_trans_mfc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
+{
+	int32_t rt, rd, sel;
+	uint32_t mfc0_inst;
+	ulong kseg0_opc, flags;
+
+	rt = (inst >> 16) & 0x1f;
+	rd = (inst >> 11) & 0x1f;
+	sel = inst & 0x7;
+
+	if ((rd == MIPS_CP0_ERRCTL) && (sel == 0)) {
+		mfc0_inst = CLEAR_TEMPLATE;
+		mfc0_inst |= ((rt & 0x1f) << 16);
+	} else {
+		mfc0_inst = LW_TEMPLATE;
+		mfc0_inst |= ((rt & 0x1f) << 16);
+		mfc0_inst |=
+		    offsetof(struct mips_coproc,
+			     reg[rd][sel]) + offsetof(struct kvm_mips_commpage,
+						      cop0);
+	}
+
+	if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
+		kseg0_opc =
+		    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
+			       (vcpu, (ulong) opc));
+		memcpy((void *)kseg0_opc, (void *)&mfc0_inst, sizeof(uint32_t));
+		mips32_SyncICache(kseg0_opc, 32);
+	} else if (KVM_GUEST_KSEGX((ulong) opc) == KVM_GUEST_KSEG23) {
+		local_irq_save(flags);
+		memcpy((void *)opc, (void *)&mfc0_inst, sizeof(uint32_t));
+		mips32_SyncICache((ulong) opc, 32);
+		local_irq_restore(flags);
+	} else {
+		kvm_err("%s: Invalid address: %p\n", __func__, opc);
+		return -EFAULT;
+	}
+
+	return 0;
+}
+
+int
+kvm_mips_trans_mtc0(uint32_t inst, uint32_t *opc, struct kvm_vcpu *vcpu)
+{
+	int32_t rt, rd, sel;
+	uint32_t mtc0_inst = SW_TEMPLATE;
+	ulong kseg0_opc, flags;
+
+	rt = (inst >> 16) & 0x1f;
+	rd = (inst >> 11) & 0x1f;
+	sel = inst & 0x7;
+
+	mtc0_inst |= ((rt & 0x1f) << 16);
+	mtc0_inst |=
+	    offsetof(struct mips_coproc,
+		     reg[rd][sel]) + offsetof(struct kvm_mips_commpage, cop0);
+
+	if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
+		kseg0_opc =
+		    CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa
+			       (vcpu, (ulong) opc));
+		memcpy((void *)kseg0_opc, (void *)&mtc0_inst, sizeof(uint32_t));
+		mips32_SyncICache(kseg0_opc, 32);
+	} else if (KVM_GUEST_KSEGX((ulong) opc) == KVM_GUEST_KSEG23) {
+		local_irq_save(flags);
+		memcpy((void *)opc, (void *)&mtc0_inst, sizeof(uint32_t));
+		mips32_SyncICache((ulong) opc, 32);
+		local_irq_restore(flags);
+	} else {
+		kvm_err("%s: Invalid address: %p\n", __func__, opc);
+		return -EFAULT;
+	}
+
+	return 0;
+}
-- 
1.7.11.3
