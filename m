Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 May 2016 15:37:38 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18082 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27028100AbcEFNgj55jSk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 May 2016 15:36:39 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email with ESMTPS id 3D6564F99A8B7;
        Fri,  6 May 2016 14:36:30 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 14:36:33 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 6 May 2016 14:36:33 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 3/7] MIPS: KVM: Abstract guest ASID mask
Date:   Fri, 6 May 2016 14:36:20 +0100
Message-ID: <1462541784-22128-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
References: <1462541784-22128-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53294
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

From: Paul Burton <paul.burton@imgtec.com>

In preparation for supporting varied widths of ASID mask in the kernel
in general, switch KVM's guest ASIDs to a new KVM_ENTRYHI_ASID
definition based on the 8-bit MIPS_ENTRYHI_ASID instead of ASID_MASK.

It could potentially be used to support extended guest ASIDs in the
future.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h |  5 +++--
 arch/mips/kvm/emulate.c          | 25 +++++++++++++------------
 arch/mips/kvm/tlb.c              |  3 ++-
 3 files changed, 18 insertions(+), 15 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index f6b12790716c..b76e132c87e4 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -311,17 +311,18 @@ enum emulation_result {
 #define MIPS3_PG_FRAME		0x3fffffc0
 
 #define VPN2_MASK		0xffffe000
+#define KVM_ENTRYHI_ASID	MIPS_ENTRYHI_ASID
 #define TLB_IS_GLOBAL(x)	(((x).tlb_lo0 & MIPS3_PG_G) &&		\
 				 ((x).tlb_lo1 & MIPS3_PG_G))
 #define TLB_VPN2(x)		((x).tlb_hi & VPN2_MASK)
-#define TLB_ASID(x)		((x).tlb_hi & ASID_MASK)
+#define TLB_ASID(x)		((x).tlb_hi & KVM_ENTRYHI_ASID)
 #define TLB_IS_VALID(x, va)	(((va) & (1 << PAGE_SHIFT))		\
 				 ? ((x).tlb_lo1 & MIPS3_PG_V)		\
 				 : ((x).tlb_lo0 & MIPS3_PG_V))
 #define TLB_HI_VPN2_HIT(x, y)	((TLB_VPN2(x) & ~(x).tlb_mask) ==	\
 				 ((y) & VPN2_MASK & ~(x).tlb_mask))
 #define TLB_HI_ASID_HIT(x, y)	(TLB_IS_GLOBAL(x) ||			\
-				 TLB_ASID(x) == ((y) & ASID_MASK))
+				 TLB_ASID(x) == ((y) & KVM_ENTRYHI_ASID))
 
 struct kvm_mips_tlb {
 	long tlb_mask;
diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
index b37954cc880d..8e945e866a73 100644
--- a/arch/mips/kvm/emulate.c
+++ b/arch/mips/kvm/emulate.c
@@ -1068,15 +1068,15 @@ enum emulation_result kvm_mips_emulate_CP0(uint32_t inst, uint32_t *opc,
 					kvm_read_c0_guest_ebase(cop0));
 			} else if (rd == MIPS_CP0_TLB_HI && sel == 0) {
 				uint32_t nasid =
-					vcpu->arch.gprs[rt] & ASID_MASK;
+					vcpu->arch.gprs[rt] & KVM_ENTRYHI_ASID;
 				if ((KSEGX(vcpu->arch.gprs[rt]) != CKSEG0) &&
 				    ((kvm_read_c0_guest_entryhi(cop0) &
-				      ASID_MASK) != nasid)) {
+				      KVM_ENTRYHI_ASID) != nasid)) {
 					kvm_debug("MTCz, change ASID from %#lx to %#lx\n",
 						kvm_read_c0_guest_entryhi(cop0)
-						& ASID_MASK,
+						& KVM_ENTRYHI_ASID,
 						vcpu->arch.gprs[rt]
-						& ASID_MASK);
+						& KVM_ENTRYHI_ASID);
 
 					/* Blow away the shadow host TLBs */
 					kvm_mips_flush_host_tlb(1);
