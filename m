Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Nov 2012 03:39:53 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:53542 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6828081Ab2KVCfgaGmHF (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 22 Nov 2012 03:35:36 +0100
Received: from agni.kymasys.com ([75.40.23.192]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 21 Nov 2012 18:35:25 -0800
Received: by agni.kymasys.com (Postfix, from userid 500)
        id B06AB630283; Wed, 21 Nov 2012 18:34:18 -0800 (PST)
From:   Sanjay Lal <sanjayl@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Cc:     Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 14/18] MIPS: ASM offsets for VCPU arch specific fields.
Date:   Wed, 21 Nov 2012 18:34:12 -0800
Message-Id: <1353551656-23579-15-git-send-email-sanjayl@kymasys.com>
X-Mailer: git-send-email 1.7.11.3
In-Reply-To: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
References: <1353551656-23579-1-git-send-email-sanjayl@kymasys.com>
X-archive-position: 35091
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
 arch/mips/kernel/asm-offsets.c | 66 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 66 insertions(+)

diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index 0c4bce4..66895de 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -17,6 +17,8 @@
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 
+#include <linux/kvm_host.h>
+
 void output_ptreg_defines(void)
 {
 	COMMENT("MIPS pt_regs offsets.");
@@ -329,3 +331,67 @@ void output_pbe_defines(void)
 	BLANK();
 }
 #endif
+
+void output_kvm_defines(void)
+{
+	COMMENT(" KVM/MIPS Specfic offsets. ");
+	DEFINE(VCPU_ARCH_SIZE, sizeof(struct kvm_vcpu_arch));
+	OFFSET(VCPU_RUN, kvm_vcpu, run);
+	OFFSET(VCPU_HOST_ARCH, kvm_vcpu, arch);
+
+	OFFSET(VCPU_HOST_EBASE, kvm_vcpu_arch, host_ebase);
+	OFFSET(VCPU_GUEST_EBASE, kvm_vcpu_arch, guest_ebase);
+
+	OFFSET(VCPU_HOST_STACK, kvm_vcpu_arch, host_stack);
+	OFFSET(VCPU_HOST_GP, kvm_vcpu_arch, host_gp);
+
+	OFFSET(VCPU_HOST_CP0_BADVADDR, kvm_vcpu_arch, host_cp0_badvaddr);
+	OFFSET(VCPU_HOST_CP0_CAUSE, kvm_vcpu_arch, host_cp0_cause);
+	OFFSET(VCPU_HOST_EPC, kvm_vcpu_arch, host_cp0_epc);
+	OFFSET(VCPU_HOST_ENTRYHI, kvm_vcpu_arch, host_cp0_entryhi);
+
+	OFFSET(VCPU_GUEST_INST, kvm_vcpu_arch, guest_inst);
+
+	OFFSET(VCPU_R0, kvm_vcpu_arch, gprs[0]);
+	OFFSET(VCPU_R1, kvm_vcpu_arch, gprs[1]);
+	OFFSET(VCPU_R2, kvm_vcpu_arch, gprs[2]);
+	OFFSET(VCPU_R3, kvm_vcpu_arch, gprs[3]);
+	OFFSET(VCPU_R4, kvm_vcpu_arch, gprs[4]);
+	OFFSET(VCPU_R5, kvm_vcpu_arch, gprs[5]);
+	OFFSET(VCPU_R6, kvm_vcpu_arch, gprs[6]);
+	OFFSET(VCPU_R7, kvm_vcpu_arch, gprs[7]);
+	OFFSET(VCPU_R8, kvm_vcpu_arch, gprs[8]);
+	OFFSET(VCPU_R9, kvm_vcpu_arch, gprs[9]);
+	OFFSET(VCPU_R10, kvm_vcpu_arch, gprs[10]);
+	OFFSET(VCPU_R11, kvm_vcpu_arch, gprs[11]);
+	OFFSET(VCPU_R12, kvm_vcpu_arch, gprs[12]);
+	OFFSET(VCPU_R13, kvm_vcpu_arch, gprs[13]);
+	OFFSET(VCPU_R14, kvm_vcpu_arch, gprs[14]);
+	OFFSET(VCPU_R15, kvm_vcpu_arch, gprs[15]);
+	OFFSET(VCPU_R16, kvm_vcpu_arch, gprs[16]);
+	OFFSET(VCPU_R17, kvm_vcpu_arch, gprs[17]);
+	OFFSET(VCPU_R18, kvm_vcpu_arch, gprs[18]);
+	OFFSET(VCPU_R19, kvm_vcpu_arch, gprs[19]);
+	OFFSET(VCPU_R20, kvm_vcpu_arch, gprs[20]);
+	OFFSET(VCPU_R21, kvm_vcpu_arch, gprs[21]);
+	OFFSET(VCPU_R22, kvm_vcpu_arch, gprs[22]);
+	OFFSET(VCPU_R23, kvm_vcpu_arch, gprs[23]);
+	OFFSET(VCPU_R24, kvm_vcpu_arch, gprs[24]);
+	OFFSET(VCPU_R25, kvm_vcpu_arch, gprs[25]);
+	OFFSET(VCPU_R26, kvm_vcpu_arch, gprs[26]);
+	OFFSET(VCPU_R27, kvm_vcpu_arch, gprs[27]);
+	OFFSET(VCPU_R28, kvm_vcpu_arch, gprs[28]);
+	OFFSET(VCPU_R29, kvm_vcpu_arch, gprs[29]);
+	OFFSET(VCPU_R30, kvm_vcpu_arch, gprs[30]);
+	OFFSET(VCPU_R31, kvm_vcpu_arch, gprs[31]);
+	OFFSET(VCPU_LO, kvm_vcpu_arch, lo);
+	OFFSET(VCPU_HI, kvm_vcpu_arch, hi);
+	OFFSET(VCPU_PC, kvm_vcpu_arch, pc);
+	OFFSET(VCPU_COP0, kvm_vcpu_arch, cop0);
+	OFFSET(VCPU_GUEST_KERNEL_ASID, kvm_vcpu_arch, guest_kernel_asid);
+	OFFSET(VCPU_GUEST_USER_ASID, kvm_vcpu_arch, guest_user_asid);
+
+	OFFSET(COP0_TLB_HI, mips_coproc, reg[MIPS_CP0_TLB_HI][0]);
+	OFFSET(COP0_STATUS, mips_coproc, reg[MIPS_CP0_STATUS][0]);
+	BLANK();
+}
-- 
1.7.11.3
