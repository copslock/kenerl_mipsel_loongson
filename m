Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 17:14:31 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:13013 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992836AbcKIQODYlmcS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2016 17:14:03 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTP id E15B2922D015C;
        Wed,  9 Nov 2016 16:13:53 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Wed, 9 Nov 2016 16:13:56 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <stable@vger.kernel.org>
CC:     Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>
Subject: [BACKPORT PATCH 3.10..3.16 2/2] KVM: MIPS: Precalculate MMIO load resume PC
Date:   Wed, 9 Nov 2016 16:13:50 +0000
Message-ID: <8dcc7b802dcf5d540c3c4d38ef0a8a52b1029fb0.1478707766.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.10.1
MIME-Version: 1.0
In-Reply-To: <2e791b20c24570339d15118a55e174f5b2d63ac1.1478707766.git-series.james.hogan@imgtec.com>
References: <2e791b20c24570339d15118a55e174f5b2d63ac1.1478707766.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55750
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

commit e1e575f6b026734be3b1f075e780e91ab08ca541 upstream.

The advancing of the PC when completing an MMIO load is done before
re-entering the guest, i.e. before restoring the guest ASID. However if
the load is in a branch delay slot it may need to access guest code to
read the prior branch instruction. This isn't safe in TLB mapped code at
the moment, nor in the future when we'll access unmapped guest segments
using direct user accessors too, as it could read the branch from host
user memory instead.

Therefore calculate the resume PC in advance while we're still in the
right context and save it in the new vcpu->arch.io_pc (replacing the no
longer needed vcpu->arch.pending_load_cause), and restore it on MMIO
completion.

Fixes: e685c689f3a8 ("KVM/MIPS32: Privileged instruction/target branch emulation.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: <stable@vger.kernel.org> # 3.10.x-3.16.x: 5f508c43a764: MIPS: KVM: Fix unused variable build warning
Cc: <stable@vger.kernel.org> # 3.10.x-3.16.x
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[james.hogan@imgtec.com: Backport to 3.10..3.16]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
---
 arch/mips/include/asm/kvm_host.h |  7 ++++---
 arch/mips/kvm/kvm_mips_emul.c    | 25 +++++++++++++++----------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 5bddbc63fc3b..f8cdc274173a 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -403,7 +403,10 @@ struct kvm_vcpu_arch {
 	/* Host KSEG0 address of the EI/DI offset */
 	void *kseg0_commpage;
 
-	u32 io_gpr;		/* GPR used as IO source/target */
+	/* Resume PC after MMIO completion */
+	unsigned long io_pc;
+	/* GPR used as IO source/target */
+	u32 io_gpr;
 
 	struct hrtimer comparecount_timer;
 	/* Count timer control KVM register */
@@ -425,8 +428,6 @@ struct kvm_vcpu_arch {
 	/* Bitmask of pending exceptions to be cleared */
 	unsigned long pending_exceptions_clr;
 
-	unsigned long pending_load_cause;
-
 	/* Save/Restore the entryhi register when are are preempted/scheduled back in */
 	unsigned long preempt_entryhi;
 
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index a32e838d9aeb..4feffc82f39a 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -1283,6 +1283,7 @@ kvm_mips_emulate_load(uint32_t inst, uint32_t cause,
 		      struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DO_MMIO;
+	unsigned long curr_pc;
 	int32_t op, base, rt, offset;
 	uint32_t bytes;
 
@@ -1291,7 +1292,18 @@ kvm_mips_emulate_load(uint32_t inst, uint32_t cause,
 	offset = inst & 0xffff;
 	op = (inst >> 26) & 0x3f;
 
-	vcpu->arch.pending_load_cause = cause;
+	/*
+	 * Find the resume PC now while we have safe and easy access to the
+	 * prior branch instruction, and save it for
+	 * kvm_mips_complete_mmio_load() to restore later.
+	 */
+	curr_pc = vcpu->arch.pc;
+	er = update_pc(vcpu, cause);
+	if (er == EMULATE_FAIL)
+		return er;
+	vcpu->arch.io_pc = vcpu->arch.pc;
+	vcpu->arch.pc = curr_pc;
+
 	vcpu->arch.io_gpr = rt;
 
 	switch (op) {
@@ -2122,9 +2134,8 @@ kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		goto done;
 	}
 
-	er = update_pc(vcpu, vcpu->arch.pending_load_cause);
-	if (er == EMULATE_FAIL)
-		return er;
+	/* Restore saved resume PC */
+	vcpu->arch.pc = vcpu->arch.io_pc;
 
 	switch (run->mmio.len) {
 	case 4:
@@ -2146,12 +2157,6 @@ kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		break;
 	}
 
-	if (vcpu->arch.pending_load_cause & CAUSEF_BD)
-		kvm_debug
-		    ("[%#lx] Completing %d byte BD Load to gpr %d (0x%08lx) type %d\n",
-		     vcpu->arch.pc, run->mmio.len, vcpu->arch.io_gpr, *gpr,
-		     vcpu->mmio_needed);
-
 done:
 	return er;
 }
-- 
git-series 0.8.10
