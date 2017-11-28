Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 11:34:30 +0100 (CET)
Received: from mail.linuxfoundation.org ([140.211.169.12]:33558 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992186AbdK1KeEH5-m- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 11:34:04 +0100
Received: from localhost (LFbn-1-12253-150.w90-92.abo.wanadoo.fr [90.92.67.150])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 2C710AF3;
        Tue, 28 Nov 2017 10:33:57 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
Subject: [PATCH 4.9 024/138] MIPS: Fix odd fp register warnings with MIPS64r2
Date:   Tue, 28 Nov 2017 11:22:05 +0100
Message-Id: <20171128100546.489662154@linuxfoundation.org>
X-Mailer: git-send-email 2.15.0
In-Reply-To: <20171128100544.706504901@linuxfoundation.org>
References: <20171128100544.706504901@linuxfoundation.org>
User-Agent: quilt/0.65
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61122
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gregkh@linuxfoundation.org
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

4.9-stable review patch.  If anyone has any objections, please let me know.

------------------

From: James Hogan <jhogan@kernel.org>

commit c7fd89a6407ea3a44a2a2fa12d290162c42499c4 upstream.

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
Patchwork: https://patchwork.linux-mips.org/patch/17656/
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/asmmacro.h |    8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

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
