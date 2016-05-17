Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 May 2016 07:12:52 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:52645 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029438AbcEQFMpJ9ii6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 May 2016 07:12:45 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id B4974BD026E46;
        Tue, 17 May 2016 06:12:36 +0100 (IST)
Received: from [10.20.78.207] (10.20.78.207) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Tue, 17 May 2016
 06:12:37 +0100
Date:   Tue, 17 May 2016 06:12:27 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>
Subject: [PATCH] MIPS: MSA: Fix a link error on `_init_msa_upper' with older
 GCC
Message-ID: <alpine.DEB.2.00.1605162325170.6794@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.207]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53478
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

Signed-off-by: Maciej W. Rozycki <macro@imgtec.com>
Cc: stable@vger.kernel.org # v3.16+
---
 I have verified that this patch removes the build failure and if applied 
to a build made with a newer version of GCC which copes regardless it 
makes no change to code generated in a !CONFIG_CPU_HAS_MSA configuration, 
and in a CONFIG_CPU_HAS_MSA one it only makes this change (haha):

--- a/vmlinux.dump	2016-05-17 01:01:03.655891000 +0100
+++ b/vmlinux.dump	2016-05-17 02:11:49.264564000 +0100
@@ -12880,7 +12880,7 @@
 8400cdf4 <enable_restore_fp_context+0x414> 00031e82 	srl	v1,v1,0x1a
 8400cdf8 <enable_restore_fp_context+0x418> 38630001 	xori	v1,v1,0x1
 8400cdfc <enable_restore_fp_context+0x41c> 30630001 	andi	v1,v1,0x1
-8400ce00 <enable_restore_fp_context+0x420> 10e300ea 	beq	a3,v1,8400d1ac <enable_restore_fp_context+0x7cc>
+8400ce00 <enable_restore_fp_context+0x420> 106700ea 	beq	v1,a3,8400d1ac <enable_restore_fp_context+0x7cc>
 8400ce04 <enable_restore_fp_context+0x424> 3c062000 	lui	a2,0x2000
 8400ce08 <enable_restore_fp_context+0x428> 8c430000 	lw	v1,0(v0)
 8400ce0c <enable_restore_fp_context+0x42c> 30a50001 	andi	a1,a1,0x1

Therefore please apply and backport as applicable.

  Maciej

linux-mips-init-msa-upper.diff
Index: linux-sfr-msa/arch/mips/include/asm/msa.h
===================================================================
--- linux-sfr-msa.orig/arch/mips/include/asm/msa.h	2016-05-17 01:53:09.316108000 +0100
+++ linux-sfr-msa/arch/mips/include/asm/msa.h	2016-05-17 01:54:29.684642000 +0100
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
Index: linux-sfr-msa/arch/mips/kernel/traps.c
===================================================================
--- linux-sfr-msa.orig/arch/mips/kernel/traps.c	2016-05-17 01:53:09.319110000 +0100
+++ linux-sfr-msa/arch/mips/kernel/traps.c	2016-05-17 01:54:29.711642000 +0100
@@ -1246,7 +1246,7 @@ static int enable_restore_fp_context(int
 		err = init_fpu();
 		if (msa && !err) {
 			enable_msa();
-			_init_msa_upper();
+			init_msa_upper();
 			set_thread_flag(TIF_USEDMSA);
 			set_thread_flag(TIF_MSA_CTX_LIVE);
 		}
@@ -1309,7 +1309,7 @@ static int enable_restore_fp_context(int
 	 */
 	prior_msa = test_and_set_thread_flag(TIF_MSA_CTX_LIVE);
 	if (!prior_msa && was_fpu_owner) {
-		_init_msa_upper();
+		init_msa_upper();
 
 		goto out;
 	}
@@ -1326,7 +1326,7 @@ static int enable_restore_fp_context(int
 		 * of each vector register such that it cannot see data left
 		 * behind by another task.
 		 */
-		_init_msa_upper();
+		init_msa_upper();
 	} else {
 		/* We need to restore the vector context. */
 		restore_msa(current);
