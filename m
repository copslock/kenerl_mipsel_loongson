Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 May 2012 17:33:30 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:55414 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903647Ab2EUPd0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 May 2012 17:33:26 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SWUbo-0003Q6-KS; Mon, 21 May 2012 10:33:20 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>
Subject: [PATCH] MIPS: Remove dead code related to 1004K oprofile support.
Date:   Mon, 21 May 2012 10:33:16 -0500
Message-Id: <1337614396-28998-1-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.10
X-archive-position: 33401
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/oprofile/op_model_mipsxx.c |    6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/oprofile/op_model_mipsxx.c b/arch/mips/oprofile/op_model_mipsxx.c
index ef4e87f..a86e93e 100644
--- a/arch/mips/oprofile/op_model_mipsxx.c
+++ b/arch/mips/oprofile/op_model_mipsxx.c
@@ -338,12 +338,6 @@ static int __init mipsxx_init(void)
 		break;
 
 	case CPU_1004K:
-#if 0
-		/* FIXME: report as 34K for now */
-		op_model_mipsxx_ops.cpu_type = "mips/1004K";
-		break;
-#endif
-
 	case CPU_34K:
 		op_model_mipsxx_ops.cpu_type = "mips/34K";
 		break;
-- 
1.7.10
