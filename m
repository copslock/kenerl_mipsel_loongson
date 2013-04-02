Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 03 Apr 2013 01:59:59 +0200 (CEST)
Received: from mail-pb0-f52.google.com ([209.85.160.52]:63852 "EHLO
        mail-pb0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6823608Ab3DBX75yiPrd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 3 Apr 2013 01:59:57 +0200
Received: by mail-pb0-f52.google.com with SMTP id mc8so516956pbc.11
        for <multiple recipients>; Tue, 02 Apr 2013 16:59:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=j1d6fDnlHTFk9Fyfu+Z17Xg8mjlzrtNNYTRePUgb+vQ=;
        b=WmsUBgdQwjBpia+dQ/ges+reBn4pFGM4iwWkhGMFdee5TP3sgn+l6Sp6GtJaGZl1dC
         aA/GCUCCPEsx7q2tWsDw1Ta+3x0iHKUmO5HiuUn4b5pg9tZgH/pwUpnOIHc6CwOFdh/E
         fkSHjl4TOevRKfJm5cTiSzvqD5Fq+SoXJXWlsKLO//Qqt+a1sUtfFnTJcYlf67uDx/Kl
         +SQAF0S+WyEwVkKu0srE+bka/kAF+MHf59h/r7PSVkhKd3WCsRyt2fPFRUsjcvPKHO18
         xB6irQjmbinLtM+A3tRCZhCSMAq5AVQSMPm8BAs3yhqS4+qxG1aJp6ul6wVVuolVcoJY
         BE1Q==
X-Received: by 10.68.116.169 with SMTP id jx9mr26952092pbb.94.1364947190797;
        Tue, 02 Apr 2013 16:59:50 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPS id gl9sm2800193pbc.44.2013.04.02.16.59.44
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 02 Apr 2013 16:59:49 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r32NxcPf025442;
        Tue, 2 Apr 2013 16:59:38 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r32NxWbu025441;
        Tue, 2 Apr 2013 16:59:32 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>,
        Al Cooper <alcooperx@gmail.com>, viric@viric.name,
        stable@vger.kernel.org.#.3.8.x
Subject: [PATCH] MIPS: Unbreak function tracer for 64-bit kernel.
Date:   Tue,  2 Apr 2013 16:59:29 -0700
Message-Id: <1364947169-25408-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
X-archive-position: 36004
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
Return-Path: <linux-mips-bounce@linux-mips.org>

From: David Daney <david.daney@cavium.com>

commit 58b69401c797 (MIPS: Function tracer: Fix broken function
tracing) completely broke the function tracer for 64-bit kernels.  The
symptom is a system hang very early in the boot process.

The fix: Remove/fix $sp adjustments for 64-bit case.

Signed-off-by: David Daney <david.daney@cavium.com>
Cc: Al Cooper <alcooperx@gmail.com>
Cc: viric@viric.name
Cc: stable@vger.kernel.org # 3.8.x
---
 arch/mips/kernel/mcount.S | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
index 1658676..33d0671 100644
--- a/arch/mips/kernel/mcount.S
+++ b/arch/mips/kernel/mcount.S
@@ -46,10 +46,9 @@
 	PTR_L	a5, PT_R9(sp)
 	PTR_L	a6, PT_R10(sp)
 	PTR_L	a7, PT_R11(sp)
-#else
-	PTR_ADDIU	sp, PT_SIZE
 #endif
-.endm
+	PTR_ADDIU	sp, PT_SIZE
+	.endm
 
 	.macro RETURN_BACK
 	jr ra
@@ -68,7 +67,11 @@ NESTED(ftrace_caller, PT_SIZE, ra)
 	.globl _mcount
 _mcount:
 	b	ftrace_stub
-	addiu sp,sp,8
+#ifdef CONFIG_32BIT
+	 addiu sp,sp,8
+#else
+	 nop
+#endif
 
 	/* When tracing is activated, it calls ftrace_caller+8 (aka here) */
 	lw	t1, function_trace_stop
-- 
1.7.11.7
