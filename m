Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 07 Sep 2015 12:42:43 +0200 (CEST)
Received: from resqmta-ch2-01v.sys.comcast.net ([69.252.207.33]:46575 "EHLO
        resqmta-ch2-01v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007489AbbIGKmlnzcP3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 7 Sep 2015 12:42:41 +0200
Received: from resomta-ch2-19v.sys.comcast.net ([69.252.207.115])
        by resqmta-ch2-01v.sys.comcast.net with comcast
        id EAiX1r0052VvR6D01AiaNZ; Mon, 07 Sep 2015 10:42:35 +0000
Received: from [192.168.1.13] ([76.106.83.43])
        by resomta-ch2-19v.sys.comcast.net with comcast
        id EAiZ1r00l0w5D3801AiaFi; Mon, 07 Sep 2015 10:42:34 +0000
From:   Joshua Kinard <kumba@gentoo.org>
Subject: [PATCH]: MIPS: Adjust set_pte() SMP fix to handle R10000_LLSC_WAR
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     Linux/MIPS <linux-mips@linux-mips.org>,
        Markos Chandras <markos.chandras@imgtec.com>,
        David Daney <david.daney@cavium.com>
Message-ID: <55ED6A16.1090909@gentoo.org>
Date:   Mon, 7 Sep 2015 06:42:30 -0400
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.2.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1441622555;
        bh=rx5ANtEusmpwnIjKcyZMifrnvA70B6e1J122xqFIQNE=;
        h=Received:Received:From:Subject:To:Message-ID:Date:MIME-Version:
         Content-Type;
        b=l0/sPFcWaE65YoXrU1bx44B5ZTZRZGQ0cq/jZgx9MZWsBNAhIlQBKPFMxV4SxVfVL
         EBFTRfSK3PLfKfnJcy1AmsMXD/8tyk1peFY90E1sIE2EVcxDZikU33NWHCcvP8Qqsi
         q3fal0a0Su4KrVzwTV5vdXXRjVB6u14G/rkNYkKsmhh1n+vfq42/XxVAPNA0NqVThB
         GU4pdaErjiusuc+3TIQH6aSmikpTuTl7BApaGvry70yHyvt/W4grAGZSuv7TH+Judv
         tuy9gkLs2AqloFlvkYGcFcXSIC5uefxvLmXmvU6rwS9qFAHheubSOifG2rROGlzBjT
         A8G/bYXuamCjA==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49123
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

From: Joshua Kinard <kumba@gentoo.org>

Update the recent changes to set_pte() that were added in 46011e6ea392
to handle R10000_LLSC_WAR, and format the assembly to match other areas
of the MIPS tree using the same WAR.

This also incorporates a patch recently sent in my Markos Chandras,
"Remove local LL/SC preprocessor variants", so that patch doesn't need
to be applied if this one is accepted.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
Fixes: 46011e6ea392 ("MIPS: Make set_pte() SMP safe.)
Cc: Markos Chandras <markos.chandras@imgtec.com>
Cc: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/pgtable.h |   52 ++++++++++++++++++------------
 1 file changed, 32 insertions(+), 20 deletions(-)

Not sure if 'kernel_uses_llsc' or 'cpu_has_llsc' is appropriate for the
if conditional.  I've seen both used in the tree w/ the R10000_LLSC_WAR
construct.

Note: The set_pte() fix appears to be needed for IP27 to boot, so the
original patch and this one may need to be backported. Otherwise, the
heavy disk I/O lockup bug I've mentioned in the past has a higher chance
of triggering and freezing the machine solid, especially if mdraid is
rebuilding a disk.  The set_pte() fix won't address that bug, but at
least mdraid was able to finish the rebuild after it was applied.

linux-mips-set_pte-smp-r10k-war.patch
diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 8957f15..560bc74 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -187,30 +187,42 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
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
 
-		__asm__ __volatile__ (
-			"	.set	push\n"
-			"	.set	noreorder\n"
-			"1:	" LL_INSN "	%[tmp], %[buddy]\n"
-			"	bnez	%[tmp], 2f\n"
-			"	 or	%[tmp], %[tmp], %[global]\n"
-			"	" SC_INSN "	%[tmp], %[buddy]\n"
-			"	beqz	%[tmp], 1b\n"
-			"	 nop\n"
-			"2:\n"
-			"	.set pop"
-			: [buddy] "+m" (buddy->pte),
-			  [tmp] "=&r" (tmp)
+		if (kernel_uses_llsc && R10000_LLSC_WAR) {
+			__asm__ __volatile__ (
+			"	.set	arch=r4000			\n"
+			"	.set	push				\n"
+			"	.set	noreorder			\n"
+			"1:"	__LL	"%[tmp], %[buddy]		\n"
+			"	bnez	%[tmp], 2f			\n"
+			"	 or	%[tmp], %[tmp], %[global]	\n"
+				__SC	"%[tmp], %[buddy]		\n"
+			"	beqzl	%[tmp], 1b			\n"
+			"	nop					\n"
+			"2:						\n"
+			"	.set	pop				\n"
+			"	.set	mips0				\n"
+			: [buddy] "+m" (buddy->pte), [tmp] "=&r" (tmp)
+			: [global] "r" (page_global));
+		} else if (kernel_uses_llsc) {
+			__asm__ __volatile__ (
+			"	.set	"MIPS_ISA_ARCH_LEVEL"		\n"
+			"	.set	push				\n"
+			"	.set	noreorder			\n"
+			"1:"	__LL	"%[tmp], %[buddy]		\n"
+			"	bnez	%[tmp], 2f			\n"
+			"	 or	%[tmp], %[tmp], %[global]	\n"
+				__SC	"%[tmp], %[buddy]		\n"
+			"	beqz	%[tmp], 1b			\n"
+			"	nop					\n"
+			"2:						\n"
+			"	.set	pop				\n"
+			"	.set	mips0				\n"
+			: [buddy] "+m" (buddy->pte), [tmp] "=&r" (tmp)
 			: [global] "r" (page_global));
+		}
 #else /* !CONFIG_SMP */
 		if (pte_none(*buddy))
 			pte_val(*buddy) = pte_val(*buddy) | _PAGE_GLOBAL;
