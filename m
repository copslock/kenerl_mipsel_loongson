Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2017 12:34:00 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:50050 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991339AbdKVLbmoyox8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Nov 2017 12:31:42 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 22 Nov 2017 11:31:38 +0000
Received: from jhogan-linux.mipstec.com (192.168.154.110) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 22 Nov 2017 03:31:01 -0800
From:   James Hogan <james.hogan@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Marcin Nowakowski <marcin.nowakowski@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>
Subject: [PATCH 7/7] MIPS: MSA: Update helpers to use new asm macros
Date:   Wed, 22 Nov 2017 11:30:33 +0000
Message-ID: <91ef683cbd1e8dee2626068a86f0f2af350aa36a.1511349998.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.41391a6cc5670b90bb8e77eadd07c712793eab03.1511349998.git-series.jhogan@kernel.org>
References: <cover.41391a6cc5670b90bb8e77eadd07c712793eab03.1511349998.git-series.jhogan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1511350286-298552-755-64361-3
X-BESS-VER: 2017.14-r1710272128
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 4.30
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.187190
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
        2.50 BSF_SC0_MV0735         META: custom rule MV0735 
        1.80 BSF_SC0_MV0735_3       META:  
X-BESS-Outbound-Spam-Status: SCORE=4.30 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND, BSF_SC0_MV0735, BSF_SC0_MV0735_3
X-BESS-BRTS-Status: 1
Return-Path: <James.Hogan@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61054
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@mips.com
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

From: James Hogan <jhogan@kernel.org>

Update MSA control register access helpers to use the new helpers for
parsing register names and creating custom assembly macro instructions.

This allows the move via $at to be dropped (saving a total of about 20
bytes of kernel code).

Note, this does not alter the equivalent code in .S files, which still
uses the $at trick.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paul Burton <paul.burton@mips.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/msa.h | 63 +++++++++++---------------------------
 1 file changed, 19 insertions(+), 44 deletions(-)

diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index 8967b475ab10..93fa7133811b 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -160,7 +160,23 @@ static inline void init_msa_upper(void)
 	_init_msa_upper();
 }
 
-#ifdef TOOLCHAIN_SUPPORTS_MSA
+#ifndef TOOLCHAIN_SUPPORTS_MSA
+/*
+ * Define assembler macros using .word for the c[ft]cmsa instructions in order
+ * to allow compilation with toolchains that do not support MSA. Once all
+ * toolchains in use support MSA these can be removed.
+ */
+_ASM_MACRO_2R(cfcmsa, rd, cs,
+	_ASM_INSN_IF_MIPS(0x787e0019 | __cs << 11 | __rd << 6)
+	_ASM_INSN32_IF_MM(0x587e0016 | __cs << 11 | __rd << 6));
+_ASM_MACRO_2R(ctcmsa, cd, rs,
+	_ASM_INSN_IF_MIPS(0x783e0019 | __rs << 11 | __cd << 6)
+	_ASM_INSN32_IF_MM(0x583e0016 | __rs << 11 | __cd << 6));
+#define _ASM_SET_MSA ""
+#else /* TOOLCHAIN_SUPPORTS_MSA */
+#define _ASM_SET_MSA ".set\tfp=64\n\t"				\
+		     ".set\tmsa\n\t"
+#endif
 
 #define __BUILD_MSA_CTL_REG(name, cs)				\
 static inline unsigned int read_msa_##name(void)		\
@@ -168,8 +184,7 @@ static inline unsigned int read_msa_##name(void)		\
 	unsigned int reg;					\
 	__asm__ __volatile__(					\
 	"	.set	push\n"					\
-	"	.set	fp=64\n"				\
-	"	.set	msa\n"					\
+	_ASM_SET_MSA						\
 	"	cfcmsa	%0, $" #cs "\n"				\
 	"	.set	pop\n"					\
 	: "=r"(reg));						\
@@ -180,52 +195,12 @@ static inline void write_msa_##name(unsigned int val)		\
 {								\
 	__asm__ __volatile__(					\
 	"	.set	push\n"					\
-	"	.set	fp=64\n"				\
-	"	.set	msa\n"					\
+	_ASM_SET_MSA						\
 	"	ctcmsa	$" #cs ", %0\n"				\
 	"	.set	pop\n"					\
 	: : "r"(val));						\
 }
 
-#else /* !TOOLCHAIN_SUPPORTS_MSA */
-
-/*
- * Define functions using .word for the c[ft]cmsa instructions in order to
- * allow compilation with toolchains that do not support MSA. Once all
- * toolchains in use support MSA these can be removed.
- */
-
-#define __BUILD_MSA_CTL_REG(name, cs)				\
-static inline unsigned int read_msa_##name(void)		\
-{								\
-	unsigned int reg;					\
-	__asm__ __volatile__(					\
-	"	.set	push\n"					\
-	"	.set	noat\n"					\
-	"	# cfcmsa $1, $%1\n"				\
-	_ASM_INSN_IF_MIPS(0x787e0059 | %1 << 11)		\
-	_ASM_INSN32_IF_MM(0x587e0056 | %1 << 11)		\
-	"	move	%0, $1\n"				\
-	"	.set	pop\n"					\
-	: "=r"(reg) : "i"(cs));					\
-	return reg;						\
-}								\
-								\
-static inline void write_msa_##name(unsigned int val)		\
-{								\
-	__asm__ __volatile__(					\
-	"	.set	push\n"					\
-	"	.set	noat\n"					\
-	"	move	$1, %0\n"				\
-	"	# ctcmsa $%1, $1\n"				\
-	_ASM_INSN_IF_MIPS(0x783e0819 | %1 << 6)			\
-	_ASM_INSN32_IF_MM(0x583e0816 | %1 << 6)			\
-	"	.set	pop\n"					\
-	: : "r"(val), "i"(cs));					\
-}
-
-#endif /* !TOOLCHAIN_SUPPORTS_MSA */
-
 __BUILD_MSA_CTL_REG(ir, 0)
 __BUILD_MSA_CTL_REG(csr, 1)
 __BUILD_MSA_CTL_REG(access, 2)
-- 
git-series 0.9.1
