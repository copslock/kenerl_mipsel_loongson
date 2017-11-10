Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Nov 2017 21:57:06 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:34379 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992309AbdKJU47n4wps (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Nov 2017 21:56:59 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1401.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Fri, 10 Nov 2017 20:56:47 +0000
Received: from jhogan-linux.mipstec.com (192.168.154.110) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Fri, 10 Nov 2017 12:56:47 -0800
From:   James Hogan <james.hogan@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>, <stable@vger.kernel.org>
Subject: [PATCH] MIPS: Fix odd fp register warnings with MIPS64r2
Date:   Fri, 10 Nov 2017 20:55:19 +0000
Message-ID: <20171110205519.25884-1-james.hogan@mips.com>
X-Mailer: git-send-email 2.14.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1510347407-321457-26328-96686-1
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186801
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60831
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

From: James Hogan <jhogan@kernel.org>

Building 32-bit MIPS64r2 kernels produces warnings like the following
on certain toolchains (such as GNU assembler 2.24.90, but not GNU
assembler 2.28.51) since commit 22b8ba765a72 ("MIPS: Fix MIPS64 FP
save/restore on 32-bit kernels"), due to the exposure of fpu_save_16odd
from fpu_save_double and fpu_restore_16odd from fpu_restore_double:

arch/mips/kernel/r4k_fpu.S:47: Warning: float register should be even, was 1
...
arch/mips/kernel/r4k_fpu.S:59: Warning: float register should be even, was 1
...

This appears to be because .set mips64r2 does not change the FPU ABI to
64-bit when -march=mips64r2 (or e.g. -march=xlp) is provided on the
command line on that toolchain, from the default FPU ABI of 32-bit due
to the -mabi=32. This makes access to the odd FPU registers invalid.

Fix by explicitly changing the FPU ABI with .set fp=64 directives in
fpu_save_16odd and fpu_restore_16odd, and moving the undefine of fp up
in asmmacro.h so fp doesn't turn into $30.

Fixes: 22b8ba765a72 ("MIPS: Fix MIPS64 FP save/restore on 32-bit kernels")
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.0+: 22b8ba765a72: MIPS: Fix MIPS64 FP save/restore on 32-bit kernels
Cc: <stable@vger.kernel.org> # 4.0+
---
 arch/mips/include/asm/asmmacro.h | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index b815d7b3bd27..feb069cbf44e 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -19,6 +19,9 @@
 #include <asm/asmmacro-64.h>
 #endif
 
+/* preprocessor replaces the fp in ".set fp=64" with $30 otherwise */
+#undef fp
+
 /*
  * Helper macros for generating raw instruction encodings.
  */
@@ -105,6 +108,7 @@
 	.macro	fpu_save_16odd thread
 	.set	push
 	.set	mips64r2
+	.set	fp=64
 	SET_HARDFLOAT
 	sdc1	$f1,  THREAD_FPR1(\thread)
 	sdc1	$f3,  THREAD_FPR3(\thread)
@@ -163,6 +167,7 @@
 	.macro	fpu_restore_16odd thread
 	.set	push
 	.set	mips64r2
+	.set	fp=64
 	SET_HARDFLOAT
 	ldc1	$f1,  THREAD_FPR1(\thread)
 	ldc1	$f3,  THREAD_FPR3(\thread)
@@ -234,9 +239,6 @@
 	.endm
 
 #ifdef TOOLCHAIN_SUPPORTS_MSA
-/* preprocessor replaces the fp in ".set fp=64" with $30 otherwise */
-#undef fp
-
 	.macro	_cfcmsa	rd, cs
 	.set	push
 	.set	mips32r2
-- 
2.14.1
