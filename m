Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2012 22:57:16 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:42850 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903738Ab2EXU4B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 May 2012 22:56:01 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SXf4d-0003sB-1e; Thu, 24 May 2012 15:55:55 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 3/4] MIPS: Optimise core library function 'strlen' for microMIPS.
Date:   Thu, 24 May 2012 15:55:41 -0500
Message-Id: <1337892942-24492-4-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1337892942-24492-1-git-send-email-sjhill@mips.com>
References: <1337892942-24492-1-git-send-email-sjhill@mips.com>
X-archive-position: 33463
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
1.7.10
