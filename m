Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Jun 2016 23:24:08 +0200 (CEST)
Received: from youngberry.canonical.com ([91.189.89.112]:34939 "EHLO
        youngberry.canonical.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27034247AbcFIVTHgfThE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 9 Jun 2016 23:19:07 +0200
Received: from 1.general.kamal.us.vpn ([10.172.68.52] helo=fourier)
        by youngberry.canonical.com with esmtpsa (TLS1.0:RSA_AES_128_CBC_SHA1:16)
        (Exim 4.76)
        (envelope-from <kamal@canonical.com>)
        id 1bB7M2-0005NN-Sf; Thu, 09 Jun 2016 21:19:07 +0000
Received: from kamal by fourier with local (Exim 4.86_2)
        (envelope-from <kamal@whence.com>)
        id 1bB7M0-0006DC-6f; Thu, 09 Jun 2016 14:19:04 -0700
From:   Kamal Mostafa <kamal@canonical.com>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        kernel-team@lists.ubuntu.com
Cc:     "Maciej W . Rozycki" <macro@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Kamal Mostafa <kamal@canonical.com>
Subject: [PATCH 4.2.y-ckt 110/206] MIPS: MSA: Fix a link error on `_init_msa_upper' with older GCC
Date:   Thu,  9 Jun 2016 14:15:19 -0700
Message-Id: <1465507015-23052-111-git-send-email-kamal@canonical.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1465507015-23052-1-git-send-email-kamal@canonical.com>
References: <1465507015-23052-1-git-send-email-kamal@canonical.com>
X-Extended-Stable: 4.2
Return-Path: <kamal@canonical.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53996
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kamal@canonical.com
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

4.2.8-ckt12 -stable review patch.  If anyone has any objections, please let me know.

---8<------------------------------------------------------------

From: "Maciej W. Rozycki" <macro@imgtec.com>

commit e49d38488515057dba8f0c2ba4cfde5be4a7281f upstream.

Fix a build regression from commit c9017757c532 ("MIPS: init upper 64b
of vector registers when MSA is first used"):

arch/mips/built-in.o: In function `enable_restore_fp_context':
traps.c:(.text+0xbb90): undefined reference to `_init_msa_upper'
traps.c:(.text+0xbb90): relocation truncated to fit: R_MIPS_26 against `_init_msa_upper'
traps.c:(.text+0xbef0): undefined reference to `_init_msa_upper'
traps.c:(.text+0xbef0): relocation truncated to fit: R_MIPS_26 against `_init_msa_upper'

to !CONFIG_CPU_HAS_MSA configurations with older GCC versions, which are
unable to figure out that calls to `_init_msa_upper' are indeed dead.
Of the many ways to tackle this failure choose the approach we have
already taken in `thread_msa_context_live'.

[ralf@linux-mips.org: Drop patch segment to junk file.]

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13271/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Kamal Mostafa <kamal@canonical.com>
---
 arch/mips/include/asm/msa.h | 13 +++++++++++++
 arch/mips/kernel/traps.c    |  6 +++---
 2 files changed, 16 insertions(+), 3 deletions(-)

diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index af5638b..38bbeda 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -67,6 +67,19 @@ static inline void restore_msa(struct task_struct *t)
 		_restore_msa(t);
 }
 
+static inline void init_msa_upper(void)
+{
+	/*
+	 * Check cpu_has_msa only if it's a constant. This will allow the
+	 * compiler to optimise out code for CPUs without MSA without adding
+	 * an extra redundant check for CPUs with MSA.
+	 */
+	if (__builtin_constant_p(cpu_has_msa) && !cpu_has_msa)
+		return;
+
+	_init_msa_upper();
+}
+
 #ifdef TOOLCHAIN_SUPPORTS_MSA
 
 #define __BUILD_MSA_CTL_REG(name, cs)				\
diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
index 86454f5..4f1d297 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1229,7 +1229,7 @@ static int enable_restore_fp_context(int msa)
 		err = init_fpu();
 		if (msa && !err) {
 			enable_msa();
-			_init_msa_upper();
+			init_msa_upper();
 			set_thread_flag(TIF_USEDMSA);
 			set_thread_flag(TIF_MSA_CTX_LIVE);
 		}
@@ -1292,7 +1292,7 @@ static int enable_restore_fp_context(int msa)
 	 */
 	prior_msa = test_and_set_thread_flag(TIF_MSA_CTX_LIVE);
 	if (!prior_msa && was_fpu_owner) {
-		_init_msa_upper();
+		init_msa_upper();
 
 		goto out;
 	}
@@ -1309,7 +1309,7 @@ static int enable_restore_fp_context(int msa)
 		 * of each vector register such that it cannot see data left
 		 * behind by another task.
 		 */
-		_init_msa_upper();
+		init_msa_upper();
 	} else {
 		/* We need to restore the vector context. */
 		restore_msa(current);
-- 
2.7.4
