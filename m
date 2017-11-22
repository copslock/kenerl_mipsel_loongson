Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2017 12:31:39 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:33670 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990409AbdKVLbcPHKm8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Nov 2017 12:31:32 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 22 Nov 2017 11:31:27 +0000
Received: from jhogan-linux.mipstec.com (192.168.154.110) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 22 Nov 2017 03:30:51 -0800
From:   James Hogan <james.hogan@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Marcin Nowakowski <marcin.nowakowski@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 1/7] MIPS: Add helpers for assembler macro instructions
Date:   Wed, 22 Nov 2017 11:30:27 +0000
Message-ID: <b13de64d5dfd644423f5804a3c70d722c9d33105.1511349998.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.41391a6cc5670b90bb8e77eadd07c712793eab03.1511349998.git-series.jhogan@kernel.org>
References: <cover.41391a6cc5670b90bb8e77eadd07c712793eab03.1511349998.git-series.jhogan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1511350286-298552-755-64361-1
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
X-archive-position: 61048
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

Implement a parse_r assembler macro in asm/mipsregs.h to parse a
register in $n form, and a few C macros for defining assembler macro
instructions. These can be used to more transparently support older
binutils versions which don't support for example the msa, virt, xpa, or
crc instructions.

In particular they overcome the difficulty of turning a register name in
$n form into an instruction encoding suitable for giving to .word /
.hword, which is particularly problematic when needed from inline
assembly where the compiler is responsible for register allocation.
Traditionally this had required the use of $at and an extra MOV
instruction, but for CRC instructions with multiple GP register operands
that approach becomes more difficult.

Three assembler macro creation helpers are added:

 - _ASM_MACRO_0(OP, ENC)
   This is to define an assembler macro for an instruction which has no
   operands, for example the VZ TLBGR instruction.

 - _ASM_MACRO_2R(OP, R1, R2, ENC)
   This is to define an assembler macro for an instruction which has 2
   register operands, for example the CFCMSA instruction.

 - _ASM_MACRO_3R(OP, R1, R2, R3, ENC)
   This is to define an assembler macro for an instruction which has 3
   register operands, for example the crc32 instructions.

 - _ASM_MACRO_2R_1S(OP, R1, R2, SEL3, ENC)
   This is to define an assembler macro for a Cop0 move instruction,
   with 2 register operands and an optional register select operand
   which defaults to 0, for example the VZ MFGC0 instruction.

Suggested-by: Ralf Baechle <ralf@linux-mips.org>
Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Marcin Nowakowski <marcin.nowakowski@mips.com>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 83 +++++++++++++++++++++++++++++++++-
 1 file changed, 83 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 6b1f1ad0542c..972698557b4b 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1181,6 +1181,89 @@ static inline int mm_insn_16bit(u16 insn)
 #endif
 
 /*
+ * parse_r var, r - Helper assembler macro for parsing register names.
+ *
+ * This converts the register name in $n form provided in \r to the
+ * corresponding register number, which is assigned to the variable \var. It is
+ * needed to allow explicit encoding of instructions in inline assembly where
+ * registers are chosen by the compiler in $n form, allowing us to avoid using
+ * fixed register numbers.
+ *
+ * It also allows newer instructions (not implemented by the assembler) to be
+ * transparently implemented using assembler macros, instead of needing separate
+ * cases depending on toolchain support.
+ *
+ * Simple usage example:
+ * __asm__ __volatile__("parse_r __rt, %0\n\t"
+ *			".insn\n\t"
+ *			"# di    %0\n\t"
+ *			".word   (0x41606000 | (__rt << 16))"
+ *			: "=r" (status);
+ */
+
+/* Match an individual register number and assign to \var */
+#define _IFC_REG(n)				\
+	".ifc	\\r, $" #n "\n\t"		\
+	"\\var	= " #n "\n\t"			\
+	".endif\n\t"
+
+__asm__(".macro	parse_r var r\n\t"
+	"\\var	= -1\n\t"
+	_IFC_REG(0)  _IFC_REG(1)  _IFC_REG(2)  _IFC_REG(3)
+	_IFC_REG(4)  _IFC_REG(5)  _IFC_REG(6)  _IFC_REG(7)
+	_IFC_REG(8)  _IFC_REG(9)  _IFC_REG(10) _IFC_REG(11)
+	_IFC_REG(12) _IFC_REG(13) _IFC_REG(14) _IFC_REG(15)
+	_IFC_REG(16) _IFC_REG(17) _IFC_REG(18) _IFC_REG(19)
+	_IFC_REG(20) _IFC_REG(21) _IFC_REG(22) _IFC_REG(23)
+	_IFC_REG(24) _IFC_REG(25) _IFC_REG(26) _IFC_REG(27)
+	_IFC_REG(28) _IFC_REG(29) _IFC_REG(30) _IFC_REG(31)
+	".iflt	\\var\n\t"
+	".error	\"Unable to parse register name \\r\"\n\t"
+	".endif\n\t"
+	".endm");
+
+#undef _IFC_REG
+
+/*
+ * C macros for generating assembler macros for common instruction formats.
+ *
+ * The names of the operands can be chosen by the caller, and the encoding of
+ * register operand \<Rn> is assigned to __<Rn> where it can be accessed from
+ * the ENC encodings.
+ */
+
+/* Instructions with no operands */
+#define _ASM_MACRO_0(OP, ENC)						\
+	__asm__(".macro	" #OP "\n\t"					\
+		ENC							\
+		".endm")
+
+/* Instructions with 2 register operands */
+#define _ASM_MACRO_2R(OP, R1, R2, ENC)					\
+	__asm__(".macro	" #OP " " #R1 ", " #R2 "\n\t"			\
+		"parse_r __" #R1 ", \\" #R1 "\n\t"			\
+		"parse_r __" #R2 ", \\" #R2 "\n\t"			\
+		ENC							\
+		".endm")
+
+/* Instructions with 3 register operands */
+#define _ASM_MACRO_3R(OP, R1, R2, R3, ENC)				\
+	__asm__(".macro	" #OP " " #R1 ", " #R2 ", " #R3 "\n\t"		\
+		"parse_r __" #R1 ", \\" #R1 "\n\t"			\
+		"parse_r __" #R2 ", \\" #R2 "\n\t"			\
+		"parse_r __" #R3 ", \\" #R3 "\n\t"			\
+		ENC							\
+		".endm")
+
+/* Instructions with 2 register operands and 1 optional select operand */
+#define _ASM_MACRO_2R_1S(OP, R1, R2, SEL3, ENC)				\
+	__asm__(".macro	" #OP " " #R1 ", " #R2 ", " #SEL3 " = 0\n\t"	\
+		"parse_r __" #R1 ", \\" #R1 "\n\t"			\
+		"parse_r __" #R2 ", \\" #R2 "\n\t"			\
+		ENC							\
+		".endm")
+
+/*
  * TLB Invalidate Flush
  */
 static inline void tlbinvf(void)
-- 
git-series 0.9.1
