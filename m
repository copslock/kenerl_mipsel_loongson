Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2016 23:42:28 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:59956 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042429AbcFEVmZg028p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Jun 2016 23:42:25 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 6A6D8723;
        Sun,  5 Jun 2016 21:42:19 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>,
        macro@linux-mips.org, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.4 01/99] MIPS64: R6: R2 emulation bugfix
Date:   Sun,  5 Jun 2016 14:40:34 -0700
Message-Id: <20160605213903.127819462@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160605213902.974592018@linuxfoundation.org>
References: <20160605213902.974592018@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53816
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

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/kernel/mips-r2-to-r6-emul.c |  105 +++++++++++++++++-----------------
 1 file changed, 53 insertions(+), 52 deletions(-)

--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -28,6 +28,7 @@
 #include <asm/inst.h>
 #include <asm/mips-r2-to-r6-emul.h>
 #include <asm/local.h>
+#include <asm/mipsregs.h>
 #include <asm/ptrace.h>
 #include <asm/uaccess.h>
 
@@ -1251,10 +1252,10 @@ fpu_emul:
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
@@ -1326,10 +1327,10 @@ fpu_emul:
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
@@ -1397,10 +1398,10 @@ fpu_emul:
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
@@ -1467,10 +1468,10 @@ fpu_emul:
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
@@ -1582,14 +1583,14 @@ fpu_emul:
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
@@ -1701,14 +1702,14 @@ fpu_emul:
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
@@ -1820,14 +1821,14 @@ fpu_emul:
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
@@ -1938,14 +1939,14 @@ fpu_emul:
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
@@ -2000,7 +2001,7 @@ fpu_emul:
 			"j	2b\n"
 			".previous\n"
 			".section        __ex_table,\"a\"\n"
-			".word  1b, 3b\n"
+			STR(PTR) " 1b,3b\n"
 			".previous\n"
 			: "=&r"(res), "+&r"(err)
 			: "r"(vaddr), "i"(SIGSEGV)
@@ -2058,7 +2059,7 @@ fpu_emul:
 			"j	2b\n"
 			".previous\n"
 			".section        __ex_table,\"a\"\n"
-			".word	1b, 3b\n"
+			STR(PTR) " 1b,3b\n"
 			".previous\n"
 			: "+&r"(res), "+&r"(err)
 			: "r"(vaddr), "i"(SIGSEGV));
@@ -2119,7 +2120,7 @@ fpu_emul:
 			"j	2b\n"
 			".previous\n"
 			".section        __ex_table,\"a\"\n"
-			".word  1b, 3b\n"
+			STR(PTR) " 1b,3b\n"
 			".previous\n"
 			: "=&r"(res), "+&r"(err)
 			: "r"(vaddr), "i"(SIGSEGV)
@@ -2182,7 +2183,7 @@ fpu_emul:
 			"j	2b\n"
 			".previous\n"
 			".section        __ex_table,\"a\"\n"
-			".word	1b, 3b\n"
+			STR(PTR) " 1b,3b\n"
 			".previous\n"
 			: "+&r"(res), "+&r"(err)
 			: "r"(vaddr), "i"(SIGSEGV));
