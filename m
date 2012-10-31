Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 16:24:12 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:52963 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6822164Ab2JaPUXvBK-8 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2012 16:20:23 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 31 Oct 2012 08:20:14 -0700
From:   Sanjay Lal <sanjayl@kymasys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 10/20] KVM/MIPS32: Keep track of VM exits and a historgram of  COP0 accesses.
Date:   Wed, 31 Oct 2012 11:20:11 -0400
Message-Id: <F20462A4-DD7D-40C8-813D-6742742EBEF9@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Mime-Version: 1.0 (Apple Message framework v1283)
X-Mailer: Apple Mail (2.1283)
X-archive-position: 34823
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
 arch/mips/kvm/kvm_mips_stats.c | 93 ++++++++++++++++++++++++++++++++++++++++++
 arch/mips/kvm/kvm_mips_stats.h | 47 +++++++++++++++++++++
 2 files changed, 140 insertions(+)
 create mode 100644 arch/mips/kvm/kvm_mips_stats.c
 create mode 100644 arch/mips/kvm/kvm_mips_stats.h

diff --git a/arch/mips/kvm/kvm_mips_stats.c b/arch/mips/kvm/kvm_mips_stats.c
new file mode 100644
index 0000000..232e91b
--- /dev/null
+++ b/arch/mips/kvm/kvm_mips_stats.c
@@ -0,0 +1,93 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+* KVM/MIPS: VM Exit stats, COP0 access histogram
+*
+* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+* Authors: Sanjay Lal <sanjayl@kymasys.com>
+*/
+
+#include <linux/kvm_host.h>
+
+char *kvm_mips_exit_types_str[MAX_KVM_MIPS_EXIT_TYPES] = {
+    "WAIT",
+    "CACHE",
+    "Signal",
+    "Interrupt",
+    "COP0/1 Unusable",
+    "TLB Mod",
+    "TLB Miss (LD)",
+    "TLB Miss (ST)",
+    "Address Err (ST)",
+    "Address Error (LD)",
+    "System Call",
+    "Reserved Inst",
+    "Break Inst",
+    "D-Cache Flushes",
+};
+
+char *kvm_cop0_str[N_MIPS_COPROC_REGS] = {
+    "Index",
+    "Random",
+    "EntryLo0",
+    "EntryLo1",
+    "Context",
+    "PG Mask",
+    "Wired",
+    "HWREna",
+    "BadVAddr",
+    "Count",
+    "EntryHI",
+    "Compare",
+    "Status",
+    "Cause",
+    "EXC PC",
+    "PRID",
+    "Config",
+    "LLAddr",
+    "Watch Lo",
+    "Watch Hi",
+    "X Context",
+    "Reserved",
+    "Impl Dep",
+    "Debug",
+    "DEPC",
+    "PerfCnt",
+    "ErrCtl",
+    "CacheErr",
+    "TagLo",
+    "TagHi",
+    "ErrorEPC",
+    "DESAVE"
+};
+
+int
+kvm_mips_dump_stats(struct kvm_vcpu *vcpu)
+{
+    int i, j __unused;
+    ulong total_exits = 0;
+
+    /* 1st run, total exits */
+    for (i = 0; i < MAX_KVM_MIPS_EXIT_TYPES; i++) {
+        total_exits += vcpu->arch.exit_reason_stats[i];
+    }
+
+    printk("KVM Exit Stats (%lu total exits):\n", total_exits);
+    for (i = 0; i < MAX_KVM_MIPS_EXIT_TYPES; i++) {
+        printk("\t%s: %lu\n", kvm_mips_exit_types_str[i], vcpu->arch.exit_reason_stats[i]);
+    }
+
+#ifdef CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS
+    printk("\nKVM COP0 Access Profile:\n");
+    for (i = 0; i < N_MIPS_COPROC_REGS; i++) {
+        for (j = 0; j < N_MIPS_COPROC_SEL; j++) {
+            if (vcpu->arch.cop0->stat[i][j])
+                printk("%s[%d]: %lu\n", kvm_cop0_str[i], j, vcpu->arch.cop0->stat[i][j]);
+        }
+    }
+#endif
+
+    return 0;
+}
diff --git a/arch/mips/kvm/kvm_mips_stats.h b/arch/mips/kvm/kvm_mips_stats.h
new file mode 100644
index 0000000..df6872a
--- /dev/null
+++ b/arch/mips/kvm/kvm_mips_stats.h
@@ -0,0 +1,47 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+* KVM/MIPS: Instrumentation, currently logs VM exit stats and COP0 accesses
+*
+* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+* Authors: Sanjay Lal <sanjayl@kymasys.com>
+*/
+
+#ifndef __KVM_MIPS_STATS_H__
+#define __KVM_MIPS_STATS_H__
+
+#include <linux/kvm_host.h>
+#include <asm/kvm_host.h>
+
+#ifdef CONFIG_KVM_EXIT_STATS
+void kvm_mips_create_vcpu_debugfs(struct kvm_vcpu *vcpu, unsigned int id);
+void kvm_mips_remove_vcpu_debugfs(struct kvm_vcpu *vcpu);
+
+static inline void kvm_mips_set_exit_type(struct kvm_vcpu *vcpu, int type)
+{
+}
+
+/* account the exit in kvm_stats */
+static inline void kvm_mips_account_exit_stat(struct kvm_vcpu *vcpu, enum kvm_mips_exit_types type)
+{
+    vcpu->arch.exit_reason_stats[type]++;
+}
+
+/* wrapper to set exit time and account for it in kvm_stats */
+static inline void kvm_mips_account_exit(struct kvm_vcpu *vcpu, enum kvm_mips_exit_types type)
+{
+	kvm_mips_account_exit_stat(vcpu, type);
+}
+
+#else
+static inline void kvm_mips_create_vcpu_debugfs(struct kvm_vcpu *vcpu,
+						unsigned int id) {}
+static inline void kvm_mips_remove_vcpu_debugfs(struct kvm_vcpu *vcpu) {}
+static inline void kvm_mips_set_exit_type(struct kvm_vcpu *vcpu, int type) {}
+
+static inline void kvm_mips_account_exit(struct kvm_vcpu *vcpu, enum kvm_mips_exit_types type) {}
+#endif /* CONFIG_KVM_EXIT_STATS*/
+
+#endif /* __KVM_MIPS_STATS_H__ */
-- 
1.7.11.3
