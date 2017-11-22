Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 22 Nov 2017 12:32:27 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.150.245]:41112 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990425AbdKVLbgm0TE8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 22 Nov 2017 12:31:36 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx29.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 22 Nov 2017 11:31:30 +0000
Received: from jhogan-linux.mipstec.com (192.168.154.110) by
 MIPSMAIL01.mipstec.com (10.20.43.31) with Microsoft SMTP Server (TLS) id
 14.3.361.1; Wed, 22 Nov 2017 03:30:53 -0800
From:   James Hogan <james.hogan@mips.com>
To:     <linux-mips@linux-mips.org>
CC:     Marcin Nowakowski <marcin.nowakowski@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: [PATCH 2/7] MIPS: VZ: Update helpers to use new asm macros
Date:   Wed, 22 Nov 2017 11:30:28 +0000
Message-ID: <ee2caecba43f2e34afde024bdcfc4f9908974ff1.1511349998.git-series.jhogan@kernel.org>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <cover.41391a6cc5670b90bb8e77eadd07c712793eab03.1511349998.git-series.jhogan@kernel.org>
References: <cover.41391a6cc5670b90bb8e77eadd07c712793eab03.1511349998.git-series.jhogan@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
X-BESS-ID: 1511350289-637139-12581-475811-1
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
X-archive-position: 61050
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

Update VZ guest register & guest TLB access helpers to use the new
assembly macros for parsing register names and creating custom assembly
macro instructions, which has a number of advantages:

 - Better code can be generated on toolchains which don't support VZ,
   more closely matching those which do, since there is no need to
   bounce values via the $at register. Some differences still remain due
   to the inability to safely fill branch delay slots and R6 compact
   branch forbidden slots with explicitly encoded instructions,
   resulting in some extra NOPs added by the assembler.

 - Some code duplication between toolchains which do and don't support
   VZ instructions is removed, since the helpers are only implemented
   once. When the toolchain doesn't implement the instruction an
   assembly macro implements it instead.

 - Instruction encodings are kept together in the source.

On a generic kernel with KVM VZ support enabled this change saves about
2.5KiB of kernel code when TOOLCHAIN_SUPPORTS_VIRT=n, bringing it down
to about 0.5KiB more than when TOOLCHAIN_SUPPORTS_VIRT=y on r6, and just
68 bytes more on r2.

