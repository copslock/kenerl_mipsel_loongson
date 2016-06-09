Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:19:27 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:34727 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27041424AbcFIVS36qX5E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:18:29 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bB7LR-0005H4-9a; Thu, 09 Jun 2016 21:18:29 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bB7LO-0006A3-K3; Thu, 09 Jun 2016 14:18:26 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>, macro@linux-mips.org,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 075/206] MIPS64: R6: R2 emulation bugfix
Date:   Thu,  9 Jun 2016 14:14:44 -0700
Message-Id: <1465507015-23052-76-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465507015-23052-1-git-send-email-kamal@canonical.com>
References: <1465507015-23052-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53982
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

4.2.8-ckt12 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

commit 41fa29e4d8cf4150568a0fe9bb4d62229f9caed5 upstream.

Error recovery pointers for fixups was improperly set as ".word"
which is unsuitable for MIPS64.

Replaced by STR(PTR)

[ralf@linux-mips.org: Apply changes as requested in the review process.]

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Reviewed-by: James Hogan <james.hogan@imgtec.com>
Reviewed-by: Markos Chandras <markos.chandras@imgtec.com>
Fixes: b0a668fb2038 ("MIPS: kernel: mips-r2-to-r6-emul: Add R2 emulator for MIPS R6")
Cc: macro@linux-mips.org
Cc: linux-mips@linux-mips.org
Cc: linux-kernel@vger.kernel.org
Patchwork: https://patchwork.linux-mips.org/patch/9911/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/kernel/mips-r2-to-r6-emul.c | 105 +++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 52 deletions(-)

diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index f2977f0..e19fa36 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -27,6 +27,7 @@
 #include <asm/inst.h>
 #include <asm/mips-r2-to-r6-emul.h>
 #include <asm/local.h>
+#include <asm/mipsregs.h>
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
 
@@ -1250,10 +1251,10 @@ fpu_emul:
 			"	j	10b\n"
 			"	.previous\n"
 			"	.section	__ex_table,\"a\"\n"
-			"	.word	1b,8b\n"
-			"	.word	2b,8b\n"
-			"	.word	3b,8b\n"
-			"	.word	4b,8b\n"
+			STR(PTR) " 1b,8b\n"
+			STR(PTR) " 2b,8b\n"
+			STR(PTR) " 3b,8b\n"
+			STR(PTR) " 4b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1325,10 +1326,10 @@ fpu_emul:
 			"	j	10b\n"
 			"       .previous\n"
 			"	.section	__ex_table,\"a\"\n"
-			"	.word	1b,8b\n"
-			"	.word	2b,8b\n"
-			"	.word	3b,8b\n"
-			"	.word	4b,8b\n"
+			STR(PTR) " 1b,8b\n"
+			STR(PTR) " 2b,8b\n"
+			STR(PTR) " 3b,8b\n"
+			STR(PTR) " 4b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1396,10 +1397,10 @@ fpu_emul:
 			"	j	9b\n"
 			"	.previous\n"
 			"	.section        __ex_table,\"a\"\n"
-			"	.word	1b,8b\n"
-			"	.word	2b,8b\n"
-			"	.word	3b,8b\n"
-			"	.word	4b,8b\n"
+			STR(PTR) " 1b,8b\n"
+			STR(PTR) " 2b,8b\n"
+			STR(PTR) " 3b,8b\n"
+			STR(PTR) " 4b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1466,10 +1467,10 @@ fpu_emul:
 			"	j	9b\n"
 			"	.previous\n"
 			"	.section        __ex_table,\"a\"\n"
-			"	.word	1b,8b\n"
-			"	.word	2b,8b\n"
-			"	.word	3b,8b\n"
-			"	.word	4b,8b\n"
+			STR(PTR) " 1b,8b\n"
+			STR(PTR) " 2b,8b\n"
+			STR(PTR) " 3b,8b\n"
+			STR(PTR) " 4b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1581,14 +1582,14 @@ fpu_emul:
 			"	j	9b\n"
 			"	.previous\n"
 			"	.section        __ex_table,\"a\"\n"
-			"	.word	1b,8b\n"
-			"	.word	2b,8b\n"
-			"	.word	3b,8b\n"
-			"	.word	4b,8b\n"
-			"	.word	5b,8b\n"
-			"	.word	6b,8b\n"
-			"	.word	7b,8b\n"
-			"	.word	0b,8b\n"
+			STR(PTR) " 1b,8b\n"
+			STR(PTR) " 2b,8b\n"
+			STR(PTR) " 3b,8b\n"
+			STR(PTR) " 4b,8b\n"
+			STR(PTR) " 5b,8b\n"
+			STR(PTR) " 6b,8b\n"
+			STR(PTR) " 7b,8b\n"
+			STR(PTR) " 0b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1700,14 +1701,14 @@ fpu_emul:
 			"	j      9b\n"
 			"	.previous\n"
 			"	.section        __ex_table,\"a\"\n"
