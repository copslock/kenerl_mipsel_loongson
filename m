Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Feb 2014 15:32:27 +0100 (CET)
Received: from mail-pb0-f51.google.com ([209.85.160.51]:42299 "EHLO
        mail-pb0-f51.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6831298AbaBGOcNfvdd0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 7 Feb 2014 15:32:13 +0100
Received: by mail-pb0-f51.google.com with SMTP id un15so3318339pbc.10
        for <multiple recipients>; Fri, 07 Feb 2014 06:32:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=psmOotXvUueHLwKnvOfYZn6X5/rklD2gKURvzeYBFrU=;
        b=qzW0bcY6awMwd992lKCrUYMMQOZvg+ZerJFJQdGaqgO2+uowSSrBXi0fzK0L/3DViM
         wLqq9mWCGZMfG43OXveD+Viy6SA+Pi/D0+5wLZt7o+pUN1pzyrpPL7u9MyxB7QN/wqp1
         Yjy8LHGNydupNVXs+Inp1STsgM6CmDDPZCDGPiJkdjlhzq5tTloHC96Fmu8cL1n0hf50
         3sVM6eltKLvWNXzp7qn3JWw13vv6edUkXEf7ad1yOwMGozHNfog/ptaYJzJ3c8lN0Eeu
         baKWw/36IykN+yvhVStnQFECgNMpPGoET3aAEtbYQrgPb2oiJN6wl5Kpfec5mmgOp9iU
         CVEg==
X-Received: by 10.68.0.99 with SMTP id 3mr20050868pbd.68.1391783527033;
        Fri, 07 Feb 2014 06:32:07 -0800 (PST)
Received: from localhost.localdomain ([222.92.8.142])
        by mx.google.com with ESMTPSA id mo2sm14257612pbc.6.2014.02.07.06.31.57
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 07 Feb 2014 06:32:06 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 2/2] MIPS: fpu: fix conflict of register usage
Date:   Fri,  7 Feb 2014 22:31:33 +0800
Message-Id: <1391783493-6806-2-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 1.7.7.3
In-Reply-To: <1391783493-6806-1-git-send-email-chenhc@lemote.com>
References: <1391783493-6806-1-git-send-email-chenhc@lemote.com>
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39231
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
index 253b2fb..40bc159 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -146,7 +146,7 @@ LEAF(_save_fp_context32)
  *  - cp1 status/control register
  */
 LEAF(_restore_fp_context)
-	EX	lw t0, SC_FPC_CSR(a0)
+	EX	lw t1, SC_FPC_CSR(a0)
 
 #if defined(CONFIG_64BIT) || defined(CONFIG_MIPS32_R2)
 	.set	push
@@ -191,7 +191,7 @@ LEAF(_restore_fp_context)
 	EX	ldc1 $f26, SC_FPREGS+208(a0)
 	EX	ldc1 $f28, SC_FPREGS+224(a0)
 	EX	ldc1 $f30, SC_FPREGS+240(a0)
-	ctc1	t0, fcr31
+	ctc1	t1, fcr31
 	jr	ra
 	 li	v0, 0					# success
 	END(_restore_fp_context)
@@ -199,7 +199,7 @@ LEAF(_restore_fp_context)
 #ifdef CONFIG_MIPS32_COMPAT
 LEAF(_restore_fp_context32)
 	/* Restore an o32 sigcontext.  */
-	EX	lw t0, SC32_FPC_CSR(a0)
+	EX	lw t1, SC32_FPC_CSR(a0)
 
 	mfc0	t0, CP0_STATUS
 	sll	t0, t0, 5
@@ -239,7 +239,7 @@ LEAF(_restore_fp_context32)
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
