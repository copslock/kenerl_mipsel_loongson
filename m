Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Jun 2014 19:34:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6680 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6816503AbaFXRbnZ1gq9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 24 Jun 2014 19:31:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 82CA9EDE54D5F;
        Tue, 24 Jun 2014 18:31:32 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.181.6; Tue, 24 Jun
 2014 18:31:35 +0100
Received: from BAMAIL02.ba.imgtec.org (192.168.66.28) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Tue, 24 Jun 2014 18:31:35 +0100
Received: from fun-lab.mips.com (10.20.2.221) by bamail02.ba.imgtec.org
 (192.168.66.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 24 Jun
 2014 10:31:33 -0700
From:   Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
To:     <pbonzini@redhat.com>
CC:     <gleb@kernel.org>, <kvm@vger.kernel.org>, <sanjayl@kymasys.com>,
        <james.hogan@imgtec.com>, <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <dengcheng.zhu@imgtec.com>
Subject: [PATCH v3 5/9] MIPS: KVM: Rename files to remove the prefix "kvm_" and "kvm_mips_"
Date:   Tue, 24 Jun 2014 10:31:06 -0700
Message-ID: <1403631071-6012-6-git-send-email-dengcheng.zhu@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1403631071-6012-1-git-send-email-dengcheng.zhu@imgtec.com>
References: <1403631071-6012-1-git-send-email-dengcheng.zhu@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.20.2.221]
Return-Path: <DengCheng.Zhu@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40748
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dengcheng.zhu@imgtec.com
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

From: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>

Since all the files are in arch/mips/kvm/, there's no need of the prefixes
"kvm_" and "kvm_mips_".

Signed-off-by: Deng-Cheng Zhu <dengcheng.zhu@imgtec.com>
---
 arch/mips/kvm/Makefile                            | 8 ++++----
 arch/mips/kvm/{kvm_cb.c => callback.c}            | 0
 arch/mips/kvm/{kvm_mips_commpage.c => commpage.c} | 2 +-
 arch/mips/kvm/{kvm_mips_comm.h => commpage.h}     | 0
 arch/mips/kvm/{kvm_mips_dyntrans.c => dyntrans.c} | 2 +-
 arch/mips/kvm/{kvm_mips_emul.c => emulate.c}      | 6 +++---
 arch/mips/kvm/{kvm_mips_int.c => interrupt.c}     | 2 +-
 arch/mips/kvm/{kvm_mips_int.h => interrupt.h}     | 0
 arch/mips/kvm/{kvm_locore.S => locore.S}          | 0
 arch/mips/kvm/{kvm_mips.c => mips.c}              | 6 +++---
 arch/mips/kvm/{kvm_mips_opcode.h => opcode.h}     | 0
 arch/mips/kvm/{kvm_mips_stats.c => stats.c}       | 0
 arch/mips/kvm/{kvm_tlb.c => tlb.c}                | 0
 arch/mips/kvm/{kvm_trap_emul.c => trap_emul.c}    | 4 ++--
 14 files changed, 15 insertions(+), 15 deletions(-)
 rename arch/mips/kvm/{kvm_cb.c => callback.c} (100%)
 rename arch/mips/kvm/{kvm_mips_commpage.c => commpage.c} (97%)
 rename arch/mips/kvm/{kvm_mips_comm.h => commpage.h} (100%)
 rename arch/mips/kvm/{kvm_mips_dyntrans.c => dyntrans.c} (99%)
 rename arch/mips/kvm/{kvm_mips_emul.c => emulate.c} (99%)
 rename arch/mips/kvm/{kvm_mips_int.c => interrupt.c} (99%)
 rename arch/mips/kvm/{kvm_mips_int.h => interrupt.h} (100%)
 rename arch/mips/kvm/{kvm_locore.S => locore.S} (100%)
 rename arch/mips/kvm/{kvm_mips.c => mips.c} (99%)
 rename arch/mips/kvm/{kvm_mips_opcode.h => opcode.h} (100%)
 rename arch/mips/kvm/{kvm_mips_stats.c => stats.c} (100%)
 rename arch/mips/kvm/{kvm_tlb.c => tlb.c} (100%)
 rename arch/mips/kvm/{kvm_trap_emul.c => trap_emul.c} (99%)

diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
index 78d87bb..401fe02 100644
--- a/arch/mips/kvm/Makefile
+++ b/arch/mips/kvm/Makefile
@@ -5,9 +5,9 @@ common-objs = $(addprefix ../../../virt/kvm/, kvm_main.o coalesced_mmio.o)
 
 EXTRA_CFLAGS += -Ivirt/kvm -Iarch/mips/kvm
 
-kvm-objs := $(common-objs) kvm_mips.o kvm_mips_emul.o kvm_locore.o \
-	    kvm_mips_int.o kvm_mips_stats.o kvm_mips_commpage.o \
-	    kvm_mips_dyntrans.o kvm_trap_emul.o
+kvm-objs := $(common-objs) mips.o emulate.o locore.o \
+	    interrupt.o stats.o commpage.o \
+	    dyntrans.o trap_emul.o
 
 obj-$(CONFIG_KVM)	+= kvm.o
-obj-y			+= kvm_cb.o kvm_tlb.o
+obj-y			+= callback.o tlb.o
diff --git a/arch/mips/kvm/kvm_cb.c b/arch/mips/kvm/callback.c
similarity index 100%
rename from arch/mips/kvm/kvm_cb.c
rename to arch/mips/kvm/callback.c
diff --git a/arch/mips/kvm/kvm_mips_commpage.c b/arch/mips/kvm/commpage.c
similarity index 97%
rename from arch/mips/kvm/kvm_mips_commpage.c
rename to arch/mips/kvm/commpage.c
index 4b5612b..61b9c04 100644
--- a/arch/mips/kvm/kvm_mips_commpage.c
+++ b/arch/mips/kvm/commpage.c
@@ -22,7 +22,7 @@
 
 #include <linux/kvm_host.h>
 
