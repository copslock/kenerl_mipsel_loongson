Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:24:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:40490 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041104AbcFINTqYOgCi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:46 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C101DD7A8B68C;
        Thu,  9 Jun 2016 14:19:41 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:44 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 17/18] MIPS: KVM: Combine handle_tlb_ld/st_miss
Date:   Thu, 9 Jun 2016 14:19:20 +0100
Message-ID: <1465478361-7431-18-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
References: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53927
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

The handle_tlb_ld/st_miss handlers are logically equivalent and
textually almost identical, so combine their implementations into a
single kvm_trap_emul_handle_tlb_miss().

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/trap_emul.c | 71 +++++++++++++----------------------------------
 1 file changed, 19 insertions(+), 52 deletions(-)

diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index ecf0068bc95e..09b97fa9dabb 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -128,7 +128,7 @@ static int kvm_trap_emul_handle_tlb_mod(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
-static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
+static int kvm_trap_emul_handle_tlb_miss(struct kvm_vcpu *vcpu, bool store)
 {
 	struct kvm_run *run = vcpu->run;
 	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
@@ -145,55 +145,8 @@ static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
 		}
 	} else if (KVM_GUEST_KSEGX(badvaddr) < KVM_GUEST_KSEG0
 		   || KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG23) {
-		kvm_debug("USER ADDR TLB LD fault: cause %#x, PC: %p, BadVaddr: %#lx\n",
-			  cause, opc, badvaddr);
-		er = kvm_mips_handle_tlbmiss(cause, opc, run, vcpu);
-		if (er == EMULATE_DONE)
-			ret = RESUME_GUEST;
-		else {
-			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-			ret = RESUME_HOST;
-		}
-	} else if (KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG0) {
-		/*
-		 * All KSEG0 faults are handled by KVM, as the guest kernel does
-		 * not expect to ever get them
-		 */
-		if (kvm_mips_handle_kseg0_tlb_fault
-		    (vcpu->arch.host_cp0_badvaddr, vcpu) < 0) {
-			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-			ret = RESUME_HOST;
-		}
-	} else {
-		kvm_err("Illegal TLB LD fault address , cause %#x, PC: %p, BadVaddr: %#lx\n",
-			cause, opc, badvaddr);
-		kvm_mips_dump_host_tlbs();
-		kvm_arch_vcpu_dump_regs(vcpu);
-		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-		ret = RESUME_HOST;
-	}
-	return ret;
-}
-
-static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
-{
-	struct kvm_run *run = vcpu->run;
-	u32 __user *opc = (u32 __user *) vcpu->arch.pc;
-	unsigned long badvaddr = vcpu->arch.host_cp0_badvaddr;
-	u32 cause = vcpu->arch.host_cp0_cause;
-	enum emulation_result er = EMULATE_DONE;
-	int ret = RESUME_GUEST;
-
-	if (((badvaddr & PAGE_MASK) == KVM_GUEST_COMMPAGE_ADDR)
-	    && KVM_GUEST_KERNEL_MODE(vcpu)) {
-		if (kvm_mips_handle_commpage_tlb_fault(badvaddr, vcpu) < 0) {
-			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-			ret = RESUME_HOST;
-		}
-	} else if (KVM_GUEST_KSEGX(badvaddr) < KVM_GUEST_KSEG0
-		   || KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG23) {
-		kvm_debug("USER ADDR TLB ST fault: PC: %#lx, BadVaddr: %#lx\n",
-			  vcpu->arch.pc, badvaddr);
+		kvm_debug("USER ADDR TLB %s fault: cause %#x, PC: %p, BadVaddr: %#lx\n",
+			  store ? "ST" : "LD", cause, opc, badvaddr);
 
 		/*
 		 * User Address (UA) fault, this could happen if
@@ -213,14 +166,18 @@ static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 			ret = RESUME_HOST;
 		}
 	} else if (KVM_GUEST_KSEGX(badvaddr) == KVM_GUEST_KSEG0) {
+		/*
+		 * All KSEG0 faults are handled by KVM, as the guest kernel does
+		 * not expect to ever get them
+		 */
 		if (kvm_mips_handle_kseg0_tlb_fault
 		    (vcpu->arch.host_cp0_badvaddr, vcpu) < 0) {
 			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
 			ret = RESUME_HOST;
 		}
 	} else {
-		kvm_err("Illegal TLB ST fault address , cause %#x, PC: %p, BadVaddr: %#lx\n",
-			cause, opc, badvaddr);
+		kvm_err("Illegal TLB %s fault address , cause %#x, PC: %p, BadVaddr: %#lx\n",
+			store ? "ST" : "LD", cause, opc, badvaddr);
 		kvm_mips_dump_host_tlbs();
 		kvm_arch_vcpu_dump_regs(vcpu);
 		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
@@ -229,6 +186,16 @@ static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
 	return ret;
 }
 
+static int kvm_trap_emul_handle_tlb_st_miss(struct kvm_vcpu *vcpu)
+{
+	return kvm_trap_emul_handle_tlb_miss(vcpu, true);
+}
+
+static int kvm_trap_emul_handle_tlb_ld_miss(struct kvm_vcpu *vcpu)
+{
+	return kvm_trap_emul_handle_tlb_miss(vcpu, false);
+}
+
 static int kvm_trap_emul_handle_addr_err_st(struct kvm_vcpu *vcpu)
 {
 	struct kvm_run *run = vcpu->run;
-- 
2.4.10
