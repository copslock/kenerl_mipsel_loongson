Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 06 Jan 2017 02:40:22 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:24520 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993032AbdAFBdnseY8u (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 6 Jan 2017 02:33:43 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 8CD57874430C2;
        Fri,  6 Jan 2017 01:33:41 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 6 Jan 2017 01:33:42 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 18/30] KVM: MIPS/TLB: Fix off-by-one in TLB invalidate
Date:   Fri, 6 Jan 2017 01:32:50 +0000
Message-ID: <8e0a619f180adcd98d6ba977a696a74ac0b7ed41.1483665879.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
References: <cover.d6d201de414322ed2c1372e164254e6055ef7db9.1483665879.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56190
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

kvm_mips_host_tlb_inv() uses the TLBP instruction to probe the host TLB
for an entry matching the given guest virtual address, and determines
whether a match was found based on whether CP0_Index > 0. This is
technically incorrect as an index of 0 (with the high bit clear) is a
perfectly valid TLB index.

This is harmless at the moment due to the use of at least 1 wired TLB
entry for the KVM commpage, however we will soon be ridding ourselves of
that particular wired entry so lets fix the condition in case the entry
needing invalidation does land at TLB index 0.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/tlb.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/mips/kvm/tlb.c b/arch/mips/kvm/tlb.c
index ba490130b5e7..0bd380968627 100644
--- a/arch/mips/kvm/tlb.c
+++ b/arch/mips/kvm/tlb.c
@@ -282,7 +282,7 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 	if (idx >= current_cpu_data.tlbsize)
 		BUG();
 
-	if (idx > 0) {
+	if (idx >= 0) {
 		write_c0_entryhi(UNIQUE_ENTRYHI(idx));
 		write_c0_entrylo0(0);
 		write_c0_entrylo1(0);
@@ -297,7 +297,7 @@ int kvm_mips_host_tlb_inv(struct kvm_vcpu *vcpu, unsigned long va)
 
 	local_irq_restore(flags);
 
-	if (idx > 0)
+	if (idx >= 0)
 		kvm_debug("%s: Invalidated entryhi %#lx @ idx %d\n", __func__,
 			  (va & VPN2_MASK) | kvm_mips_get_user_asid(vcpu), idx);
 
-- 
git-series 0.8.10
