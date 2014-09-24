Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2014 11:47:36 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:39550 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009557AbaIXJqqQQPPf (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2014 11:46:46 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 128D3E5145401
        for <linux-mips@linux-mips.org>; Wed, 24 Sep 2014 10:46:37 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 24 Sep 2014 10:46:39 +0100
Received: from pburton-laptop.home (192.168.159.158) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 24 Sep
 2014 10:46:38 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 04/11] MIPS: wrap cfcmsa & ctcmsa accesses for toolchains with MSA support
Date:   Wed, 24 Sep 2014 10:45:35 +0100
Message-ID: <1411551942-11153-5-git-send-email-paul.burton@imgtec.com>
X-Mailer: git-send-email 2.0.4
In-Reply-To: <1411551942-11153-1-git-send-email-paul.burton@imgtec.com>
References: <1411551942-11153-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.159.158]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 42759
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
 arch/mips/include/asm/asmmacro.h | 24 ++++++++++++++++++++----
 1 file changed, 20 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 62c4af9..0bbb3aa 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -202,6 +202,22 @@
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
@@ -274,7 +290,7 @@
 	/*
 	 * Temporary until all toolchains in use include MSA support.
 	 */
-	.macro	cfcmsa	rd, cs
+	.macro	_cfcmsa	rd, cs
 	.set	push
 	.set	noat
 	.insn
@@ -283,7 +299,7 @@
 	.set	pop
 	.endm
 
-	.macro	ctcmsa	cd, rs
+	.macro	_ctcmsa	cd, rs
 	.set	push
 	.set	noat
 	move	$1, \rs
@@ -373,7 +389,7 @@
 	st_d	31, THREAD_FPR31, \thread
 	.set	push
 	.set	noat
-	cfcmsa	$1, MSA_CSR
+	_cfcmsa	$1, MSA_CSR
 	sw	$1, THREAD_MSA_CSR(\thread)
 	.set	pop
 	.endm
@@ -382,7 +398,7 @@
 	.set	push
 	.set	noat
 	lw	$1, THREAD_MSA_CSR(\thread)
-	ctcmsa	MSA_CSR, $1
+	_ctcmsa	MSA_CSR, $1
 	.set	pop
 	ld_d	0, THREAD_FPR0, \thread
 	ld_d	1, THREAD_FPR1, \thread
-- 
2.0.4
