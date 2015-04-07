Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 14:52:19 +0200 (CEST)
Received: from ip4-83-240-67-251.cust.nbox.cz ([83.240.67.251]:35585 "EHLO
        ip4-83-240-18-248.cust.nbox.cz" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S27009769AbbDGMwRCMndp (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Apr 2015 14:52:17 +0200
Received: from ku by ip4-83-240-18-248.cust.nbox.cz with local (Exim 4.85)
        (envelope-from <jslaby@suse.cz>)
        id 1YfSz8-0001zw-4E; Tue, 07 Apr 2015 14:52:06 +0200
From:   Jiri Slaby <jslaby@suse.cz>
To:     stable@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Alex Smith <alex@alex-smith.me.uk>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.cz>
Subject: [PATCH 3.12 095/155] MIPS: asm/reg.h: Make 32- and 64-bit definitions available at the same time
Date:   Tue,  7 Apr 2015 14:51:04 +0200
Message-Id: <e9d88efb5980aab008e071849cb6fbb95027f331.1428411004.git.jslaby@suse.cz>
X-Mailer: git-send-email 2.3.4
In-Reply-To: <9a548862b8a26cbccc14f2c6c9c3688813d8d14b.1428411003.git.jslaby@suse.cz>
References: <9a548862b8a26cbccc14f2c6c9c3688813d8d14b.1428411003.git.jslaby@suse.cz>
In-Reply-To: <cover.1428411003.git.jslaby@suse.cz>
References: <cover.1428411003.git.jslaby@suse.cz>
Return-Path: <jslaby@suse.cz>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jslaby@suse.cz
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

From: Alex Smith <alex@alex-smith.me.uk>

3.12-stable review patch.  If anyone has any objections, please let me know.

===============

commit bcec7c8da6b092b1ff3327fd83c2193adb12f684 upstream.

Get rid of the WANT_COMPAT_REG_H test and instead define both the 32-
and 64-bit register offset definitions at the same time with
MIPS{32,64}_ prefixes, then define the existing EF_* names to the
correct definitions for the kernel's bitness.

This patch is a prerequisite of the following bug fix patch.

Signed-off-by: Alex Smith <alex@alex-smith.me.uk>
Cc: linux-mips@linux-mips.org
Patchwork: https://patchwork.linux-mips.org/patch/7451/
Signed-off-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Jiri Slaby <jslaby@suse.cz>
---
 arch/mips/include/asm/reg.h      | 260 +++++++++++++++++++++++++--------------
 arch/mips/kernel/binfmt_elfo32.c |  32 ++---
 2 files changed, 182 insertions(+), 110 deletions(-)

diff --git a/arch/mips/include/asm/reg.h b/arch/mips/include/asm/reg.h
index 910e71a12466..b8343ccbc989 100644
--- a/arch/mips/include/asm/reg.h
+++ b/arch/mips/include/asm/reg.h
@@ -12,116 +12,194 @@
 #ifndef __ASM_MIPS_REG_H
 #define __ASM_MIPS_REG_H
 
-
-#if defined(CONFIG_32BIT) || defined(WANT_COMPAT_REG_H)
-
-#define EF_R0			6
-#define EF_R1			7
-#define EF_R2			8
-#define EF_R3			9
-#define EF_R4			10
-#define EF_R5			11
-#define EF_R6			12
-#define EF_R7			13
-#define EF_R8			14
-#define EF_R9			15
-#define EF_R10			16
-#define EF_R11			17
-#define EF_R12			18
-#define EF_R13			19
-#define EF_R14			20
-#define EF_R15			21
-#define EF_R16			22
-#define EF_R17			23
-#define EF_R18			24
-#define EF_R19			25
-#define EF_R20			26
-#define EF_R21			27
-#define EF_R22			28
-#define EF_R23			29
-#define EF_R24			30
-#define EF_R25			31
+#define MIPS32_EF_R0		6
+#define MIPS32_EF_R1		7
+#define MIPS32_EF_R2		8
+#define MIPS32_EF_R3		9
+#define MIPS32_EF_R4		10
+#define MIPS32_EF_R5		11
+#define MIPS32_EF_R6		12
+#define MIPS32_EF_R7		13
+#define MIPS32_EF_R8		14
+#define MIPS32_EF_R9		15
+#define MIPS32_EF_R10		16
+#define MIPS32_EF_R11		17
+#define MIPS32_EF_R12		18
+#define MIPS32_EF_R13		19
+#define MIPS32_EF_R14		20
+#define MIPS32_EF_R15		21
+#define MIPS32_EF_R16		22
+#define MIPS32_EF_R17		23
+#define MIPS32_EF_R18		24
+#define MIPS32_EF_R19		25
+#define MIPS32_EF_R20		26
+#define MIPS32_EF_R21		27
+#define MIPS32_EF_R22		28
+#define MIPS32_EF_R23		29
+#define MIPS32_EF_R24		30
+#define MIPS32_EF_R25		31
 
 /*
  * k0/k1 unsaved
  */
-#define EF_R26			32
-#define EF_R27			33
+#define MIPS32_EF_R26		32
+#define MIPS32_EF_R27		33
 
-#define EF_R28			34
-#define EF_R29			35
-#define EF_R30			36
-#define EF_R31			37
+#define MIPS32_EF_R28		34
+#define MIPS32_EF_R29		35
+#define MIPS32_EF_R30		36
+#define MIPS32_EF_R31		37
 
 /*
  * Saved special registers
  */
-#define EF_LO			38
-#define EF_HI			39
-
-#define EF_CP0_EPC		40
-#define EF_CP0_BADVADDR		41
-#define EF_CP0_STATUS		42
-#define EF_CP0_CAUSE		43
-#define EF_UNUSED0		44
-
-#define EF_SIZE			180
-
-#endif
-
-#if defined(CONFIG_64BIT) && !defined(WANT_COMPAT_REG_H)
-
-#define EF_R0			 0
-#define EF_R1			 1
-#define EF_R2			 2
-#define EF_R3			 3
-#define EF_R4			 4
-#define EF_R5			 5
-#define EF_R6			 6
-#define EF_R7			 7
-#define EF_R8			 8
-#define EF_R9			 9
-#define EF_R10			10
-#define EF_R11			11
-#define EF_R12			12
-#define EF_R13			13
-#define EF_R14			14
-#define EF_R15			15
-#define EF_R16			16
-#define EF_R17			17
-#define EF_R18			18
-#define EF_R19			19
-#define EF_R20			20
-#define EF_R21			21
-#define EF_R22			22
-#define EF_R23			23
-#define EF_R24			24
-#define EF_R25			25
+#define MIPS32_EF_LO		38
+#define MIPS32_EF_HI		39
+
+#define MIPS32_EF_CP0_EPC	40
+#define MIPS32_EF_CP0_BADVADDR	41
+#define MIPS32_EF_CP0_STATUS	42
+#define MIPS32_EF_CP0_CAUSE	43
+#define MIPS32_EF_UNUSED0	44
+
+#define MIPS32_EF_SIZE		180
+
+#define MIPS64_EF_R0		0
+#define MIPS64_EF_R1		1
+#define MIPS64_EF_R2		2
+#define MIPS64_EF_R3		3
+#define MIPS64_EF_R4		4
+#define MIPS64_EF_R5		5
+#define MIPS64_EF_R6		6
+#define MIPS64_EF_R7		7
+#define MIPS64_EF_R8		8
+#define MIPS64_EF_R9		9
+#define MIPS64_EF_R10		10
+#define MIPS64_EF_R11		11
+#define MIPS64_EF_R12		12
+#define MIPS64_EF_R13		13
+#define MIPS64_EF_R14		14
+#define MIPS64_EF_R15		15
+#define MIPS64_EF_R16		16
+#define MIPS64_EF_R17		17
+#define MIPS64_EF_R18		18
+#define MIPS64_EF_R19		19
+#define MIPS64_EF_R20		20
+#define MIPS64_EF_R21		21
+#define MIPS64_EF_R22		22
+#define MIPS64_EF_R23		23
+#define MIPS64_EF_R24		24
+#define MIPS64_EF_R25		25
 
 /*
  * k0/k1 unsaved
  */
-#define EF_R26			26
-#define EF_R27			27
+#define MIPS64_EF_R26		26
+#define MIPS64_EF_R27		27
 
 
-#define EF_R28			28
-#define EF_R29			29
-#define EF_R30			30
-#define EF_R31			31
+#define MIPS64_EF_R28		28
+#define MIPS64_EF_R29		29
+#define MIPS64_EF_R30		30
+#define MIPS64_EF_R31		31
 
 /*
  * Saved special registers
  */
-#define EF_LO			32
-#define EF_HI			33
-
-#define EF_CP0_EPC		34
-#define EF_CP0_BADVADDR		35
-#define EF_CP0_STATUS		36
-#define EF_CP0_CAUSE		37
-
-#define EF_SIZE			304	/* size in bytes */
+#define MIPS64_EF_LO		32
+#define MIPS64_EF_HI		33
+
+#define MIPS64_EF_CP0_EPC	34
+#define MIPS64_EF_CP0_BADVADDR	35
+#define MIPS64_EF_CP0_STATUS	36
+#define MIPS64_EF_CP0_CAUSE	37
+
+#define MIPS64_EF_SIZE		304	/* size in bytes */
+
+#if defined(CONFIG_32BIT)
+
+#define EF_R0			MIPS32_EF_R0
+#define EF_R1			MIPS32_EF_R1
+#define EF_R2			MIPS32_EF_R2
+#define EF_R3			MIPS32_EF_R3
+#define EF_R4			MIPS32_EF_R4
+#define EF_R5			MIPS32_EF_R5
+#define EF_R6			MIPS32_EF_R6
+#define EF_R7			MIPS32_EF_R7
+#define EF_R8			MIPS32_EF_R8
+#define EF_R9			MIPS32_EF_R9
+#define EF_R10			MIPS32_EF_R10
+#define EF_R11			MIPS32_EF_R11
+#define EF_R12			MIPS32_EF_R12
+#define EF_R13			MIPS32_EF_R13
+#define EF_R14			MIPS32_EF_R14
+#define EF_R15			MIPS32_EF_R15
+#define EF_R16			MIPS32_EF_R16
+#define EF_R17			MIPS32_EF_R17
+#define EF_R18			MIPS32_EF_R18
+#define EF_R19			MIPS32_EF_R19
+#define EF_R20			MIPS32_EF_R20
+#define EF_R21			MIPS32_EF_R21
+#define EF_R22			MIPS32_EF_R22
+#define EF_R23			MIPS32_EF_R23
+#define EF_R24			MIPS32_EF_R24
+#define EF_R25			MIPS32_EF_R25
+#define EF_R26			MIPS32_EF_R26
+#define EF_R27			MIPS32_EF_R27
+#define EF_R28			MIPS32_EF_R28
+#define EF_R29			MIPS32_EF_R29
+#define EF_R30			MIPS32_EF_R30
+#define EF_R31			MIPS32_EF_R31
+#define EF_LO			MIPS32_EF_LO
+#define EF_HI			MIPS32_EF_HI
+#define EF_CP0_EPC		MIPS32_EF_CP0_EPC
+#define EF_CP0_BADVADDR		MIPS32_EF_CP0_BADVADDR
+#define EF_CP0_STATUS		MIPS32_EF_CP0_STATUS
+#define EF_CP0_CAUSE		MIPS32_EF_CP0_CAUSE
+#define EF_UNUSED0		MIPS32_EF_UNUSED0
+#define EF_SIZE			MIPS32_EF_SIZE
+
+#elif defined(CONFIG_64BIT)
+
+#define EF_R0			MIPS64_EF_R0
+#define EF_R1			MIPS64_EF_R1
+#define EF_R2			MIPS64_EF_R2
+#define EF_R3			MIPS64_EF_R3
+#define EF_R4			MIPS64_EF_R4
+#define EF_R5			MIPS64_EF_R5
+#define EF_R6			MIPS64_EF_R6
+#define EF_R7			MIPS64_EF_R7
+#define EF_R8			MIPS64_EF_R8
+#define EF_R9			MIPS64_EF_R9
+#define EF_R10			MIPS64_EF_R10
+#define EF_R11			MIPS64_EF_R11
+#define EF_R12			MIPS64_EF_R12
+#define EF_R13			MIPS64_EF_R13
+#define EF_R14			MIPS64_EF_R14
+#define EF_R15			MIPS64_EF_R15
+#define EF_R16			MIPS64_EF_R16
+#define EF_R17			MIPS64_EF_R17
+#define EF_R18			MIPS64_EF_R18
+#define EF_R19			MIPS64_EF_R19
+#define EF_R20			MIPS64_EF_R20
+#define EF_R21			MIPS64_EF_R21
+#define EF_R22			MIPS64_EF_R22
+#define EF_R23			MIPS64_EF_R23
+#define EF_R24			MIPS64_EF_R24
+#define EF_R25			MIPS64_EF_R25
+#define EF_R26			MIPS64_EF_R26
+#define EF_R27			MIPS64_EF_R27
+#define EF_R28			MIPS64_EF_R28
+#define EF_R29			MIPS64_EF_R29
+#define EF_R30			MIPS64_EF_R30
+#define EF_R31			MIPS64_EF_R31
+#define EF_LO			MIPS64_EF_LO
+#define EF_HI			MIPS64_EF_HI
+#define EF_CP0_EPC		MIPS64_EF_CP0_EPC
+#define EF_CP0_BADVADDR		MIPS64_EF_CP0_BADVADDR
+#define EF_CP0_STATUS		MIPS64_EF_CP0_STATUS
+#define EF_CP0_CAUSE		MIPS64_EF_CP0_CAUSE
+#define EF_SIZE			MIPS64_EF_SIZE
 
 #endif /* CONFIG_64BIT */
 
diff --git a/arch/mips/kernel/binfmt_elfo32.c b/arch/mips/kernel/binfmt_elfo32.c
index 202e581e6096..7fdf1de0447f 100644
--- a/arch/mips/kernel/binfmt_elfo32.c
+++ b/arch/mips/kernel/binfmt_elfo32.c
@@ -58,12 +58,6 @@ typedef elf_fpreg_t elf_fpregset_t[ELF_NFPREG];
 
 #include <asm/processor.h>
 
-/*
- * When this file is selected, we are definitely running a 64bit kernel.
- * So using the right regs define in asm/reg.h
- */
-#define WANT_COMPAT_REG_H
-
 /* These MUST be defined before elf.h gets included */
 extern void elf32_core_copy_regs(elf_gregset_t grp, struct pt_regs *regs);
 #define ELF_CORE_COPY_REGS(_dest, _regs) elf32_core_copy_regs(_dest, _regs);
@@ -135,21 +129,21 @@ void elf32_core_copy_regs(elf_gregset_t grp, struct pt_regs *regs)
 {
 	int i;
 
-	for (i = 0; i < EF_R0; i++)
+	for (i = 0; i < MIPS32_EF_R0; i++)
 		grp[i] = 0;
-	grp[EF_R0] = 0;
+	grp[MIPS32_EF_R0] = 0;
 	for (i = 1; i <= 31; i++)
-		grp[EF_R0 + i] = (elf_greg_t) regs->regs[i];
-	grp[EF_R26] = 0;
-	grp[EF_R27] = 0;
-	grp[EF_LO] = (elf_greg_t) regs->lo;
-	grp[EF_HI] = (elf_greg_t) regs->hi;
-	grp[EF_CP0_EPC] = (elf_greg_t) regs->cp0_epc;
-	grp[EF_CP0_BADVADDR] = (elf_greg_t) regs->cp0_badvaddr;
-	grp[EF_CP0_STATUS] = (elf_greg_t) regs->cp0_status;
-	grp[EF_CP0_CAUSE] = (elf_greg_t) regs->cp0_cause;
-#ifdef EF_UNUSED0
-	grp[EF_UNUSED0] = 0;
+		grp[MIPS32_EF_R0 + i] = (elf_greg_t) regs->regs[i];
+	grp[MIPS32_EF_R26] = 0;
+	grp[MIPS32_EF_R27] = 0;
+	grp[MIPS32_EF_LO] = (elf_greg_t) regs->lo;
+	grp[MIPS32_EF_HI] = (elf_greg_t) regs->hi;
+	grp[MIPS32_EF_CP0_EPC] = (elf_greg_t) regs->cp0_epc;
+	grp[MIPS32_EF_CP0_BADVADDR] = (elf_greg_t) regs->cp0_badvaddr;
+	grp[MIPS32_EF_CP0_STATUS] = (elf_greg_t) regs->cp0_status;
+	grp[MIPS32_EF_CP0_CAUSE] = (elf_greg_t) regs->cp0_cause;
+#ifdef MIPS32_EF_UNUSED0
+	grp[MIPS32_EF_UNUSED0] = 0;
 #endif
 }
 
-- 
2.3.4
