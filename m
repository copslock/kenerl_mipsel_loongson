Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 21 Aug 2016 17:34:56 +0200 (CEST)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:55770 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23992624AbcHUPeoNvGH3 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 21 Aug 2016 17:34:44 +0200
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id u7LFWGdQ013307;
        Sun, 21 Aug 2016 17:32:16 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 052/180] MIPS: KVM: Fix gfn range check in kseg0 tlb faults
Date:   Sun, 21 Aug 2016 17:29:42 +0200
Message-Id: <1471793510-13022-53-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1471793510-13022-1-git-send-email-w@1wt.eu>
References: <1471793510-13022-1-git-send-email-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=latin1
Content-Transfer-Encoding: 8bit
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54706
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

commit 0741f52d1b980dbeb290afe67d88fc2928edd8ab upstream.

Two consecutive gfns are loaded into host TLB, so ensure the range check
isn't off by one if guest_pmap_npages is odd.

Fixes: 858dd5d45733 ("KVM/MIPS32: MMU/TLB operations for the Guest.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Radim Krčmář <rkrcmar@redhat.com>
[james.hogan@imgtec.com: Backport to v3.10.y - v3.15.y]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kvm/kvm_tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 8aba2e5..5a3c373 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -312,7 +312,7 @@ int kvm_mips_handle_kseg0_tlb_fault(unsigned long badvaddr,
 	}
 
 	gfn = (KVM_GUEST_CPHYSADDR(badvaddr) >> PAGE_SHIFT);
-	if (gfn >= kvm->arch.guest_pmap_npages) {
+	if ((gfn | 1) >= kvm->arch.guest_pmap_npages) {
 		kvm_err("%s: Invalid gfn: %#llx, BadVaddr: %#lx\n", __func__,
 			gfn, badvaddr);
 		kvm_mips_dump_host_tlbs();
-- 
2.8.0.rc2.1.gbe9624a
