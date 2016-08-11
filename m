Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2016 12:59:42 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:37111 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992717AbcHKK6ujyN38 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Aug 2016 12:58:50 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id DB4D6104BFBAC;
        Thu, 11 Aug 2016 11:58:31 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 11 Aug 2016 11:58:34 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>,
        <stable@vger.kernel.org>, James Hogan <james.hogan@imgtec.com>
Subject: [PATCH 3/4] MIPS: KVM: Fix gfn range check in kseg0 tlb faults
Date:   Thu, 11 Aug 2016 11:58:14 +0100
Message-ID: <05f9926ea83406219474349145119beb0ec019fa.1470911944.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.9.2
MIME-Version: 1.0
In-Reply-To: <cover.e70247d7d77e67a2331e65b6b7fd3894508e5d28.1470911944.git-series.james.hogan@imgtec.com>
References: <cover.e70247d7d77e67a2331e65b6b7fd3894508e5d28.1470911944.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54482
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

Two consecutive gfns are loaded into host TLB, so ensure the range check
isn't off by one if guest_pmap_npages is odd.

Fixes: 858dd5d45733 ("KVM/MIPS32: MMU/TLB operations for the Guest.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Cc: <stable@vger.kernel.org> # 3.10.x-
---
 arch/mips/kvm/mmu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/mmu.c b/arch/mips/kvm/mmu.c
index 701c1b64cef8..6a8a21859502 100644
--- a/arch/mips/kvm/mmu.c
+++ b/arch/mips/kvm/mmu.c
@@ -99,7 +99,7 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 	}
 
 	gfn = (KVM_GUEST_CPHYSADDR(badvaddr) >> PAGE_SHIFT);
-	if (gfn >= kvm->arch.guest_pmap_npages) {
+	if ((gfn | 1) >= kvm->arch.guest_pmap_npages) {
 		kvm_err("%s: Invalid gfn: %#llx, BadVaddr: %#lx\n", __func__,
 			gfn, badvaddr);
 		kvm_mips_dump_host_tlbs();
-- 
git-series 0.8.7
