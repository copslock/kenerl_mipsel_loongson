Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 29 Sep 2016 12:26:03 +0200 (CEST)
Received: from mx2.suse.de ([195.135.220.15]:52279 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23990864AbcI2KZ4nCJKU (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 29 Sep 2016 12:25:56 +0200
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (charybdis-ext.suse.de [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 8CEECABA5;
        Thu, 29 Sep 2016 10:25:56 +0000 (UTC)
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org, Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 001/119] MIPS: KVM: Check for pfn noslot case
Date:   Thu, 29 Sep 2016 12:23:57 +0200
Message-Id: <a528a0fa6d67ebe60bfc762c72b316d28ed21dea.1475144721.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <cover.1475144721.git.jslaby@suse.cz>
References: <cover.1475144721.git.jslaby@suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

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
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/kvm/kvm_tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index 4bee4397dca8..8a47bd96cee3 100644
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
2.10.0
