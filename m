Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 06:08:52 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60323 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824804Ab2LGFFzGnwJP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 06:05:55 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Tgq8C-0007MA-Ul; Thu, 06 Dec 2012 23:05:48 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v99,09/13] MIPS: microMIPS: Work-around for assembler bug.
Date:   Thu,  6 Dec 2012 23:05:33 -0600
Message-Id: <1354856737-28678-10-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1354856737-28678-1-git-send-email-sjhill@mips.com>
References: <1354856737-28678-1-git-send-email-sjhill@mips.com>
X-archive-position: 35220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

When building a microMIPS instructions only kernel, the linker
complains about ISA mode switches in the .fixup section. We
explicitly add the .insn assembler directive to address this.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/include/asm/uaccess.h |   14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/uaccess.h b/arch/mips/include/asm/uaccess.h
index 3b92efe..d2f99ba 100644
--- a/arch/mips/include/asm/uaccess.h
+++ b/arch/mips/include/asm/uaccess.h
@@ -261,6 +261,7 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	" insn "	%1, %3				\n"	\
 	"2:							\n"	\
+	"	.insn						\n"	\
 	"	.section .fixup,\"ax\"				\n"	\
 	"3:	li	%0, %4					\n"	\
 	"	j	2b					\n"	\
@@ -287,7 +288,9 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	lw	%1, (%3)				\n"	\
 	"2:	lw	%D1, 4(%3)				\n"	\
-	"3:	.section	.fixup,\"ax\"			\n"	\
+	"3:							\n"	\
+	"	.insn						\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
 	"4:	li	%0, %4					\n"	\
 	"	move	%1, $0					\n"	\
 	"	move	%D1, $0					\n"	\
@@ -355,6 +358,7 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	" insn "	%z2, %3		# __put_user_asm\n"	\
 	"2:							\n"	\
+	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
 	"3:	li	%0, %4					\n"	\
 	"	j	2b					\n"	\
@@ -373,6 +377,7 @@ do {									\
 	"1:	sw	%2, (%3)	# __put_user_asm_ll32	\n"	\
 	"2:	sw	%D2, 4(%3)				\n"	\
 	"3:							\n"	\
+	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
 	"4:	li	%0, %4					\n"	\
 	"	j	3b					\n"	\
@@ -524,6 +529,7 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	" insn "	%1, %3				\n"	\
 	"2:							\n"	\
+	"	.insn						\n"	\
 	"	.section .fixup,\"ax\"				\n"	\
 	"3:	li	%0, %4					\n"	\
 	"	j	2b					\n"	\
@@ -549,7 +555,9 @@ do {									\
 	"1:	ulw	%1, (%3)				\n"	\
 	"2:	ulw	%D1, 4(%3)				\n"	\
 	"	move	%0, $0					\n"	\
-	"3:	.section	.fixup,\"ax\"			\n"	\
+	"3:							\n"	\
+	"	.insn						\n"	\
+	"	.section	.fixup,\"ax\"			\n"	\
 	"4:	li	%0, %4					\n"	\
 	"	move	%1, $0					\n"	\
 	"	move	%D1, $0					\n"	\
@@ -616,6 +624,7 @@ do {									\
 	__asm__ __volatile__(						\
 	"1:	" insn "	%z2, %3		# __put_user_unaligned_asm\n" \
 	"2:							\n"	\
+	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
 	"3:	li	%0, %4					\n"	\
 	"	j	2b					\n"	\
@@ -634,6 +643,7 @@ do {									\
 	"1:	sw	%2, (%3)	# __put_user_unaligned_asm_ll32	\n" \
 	"2:	sw	%D2, 4(%3)				\n"	\
 	"3:							\n"	\
+	"	.insn						\n"	\
 	"	.section	.fixup,\"ax\"			\n"	\
 	"4:	li	%0, %4					\n"	\
 	"	j	3b					\n"	\
-- 
1.7.9.5
