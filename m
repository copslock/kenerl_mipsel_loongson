Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Sep 2014 11:46:59 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:16526 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27007197AbaIXJqkxJ8FN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Sep 2014 11:46:40 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id A511C7E3DE351
        for <linux-mips@linux-mips.org>; Wed, 24 Sep 2014 10:46:31 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Wed, 24 Sep 2014 10:46:34 +0100
Received: from pburton-laptop.home (192.168.159.158) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Wed, 24 Sep
 2014 10:46:31 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>
Subject: [PATCH 02/11] MIPS: assume at as source/dest of MSA copy/insert instructions
Date:   Wed, 24 Sep 2014 10:45:33 +0100
Message-ID: <1411551942-11153-3-git-send-email-paul.burton@imgtec.com>
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
X-archive-position: 42757
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

Assuming at ($1) as the source or destination register of copy or
insert instructions:

  - Simplifies the macros providing those instructions for toolchains
    without MSA support.

  - Avoids an unnecessary move instruction when at is used as the source
    or destination register anyway.

  - Is sufficient for the uses to be introduced in the kernel by a
    subsequent patch.

Note that due to a patch ordering snafu on my part this also fixes the
currently broken build with MSA support enabled. The build has been
broken since commit c9017757c532 "MIPS: init upper 64b of vector
registers when MSA is first used", which this patch should have
preceeded.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
---
 arch/mips/include/asm/asmmacro.h | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index f6293ef..7e4aaeb 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -218,35 +218,35 @@
 	.set	pop
 	.endm
 
-	.macro	copy_u_w	rd, ws, n
+	.macro	copy_u_w	ws, n
 	.set	push
 	.set	mips32r2
 	.set	msa
-	copy_u.w \rd, $w\ws[\n]
+	copy_u.w $1, $w\ws[\n]
 	.set	pop
 	.endm
 
-	.macro	copy_u_d	rd, ws, n
+	.macro	copy_u_d	ws, n
 	.set	push
 	.set	mips64r2
 	.set	msa
-	copy_u.d \rd, $w\ws[\n]
+	copy_u.d $1, $w\ws[\n]
 	.set	pop
 	.endm
 
-	.macro	insert_w	wd, n, rs
+	.macro	insert_w	wd, n
 	.set	push
 	.set	mips32r2
 	.set	msa
-	insert.w $w\wd[\n], \rs
+	insert.w $w\wd[\n], $1
 	.set	pop
 	.endm
 
-	.macro	insert_d	wd, n, rs
+	.macro	insert_d	wd, n
 	.set	push
 	.set	mips64r2
 	.set	msa
-	insert.d $w\wd[\n], \rs
+	insert.d $w\wd[\n], $1
 	.set	pop
 	.endm
 #else
@@ -307,36 +307,32 @@
 	.set	pop
 	.endm
 
-	.macro	copy_u_w	rd, ws, n
+	.macro	copy_u_w	ws, n
 	.set	push
 	.set	noat
 	.insn
 	.word	COPY_UW_MSA_INSN | (\n << 16) | (\ws << 11)
-	move	\rd, $1
 	.set	pop
 	.endm
 
-	.macro	copy_u_d	rd, ws, n
+	.macro	copy_u_d	ws, n
 	.set	push
 	.set	noat
 	.insn
 	.word	COPY_UD_MSA_INSN | (\n << 16) | (\ws << 11)
-	move	\rd, $1
 	.set	pop
 	.endm
 
-	.macro	insert_w	wd, n, rs
+	.macro	insert_w	wd, n
 	.set	push
 	.set	noat
-	move	$1, \rs
 	.word	INSERT_W_MSA_INSN | (\n << 16) | (\wd << 6)
 	.set	pop
 	.endm
 
-	.macro	insert_d	wd, n, rs
+	.macro	insert_d	wd, n
 	.set	push
 	.set	noat
-	move	$1, \rs
 	.word	INSERT_D_MSA_INSN | (\n << 16) | (\wd << 6)
 	.set	pop
 	.endm
-- 
2.0.4
