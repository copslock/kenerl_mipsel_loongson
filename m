Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Mar 2017 11:21:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:42947 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23994799AbdCNKSN3SELU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Mar 2017 11:18:13 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 9F2795A00B754;
        Tue, 14 Mar 2017 10:18:04 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 hhmail02.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Tue, 14 Mar 2017 10:18:07 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>, <kvm@vger.kernel.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>
Subject: [PATCH v2 6/33] MIPS: asm/tlb.h: Add UNIQUE_GUEST_ENTRYHI() macro
Date:   Tue, 14 Mar 2017 10:15:13 +0000
Message-ID: <a45aeffd142c2da3a6efb178871eb0d30b3fe060.1489485940.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.1
MIME-Version: 1.0
In-Reply-To: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
References: <cover.26e10ec77a4ed0d3177ccf4fabf57bc95ea030f8.1489485940.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57208
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

Add a distinct UNIQUE_GUEST_ENTRYHI() macro for invalidation of guest
TLB entries by KVM, using addresses in KSeg1 rather than KSeg0. This
avoids conflicts with guest invalidation routines when there is no EHINV
bit to mark the whole entry as invalid, avoiding guest machine check
exceptions on Cavium Octeon III.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/tlb.h | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/tlb.h b/arch/mips/include/asm/tlb.h
index dd179fd8acda..939734de4359 100644
--- a/arch/mips/include/asm/tlb.h
+++ b/arch/mips/include/asm/tlb.h
@@ -21,9 +21,11 @@
  */
 #define tlb_flush(tlb) flush_tlb_mm((tlb)->mm)
 
-#define UNIQUE_ENTRYHI(idx)						\
-		((CKSEG0 + ((idx) << (PAGE_SHIFT + 1))) |		\
+#define _UNIQUE_ENTRYHI(base, idx)					\
+		(((base) + ((idx) << (PAGE_SHIFT + 1))) |		\
 		 (cpu_has_tlbinv ? MIPS_ENTRYHI_EHINV : 0))
+#define UNIQUE_ENTRYHI(idx)		_UNIQUE_ENTRYHI(CKSEG0, idx)
+#define UNIQUE_GUEST_ENTRYHI(idx)	_UNIQUE_ENTRYHI(CKSEG1, idx)
 
 static inline unsigned int num_wired_entries(void)
 {
-- 
git-series 0.8.10
