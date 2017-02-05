Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Feb 2017 20:14:45 +0100 (CET)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:27187 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990522AbdBETOit1isJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 5 Feb 2017 20:14:38 +0100
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id v15JEYAt007944;
        Sun, 5 Feb 2017 20:14:34 +0100
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        linux@roeck-us.net
Cc:     James Hogan <james.hogan@imgtec.com>, Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?=20Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org,
        "stable@vger.kernel.org#3.10.x-3.16.x":5f508c43a764:MIPS:KVM:Fixunusedvariablebuildwarning@pcw.home.local,
        stable@vger.kernel.org#3.10.x-3.16.x, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 023/319] KVM: MIPS: Precalculate MMIO load resume PC
Date:   Sun,  5 Feb 2017 20:09:27 +0100
Message-Id: <1486322063-7558-24-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1486322063-7558-1-git-send-email-w@1wt.eu>
References: <1486322063-7558-1-git-send-email-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=latin1
Content-Transfer-Encoding: 8bit
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56637
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: w@1wt.eu
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
Cc: <stable@vger.kernel.org> # 3.10.x-3.16.x: 5f508c43a764: MIPS: KVM: Fix unused variable build warning
Cc: <stable@vger.kernel.org> # 3.10.x-3.16.x
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[james.hogan@imgtec.com: Backport to 3.10..3.16]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/include/asm/kvm_host.h |  7 ++++---
 arch/mips/kvm/kvm_mips_emul.c    | 25 +++++++++++++++----------
 2 files changed, 19 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 883a162..05863e3 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -375,7 +375,10 @@ struct kvm_vcpu_arch {
 	/* Host KSEG0 address of the EI/DI offset */
 	void *kseg0_commpage;
 
-	u32 io_gpr;		/* GPR used as IO source/target */
+	/* Resume PC after MMIO completion */
+	unsigned long io_pc;
+	/* GPR used as IO source/target */
+	u32 io_gpr;
 
 	/* Used to calibrate the virutal count register for the guest */
 	int32_t host_cp0_count;
@@ -386,8 +389,6 @@ struct kvm_vcpu_arch {
 	/* Bitmask of pending exceptions to be cleared */
 	unsigned long pending_exceptions_clr;
 
-	unsigned long pending_load_cause;
-
 	/* Save/Restore the entryhi register when are are preempted/scheduled back in */
 	unsigned long preempt_entryhi;
 
diff --git a/arch/mips/kvm/kvm_mips_emul.c b/arch/mips/kvm/kvm_mips_emul.c
index 5c2d70b..e5977f2 100644
--- a/arch/mips/kvm/kvm_mips_emul.c
+++ b/arch/mips/kvm/kvm_mips_emul.c
@@ -773,6 +773,7 @@ kvm_mips_emulate_load(uint32_t inst, uint32_t cause,
 		      struct kvm_run *run, struct kvm_vcpu *vcpu)
 {
 	enum emulation_result er = EMULATE_DO_MMIO;
+	unsigned long curr_pc;
 	int32_t op, base, rt, offset;
 	uint32_t bytes;
 
@@ -781,7 +782,18 @@ kvm_mips_emulate_load(uint32_t inst, uint32_t cause,
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
@@ -1617,9 +1629,8 @@ kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
 		goto done;
 	}
 
-	er = update_pc(vcpu, vcpu->arch.pending_load_cause);
-	if (er == EMULATE_FAIL)
-		return er;
+	/* Restore saved resume PC */
+	vcpu->arch.pc = vcpu->arch.io_pc;
 
 	switch (run->mmio.len) {
 	case 4:
@@ -1641,12 +1652,6 @@ kvm_mips_complete_mmio_load(struct kvm_vcpu *vcpu, struct kvm_run *run)
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
2.8.0.rc2.1.gbe9624a