@@ -1620,7 +1620,7 @@ enum emulation_result kvm_mips_emulate_cache(uint32_t inst, uint32_t *opc,
 		 */
 		index = kvm_mips_guest_tlb_lookup(vcpu, (va & VPN2_MASK) |
 						  (kvm_read_c0_guest_entryhi
-						   (cop0) & ASID_MASK));
+						   (cop0) & KVM_ENTRYHI_ASID));
 
 		if (index < 0) {
 			vcpu->arch.host_cp0_entryhi = (va & VPN2_MASK);
@@ -1786,7 +1786,7 @@ enum emulation_result kvm_mips_emulate_tlbmiss_ld(unsigned long cause,
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	unsigned long entryhi = (vcpu->arch.  host_cp0_badvaddr & VPN2_MASK) |
-				(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
+			(kvm_read_c0_guest_entryhi(cop0) & KVM_ENTRYHI_ASID);
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1833,7 +1833,7 @@ enum emulation_result kvm_mips_emulate_tlbinv_ld(unsigned long cause,
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	unsigned long entryhi =
 		(vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-		(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
+		(kvm_read_c0_guest_entryhi(cop0) & KVM_ENTRYHI_ASID);
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1878,7 +1878,7 @@ enum emulation_result kvm_mips_emulate_tlbmiss_st(unsigned long cause,
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-				(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
+			(kvm_read_c0_guest_entryhi(cop0) & KVM_ENTRYHI_ASID);
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1922,7 +1922,7 @@ enum emulation_result kvm_mips_emulate_tlbinv_st(unsigned long cause,
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-		(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
+		(kvm_read_c0_guest_entryhi(cop0) & KVM_ENTRYHI_ASID);
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
 		/* save old pc */
@@ -1967,7 +1967,7 @@ enum emulation_result kvm_mips_handle_tlbmod(unsigned long cause, uint32_t *opc,
 #ifdef DEBUG
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-				(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
+			(kvm_read_c0_guest_entryhi(cop0) & KVM_ENTRYHI_ASID);
 	int index;
 
 	/* If address not in the guest TLB, then we are in trouble */
@@ -1994,7 +1994,7 @@ enum emulation_result kvm_mips_emulate_tlbmod(unsigned long cause,
 {
 	struct mips_coproc *cop0 = vcpu->arch.cop0;
 	unsigned long entryhi = (vcpu->arch.host_cp0_badvaddr & VPN2_MASK) |
-				(kvm_read_c0_guest_entryhi(cop0) & ASID_MASK);
+			(kvm_read_c0_guest_entryhi(cop0) & KVM_ENTRYHI_ASID);
 	struct kvm_vcpu_arch *arch = &vcpu->arch;
 
 	if ((kvm_read_c0_guest_status(cop0) & ST0_EXL) == 0) {
@@ -2569,7 +2569,8 @@ enum emulation_result kvm_mips_handle_tlbmiss(unsigned long cause,
 	 */
 	index = kvm_mips_guest_tlb_lookup(vcpu,
 		      (va & VPN2_MASK) |
-		      (kvm_read_c0_guest_entryhi(vcpu->arch.cop0) & ASID_MASK));
+		      (kvm_read_c0_guest_entryhi(vcpu->arch.cop0) &
+		       KVM_ENTRYHI_ASID));
 	if (index < 0) {
 		if (exccode == EXCCODE_TLBL) {
 			er = kvm_mips_emulate_tlbmiss_ld(cause, opc, run, vcpu);
diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index e0e1d0a611fc..52d87280f865 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -748,7 +748,8 @@ uint32_t kvm_get_inst(uint32_t *opc, struct kvm_vcpu *vcpu)
 			inst = *(opc);
 		} else {
 			vpn2 = (unsigned long) opc & VPN2_MASK;
-			asid = kvm_read_c0_guest_entryhi(cop0) & ASID_MASK;
+			asid = kvm_read_c0_guest_entryhi(cop0) &
+						KVM_ENTRYHI_ASID;
 			index = kvm_mips_guest_tlb_lookup(vcpu, vpn2 | asid);
 			if (index < 0) {
 				kvm_err("%s: get_user_failed for %p, vcpu: %p, ASID: %#lx\n",
-- 
2.4.10
