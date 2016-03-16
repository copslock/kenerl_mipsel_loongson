Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2016 09:10:55 +0100 (CET)
Received: from mail.kernel.org ([198.145.29.136]:56376 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27024671AbcCPIKwyi5QI (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 16 Mar 2016 09:10:52 +0100
Received: from mail.kernel.org (localhost [127.0.0.1])
        by mail.kernel.org (Postfix) with ESMTP id 0D5B020375;
        Wed, 16 Mar 2016 08:10:51 +0000 (UTC)
Received: from localhost.localdomain (unknown [221.12.19.247])
        (using TLSv1.2 with cipher AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 45042203F3;
        Wed, 16 Mar 2016 08:10:48 +0000 (UTC)
From:   lizf@kernel.org
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Zefan Li <lizefan@huawei.com>
Subject: [PATCH 3.4 062/107] MIPS: Make set_pte() SMP safe.
Date:   Wed, 16 Mar 2016 16:05:56 +0800
Message-Id: <1458115601-5762-62-git-send-email-lizf@kernel.org>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1458115541-5712-1-git-send-email-lizf@kernel.org>
References: <1458115541-5712-1-git-send-email-lizf@kernel.org>
X-Virus-Scanned: ClamAV using ClamSMTP
Return-Path: <lizf@kernel.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52605
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lizf@kernel.org
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

From: David Daney <david.daney@cavium.com>

3.4.111-rc1 review patch.  If anyone has any objections, please let me know.

------------------


commit 46011e6ea39235e4aca656673c500eac81a07a17 upstream.

On MIPS the GLOBAL bit of the PTE must have the same value in any
aligned pair of PTEs.  These pairs of PTEs are referred to as
"buddies".  In a SMP system is is possible for two CPUs to be calling
set_pte() on adjacent PTEs at the same time.  There is a race between
setting the PTE and a different CPU setting the GLOBAL bit in its
buddy PTE.

This race can be observed when multiple CPUs are executing
vmap()/vfree() at the same time.

Make setting the buddy PTE's GLOBAL bit an atomic operation to close
the race condition.

The case of CONFIG_64BIT_PHYS_ADDR && CONFIG_CPU_MIPS32 is *not*
handled.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/10835/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Zefan Li <lizefan@huawei.com>
---
 arch/mips/include/asm/pgtable.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index b2202a6..95bcedb 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -153,8 +153,39 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 		 * Make sure the buddy is global too (if it's !none,
 		 * it better already be global)
 		 */
+#ifdef CONFIG_SMP
+		/*
+		 * For SMP, multiple CPUs can race, so we need to do
+		 * this atomically.
+		 */
+#ifdef CONFIG_64BIT
+#define LL_INSN "lld"
+#define SC_INSN "scd"
+#else /* CONFIG_32BIT */
+#define LL_INSN "ll"
+#define SC_INSN "sc"
+#endif
+		unsigned long page_global = _PAGE_GLOBAL;
+		unsigned long tmp;
+
+		__asm__ __volatile__ (
+			"	.set	push\n"
+			"	.set	noreorder\n"
+			"1:	" LL_INSN "	%[tmp], %[buddy]\n"
+			"	bnez	%[tmp], 2f\n"
+			"	 or	%[tmp], %[tmp], %[global]\n"
+			"	" SC_INSN "	%[tmp], %[buddy]\n"
+			"	beqz	%[tmp], 1b\n"
+			"	 nop\n"
+			"2:\n"
+			"	.set pop"
+			: [buddy] "+m" (buddy->pte),
+			  [tmp] "=&r" (tmp)
+			: [global] "r" (page_global));
+#else /* !CONFIG_SMP */
 		if (pte_none(*buddy))
 			pte_val(*buddy) = pte_val(*buddy) | _PAGE_GLOBAL;
+#endif /* CONFIG_SMP */
 	}
 #endif
 }
-- 
1.9.1
