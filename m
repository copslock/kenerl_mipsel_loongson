Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Jun 2016 00:28:58 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:32948 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042515AbcFEWY60LSt1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Jun 2016 00:24:58 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 707BD956;
        Sun,  5 Jun 2016 22:24:52 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, "Maciej W. Rozycki" <macro@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.5 003/128] MIPS: MSA: Fix a link error on `_init_msa_upper with older GCC
Date:   Sun,  5 Jun 2016 15:22:38 -0700
Message-Id: <20160605222321.319520632@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160605222321.183131188@linuxfoundation.org>
References: <20160605222321.183131188@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53873
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

4.5-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Maciej W. Rozycki <macro@imgtec.com>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/msa.h |   13 +++++++++++++
 arch/mips/kernel/traps.c    |    6 +++---
 2 files changed, 16 insertions(+), 3 deletions(-)

--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -147,6 +147,19 @@ static inline void restore_msa(struct ta
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
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1242,7 +1242,7 @@ static int enable_restore_fp_context(int
 		err = init_fpu();
 		if (msa && !err) {
 			enable_msa();
-			_init_msa_upper();
+			init_msa_upper();
 			set_thread_flag(TIF_USEDMSA);
 			set_thread_flag(TIF_MSA_CTX_LIVE);
 		}
@@ -1305,7 +1305,7 @@ static int enable_restore_fp_context(int
 	 */
 	prior_msa = test_and_set_thread_flag(TIF_MSA_CTX_LIVE);
 	if (!prior_msa && was_fpu_owner) {
-		_init_msa_upper();
+		init_msa_upper();
 
 		goto out;
 	}
@@ -1322,7 +1322,7 @@ static int enable_restore_fp_context(int
 		 * of each vector register such that it cannot see data left
 		 * behind by another task.
 		 */
-		_init_msa_upper();
+		init_msa_upper();
 	} else {
 		/* We need to restore the vector context. */
 		restore_msa(current);
