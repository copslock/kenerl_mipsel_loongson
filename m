Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2016 11:08:02 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:28659 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27026632AbcDOJHpPM5vc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2016 11:07:45 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 8A90BD9C0FA68;
        Fri, 15 Apr 2016 10:07:35 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 10:07:38 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 15 Apr 2016 10:07:37 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, Paul Burton <paul.burton@imgtec.com>,
        "James Hogan" <james.hogan@imgtec.com>, <stable@vger.kernel.org>
Subject: [PATCH 1/4] MIPS: Use copy_s.fmt rather than copy_u.fmt
Date:   Fri, 15 Apr 2016 10:07:23 +0100
Message-ID: <1460711246-4394-2-git-send-email-james.hogan@imgtec.com>
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
X-archive-position: 52989
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

From: Paul Burton <paul.burton@imgtec.com>

In revision 1.12 of the MSA specification, the copy_u.w instruction has
been removed for MIPS32 & the copy_u.d instruction has been removed for
MIPS64. Newer toolchains (eg. Codescape SDK essentials 2015.10) will
complain about this like so:

arch/mips/kernel/r4k_fpu.S:290: Error: opcode not supported on this
processor: mips32r2 (mips32r2) `copy_u.w $1,$w26[3]'

Since we always copy to the width of a GPR, simply use copy_s instead of
copy_u to fix this.

Signed-off-by: Paul Burton <paul.burton@imgtec.com>
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: <stable@vger.kernel.org> # 4.1.x-
---
 arch/mips/include/asm/asmmacro.h | 24 ++++++++++++------------
 arch/mips/kernel/r4k_fpu.S       | 10 +++++-----
 2 files changed, 17 insertions(+), 17 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 867f924b05c7..b99b38862fcb 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -298,21 +298,21 @@
 	.set	pop
 	.endm
 
-	.macro	copy_u_w	ws, n
+	.macro	copy_s_w	ws, n
 	.set	push
 	.set	mips32r2
 	.set	fp=64
 	.set	msa
-	copy_u.w $1, $w\ws[\n]
+	copy_s.w $1, $w\ws[\n]
 	.set	pop
 	.endm
 
-	.macro	copy_u_d	ws, n
+	.macro	copy_s_d	ws, n
 	.set	push
 	.set	mips64r2
 	.set	fp=64
 	.set	msa
-	copy_u.d $1, $w\ws[\n]
+	copy_s.d $1, $w\ws[\n]
 	.set	pop
 	.endm
 
@@ -346,8 +346,8 @@
 #define STH_MSA_INSN		0x5800081f
 #define STW_MSA_INSN		0x5800082f
 #define STD_MSA_INSN		0x5800083f
-#define COPY_UW_MSA_INSN	0x58f00056
-#define COPY_UD_MSA_INSN	0x58f80056
+#define COPY_SW_MSA_INSN	0x58b00056
+#define COPY_SD_MSA_INSN	0x58b80056
 #define INSERT_W_MSA_INSN	0x59300816
 #define INSERT_D_MSA_INSN	0x59380816
 #else
@@ -361,8 +361,8 @@
 #define STH_MSA_INSN		0x78000825
 #define STW_MSA_INSN		0x78000826
 #define STD_MSA_INSN		0x78000827
-#define COPY_UW_MSA_INSN	0x78f00059
-#define COPY_UD_MSA_INSN	0x78f80059
+#define COPY_SW_MSA_INSN	0x78b00059
+#define COPY_SD_MSA_INSN	0x78b80059
 #define INSERT_W_MSA_INSN	0x79300819
 #define INSERT_D_MSA_INSN	0x79380819
 #endif
@@ -461,21 +461,21 @@
 	.set	pop
 	.endm
 
-	.macro	copy_u_w	ws, n
+	.macro	copy_s_w	ws, n
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
 	.insn
-	.word	COPY_UW_MSA_INSN | (\n << 16) | (\ws << 11)
+	.word	COPY_SW_MSA_INSN | (\n << 16) | (\ws << 11)
 	.set	pop
 	.endm
 
-	.macro	copy_u_d	ws, n
+	.macro	copy_s_d	ws, n
 	.set	push
 	.set	noat
 	SET_HARDFLOAT
 	.insn
-	.word	COPY_UD_MSA_INSN | (\n << 16) | (\ws << 11)
+	.word	COPY_SD_MSA_INSN | (\n << 16) | (\ws << 11)
 	.set	pop
 	.endm
 
diff --git a/arch/mips/kernel/r4k_fpu.S b/arch/mips/kernel/r4k_fpu.S
index 17732f876eff..56d86b09c917 100644
--- a/arch/mips/kernel/r4k_fpu.S
+++ b/arch/mips/kernel/r4k_fpu.S
@@ -244,17 +244,17 @@ LEAF(\name)
 	.set	push
 	.set	noat
 #ifdef CONFIG_64BIT
-	copy_u_d \wr, 1
+	copy_s_d \wr, 1
 	EX sd	$1, \off(\base)
 #elif defined(CONFIG_CPU_LITTLE_ENDIAN)
-	copy_u_w \wr, 2
+	copy_s_w \wr, 2
 	EX sw	$1, \off(\base)
-	copy_u_w \wr, 3
+	copy_s_w \wr, 3
 	EX sw	$1, (\off+4)(\base)
 #else /* CONFIG_CPU_BIG_ENDIAN */
-	copy_u_w \wr, 2
+	copy_s_w \wr, 2
 	EX sw	$1, (\off+4)(\base)
-	copy_u_w \wr, 3
+	copy_s_w \wr, 3
 	EX sw	$1, \off(\base)
 #endif
 	.set	pop
-- 
2.4.10
