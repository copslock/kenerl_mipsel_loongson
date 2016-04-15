Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 11:08:56 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:26615 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026637AbcDOJHqhnCwc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2016 11:07:46 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 72348DC7861;
        Fri, 15 Apr 2016 10:07:37 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 10:07:39 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 10:07:39 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        "James Hogan" <james.hogan@imgtec.com>
Subject: [PATCH 3/4] MIPS: Fix MSA assembly with big thread offsets
Date:   Fri, 15 Apr 2016 10:07:25 +0100
Message-ID: <1460711246-4394-4-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1460711246-4394-1-git-send-email-james.hogan@imgtec.com>
References: <1460711246-4394-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52992
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

When lockdep is enabled on a 64-bit kernel the FPR offset into the
thread structure exceeds the maximum range of the MSA ld.d/st.d
instructions. For example THREAD_FPR31 = 4644 (instead of 2448), while
the signed immediate field is only 10 bits with an implicit multiply by
8, giving a maximum offset of 511*8 = 4088.

This isn't a problem when the toolchain doesn't support MSA as the
ld_*/st_* macros perform the addition separately into $1 with [d]addui
which has a 16bit signed immediate field.

Fix the case where the toolchain does support MSA by doing a single
addition of THREAD_FPR0 into $1 with [d]addui, and doing the ld_*/st_*
relative to that.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@imgtec.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/asmmacro.h | 147 ++++++++++++++++++++++-----------------
 1 file changed, 82 insertions(+), 65 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index e689b894353c..637fccab5604 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -496,41 +496,52 @@
 	.endm
 #endif
 
+#ifdef TOOLCHAIN_SUPPORTS_MSA
+#define FPR_BASE_OFFS	THREAD_FPR0
+#define FPR_BASE	$1
+#else
+#define FPR_BASE_OFFS	0
+#define FPR_BASE	\thread
+#endif
+
 	.macro	msa_save_all	thread
-	st_d	0, THREAD_FPR0, \thread
-	st_d	1, THREAD_FPR1, \thread
-	st_d	2, THREAD_FPR2, \thread
-	st_d	3, THREAD_FPR3, \thread
-	st_d	4, THREAD_FPR4, \thread
-	st_d	5, THREAD_FPR5, \thread
-	st_d	6, THREAD_FPR6, \thread
-	st_d	7, THREAD_FPR7, \thread
-	st_d	8, THREAD_FPR8, \thread
-	st_d	9, THREAD_FPR9, \thread
-	st_d	10, THREAD_FPR10, \thread
-	st_d	11, THREAD_FPR11, \thread
-	st_d	12, THREAD_FPR12, \thread
-	st_d	13, THREAD_FPR13, \thread
-	st_d	14, THREAD_FPR14, \thread
-	st_d	15, THREAD_FPR15, \thread
-	st_d	16, THREAD_FPR16, \thread
-	st_d	17, THREAD_FPR17, \thread
-	st_d	18, THREAD_FPR18, \thread
-	st_d	19, THREAD_FPR19, \thread
-	st_d	20, THREAD_FPR20, \thread
-	st_d	21, THREAD_FPR21, \thread
-	st_d	22, THREAD_FPR22, \thread
-	st_d	23, THREAD_FPR23, \thread
-	st_d	24, THREAD_FPR24, \thread
-	st_d	25, THREAD_FPR25, \thread
-	st_d	26, THREAD_FPR26, \thread
-	st_d	27, THREAD_FPR27, \thread
-	st_d	28, THREAD_FPR28, \thread
-	st_d	29, THREAD_FPR29, \thread
-	st_d	30, THREAD_FPR30, \thread
-	st_d	31, THREAD_FPR31, \thread
 	.set	push
 	.set	noat
