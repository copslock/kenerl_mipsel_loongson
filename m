Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 13:51:34 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:18758 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993871AbdAPMtvMi0xk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 13:49:51 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0B3558E50244B;
        Mon, 16 Jan 2017 12:49:42 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 16 Jan 2017 12:49:44 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 4/13] KVM: MIPS/T&E: Treat unhandled guest KSeg0 as MMIO
Date:   Mon, 16 Jan 2017 12:49:25 +0000
Message-ID: <8891993da8c093da4e8d792eb755d44c678d558f.1484570878.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.99eec1b2ac935212acbcf2effacaab95cf6cdbf1.1484570878.git-series.james.hogan@imgtec.com>
References: <cover.99eec1b2ac935212acbcf2effacaab95cf6cdbf1.1484570878.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56323
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

Treat unhandled accesses to guest KSeg0 as MMIO, rather than only host
KSeg0 addresses. This will allow read only memory regions (such as the
Malta boot flash as emulated by QEMU) to have writes (before reads)
treated as MMIO, and unallocated physical addresses to have all accesses
treated as MMIO.

The MMIO emulation uses the gva_to_gpa callback, so this is also updated
for trap & emulate to handle guest KSeg0 addresses.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mmu.c       |  1 -
 arch/mips/kvm/trap_emul.c | 10 +++++-----
 2 files changed, 5 insertions(+), 6 deletions(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 1af65f2e6bb7..934bcc3732da 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -350,7 +350,6 @@ static int kvm_mips_map_page(struct kvm_vcpu *vcpu, unsigned long gpa,
 	pfn = gfn_to_pfn(kvm, gfn);
 
 	if (is_error_noslot_pfn(pfn)) {
-		kvm_err("Couldn't get pfn for gfn %#llx!\n", gfn);
 		err = -EFAULT;
 		goto out;
 	}
diff --git a/arch/mips/kvm/trap_emul.c b/arch/mips/kvm/trap_emul.c
index 79c30a0baad1..236390db6219 100644
--- a/arch/mips/kvm/trap_emul.c
+++ b/arch/mips/kvm/trap_emul.c
@@ -23,9 +23,12 @@ static gpa_t kvm_trap_emul_gva_to_gpa_cb(gva_t gva)
 {
 	gpa_t gpa;
 	gva_t kseg = KSEGX(gva);
+	gva_t gkseg = KVM_GUEST_KSEGX(gva);
 
 	if ((kseg == CKSEG0) || (kseg == CKSEG1))
 		gpa = CPHYSADDR(gva);
+	else if (gkseg == KVM_GUEST_KSEG0)
+		gpa = KVM_GUEST_CPHYSADDR(gva);
 	else {
 		kvm_err("%s: cannot find GPA for GVA: %#lx\n", __func__, gva);
 		kvm_mips_dump_host_tlbs();
@@ -240,11 +243,8 @@ static int kvm_trap_emul_handle_tlb_miss(struct kvm_vcpu *vcpu, bool store)
 		 * All KSEG0 faults are handled by KVM, as the guest kernel does
 		 * not expect to ever get them
 		 */
-		if (kvm_mips_handle_kseg0_tlb_fault
-		    (vcpu->arch.host_cp0_badvaddr, vcpu, store) < 0) {
-			run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
-			ret = RESUME_HOST;
-		}
+		if (kvm_mips_handle_kseg0_tlb_fault(badvaddr, vcpu, store) < 0)
+			ret = kvm_mips_bad_access(cause, opc, run, vcpu, store);
 	} else if (KVM_GUEST_KERNEL_MODE(vcpu)
 		   && (KSEGX(badvaddr) == CKSEG0 || KSEGX(badvaddr) == CKSEG1)) {
 		/*
-- 
git-series 0.8.10
