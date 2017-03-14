Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:23:07 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56839 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994804AbdCNKSOyQ1GU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:18:14 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 6BE817599AD80;
        Tue, 14 Mar 2017 10:18:05 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:18:08 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <david.daney@cavium.com>,
        Jonathan Corbet <corbet@lwn.net>, <linux-doc@vger.kernel.org>
Subject: [PATCH v2 7/33] KVM: MIPS: Implement HYPCALL emulation
Date:   Tue, 14 Mar 2017 10:15:14 +0000
Message-ID: <2306dc3161f82c86ee00eb0e421f3c956e2b1140.1489485940.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
References: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57212
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Emulate the HYPCALL instruction added in the VZ ASE and used by the MIPS
paravirtualised guest support that is already merged. The new hypcall.c
handles arguments and the return value. No actual hypercalls are yet
supported, but this still allows us to safely step over hypercalls and
set an error code in the return value for forward compatibility.

Non-zero HYPCALL codes are not handled.

We also document the hypercall ABI which asm/kvm_para.h uses.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>
Cc: David Daney <david.daney@cavium.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: linux-doc@vger.kernel.org
---
Changes in v2:
- Patch 1 of hypercall series incorporated into VZ series
---
 Documentation/virtual/kvm/hypercalls.txt |  5 ++-
 arch/mips/include/asm/kvm_host.h         |  7 +++-
 arch/mips/include/uapi/asm/inst.h        |  2 +-
 arch/mips/kvm/Makefile                   |  1 +-
 arch/mips/kvm/emulate.c                  |  3 +-
 arch/mips/kvm/hypcall.c                  | 53 +++++++++++++++++++++++++-
 arch/mips/kvm/trap_emul.c                |  4 ++-
 7 files changed, 74 insertions(+), 1 deletion(-)
 create mode 100644 arch/mips/kvm/hypcall.c

diff --git a/Documentation/virtual/kvm/hypercalls.txt b/Documentation/virtual/kvm/hypercalls.txt
index feaaa634f154..a890529c63ed 100644
--- a/Documentation/virtual/kvm/hypercalls.txt
+++ b/Documentation/virtual/kvm/hypercalls.txt
@@ -28,6 +28,11 @@ S390:
   property inside the device tree's /hypervisor node.
   For more information refer to Documentation/virtual/kvm/ppc-pv.txt
 
+MIPS:
+  KVM hypercalls use the HYPCALL instruction with code 0 and the hypercall
+  number in $2 (v0). Up to four arguments may be placed in $4-$7 (a0-a3) and
+  the return value is placed in $2 (v0).
+
 KVM Hypercalls Documentation
 ===========================
 The template for each hypercall is:
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 05e785fc061d..0d308d4f2429 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -229,6 +229,7 @@ enum emulation_result {
 	EMULATE_WAIT,		/* WAIT instruction */
 	EMULATE_PRIV_FAIL,
 	EMULATE_EXCEPT,		/* A guest exception has been generated */
+	EMULATE_HYPERCALL,	/* HYPCALL instruction */
 };
 
 #define mips3_paddr_to_tlbpfn(x) \
@@ -832,6 +833,12 @@ unsigned int kvm_mips_config3_wrmask(struct kvm_vcpu *vcpu);
 unsigned int kvm_mips_config4_wrmask(struct kvm_vcpu *vcpu);
 unsigned int kvm_mips_config5_wrmask(struct kvm_vcpu *vcpu);
 
+/* Hypercalls (hypcall.c) */
+
+enum emulation_result kvm_mips_emul_hypcall(struct kvm_vcpu *vcpu,
+					    union mips_instruction inst);
+int kvm_mips_handle_hypcall(struct kvm_vcpu *vcpu);
+
 /* Dynamic binary translation */
 extern int kvm_mips_trans_cache_index(union mips_instruction inst,
 				      u32 *opc, struct kvm_vcpu *vcpu);
