Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Aug 2015 09:38:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:38347 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011194AbbHYHii6en5x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Aug 2015 09:38:38 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 521DB8DF41E77;
        Tue, 25 Aug 2015 08:38:30 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Tue, 25 Aug 2015 08:38:32 +0100
Received: from mchandras-linux.le.imgtec.org (192.168.154.168) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Tue, 25 Aug 2015 08:38:31 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: asm: pgtable.h: Remove local LL/SC preprocessor variants
Date:   Tue, 25 Aug 2015 08:38:26 +0100
Message-ID: <1440488306-25374-1-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.5.0
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.168]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49009
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

We already have 32/64-bit variants for the LL/SC instructions in
asm/bitops.h so make use of them and remove the local variants
from pgtable.h

Cc: David Daney <david.daney@cavium.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/pgtable.h | 12 +++---------
 1 file changed, 3 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index ae8569475264..e02777e8563e 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -10,6 +10,7 @@
 
 #include <linux/mm_types.h>
 #include <linux/mmzone.h>
+#include <asm/bitops.h>
 #ifdef CONFIG_32BIT
 #include <asm/pgtable-32.h>
 #endif
@@ -187,23 +188,16 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
 		 * For SMP, multiple CPUs can race, so we need to do
 		 * this atomically.
 		 */
-#ifdef CONFIG_64BIT
-#define LL_INSN "lld"
-#define SC_INSN "scd"
-#else /* CONFIG_32BIT */
-#define LL_INSN "ll"
-#define SC_INSN "sc"
-#endif
 		unsigned long page_global = _PAGE_GLOBAL;
 		unsigned long tmp;
 
 		__asm__ __volatile__ (
 			"	.set	push\n"
 			"	.set	noreorder\n"
-			"1:	" LL_INSN "	%[tmp], %[buddy]\n"
+			"1:	" __LL "%[tmp], %[buddy]\n"
 			"	bnez	%[tmp], 2f\n"
 			"	 or	%[tmp], %[tmp], %[global]\n"
-			"	" SC_INSN "	%[tmp], %[buddy]\n"
+			"	" __SC "%[tmp], %[buddy]\n"
 			"	beqz	%[tmp], 1b\n"
 			"	 nop\n"
 			"2:\n"
-- 
2.5.0
