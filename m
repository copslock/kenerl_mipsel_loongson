Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 13 Aug 2016 20:10:33 +0200 (CEST)
Received: from shadbolt.e.decadent.org.uk ([88.96.1.126]:38874 "EHLO
        shadbolt.e.decadent.org.uk" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993074AbcHMSKXZpizD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 13 Aug 2016 20:10:23 +0200
Received: from 92.40.249.202.threembb.co.uk ([92.40.249.202] helo=deadeye)
        by shadbolt.decadent.org.uk with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.84_2)
        (envelope-from <ben@decadent.org.uk>)
        id 1bYdNz-0004W9-Jb; Sat, 13 Aug 2016 19:10:19 +0100
Received: from ben by deadeye with local (Exim 4.87)
        (envelope-from <ben@decadent.org.uk>)
        id 1bYd3f-0002sg-8g; Sat, 13 Aug 2016 18:49:19 +0100
Content-Type: text/plain; charset="UTF-8"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
From:   Ben Hutchings <ben@decadent.org.uk>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
CC:     akpm@linux-foundation.org,
        "Linux/MIPS" <linux-mips@linux-mips.org>,
        "David Daney" <david.daney@cavium.com>,
        "Joshua Kinard" <kumba@gentoo.org>,
        "Ralf Baechle" <ralf@linux-mips.org>
Date:   Sat, 13 Aug 2016 18:42:51 +0100
Message-ID: <lsq.1471110171.863985121@decadent.org.uk>
X-Mailer: LinuxStableQueue (scripts by bwh)
Subject: [PATCH 3.16 055/305] MIPS: Adjust set_pte() SMP fix to handle
 R10000_LLSC_WAR
In-Reply-To: <lsq.1471110169.907390585@decadent.org.uk>
X-SA-Exim-Connect-IP: 92.40.249.202
X-SA-Exim-Mail-From: ben@decadent.org.uk
X-SA-Exim-Scanned: No (on shadbolt.decadent.org.uk); SAEximRunCond expanded to false
Return-Path: <ben@decadent.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ben@decadent.org.uk
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

3.16.37-rc1 review patch.  If anyone has any objections, please let me know.

------------------

From: Joshua Kinard <kumba@gentoo.org>

commit 128639395b2ceacc6a56a0141d0261012bfe04d3 upstream.

Update the recent changes to set_pte() that were added in 46011e6ea392
to handle R10000_LLSC_WAR, and format the assembly to match other areas
of the MIPS tree using the same WAR.

This also incorporates a patch recently sent in my Markos Chandras,
"Remove local LL/SC preprocessor variants", so that patch doesn't need
to be applied if this one is accepted.

Signed-off-by: Joshua Kinard <kumba@gentoo.org>
Fixes: 46011e6ea392 ("MIPS: Make set_pte() SMP safe.)
Cc: David Daney <david.daney@cavium.com>
Cc: Linux/MIPS <linux-mips@linux-mips.org>
Patchwork: https://patchwork.linux-mips.org/patch/11103/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
[bwh: Backported to 3.2:
 - Use {LL,SC}_INSN not __{LL,SC}
 - Use literal arch=r4000 instead of MIPS_ISA_ARCH_LEVEL since R6 is not
   supported]
Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
---
 arch/mips/include/asm/pgtable.h | 45 +++++++++++++++++++++++++++++------------
 1 file changed, 32 insertions(+), 13 deletions(-)

--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -167,20 +167,39 @@ static inline void set_pte(pte_t *ptep,
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
+			"1:"	LL_INSN	" %[tmp], %[buddy]		\n"
+			"	bnez	%[tmp], 2f			\n"
+			"	 or	%[tmp], %[tmp], %[global]	\n"
+				SC_INSN	" %[tmp], %[buddy]		\n"
+			"	beqzl	%[tmp], 1b			\n"
+			"	nop					\n"
+			"2:						\n"
+			"	.set	pop				\n"
+			"	.set	mips0				\n"
+			: [buddy] "+m" (buddy->pte), [tmp] "=&r" (tmp)
 			: [global] "r" (page_global));
+		} else if (kernel_uses_llsc) {
+			__asm__ __volatile__ (
+			"	.set	arch=r4000			\n"
+			"	.set	push				\n"
+			"	.set	noreorder			\n"
+			"1:"	LL_INSN	" %[tmp], %[buddy]		\n"
+			"	bnez	%[tmp], 2f			\n"
+			"	 or	%[tmp], %[tmp], %[global]	\n"
+				SC_INSN	" %[tmp], %[buddy]		\n"
+			"	beqz	%[tmp], 1b			\n"
+			"	nop					\n"
+			"2:						\n"
+			"	.set	pop				\n"
+			"	.set	mips0				\n"
+			: [buddy] "+m" (buddy->pte), [tmp] "=&r" (tmp)
+			: [global] "r" (page_global));
+		}
 #else /* !CONFIG_SMP */
 		if (pte_none(*buddy))
 			pte_val(*buddy) = pte_val(*buddy) | _PAGE_GLOBAL;
