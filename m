Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Dec 2015 00:50:13 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:14343 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013984AbbLPXuJgB0H0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Dec 2015 00:50:09 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 9896F2F8AA3B9;
        Wed, 16 Dec 2015 23:49:59 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Wed, 16 Dec 2015 23:50:03 +0000
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Wed, 16 Dec 2015 23:50:02 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>
CC:     Gleb Natapov <gleb@kernel.org>, <linux-mips@linux-mips.org>,
        <kvm@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 01/16] MIPS: KVM: Trivial whitespace and style fixes
Date:   Wed, 16 Dec 2015 23:49:26 +0000
Message-ID: <1450309781-28030-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
References: <1450309781-28030-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50648
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

A bunch of misc whitespace and style fixes within arch/mips/kvm/.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Gleb Natapov <gleb@kernel.org>
Cc: kvm@vger.kernel.org
Cc: linux-mips@linux-mips.org
---
 arch/mips/Kconfig                |  3 ++-
 arch/mips/include/asm/kvm_host.h |  2 +-
 arch/mips/kvm/emulate.c          |  8 +++-----
 arch/mips/kvm/locore.S           | 12 ++++++------
 arch/mips/kvm/tlb.c              |  4 ++--
 5 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 71683a853372..3aa967ff2c11 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -2018,7 +2018,8 @@ config KVM_GUEST
 	bool "KVM Guest Kernel"
 	depends on BROKEN_ON_SMP
 	help
-	  Select this option if building a guest kernel for KVM (Trap & Emulate) mode
+	  Select this option if building a guest kernel for KVM (Trap & Emulate)
+	  mode.
 
 config KVM_GUEST_TIMER_FREQ
 	int "Count/Compare Timer Frequency (MHz)"
diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 6ded8d347af9..6a313157db83 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -58,7 +58,7 @@
 #define KVM_MAX_VCPUS		1
 #define KVM_USER_MEM_SLOTS	8
 /* memory slots that does not exposed to userspace */
-#define KVM_PRIVATE_MEM_SLOTS 	0
+#define KVM_PRIVATE_MEM_SLOTS	0
 
 #define KVM_COALESCED_MMIO_PAGE_OFFSET 1
 #define KVM_HALT_POLL_NS_DEFAULT 500000
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 41b1b090f56f..95b83a6582ef 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1243,10 +1243,9 @@ enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
 #ifdef KVM_MIPS_DEBUG_COP0_COUNTERS
 			cop0->stat[MIPS_CP0_STATUS][0]++;
 #endif
-			if (rt != 0) {
+			if (rt != 0)
 				vcpu->arch.gprs[rt] =
 				    kvm_read_c0_guest_status(cop0);
-			}
 			/* EI */
 			if (inst & 0x20) {
 				kvm_debug("[%#lx] mfmcz_op: EI\n",
@@ -2583,9 +2582,8 @@ enum emulation_result kvm_mips_handle_tlbmiss(unsigned long cause,
 	 * an entry into the guest TLB.
 	 */
 	index = kvm_mips_guest_tlb_lookup(vcpu,
-					  (va & VPN2_MASK) |
-					  (kvm_read_c0_guest_entryhi
-					   (vcpu->arch.cop0) & ASID_MASK));
+		      (va & VPN2_MASK) |
+		      (kvm_read_c0_guest_entryhi(vcpu->arch.cop0) & ASID_MASK));
 	if (index < 0) {
 		if (exccode == T_TLB_LD_MISS) {
 			er = kvm_mips_emulate_tlbmiss_ld(cause, opc, run, vcpu);
diff --git a/arch/mips/kvm/locore.S b/arch/mips/kvm/locore.S
index 7e2210846b8b..81687ab1b523 100644
--- a/arch/mips/kvm/locore.S
+++ b/arch/mips/kvm/locore.S
@@ -335,7 +335,7 @@ NESTED (MIPSX(GuestException), CALLFRAME_SIZ, ra)
 
 	/* Now restore the host state just enough to run the handlers */
 
-	/* Swtich EBASE to the one used by Linux */
+	/* Switch EBASE to the one used by Linux */
 	/* load up the host EBASE */
 	mfc0	v0, CP0_STATUS
 
@@ -490,11 +490,11 @@ __kvm_mips_return_to_guest:
 	REG_ADDU t3, t1, t2
 	LONG_L	k0, (t3)
 	andi	k0, k0, 0xff
-	mtc0	k0,CP0_ENTRYHI
+	mtc0	k0, CP0_ENTRYHI
 	ehb
 
 	/* Disable RDHWR access */
-	mtc0    zero,  CP0_HWRENA
+	mtc0	zero, CP0_HWRENA
 
 	/* load the guest context from VCPU and return */
 	LONG_L	$0, VCPU_R0(k1)
@@ -606,11 +606,11 @@ __kvm_mips_return_to_host:
 
 	/* Restore RDHWR access */
 	PTR_LI	k0, 0x2000000F
-	mtc0	k0,  CP0_HWRENA
+	mtc0	k0, CP0_HWRENA
 
 	/* Restore RA, which is the address we will return to */
-	LONG_L  ra, PT_R31(k1)
-	j       ra
+	LONG_L	ra, PT_R31(k1)
+	j	ra
 	 nop
 
 VECTOR_END(MIPSX(GuestExceptionEnd))
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index aed0ac2a4972..3d3f22301a35 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -673,8 +673,8 @@ void kvm_arch_vcpu_load(struct kvm_vcpu *vcpu, int cpu)
 
 	local_irq_save(flags);
 
-	if (((vcpu->arch.
-	      guest_kernel_asid[cpu] ^ asid_cache(cpu)) & ASID_VERSION_MASK)) {
+	if ((vcpu->arch.guest_kernel_asid[cpu] ^ asid_cache(cpu)) &
+							ASID_VERSION_MASK) {
 		kvm_get_new_mmu_context(&vcpu->arch.guest_kernel_mm, cpu, vcpu);
 		vcpu->arch.guest_kernel_asid[cpu] =
 		    vcpu->arch.guest_kernel_mm.context.asid[cpu];
-- 
2.4.10
