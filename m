Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2016 12:54:21 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16248 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992731AbcGHKxzCtXJv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2016 12:53:55 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8F11C48A82FEE;
        Fri,  8 Jul 2016 11:53:46 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 8 Jul 2016 11:53:48 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 02/12] MIPS: KVM: Use virt_to_phys() to get commpage PFN
Date:   Fri, 8 Jul 2016 11:53:21 +0100
Message-ID: <1467975211-12674-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com>
References: <1467975211-12674-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54259
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

Calculate the PFN of the commpage using virt_to_phys() instead of
CPHYSADDR(). This is more portable as kzalloc() may allocate from XKPhys
instead of KSeg0 on 64-bit kernels, which CPHYSADDR() doesn't handle.
This is sufficient for highmem kernels too since kzalloc() will allocate
from lowmem in KSeg0.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/tlb.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index 9699352293e4..f5f8c2acae53 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -176,7 +176,7 @@ int kvm_mips_handle_commpage_tlb_fault(unsigned long badvaddr,
 	unsigned long entrylo[2] = { 0, 0 };
 	unsigned int pair_idx;
 
-	pfn = CPHYSADDR(vcpu->arch.kseg0_commpage) >> PAGE_SHIFT;
+	pfn = PFN_DOWN(virt_to_phys(vcpu->arch.kseg0_commpage));
 	pair_idx = (badvaddr >> PAGE_SHIFT) & 1;
 	entrylo[pair_idx] = mips3_paddr_to_tlbpfn(pfn << PAGE_SHIFT) |
 		((_page_cachable_default >> _CACHE_SHIFT) << ENTRYLO_C_SHIFT) |
-- 
2.4.10