-#include "kvm_mips_comm.h"
+#include "commpage.h"
 
 void kvm_mips_commpage_init(struct kvm_vcpu *vcpu)
 {
diff --git a/arch/mips/kvm/kvm_mips_comm.h b/arch/mips/kvm/commpage.h
similarity index 100%
rename from arch/mips/kvm/kvm_mips_comm.h
rename to arch/mips/kvm/commpage.h
diff --git a/arch/mips/kvm/kvm_mips_dyntrans.c b/arch/mips/kvm/dyntrans.c
similarity index 99%
rename from arch/mips/kvm/kvm_mips_dyntrans.c
rename to arch/mips/kvm/dyntrans.c
index fa7184d..521121b 100644
--- a/arch/mips/kvm/kvm_mips_dyntrans.c
+++ b/arch/mips/kvm/dyntrans.c
@@ -18,7 +18,7 @@
 #include <linux/bootmem.h>
 #include <asm/cacheflush.h>
 
-#include "kvm_mips_comm.h"
+#include "commpage.h"
 
 #define SYNCI_TEMPLATE  0x041f0000
 #define SYNCI_BASE(x)   (((x) >> 21) & 0x1f)
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/emulate.c
similarity index 99%
rename from arch/mips/kvm/kvm_mips_emul.c
rename to arch/mips/kvm/emulate.c
index e5862bc..982f4af 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/emulate.c
@@ -29,9 +29,9 @@
 #include <asm/r4kcache.h>
 #define CONFIG_MIPS_MT
 
-#include "kvm_mips_opcode.h"
-#include "kvm_mips_int.h"
-#include "kvm_mips_comm.h"
+#include "opcode.h"
+#include "interrupt.h"
+#include "commpage.h"
 
 #include "trace.h"
 
diff --git a/arch/mips/kvm/kvm_mips_int.c b/arch/mips/kvm/interrupt.c
similarity index 99%
rename from arch/mips/kvm/kvm_mips_int.c
rename to arch/mips/kvm/interrupt.c
index d458c04..9b44459 100644
--- a/arch/mips/kvm/kvm_mips_int.c
+++ b/arch/mips/kvm/interrupt.c
@@ -20,7 +20,7 @@
 
 #include <linux/kvm_host.h>
 
-#include "kvm_mips_int.h"
+#include "interrupt.h"
 
 void kvm_mips_queue_irq(struct kvm_vcpu *vcpu, uint32_t priority)
 {
diff --git a/arch/mips/kvm/kvm_mips_int.h b/arch/mips/kvm/interrupt.h
similarity index 100%
rename from arch/mips/kvm/kvm_mips_int.h
rename to arch/mips/kvm/interrupt.h
diff --git a/arch/mips/kvm/kvm_locore.S b/arch/mips/kvm/locore.S
similarity index 100%
rename from arch/mips/kvm/kvm_locore.S
rename to arch/mips/kvm/locore.S
diff --git a/arch/mips/kvm/kvm_mips.c b/arch/mips/kvm/mips.c
similarity index 99%
rename from arch/mips/kvm/kvm_mips.c
rename to arch/mips/kvm/mips.c
index cabcac0a..27250ee 100644
--- a/arch/mips/kvm/kvm_mips.c
+++ b/arch/mips/kvm/mips.c
@@ -21,8 +21,8 @@
 
 #include <linux/kvm_host.h>
 
-#include "kvm_mips_int.h"
-#include "kvm_mips_comm.h"
+#include "interrupt.h"
+#include "commpage.h"
 
 #define CREATE_TRACE_POINTS
 #include "trace.h"
@@ -1188,7 +1188,7 @@ int __init kvm_mips_init(void)
 	/*
 	 * On MIPS, kernel modules are executed from "mapped space", which
 	 * requires TLBs. The TLB handling code is statically linked with
-	 * the rest of the kernel (kvm_tlb.c) to avoid the possibility of
+	 * the rest of the kernel (tlb.c) to avoid the possibility of
 	 * double faulting. The issue is that the TLB code references
 	 * routines that are part of the the KVM module, which are only
 	 * available once the module is loaded.
diff --git a/arch/mips/kvm/kvm_mips_opcode.h b/arch/mips/kvm/opcode.h
similarity index 100%
rename from arch/mips/kvm/kvm_mips_opcode.h
rename to arch/mips/kvm/opcode.h
diff --git a/arch/mips/kvm/kvm_mips_stats.c b/arch/mips/kvm/stats.c
similarity index 100%
rename from arch/mips/kvm/kvm_mips_stats.c
rename to arch/mips/kvm/stats.c
diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/tlb.c
similarity index 100%
rename from arch/mips/kvm/kvm_tlb.c
rename to arch/mips/kvm/tlb.c
diff --git a/arch/mips/kvm/kvm_trap_emul.c b/arch/mips/kvm/trap_emul.c
similarity index 99%
rename from arch/mips/kvm/kvm_trap_emul.c
rename to arch/mips/kvm/trap_emul.c
index ca11c5f..7ecf0ef 100644
--- a/arch/mips/kvm/kvm_trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -16,8 +16,8 @@
 
 #include <linux/kvm_host.h>
 
-#include "kvm_mips_opcode.h"
-#include "kvm_mips_int.h"
+#include "opcode.h"
+#include "interrupt.h"
 
 static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
 {
-- 
1.8.5.3
