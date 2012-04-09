Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Apr 2012 17:26:16 +0200 (CEST)
Received: from home.bethel-hill.org ([63.228.164.32]:39811 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903696Ab2DIPWa (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Apr 2012 17:22:30 +0200
Received: by home.bethel-hill.org with esmtpsa (TLS1.0:DHE_RSA_AES_256_CBC_SHA1:32)
        (Exim 4.72)
        (envelope-from <sjhill@mips.com>)
        id 1SHGQB-0005vf-G2; Mon, 09 Apr 2012 10:22:23 -0500
From:   "Steven J. Hill" <sjhill@mips.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     "Steven J. Hill" <sjhill@mips.com>,
        Leonid Yegoshin <yegoshin@mips.com>
Subject: [PATCH 8/9] MIPS: Support microMIPS/MIPS16e unaligned accesses.
Date:   Mon,  9 Apr 2012 10:22:02 -0500
Message-Id: <1333984923-445-9-git-send-email-sjhill@mips.com>
X-Mailer: git-send-email 1.7.9.6
In-Reply-To: <1333984923-445-1-git-send-email-sjhill@mips.com>
References: <1333984923-445-1-git-send-email-sjhill@mips.com>
X-archive-position: 32900
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sjhill@mips.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

From: "Steven J. Hill" <sjhill@mips.com>

Add logic needed to properly handle unaligned accesses when
in microMIPS or MIPS16e modes.

Signed-off-by: Leonid Yegoshin <yegoshin@mips.com>
Signed-off-by: Steven J. Hill <sjhill@mips.com>
---
 arch/mips/kernel/process.c   |  101 +++
 arch/mips/kernel/unaligned.c | 1496 ++++++++++++++++++++++++++++++++++++------
 2 files changed, 1391 insertions(+), 206 deletions(-)

diff --git a/arch/mips/kernel/process.c b/arch/mips/kernel/process.c
index e9a5fd7..2f24d70 100644
--- a/arch/mips/kernel/process.c
+++ b/arch/mips/kernel/process.c
@@ -7,6 +7,7 @@
  * Copyright (C) 2005, 2006 by Ralf Baechle (ralf@linux-mips.org)
  * Copyright (C) 1999, 2000 Silicon Graphics, Inc.
  * Copyright (C) 2004 Thiemo Seufer
+ * Copyright (C) 2011  MIPS Technologies, Inc.
  */
 #include <linux/errno.h>
 #include <linux/sched.h>
@@ -262,34 +263,115 @@ struct mips_frame_info {
 
 static inline int is_ra_save_ins(union mips_instruction *ip)
 {
+#ifdef CONFIG_CPU_MICROMIPS
+	union mips_instruction mmi;
+
+	/*
+	 * swsp ra,offset
+	 * swm16 reglist,offset(sp)
+	 * swm32 reglist,offset(sp)
+	 * sw32 ra,offset(sp)
+	 * jradiussp - NOT SUPPORTED
+	 *
+	 * microMIPS is way more fun...
+	 */
+	if (mm_is16bit(ip->halfword[0])) {
+		mmi.word = (ip->halfword[0] << 16);
+		return ((mmi.mm16_r5_format.opcode == mm_swsp16_op &&
+			 mmi.mm16_r5_format.rt == 31) ||
+			(mmi.mm16_m_format.opcode == mm_pool16c_op &&
+			 mmi.mm16_m_format.func == mm_swm16_op));
+	}
+	else {
+		mmi.halfword[0] = ip->halfword[1];
+		mmi.halfword[1] = ip->halfword[0];
+		return ((mmi.mm_m_format.opcode == mm_pool32b_op &&
+			 mmi.mm_m_format.rd > 9 &&
+			 mmi.mm_m_format.base == 29 &&
+			 mmi.mm_m_format.func == mm_swm32_func) ||
+			(mmi.i_format.opcode == mm_sw32_op &&
+			 mmi.i_format.rs == 29 &&
+			 mmi.i_format.rt == 31));
+	}
+#else
 	/* sw / sd $ra, offset($sp) */
 	return (ip->i_format.opcode == sw_op || ip->i_format.opcode == sd_op) &&
 		ip->i_format.rs == 29 &&
 		ip->i_format.rt == 31;
+#endif
 }
 
 static inline int is_jal_jalr_jr_ins(union mips_instruction *ip)
 {
+#ifdef CONFIG_CPU_MICROMIPS
+	/*
+	 * jr16,jrc,jalr16,jalr16
+	 * jal
+	 * jalr/jr,jalr.hb/jr.hb,jalrs,jalrs.hb
+	 * jraddiusp - NOT SUPPORTED
+	 *
+	 * microMIPS is kind of more fun...
+	 */
+	union mips_instruction mmi;
+
+	mmi.word = (ip->halfword[0] << 16);
+
+	if ((mmi.mm16_r5_format.opcode == mm_pool16c_op &&
+	    (mmi.mm16_r5_format.rt & mm_jr16_op) == mm_jr16_op) ||
+	    ip->j_format.opcode == mm_jal32_op)
+		return 1;
+	if (ip->r_format.opcode != mm_pool32a_op ||
+			ip->r_format.func != mm_pool32axf_op) 
+		return 0;
+	return (((ip->u_format.uimmediate >> 6) & mm_jalr_op) == mm_jalr_op);
+#else
 	if (ip->j_format.opcode == jal_op)
 		return 1;
 	if (ip->r_format.opcode != spec_op)
 		return 0;
 	return ip->r_format.func == jalr_op || ip->r_format.func == jr_op;
+#endif
 }
 
 static inline int is_sp_move_ins(union mips_instruction *ip)
 {
+#ifdef CONFIG_CPU_MICROMIPS
+	/*
+	 * addiusp -imm
+	 * addius5 sp,-imm
+	 * addiu32 sp,sp,-imm
+	 * jradiussp - NOT SUPPORTED
+	 *
+	 * microMIPS is not more fun...
+	 */
+	if (mm_is16bit(ip->halfword[0])) {
+		union mips_instruction mmi;
+
+		mmi.word = (ip->halfword[0] << 16);
+		return ((mmi.mm16_r3_format.opcode == mm_pool16d_op &&
+			 mmi.mm16_r3_format.simmediate && mm_addiusp_func) ||
+			(mmi.mm16_r5_format.opcode == mm_pool16d_op &&
+			 mmi.mm16_r5_format.rt == 29));
+	}
+	return (ip->mm_i_format.opcode == mm_addiu32_op &&
+		 ip->mm_i_format.rt == 29 && ip->mm_i_format.rs == 29);
+#else
 	/* addiu/daddiu sp,sp,-imm */
 	if (ip->i_format.rs != 29 || ip->i_format.rt != 29)
 		return 0;
 	if (ip->i_format.opcode == addiu_op || ip->i_format.opcode == daddiu_op)
 		return 1;
+#endif
 	return 0;
 }
 
 static int get_frame_info(struct mips_frame_info *info)
 {
+#ifdef CONFIG_CPU_MICROMIPS
+	union mips_instruction *ip = (void *) (((char *) info->func) - 1);
+#else
 	union mips_instruction *ip = info->func;
+#endif
 	unsigned max_insns = info->func_size / sizeof(union mips_instruction);
 	unsigned i;
 
@@ -309,7 +391,26 @@ static int get_frame_info(struct mips_frame_info *info)
 			break;
 		if (!info->frame_size) {
 			if (is_sp_move_ins(ip))
+			{
+#ifdef CONFIG_CPU_MICROMIPS
+				if (mm_is16bit(ip->halfword[0]))
+				{
+					unsigned short tmp;
+
+					if (ip->halfword[0] & mm_addiusp_func)
+					{
+						tmp = (((ip->halfword[0] >> 1) & 0x1ff) << 2);
+						info->frame_size = -(signed short)(tmp | ((tmp & 0x100) ? 0xfe00 : 0));
+					} else {
+						tmp = (ip->halfword[0] >> 1);
+						info->frame_size = -(signed short)(tmp & 0xf);
+					}
+					ip = (void *) &ip->halfword[1];
+					ip--;
+				} else
+#endif
 				info->frame_size = - ip->i_format.simmediate;
+			}
 			continue;
 		}
 		if (info->pc_offset == -1 && is_ra_save_ins(ip)) {
diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 9c58bdf..6a9927a 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -85,6 +85,8 @@
 #include <asm/cop2.h>
 #include <asm/inst.h>
 #include <asm/uaccess.h>
+#include <asm/fpu.h>
+#include <asm/fpu_emulator.h>
 
 #define STR(x)  __STR(x)
 #define __STR(x)  #x
@@ -102,12 +104,333 @@ static u32 unaligned_action;
 #endif
 extern void show_registers(struct pt_regs *regs);
 
+#ifdef __BIG_ENDIAN
+#define     LoadHW(addr, value, res)  \
+		__asm__ __volatile__ (".set\tnoat\n"        \
+			"1:\tlb\t%0, 0(%2)\n"               \
+			"2:\tlbu\t$1, 1(%2)\n\t"            \
+			"sll\t%0, 0x8\n\t"                  \
+			"or\t%0, $1\n\t"                    \
+			"li\t%1, 0\n"                       \
+			"3:\t.set\tat\n\t"                  \
+			".insn\n\t"                         \
+			".section\t.fixup,\"ax\"\n\t"       \
+			"4:\tli\t%1, %3\n\t"                \
+			"j\t3b\n\t"                         \
+			".previous\n\t"                     \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 4b\n\t"              \
+			STR(PTR)"\t2b, 4b\n\t"              \
+			".previous"                         \
+			: "=&r" (value), "=r" (res)         \
+			: "r" (addr), "i" (-EFAULT));
+
+#define     LoadW(addr, value, res)   \
+		__asm__ __volatile__ (                      \
+			"1:\tlwl\t%0, (%2)\n"               \
+			"2:\tlwr\t%0, 3(%2)\n\t"            \
+			"li\t%1, 0\n"                       \
+			"3:\n\t"                            \
+			".insn\n\t"                         \
+			".section\t.fixup,\"ax\"\n\t"       \
+			"4:\tli\t%1, %3\n\t"                \
+			"j\t3b\n\t"                         \
+			".previous\n\t"                     \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 4b\n\t"              \
+			STR(PTR)"\t2b, 4b\n\t"              \
+			".previous"                         \
+			: "=&r" (value), "=r" (res)         \
+			: "r" (addr), "i" (-EFAULT));
+
+#define     LoadHWU(addr, value, res) \
+		__asm__ __volatile__ (                      \
+			".set\tnoat\n"                      \
+			"1:\tlbu\t%0, 0(%2)\n"              \
+			"2:\tlbu\t$1, 1(%2)\n\t"            \
+			"sll\t%0, 0x8\n\t"                  \
+			"or\t%0, $1\n\t"                    \
+			"li\t%1, 0\n"                       \
+			"3:\n\t"                            \
+			".insn\n\t"                         \
+			".set\tat\n\t"                      \
+			".section\t.fixup,\"ax\"\n\t"       \
+			"4:\tli\t%1, %3\n\t"                \
+			"j\t3b\n\t"                         \
+			".previous\n\t"                     \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 4b\n\t"              \
+			STR(PTR)"\t2b, 4b\n\t"              \
+			".previous"                         \
+			: "=&r" (value), "=r" (res)         \
+			: "r" (addr), "i" (-EFAULT));
+
+#define     LoadWU(addr, value, res)  \
+		__asm__ __volatile__ (                      \
+			"1:\tlwl\t%0, (%2)\n"               \
+			"2:\tlwr\t%0, 3(%2)\n\t"            \
+			"dsll\t%0, %0, 32\n\t"              \
+			"dsrl\t%0, %0, 32\n\t"              \
+			"li\t%1, 0\n"                       \
+			"3:\n\t"                            \
+			".insn\n\t"                         \
+			"\t.section\t.fixup,\"ax\"\n\t"     \
+			"4:\tli\t%1, %3\n\t"                \
+			"j\t3b\n\t"                         \
+			".previous\n\t"                     \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 4b\n\t"              \
+			STR(PTR)"\t2b, 4b\n\t"              \
+			".previous"                         \
+			: "=&r" (value), "=r" (res)         \
+			: "r" (addr), "i" (-EFAULT));
+
+#define     LoadDW(addr, value, res)  \
+		__asm__ __volatile__ (                      \
+			"1:\tldl\t%0, (%2)\n"               \
+			"2:\tldr\t%0, 7(%2)\n\t"            \
+			"li\t%1, 0\n"                       \
+			"3:\n\t"                            \
+			".insn\n\t"                         \
+			"\t.section\t.fixup,\"ax\"\n\t"     \
+			"4:\tli\t%1, %3\n\t"                \
+			"j\t3b\n\t"                         \
+			".previous\n\t"                     \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 4b\n\t"              \
+			STR(PTR)"\t2b, 4b\n\t"              \
+			".previous"                         \
+			: "=&r" (value), "=r" (res)         \
+			: "r" (addr), "i" (-EFAULT));
+
+#define     StoreHW(addr, value, res) \
+		__asm__ __volatile__ (                      \
+			".set\tnoat\n"                      \
+			"1:\tsb\t%1, 1(%2)\n\t"             \
+			"srl\t$1, %1, 0x8\n"                \
+			"2:\tsb\t$1, 0(%2)\n\t"             \
+			".set\tat\n\t"                      \
+			"li\t%0, 0\n"                       \
+			"3:\n\t"                            \
+			".insn\n\t"                         \
+			".section\t.fixup,\"ax\"\n\t"       \
+			"4:\tli\t%0, %3\n\t"                \
+			"j\t3b\n\t"                         \
+			".previous\n\t"                     \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 4b\n\t"              \
+			STR(PTR)"\t2b, 4b\n\t"              \
+			".previous"                         \
+			: "=r" (res)                        \
+			: "r" (value), "r" (addr), "i" (-EFAULT));
+
+#define     StoreW(addr, value, res)  \
+		__asm__ __volatile__ (                      \
+			"1:\tswl\t%1,(%2)\n"                \
+			"2:\tswr\t%1, 3(%2)\n\t"            \
+			"li\t%0, 0\n"                       \
+			"3:\n\t"                            \
+			".insn\n\t"                         \
+			".section\t.fixup,\"ax\"\n\t"       \
+			"4:\tli\t%0, %3\n\t"                \
+			"j\t3b\n\t"                         \
+			".previous\n\t"                     \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 4b\n\t"              \
+			STR(PTR)"\t2b, 4b\n\t"              \
+			".previous"                         \
+		: "=r" (res)                                \
+		: "r" (value), "r" (addr), "i" (-EFAULT));
+
+#define     StoreDW(addr, value, res) \
+		__asm__ __volatile__ (                      \
+			"1:\tsdl\t%1,(%2)\n"                \
+			"2:\tsdr\t%1, 7(%2)\n\t"            \
+			"li\t%0, 0\n"                       \
+			"3:\n\t"                            \
+			".insn\n\t"                         \
+			".section\t.fixup,\"ax\"\n\t"       \
+			"4:\tli\t%0, %3\n\t"                \
+			"j\t3b\n\t"                         \
+			".previous\n\t"                     \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 4b\n\t"              \
+			STR(PTR)"\t2b, 4b\n\t"              \
+			".previous"                         \
+		: "=r" (res)                                \
+		: "r" (value), "r" (addr), "i" (-EFAULT));
+#endif
+
+#ifdef __LITTLE_ENDIAN
+#define     LoadHW(addr, value, res)  \
+		__asm__ __volatile__ (".set\tnoat\n"        \
+			"1:\tlb\t%0, 1(%2)\n"               \
+			"2:\tlbu\t$1, 0(%2)\n\t"            \
+			"sll\t%0, 0x8\n\t"                  \
+			"or\t%0, $1\n\t"                    \
+			"li\t%1, 0\n"                       \
+			"3:\t.set\tat\n\t"                  \
+			".insn\n\t"                         \
+			".section\t.fixup,\"ax\"\n\t"       \
+			"4:\tli\t%1, %3\n\t"                \
+			"j\t3b\n\t"                         \
+			".previous\n\t"                     \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 4b\n\t"              \
+			STR(PTR)"\t2b, 4b\n\t"              \
+			".previous"                         \
+			: "=&r" (value), "=r" (res)         \
+			: "r" (addr), "i" (-EFAULT));
+
+#define     LoadW(addr, value, res)   \
+		__asm__ __volatile__ (                      \
+			"1:\tlwl\t%0, 3(%2)\n"              \
+			"2:\tlwr\t%0, (%2)\n\t"             \
+			"li\t%1, 0\n"                       \
+			"3:\n\t"                            \
+			".insn\n\t"                         \
+			".section\t.fixup,\"ax\"\n\t"       \
+			"4:\tli\t%1, %3\n\t"                \
+			"j\t3b\n\t"                         \
+			".previous\n\t"                     \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 4b\n\t"              \
+			STR(PTR)"\t2b, 4b\n\t"              \
+			".previous"                         \
+			: "=&r" (value), "=r" (res)         \
+			: "r" (addr), "i" (-EFAULT));
+
+#define     LoadHWU(addr, value, res) \
+		__asm__ __volatile__ (                      \
+			".set\tnoat\n"                      \
+			"1:\tlbu\t%0, 1(%2)\n"              \
+			"2:\tlbu\t$1, 0(%2)\n\t"            \
+			"sll\t%0, 0x8\n\t"                  \
+			"or\t%0, $1\n\t"                    \
+			"li\t%1, 0\n"                       \
+			"3:\n\t"                            \
+			".insn\n\t"                         \
+			".set\tat\n\t"                      \
+			".section\t.fixup,\"ax\"\n\t"       \
+			"4:\tli\t%1, %3\n\t"                \
+			"j\t3b\n\t"                         \
+			".previous\n\t"                     \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 4b\n\t"              \
+			STR(PTR)"\t2b, 4b\n\t"              \
+			".previous"                         \
+			: "=&r" (value), "=r" (res)         \
+			: "r" (addr), "i" (-EFAULT));
+
+#define     LoadWU(addr, value, res)  \
+		__asm__ __volatile__ (                      \
+			"1:\tlwl\t%0, 3(%2)\n"              \
+			"2:\tlwr\t%0, (%2)\n\t"             \
+			"dsll\t%0, %0, 32\n\t"              \
+			"dsrl\t%0, %0, 32\n\t"              \
+			"li\t%1, 0\n"                       \
+			"3:\n\t"                            \
+			".insn\n\t"                         \
+			"\t.section\t.fixup,\"ax\"\n\t"     \
+			"4:\tli\t%1, %3\n\t"                \
+			"j\t3b\n\t"                         \
+			".previous\n\t"                     \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 4b\n\t"              \
+			STR(PTR)"\t2b, 4b\n\t"              \
+			".previous"                         \
+			: "=&r" (value), "=r" (res)         \
+			: "r" (addr), "i" (-EFAULT));
+
+#define     LoadDW(addr, value, res)  \
+		__asm__ __volatile__ (                      \
+			"1:\tldl\t%0, 7(%2)\n"              \
+			"2:\tldr\t%0, (%2)\n\t"             \
+			"li\t%1, 0\n"                       \
+			"3:\n\t"                            \
+			".insn\n\t"                         \
+			"\t.section\t.fixup,\"ax\"\n\t"     \
+			"4:\tli\t%1, %3\n\t"                \
+			"j\t3b\n\t"                         \
+			".previous\n\t"                     \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 4b\n\t"              \
+			STR(PTR)"\t2b, 4b\n\t"              \
+			".previous"                         \
+			: "=&r" (value), "=r" (res)         \
+			: "r" (addr), "i" (-EFAULT));
+
+#define     StoreHW(addr, value, res) \
+		__asm__ __volatile__ (                      \
+			".set\tnoat\n"                      \
+			"1:\tsb\t%1, 0(%2)\n\t"             \
+			"srl\t$1,%1, 0x8\n"                 \
+			"2:\tsb\t$1, 1(%2)\n\t"             \
+			".set\tat\n\t"                      \
+			"li\t%0, 0\n"                       \
+			"3:\n\t"                            \
+			".insn\n\t"                         \
+			".section\t.fixup,\"ax\"\n\t"       \
+			"4:\tli\t%0, %3\n\t"                \
+			"j\t3b\n\t"                         \
+			".previous\n\t"                     \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 4b\n\t"              \
+			STR(PTR)"\t2b, 4b\n\t"              \
+			".previous"                         \
+			: "=r" (res)                        \
+			: "r" (value), "r" (addr), "i" (-EFAULT));
+
+#define     StoreW(addr, value, res)  \
+		__asm__ __volatile__ (                      \
+			"1:\tswl\t%1, 3(%2)\n"              \
+			"2:\tswr\t%1, (%2)\n\t"             \
+			"li\t%0, 0\n"                       \
+			"3:\n\t"                            \
+			".insn\n\t"                         \
+			".section\t.fixup,\"ax\"\n\t"       \
+			"4:\tli\t%0, %3\n\t"                \
+			"j\t3b\n\t"                         \
+			".previous\n\t"                     \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 4b\n\t"              \
+			STR(PTR)"\t2b, 4b\n\t"              \
+			".previous"                         \
+		: "=r" (res)                                \
+		: "r" (value), "r" (addr), "i" (-EFAULT));
+
+#define     StoreDW(addr, value, res) \
+		__asm__ __volatile__ (                      \
+			"1:\tsdl\t%1, 7(%2)\n"              \
+			"2:\tsdr\t%1, (%2)\n\t"             \
+			"li\t%0, 0\n"                       \
+			"3:\n\t"                            \
+			".insn\n\t"                         \
+			".section\t.fixup,\"ax\"\n\t"       \
+			"4:\tli\t%0, %3\n\t"                \
+			"j\t3b\n\t"                         \
+			".previous\n\t"                     \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 4b\n\t"              \
+			STR(PTR)"\t2b, 4b\n\t"              \
+			".previous"                         \
+		: "=r" (res)                                \
+		: "r" (value), "r" (addr), "i" (-EFAULT));
+#endif
+
 static void emulate_load_store_insn(struct pt_regs *regs,
-	void __user *addr, unsigned int __user *pc)
+				    void __user *addr,
+				    unsigned int __user *pc)
 {
 	union mips_instruction insn;
 	unsigned long value;
 	unsigned int res;
+	unsigned long origpc;
+	unsigned long orig31;
+	void __user *fault_addr = NULL;
+
+	origpc = (unsigned long)pc;
+	orig31 = regs->regs[31];
 
 	perf_sw_event(PERF_COUNT_SW_EMULATION_FAULTS, 1, regs, 0);
 
@@ -117,22 +440,22 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 	__get_user(insn.word, pc);
 
 	switch (insn.i_format.opcode) {
-	/*
-	 * These are instructions that a compiler doesn't generate.  We
-	 * can assume therefore that the code is MIPS-aware and
-	 * really buggy.  Emulating these instructions would break the
-	 * semantics anyway.
-	 */
+		/*
+		 * These are instructions that a compiler doesn't generate.  We
+		 * can assume therefore that the code is MIPS-aware and
+		 * really buggy.  Emulating these instructions would break the
+		 * semantics anyway.
+		 */
 	case ll_op:
 	case lld_op:
 	case sc_op:
 	case scd_op:
 
-	/*
-	 * For these instructions the only way to create an address
-	 * error is an attempted access to kernel/supervisor address
-	 * space.
-	 */
+		/*
+		 * For these instructions the only way to create an address
+		 * error is an attempted access to kernel/supervisor address
+		 * space.
+		 */
 	case ldl_op:
 	case ldr_op:
 	case lwl_op:
@@ -146,36 +469,15 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 	case sb_op:
 		goto sigbus;
 
-	/*
-	 * The remaining opcodes are the ones that are really of interest.
-	 */
+		/*
+		 * The remaining opcodes are the ones that are really of
+		 * interest.
+		 */
 	case lh_op:
 		if (!access_ok(VERIFY_READ, addr, 2))
 			goto sigbus;
 
-		__asm__ __volatile__ (".set\tnoat\n"
-#ifdef __BIG_ENDIAN
-			"1:\tlb\t%0, 0(%2)\n"
-			"2:\tlbu\t$1, 1(%2)\n\t"
-#endif
-#ifdef __LITTLE_ENDIAN
-			"1:\tlb\t%0, 1(%2)\n"
-			"2:\tlbu\t$1, 0(%2)\n\t"
-#endif
-			"sll\t%0, 0x8\n\t"
-			"or\t%0, $1\n\t"
-			"li\t%1, 0\n"
-			"3:\t.set\tat\n\t"
-			".section\t.fixup,\"ax\"\n\t"
-			"4:\tli\t%1, %3\n\t"
-			"j\t3b\n\t"
-			".previous\n\t"
-			".section\t__ex_table,\"a\"\n\t"
-			STR(PTR)"\t1b, 4b\n\t"
-			STR(PTR)"\t2b, 4b\n\t"
-			".previous"
-			: "=&r" (value), "=r" (res)
-			: "r" (addr), "i" (-EFAULT));
+		LoadHW(addr, value, res);
 		if (res)
 			goto fault;
 		compute_return_epc(regs);
@@ -186,26 +488,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		if (!access_ok(VERIFY_READ, addr, 4))
 			goto sigbus;
 
-		__asm__ __volatile__ (
-#ifdef __BIG_ENDIAN
-			"1:\tlwl\t%0, (%2)\n"
-			"2:\tlwr\t%0, 3(%2)\n\t"
-#endif
-#ifdef __LITTLE_ENDIAN
-			"1:\tlwl\t%0, 3(%2)\n"
-			"2:\tlwr\t%0, (%2)\n\t"
-#endif
-			"li\t%1, 0\n"
-			"3:\t.section\t.fixup,\"ax\"\n\t"
-			"4:\tli\t%1, %3\n\t"
-			"j\t3b\n\t"
-			".previous\n\t"
-			".section\t__ex_table,\"a\"\n\t"
-			STR(PTR)"\t1b, 4b\n\t"
-			STR(PTR)"\t2b, 4b\n\t"
-			".previous"
-			: "=&r" (value), "=r" (res)
-			: "r" (addr), "i" (-EFAULT));
+		LoadW(addr, value, res);
 		if (res)
 			goto fault;
 		compute_return_epc(regs);
@@ -216,30 +499,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		if (!access_ok(VERIFY_READ, addr, 2))
 			goto sigbus;
 
-		__asm__ __volatile__ (
-			".set\tnoat\n"
-#ifdef __BIG_ENDIAN
-			"1:\tlbu\t%0, 0(%2)\n"
-			"2:\tlbu\t$1, 1(%2)\n\t"
-#endif
-#ifdef __LITTLE_ENDIAN
-			"1:\tlbu\t%0, 1(%2)\n"
-			"2:\tlbu\t$1, 0(%2)\n\t"
-#endif
-			"sll\t%0, 0x8\n\t"
-			"or\t%0, $1\n\t"
-			"li\t%1, 0\n"
-			"3:\t.set\tat\n\t"
-			".section\t.fixup,\"ax\"\n\t"
-			"4:\tli\t%1, %3\n\t"
-			"j\t3b\n\t"
-			".previous\n\t"
-			".section\t__ex_table,\"a\"\n\t"
-			STR(PTR)"\t1b, 4b\n\t"
-			STR(PTR)"\t2b, 4b\n\t"
-			".previous"
-			: "=&r" (value), "=r" (res)
-			: "r" (addr), "i" (-EFAULT));
+		LoadHWU(addr, value, res);
 		if (res)
 			goto fault;
 		compute_return_epc(regs);
@@ -258,28 +518,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		if (!access_ok(VERIFY_READ, addr, 4))
 			goto sigbus;
 
-		__asm__ __volatile__ (
-#ifdef __BIG_ENDIAN
-			"1:\tlwl\t%0, (%2)\n"
-			"2:\tlwr\t%0, 3(%2)\n\t"
-#endif
-#ifdef __LITTLE_ENDIAN
-			"1:\tlwl\t%0, 3(%2)\n"
-			"2:\tlwr\t%0, (%2)\n\t"
-#endif
-			"dsll\t%0, %0, 32\n\t"
-			"dsrl\t%0, %0, 32\n\t"
-			"li\t%1, 0\n"
-			"3:\t.section\t.fixup,\"ax\"\n\t"
-			"4:\tli\t%1, %3\n\t"
-			"j\t3b\n\t"
-			".previous\n\t"
-			".section\t__ex_table,\"a\"\n\t"
-			STR(PTR)"\t1b, 4b\n\t"
-			STR(PTR)"\t2b, 4b\n\t"
-			".previous"
-			: "=&r" (value), "=r" (res)
-			: "r" (addr), "i" (-EFAULT));
+		LoadWU(addr, value, res);
 		if (res)
 			goto fault;
 		compute_return_epc(regs);
@@ -302,26 +541,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		if (!access_ok(VERIFY_READ, addr, 8))
 			goto sigbus;
 
-		__asm__ __volatile__ (
-#ifdef __BIG_ENDIAN
-			"1:\tldl\t%0, (%2)\n"
-			"2:\tldr\t%0, 7(%2)\n\t"
-#endif
-#ifdef __LITTLE_ENDIAN
-			"1:\tldl\t%0, 7(%2)\n"
-			"2:\tldr\t%0, (%2)\n\t"
-#endif
-			"li\t%1, 0\n"
-			"3:\t.section\t.fixup,\"ax\"\n\t"
-			"4:\tli\t%1, %3\n\t"
-			"j\t3b\n\t"
-			".previous\n\t"
-			".section\t__ex_table,\"a\"\n\t"
-			STR(PTR)"\t1b, 4b\n\t"
-			STR(PTR)"\t2b, 4b\n\t"
-			".previous"
-			: "=&r" (value), "=r" (res)
-			: "r" (addr), "i" (-EFAULT));
+		LoadDW(addr, value, res);
 		if (res)
 			goto fault;
 		compute_return_epc(regs);
@@ -336,68 +556,22 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		if (!access_ok(VERIFY_WRITE, addr, 2))
 			goto sigbus;
 
+		compute_return_epc(regs);
 		value = regs->regs[insn.i_format.rt];
-		__asm__ __volatile__ (
-#ifdef __BIG_ENDIAN
-			".set\tnoat\n"
-			"1:\tsb\t%1, 1(%2)\n\t"
-			"srl\t$1, %1, 0x8\n"
-			"2:\tsb\t$1, 0(%2)\n\t"
-			".set\tat\n\t"
-#endif
-#ifdef __LITTLE_ENDIAN
-			".set\tnoat\n"
-			"1:\tsb\t%1, 0(%2)\n\t"
-			"srl\t$1,%1, 0x8\n"
-			"2:\tsb\t$1, 1(%2)\n\t"
-			".set\tat\n\t"
-#endif
-			"li\t%0, 0\n"
-			"3:\n\t"
-			".section\t.fixup,\"ax\"\n\t"
-			"4:\tli\t%0, %3\n\t"
-			"j\t3b\n\t"
-			".previous\n\t"
-			".section\t__ex_table,\"a\"\n\t"
-			STR(PTR)"\t1b, 4b\n\t"
-			STR(PTR)"\t2b, 4b\n\t"
-			".previous"
-			: "=r" (res)
-			: "r" (value), "r" (addr), "i" (-EFAULT));
+		StoreHW(addr, value, res);
 		if (res)
 			goto fault;
-		compute_return_epc(regs);
 		break;
 
 	case sw_op:
 		if (!access_ok(VERIFY_WRITE, addr, 4))
 			goto sigbus;
 
+		compute_return_epc(regs);
 		value = regs->regs[insn.i_format.rt];
-		__asm__ __volatile__ (
-#ifdef __BIG_ENDIAN
-			"1:\tswl\t%1,(%2)\n"
-			"2:\tswr\t%1, 3(%2)\n\t"
-#endif
-#ifdef __LITTLE_ENDIAN
-			"1:\tswl\t%1, 3(%2)\n"
-			"2:\tswr\t%1, (%2)\n\t"
-#endif
-			"li\t%0, 0\n"
-			"3:\n\t"
-			".section\t.fixup,\"ax\"\n\t"
-			"4:\tli\t%0, %3\n\t"
-			"j\t3b\n\t"
-			".previous\n\t"
-			".section\t__ex_table,\"a\"\n\t"
-			STR(PTR)"\t1b, 4b\n\t"
-			STR(PTR)"\t2b, 4b\n\t"
-			".previous"
-		: "=r" (res)
-		: "r" (value), "r" (addr), "i" (-EFAULT));
+		StoreW(addr, value, res);
 		if (res)
 			goto fault;
-		compute_return_epc(regs);
 		break;
 
 	case sd_op:
@@ -412,31 +586,11 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 		if (!access_ok(VERIFY_WRITE, addr, 8))
 			goto sigbus;
 
+		compute_return_epc(regs);
 		value = regs->regs[insn.i_format.rt];
-		__asm__ __volatile__ (
-#ifdef __BIG_ENDIAN
-			"1:\tsdl\t%1,(%2)\n"
-			"2:\tsdr\t%1, 7(%2)\n\t"
-#endif
-#ifdef __LITTLE_ENDIAN
-			"1:\tsdl\t%1, 7(%2)\n"
-			"2:\tsdr\t%1, (%2)\n\t"
-#endif
-			"li\t%0, 0\n"
-			"3:\n\t"
-			".section\t.fixup,\"ax\"\n\t"
-			"4:\tli\t%0, %3\n\t"
-			"j\t3b\n\t"
-			".previous\n\t"
-			".section\t__ex_table,\"a\"\n\t"
-			STR(PTR)"\t1b, 4b\n\t"
-			STR(PTR)"\t2b, 4b\n\t"
-			".previous"
-		: "=r" (res)
-		: "r" (value), "r" (addr), "i" (-EFAULT));
+		StoreDW(addr, value, res);
 		if (res)
 			goto fault;
-		compute_return_epc(regs);
 		break;
 #endif /* CONFIG_64BIT */
 
@@ -447,10 +601,21 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 	case ldc1_op:
 	case swc1_op:
 	case sdc1_op:
-		/*
-		 * I herewith declare: this does not happen.  So send SIGBUS.
-		 */
-		goto sigbus;
+		die_if_kernel("Unaligned FP access in kernel code", regs);
+		BUG_ON(!used_math());
+		BUG_ON(!is_fpu_owner());
+
+		lose_fpu(1);	/* save the FPU state for the emulator */
+		res = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
+					       &fault_addr);
+		own_fpu(1);	/* restore FPU state */
+
+		/* If something went wrong, signal */
+		process_fpemu_return(res, fault_addr);
+
+		if (res == 0)
+			break;
+		return;
 
 	/*
 	 * COP2 is available to implementor for application specific use.
@@ -488,6 +653,883 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 	return;
 
 fault:
+	/* roll back jump/branch */
+	regs->cp0_epc = origpc;
+	regs->regs[31] = orig31;
+	/* Did we have an exception handler installed? */
+	if (fixup_exception(regs))
+		return;
+
+	die_if_kernel("Unhandled kernel unaligned access", regs);
+	force_sig(SIGSEGV, current);
+
+	return;
+
+sigbus:
+	die_if_kernel("Unhandled kernel unaligned access", regs);
+	force_sig(SIGBUS, current);
+
+	return;
+
+sigill:
+	die_if_kernel
+	    ("Unhandled kernel unaligned access or invalid instruction", regs);
+	force_sig(SIGILL, current);
+}
+
+/*  recode table from micromips register notation to GPR */
+static int mmreg16to32[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
+
+/*  recode table from micromips STORE register notation to GPR */
+static int mmreg16to32_st[] = { 0, 17, 2, 3, 4, 5, 6, 7 };
+
+void emulate_load_store_microMIPS(struct pt_regs *regs, void __user * addr)
+{
+	unsigned long value;
+	unsigned int res;
+	int i;
+	unsigned int reg = 0, rvar;
+	unsigned long orig31;
+	u16 __user *pc16;
+	u16 halfword;
+	unsigned int word;
+	unsigned long origpc, contpc;
+	union mips_instruction insn;
+	struct decoded_instn mminst;
+	void __user *fault_addr = NULL;
+
+	origpc = regs->cp0_epc;
+	orig31 = regs->regs[31];
+
+	mminst.micro_mips_mode = 1;
+
+	/*
+	 * This load never faults.
+	 */
+	pc16 = (unsigned short __user *)(regs->cp0_epc & ~MIPS_ISA_MODE);
+	__get_user(halfword, pc16);
+	pc16++;
+	contpc = regs->cp0_epc + 2;
+	word = ((unsigned int)halfword << 16);
+	mminst.pc_inc = 2;
+
+	if (!mm_is16bit(halfword)) {
+		__get_user(halfword, pc16);
+		pc16++;
+		contpc = regs->cp0_epc + 4;
+		mminst.pc_inc = 4;
+		word |= halfword;
+	}
+	mminst.insn = word;
+
+	if (get_user(halfword, pc16))
+		goto fault;
+	mminst.next_pc_inc = 2;
+	word = ((unsigned int)halfword << 16);
+
+	if (!mm_is16bit(halfword)) {
+		pc16++;
+		if (get_user(halfword, pc16))
+			goto fault;
+		mminst.next_pc_inc = 4;
+		word |= halfword;
+	}
+	mminst.next_insn = word;
+
+	insn = (union mips_instruction)(mminst.insn);
+	if (mm_isBranchInstr(regs, mminst, &contpc))
+		insn = (union mips_instruction)(mminst.next_insn);
+
+	/*  Parse instruction to find what to do */
+
+	switch (insn.mm_i_format.opcode) {
+
+	case mm_pool32a_op:
+		switch (insn.mm_x_format.func) {
+		case mm_lwxs_op:
+			reg = insn.mm_x_format.rd;
+			goto loadW;
+		}
+
+		goto sigbus;
+
+	case mm_pool32b_op:
+		switch (insn.mm_m_format.func) {
+		case mm_lwp_func:
+			reg = insn.mm_m_format.rd;
+			if (reg == 31)
+				goto sigbus;
+
+			if (!access_ok(VERIFY_READ, addr, 8))
+				goto sigbus;
+
+			LoadW(addr, value, res);
+			if (res)
+				goto fault;
+			regs->regs[reg] = value;
+			addr += 4;
+			LoadW(addr, value, res);
+			if (res)
+				goto fault;
+			regs->regs[reg + 1] = value;
+			goto success;
+
+		case mm_swp_func:
+			reg = insn.mm_m_format.rd;
+			if (reg == 31)
+				goto sigbus;
+
+			if (!access_ok(VERIFY_WRITE, addr, 8))
+				goto sigbus;
+
+			value = regs->regs[reg];
+			StoreW(addr, value, res);
+			if (res)
+				goto fault;
+			addr += 4;
+			value = regs->regs[reg + 1];
+			StoreW(addr, value, res);
+			if (res)
+				goto fault;
+			goto success;
+
+		case mm_ldp_func:
+#ifdef CONFIG_64BIT
+			reg = insn.mm_m_format.rd;
+			if (reg == 31)
+				goto sigbus;
+
+			if (!access_ok(VERIFY_READ, addr, 16))
+				goto sigbus;
+
+			LoadDW(addr, value, res);
+			if (res)
+				goto fault;
+			regs->regs[reg] = value;
+			addr += 8;
+			LoadDW(addr, value, res);
+			if (res)
+				goto fault;
+			regs->regs[reg + 1] = value;
+			goto success;
+#endif /* CONFIG_64BIT */
+
+			goto sigill;
+
+		case mm_sdp_func:
+#ifdef CONFIG_64BIT
+			reg = insn.mm_m_format.rd;
+			if (reg == 31)
+				goto sigbus;
+
+			if (!access_ok(VERIFY_WRITE, addr, 16))
+				goto sigbus;
+
+			value = regs->regs[reg];
+			StoreDW(addr, value, res);
+			if (res)
+				goto fault;
+			addr += 8;
+			value = regs->regs[reg + 1];
+			StoreDW(addr, value, res);
+			if (res)
+				goto fault;
+			goto success;
+#endif /* CONFIG_64BIT */
+
+			goto sigill;
+
+		case mm_lwm32_func:
+			reg = insn.mm_m_format.rd;
+			rvar = reg & 0xf;
+			if ((rvar > 9) || !reg)
+				goto sigill;
+			if (reg & 0x10) {
+				if (!access_ok
+				    (VERIFY_READ, addr, 4 * (rvar + 1)))
+					goto sigbus;
+			} else {
+				if (!access_ok(VERIFY_READ, addr, 4 * rvar))
+					goto sigbus;
+			}
+			if (rvar == 9)
+				rvar = 8;
+			for (i = 16; rvar; rvar--, i++) {
+				LoadW(addr, value, res);
+				if (res)
+					goto fault;
+				addr += 4;
+				regs->regs[i] = value;
+			}
+			if ((reg & 0xf) == 9) {
+				LoadW(addr, value, res);
+				if (res)
+					goto fault;
+				addr += 4;
+				regs->regs[30] = value;
+			}
+			if (reg & 0x10) {
+				LoadW(addr, value, res);
+				if (res)
+					goto fault;
+				regs->regs[31] = value;
+			}
+			goto success;
+
+		case mm_swm32_func:
+			reg = insn.mm_m_format.rd;
+			rvar = reg & 0xf;
+			if ((rvar > 9) || !reg)
+				goto sigill;
+			if (reg & 0x10) {
+				if (!access_ok
+				    (VERIFY_WRITE, addr, 4 * (rvar + 1)))
+					goto sigbus;
+			} else {
+				if (!access_ok(VERIFY_WRITE, addr, 4 * rvar))
+					goto sigbus;
+			}
+			if (rvar == 9)
+				rvar = 8;
+			for (i = 16; rvar; rvar--, i++) {
+				value = regs->regs[i];
+				StoreW(addr, value, res);
+				if (res)
+					goto fault;
+				addr += 4;
+			}
+			if ((reg & 0xf) == 9) {
+				value = regs->regs[30];
+				StoreW(addr, value, res);
+				if (res)
+					goto fault;
+				addr += 4;
+			}
+			if (reg & 0x10) {
+				value = regs->regs[31];
+				StoreW(addr, value, res);
+				if (res)
+					goto fault;
+			}
+			goto success;
+
+		case mm_ldm_func:
+#ifdef CONFIG_64BIT
+			reg = insn.mm_m_format.rd;
+			rvar = reg & 0xf;
+			if ((rvar > 9) || !reg)
+				goto sigill;
+			if (reg & 0x10) {
+				if (!access_ok
+				    (VERIFY_READ, addr, 8 * (rvar + 1)))
+					goto sigbus;
+			} else {
+				if (!access_ok(VERIFY_READ, addr, 8 * rvar))
+					goto sigbus;
+			}
+			if (rvar == 9)
+				rvar = 8;
+
+			for (i = 16; rvar; rvar--, i++) {
+				LoadDW(addr, value, res);
+				if (res)
+					goto fault;
+				addr += 4;
+				regs->regs[i] = value;
+			}
+			if ((reg & 0xf) == 9) {
+				LoadDW(addr, value, res);
+				if (res)
+					goto fault;
+				addr += 8;
+				regs->regs[30] = value;
+			}
+			if (reg & 0x10) {
+				LoadDW(addr, value, res);
+				if (res)
+					goto fault;
+				regs->regs[31] = value;
+			}
+			goto success;
+#endif /* CONFIG_64BIT */
+
+			goto sigill;
+
+		case mm_sdm_func:
+#ifdef CONFIG_64BIT
+			reg = insn.mm_m_format.rd;
+			rvar = reg & 0xf;
+			if ((rvar > 9) || !reg)
+				goto sigill;
+			if (reg & 0x10) {
+				if (!access_ok
+				    (VERIFY_WRITE, addr, 8 * (rvar + 1)))
+					goto sigbus;
+			} else {
+				if (!access_ok(VERIFY_WRITE, addr, 8 * rvar))
+					goto sigbus;
+			}
+			if (rvar == 9)
+				rvar = 8;
+
+			for (i = 16; rvar; rvar--, i++) {
+				value = regs->regs[i];
+				StoreDW(addr, value, res);
+				if (res)
+					goto fault;
+				addr += 8;
+			}
+			if ((reg & 0xf) == 9) {
+				value = regs->regs[30];
+				StoreDW(addr, value, res);
+				if (res)
+					goto fault;
+				addr += 8;
+			}
+			if (reg & 0x10) {
+				value = regs->regs[31];
+				StoreDW(addr, value, res);
+				if (res)
+					goto fault;
+			}
+			goto success;
+#endif /* CONFIG_64BIT */
+
+			goto sigill;
+
+			/*  LWC2, SWC2, LDC2, SDC2 are not serviced */
+		}
+
+		goto sigbus;
+
+	case mm_pool32c_op:
+		switch (insn.mm_m_format.func) {
+		case mm_lwu_func:
+			reg = insn.mm_m_format.rd;
+			goto loadWU;
+		}
+
+		/*  LL,SC,LLD,SCD are not serviced */
+		goto sigbus;
+
+	case mm_pool32f_op:
+		switch (insn.mm_x_format.func) {
+		case mm_lwxc1_func:
+		case mm_swxc1_func:
+		case mm_ldxc1_func:
+		case mm_sdxc1_func:
+			goto fpu_emul;
+		}
+
+		goto sigbus;
+
+	case mm_ldc132_op:
+	case mm_sdc132_op:
+	case mm_lwc132_op:
+	case mm_swc132_op:
+fpu_emul:
+		/* roll back jump/branch */
+		regs->cp0_epc = origpc;
+		regs->regs[31] = orig31;
+
+		die_if_kernel("Unaligned FP access in kernel code", regs);
+		BUG_ON(!used_math());
+		BUG_ON(!is_fpu_owner());
+
+		lose_fpu(1);	/* save the FPU state for the emulator */
+		res = fpu_emulator_cop1Handler(regs, &current->thread.fpu, 1,
+					       &fault_addr);
+		own_fpu(1);	/* restore FPU state */
+
+		/* If something went wrong, signal */
+		process_fpemu_return(res, fault_addr);
+
+		if (res == 0)
+			goto success;
+		return;
+
+	case mm_lh32_op:
+		reg = insn.mm_i_format.rt;
+		goto loadHW;
+
+	case mm_lhu32_op:
+		reg = insn.mm_i_format.rt;
+		goto loadHWU;
+
+	case mm_lw32_op:
+		reg = insn.mm_i_format.rt;
+		goto loadW;
+
+	case mm_sh32_op:
+		reg = insn.mm_i_format.rt;
+		goto storeHW;
+
+	case mm_sw32_op:
+		reg = insn.mm_i_format.rt;
+		goto storeW;
+
+	case mm_ld32_op:
+		reg = insn.mm_i_format.rt;
+		goto loadDW;
+
+	case mm_sd32_op:
+		reg = insn.mm_i_format.rt;
+		goto storeDW;
+
+	case mm_pool16c_op:
+		switch (insn.mm16_m_format.func) {
+		case mm_lwm16_op:
+			reg = insn.mm16_m_format.rlist;
+			rvar = reg + 1;
+			if (!access_ok(VERIFY_READ, addr, 4 * rvar))
+				goto sigbus;
+
+			for (i = 16; rvar; rvar--, i++) {
+				LoadW(addr, value, res);
+				if (res)
+					goto fault;
+				addr += 4;
+				regs->regs[i] = value;
+			}
+			LoadW(addr, value, res);
+			if (res)
+				goto fault;
+			regs->regs[31] = value;
+
+			goto success;
+
+		case mm_swm16_op:
+			reg = insn.mm16_m_format.rlist;
+			rvar = reg + 1;
+			if (!access_ok(VERIFY_WRITE, addr, 4 * rvar))
+				goto sigbus;
+
+			for (i = 16; rvar; rvar--, i++) {
+				value = regs->regs[i];
+				StoreW(addr, value, res);
+				if (res)
+					goto fault;
+				addr += 4;
+			}
+			value = regs->regs[31];
+			StoreW(addr, value, res);
+			if (res)
+				goto fault;
+
+			goto success;
+
+		}
+
+		goto sigbus;
+
+	case mm_lhu16_op:
+		reg = mmreg16to32[insn.mm16_rb_format.rt];
+		goto loadHWU;
+
+	case mm_lw16_op:
+		reg = mmreg16to32[insn.mm16_rb_format.rt];
+		goto loadW;
+
+	case mm_sh16_op:
+		reg = mmreg16to32_st[insn.mm16_rb_format.rt];
+		goto storeHW;
+
+	case mm_sw16_op:
+		reg = mmreg16to32_st[insn.mm16_rb_format.rt];
+		goto storeW;
+
+	case mm_lwsp16_op:
+		reg = insn.mm16_r5_format.rt;
+		goto loadW;
+
+	case mm_swsp16_op:
+		reg = insn.mm16_r5_format.rt;
+		goto storeW;
+
+	case mm_lwgp16_op:
+		reg = mmreg16to32[insn.mm16_r3_format.rt];
+		goto loadW;
+
+	default:
+		goto sigill;
+	}
+
+loadHW:
+	if (!access_ok(VERIFY_READ, addr, 2))
+		goto sigbus;
+
+	LoadHW(addr, value, res);
+	if (res)
+		goto fault;
+	regs->regs[reg] = value;
+	goto success;
+
+loadHWU:
+	if (!access_ok(VERIFY_READ, addr, 2))
+		goto sigbus;
+
+	LoadHWU(addr, value, res);
+	if (res)
+		goto fault;
+	regs->regs[reg] = value;
+	goto success;
+
+loadW:
+	if (!access_ok(VERIFY_READ, addr, 4))
+		goto sigbus;
+
+	LoadW(addr, value, res);
+	if (res)
+		goto fault;
+	regs->regs[reg] = value;
+	goto success;
+
+loadWU:
+#ifdef CONFIG_64BIT
+	/*
+	 * A 32-bit kernel might be running on a 64-bit processor.  But
+	 * if we're on a 32-bit processor and an i-cache incoherency
+	 * or race makes us see a 64-bit instruction here the sdl/sdr
+	 * would blow up, so for now we don't handle unaligned 64-bit
+	 * instructions on 32-bit kernels.
+	 */
+	if (!access_ok(VERIFY_READ, addr, 4))
+		goto sigbus;
+
+	LoadWU(addr, value, res);
+	if (res)
+		goto fault;
+	regs->regs[reg] = value;
+	goto success;
+#endif /* CONFIG_64BIT */
+
+	/* Cannot handle 64-bit instructions in 32-bit kernel */
+	goto sigill;
+
+loadDW:
+#ifdef CONFIG_64BIT
+	/*
+	 * A 32-bit kernel might be running on a 64-bit processor.  But
+	 * if we're on a 32-bit processor and an i-cache incoherency
+	 * or race makes us see a 64-bit instruction here the sdl/sdr
+	 * would blow up, so for now we don't handle unaligned 64-bit
+	 * instructions on 32-bit kernels.
+	 */
+	if (!access_ok(VERIFY_READ, addr, 8))
+		goto sigbus;
+
+	LoadDW(addr, value, res);
+	if (res)
+		goto fault;
+	regs->regs[reg] = value;
+	goto success;
+#endif /* CONFIG_64BIT */
+
+	/* Cannot handle 64-bit instructions in 32-bit kernel */
+	goto sigill;
+
+storeHW:
+	if (!access_ok(VERIFY_WRITE, addr, 2))
+		goto sigbus;
+
+	value = regs->regs[reg];
+	StoreHW(addr, value, res);
+	if (res)
+		goto fault;
+	goto success;
+
+storeW:
+	if (!access_ok(VERIFY_WRITE, addr, 4))
+		goto sigbus;
+
+	value = regs->regs[reg];
+	StoreW(addr, value, res);
+	if (res)
+		goto fault;
+	goto success;
+
+storeDW:
+#ifdef CONFIG_64BIT
+	/*
+	 * A 32-bit kernel might be running on a 64-bit processor.  But
+	 * if we're on a 32-bit processor and an i-cache incoherency
+	 * or race makes us see a 64-bit instruction here the sdl/sdr
+	 * would blow up, so for now we don't handle unaligned 64-bit
+	 * instructions on 32-bit kernels.
+	 */
+	if (!access_ok(VERIFY_WRITE, addr, 8))
+		goto sigbus;
+
+	value = regs->regs[reg];
+	StoreDW(addr, value, res);
+	if (res)
+		goto fault;
+	goto success;
+#endif /* CONFIG_64BIT */
+
+	/* Cannot handle 64-bit instructions in 32-bit kernel */
+	goto sigill;
+
+success:
+	regs->cp0_epc = contpc;	/* advance or branch */
+
+#ifdef CONFIG_DEBUG_FS
+	unaligned_instructions++;
+#endif
+	return;
+
+fault:
+	/* roll back jump/branch */
+	regs->cp0_epc = origpc;
+	regs->regs[31] = orig31;
+	/* Did we have an exception handler installed? */
+	if (fixup_exception(regs))
+		return;
+
+	die_if_kernel("Unhandled kernel unaligned access", regs);
+	force_sig(SIGSEGV, current);
+
+	return;
+
+sigbus:
+	die_if_kernel("Unhandled kernel unaligned access", regs);
+	force_sig(SIGBUS, current);
+
+	return;
+
+sigill:
+	die_if_kernel
+	    ("Unhandled kernel unaligned access or invalid instruction", regs);
+	force_sig(SIGILL, current);
+}
+
+/*  recode table from MIPS16e register notation to GPR */
+int mips16e_reg2gpr[] = { 16, 17, 2, 3, 4, 5, 6, 7 };
+
+static void emulate_load_store_MIPS16e(struct pt_regs *regs, void __user * addr)
+{
+	unsigned long value;
+	unsigned int res;
+	int reg;
+	unsigned long orig31;
+	u16 __user *pc16;
+	unsigned long origpc;
+	union mips16e_instruction mips16inst, oldinst;
+
+	origpc = regs->cp0_epc;
+	orig31 = regs->regs[31];
+	pc16 = (unsigned short __user *)(origpc & ~MIPS_ISA_MODE);
+	/*
+	 * This load never faults.
+	 */
+	__get_user(mips16inst.full, pc16);
+	oldinst = mips16inst;
+
+	/* skip EXTEND instruction */
+	if (mips16inst.ri.opcode == MIPS16e_extend_op) {
+		pc16++;
+		__get_user(mips16inst.full, pc16);
+	} else if (delay_slot(regs)) {
+		/*  skip jump instructions */
+		/*  JAL/JALX are 32 bits but have OPCODE in first short int */
+		if (mips16inst.ri.opcode == MIPS16e_jal_op)
+			pc16++;
+		pc16++;
+		if (get_user(mips16inst.full, pc16))
+			goto sigbus;
+	}
+
+	switch (mips16inst.ri.opcode) {
+	case MIPS16e_i64_op:	/* I64 or RI64 instruction */
+		switch (mips16inst.i64.func) {	/* I64/RI64 func field check */
+		case MIPS16e_ldpc_func:
+		case MIPS16e_ldsp_func:
+			reg = mips16e_reg2gpr[mips16inst.ri64.ry];
+			goto loadDW;
+
+		case MIPS16e_sdsp_func:
+			reg = mips16e_reg2gpr[mips16inst.ri64.ry];
+			goto writeDW;
+
+		case MIPS16e_sdrasp_func:
+			reg = 29;	/* GPRSP */
+			goto writeDW;
+		}
+
+		goto sigbus;
+
+	case MIPS16e_swsp_op:
+	case MIPS16e_lwpc_op:
+	case MIPS16e_lwsp_op:
+		reg = mips16e_reg2gpr[mips16inst.ri.rx];
+		break;
+
+	case MIPS16e_i8_op:
+		if (mips16inst.i8.func != MIPS16e_swrasp_func)
+			goto sigbus;
+		reg = 29;	/* GPRSP */
+		break;
+
+	default:
+		reg = mips16e_reg2gpr[mips16inst.rri.ry];
+		break;
+	}
+
+	switch (mips16inst.ri.opcode) {
+
+	case MIPS16e_lb_op:
+	case MIPS16e_lbu_op:
+	case MIPS16e_sb_op:
+		goto sigbus;
+
+	case MIPS16e_lh_op:
+		if (!access_ok(VERIFY_READ, addr, 2))
+			goto sigbus;
+
+		LoadHW(addr, value, res);
+		if (res)
+			goto fault;
+		MIPS16e_compute_return_epc(regs, &oldinst);
+		regs->regs[reg] = value;
+		break;
+
+	case MIPS16e_lhu_op:
+		if (!access_ok(VERIFY_READ, addr, 2))
+			goto sigbus;
+
+		LoadHWU(addr, value, res);
+		if (res)
+			goto fault;
+		MIPS16e_compute_return_epc(regs, &oldinst);
+		regs->regs[reg] = value;
+		break;
+
+	case MIPS16e_lw_op:
+	case MIPS16e_lwpc_op:
+	case MIPS16e_lwsp_op:
+		if (!access_ok(VERIFY_READ, addr, 4))
+			goto sigbus;
+
+		LoadW(addr, value, res);
+		if (res)
+			goto fault;
+		MIPS16e_compute_return_epc(regs, &oldinst);
+		regs->regs[reg] = value;
+		break;
+
+	case MIPS16e_lwu_op:
+#ifdef CONFIG_64BIT
+		/*
+		 * A 32-bit kernel might be running on a 64-bit processor.  But
+		 * if we're on a 32-bit processor and an i-cache incoherency
+		 * or race makes us see a 64-bit instruction here the sdl/sdr
+		 * would blow up, so for now we don't handle unaligned 64-bit
+		 * instructions on 32-bit kernels.
+		 */
+		if (!access_ok(VERIFY_READ, addr, 4))
+			goto sigbus;
+
+		LoadWU(addr, value, res);
+		if (res)
+			goto fault;
+		MIPS16e_compute_return_epc(regs, &oldinst);
+		regs->regs[reg] = value;
+		break;
+#endif /* CONFIG_64BIT */
+
+		/* Cannot handle 64-bit instructions in 32-bit kernel */
+		goto sigill;
+
+	case MIPS16e_ld_op:
+loadDW:
+#ifdef CONFIG_64BIT
+		/*
+		 * A 32-bit kernel might be running on a 64-bit processor.  But
+		 * if we're on a 32-bit processor and an i-cache incoherency
+		 * or race makes us see a 64-bit instruction here the sdl/sdr
+		 * would blow up, so for now we don't handle unaligned 64-bit
+		 * instructions on 32-bit kernels.
+		 */
+		if (!access_ok(VERIFY_READ, addr, 8))
+			goto sigbus;
+
+		LoadDW(addr, value, res);
+		if (res)
+			goto fault;
+		MIPS16e_compute_return_epc(regs, &oldinst);
+		regs->regs[reg] = value;
+		break;
+#endif /* CONFIG_64BIT */
+
+		/* Cannot handle 64-bit instructions in 32-bit kernel */
+		goto sigill;
+
+	case MIPS16e_sh_op:
+		if (!access_ok(VERIFY_WRITE, addr, 2))
+			goto sigbus;
+
+		MIPS16e_compute_return_epc(regs, &oldinst);
+		value = regs->regs[reg];
+		StoreHW(addr, value, res);
+		if (res)
+			goto fault;
+		break;
+
+	case MIPS16e_sw_op:
+	case MIPS16e_swsp_op:
+	case MIPS16e_i8_op:	/* actually - MIPS16e_swrasp_func */
+		if (!access_ok(VERIFY_WRITE, addr, 4))
+			goto sigbus;
+
+		MIPS16e_compute_return_epc(regs, &oldinst);
+		value = regs->regs[reg];
+		StoreW(addr, value, res);
+		if (res)
+			goto fault;
+		break;
+
+	case MIPS16e_sd_op:
+writeDW:
+#ifdef CONFIG_64BIT
+		/*
+		 * A 32-bit kernel might be running on a 64-bit processor.  But
+		 * if we're on a 32-bit processor and an i-cache incoherency
+		 * or race makes us see a 64-bit instruction here the sdl/sdr
+		 * would blow up, so for now we don't handle unaligned 64-bit
+		 * instructions on 32-bit kernels.
+		 */
+		if (!access_ok(VERIFY_WRITE, addr, 8))
+			goto sigbus;
+
+		MIPS16e_compute_return_epc(regs, &oldinst);
+		value = regs->regs[reg];
+		StoreDW(addr, value, res);
+		if (res)
+			goto fault;
+		break;
+#endif /* CONFIG_64BIT */
+
+		/* Cannot handle 64-bit instructions in 32-bit kernel */
+		goto sigill;
+
+	default:
+		/*
+		 * Pheeee...  We encountered an yet unknown instruction or
+		 * cache coherence problem.  Die sucker, die ...
+		 */
+		goto sigill;
+	}
+
+#ifdef CONFIG_DEBUG_FS
+	unaligned_instructions++;
+#endif
+
+	return;
+
+fault:
+	/* roll back jump/branch */
+	regs->cp0_epc = origpc;
+	regs->regs[31] = orig31;
 	/* Did we have an exception handler installed? */
 	if (fixup_exception(regs))
 		return;
@@ -504,7 +1546,8 @@ sigbus:
 	return;
 
 sigill:
-	die_if_kernel("Unhandled kernel unaligned access or invalid instruction", regs);
+	die_if_kernel
+	    ("Unhandled kernel unaligned access or invalid instruction", regs);
 	force_sig(SIGILL, current);
 }
 
@@ -517,23 +1560,64 @@ asmlinkage void do_ade(struct pt_regs *regs)
 			1, regs, regs->cp0_badvaddr);
 	/*
 	 * Did we catch a fault trying to load an instruction?
-	 * Or are we running in MIPS16 mode?
 	 */
-	if ((regs->cp0_badvaddr == regs->cp0_epc) || (regs->cp0_epc & 0x1))
+	if (regs->cp0_badvaddr == regs->cp0_epc)
 		goto sigbus;
 
-	pc = (unsigned int __user *) exception_epc(regs);
 	if (user_mode(regs) && !test_thread_flag(TIF_FIXADE))
 		goto sigbus;
 	if (unaligned_action == UNALIGNED_ACTION_SIGNAL)
 		goto sigbus;
-	else if (unaligned_action == UNALIGNED_ACTION_SHOW)
-		show_registers(regs);
 
 	/*
 	 * Do branch emulation only if we didn't forward the exception.
 	 * This is all so but ugly ...
 	 */
+
+	/*
+	 * Are we running in MIPS16e/microMIPS mode?
+	 */
+	if (is16mode(regs)) {
+		/*
+		 * Did we catch a fault trying to load an instruction in
+		 * 16bit mode?
+		 */
+		if (regs->cp0_badvaddr == (regs->cp0_epc & ~MIPS_ISA_MODE))
+			goto sigbus;
+		if (unaligned_action == UNALIGNED_ACTION_SHOW)
+			show_registers(regs);
+
+		if (cpu_has_mips16) {
+			seg = get_fs();
+			if (!user_mode(regs))
+				set_fs(KERNEL_DS);
+			emulate_load_store_MIPS16e(regs,
+						   (void __user *)regs->
+						   cp0_badvaddr);
+			set_fs(seg);
+
+			return;
+		}
+
+		if (cpu_has_mmips) {	/* micromips unaligned access */
+			seg = get_fs();
+			if (!user_mode(regs))
+				set_fs(KERNEL_DS);
+			emulate_load_store_microMIPS(regs,
+						     (void __user *)regs->
+						     cp0_badvaddr);
+			set_fs(seg);
+
+			return;
+		}
+
+		goto sigbus;
+	}
+
+	if (unaligned_action == UNALIGNED_ACTION_SHOW)
+		show_registers(regs);
+	pc = (unsigned int __user *)exception_epc(regs);
+
 	seg = get_fs();
 	if (!user_mode(regs))
 		set_fs(KERNEL_DS);
-- 
1.7.9.6
