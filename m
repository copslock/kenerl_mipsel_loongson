Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 15 Feb 2014 16:14:27 +0100 (CET)
Received: from mail-pd0-f176.google.com ([209.85.192.176]:36157 "EHLO
        mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822478AbaBOPOTKABHV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 15 Feb 2014 16:14:19 +0100
Received: by mail-pd0-f176.google.com with SMTP id w10so13113166pde.7
        for <multiple recipients>; Sat, 15 Feb 2014 07:14:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=phDdca0JBES+A0Fjhv8eRrGKlmfBT42h4UpWP06a+RQ=;
        b=mVjfY0CGfn1RltD6Vz+4M2giz1Ap/7D/j2xrY+8lNO/v82UWqONhunRZfTt1oCEAeU
         n32yz5hH2RXZx3649SbOtIaTC8c+RwFnATBGGOe0G+x3doQuj9odKDFKjB/yRXmOuooV
         2Wg/LpXB/l/hTAUSu0voYlYiihO27Drwp8Gde1PeU7hlRcO4gFAr4ry8GI8Ynj6ytXBO
         YZvGrQ5KCsJVuXyETxMs5AJ58Ld6CG4rZ802pVZlQtB/M0fL61rT+g3tvOILAumublpP
         cYzRfakgZVypN8Gz8xHHaTCOUz9WLBkGTGe/o0XpXiWrFtfZ3QO9zD/atCCxfoMMuXBV
         FoWA==
X-Received: by 10.68.237.228 with SMTP id vf4mr15819418pbc.131.1392477252430;
        Sat, 15 Feb 2014 07:14:12 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id si6sm69132798pab.19.2014.02.15.07.13.59
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Sat, 15 Feb 2014 07:14:11 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 2/2] MIPS: fpu: fix conflict of register usage
Date:   Sat, 15 Feb 2014 23:13:24 +0800
Message-Id: <1392477204-16238-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1392477204-16238-1-git-send-email-chenhc@lemote.com>
References: <1392477204-16238-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39310
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

In _restore_fp_context/_restore_fp_context32, t0 is used for both
CP0_Status and CP1_FCSR. This is a mistake and cause FP exeception on
boot, so fix it.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/kernel/r4k_fpu.S |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 3ab26a5..c68ca61 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -147,7 +147,7 @@ LEAF(_save_fp_context32)
  *  - cp1 status/control register
  */
 LEAF(_restore_fp_context)
-	EX	lw t0, SC_FPC_CSR(a0)
+	EX	lw t1, SC_FPC_CSR(a0)
 
 #if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
 	.set	push
@@ -192,7 +192,7 @@ LEAF(_restore_fp_context)
 	EX	ldc1 $f26, SC_FPREGS+208(a0)
 	EX	ldc1 $f28, SC_FPREGS+224(a0)
 	EX	ldc1 $f30, SC_FPREGS+240(a0)
-	ctc1	t0, fcr31
+	ctc1	t1, fcr31
 	jr	ra
 	 li	v0, 0					# success
 	END(_restore_fp_context)
@@ -200,7 +200,7 @@ LEAF(_restore_fp_context)
 #ifdef CONFIG_MIPS32_COMPAT
 LEAF(_restore_fp_context32)
 	/* Restore an o32 sigcontext.  */
-	EX	lw t0, SC32_FPC_CSR(a0)
+	EX	lw t1, SC32_FPC_CSR(a0)
 
 	mfc0	t0, CP0_STATUS
 	sll	t0, t0, 5
@@ -240,7 +240,7 @@ LEAF(_restore_fp_context32)
 	EX	ldc1 $f26, SC32_FPREGS+208(a0)
 	EX	ldc1 $f28, SC32_FPREGS+224(a0)
 	EX	ldc1 $f30, SC32_FPREGS+240(a0)
-	ctc1	t0, fcr31
+	ctc1	t1, fcr31
 	jr	ra
 	 li	v0, 0					# success
 	END(_restore_fp_context32)
-- 
1.7.7.3
