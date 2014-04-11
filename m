Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Apr 2014 16:58:40 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:42073 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834668AbaDKO6e0qjj3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Apr 2014 16:58:34 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1WYcuS-0007wl-5g; Fri, 11 Apr 2014 09:58:28 -0500
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH] MIPS: Add microMIPS MSA support.
Date:   Fri, 11 Apr 2014 09:58:23 -0500
Message-Id: <1397228303-7689-1-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.8.3.2
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39780
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
 arch/mips/include/asm/asmmacro.h | 35 +++++++++++++++++++++++++++++++++++
 arch/mips/include/asm/msa.h      | 18 ++++++++++++++----
 2 files changed, 49 insertions(+), 4 deletions(-)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index b464b8b..30d1ac3 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -273,7 +273,12 @@
 	.macro	cfcmsa	rd, cs
 	.set	push
 	.set	noat
+#ifdef CONFIG_CPU_MICROMIPS
+	.insn
+	.word	0x587e0056 | (\cs << 11)
+#else
 	.word	0x787e0059 | (\cs << 11)
+#endif
 	move	\rd, $1
 	.set	pop
 	.endm
@@ -282,7 +287,11 @@
 	.set	push
 	.set	noat
 	move	$1, \rs
+#ifdef CONFIG_CPU_MICROMIPS
+	.word	0x583e0816 | (\cd << 6)
+#else
 	.word	0x783e0819 | (\cd << 6)
+#endif
 	.set	pop
 	.endm
 
@@ -290,7 +299,11 @@
 	.set	push
 	.set	noat
 	add	$1, \base, \off
+#ifdef CONFIG_CPU_MICROMIPS
+	.word	0x5800083f | (\wd << 6)
+#else
 	.word	0x78000823 | (\wd << 6)
+#endif
 	.set	pop
 	.endm
 
@@ -298,14 +311,23 @@
 	.set	push
 	.set	noat
 	add	$1, \base, \off
+#ifdef CONFIG_CPU_MICROMIPS
+	.word	0x5800083f | (\wd << 6)
+#else
 	.word	0x78000827 | (\wd << 6)
+#endif
 	.set	pop
 	.endm
 
 	.macro	copy_u_w	rd, ws, n
 	.set	push
 	.set	noat
+#ifdef CONFIG_CPU_MICROMIPS
+	.insn
+	.word	0x58f00056 | (\n << 16) | (\ws << 11)
+#else
 	.word	0x78f00059 | (\n << 16) | (\ws << 11)
+#endif
 	/* move triggers an assembler bug... */
 	or	\rd, $1, zero
 	.set	pop
@@ -314,7 +336,12 @@
 	.macro	copy_u_d	rd, ws, n
 	.set	push
 	.set	noat
+#ifdef CONFIG_CPU_MICROMIPS
+	.insn
+	.word	0x58f80056 | (\n << 16) | (\ws << 11)
+#else
 	.word	0x78f80059 | (\n << 16) | (\ws << 11)
+#endif
 	/* move triggers an assembler bug... */
 	or	\rd, $1, zero
 	.set	pop
@@ -325,7 +352,11 @@
 	.set	noat
 	/* move triggers an assembler bug... */
 	or	$1, \rs, zero
+#ifdef CONFIG_CPU_MICROMIPS
+	.word	0x59300816 | (\n << 16) | (\wd << 6)
+#else
 	.word	0x79300819 | (\n << 16) | (\wd << 6)
+#endif
 	.set	pop
 	.endm
 
@@ -334,7 +365,11 @@
 	.set	noat
 	/* move triggers an assembler bug... */
 	or	$1, \rs, zero
+#ifdef CONFIG_CPU_MICROMIPS
+	.word	0x59380816 | (\n << 16) | (\wd << 6)
+#else
 	.word	0x79380819 | (\n << 16) | (\wd << 6)
+#endif
 	.set	pop
 	.endm
 #endif
diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index a2aba6c..fd76b3b 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -96,6 +96,13 @@ static inline void write_msa_##name(unsigned int val)		\
  * allow compilation with toolchains that do not support MSA. Once all
  * toolchains in use support MSA these can be removed.
  */
+#ifdef CONFIG_CPU_MICROMIPS
+#define CFCMSA_INSN	0x587e0056
+#define CTCMSA_INSN	0x583e0816
+#else
+#define CFCMSA_INSN	0x787e0059
+#define CTCMSA_INSN	0x783e0819
+#endif
 
 #define __BUILD_MSA_CTL_REG(name, cs)				\
 static inline unsigned int read_msa_##name(void)		\
@@ -104,10 +111,12 @@ static inline unsigned int read_msa_##name(void)		\
 	__asm__ __volatile__(					\
 	"	.set	push\n"					\
 	"	.set	noat\n"					\
-	"	.word	0x787e0059 | (" #cs " << 11)\n"		\
+	"	.insn\n"					\
+	"	.word	%1 | (" #cs " << 11)\n"			\
 	"	move	%0, $1\n"				\
 	"	.set	pop\n"					\
-	: "=r"(reg));						\
+	: "=r"(reg)						\
+	: "i"(CFCMSA_INSN));					\
 	return reg;						\
 }								\
 								\
@@ -117,9 +126,10 @@ static inline void write_msa_##name(unsigned int val)		\
 	"	.set	push\n"					\
 	"	.set	noat\n"					\
 	"	move	$1, %0\n"				\
-	"	.word	0x783e0819 | (" #cs " << 6)\n"		\
+	"	.insn\n"					\
+	"	.word	%1 | (" #cs " << 6)\n"			\
 	"	.set	pop\n"					\
-	: : "r"(val));						\
+	: : "r"(val), "i"(CTCMSA_INSN));			\
 }
 
 #endif /* !TOOLCHAIN_SUPPORTS_MSA */
-- 
1.8.3.2
