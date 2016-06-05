Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 05 Jun 2016 23:55:52 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:60496 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27042478AbcFEVxEHYo3p (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 5 Jun 2016 23:53:04 +0200
Received: from localhost (c-50-170-35-168.hsd1.wa.comcast.net [50.170.35.168])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id 8089293D;
        Sun,  5 Jun 2016 21:52:53 +0000 (UTC)
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Paul Burton <paul.burton@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 4.6 016/121] MIPS: Use copy_s.fmt rather than copy_u.fmt
Date:   Sun,  5 Jun 2016 14:42:48 -0700
Message-Id: <20160605214418.200501886@linuxfoundation.org>
X-Mailer: git-send-email 2.8.3
In-Reply-To: <20160605214417.708509043@linuxfoundation.org>
References: <20160605214417.708509043@linuxfoundation.org>
User-Agent: quilt/0.64
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-Path: <gregkh@linuxfoundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53846
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

4.6-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Paul Burton <paul.burton@imgtec.com>

commit 8a3c8b48aca8771bff3536e40aa26ffb311699d1 upstream.

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
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/13061/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 arch/mips/include/asm/asmmacro.h |   24 ++++++++++++------------
 arch/mips/kernel/r4k_fpu.S       |   10 +++++-----
 2 files changed, 17 insertions(+), 17 deletions(-)

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
