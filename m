Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jan 2017 13:53:09 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:57092 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993885AbdAPMtz1RZ1k (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 16 Jan 2017 13:49:55 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AD773E2725CD2;
        Mon, 16 Jan 2017 12:49:44 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 16 Jan 2017 12:49:47 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: [PATCH 8/13] KVM: MIPS: Clean & flush on dirty page logging enable
Date:   Mon, 16 Jan 2017 12:49:29 +0000
Message-ID: <e5f425d3732d75e707e0fdad2d4b0ce57f92c609.1484570878.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.99eec1b2ac935212acbcf2effacaab95cf6cdbf1.1484570878.git-series.james.hogan@imgtec.com>
References: <cover.99eec1b2ac935212acbcf2effacaab95cf6cdbf1.1484570878.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56327
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

When an existing memory region has dirty page logging enabled, make the
entire slot clean (read only) so that writes will immediately start
logging dirty pages (once the dirty bit is transferred from GPA to GVA
page tables in an upcoming patch).

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/kvm/mips.c | 24 ++++++++++++++++++++++++
 1 file changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/mips/kvm/mips.c b/arch/mips/kvm/mips.c
index bee7f5eabd4f..5b7e9a053f77 100644
--- a/arch/mips/kvm/mips.c
+++ b/arch/mips/kvm/mips.c
@@ -197,9 +197,33 @@ void kvm_arch_commit_memory_region(struct kvm *kvm,
 				   const struct kvm_memory_slot *new,
 				   enum kvm_mr_change change)
 {
+	int needs_flush;
+
 	kvm_debug("%s: kvm: %p slot: %d, GPA: %llx, size: %llx, QVA: %llx\n",
 		  __func__, kvm, mem->slot, mem->guest_phys_addr,
 		  mem->memory_size, mem->userspace_addr);
+
+	/*
+	 * If dirty page logging is enabled, write protect all pages in the slot
+	 * ready for dirty logging.
+	 *
+	 * There is no need to do this in any of the following cases:
+	 * CREATE:	No dirty mappings will already exist.
+	 * MOVE/DELETE:	The old mappings will already have been cleaned up by
+	 *		kvm_arch_flush_shadow_memslot()
+	 */
+	if (change == KVM_MR_FLAGS_ONLY &&
+	    (!(old->flags & KVM_MEM_LOG_DIRTY_PAGES) &&
+	     new->flags & KVM_MEM_LOG_DIRTY_PAGES)) {
+		spin_lock(&kvm->mmu_lock);
+		/* Write protect GPA page table entries */
+		needs_flush = kvm_mips_mkclean_gpa_pt(kvm, new->base_gfn,
+					new->base_gfn + new->npages - 1);
+		/* Let implementation do the rest */
+		if (needs_flush)
+			kvm_mips_callbacks->flush_shadow_memslot(kvm, new);
+		spin_unlock(&kvm->mmu_lock);
+	}
 }
 
 static inline void dump_handler(const char *symbol, void *start, void *end)
-- 
git-series 0.8.10
