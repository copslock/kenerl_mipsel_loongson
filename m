Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Apr 2015 21:53:45 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:64134 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007495AbbD1TxnDrSX9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Apr 2015 21:53:43 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 083B82D94BFE9;
        Tue, 28 Apr 2015 20:53:35 +0100 (IST)
Received: from hhmail02.hh.imgtec.org (10.100.10.20) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Tue, 28 Apr
 2015 20:53:38 +0100
Received: from BAMAIL02.ba.imgtec.org (10.20.40.28) by hhmail02.hh.imgtec.org
 (10.100.10.20) with Microsoft SMTP Server (TLS) id 14.3.224.2; Tue, 28 Apr
 2015 20:53:37 +0100
Received: from [127.0.1.1] (10.20.3.79) by bamail02.ba.imgtec.org
 (10.20.40.28) with Microsoft SMTP Server (TLS) id 14.3.174.1; Tue, 28 Apr
 2015 12:53:35 -0700
Subject: [PATCH] MIPS64: R6: R2 emulation bugfix
From:   Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
To:     <linux-mips@linux-mips.org>, <macro@linux-mips.org>,
        <markos.chandras@imgtec.com>, <ralf@linux-mips.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 28 Apr 2015 12:53:35 -0700
Message-ID: <20150428195335.11229.4516.stgit@ubuntu-yegoshin>
User-Agent: StGit/0.17.1-dirty
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.20.3.79]
Return-Path: <Leonid.Yegoshin@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47139
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Leonid.Yegoshin@imgtec.com
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

Error recovery pointers for fixups was improperly set as ".word"
which is unsuitable for MIPS64.

Replaced by __stringify(PTR)

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
---
 arch/mips/kernel/mips-r2-to-r6-emul.c |  104 +++++++++++++++++----------------
 1 file changed, 52 insertions(+), 52 deletions(-)

diff --git a/arch/mips/kernel/mips-r2-to-r6-emul.c b/arch/mips/kernel/mips-r2-to-r6-emul.c
index f2977f00911b..c6f079f8f3dc 100644
--- a/arch/mips/kernel/mips-r2-to-r6-emul.c
+++ b/arch/mips/kernel/mips-r2-to-r6-emul.c
@@ -1250,10 +1250,10 @@ fpu_emul:
 			"	j	10b\n"
 			"	.previous\n"
 			"	.section	__ex_table,\"a\"\n"
-			"	.word	1b,8b\n"
-			"	.word	2b,8b\n"
-			"	.word	3b,8b\n"
-			"	.word	4b,8b\n"
+			__stringify(PTR) " 1b,8b\n"
+			__stringify(PTR) " 2b,8b\n"
+			__stringify(PTR) " 3b,8b\n"
+			__stringify(PTR) " 4b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1325,10 +1325,10 @@ fpu_emul:
 			"	j	10b\n"
 			"       .previous\n"
 			"	.section	__ex_table,\"a\"\n"
-			"	.word	1b,8b\n"
-			"	.word	2b,8b\n"
-			"	.word	3b,8b\n"
-			"	.word	4b,8b\n"
+			__stringify(PTR) " 1b,8b\n"
+			__stringify(PTR) " 2b,8b\n"
+			__stringify(PTR) " 3b,8b\n"
+			__stringify(PTR) " 4b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1396,10 +1396,10 @@ fpu_emul:
 			"	j	9b\n"
 			"	.previous\n"
 			"	.section        __ex_table,\"a\"\n"
-			"	.word	1b,8b\n"
-			"	.word	2b,8b\n"
-			"	.word	3b,8b\n"
-			"	.word	4b,8b\n"
+			__stringify(PTR) " 1b,8b\n"
+			__stringify(PTR) " 2b,8b\n"
+			__stringify(PTR) " 3b,8b\n"
+			__stringify(PTR) " 4b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1466,10 +1466,10 @@ fpu_emul:
 			"	j	9b\n"
 			"	.previous\n"
 			"	.section        __ex_table,\"a\"\n"