-			"	.word  1b,8b\n"
-			"	.word  2b,8b\n"
-			"	.word  3b,8b\n"
-			"	.word  4b,8b\n"
-			"	.word  5b,8b\n"
-			"	.word  6b,8b\n"
-			"	.word  7b,8b\n"
-			"	.word  0b,8b\n"
+			STR(PTR) " 1b,8b\n"
+			STR(PTR) " 2b,8b\n"
+			STR(PTR) " 3b,8b\n"
+			STR(PTR) " 4b,8b\n"
+			STR(PTR) " 5b,8b\n"
+			STR(PTR) " 6b,8b\n"
+			STR(PTR) " 7b,8b\n"
+			STR(PTR) " 0b,8b\n"
 			"	.previous\n"
 			"	.set    pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1819,14 +1820,14 @@ fpu_emul:
 			"	j	9b\n"
 			"	.previous\n"
 			"	.section        __ex_table,\"a\"\n"
-			"	.word	1b,8b\n"
-			"	.word	2b,8b\n"
-			"	.word	3b,8b\n"
-			"	.word	4b,8b\n"
-			"	.word	5b,8b\n"
-			"	.word	6b,8b\n"
-			"	.word	7b,8b\n"
-			"	.word	0b,8b\n"
+			STR(PTR) " 1b,8b\n"
+			STR(PTR) " 2b,8b\n"
+			STR(PTR) " 3b,8b\n"
+			STR(PTR) " 4b,8b\n"
+			STR(PTR) " 5b,8b\n"
+			STR(PTR) " 6b,8b\n"
+			STR(PTR) " 7b,8b\n"
+			STR(PTR) " 0b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1937,14 +1938,14 @@ fpu_emul:
 			"       j	9b\n"
 			"       .previous\n"
 			"       .section        __ex_table,\"a\"\n"
-			"       .word	1b,8b\n"
-			"       .word	2b,8b\n"
-			"       .word	3b,8b\n"
-			"       .word	4b,8b\n"
-			"       .word	5b,8b\n"
-			"       .word	6b,8b\n"
-			"       .word	7b,8b\n"
-			"       .word	0b,8b\n"
+			STR(PTR) " 1b,8b\n"
+			STR(PTR) " 2b,8b\n"
+			STR(PTR) " 3b,8b\n"
+			STR(PTR) " 4b,8b\n"
+			STR(PTR) " 5b,8b\n"
+			STR(PTR) " 6b,8b\n"
+			STR(PTR) " 7b,8b\n"
+			STR(PTR) " 0b,8b\n"
 			"       .previous\n"
 			"       .set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1999,7 +2000,7 @@ fpu_emul:
 			"j	2b\n"
 			".previous\n"
 			".section        __ex_table,\"a\"\n"
-			".word  1b, 3b\n"
+			STR(PTR) " 1b,3b\n"
 			".previous\n"
 			: "=&r"(res), "+&r"(err)
 			: "r"(vaddr), "i"(SIGSEGV)
@@ -2057,7 +2058,7 @@ fpu_emul:
 			"j	2b\n"
 			".previous\n"
 			".section        __ex_table,\"a\"\n"
-			".word	1b, 3b\n"
+			STR(PTR) " 1b,3b\n"
 			".previous\n"
 			: "+&r"(res), "+&r"(err)
 			: "r"(vaddr), "i"(SIGSEGV));
@@ -2118,7 +2119,7 @@ fpu_emul:
 			"j	2b\n"
 			".previous\n"
 			".section        __ex_table,\"a\"\n"
-			".word  1b, 3b\n"
+			STR(PTR) " 1b,3b\n"
 			".previous\n"
 			: "=&r"(res), "+&r"(err)
 			: "r"(vaddr), "i"(SIGSEGV)
@@ -2181,7 +2182,7 @@ fpu_emul:
 			"j	2b\n"
 			".previous\n"
 			".section        __ex_table,\"a\"\n"
-			".word	1b, 3b\n"
+			STR(PTR) " 1b,3b\n"
 			".previous\n"
 			: "+&r"(res), "+&r"(err)
 			: "r"(vaddr), "i"(SIGSEGV));
-- 
2.7.4
