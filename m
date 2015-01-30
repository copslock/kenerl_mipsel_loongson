Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 30 Jan 2015 13:11:15 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60836 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012269AbbA3MLOBymKx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 30 Jan 2015 13:11:14 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 33F93A749DFC6
        for <linux-mips@linux-mips.org>; Fri, 30 Jan 2015 12:11:06 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 30 Jan 2015 12:11:08 +0000
Received: from localhost (192.168.159.167) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 30 Jan
 2015 12:11:04 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH v2 04/10] MIPS: wrap cfcmsa & ctcmsa accesses for toolchains with MSA support
Date:   Fri, 30 Jan 2015 12:09:33 +0000
Message-ID: <1422619779-9940-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.2.2
In-Reply-To: <1422619779-9940-1-git-send-email-paul.burton@imgtec.com>
References: <1422619779-9940-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.167]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45566
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

Uses of the cfcmsa & ctcmsa instructions were not being wrapped by a
macro in the case where the toolchain supports MSA, since the arguments
exactly match a typical use of the instructions. However using current
toolchains this leads to errors such as:

  arch/mips/kernel/genex.S:437: Error: opcode not supported on this processor: mips32r2 (mips32r2) `cfcmsa $5,1'

Thus uses of the instructions must be in the context of a ".set msa"
directive, however doing that from the users of the instructions would
be messy due to the possibility that the toolchain does not support
MSA. Fix this by renaming the macros (prepending an underscore) in order
to avoid recursion when attempting to emit the instructions, and provide
implementations for the TOOLCHAIN_SUPPORTS_MSA case which ".set msa" as
appropriate.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
Changes in v2:
  - Rebase atop v3.19-rc6.
---
 arch/mips/include/asm/asmmacro.h | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index d2231d6..65c631d 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -209,6 +209,22 @@
 	.endm
 
 #ifdef TOOLCHAIN_SUPPORTS_MSA
+	.macro	_cfcmsa	rd, cs
+	.set	push
+	.set	mips32r2
+	.set	msa
+	cfcmsa	\rd, $\cs
+	.set	pop
+	.endm
+
+	.macro	_ctcmsa	cd, rs
+	.set	push
+	.set	mips32r2
+	.set	msa
+	ctcmsa	$\cd, \rs
+	.set	pop
+	.endm
+
 	.macro	ld_d	wd, off, base
 	.set	push
 	.set	mips32r2
@@ -281,7 +297,7 @@
 	/*
 	 * Temporary until all toolchains in use include MSA support.
 	 */
-	.macro	cfcmsa	rd, cs
+	.macro	_cfcmsa	rd, cs
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
@@ -291,7 +307,7 @@
 	.set	pop
 	.endm
 
-	.macro	ctcmsa	cd, rs
+	.macro	_ctcmsa	cd, rs
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
@@ -389,7 +405,7 @@
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
-	cfcmsa	$1, MSA_CSR
+	_cfcmsa	$1, MSA_CSR
 	sw	$1, THREAD_MSA_CSR(\thread)
 	.set	pop
 	.endm
@@ -399,7 +415,7 @@
 	.set	noat
 	SET_HARDFLOAT
 	lw	$1, THREAD_MSA_CSR(\thread)
-	ctcmsa	MSA_CSR, $1
+	_ctcmsa	MSA_CSR, $1
 	.set	pop
 	ld_d	0, THREAD_FPR0, \thread
 	ld_d	1, THREAD_FPR1, \thread
-- 
2.2.2
