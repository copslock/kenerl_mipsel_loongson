Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:21:19 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62638 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009184AbaLRPMng7Qo2 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:12:43 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id B8BD7371B6775
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:12:33 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:12:36 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:12:36 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 36/67] MIPS: kernel: unaligned: Add support for the MIPS R6
Date:   Thu, 18 Dec 2014 15:09:45 +0000
Message-ID: <1418915416-3196-37-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.2.0
In-Reply-To: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
References: <1418915416-3196-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.125]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44771
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: markos.chandras@imgtec.com
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

The load/store unaligned instructions have been removed in MIPS R6
so we need to re-implement the related macros using the regular
load/store instructions. Moreover, the load/store from coprocessor 2
instructions have been reallocated in Release 6 so we will handle them
in the emulator instead.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/unaligned.c | 390 ++++++++++++++++++++++++++++++++++++++++++-
 1 file changed, 386 insertions(+), 4 deletions(-)

diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index 3665905cbbe2..039ada90ed69 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -129,6 +129,7 @@ extern void show_registers(struct pt_regs *regs);
 			: "=&r" (value), "=r" (res)         \
 			: "r" (addr), "i" (-EFAULT));
 
+#ifndef CONFIG_CPU_MIPSR6
 #define     LoadW(addr, value, res)   \
 		__asm__ __volatile__ (                      \
 			"1:\t"user_lwl("%0", "(%2)")"\n"    \
@@ -146,6 +147,39 @@ extern void show_registers(struct pt_regs *regs);
 			".previous"                         \
 			: "=&r" (value), "=r" (res)         \
 			: "r" (addr), "i" (-EFAULT));