diff --git a/arch/mips/include/uapi/asm/inst.h b/arch/mips/include/uapi/asm/inst.h
index 77429d1622b3..b5e46ae872d3 100644
--- a/arch/mips/include/uapi/asm/inst.h
+++ b/arch/mips/include/uapi/asm/inst.h
@@ -179,7 +179,7 @@ enum cop0_coi_func {
 	tlbr_op	      = 0x01, tlbwi_op	    = 0x02,
 	tlbwr_op      = 0x06, tlbp_op	    = 0x08,
 	rfe_op	      = 0x10, eret_op	    = 0x18,
-	wait_op       = 0x20,
+	wait_op       = 0x20, hypcall_op    = 0x28
 };
 
 /*
diff --git a/arch/mips/kvm/Makefile b/arch/mips/kvm/Makefile
index 847429de780d..e56403c8a3f5 100644
--- a/arch/mips/kvm/Makefile
+++ b/arch/mips/kvm/Makefile
@@ -10,6 +10,7 @@ common-objs-$(CONFIG_CPU_HAS_MSA) += msa.o
 kvm-objs := $(common-objs-y) mips.o emulate.o entry.o \
 	    interrupt.o stats.o commpage.o \
 	    dyntrans.o trap_emul.o fpu.o
+kvm-objs += hypcall.o
 kvm-objs += mmu.o
 
 obj-$(CONFIG_KVM)	+= kvm.o
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index d40cfaad4529..637753ea0a00 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1143,6 +1143,9 @@ enum emulation_result kvm_mips_emulate_CP0(union mips_instruction inst,
 		case wait_op:
 			er = kvm_mips_emul_wait(vcpu);
 			break;
+		case hypcall_op:
+			er = kvm_mips_emul_hypcall(vcpu, inst);
+			break;
 		}
 	} else {
 		rt = inst.c0r_format.rt;
diff --git a/arch/mips/kvm/hypcall.c b/arch/mips/kvm/hypcall.c
new file mode 100644
index 000000000000..83063435195f
--- /dev/null
+++ b/arch/mips/kvm/hypcall.c
@@ -0,0 +1,53 @@
+/*
+ * This file is subject to the terms and conditions of the GNU General Public
+ * License.  See the file "COPYING" in the main directory of this archive
+ * for more details.
+ *
+ * KVM/MIPS: Hypercall handling.
+ *
+ * Copyright (C) 2015  Imagination Technologies Ltd.
+ */
+
+#include <linux/kernel.h>
+#include <linux/kvm_host.h>
+#include <linux/kvm_para.h>
+
+#define MAX_HYPCALL_ARGS	4
+
+enum emulation_result kvm_mips_emul_hypcall(struct kvm_vcpu *vcpu,
+					    union mips_instruction inst)
+{
+	unsigned int code = (inst.co_format.code >> 5) & 0x3ff;
+
+	kvm_debug("[%#lx] HYPCALL %#03x\n", vcpu->arch.pc, code);
+
+	switch (code) {
+	case 0:
+		return EMULATE_HYPERCALL;
+	default:
+		return EMULATE_FAIL;
+	};
+}
+
+static int kvm_mips_hypercall(struct kvm_vcpu *vcpu, unsigned long num,
+			      const unsigned long *args, unsigned long *hret)
+{
+	/* Report unimplemented hypercall to guest */
+	*hret = -KVM_ENOSYS;
+	return RESUME_GUEST;
+}
+
+int kvm_mips_handle_hypcall(struct kvm_vcpu *vcpu)
+{
+	unsigned long num, args[MAX_HYPCALL_ARGS];
+
+	/* read hypcall number and arguments */
+	num = vcpu->arch.gprs[2];	/* v0 */
+	args[0] = vcpu->arch.gprs[4];	/* a0 */
+	args[1] = vcpu->arch.gprs[5];	/* a1 */
+	args[2] = vcpu->arch.gprs[6];	/* a2 */
+	args[3] = vcpu->arch.gprs[7];	/* a3 */
+
+	return kvm_mips_hypercall(vcpu, num,
+				  args, &vcpu->arch.gprs[2] /* v0 */);
+}
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index b1fa53b252ea..3a854bb9e606 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -82,6 +82,10 @@ static int kvm_trap_emul_handle_cop_unusable(struct kvm_vcpu *vcpu)
 		ret = RESUME_HOST;
 		break;
 
+	case EMULATE_HYPERCALL:
+		ret = kvm_mips_handle_hypcall(vcpu);
+		break;
+
 	default:
 		BUG();
 	}
-- 
git-series 0.8.10
