Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2015 02:49:09 +0200 (CEST)
Received: from mail-io0-f171.google.com ([209.85.223.171]:34695 "EHLO
        mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012260AbbHDAtH73ubU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2015 02:49:07 +0200
Received: by ioea135 with SMTP id a135so2113382ioe.1;
        Mon, 03 Aug 2015 17:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=2RjMi2ZHJkE4572jlXXZwDxEy2fLtB0BOdb/D+qHFbU=;
        b=GdsAsWbQ7NlN5ISVt3xPfFeWFxH/s7/VBWM/3MruDaNhPD4tcCLtm52l3Tvrml7Csi
         DDMCR6Ufr3qy1+tN08tlO3xPrJV9A6ZPRWg/+5SfMKZeXe5/irpQDeQfImiWSO0EK3Pl
         jeCBwdQoUImQkCFh7upyhvCIRbI3aOos8TDy+bejo4W0cOMddcdCG/nFYKuxFkh66j3O
         v91CkfgMcQzls9O2B48P7dvWlFCrkzaidslU/lmbGOkLS++ihu/dYQUtfFbQEHO1uxIC
         4zznsC8Nnlqy+jSR3yki9sOyg0swvzdcN0wzyEKrfOeUWLRZBjM34+HRj+7aQhW8LjWJ
         6u4g==
X-Received: by 10.107.26.206 with SMTP id a197mr869825ioa.147.1438649342173;
        Mon, 03 Aug 2015 17:49:02 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.194.ptr.us.xo.net. [64.2.3.194])
        by smtp.gmail.com with ESMTPSA id lp3sm205720igb.12.2015.08.03.17.49.00
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 03 Aug 2015 17:49:01 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id t740mwqo001121;
        Mon, 3 Aug 2015 17:48:58 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id t740mvkL001120;
        Mon, 3 Aug 2015 17:48:57 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Make set_pte() SMP safe.
Date:   Mon,  3 Aug 2015 17:48:43 -0700
Message-Id: <1438649323-1082-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48558
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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
Cc: <stable@vger.kernel.org>
---
 arch/mips/include/asm/pgtable.h | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/arch/mips/include/asm/pgtable.h b/arch/mips/include/asm/pgtable.h
index 9d81067..ae85694 100644
--- a/arch/mips/include/asm/pgtable.h
+++ b/arch/mips/include/asm/pgtable.h
@@ -182,8 +182,39 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
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
1.7.11.7
