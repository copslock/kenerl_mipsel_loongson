Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 24 May 2012 22:57:39 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:42852 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903739Ab2EXU4B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 24 May 2012 22:56:01 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SXf4d-0003sB-FG; Thu, 24 May 2012 15:55:55 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH 4/4] MIPS: Optimise core library function 'strnlen' for microMIPS.
Date:   Thu, 24 May 2012 15:55:42 -0500
Message-Id: <1337892942-24492-5-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
In-Reply-To: <1337892942-24492-1-git-send-email-sjhill@mips.com>
References: <1337892942-24492-1-git-send-email-sjhill@mips.com>
X-archive-position: 33464
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

Optimise 'strnlen' to use microMIPS instructions and/or optimisations
for binary size reduction. When the microMIPS ISA is not being used,
the library function compiles to the original binary code.

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/lib/strnlen_user.S |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/lib/strnlen_user.S b/arch/mips/lib/strnlen_user.S
index 6445716..c5bdf8b 100644
--- a/arch/mips/lib/strnlen_user.S
+++ b/arch/mips/lib/strnlen_user.S
@@ -35,7 +35,7 @@ FEXPORT(__strnlen_user_nocheck_asm)
 	PTR_ADDU	a1, a0			# stop pointer
 1:	beq		v0, a1, 1f		# limit reached?
 	EX(lb, t0, (v0), .Lfault)
-	PTR_ADDU	v0, 1
+	PTR_ADDIU	v0, 1
 	bnez		t0, 1b
 1:	PTR_SUBU	v0, a0
 	jr		ra
-- 
1.7.10
