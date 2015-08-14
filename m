Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Aug 2015 19:53:11 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:56757 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006209AbbHNRxIyVCh1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Aug 2015 19:53:08 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 491F88A6;
        Fri, 14 Aug 2015 17:53:02 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, David Daney <david.daney@cavium.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 3.10 03/35] MIPS: Make set_pte() SMP safe.
Date:   Fri, 14 Aug 2015 10:44:41 -0700
Message-Id: <20150814174353.957695441@linuxfoundation.org>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <20150814174353.835241087@linuxfoundation.org>
References: <20150814174353.835241087@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48908
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

3.10-stable review patch.  If anyone has any objections, please let me know.

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/pgtable.h |   31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -150,8 +150,39 @@ static inline void set_pte(pte_t *ptep,
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