-			"	.word	1b,8b\n"
-			"	.word	2b,8b\n"
-			"	.word	3b,8b\n"
-			"	.word	4b,8b\n"
+			__stringify(PTR) " 1b,8b\n"
+			__stringify(PTR) " 2b,8b\n"
+			__stringify(PTR) " 3b,8b\n"
+			__stringify(PTR) " 4b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1581,14 +1581,14 @@ fpu_emul:
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
+			__stringify(PTR) " 1b,8b\n"
+			__stringify(PTR) " 2b,8b\n"
+			__stringify(PTR) " 3b,8b\n"
+			__stringify(PTR) " 4b,8b\n"
+			__stringify(PTR) " 5b,8b\n"
+			__stringify(PTR) " 6b,8b\n"
+			__stringify(PTR) " 7b,8b\n"
+			__stringify(PTR) " 0b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1700,14 +1700,14 @@ fpu_emul:
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
+			__stringify(PTR) " 1b,8b\n"
+			__stringify(PTR) " 2b,8b\n"
+			__stringify(PTR) " 3b,8b\n"
+			__stringify(PTR) " 4b,8b\n"
+			__stringify(PTR) " 5b,8b\n"
+			__stringify(PTR) " 6b,8b\n"
+			__stringify(PTR) " 7b,8b\n"
+			__stringify(PTR) " 0b,8b\n"
 			"	.previous\n"
 			"	.set    pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1819,14 +1819,14 @@ fpu_emul:
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
+			__stringify(PTR) " 1b,8b\n"
+			__stringify(PTR) " 2b,8b\n"
+			__stringify(PTR) " 3b,8b\n"
+			__stringify(PTR) " 4b,8b\n"
+			__stringify(PTR) " 5b,8b\n"
+			__stringify(PTR) " 6b,8b\n"
+			__stringify(PTR) " 7b,8b\n"
+			__stringify(PTR) " 0b,8b\n"
 			"	.previous\n"
 			"	.set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1937,14 +1937,14 @@ fpu_emul:
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
+			__stringify(PTR) " 1b,8b\n"
+			__stringify(PTR) " 2b,8b\n"
+			__stringify(PTR) " 3b,8b\n"
+			__stringify(PTR) " 4b,8b\n"
+			__stringify(PTR) " 5b,8b\n"
+			__stringify(PTR) " 6b,8b\n"
+			__stringify(PTR) " 7b,8b\n"
+			__stringify(PTR) " 0b,8b\n"
 			"       .previous\n"
 			"       .set	pop\n"
 			: "+&r"(rt), "=&r"(rs),
@@ -1999,7 +1999,7 @@ fpu_emul:
 			"j	2b\n"
 			".previous\n"
 			".section        __ex_table,\"a\"\n"
-			".word  1b, 3b\n"
+			__stringify(PTR) " 1b,3b\n"
 			".previous\n"
 			: "=&r"(res), "+&r"(err)
 			: "r"(vaddr), "i"(SIGSEGV)
@@ -2057,7 +2057,7 @@ fpu_emul:
 			"j	2b\n"
 			".previous\n"
 			".section        __ex_table,\"a\"\n"
-			".word	1b, 3b\n"
+			__stringify(PTR) " 1b,3b\n"
 			".previous\n"
 			: "+&r"(res), "+&r"(err)
 			: "r"(vaddr), "i"(SIGSEGV));
@@ -2118,7 +2118,7 @@ fpu_emul:
 			"j	2b\n"
 			".previous\n"
 			".section        __ex_table,\"a\"\n"
-			".word  1b, 3b\n"
+			__stringify(PTR) " 1b,3b\n"
 			".previous\n"
 			: "=&r"(res), "+&r"(err)
 			: "r"(vaddr), "i"(SIGSEGV)
@@ -2181,7 +2181,7 @@ fpu_emul:
 			"j	2b\n"
 			".previous\n"
 			".section        __ex_table,\"a\"\n"
-			".word	1b, 3b\n"
+			__stringify(PTR) " 1b,3b\n"
 			".previous\n"
 			: "+&r"(res), "+&r"(err)
 			: "r"(vaddr), "i"(SIGSEGV));
