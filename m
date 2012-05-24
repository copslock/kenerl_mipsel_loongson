Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2012 22:56:55 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:42849 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903737Ab2EXU4A (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 May 2012 22:56:00 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SXf4c-0003sB-K6; Thu, 24 May 2012 15:55:54 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 2/4] MIPS: Optimise core library function 'strncpy' for microMIPS.
Date:   Thu, 24 May 2012 15:55:40 -0500
Message-Id: <1337892942-24492-3-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1337892942-24492-1-git-send-email-sjhill@mips.com>
References: <1337892942-24492-1-git-send-email-sjhill@mips.com>
X-archive-position: 33462
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

Optimise 'strncpy' to use microMIPS instructions and/or optimisations
for binary size reduction. When the microMIPS ISA is not being used,
the library function compiles to the original binary code.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/lib/strncpy_user.S |   28 +++++++++++++++-------------
 1 file changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/mips/lib/strncpy_user.S b/arch/mips/lib/strncpy_user.S
index 7201b2f..dea9304 100644
--- a/arch/mips/lib/strncpy_user.S
+++ b/arch/mips/lib/strncpy_user.S
@@ -3,7 +3,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (c) 1996, 1999 by Ralf Baechle
+ * Copyright (C) 1996, 1999 by Ralf Baechle
+ * Copyright (C) 2011 MIPS Technologies, Inc.
  */
 #include <linux/errno.h>
 #include <asm/asm.h>
@@ -33,22 +34,23 @@ LEAF(__strncpy_from_user_asm)
 	bnez		v0, .Lfault
 
 FEXPORT(__strncpy_from_user_nocheck_asm)
-	move		v0, zero
-	move		v1, a1
 	.set		noreorder
-1:	EX(lbu, t0, (v1), .Lfault)
+	move		t0, zero
+	move		v1, a1
+1:	EX(lbu, v0, (v1), .Lfault)
 	PTR_ADDIU	v1, 1
 	R10KCBARRIER(0(ra))
-	beqz		t0, 2f
-	 sb		t0, (a0)
-	PTR_ADDIU	v0, 1
-	.set		reorder
-	PTR_ADDIU	a0, 1
-	bne		v0, a2, 1b
-2:	PTR_ADDU	t0, a1, v0
-	xor		t0, a1
-	bltz		t0, .Lfault
+	beqz		v0, 2f
+	 sb		v0, (a0)
+	PTR_ADDIU	t0, 1
+	bne		t0, a2, 1b
+	 PTR_ADDIU	a0, 1
+2:	PTR_ADDU	v0, a1, t0
+	xor		v0, a1
+	bltz		v0, .Lfault
+	 nop
 	jr		ra			# return n
+	move		v0, t0
 	END(__strncpy_from_user_asm)
 
 .Lfault:	li		v0, -EFAULT
-- 
1.7.10
