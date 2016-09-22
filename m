Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2016 19:43:00 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:45710 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992126AbcIVRmu5F5Fk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2016 19:42:50 +0200
Received: from localhost (pes75-3-78-192-101-3.fbxo.proxad.net [78.192.101.3])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 14D47B8F;
        Thu, 22 Sep 2016 17:42:42 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        kvm@vger.kernel.org
Subject: [PATCH 4.7 002/184] MIPS: KVM: Check for pfn noslot case
Date:   Thu, 22 Sep 2016 19:38:56 +0200
Message-Id: <20160922174048.756735154@linuxfoundation.org>
X-Mailer: git-send-email 2.10.0
In-Reply-To: <20160922174048.653794923@linuxfoundation.org>
References: <20160922174048.653794923@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55239
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

4.7-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
[james.hogan@imgtec.com: Backport to v4.7.y]
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 arch/mips/kvm/tlb.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -159,7 +159,7 @@ static int kvm_mips_map_page(struct kvm
 	srcu_idx = srcu_read_lock(&kvm->srcu);
 	pfn = kvm_mips_gfn_to_pfn(kvm, gfn);
 
-	if (kvm_mips_is_error_pfn(pfn)) {
+	if (is_error_noslot_pfn(pfn)) {
 		kvm_err("Couldn't get pfn for gfn %#" PRIx64 "!\n", gfn);
 		err = -EFAULT;
 		goto out;
