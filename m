Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 09 Nov 2016 12:08:43 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:56492 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993030AbcKILIHw1-0A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 9 Nov 2016 12:08:07 +0100
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 4FBB7B47;
        Wed,  9 Nov 2016 11:08:01 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: [PATCH 4.8 071/138] KVM: MIPS: Precalculate MMIO load resume PC
Date:   Wed,  9 Nov 2016 11:45:54 +0100
Message-Id: <20161109102848.091903774@linuxfoundation.org>
X-Mailer: git-send-email 2.10.2
In-Reply-To: <20161109102844.808685475@linuxfoundation.org>
References: <20161109102844.808685475@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55736
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.8-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <james.hogan@imgtec.com>

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
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/kvm_host.h |    7 ++++---
 arch/mips/kvm/emulate.c          |   24 +++++++++++++++---------
 2 files changed, 19 insertions(+), 12 deletions(-)

--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -279,7 +279,10 @@ struct kvm_vcpu_arch {
 	/* Host KSEG0 address of the EI/DI offset */
 	void *kseg0_commpage;
 
-	u32 io_gpr;		/* GPR used as IO source/target */
+	/* Resume PC after MMIO completion */
+	unsigned long io_pc;
+	/* GPR used as IO source/target */
+	u32 io_gpr;
 
 	struct hrtimer comparecount_timer;
 	/* Count timer control KVM register */
@@ -301,8 +304,6 @@ struct kvm_vcpu_arch {
 	/* Bitmask of pending exceptions to be cleared */
 	unsigned long pending_exceptions_clr;
 
-	u32 pending_load_cause;
-
 	/* Save/Restore the entryhi register when are are preempted/scheduled back in */
 	unsigned long preempt_entryhi;
 
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1522,13 +1522,25 @@ enum emulation_result kvm_mips_emulate_l
 					    struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DO_MMIO;
+	unsigned long curr_pc;
 	u32 op, rt;
 	u32 bytes;
 
 	rt = inst.i_format.rt;
 	op = inst.i_format.opcode;
 
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
@@ -2488,9 +2500,8 @@ enum emulation_result kvm_mips_complete_
 		goto done;
 	}
 
-	er = update_pc(vcpu, vcpu->arch.pending_load_cause);
-	if (er == EMULATE_FAIL)
-		return er;
+	/* Restore saved resume PC */
+	vcpu->arch.pc = vcpu->arch.io_pc;
 
 	switch (run->mmio.len) {
 	case 4:
@@ -2512,11 +2523,6 @@ enum emulation_result kvm_mips_complete_
 		break;
 	}
 
-	if (vcpu->arch.pending_load_cause & CAUSEF_BD)
-		kvm_debug("[%#lx] Completing %d byte BD Load to gpr %d (0x%08lx) type %d\n",
-			  vcpu->arch.pc, run->mmio.len, vcpu->arch.io_gpr, *gpr,
-			  vcpu->mmio_needed);
-
 done:
 	return er;
 }
