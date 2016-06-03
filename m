Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 03 Jun 2016 23:43:11 +0200 (CEST)
Received: from aserp1040.oracle.com ([141.146.126.69]:40194 "EHLO
        aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27042106AbcFCVjKEq8V4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 3 Jun 2016 23:39:10 +0200
Received: from userv0021.oracle.com (userv0021.oracle.com [156.151.31.71])
        by aserp1040.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id u53Lcx0J011111
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 3 Jun 2016 21:38:59 GMT
Received: from aserv0121.oracle.com (aserv0121.oracle.com [141.146.126.235])
        by userv0021.oracle.com (8.13.8/8.13.8) with ESMTP id u53LcwBF012140
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=OK);
        Fri, 3 Jun 2016 21:38:59 GMT
Received: from abhmp0005.oracle.com (abhmp0005.oracle.com [141.146.116.11])
        by aserv0121.oracle.com (8.13.8/8.13.8) with ESMTP id u53LcvSE023137;
        Fri, 3 Jun 2016 21:38:58 GMT
Received: from lappy.us.oracle.com (/10.154.190.197)
        by default (Oracle Beehive Gateway v4.0)
        with ESMTP ; Fri, 03 Jun 2016 14:38:57 -0700
From:   Sasha Levin <sasha.levin@oracle.com>
To:     stable@vger.kernel.org, stable-commits@vger.kernel.org
Cc:     "Maciej W. Rozycki" <macro@imgtec.com>, linux-mips@linux-mips.org,
        Ralf Baechle <ralf@linux-mips.org>,
        Sasha Levin <sasha.levin@oracle.com>
Subject: [added to the 4.1 stable tree] MIPS: MSA: Fix a link error on `_init_msa_upper' with older GCC
Date:   Fri,  3 Jun 2016 17:36:38 -0400
Message-Id: <1464989831-16666-103-git-send-email-sasha.levin@oracle.com>
X-Mailer: git-send-email 2.5.0
In-Reply-To: <1464989831-16666-1-git-send-email-sasha.levin@oracle.com>
References: <1464989831-16666-1-git-send-email-sasha.levin@oracle.com>
X-Source-IP: userv0021.oracle.com [156.151.31.71]
Return-Path: <sasha.levin@oracle.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53797
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sasha.levin@oracle.com
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

From: "Maciej W. Rozycki" <macro@imgtec.com>

This patch has been added to the 4.1 stable tree. If you have any
objections, please let us know.

===============

[ Upstream commit e49d38488515057dba8f0c2ba4cfde5be4a7281f ]

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
Cc: stable@vger.kernel.org # v3.16+
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13271/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Sasha Levin <sasha.levin@oracle.com>
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
index b274541..7440395 100644
--- a/arch/mips/kernel/traps.c
+++ b/arch/mips/kernel/traps.c
@@ -1228,7 +1228,7 @@ static int enable_restore_fp_context(int msa)
 		err = init_fpu();
 		if (msa && !err) {
 			enable_msa();
-			_init_msa_upper();
+			init_msa_upper();
 			set_thread_flag(TIF_USEDMSA);
 			set_thread_flag(TIF_MSA_CTX_LIVE);
 		}
@@ -1291,7 +1291,7 @@ static int enable_restore_fp_context(int msa)
 	 */
 	prior_msa = test_and_set_thread_flag(TIF_MSA_CTX_LIVE);
 	if (!prior_msa && was_fpu_owner) {
-		_init_msa_upper();
+		init_msa_upper();
 
 		goto out;
 	}
@@ -1308,7 +1308,7 @@ static int enable_restore_fp_context(int msa)
 		 * of each vector register such that it cannot see data left
 		 * behind by another task.
 		 */
-		_init_msa_upper();
+		init_msa_upper();
 	} else {
 		/* We need to restore the vector context. */
 		restore_msa(current);
-- 
2.5.0
