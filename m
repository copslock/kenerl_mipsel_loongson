Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Feb 2017 00:23:04 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:35401 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993894AbdBOXWycYk2p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Feb 2017 00:22:54 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1ce8U1-0002J9-3L; Wed, 15 Feb 2017 22:55:33 +0000
Received: from ben by deadeye with local (Exim 4.89)
        (envelope-from <ben@decadent.org.uk>)
        id 1ce8Tl-000365-Fg; Wed, 15 Feb 2017 22:55:17 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org, linux-mips@linux-mips.org,
 "James Hogan" <james.hogan@imgtec.com>,
 kvm@vger.kernel.org,
 "Paolo Bonzini" <pbonzini@redhat.com>,
 ""Radim
 =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>, "Ralf
 Baechle" <ralf@linux-mips.org>
Date:   Wed, 15 Feb 2017 22:41:40 +0000
Message-ID: <lsq.1487198500.141194853@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 165/306] KVM: MIPS: Precalculate MMIO load resume PC
In-Reply-To: <lsq.1487198498.99718322@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56834
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.40-rc1 review patch.  If anyone has any objections, please let me know.

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
Cc: "Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[bwh: Backported to 3.16: adjust filename, context]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
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
 
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -1328,6 +1328,7 @@ kvm_mips_emulate_load(uint32_t inst, uin
 		      struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DO_MMIO;
+	unsigned long curr_pc;
 	int32_t op, base, rt, offset;
 	uint32_t bytes;
 
@@ -1336,7 +1337,18 @@ kvm_mips_emulate_load(uint32_t inst, uin
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
@@ -2179,9 +2191,8 @@ kvm_mips_complete_mmio_load(struct kvm_v
 		goto done;
 	}
 
-	er = update_pc(vcpu, vcpu->arch.pending_load_cause);
-	if (er == EMULATE_FAIL)
-		return er;
+	/* Restore saved resume PC */
+	vcpu->arch.pc = vcpu->arch.io_pc;
 
 	switch (run->mmio.len) {
 	case 4:
@@ -2203,12 +2214,6 @@ kvm_mips_complete_mmio_load(struct kvm_v
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