+#ifdef TOOLCHAIN_SUPPORTS_MSA
+	PTR_ADDU FPR_BASE, \thread, FPR_BASE_OFFS
+#endif
+	st_d	 0, THREAD_FPR0  - FPR_BASE_OFFS, FPR_BASE
+	st_d	 1, THREAD_FPR1  - FPR_BASE_OFFS, FPR_BASE
+	st_d	 2, THREAD_FPR2  - FPR_BASE_OFFS, FPR_BASE
+	st_d	 3, THREAD_FPR3  - FPR_BASE_OFFS, FPR_BASE
+	st_d	 4, THREAD_FPR4  - FPR_BASE_OFFS, FPR_BASE
+	st_d	 5, THREAD_FPR5  - FPR_BASE_OFFS, FPR_BASE
+	st_d	 6, THREAD_FPR6  - FPR_BASE_OFFS, FPR_BASE
+	st_d	 7, THREAD_FPR7  - FPR_BASE_OFFS, FPR_BASE
+	st_d	 8, THREAD_FPR8  - FPR_BASE_OFFS, FPR_BASE
+	st_d	 9, THREAD_FPR9  - FPR_BASE_OFFS, FPR_BASE
+	st_d	10, THREAD_FPR10 - FPR_BASE_OFFS, FPR_BASE
+	st_d	11, THREAD_FPR11 - FPR_BASE_OFFS, FPR_BASE
+	st_d	12, THREAD_FPR12 - FPR_BASE_OFFS, FPR_BASE
+	st_d	13, THREAD_FPR13 - FPR_BASE_OFFS, FPR_BASE
+	st_d	14, THREAD_FPR14 - FPR_BASE_OFFS, FPR_BASE
+	st_d	15, THREAD_FPR15 - FPR_BASE_OFFS, FPR_BASE
+	st_d	16, THREAD_FPR16 - FPR_BASE_OFFS, FPR_BASE
+	st_d	17, THREAD_FPR17 - FPR_BASE_OFFS, FPR_BASE
+	st_d	18, THREAD_FPR18 - FPR_BASE_OFFS, FPR_BASE
+	st_d	19, THREAD_FPR19 - FPR_BASE_OFFS, FPR_BASE
+	st_d	20, THREAD_FPR20 - FPR_BASE_OFFS, FPR_BASE
+	st_d	21, THREAD_FPR21 - FPR_BASE_OFFS, FPR_BASE
+	st_d	22, THREAD_FPR22 - FPR_BASE_OFFS, FPR_BASE
+	st_d	23, THREAD_FPR23 - FPR_BASE_OFFS, FPR_BASE
+	st_d	24, THREAD_FPR24 - FPR_BASE_OFFS, FPR_BASE
+	st_d	25, THREAD_FPR25 - FPR_BASE_OFFS, FPR_BASE
+	st_d	26, THREAD_FPR26 - FPR_BASE_OFFS, FPR_BASE
+	st_d	27, THREAD_FPR27 - FPR_BASE_OFFS, FPR_BASE
+	st_d	28, THREAD_FPR28 - FPR_BASE_OFFS, FPR_BASE
+	st_d	29, THREAD_FPR29 - FPR_BASE_OFFS, FPR_BASE
+	st_d	30, THREAD_FPR30 - FPR_BASE_OFFS, FPR_BASE
+	st_d	31, THREAD_FPR31 - FPR_BASE_OFFS, FPR_BASE
 	SET_HARDFLOAT
 	_cfcmsa	$1, MSA_CSR
 	sw	$1, THREAD_MSA_CSR(\thread)
@@ -543,41 +554,47 @@
 	SET_HARDFLOAT
 	lw	$1, THREAD_MSA_CSR(\thread)
 	_ctcmsa	MSA_CSR, $1
