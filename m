Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Jul 2016 12:55:49 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62058 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992804AbcGHKyBWfxxv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Jul 2016 12:54:01 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0098553EA0B2B;
        Fri,  8 Jul 2016 11:53:53 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 8 Jul 2016 11:53:55 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>
CC:     =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        James Hogan <james.hogan@imgtec.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 10/12] MIPS: KVM: Fix ptr->int cast via KVM_GUEST_KSEGX()
Date:   Fri, 8 Jul 2016 11:53:29 +0100
Message-ID: <1467975211-12674-11-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 54263
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

kvm_mips_trans_replace() passes a pointer to KVM_GUEST_KSEGX(). This
breaks on 64-bit builds due to the cast of that 64-bit pointer to a
different sized 32-bit int. Cast the pointer argument to an unsigned
long to work around the warning.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/dyntrans.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/kvm/dyntrans.c b/arch/mips/kvm/dyntrans.c
index c793ff19a8a8..d280894915ed 100644
--- a/arch/mips/kvm/dyntrans.c
+++ b/arch/mips/kvm/dyntrans.c
@@ -33,7 +33,7 @@ static int kvm_mips_trans_replace(struct kvm_vcpu *vcpu, u32 *opc,
 	unsigned long paddr, flags;
 	void *vaddr;
 
-	if (KVM_GUEST_KSEGX(opc) == KVM_GUEST_KSEG0) {
+	if (KVM_GUEST_KSEGX((unsigned long)opc) == KVM_GUEST_KSEG0) {
 		paddr = kvm_mips_translate_guest_kseg0_to_hpa(vcpu,
 							    (unsigned long)opc);
 		vaddr = kmap_atomic(pfn_to_page(PHYS_PFN(paddr)));
-- 
2.4.10
