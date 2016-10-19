Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Oct 2016 00:50:13 +0200 (CEST)
Received: from wtarreau.pck.nerim.net ([62.212.114.60]:20563 "EHLO 1wt.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23991978AbcJSWuGcvPWa (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Oct 2016 00:50:06 +0200
Received: (from willy@localhost)
        by pcw.home.local (8.15.2/8.15.2/Submit) id u9JMnw7u028383;
        Thu, 20 Oct 2016 00:49:58 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Willy Tarreau <w@1wt.eu>
Subject: [PATCH 3.10 13/16] MIPS: KVM: Check for pfn noslot case
Date:   Thu, 20 Oct 2016 00:49:37 +0200
Message-Id: <1476917380-28311-14-git-send-email-w@1wt.eu>
X-Mailer: git-send-email 2.8.0.rc2.1.gbe9624a
In-Reply-To: <1476917380-28311-1-git-send-email-w@1wt.eu>
References: <1476917380-28311-1-git-send-email-w@1wt.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=latin1
Content-Transfer-Encoding: 8bit
Return-Path: <w@1wt.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55519
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

commit ba913e4f72fc9cfd03dad968dfb110eb49211d80 upstream.

When mapping a page into the guest we error check using is_error_pfn(),
however this doesn't detect a value of KVM_PFN_NOSLOT, indicating an
error HVA for the page. This can only happen on MIPS right now due to
unusual memslot management (e.g. being moved / removed / resized), or
with an Enhanced Virtual Memory (EVA) configuration where the default
KVM_HVA_ERR_* and kvm_is_error_hva() definitions are unsuitable (fixed
in a later patch). This case will be treated as a pfn of zero, mapping
the first page of physical memory into the guest.

It would appear the MIPS KVM port wasn't updated prior to being merged
(in v3.10) to take commit 81c52c56e2b4 ("KVM: do not treat noslot pfn as
a error pfn") into account (merged v3.8), which converted a bunch of
is_error_pfn() calls to is_error_noslot_pfn(). Switch to using
is_error_noslot_pfn() instead to catch this case properly.

Fixes: 858dd5d45733 ("KVM/MIPS32: MMU/TLB operations for the Guest.")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[james.hogan@imgtec.com: Backport to v3.16.y]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Willy Tarreau <w@1wt.eu>
---
 arch/mips/kvm/kvm_tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 4bee439..8a47bd9 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -182,7 +182,7 @@ static int kvm_mips_map_page(struct kvm *kvm, gfn_t gfn)
         srcu_idx = srcu_read_lock(&kvm->srcu);
 	pfn = kvm_mips_gfn_to_pfn(kvm, gfn);
 
-	if (kvm_mips_is_error_pfn(pfn)) {
+	if (is_error_noslot_pfn(pfn)) {
 		kvm_err("Couldn't get pfn for gfn %#" PRIx64 "!\n", gfn);
 		err = -EFAULT;
 		goto out;
-- 
2.8.0.rc2.1.gbe9624a
