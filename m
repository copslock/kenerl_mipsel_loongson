Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 14 Nov 2016 03:09:26 +0100 (CET)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38435 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993045AbcKNCEnZUuuO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 14 Nov 2016 03:04:43 +0100
Received: from [2a02:8011:400e:2:6f00:88c8:c921:d332] (helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66dO-0005pA-AR; Mon, 14 Nov 2016 02:04:34 +0000
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1c66d8-0000c4-Sg; Mon, 14 Nov 2016 02:04:18 +0000
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Radim =?UTF-8?Q?Kr=C4=8Dm=C3=A1=C5=99?=" <rkrcmar@redhat.com>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Paolo Bonzini" <pbonzini@redhat.com>, kvm@vger.kernel.org,
        "James Hogan" <james.hogan@imgtec.com>, linux-mips@linux-mips.org,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Mon, 14 Nov 2016 00:14:20 +0000
Message-ID: <lsq.1479082460.632169991@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 196/346] MIPS: KVM: Check for pfn noslot case
In-Reply-To: <lsq.1479082458.755945576@decadent.org.uk>
X-SA-Exim-Connect-IP: 2a02:8011:400e:2:6f00:88c8:c921:d332
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55806
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

3.16.39-rc1 review patch.  If anyone has any objections, please let me know.

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
[bwh: Backported to 3.16: adjust filename]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/kvm/kvm_tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -155,7 +155,7 @@ static int kvm_mips_map_page(struct kvm
         srcu_idx = srcu_read_lock(&kvm->srcu);
 	pfn = kvm_mips_gfn_to_pfn(kvm, gfn);
 
-	if (kvm_mips_is_error_pfn(pfn)) {
+	if (is_error_noslot_pfn(pfn)) {
 		kvm_err("Couldn't get pfn for gfn %#" PRIx64 "!\n", gfn);
 		err = -EFAULT;
 		goto out;