+#else
+/* MIPSR6 has no lwl instruction */
+#define     LoadW(addr, value, res) \
+		__asm__ __volatile__ (			    \
+			".set\tpush\n"			    \
+			".set\tnoat\n\t"		    \
+			"1:"user_lb("%0", "0(%2)")"\n\t"    \
+			"2:"user_lbu("$1", "1(%2)")"\n\t"   \
+			"sll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"3:"user_lbu("$1", "2(%2)")"\n\t"   \
+			"sll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"4:"user_lbu("$1", "3(%2)")"\n\t"   \
+			"sll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"li\t%1, 0\n"			    \
+			".set\tpop\n"			    \
+			"10:\n\t"			    \
+			".insn\n\t"			    \
+			".section\t.fixup,\"ax\"\n\t"	    \
+			"11:\tli\t%1, %3\n\t"		    \
+			"j\t10b\n\t"			    \
+			".previous\n\t"			    \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 11b\n\t"		    \
+			STR(PTR)"\t2b, 11b\n\t"		    \
+			STR(PTR)"\t3b, 11b\n\t"		    \
+			STR(PTR)"\t4b, 11b\n\t"		    \
+			".previous"			    \
+			: "=&r" (value), "=r" (res)	    \
+			: "r" (addr), "i" (-EFAULT));
+#endif /* CONFIG_MIPS_R6 */
 
 #define     LoadHWU(addr, value, res) \
 		__asm__ __volatile__ (                      \
@@ -169,6 +203,7 @@ extern void show_registers(struct pt_regs *regs);
 			: "=&r" (value), "=r" (res)         \
 			: "r" (addr), "i" (-EFAULT));
 
+#ifndef CONFIG_CPU_MIPSR6
 #define     LoadWU(addr, value, res)  \
 		__asm__ __volatile__ (                      \
 			"1:\t"user_lwl("%0", "(%2)")"\n"    \
@@ -206,6 +241,87 @@ extern void show_registers(struct pt_regs *regs);
 			".previous"                         \
 			: "=&r" (value), "=r" (res)         \
 			: "r" (addr), "i" (-EFAULT));
+#else
+/* MIPSR6 has not lwl and ldl instructions */
+#define	    LoadWU(addr, value, res) \
+		__asm__ __volatile__ (			    \
+			".set\tpush\n\t"		    \
+			".set\tnoat\n\t"		    \
+			"1:"user_lbu("%0", "0(%2)")"\n\t"   \
+			"2:"user_lbu("$1", "1(%2)")"\n\t"   \
+			"sll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"3:"user_lbu("$1", "2(%2)")"\n\t"   \
+			"sll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"4:"user_lbu("$1", "3(%2)")"\n\t"   \
+			"sll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"li\t%1, 0\n"			    \
+			".set\tpop\n"			    \
+			"10:\n\t"			    \
+			".insn\n\t"			    \
+			".section\t.fixup,\"ax\"\n\t"	    \
+			"11:\tli\t%1, %3\n\t"		    \
+			"j\t10b\n\t"			    \
+			".previous\n\t"			    \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 11b\n\t"		    \
+			STR(PTR)"\t2b, 11b\n\t"		    \
+			STR(PTR)"\t3b, 11b\n\t"		    \
+			STR(PTR)"\t4b, 11b\n\t"		    \
+			".previous"			    \
+			: "=&r" (value), "=r" (res)	    \
+			: "r" (addr), "i" (-EFAULT));
+
+#define     LoadDW(addr, value, res)  \
+		__asm__ __volatile__ (			    \
+			".set\tpush\n\t"		    \
+			".set\tnoat\n\t"		    \
+			"1:lb\t%0, 0(%2)\n\t"    	    \
+			"2:lbu\t $1, 1(%2)\n\t"   	    \
+			"dsll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"3:lbu\t$1, 2(%2)\n\t"   	    \
+			"dsll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"4:lbu\t$1, 3(%2)\n\t"   	    \
+			"dsll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"5:lbu\t$1, 4(%2)\n\t"   	    \
+			"dsll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"6:lbu\t$1, 5(%2)\n\t"   	    \
+			"dsll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"7:lbu\t$1, 6(%2)\n\t"   	    \
+			"dsll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"8:lbu\t$1, 7(%2)\n\t"   	    \
+			"dsll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"li\t%1, 0\n"			    \
+			".set\tpop\n\t"			    \
+			"10:\n\t"			    \
+			".insn\n\t"			    \
+			".section\t.fixup,\"ax\"\n\t"	    \
+			"11:\tli\t%1, %3\n\t"		    \
+			"j\t10b\n\t"			    \
+			".previous\n\t"			    \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 11b\n\t"		    \
+			STR(PTR)"\t2b, 11b\n\t"		    \
+			STR(PTR)"\t3b, 11b\n\t"		    \
+			STR(PTR)"\t4b, 11b\n\t"		    \
+			STR(PTR)"\t5b, 11b\n\t"		    \
+			STR(PTR)"\t6b, 11b\n\t"		    \
+			STR(PTR)"\t7b, 11b\n\t"		    \
+			STR(PTR)"\t8b, 11b\n\t"		    \
+			".previous"			    \
+			: "=&r" (value), "=r" (res)	    \
+			: "r" (addr), "i" (-EFAULT));
+#endif /* CONFIG_CPU_MIPSR6 */
+
 
 #define     StoreHW(addr, value, res) \
 		__asm__ __volatile__ (                      \
@@ -228,6 +344,7 @@ extern void show_registers(struct pt_regs *regs);
 			: "=r" (res)                        \
 			: "r" (value), "r" (addr), "i" (-EFAULT));
 
+#ifndef CONFIG_CPU_MIPSR6
 #define     StoreW(addr, value, res)  \
 		__asm__ __volatile__ (                      \
 			"1:\t"user_swl("%1", "(%2)")"\n"    \
@@ -263,9 +380,82 @@ extern void show_registers(struct pt_regs *regs);
 			".previous"                         \
 		: "=r" (res)                                \
 		: "r" (value), "r" (addr), "i" (-EFAULT));
-#endif
+#else
+/* MIPSR6 has no swl and sdl instructions */
+#define     StoreW(addr, value, res)  \
+		__asm__ __volatile__ (                      \
+			".set\tpush\n\t"		    \
+			".set\tnoat\n\t"		    \
+			"1:"user_sb("%1", "3(%2)")"\n\t"    \
+			"srl\t$1, %1, 0x8\n\t"		    \
+			"2:"user_sb("$1", "2(%2)")"\n\t"    \
+			"srl\t$1, $1,  0x8\n\t"		    \
+			"3:"user_sb("$1", "1(%2)")"\n\t"    \
+			"srl\t$1, $1, 0x8\n\t"		    \
+			"4:"user_sb("$1", "0(%2)")"\n\t"    \
+			".set\tpop\n\t"			    \
+			"li\t%0, 0\n"			    \
+			"10:\n\t"			    \
+			".insn\n\t"			    \
+			".section\t.fixup,\"ax\"\n\t"	    \
+			"11:\tli\t%0, %3\n\t"		    \
+			"j\t10b\n\t"			    \
+			".previous\n\t"			    \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 11b\n\t"		    \
+			STR(PTR)"\t2b, 11b\n\t"		    \
+			STR(PTR)"\t3b, 11b\n\t"		    \
+			STR(PTR)"\t4b, 11b\n\t"		    \
+			".previous"			    \
+		: "=&r" (res)			    	    \
+		: "r" (value), "r" (addr), "i" (-EFAULT)    \
+		: "memory");
+
+#define     StoreDW(addr, value, res) \
+		__asm__ __volatile__ (                      \
+			".set\tpush\n\t"		    \
+			".set\tnoat\n\t"		    \
+			"1:sb\t%1, 7(%2)\n\t"    	    \
+			"dsrl\t$1, %1, 0x8\n\t"		    \
+			"2:sb\t$1, 6(%2)\n\t"    	    \
+			"dsrl\t$1, $1, 0x8\n\t"		    \
+			"3:sb\t$1, 5(%2)\n\t"    	    \
+			"dsrl\t$1, $1, 0x8\n\t"		    \
+			"4:sb\t$1, 4(%2)\n\t"    	    \
+			"dsrl\t$1, $1, 0x8\n\t"		    \
+			"5:sb\t$1, 3(%2)\n\t"    	    \
+			"dsrl\t$1, $1, 0x8\n\t"		    \
+			"6:sb\t$1, 2(%2)\n\t"    	    \
+			"dsrl\t$1, $1, 0x8\n\t"		    \
+			"7:sb\t$1, 1(%2)\n\t"    	    \
+			"dsrl\t$1, $1, 0x8\n\t"		    \
+			"8:sb\t$1, 0(%2)\n\t"    	    \
+			"dsrl\t$1, $1, 0x8\n\t"		    \
+			".set\tpop\n\t"			    \
+			"li\t%0, 0\n"			    \
+			"10:\n\t"			    \
+			".insn\n\t"			    \
+			".section\t.fixup,\"ax\"\n\t"	    \
+			"11:\tli\t%0, %3\n\t"		    \
+			"j\t10b\n\t"			    \
+			".previous\n\t"			    \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 11b\n\t"		    \
+			STR(PTR)"\t2b, 11b\n\t"		    \
+			STR(PTR)"\t3b, 11b\n\t"		    \
+			STR(PTR)"\t4b, 11b\n\t"		    \
+			STR(PTR)"\t5b, 11b\n\t"		    \
+			STR(PTR)"\t6b, 11b\n\t"		    \
+			STR(PTR)"\t7b, 11b\n\t"		    \
+			STR(PTR)"\t8b, 11b\n\t"		    \
+			".previous"			    \
+		: "=&r" (res)			    	    \
+		: "r" (value), "r" (addr), "i" (-EFAULT)    \
+		: "memory");
+#endif /* CONFIG_CPU_MIPSR6 */
+
+#else /* __BIG_ENDIAN */
 
-#ifdef __LITTLE_ENDIAN
 #define     LoadHW(addr, value, res)  \
 		__asm__ __volatile__ (".set\tnoat\n"        \
 			"1:\t"user_lb("%0", "1(%2)")"\n"    \
@@ -286,6 +476,7 @@ extern void show_registers(struct pt_regs *regs);
 			: "=&r" (value), "=r" (res)         \
 			: "r" (addr), "i" (-EFAULT));
 
+#ifndef CONFIG_CPU_MIPSR6
 #define     LoadW(addr, value, res)   \
 		__asm__ __volatile__ (                      \
 			"1:\t"user_lwl("%0", "3(%2)")"\n"   \
@@ -303,6 +494,40 @@ extern void show_registers(struct pt_regs *regs);
 			".previous"                         \
 			: "=&r" (value), "=r" (res)         \
 			: "r" (addr), "i" (-EFAULT));
+#else
+/* MIPSR6 has no lwl instruction */
+#define     LoadW(addr, value, res) \
+		__asm__ __volatile__ (			    \
+			".set\tpush\n"			    \
+			".set\tnoat\n\t"		    \
+			"1:"user_lb("%0", "3(%2)")"\n\t"    \
+			"2:"user_lbu("$1", "2(%2)")"\n\t"   \
+			"sll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"3:"user_lbu("$1", "1(%2)")"\n\t"   \
+			"sll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"4:"user_lbu("$1", "0(%2)")"\n\t"   \
+			"sll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"li\t%1, 0\n"			    \
+			".set\tpop\n"			    \
+			"10:\n\t"			    \
+			".insn\n\t"			    \
+			".section\t.fixup,\"ax\"\n\t"	    \
+			"11:\tli\t%1, %3\n\t"		    \
+			"j\t10b\n\t"			    \
+			".previous\n\t"			    \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 11b\n\t"		    \
+			STR(PTR)"\t2b, 11b\n\t"		    \
+			STR(PTR)"\t3b, 11b\n\t"		    \
+			STR(PTR)"\t4b, 11b\n\t"		    \
+			".previous"			    \
+			: "=&r" (value), "=r" (res)	    \
+			: "r" (addr), "i" (-EFAULT));
+#endif /* CONFIG_CPU_MIPSR6 */
+
 
 #define     LoadHWU(addr, value, res) \
 		__asm__ __volatile__ (                      \
@@ -326,6 +551,7 @@ extern void show_registers(struct pt_regs *regs);
 			: "=&r" (value), "=r" (res)         \
 			: "r" (addr), "i" (-EFAULT));
 
+#ifndef CONFIG_CPU_MIPSR6
 #define     LoadWU(addr, value, res)  \
 		__asm__ __volatile__ (                      \
 			"1:\t"user_lwl("%0", "3(%2)")"\n"   \
@@ -363,6 +589,86 @@ extern void show_registers(struct pt_regs *regs);
 			".previous"                         \
 			: "=&r" (value), "=r" (res)         \
 			: "r" (addr), "i" (-EFAULT));
+#else
+/* MIPSR6 has not lwl and ldl instructions */
+#define	    LoadWU(addr, value, res) \
+		__asm__ __volatile__ (			    \
+			".set\tpush\n\t"		    \
+			".set\tnoat\n\t"		    \
+			"1:"user_lbu("%0", "3(%2)")"\n\t"   \
+			"2:"user_lbu("$1", "2(%2)")"\n\t"   \
+			"sll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"3:"user_lbu("$1", "1(%2)")"\n\t"   \
+			"sll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"4:"user_lbu("$1", "0(%2)")"\n\t"   \
+			"sll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"li\t%1, 0\n"			    \
+			".set\tpop\n"			    \
+			"10:\n\t"			    \
+			".insn\n\t"			    \
+			".section\t.fixup,\"ax\"\n\t"	    \
+			"11:\tli\t%1, %3\n\t"		    \
+			"j\t10b\n\t"			    \
+			".previous\n\t"			    \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 11b\n\t"		    \
+			STR(PTR)"\t2b, 11b\n\t"		    \
+			STR(PTR)"\t3b, 11b\n\t"		    \
+			STR(PTR)"\t4b, 11b\n\t"		    \
+			".previous"			    \
+			: "=&r" (value), "=r" (res)	    \
+			: "r" (addr), "i" (-EFAULT));
+
+#define     LoadDW(addr, value, res)  \
+		__asm__ __volatile__ (			    \
+			".set\tpush\n\t"		    \
+			".set\tnoat\n\t"		    \
+			"1:lb\t%0, 7(%2)\n\t"    	    \
+			"2:lbu\t$1, 6(%2)\n\t"   	    \
+			"dsll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"3:lbu\t$1, 5(%2)\n\t"   	    \
+			"dsll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"4:lbu\t$1, 4(%2)\n\t"   	    \
+			"dsll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"5:lbu\t$1, 3(%2)\n\t"   	    \
+			"dsll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"6:lbu\t$1, 2(%2)\n\t"   	    \
+			"dsll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"7:lbu\t$1, 1(%2)\n\t"   	    \
+			"dsll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"8:lbu\t$1, 0(%2)\n\t"   	    \
+			"dsll\t%0, 0x8\n\t"		    \
+			"or\t%0, $1\n\t"		    \
+			"li\t%1, 0\n"			    \
+			".set\tpop\n\t"			    \
+			"10:\n\t"			    \
+			".insn\n\t"			    \
+			".section\t.fixup,\"ax\"\n\t"	    \
+			"11:\tli\t%1, %3\n\t"		    \
+			"j\t10b\n\t"			    \
+			".previous\n\t"			    \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 11b\n\t"		    \
+			STR(PTR)"\t2b, 11b\n\t"		    \
+			STR(PTR)"\t3b, 11b\n\t"		    \
+			STR(PTR)"\t4b, 11b\n\t"		    \
+			STR(PTR)"\t5b, 11b\n\t"		    \
+			STR(PTR)"\t6b, 11b\n\t"		    \
+			STR(PTR)"\t7b, 11b\n\t"		    \
+			STR(PTR)"\t8b, 11b\n\t"		    \
+			".previous"			    \
+			: "=&r" (value), "=r" (res)	    \
+			: "r" (addr), "i" (-EFAULT));
+#endif /* CONFIG_CPU_MIPSR6 */
 
 #define     StoreHW(addr, value, res) \
 		__asm__ __volatile__ (                      \
@@ -384,7 +690,7 @@ extern void show_registers(struct pt_regs *regs);
 			".previous"                         \
 			: "=r" (res)                        \
 			: "r" (value), "r" (addr), "i" (-EFAULT));
-
+#ifndef CONFIG_CPU_MIPSR6
 #define     StoreW(addr, value, res)  \
 		__asm__ __volatile__ (                      \
 			"1:\t"user_swl("%1", "3(%2)")"\n"   \
@@ -420,6 +726,79 @@ extern void show_registers(struct pt_regs *regs);
 			".previous"                         \
 		: "=r" (res)                                \
 		: "r" (value), "r" (addr), "i" (-EFAULT));
+#else
+/* MIPSR6 has no swl and sdl instructions */
+#define     StoreW(addr, value, res)  \
+		__asm__ __volatile__ (                      \
+			".set\tpush\n\t"		    \
+			".set\tnoat\n\t"		    \
+			"1:"user_sb("%1", "0(%2)")"\n\t"    \
+			"srl\t$1, %1, 0x8\n\t"		    \
+			"2:"user_sb("$1", "1(%2)")"\n\t"    \
+			"srl\t$1, $1,  0x8\n\t"		    \
+			"3:"user_sb("$1", "2(%2)")"\n\t"    \
+			"srl\t$1, $1, 0x8\n\t"		    \
+			"4:"user_sb("$1", "3(%2)")"\n\t"    \
+			".set\tpop\n\t"			    \
+			"li\t%0, 0\n"			    \
+			"10:\n\t"			    \
+			".insn\n\t"			    \
+			".section\t.fixup,\"ax\"\n\t"	    \
+			"11:\tli\t%0, %3\n\t"		    \
+			"j\t10b\n\t"			    \
+			".previous\n\t"			    \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 11b\n\t"		    \
+			STR(PTR)"\t2b, 11b\n\t"		    \
+			STR(PTR)"\t3b, 11b\n\t"		    \
+			STR(PTR)"\t4b, 11b\n\t"		    \
+			".previous"			    \
+		: "=&r" (res)			    	    \
+		: "r" (value), "r" (addr), "i" (-EFAULT)    \
+		: "memory");
+
+#define     StoreDW(addr, value, res) \
+		__asm__ __volatile__ (                      \
+			".set\tpush\n\t"		    \
+			".set\tnoat\n\t"		    \
+			"1:sb\t%1, 0(%2)\n\t"    	    \
+			"dsrl\t$1, %1, 0x8\n\t"		    \
+			"2:sb\t$1, 1(%2)\n\t"    	    \
+			"dsrl\t$1, $1, 0x8\n\t"		    \
+			"3:sb\t$1, 2(%2)\n\t"    	    \
+			"dsrl\t$1, $1, 0x8\n\t"		    \
+			"4:sb\t$1, 3(%2)\n\t"    	    \
+			"dsrl\t$1, $1, 0x8\n\t"		    \
+			"5:sb\t$1, 4(%2)\n\t"    	    \
+			"dsrl\t$1, $1, 0x8\n\t"		    \
+			"6:sb\t$1, 5(%2)\n\t"    	    \
+			"dsrl\t$1, $1, 0x8\n\t"		    \
+			"7:sb\t$1, 6(%2)\n\t"    	    \
+			"dsrl\t$1, $1, 0x8\n\t"		    \
+			"8:sb\t$1, 7(%2)\n\t"    	    \
+			"dsrl\t$1, $1, 0x8\n\t"		    \
+			".set\tpop\n\t"			    \
+			"li\t%0, 0\n"			    \
+			"10:\n\t"			    \
+			".insn\n\t"			    \
+			".section\t.fixup,\"ax\"\n\t"	    \
+			"11:\tli\t%0, %3\n\t"		    \
+			"j\t10b\n\t"			    \
+			".previous\n\t"			    \
+			".section\t__ex_table,\"a\"\n\t"    \
+			STR(PTR)"\t1b, 11b\n\t"		    \
+			STR(PTR)"\t2b, 11b\n\t"		    \
+			STR(PTR)"\t3b, 11b\n\t"		    \
+			STR(PTR)"\t4b, 11b\n\t"		    \
+			STR(PTR)"\t5b, 11b\n\t"		    \
+			STR(PTR)"\t6b, 11b\n\t"		    \
+			STR(PTR)"\t7b, 11b\n\t"		    \
+			STR(PTR)"\t8b, 11b\n\t"		    \
+			".previous"			    \
+		: "=&r" (res)			    	    \
+		: "r" (value), "r" (addr), "i" (-EFAULT)    \
+		: "memory");
+#endif /* CONFIG_CPU_MIPSR6 */
 #endif
 
 static void emulate_load_store_insn(struct pt_regs *regs,
@@ -703,10 +1082,13 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 			break;
 		return;
 
+#ifndef CONFIG_MIPS_R6
 	/*
 	 * COP2 is available to implementor for application specific use.
 	 * It's up to applications to register a notifier chain and do
 	 * whatever they have to do, including possible sending of signals.
+	 *
+	 * This instruction has been reallocated in Release 6
 	 */
 	case lwc2_or_bc_op:
 		cu2_notifier_call_chain(CU2_LWC2_OP, regs);
@@ -723,7 +1105,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 	case sdc2_or_bnzcjialc_op:
 		cu2_notifier_call_chain(CU2_SDC2_OP, regs);
 		break;
-
+#endif
 	default:
 		/*
 		 * Pheeee...  We encountered an yet unknown instruction or
-- 
2.2.0