Signed-off-by: James Hogan <jhogan@kernel.org>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 164 +++++++-------------------------
 1 file changed, 37 insertions(+), 127 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 972698557b4b..361c35243366 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1913,14 +1913,40 @@ do {									\
  * Macros to access the guest system control coprocessor
  */
 
-#ifdef TOOLCHAIN_SUPPORTS_VIRT
+#ifndef TOOLCHAIN_SUPPORTS_VIRT
+_ASM_MACRO_2R_1S(mfgc0, rt, rs, sel,
+	_ASM_INSN_IF_MIPS(0x40600000 | __rt << 16 | __rs << 11 | \\sel)
+	_ASM_INSN32_IF_MM(0x000004fc | __rt << 21 | __rs << 16 | \\sel << 11));
+_ASM_MACRO_2R_1S(dmfgc0, rt, rs, sel,
+	_ASM_INSN_IF_MIPS(0x40600100 | __rt << 16 | __rs << 11 | \\sel)
+	_ASM_INSN32_IF_MM(0x580004fc | __rt << 21 | __rs << 16 | \\sel << 11));
+_ASM_MACRO_2R_1S(mtgc0, rt, rd, sel,
+	_ASM_INSN_IF_MIPS(0x40600200 | __rt << 16 | __rd << 11 | \\sel)
+	_ASM_INSN32_IF_MM(0x000006fc | __rt << 21 | __rd << 16 | \\sel << 11));
+_ASM_MACRO_2R_1S(dmtgc0, rt, rd, sel,
+	_ASM_INSN_IF_MIPS(0x40600300 | __rt << 16 | __rd << 11 | \\sel)
+	_ASM_INSN32_IF_MM(0x580006fc | __rt << 21 | __rd << 16 | \\sel << 11));
+_ASM_MACRO_0(tlbgp,    _ASM_INSN_IF_MIPS(0x42000010)
+		       _ASM_INSN32_IF_MM(0x0000017c));
+_ASM_MACRO_0(tlbgr,    _ASM_INSN_IF_MIPS(0x42000009)
+		       _ASM_INSN32_IF_MM(0x0000117c));
+_ASM_MACRO_0(tlbgwi,   _ASM_INSN_IF_MIPS(0x4200000a)
+		       _ASM_INSN32_IF_MM(0x0000217c));
+_ASM_MACRO_0(tlbgwr,   _ASM_INSN_IF_MIPS(0x4200000e)
+		       _ASM_INSN32_IF_MM(0x0000317c));
+_ASM_MACRO_0(tlbginvf, _ASM_INSN_IF_MIPS(0x4200000c)
+		       _ASM_INSN32_IF_MM(0x0000517c));
+#define _ASM_SET_VIRT ""
+#else	/* !TOOLCHAIN_SUPPORTS_VIRT */
+#define _ASM_SET_VIRT ".set\tvirt\n\t"
+#endif
 
 #define __read_32bit_gc0_register(source, sel)				\
 ({ int __res;								\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
 		".set\tmips32r2\n\t"					\
-		".set\tvirt\n\t"					\
+		_ASM_SET_VIRT						\
 		"mfgc0\t%0, $%1, %2\n\t"				\
 		".set\tpop"						\
 		: "=r" (__res)						\
@@ -1933,8 +1959,8 @@ do {									\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
 		".set\tmips64r2\n\t"					\
-		".set\tvirt\n\t"					\
-		"dmfgc0\t%0, $%1, %2\n\t"			\
+		_ASM_SET_VIRT						\
+		"dmfgc0\t%0, $%1, %2\n\t"				\
 		".set\tpop"						\
 		: "=r" (__res)						\
 		: "i" (source), "i" (sel));				\
@@ -1946,7 +1972,7 @@ do {									\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
 		".set\tmips32r2\n\t"					\
-		".set\tvirt\n\t"					\
+		_ASM_SET_VIRT						\
 		"mtgc0\t%z0, $%1, %2\n\t"				\
 		".set\tpop"						\
 		: : "Jr" ((unsigned int)(value)),			\
@@ -1958,75 +1984,13 @@ do {									\
 	__asm__ __volatile__(						\
 		".set\tpush\n\t"					\
 		".set\tmips64r2\n\t"					\
-		".set\tvirt\n\t"					\
+		_ASM_SET_VIRT						\
 		"dmtgc0\t%z0, $%1, %2\n\t"				\
 		".set\tpop"						\
 		: : "Jr" (value),					\
 		    "i" (register), "i" (sel));				\
 } while (0)
 
-#else	/* TOOLCHAIN_SUPPORTS_VIRT */
-
-#define __read_32bit_gc0_register(source, sel)				\
-({ int __res;								\
-	__asm__ __volatile__(						\
-		".set\tpush\n\t"					\
-		".set\tnoat\n\t"					\
-		"# mfgc0\t$1, $%1, %2\n\t"				\
-		_ASM_INSN_IF_MIPS(0x40610000 | %1 << 11 | %2)		\
-		_ASM_INSN32_IF_MM(0x002004fc | %1 << 16 | %2 << 11)	\
-		"move\t%0, $1\n\t"					\
-		".set\tpop"						\
-		: "=r" (__res)						\
-		: "i" (source), "i" (sel));				\
-	__res;								\
-})
-
-#define __read_64bit_gc0_register(source, sel)				\
-({ unsigned long long __res;						\
-	__asm__ __volatile__(						\
-		".set\tpush\n\t"					\
-		".set\tnoat\n\t"					\
-		"# dmfgc0\t$1, $%1, %2\n\t"				\
-		_ASM_INSN_IF_MIPS(0x40610100 | %1 << 11 | %2)		\
-		_ASM_INSN32_IF_MM(0x582004fc | %1 << 16 | %2 << 11)	\
-		"move\t%0, $1\n\t"					\
-		".set\tpop"						\
-		: "=r" (__res)						\
-		: "i" (source), "i" (sel));				\
-	__res;								\
-})
-
-#define __write_32bit_gc0_register(register, sel, value)		\
-do {									\
-	__asm__ __volatile__(						\
-		".set\tpush\n\t"					\
-		".set\tnoat\n\t"					\
-		"move\t$1, %z0\n\t"					\
-		"# mtgc0\t$1, $%1, %2\n\t"				\
-		_ASM_INSN_IF_MIPS(0x40610200 | %1 << 11 | %2)		\
-		_ASM_INSN32_IF_MM(0x002006fc | %1 << 16 | %2 << 11)	\
-		".set\tpop"						\
-		: : "Jr" ((unsigned int)(value)),			\
-		    "i" (register), "i" (sel));				\
-} while (0)
-
-#define __write_64bit_gc0_register(register, sel, value)		\
-do {									\
-	__asm__ __volatile__(						\
-		".set\tpush\n\t"					\
-		".set\tnoat\n\t"					\
-		"move\t$1, %z0\n\t"					\
-		"# dmtgc0\t$1, $%1, %2\n\t"				\
-		_ASM_INSN_IF_MIPS(0x40610300 | %1 << 11 | %2)		\
-		_ASM_INSN32_IF_MM(0x582006fc | %1 << 16 | %2 << 11)	\
-		".set\tpop"						\
-		: : "Jr" (value),					\
-		    "i" (register), "i" (sel));				\
-} while (0)
-
-#endif	/* !TOOLCHAIN_SUPPORTS_VIRT */
-
 #define __read_ulong_gc0_register(reg, sel)				\
 	((sizeof(unsigned long) == 4) ?					\
 	(unsigned long) __read_32bit_gc0_register(reg, sel) :		\
@@ -2664,8 +2628,6 @@ static inline void tlb_write_random(void)
 		".set reorder");
 }
 
-#ifdef TOOLCHAIN_SUPPORTS_VIRT
-
 /*
  * Guest TLB operations.
  *
@@ -2676,7 +2638,7 @@ static inline void guest_tlb_probe(void)
 	__asm__ __volatile__(
 		".set push\n\t"
 		".set noreorder\n\t"
-		".set virt\n\t"
+		_ASM_SET_VIRT
 		"tlbgp\n\t"
 		".set pop");
 }
@@ -2686,7 +2648,7 @@ static inline void guest_tlb_read(void)
 	__asm__ __volatile__(
 		".set push\n\t"
 		".set noreorder\n\t"
-		".set virt\n\t"
+		_ASM_SET_VIRT
 		"tlbgr\n\t"
 		".set pop");
 }
@@ -2696,7 +2658,7 @@ static inline void guest_tlb_write_indexed(void)
 	__asm__ __volatile__(
 		".set push\n\t"
 		".set noreorder\n\t"
-		".set virt\n\t"
+		_ASM_SET_VIRT
 		"tlbgwi\n\t"
 		".set pop");
 }
@@ -2706,7 +2668,7 @@ static inline void guest_tlb_write_random(void)
 	__asm__ __volatile__(
 		".set push\n\t"
 		".set noreorder\n\t"
-		".set virt\n\t"
+		_ASM_SET_VIRT
 		"tlbgwr\n\t"
 		".set pop");
 }
@@ -2719,63 +2681,11 @@ static inline void guest_tlbinvf(void)
 	__asm__ __volatile__(
 		".set push\n\t"
 		".set noreorder\n\t"
-		".set virt\n\t"
+		_ASM_SET_VIRT
 		"tlbginvf\n\t"
 		".set pop");
 }
 
-#else	/* TOOLCHAIN_SUPPORTS_VIRT */
-
-/*
- * Guest TLB operations.
- *
- * It is responsibility of the caller to take care of any TLB hazards.
- */
-static inline void guest_tlb_probe(void)
-{
-	__asm__ __volatile__(
-		"# tlbgp\n\t"
-		_ASM_INSN_IF_MIPS(0x42000010)
-		_ASM_INSN32_IF_MM(0x0000017c));
-}
-
-static inline void guest_tlb_read(void)
-{
-	__asm__ __volatile__(
-		"# tlbgr\n\t"
-		_ASM_INSN_IF_MIPS(0x42000009)
-		_ASM_INSN32_IF_MM(0x0000117c));
-}
-
-static inline void guest_tlb_write_indexed(void)
-{
-	__asm__ __volatile__(
-		"# tlbgwi\n\t"
-		_ASM_INSN_IF_MIPS(0x4200000a)
-		_ASM_INSN32_IF_MM(0x0000217c));
-}
-
-static inline void guest_tlb_write_random(void)
-{
-	__asm__ __volatile__(
-		"# tlbgwr\n\t"
-		_ASM_INSN_IF_MIPS(0x4200000e)
-		_ASM_INSN32_IF_MM(0x0000317c));
-}
-
-/*
- * Guest TLB Invalidate Flush
- */
-static inline void guest_tlbinvf(void)
-{
-	__asm__ __volatile__(
-		"# tlbginvf\n\t"
-		_ASM_INSN_IF_MIPS(0x4200000c)
-		_ASM_INSN32_IF_MM(0x0000517c));
-}
-
-#endif	/* !TOOLCHAIN_SUPPORTS_VIRT */
-
 /*
  * Manipulate bits in a register.
  */
-- 
git-series 0.9.1
