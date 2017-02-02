Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 02 Feb 2017 13:12:29 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:9114 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993924AbdBBMFIrGt1v (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 2 Feb 2017 13:05:08 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 4F100856C9D1E;
        Thu,  2 Feb 2017 12:05:04 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 2 Feb 2017 12:05:07 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH v2 19/30] KVM: MIPS/TLB: Generalise host TLB invalidate to kernel ASID
Date:   Thu, 2 Feb 2017 12:04:32 +0000
Message-ID: <bad8a6ab592a797c91b9b7f4a0bcbc7250d499e2.1486036366.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
References: <cover.e37f86dece46fc3ed00a075d68119cab361cda8e.1486036366.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56605
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

Refactor kvm_mips_host_tlb_inv() to also be able to invalidate any
matching TLB entry in the kernel ASID rather than assuming only the TLB
entries in the user ASID can change. Two new bool user/kernel arguments
allow the caller to indicate whether the mapping should affect each of
the ASIDs for guest user/kernel mode.

- kvm_mips_invalidate_guest_tlb() (used by TLBWI/TLBWR emulation) can
  now invalidate any corresponding TLB entry in both the kernel ASID
  (guest kernel may have accessed any guest mapping), and the user ASID
  if the entry being replaced is in guest USeg (where guest user may
  also have accessed it).

- The tlbmod fault handler (and the KSeg0 / TLB mapped / commpage fault
  handlers in later patches) can now invalidate the corresponding TLB
  entry in whichever ASID is currently active, since only a single page
  table will have been updated anyway.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  3 +-
 arch/mips/kvm/emulate.c          |  6 +++--
 arch/mips/kvm/tlb.c              | 40 ++++++++++++++++++++++++---------
 3 files changed, 36 insertions(+), 13 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 80928ffa0150..fb2ea578c193 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -604,7 +604,8 @@ extern int kvm_mips_host_tlb_write(struct kvm_vcpu *vcpu, unsigned long entryhi,
 				   unsigned long entrylo1,
 				   int flush_dcache_mask);
 extern void kvm_mips_flush_host_tlb(int skip_kseg0);
-extern int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long entryhi);
+extern int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long entryhi,
+				 bool user, bool kernel);
 
 extern int kvm_mips_guest_tlb_lookup(struct kvm_vcpu *vcpu,
 				     unsigned long entryhi);
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index 060acc5b3378..611b8996ca0c 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -873,7 +873,7 @@ static void kvm_mips_invalidate_guest_tlb(struct kvm_vcpu *vcpu,
 	 * Probe the shadow host TLB for the entry being overwritten, if one
 	 * matches, invalidate it
 	 */
-	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi);
+	kvm_mips_host_tlb_inv(vcpu, tlb->tlb_hi, user, true);
 
 	/* Invalidate the whole ASID on other CPUs */
 	cpu = smp_processor_id();
@@ -2100,13 +2100,15 @@ enum emulation_result kvm_mips_handle_tlbmod(u32 cause, u32 *opc,
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
 			(kvm_read_c0_guest_entryhi(cop0) & KVM_ENTRYHI_ASID);
+	bool kernel = KVM_GUEST_KERNEL_MODE(vcpu);
 	int index;
 
 	/* If address not in the guest TLB, then we are in trouble */
 	index = kvm_mips_guest_tlb_lookup(vcpu, entryhi);
 	if (index < 0) {
 		/* XXXKYMA Invalidate and retry */
-		kvm_mips_host_tlb_inv(vcpu, vcpu->arch.host_cp0_badvaddr);
+		kvm_mips_host_tlb_inv(vcpu, vcpu->arch.host_cp0_badvaddr,
+				      !kernel, kernel);
 		kvm_err("%s: host got TLBMOD for %#lx but entry not present in Guest TLB\n",
 		     __func__, entryhi);
 		kvm_mips_dump_guest_tlbs(vcpu);
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 4bf82613d440..06ee9a1d78a5 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -263,16 +263,11 @@ int kvm_mips_host_tlb_lookup(struct kvm_vcpu *vcpu, unsigned long vaddr)
 }
 EXPORT_SYMBOL_GPL(kvm_mips_host_tlb_lookup);
 
-int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
+static int _kvm_mips_host_tlb_inv(unsigned long entryhi)
 {
 	int idx;
-	unsigned long flags, old_entryhi;
-
-	local_irq_save(flags);
-
-	old_entryhi = read_c0_entryhi();
 
-	write_c0_entryhi((va & VPN2_MASK) | kvm_mips_get_user_asid(vcpu));
+	write_c0_entryhi(entryhi);
 	mtc0_tlbw_hazard();
 
 	tlb_probe();
@@ -292,14 +287,39 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 		tlbw_use_hazard();
 	}
 
+	return idx;
+}
+
+int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va,
+			  bool user, bool kernel)
+{
+	int idx_user, idx_kernel;
+	unsigned long flags, old_entryhi;
+
+	local_irq_save(flags);
+
+	old_entryhi = read_c0_entryhi();
+
+	if (user)
+		idx_user = _kvm_mips_host_tlb_inv((va & VPN2_MASK) |
+						  kvm_mips_get_user_asid(vcpu));
+	if (kernel)
+		idx_kernel = _kvm_mips_host_tlb_inv((va & VPN2_MASK) |
+						kvm_mips_get_kernel_asid(vcpu));
+
 	write_c0_entryhi(old_entryhi);
 	mtc0_tlbw_hazard();
 
 	local_irq_restore(flags);
 
-	if (idx >= 0)
-		kvm_debug("%s: Invalidated entryhi %#lx @ idx %d\n", __func__,
-			  (va & VPN2_MASK) | kvm_mips_get_user_asid(vcpu), idx);
+	if (user && idx_user >= 0)
+		kvm_debug("%s: Invalidated guest user entryhi %#lx @ idx %d\n",
+			  __func__, (va & VPN2_MASK) |
+				    kvm_mips_get_user_asid(vcpu), idx_user);
+	if (kernel && idx_kernel >= 0)
+		kvm_debug("%s: Invalidated guest kernel entryhi %#lx @ idx %d\n",
+			  __func__, (va & VPN2_MASK) |
+				    kvm_mips_get_kernel_asid(vcpu), idx_kernel);
 
 	return 0;
 }
-- 
git-series 0.8.10
