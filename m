Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 16:23:21 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:54814 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6825656Ab2JaPTvyOG8J convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2012 16:19:51 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 31 Oct 2012 08:19:45 -0700
From:   Sanjay Lal <sanjayl@kymasys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 07/20] KVM/MIPS32: Dynamic binary translation of select  privileged instructions.
Date:   Wed, 31 Oct 2012 11:19:41 -0400
Message-Id: <3E678B37-B4C1-409F-A1CB-A7CC83B2D874@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Mime-Version: 1.0 (Apple Message framework v1283)
X-Mailer: Apple Mail (2.1283)
X-archive-position: 34820
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

Currently, the following instructions are translated:
- CACHE (indexed)
- CACHE (va based): translated to a synci, overkill on D-CACHE operations, but still much faster than a trap.
- mfc0/mtc0: the virtual COP0 registers for the guest are implemented as 2-D array
  [COP#][SEL] and this is mapped into the guest kernel address space @ VA 0x0.
  mfc0/mtc0 operations are transformed to load/stores.

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/kvm/kvm_mips_comm.h     |  24 +++++++
 arch/mips/kvm/kvm_mips_commpage.c |  38 ++++++++++
 arch/mips/kvm/kvm_mips_dyntrans.c | 142 ++++++++++++++++++++++++++++++++++++++
 3 files changed, 204 insertions(+)
 create mode 100644 arch/mips/kvm/kvm_mips_comm.h
 create mode 100644 arch/mips/kvm/kvm_mips_commpage.c
 create mode 100644 arch/mips/kvm/kvm_mips_dyntrans.c

diff --git a/arch/mips/kvm/kvm_mips_comm.h b/arch/mips/kvm/kvm_mips_comm.h
new file mode 100644
index 0000000..02073db
--- /dev/null
+++ b/arch/mips/kvm/kvm_mips_comm.h
@@ -0,0 +1,24 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+* KVM/MIPS commpage: mapped into guest kernel @ VA: 0x0 to support dynamic translation
+*
+* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+* Authors: Sanjay Lal <sanjayl@kymasys.com>
+*/
+
+#ifndef __KVM_MIPS_COMMPAGE_H__
+#define __KVM_MIPS_COMMPAGE_H__
+
+struct kvm_mips_commpage {
+    struct mips_coproc cop0;    /* COP0 state is mapped into Guest kernel via commpage */
+};
+
+#define KVM_MIPS_COMM_EIDI_OFFSET       0x0
+
+extern void kvm_mips_commpage_init (struct kvm_vcpu *vcpu);
+
+#endif /* __KVM_MIPS_COMMPAGE_H__ */
+
diff --git a/arch/mips/kvm/kvm_mips_commpage.c b/arch/mips/kvm/kvm_mips_commpage.c
new file mode 100644
index 0000000..5a4b21f
--- /dev/null
+++ b/arch/mips/kvm/kvm_mips_commpage.c
@@ -0,0 +1,38 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+* commpage, currently used for Virtual COP0 registers. Mapped into the guest kernel
+* aspace @ 0x0.
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
+void
+kvm_mips_commpage_init (struct kvm_vcpu *vcpu)
+{
+    struct kvm_mips_commpage *page = vcpu->arch.kseg0_commpage;
+    memset (page, 0, sizeof(struct kvm_mips_commpage));
+
+    /* Specific init values for fields */
+    vcpu->arch.cop0 = &page->cop0;
+    memset(vcpu->arch.cop0, 0, sizeof(struct mips_coproc));
+
+    return;
+}
diff --git a/arch/mips/kvm/kvm_mips_dyntrans.c b/arch/mips/kvm/kvm_mips_dyntrans.c
new file mode 100644
index 0000000..2cbbdde
--- /dev/null
+++ b/arch/mips/kvm/kvm_mips_dyntrans.c
@@ -0,0 +1,142 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+* KVM/MIPS: Dynamic translation for privileged instructions, reduces traps.
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
+kvm_mips_trans_cache_index (uint32_t inst, uint32_t __user *opc, struct kvm_vcpu *vcpu)
+{
+    int result = 0;
+    ulong kseg0_opc;
+    uint32_t synci_inst = 0x0;
+
+    /* Replace the CACHE instruction, with a NOP */
+    kseg0_opc = CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa (vcpu, (ulong) opc));
+    memcpy((void *) kseg0_opc, (void *)&synci_inst, sizeof(uint32_t));
+    mips32_SyncICache(kseg0_opc, 32);
+
+    return (result);
+}
+
+/*
+ *  Address based CACHE instructions are transformed into synci(s). A little heavy
+ * for just D-cache invalidates, but avoids an expensive trap
+ */
+int
+kvm_mips_trans_cache_va (uint32_t inst, uint32_t __user *opc, struct kvm_vcpu *vcpu)
+{
+    int result = 0;
+    ulong kseg0_opc;
+    uint32_t synci_inst = SYNCI_TEMPLATE, base, offset;
+
+    base = (inst >> 21) & 0x1f;
+    offset = inst & 0xffff;
+    synci_inst |= (base << 21);
+    synci_inst |= offset;
+
+    kseg0_opc = CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa (vcpu, (ulong) opc));
+    memcpy((void *) kseg0_opc, (void *)&synci_inst, sizeof(uint32_t));
+    mips32_SyncICache(kseg0_opc, 32);
+
+    return (result);
+}
+
+
+int
+kvm_mips_trans_mfc0 (uint32_t inst, uint32_t __user *opc, struct kvm_vcpu *vcpu)
+{
+    int32_t rt, rd, sel;
+    uint32_t mfc0_inst;
+    ulong kseg0_opc, flags;
+    
+
+    rt = (inst >> 16) & 0x1f;
+    rd = (inst >> 11) & 0x1f;
+    sel = inst & 0x7;
+
+    if ((rd == MIPS_CP0_ERRCTL) && (sel == 0)) {
+        mfc0_inst = CLEAR_TEMPLATE;
+        mfc0_inst |= ((rt & 0x1f) << 16);
+    }
+    else {
+        mfc0_inst = LW_TEMPLATE;
+        mfc0_inst |= ((rt & 0x1f) << 16);
+        mfc0_inst |= offsetof(struct mips_coproc, reg[rd][sel]) + offsetof(struct kvm_mips_commpage, cop0);
+    }
+
+    if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
+        kseg0_opc = CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa (vcpu, (ulong) opc));
+        memcpy((void *) kseg0_opc, (void *)&mfc0_inst, sizeof(uint32_t));
+        mips32_SyncICache(kseg0_opc, 32);
+    }
+    else if (KVM_GUEST_KSEGX((ulong)opc) == KVM_GUEST_KSEG23) {
+        ENTER_CRITICAL(flags);
+        memcpy((void *) opc, (void *)&mfc0_inst, sizeof(uint32_t));
+        mips32_SyncICache((ulong)opc, 32);
+        EXIT_CRITICAL(flags);
+    }
+    else {
+        kvm_err("%s: Invalid address: %p\n", __func__, opc);
+        return -EFAULT; 
+    }
+
+    return 0;
+}
+
+int
+kvm_mips_trans_mtc0 (uint32_t inst, uint32_t __user *opc, struct kvm_vcpu *vcpu)
+{
+    int32_t rt, rd, sel;
+    uint32_t mtc0_inst = SW_TEMPLATE;
+    ulong kseg0_opc, flags;
+
+    rt = (inst >> 16) & 0x1f;
+    rd = (inst >> 11) & 0x1f;
+    sel = inst & 0x7;
+
+    mtc0_inst |= ((rt & 0x1f) << 16);
+    mtc0_inst |= offsetof(struct mips_coproc, reg[rd][sel]) + offsetof(struct kvm_mips_commpage, cop0);
+
+    if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
+        kseg0_opc = CKSEG0ADDR(kvm_mips_translate_guest_kseg0_to_hpa (vcpu, (ulong) opc));
+        memcpy((void *) kseg0_opc, (void *)&mtc0_inst, sizeof(uint32_t));
+        mips32_SyncICache(kseg0_opc, 32);
+    }
+    else if (KVM_GUEST_KSEGX((ulong)opc) == KVM_GUEST_KSEG23) {
+        ENTER_CRITICAL(flags);
+        memcpy((void *) opc, (void *)&mtc0_inst, sizeof(uint32_t));
+        mips32_SyncICache((ulong)opc, 32);
+        EXIT_CRITICAL(flags);
+    }
+    else {
+        kvm_err("%s: Invalid address: %p\n", __func__, opc);
+        return -EFAULT; 
+    }
+
+    return 0;
+}
+
-- 
1.7.11.3
