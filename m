Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Dec 2012 06:10:07 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:60341 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824766Ab2LGFJ3XWfXa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Dec 2012 06:09:29 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1Tgq8E-0007MA-Fn; Thu, 06 Dec 2012 23:05:50 -0600
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>, ralf@linux-mips.org
Subject: [PATCH v99,12/13] MIPS: microMIPS: Optimise 'strlen' core library function.
Date:   Thu,  6 Dec 2012 23:05:36 -0600
Message-Id: <1354856737-28678-13-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1354856737-28678-1-git-send-email-sjhill@mips.com>
References: <1354856737-28678-1-git-send-email-sjhill@mips.com>
X-archive-position: 35224
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

Optimise 'strlen' to use microMIPS instructions and/or optimisations
for binary size reduction. When the microMIPS ISA is not being used,
the library function compiles to the original binary code.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/lib/strlen_user.S |    9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/arch/mips/lib/strlen_user.S b/arch/mips/lib/strlen_user.S
index fdbb970..e362dcd 100644
--- a/arch/mips/lib/strlen_user.S
+++ b/arch/mips/lib/strlen_user.S
@@ -3,8 +3,9 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (c) 1996, 1998, 1999, 2004 by Ralf Baechle
- * Copyright (c) 1999 Silicon Graphics, Inc.
+ * Copyright (C) 1996, 1998, 1999, 2004 by Ralf Baechle
+ * Copyright (C) 1999 Silicon Graphics, Inc.
+ * Copyright (C) 2011 MIPS Technologies, Inc.
  */
 #include <asm/asm.h>
 #include <asm/asm-offsets.h>
@@ -28,9 +29,9 @@ LEAF(__strlen_user_asm)
 
 FEXPORT(__strlen_user_nocheck_asm)
 	move		v0, a0
-1:	EX(lb, t0, (v0), .Lfault)
+1:	EX(lbu, v1, (v0), .Lfault)
 	PTR_ADDIU	v0, 1
-	bnez		t0, 1b
+	bnez		v1, 1b
 	PTR_SUBU	v0, a0
 	jr		ra
 	END(__strlen_user_asm)
-- 
1.7.9.5
