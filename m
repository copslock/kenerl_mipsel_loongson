Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Jun 2016 18:37:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18317 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27043852AbcFWQfDKxhwz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Jun 2016 18:35:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 1AD622B6CD948;
        Thu, 23 Jun 2016 17:34:53 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 23 Jun 2016 17:34:56 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>
Subject: [PATCH 08/14] MIPS: KVM: Drop now unused asm offsets
Date:   Thu, 23 Jun 2016 17:34:41 +0100
Message-ID: <1466699687-24791-9-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
References: <1466699687-24791-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54145
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

Now that locore.S is converted to uasm, remove a bunch of the assembly
offset definitions created by asm-offsets.c, including the CPUINFO_ ones
for reading the variable asid mask, and the non FPU/MSA related VCPU_
definitions. KVM's fpu.S and msa.S still use the remaining definitions.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kernel/asm-offsets.c | 66 ------------------------------------------
 1 file changed, 66 deletions(-)

diff --git a/arch/mips/kernel/asm-offsets.c b/arch/mips/kernel/asm-offsets.c
index a1263d188a5a..fae2f9447792 100644
--- a/arch/mips/kernel/asm-offsets.c
+++ b/arch/mips/kernel/asm-offsets.c
@@ -339,67 +339,9 @@ void output_pm_defines(void)
 }
 #endif
 
-void output_cpuinfo_defines(void)
-{
-	COMMENT(" MIPS cpuinfo offsets. ");
-	DEFINE(CPUINFO_SIZE, sizeof(struct cpuinfo_mips));
-#ifdef CONFIG_MIPS_ASID_BITS_VARIABLE
-	OFFSET(CPUINFO_ASID_MASK, cpuinfo_mips, asid_mask);
-#endif
-}
-
 void output_kvm_defines(void)
 {
 	COMMENT(" KVM/MIPS Specfic offsets. ");
-	DEFINE(VCPU_ARCH_SIZE, sizeof(struct kvm_vcpu_arch));
-	OFFSET(VCPU_RUN, kvm_vcpu, run);
-	OFFSET(VCPU_HOST_ARCH, kvm_vcpu, arch);
-
-	OFFSET(VCPU_GUEST_EBASE, kvm_vcpu_arch, guest_ebase);
-
-	OFFSET(VCPU_HOST_STACK, kvm_vcpu_arch, host_stack);
-	OFFSET(VCPU_HOST_GP, kvm_vcpu_arch, host_gp);
-
-	OFFSET(VCPU_HOST_CP0_BADVADDR, kvm_vcpu_arch, host_cp0_badvaddr);
-	OFFSET(VCPU_HOST_CP0_CAUSE, kvm_vcpu_arch, host_cp0_cause);
-	OFFSET(VCPU_HOST_EPC, kvm_vcpu_arch, host_cp0_epc);
-
-	OFFSET(VCPU_R0, kvm_vcpu_arch, gprs[0]);
-	OFFSET(VCPU_R1, kvm_vcpu_arch, gprs[1]);
-	OFFSET(VCPU_R2, kvm_vcpu_arch, gprs[2]);
-	OFFSET(VCPU_R3, kvm_vcpu_arch, gprs[3]);
-	OFFSET(VCPU_R4, kvm_vcpu_arch, gprs[4]);
-	OFFSET(VCPU_R5, kvm_vcpu_arch, gprs[5]);
-	OFFSET(VCPU_R6, kvm_vcpu_arch, gprs[6]);
-	OFFSET(VCPU_R7, kvm_vcpu_arch, gprs[7]);
-	OFFSET(VCPU_R8, kvm_vcpu_arch, gprs[8]);
-	OFFSET(VCPU_R9, kvm_vcpu_arch, gprs[9]);
-	OFFSET(VCPU_R10, kvm_vcpu_arch, gprs[10]);
-	OFFSET(VCPU_R11, kvm_vcpu_arch, gprs[11]);
-	OFFSET(VCPU_R12, kvm_vcpu_arch, gprs[12]);
-	OFFSET(VCPU_R13, kvm_vcpu_arch, gprs[13]);
-	OFFSET(VCPU_R14, kvm_vcpu_arch, gprs[14]);
-	OFFSET(VCPU_R15, kvm_vcpu_arch, gprs[15]);
-	OFFSET(VCPU_R16, kvm_vcpu_arch, gprs[16]);
-	OFFSET(VCPU_R17, kvm_vcpu_arch, gprs[17]);
-	OFFSET(VCPU_R18, kvm_vcpu_arch, gprs[18]);
-	OFFSET(VCPU_R19, kvm_vcpu_arch, gprs[19]);
-	OFFSET(VCPU_R20, kvm_vcpu_arch, gprs[20]);
-	OFFSET(VCPU_R21, kvm_vcpu_arch, gprs[21]);
-	OFFSET(VCPU_R22, kvm_vcpu_arch, gprs[22]);
-	OFFSET(VCPU_R23, kvm_vcpu_arch, gprs[23]);
-	OFFSET(VCPU_R24, kvm_vcpu_arch, gprs[24]);
-	OFFSET(VCPU_R25, kvm_vcpu_arch, gprs[25]);
-	OFFSET(VCPU_R26, kvm_vcpu_arch, gprs[26]);
-	OFFSET(VCPU_R27, kvm_vcpu_arch, gprs[27]);
-	OFFSET(VCPU_R28, kvm_vcpu_arch, gprs[28]);
-	OFFSET(VCPU_R29, kvm_vcpu_arch, gprs[29]);
-	OFFSET(VCPU_R30, kvm_vcpu_arch, gprs[30]);
-	OFFSET(VCPU_R31, kvm_vcpu_arch, gprs[31]);
-	OFFSET(VCPU_LO, kvm_vcpu_arch, lo);
-	OFFSET(VCPU_HI, kvm_vcpu_arch, hi);
-	OFFSET(VCPU_PC, kvm_vcpu_arch, pc);
-	BLANK();
 
 	OFFSET(VCPU_FPR0, kvm_vcpu_arch, fpu.fpr[0]);
 	OFFSET(VCPU_FPR1, kvm_vcpu_arch, fpu.fpr[1]);
@@ -437,14 +379,6 @@ void output_kvm_defines(void)
 	OFFSET(VCPU_FCR31, kvm_vcpu_arch, fpu.fcr31);
 	OFFSET(VCPU_MSA_CSR, kvm_vcpu_arch, fpu.msacsr);
 	BLANK();
-
-	OFFSET(VCPU_COP0, kvm_vcpu_arch, cop0);
-	OFFSET(VCPU_GUEST_KERNEL_ASID, kvm_vcpu_arch, guest_kernel_asid);
-	OFFSET(VCPU_GUEST_USER_ASID, kvm_vcpu_arch, guest_user_asid);
-
-	OFFSET(COP0_TLB_HI, mips_coproc, reg[MIPS_CP0_TLB_HI][0]);
-	OFFSET(COP0_STATUS, mips_coproc, reg[MIPS_CP0_STATUS][0]);
-	BLANK();
 }
 
 #ifdef CONFIG_MIPS_CPS
-- 
2.4.10
