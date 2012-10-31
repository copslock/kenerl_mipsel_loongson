Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2012 16:25:20 +0100 (CET)
Received: from kymasys.com ([64.62.140.43]:46731 "HELO kymasys.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with SMTP
        id S6822164Ab2JaPUxka8hR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2012 16:20:53 +0100
Received: from ::ffff:173.33.185.184 ([173.33.185.184]) by kymasys.com for <linux-mips@linux-mips.org>; Wed, 31 Oct 2012 08:20:45 -0700
From:   Sanjay Lal <sanjayl@kymasys.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Subject: [PATCH 15/20] MIPS: If KVM is enabled then use the KVM specific  routine to flush the TLBs on a ASID wrap
Date:   Wed, 31 Oct 2012 11:20:42 -0400
Message-Id: <333219EB-AEDE-47AE-BD69-2B69BBECD188@kymasys.com>
To:     kvm@vger.kernel.org, linux-mips@linux-mips.org
Mime-Version: 1.0 (Apple Message framework v1283)
X-Mailer: Apple Mail (2.1283)
X-archive-position: 34827
X-Approved-By: ralf@linux-mips.org
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sanjayl@kymasys.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Signed-off-by: Sanjay Lal <sanjayl@kymasys.com>
---
 arch/mips/include/asm/mmu_context.h | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
index 9b02cfb..9c7024c 100644
--- a/arch/mips/include/asm/mmu_context.h
+++ b/arch/mips/include/asm/mmu_context.h
@@ -112,15 +112,21 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
 static inline void
 get_new_mmu_context(struct mm_struct *mm, unsigned long cpu)
 {
+    extern void kvm_local_flush_tlb_all(void);
 	unsigned long asid = asid_cache(cpu);
 
 	if (! ((asid += ASID_INC) & ASID_MASK) ) {
 		if (cpu_has_vtag_icache)
 			flush_icache_all();
+#ifdef CONFIG_VIRTUALIZATION
+        kvm_local_flush_tlb_all();      /* start new asid cycle */
+#else
 		local_flush_tlb_all();	/* start new asid cycle */
+#endif
 		if (!asid)		/* fix version if needed */
 			asid = ASID_FIRST_VERSION;
 	}
+
 	cpu_context(cpu, mm) = asid_cache(cpu) = asid;
 }
 
-- 
1.7.11.3
