Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 12 Mar 2014 23:40:11 +0100 (CET)
Received: from filtteri2.pp.htv.fi ([213.243.153.185]:53723 "EHLO
        filtteri2.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6870550AbaCLWjud24QF (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 12 Mar 2014 23:39:50 +0100
Received: from localhost (localhost [127.0.0.1])
        by filtteri2.pp.htv.fi (Postfix) with ESMTP id 1EB5C19BD53;
        Thu, 13 Mar 2014 00:39:50 +0200 (EET)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp5.welho.com ([213.243.153.39])
        by localhost (filtteri2.pp.htv.fi [213.243.153.185]) (amavisd-new, port 10024)
        with ESMTP id aACnygKTgY8f; Thu, 13 Mar 2014 00:39:45 +0200 (EET)
Received: from cooljazz.bb.dnainternet.fi (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp5.welho.com (Postfix) with ESMTP id EB8835BC007;
        Thu, 13 Mar 2014 00:39:44 +0200 (EET)
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Ralf Baechle <ralf@linux-mips.org>
Cc:     Paul Burton <paul.burton@imgtec.com>,
        Paul Bolle <pebolle@tiscali.nl>,
        Huacai Chen <chenhc@lemote.com>, Andreas Barth <aba@ayous.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Aaro Koskinen <aaro.koskinen@iki.fi>
Subject: [PATCH RESEND 2/2] MIPS: fpu: fix conflict of register usage
Date:   Thu, 13 Mar 2014 00:41:07 +0200
Message-Id: <1394664067-17712-3-git-send-email-aaro.koskinen@iki.fi>
X-Mailer: git-send-email 1.9.0
In-Reply-To: <1394664067-17712-1-git-send-email-aaro.koskinen@iki.fi>
References: <1394664067-17712-1-git-send-email-aaro.koskinen@iki.fi>
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39458
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

From: Huacai Chen <chenhc@lemote.com>

In _restore_fp_context/_restore_fp_context32, t0 is used for both
CP0_Status and CP1_FCSR. This is a mistake and cause FP exeception on
boot, so fix it.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
Tested-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Tested-by: Andreas Barth <aba@ayous.org>
Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/mips/kernel/r4k_fpu.S | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 841ffc2..73b0ddf 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -146,7 +146,7 @@ LEAF(_save_fp_context32)
  *  - cp1 status/control register
  */
 LEAF(_restore_fp_context)
-	EX	lw t0, SC_FPC_CSR(a0)
+	EX	lw t1, SC_FPC_CSR(a0)
 
 #if defined(CONFIG_64BIT) || defined(CONFIG_CPU_MIPS32_R2)
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
1.9.0
