Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Jan 2014 13:02:30 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:49256 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817237AbaAQMCC32Aht (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 17 Jan 2014 13:02:02 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Gleb Natapov <gleb@redhat.com>, <kvm@vger.kernel.org>,
        Sanjay Lal <sanjayl@kymasys.com>
Subject: [PATCH v2 1/2] MIPS: KVM: use common EHINV aware UNIQUE_ENTRYHI
Date:   Fri, 17 Jan 2014 12:01:30 +0000
Message-ID: <1389960091-8098-2-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 1.8.1.2
In-Reply-To: <1389960091-8098-1-git-send-email-james.hogan@imgtec.com>
References: <1389960091-8098-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.65]
X-SEF-Processed: 7_3_0_01192__2014_01_17_12_01_57
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39020
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

When KVM is enabled and TLB invalidation is supported,
kvm_mips_flush_host_tlb() can cause a machine check exception due to
multiple matching TLB entries. This can occur on shutdown even when KVM
hasn't been actively used.

Commit adb78de9eae8 (MIPS: mm: Move UNIQUE_ENTRYHI macro to a header
file) created a common UNIQUE_ENTRYHI in asm/tlb.h but it didn't update
the copy of UNIQUE_ENTRYHI in kvm_tlb.c to use it.

Commit 36b175451399 (MIPS: tlb: Set the EHINV bit for TLBINVF cores when
invalidating the TLB) later added TLB invalidation (EHINV) support to
the common UNIQUE_ENTRYHI.

Therefore make kvm_tlb.c use the EHINV aware UNIQUE_ENTRYHI
implementation in asm/tlb.h too.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: John Crispin <blogic@openwrt.org>
Cc: linux-mips@linux-mips.org
Cc: Gleb Natapov <gleb@redhat.com>
Cc: kvm@vger.kernel.org
Cc: Sanjay Lal <sanjayl@kymasys.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Acked-by: Paolo Bonzini <pbonzini@redhat.com>
---
This is based on John Crispin's mips-next-3.14 branch.

I do not object to it being squashed into commit adb78de9eae8 (MIPS: mm:
Move UNIQUE_ENTRYHI macro to a header file) since that commit hasn't
reached mainline yet.
---
 arch/mips/kvm/kvm_tlb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/arch/mips/kvm/kvm_tlb.c b/arch/mips/kvm/kvm_tlb.c
index c777dd36d4a8..52083ea7fddd 100644
--- a/arch/mips/kvm/kvm_tlb.c
+++ b/arch/mips/kvm/kvm_tlb.c
@@ -25,6 +25,7 @@
 #include <asm/mmu_context.h>
 #include <asm/pgtable.h>
 #include <asm/cacheflush.h>
+#include <asm/tlb.h>
 
 #undef CONFIG_MIPS_MT
 #include <asm/r4kcache.h>
@@ -35,9 +36,6 @@
 
 #define PRIx64 "llx"
 
-/* Use VZ EntryHi.EHINV to invalidate TLB entries */
-#define UNIQUE_ENTRYHI(idx) (CKSEG0 + ((idx) << (PAGE_SHIFT + 1)))
-
 atomic_t kvm_mips_instance;
 EXPORT_SYMBOL(kvm_mips_instance);
 
-- 
1.8.1.2