-	.set	pop
-	ld_d	0, THREAD_FPR0, \thread
-	ld_d	1, THREAD_FPR1, \thread
-	ld_d	2, THREAD_FPR2, \thread
-	ld_d	3, THREAD_FPR3, \thread
-	ld_d	4, THREAD_FPR4, \thread
-	ld_d	5, THREAD_FPR5, \thread
-	ld_d	6, THREAD_FPR6, \thread
-	ld_d	7, THREAD_FPR7, \thread
-	ld_d	8, THREAD_FPR8, \thread
-	ld_d	9, THREAD_FPR9, \thread
-	ld_d	10, THREAD_FPR10, \thread
-	ld_d	11, THREAD_FPR11, \thread
-	ld_d	12, THREAD_FPR12, \thread
-	ld_d	13, THREAD_FPR13, \thread
-	ld_d	14, THREAD_FPR14, \thread
-	ld_d	15, THREAD_FPR15, \thread
-	ld_d	16, THREAD_FPR16, \thread
-	ld_d	17, THREAD_FPR17, \thread
-	ld_d	18, THREAD_FPR18, \thread
-	ld_d	19, THREAD_FPR19, \thread
-	ld_d	20, THREAD_FPR20, \thread
-	ld_d	21, THREAD_FPR21, \thread
-	ld_d	22, THREAD_FPR22, \thread
-	ld_d	23, THREAD_FPR23, \thread
-	ld_d	24, THREAD_FPR24, \thread
-	ld_d	25, THREAD_FPR25, \thread
-	ld_d	26, THREAD_FPR26, \thread
-	ld_d	27, THREAD_FPR27, \thread
-	ld_d	28, THREAD_FPR28, \thread
-	ld_d	29, THREAD_FPR29, \thread
-	ld_d	30, THREAD_FPR30, \thread
-	ld_d	31, THREAD_FPR31, \thread
+#ifdef TOOLCHAIN_SUPPORTS_MSA
+	PTR_ADDU FPR_BASE, \thread, FPR_BASE_OFFS
+#endif
+	ld_d	 0, THREAD_FPR0  - FPR_BASE_OFFS, FPR_BASE
+	ld_d	 1, THREAD_FPR1  - FPR_BASE_OFFS, FPR_BASE
+	ld_d	 2, THREAD_FPR2  - FPR_BASE_OFFS, FPR_BASE
+	ld_d	 3, THREAD_FPR3  - FPR_BASE_OFFS, FPR_BASE
+	ld_d	 4, THREAD_FPR4  - FPR_BASE_OFFS, FPR_BASE
+	ld_d	 5, THREAD_FPR5  - FPR_BASE_OFFS, FPR_BASE
+	ld_d	 6, THREAD_FPR6  - FPR_BASE_OFFS, FPR_BASE
+	ld_d	 7, THREAD_FPR7  - FPR_BASE_OFFS, FPR_BASE
+	ld_d	 8, THREAD_FPR8  - FPR_BASE_OFFS, FPR_BASE
+	ld_d	 9, THREAD_FPR9  - FPR_BASE_OFFS, FPR_BASE
+	ld_d	10, THREAD_FPR10 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	11, THREAD_FPR11 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	12, THREAD_FPR12 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	13, THREAD_FPR13 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	14, THREAD_FPR14 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	15, THREAD_FPR15 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	16, THREAD_FPR16 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	17, THREAD_FPR17 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	18, THREAD_FPR18 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	19, THREAD_FPR19 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	20, THREAD_FPR20 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	21, THREAD_FPR21 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	22, THREAD_FPR22 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	23, THREAD_FPR23 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	24, THREAD_FPR24 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	25, THREAD_FPR25 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	26, THREAD_FPR26 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	27, THREAD_FPR27 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	28, THREAD_FPR28 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	29, THREAD_FPR29 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	30, THREAD_FPR30 - FPR_BASE_OFFS, FPR_BASE
+	ld_d	31, THREAD_FPR31 - FPR_BASE_OFFS, FPR_BASE
+	.set pop
 	.endm
 
+#undef FPR_BASE_OFFS
+#undef FPR_BASE
+
 	.macro	msa_init_upper wd
 #ifdef CONFIG_64BIT
 	insert_d \wd, 1
-- 
2.4.10
