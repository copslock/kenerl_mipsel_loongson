Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 15:25:30 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:49811 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27041107AbcFINTuCHTzi (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 15:19:50 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 5D5047FBB671E;
        Thu,  9 Jun 2016 14:19:40 +0100 (IST)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Thu, 9 Jun 2016 14:19:43 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 15/18] MIPS: KVM: Simplify TLB_* macros
Date:   Thu, 9 Jun 2016 14:19:18 +0100
Message-ID: <1465478361-7431-16-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
References: <1465478361-7431-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53931
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

Simplify some of the TLB_ macros making use of the arrayification of
tlb_lo. Basically we index the array by the bit of the virtual address
which determines whether the even or odd entry is used, instead of
having a conditional.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Radim Krčmář <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/kvm_host.h | 8 +++-----
 1 file changed, 3 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/kvm_host.h b/arch/mips/include/asm/kvm_host.h
index 2d15da111ba8..83a3212b956d 100644
--- a/arch/mips/include/asm/kvm_host.h
+++ b/arch/mips/include/asm/kvm_host.h
@@ -310,13 +310,11 @@ enum emulation_result {
 
 #define VPN2_MASK		0xffffe000
 #define KVM_ENTRYHI_ASID	MIPS_ENTRYHI_ASID
-#define TLB_IS_GLOBAL(x)	(((x).tlb_lo[0] & MIPS3_PG_G) &&	\
-				 ((x).tlb_lo[1] & MIPS3_PG_G))
+#define TLB_IS_GLOBAL(x)	((x).tlb_lo[0] & (x).tlb_lo[1] & MIPS3_PG_G)
 #define TLB_VPN2(x)		((x).tlb_hi & VPN2_MASK)
 #define TLB_ASID(x)		((x).tlb_hi & KVM_ENTRYHI_ASID)
-#define TLB_IS_VALID(x, va)	(((va) & (1 << PAGE_SHIFT))		\
-				 ? ((x).tlb_lo[1] & MIPS3_PG_V)		\
-				 : ((x).tlb_lo[0] & MIPS3_PG_V))
+#define TLB_LO_IDX(x, va)	(((va) >> PAGE_SHIFT) & 1)
+#define TLB_IS_VALID(x, va)	((x).tlb_lo[TLB_LO_IDX(x, va)] & MIPS3_PG_V)
 #define TLB_HI_VPN2_HIT(x, y)	((TLB_VPN2(x) & ~(x).tlb_mask) ==	\
 				 ((y) & VPN2_MASK & ~(x).tlb_mask))
 #define TLB_HI_ASID_HIT(x, y)	(TLB_IS_GLOBAL(x) ||			\
-- 
2.4.10
