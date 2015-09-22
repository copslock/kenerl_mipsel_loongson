Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 Sep 2015 19:55:22 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:53302 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009092AbbIVRxorZJCU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 22 Sep 2015 19:53:44 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1ZeRlA-0000zc-BR; Tue, 22 Sep 2015 17:53:44 +0000
Received: from kamal by fourier with local (Exim 4.82)
        (envelope-from <kamal@whence.com>)
        id 1ZeRl8-0000eJ-45; Tue, 22 Sep 2015 10:53:42 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     David Daney <david.daney@cavium.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 3.19.y-ckt 046/102] MIPS: Make set_pte() SMP safe.
Date:   Tue, 22 Sep 2015 10:51:42 -0700
Message-Id: <1442944358-1248-47-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1442944358-1248-1-git-send-email-kamal@canonical.com>
References: <1442944358-1248-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 3.19
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49298
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

3.19.8-ckt7 -stable review patch.  If anyone has any objections, please let me know.

------------------

From: David Daney <david.daney@cavium.com>

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
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/include/asm/pgtable.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 845016d..4ec91d5 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -187,8 +187,39 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
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
