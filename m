Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 15 Apr 2014 23:00:12 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:48517 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6818702AbaDOVAGHZbNk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 15 Apr 2014 23:00:06 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1WaASU-0001qV-Ug; Tue, 15 Apr 2014 15:59:58 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH v2] MIPS: Add microMIPS MSA support.
Date:   Tue, 15 Apr 2014 15:59:42 -0500
Message-Id: <1397595582-14577-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Steven.Hill@imgtec.com
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

From: "Steven J. Hill" <Steven.Hill@imgtec.com>

This patch adds support for the microMIPS implementation
of the MSA instructions.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
Reviewed-by: Paul Burton <Paul.Burton@imgtec.com>
---
v2: Clean up macros to use less #ifdef's.

 arch/mips/include/asm/asmmacro.h |   40 ++++++++++++++++++++++++++++++--------
 arch/mips/include/asm/msa.h      |   13 +++++++++++--
 2 files changed, 43 insertions(+), 10 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index b464b8b..587a3db 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -267,13 +267,35 @@
 	.set	pop
 	.endm
 #else
+
+#ifdef CONFIG_CPU_MICROMIPS
+#define CFC_MSA_INSN		0x587e0056
+#define CTC_MSA_INSN		0x583e0816
+#define LDD_MSA_INSN		0x58000837
+#define STD_MSA_INSN		0x5800083f
+#define COPY_UW_MSA_INSN	0x58f00056
+#define COPY_UD_MSA_INSN	0x58f80056
+#define INSERT_W_MSA_INSN	0x59300816
+#define INSERT_D_MSA_INSN	0x59380816
+#else
+#define CFC_MSA_INSN		0x787e0059
+#define CTC_MSA_INSN		0x783e0819
+#define LDD_MSA_INSN		0x78000823
+#define STD_MSA_INSN		0x78000827
+#define COPY_UW_MSA_INSN	0x78f00059
+#define COPY_UD_MSA_INSN	0x78f80059
+#define INSERT_W_MSA_INSN	0x79300819
+#define INSERT_D_MSA_INSN	0x79380819
+#endif
+
 	/*
 	 * Temporary until all toolchains in use include MSA support.
 	 */
 	.macro	cfcmsa	rd, cs
 	.set	push
 	.set	noat
-	.word	0x787e0059 | (\cs << 11)
+	.insn
+	.word	CFCMSA_INSN | (\cs << 11)
 	move	\rd, $1
 	.set	pop
 	.endm
@@ -282,7 +304,7 @@
 	.set	push
 	.set	noat
 	move	$1, \rs
-	.word	0x783e0819 | (\cd << 6)
+	.word	CTCMSA_INSN | (\cd << 6)
 	.set	pop
 	.endm
 
@@ -290,7 +312,7 @@
 	.set	push
 	.set	noat
 	add	$1, \base, \off
-	.word	0x78000823 | (\wd << 6)
+	.word	LDD_MSA_INSN | (\wd << 6)
 	.set	pop
 	.endm
 
@@ -298,14 +320,15 @@
 	.set	push
 	.set	noat
 	add	$1, \base, \off
-	.word	0x78000827 | (\wd << 6)
+	.word	STD_MSA_INSN | (\wd << 6)
 	.set	pop
 	.endm
 
 	.macro	copy_u_w	rd, ws, n
 	.set	push
 	.set	noat
-	.word	0x78f00059 | (\n << 16) | (\ws << 11)
+	.insn
+	.word	COPY_UW_MSA_INSN | (\n << 16) | (\ws << 11)
 	/* move triggers an assembler bug... */
 	or	\rd, $1, zero
 	.set	pop
@@ -314,7 +337,8 @@
 	.macro	copy_u_d	rd, ws, n
 	.set	push
 	.set	noat
-	.word	0x78f80059 | (\n << 16) | (\ws << 11)
+	.insn
+	.word	COPY_UD_MSA_INSN | (\n << 16) | (\ws << 11)
 	/* move triggers an assembler bug... */
 	or	\rd, $1, zero
 	.set	pop
@@ -325,7 +349,7 @@
 	.set	noat
 	/* move triggers an assembler bug... */
 	or	$1, \rs, zero
-	.word	0x79300819 | (\n << 16) | (\wd << 6)
+	.word	INSERT_W_MSA_INSN | (\n << 16) | (\wd << 6)
 	.set	pop
 	.endm
 
@@ -334,7 +358,7 @@
 	.set	noat
 	/* move triggers an assembler bug... */
 	or	$1, \rs, zero
-	.word	0x79380819 | (\n << 16) | (\wd << 6)
+	.word	INSERT_D_MSA_INSN | (\n << 16) | (\wd << 6)
 	.set	pop
 	.endm
 #endif
diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index a2aba6c..52450a0 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -96,6 +96,13 @@ static inline void write_msa_##name(unsigned int val)		\
  * allow compilation with toolchains that do not support MSA. Once all
  * toolchains in use support MSA these can be removed.
  */
+#ifdef CONFIG_CPU_MICROMIPS
+#define CFC_MSA_INSN	0x587e0056
+#define CTC_MSA_INSN	0x583e0816
+#else
+#define CFC_MSA_INSN	0x787e0059
+#define CTC_MSA_INSN	0x783e0819
+#endif
 
 #define __BUILD_MSA_CTL_REG(name, cs)				\
 static inline unsigned int read_msa_##name(void)		\
@@ -104,7 +111,8 @@ static inline unsigned int read_msa_##name(void)		\
 	__asm__ __volatile__(					\
 	"	.set	push\n"					\
 	"	.set	noat\n"					\
-	"	.word	0x787e0059 | (" #cs " << 11)\n"		\
+	"	.insn\n"					\
+	"	.word	#CFC_MSA_INSN | (" #cs " << 11)\n"	\
 	"	move	%0, $1\n"				\
 	"	.set	pop\n"					\
 	: "=r"(reg));						\
@@ -117,7 +125,8 @@ static inline void write_msa_##name(unsigned int val)		\
 	"	.set	push\n"					\
 	"	.set	noat\n"					\
 	"	move	$1, %0\n"				\
-	"	.word	0x783e0819 | (" #cs " << 6)\n"		\
+	"	.insn\n"					\
+	"	.word	#CTC_MSA_INSN | (" #cs " << 6)\n"	\
 	"	.set	pop\n"					\
 	: : "r"(val));						\
 }
-- 
1.7.10.4
