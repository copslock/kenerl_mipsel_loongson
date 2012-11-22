Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2012 03:38:36 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:54901 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6828077Ab2KVCfHoZXEg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Nov 2012 03:35:07 +0100
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 21 Nov 2012 18:35:00 -0800
Received: by agni.kymasys.com (Postfix, from userid 500)
        id 9F23563027E; Wed, 21 Nov 2012 18:34:18 -0800 (PST)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 09/18] KVM/MIPS32: COP0 accesses profiling.
Date:   Wed, 21 Nov 2012 18:34:07 -0800
Message-Id: <1353551656-23579-10-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
X-archive-position: 35087
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
 arch/mips/kvm/kvm_mips_stats.c | 81 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 81 insertions(+)
 create mode 100644 arch/mips/kvm/kvm_mips_stats.c

diff --git a/arch/mips/kvm/kvm_mips_stats.c b/arch/mips/kvm/kvm_mips_stats.c
new file mode 100644
index 0000000..e442a26
--- /dev/null
+++ b/arch/mips/kvm/kvm_mips_stats.c
@@ -0,0 +1,81 @@
+/*
+* This file is subject to the terms and conditions of the GNU General Public
+* License.  See the file "COPYING" in the main directory of this archive
+* for more details.
+*
+* KVM/MIPS: COP0 access histogram
+*
+* Copyright (C) 2012  MIPS Technologies, Inc.  All rights reserved.
+* Authors: Sanjay Lal <sanjayl@kymasys.com>
+*/
+
+#include <linux/kvm_host.h>
+
+char *kvm_mips_exit_types_str[MAX_KVM_MIPS_EXIT_TYPES] = {
+	"WAIT",
+	"CACHE",
+	"Signal",
+	"Interrupt",
+	"COP0/1 Unusable",
+	"TLB Mod",
+	"TLB Miss (LD)",
+	"TLB Miss (ST)",
+	"Address Err (ST)",
+	"Address Error (LD)",
+	"System Call",
+	"Reserved Inst",
+	"Break Inst",
+	"D-Cache Flushes",
+};
+
+char *kvm_cop0_str[N_MIPS_COPROC_REGS] = {
+	"Index",
+	"Random",
+	"EntryLo0",
+	"EntryLo1",
+	"Context",
+	"PG Mask",
+	"Wired",
+	"HWREna",
+	"BadVAddr",
+	"Count",
+	"EntryHI",
+	"Compare",
+	"Status",
+	"Cause",
+	"EXC PC",
+	"PRID",
+	"Config",
+	"LLAddr",
+	"Watch Lo",
+	"Watch Hi",
+	"X Context",
+	"Reserved",
+	"Impl Dep",
+	"Debug",
+	"DEPC",
+	"PerfCnt",
+	"ErrCtl",
+	"CacheErr",
+	"TagLo",
+	"TagHi",
+	"ErrorEPC",
+	"DESAVE"
+};
+
+int kvm_mips_dump_stats(struct kvm_vcpu *vcpu)
+{
+	int i, j __unused;
+#ifdef CONFIG_KVM_MIPS_DEBUG_COP0_COUNTERS
+	printk("\nKVM VCPU[%d] COP0 Access Profile:\n", vcpu->vcpu_id);
+	for (i = 0; i < N_MIPS_COPROC_REGS; i++) {
+		for (j = 0; j < N_MIPS_COPROC_SEL; j++) {
+			if (vcpu->arch.cop0->stat[i][j])
+				printk("%s[%d]: %lu\n", kvm_cop0_str[i], j,
+				       vcpu->arch.cop0->stat[i][j]);
+		}
+	}
+#endif
+
+	return 0;
+}
-- 
1.7.11.3
