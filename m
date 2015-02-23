Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Feb 2015 09:22:32 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:50988 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27006932AbbBWIWaLWxJ9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Feb 2015 09:22:30 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 26A83898E5C16;
        Mon, 23 Feb 2015 08:22:22 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Mon, 23 Feb 2015 08:22:23 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.96) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Mon, 23 Feb 2015 08:22:22 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>,
        <stable@vger.kernel.org>
Subject: [PATCH 2/2] MIPS: unaligned: Prevent EVA instructions on kernel unaligned accesses
Date:   Mon, 23 Feb 2015 08:21:36 +0000
Message-ID: <1424679696-19696-3-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 2.3.0
In-Reply-To: <1424679696-19696-1-git-send-email-markos.chandras@imgtec.com>
References: <1424679696-19696-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.96]
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45889
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

Commit c1771216ab48 ("MIPS: kernel: unaligned: Handle unaligned
accesses for EVA") allowed unaligned accesses to be emulated for
EVA. However, when emulating regular load/store unaligned accesses,
we need to use the appropriate "address space" instructions for that.
Previously, an unaligned load/store instruction in kernel space would
have used the corresponding EVA instructions to emulate it which led to
segmentation faults because of the address translation that happens
with EVA instructions. This is now fixed by using the EVA instruction
only when emulating EVA unaligned accesses.

Fixes: c1771216ab48 ("MIPS: kernel: unaligned: Handle unaligned accesses for EVA")
Cc: <stable@vger.kernel.org> # v3.15+
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/unaligned.c | 170 +++++++++++++++++++++++--------------------
 1 file changed, 93 insertions(+), 77 deletions(-)

diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index bbb69695a0a1..a6d62026c545 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -109,10 +109,10 @@ static u32 unaligned_action;
 extern void show_registers(struct pt_regs *regs);
 
 #ifdef __BIG_ENDIAN
-#define     LoadHW(addr, value, res)  \
+#define     _LoadHW(addr, value, res, type)  \
 		__asm__ __volatile__ (".set\tnoat\n"        \
-			"1:\t"user_lb("%0", "0(%2)")"\n"    \
-			"2:\t"user_lbu("$1", "1(%2)")"\n\t" \
+			"1:\t"type##_lb("%0", "0(%2)")"\n"    \
+			"2:\t"type##_lbu("$1", "1(%2)")"\n\t" \
 			"sll\t%0, 0x8\n\t"                  \
 			"or\t%0, $1\n\t"                    \
 			"li\t%1, 0\n"                       \
@@ -130,10 +130,10 @@ extern void show_registers(struct pt_regs *regs);
 			: "r" (addr), "i" (-EFAULT));
 
 #ifndef CONFIG_CPU_MIPSR6
-#define     LoadW(addr, value, res)   \
+#define     _LoadW(addr, value, res, type)   \
 		__asm__ __volatile__ (                      \
-			"1:\t"user_lwl("%0", "(%2)")"\n"    \
-			"2:\t"user_lwr("%0", "3(%2)")"\n\t" \
+			"1:\t"type##_lwl("%0", "(%2)")"\n"    \
+			"2:\t"type##_lwr("%0", "3(%2)")"\n\t" \
 			"li\t%1, 0\n"                       \
 			"3:\n\t"                            \
 			".insn\n\t"                         \
@@ -149,18 +149,18 @@ extern void show_registers(struct pt_regs *regs);
 			: "r" (addr), "i" (-EFAULT));
 #else
 /* MIPSR6 has no lwl instruction */
-#define     LoadW(addr, value, res) \
+#define     _LoadW(addr, value, res, type) \
 		__asm__ __volatile__ (			    \
 			".set\tpush\n"			    \
 			".set\tnoat\n\t"		    \
-			"1:"user_lb("%0", "0(%2)")"\n\t"    \
-			"2:"user_lbu("$1", "1(%2)")"\n\t"   \
+			"1:"type##_lb("%0", "0(%2)")"\n\t"    \
+			"2:"type##_lbu("$1", "1(%2)")"\n\t"   \
 			"sll\t%0, 0x8\n\t"		    \
 			"or\t%0, $1\n\t"		    \
-			"3:"user_lbu("$1", "2(%2)")"\n\t"   \
+			"3:"type##_lbu("$1", "2(%2)")"\n\t"   \
 			"sll\t%0, 0x8\n\t"		    \
 			"or\t%0, $1\n\t"		    \
-			"4:"user_lbu("$1", "3(%2)")"\n\t"   \
+			"4:"type##_lbu("$1", "3(%2)")"\n\t"   \
 			"sll\t%0, 0x8\n\t"		    \
 			"or\t%0, $1\n\t"		    \
 			"li\t%1, 0\n"			    \
@@ -181,11 +181,11 @@ extern void show_registers(struct pt_regs *regs);
 			: "r" (addr), "i" (-EFAULT));
 #endif /* CONFIG_CPU_MIPSR6 */
 
-#define     LoadHWU(addr, value, res) \
+#define     _LoadHWU(addr, value, res, type) \
 		__asm__ __volatile__ (                      \
 			".set\tnoat\n"                      \
-			"1:\t"user_lbu("%0", "0(%2)")"\n"   \
-			"2:\t"user_lbu("$1", "1(%2)")"\n\t" \
+			"1:\t"type##_lbu("%0", "0(%2)")"\n"   \
+			"2:\t"type##_lbu("$1", "1(%2)")"\n\t" \
 			"sll\t%0, 0x8\n\t"                  \
 			"or\t%0, $1\n\t"                    \
 			"li\t%1, 0\n"                       \
@@ -204,10 +204,10 @@ extern void show_registers(struct pt_regs *regs);
 			: "r" (addr), "i" (-EFAULT));
 
 #ifndef CONFIG_CPU_MIPSR6
-#define     LoadWU(addr, value, res)  \
+#define     _LoadWU(addr, value, res, type)  \
 		__asm__ __volatile__ (                      \
-			"1:\t"user_lwl("%0", "(%2)")"\n"    \
-			"2:\t"user_lwr("%0", "3(%2)")"\n\t" \
+			"1:\t"type##_lwl("%0", "(%2)")"\n"    \
+			"2:\t"type##_lwr("%0", "3(%2)")"\n\t" \
 			"dsll\t%0, %0, 32\n\t"              \
 			"dsrl\t%0, %0, 32\n\t"              \
 			"li\t%1, 0\n"                       \
@@ -224,7 +224,7 @@ extern void show_registers(struct pt_regs *regs);
 			: "=&r" (value), "=r" (res)         \
 			: "r" (addr), "i" (-EFAULT));
 
-#define     LoadDW(addr, value, res)  \
+#define     _LoadDW(addr, value, res)  \
 		__asm__ __volatile__ (                      \
 			"1:\tldl\t%0, (%2)\n"               \
 			"2:\tldr\t%0, 7(%2)\n\t"            \
@@ -243,18 +243,18 @@ extern void show_registers(struct pt_regs *regs);
 			: "r" (addr), "i" (-EFAULT));
 #else
 /* MIPSR6 has not lwl and ldl instructions */
-#define	    LoadWU(addr, value, res) \
+#define	    _LoadWU(addr, value, res, type) \
 		__asm__ __volatile__ (			    \
 			".set\tpush\n\t"		    \
 			".set\tnoat\n\t"		    \
-			"1:"user_lbu("%0", "0(%2)")"\n\t"   \
-			"2:"user_lbu("$1", "1(%2)")"\n\t"   \
+			"1:"type##_lbu("%0", "0(%2)")"\n\t"   \
+			"2:"type##_lbu("$1", "1(%2)")"\n\t"   \
 			"sll\t%0, 0x8\n\t"		    \
 			"or\t%0, $1\n\t"		    \
-			"3:"user_lbu("$1", "2(%2)")"\n\t"   \
+			"3:"type##_lbu("$1", "2(%2)")"\n\t"   \
 			"sll\t%0, 0x8\n\t"		    \
 			"or\t%0, $1\n\t"		    \
-			"4:"user_lbu("$1", "3(%2)")"\n\t"   \
+			"4:"type##_lbu("$1", "3(%2)")"\n\t"   \
 			"sll\t%0, 0x8\n\t"		    \
 			"or\t%0, $1\n\t"		    \
 			"li\t%1, 0\n"			    \
@@ -274,7 +274,7 @@ extern void show_registers(struct pt_regs *regs);
 			: "=&r" (value), "=r" (res)	    \
 			: "r" (addr), "i" (-EFAULT));
 
-#define     LoadDW(addr, value, res)  \
+#define     _LoadDW(addr, value, res)  \
 		__asm__ __volatile__ (			    \
 			".set\tpush\n\t"		    \
 			".set\tnoat\n\t"		    \
@@ -323,12 +323,12 @@ extern void show_registers(struct pt_regs *regs);
 #endif /* CONFIG_CPU_MIPSR6 */
 
 
-#define     StoreHW(addr, value, res) \
+#define     _StoreHW(addr, value, res, type) \
 		__asm__ __volatile__ (                      \
 			".set\tnoat\n"                      \
-			"1:\t"user_sb("%1", "1(%2)")"\n"    \
+			"1:\t"type##_sb("%1", "1(%2)")"\n"    \
 			"srl\t$1, %1, 0x8\n"                \
-			"2:\t"user_sb("$1", "0(%2)")"\n"    \
+			"2:\t"type##_sb("$1", "0(%2)")"\n"    \
 			".set\tat\n\t"                      \
 			"li\t%0, 0\n"                       \
 			"3:\n\t"                            \
@@ -345,10 +345,10 @@ extern void show_registers(struct pt_regs *regs);
 			: "r" (value), "r" (addr), "i" (-EFAULT));
 
 #ifndef CONFIG_CPU_MIPSR6
-#define     StoreW(addr, value, res)  \
+#define     _StoreW(addr, value, res, type)  \
 		__asm__ __volatile__ (                      \
-			"1:\t"user_swl("%1", "(%2)")"\n"    \
-			"2:\t"user_swr("%1", "3(%2)")"\n\t" \
+			"1:\t"type##_swl("%1", "(%2)")"\n"    \
+			"2:\t"type##_swr("%1", "3(%2)")"\n\t" \
 			"li\t%0, 0\n"                       \
 			"3:\n\t"                            \
 			".insn\n\t"                         \
@@ -363,7 +363,7 @@ extern void show_registers(struct pt_regs *regs);
 		: "=r" (res)                                \
 		: "r" (value), "r" (addr), "i" (-EFAULT));
 
-#define     StoreDW(addr, value, res) \
+#define     _StoreDW(addr, value, res) \
 		__asm__ __volatile__ (                      \
 			"1:\tsdl\t%1,(%2)\n"                \
 			"2:\tsdr\t%1, 7(%2)\n\t"            \
@@ -382,17 +382,17 @@ extern void show_registers(struct pt_regs *regs);
 		: "r" (value), "r" (addr), "i" (-EFAULT));
 #else
 /* MIPSR6 has no swl and sdl instructions */
-#define     StoreW(addr, value, res)  \
+#define     _StoreW(addr, value, res, type)  \
 		__asm__ __volatile__ (                      \
 			".set\tpush\n\t"		    \
 			".set\tnoat\n\t"		    \
-			"1:"user_sb("%1", "3(%2)")"\n\t"    \
+			"1:"type##_sb("%1", "3(%2)")"\n\t"  \
 			"srl\t$1, %1, 0x8\n\t"		    \
-			"2:"user_sb("$1", "2(%2)")"\n\t"    \
+			"2:"type##_sb("$1", "2(%2)")"\n\t"  \
 			"srl\t$1, $1,  0x8\n\t"		    \
-			"3:"user_sb("$1", "1(%2)")"\n\t"    \
+			"3:"type##_sb("$1", "1(%2)")"\n\t"  \
 			"srl\t$1, $1, 0x8\n\t"		    \
-			"4:"user_sb("$1", "0(%2)")"\n\t"    \
+			"4:"type##_sb("$1", "0(%2)")"\n\t"  \
 			".set\tpop\n\t"			    \
 			"li\t%0, 0\n"			    \
 			"10:\n\t"			    \
@@ -456,10 +456,10 @@ extern void show_registers(struct pt_regs *regs);
 
 #else /* __BIG_ENDIAN */
 
-#define     LoadHW(addr, value, res)  \
+#define     _LoadHW(addr, value, res, type)  \
 		__asm__ __volatile__ (".set\tnoat\n"        \
-			"1:\t"user_lb("%0", "1(%2)")"\n"    \
-			"2:\t"user_lbu("$1", "0(%2)")"\n\t" \
+			"1:\t"type##_lb("%0", "1(%2)")"\n"    \
+			"2:\t"type##_lbu("$1", "0(%2)")"\n\t" \
 			"sll\t%0, 0x8\n\t"                  \
 			"or\t%0, $1\n\t"                    \
 			"li\t%1, 0\n"                       \
@@ -477,10 +477,10 @@ extern void show_registers(struct pt_regs *regs);
 			: "r" (addr), "i" (-EFAULT));
 
 #ifndef CONFIG_CPU_MIPSR6
-#define     LoadW(addr, value, res)   \
+#define     _LoadW(addr, value, res, type)   \
 		__asm__ __volatile__ (                      \
-			"1:\t"user_lwl("%0", "3(%2)")"\n"   \
-			"2:\t"user_lwr("%0", "(%2)")"\n\t"  \
+			"1:\t"type##_lwl("%0", "3(%2)")"\n"   \
+			"2:\t"type##_lwr("%0", "(%2)")"\n\t"  \
 			"li\t%1, 0\n"                       \
 			"3:\n\t"                            \
 			".insn\n\t"                         \
@@ -496,18 +496,18 @@ extern void show_registers(struct pt_regs *regs);
 			: "r" (addr), "i" (-EFAULT));
 #else
 /* MIPSR6 has no lwl instruction */
-#define     LoadW(addr, value, res) \
+#define     _LoadW(addr, value, res, type) \
 		__asm__ __volatile__ (			    \
 			".set\tpush\n"			    \
 			".set\tnoat\n\t"		    \
-			"1:"user_lb("%0", "3(%2)")"\n\t"    \
-			"2:"user_lbu("$1", "2(%2)")"\n\t"   \
+			"1:"type##_lb("%0", "3(%2)")"\n\t"    \
+			"2:"type##_lbu("$1", "2(%2)")"\n\t"   \
 			"sll\t%0, 0x8\n\t"		    \
 			"or\t%0, $1\n\t"		    \
-			"3:"user_lbu("$1", "1(%2)")"\n\t"   \
+			"3:"type##_lbu("$1", "1(%2)")"\n\t"   \
 			"sll\t%0, 0x8\n\t"		    \
 			"or\t%0, $1\n\t"		    \
-			"4:"user_lbu("$1", "0(%2)")"\n\t"   \
+			"4:"type##_lbu("$1", "0(%2)")"\n\t"   \
 			"sll\t%0, 0x8\n\t"		    \
 			"or\t%0, $1\n\t"		    \
 			"li\t%1, 0\n"			    \
@@ -529,11 +529,11 @@ extern void show_registers(struct pt_regs *regs);
 #endif /* CONFIG_CPU_MIPSR6 */
 
 
-#define     LoadHWU(addr, value, res) \
+#define     _LoadHWU(addr, value, res, type) \
 		__asm__ __volatile__ (                      \
 			".set\tnoat\n"                      \
-			"1:\t"user_lbu("%0", "1(%2)")"\n"   \
-			"2:\t"user_lbu("$1", "0(%2)")"\n\t" \
+			"1:\t"type##_lbu("%0", "1(%2)")"\n"   \
+			"2:\t"type##_lbu("$1", "0(%2)")"\n\t" \
 			"sll\t%0, 0x8\n\t"                  \
 			"or\t%0, $1\n\t"                    \
 			"li\t%1, 0\n"                       \
@@ -552,10 +552,10 @@ extern void show_registers(struct pt_regs *regs);
 			: "r" (addr), "i" (-EFAULT));
 
 #ifndef CONFIG_CPU_MIPSR6
-#define     LoadWU(addr, value, res)  \
+#define     _LoadWU(addr, value, res, type)  \
 		__asm__ __volatile__ (                      \
-			"1:\t"user_lwl("%0", "3(%2)")"\n"   \
-			"2:\t"user_lwr("%0", "(%2)")"\n\t"  \
+			"1:\t"type##_lwl("%0", "3(%2)")"\n"   \
+			"2:\t"type##_lwr("%0", "(%2)")"\n\t"  \
 			"dsll\t%0, %0, 32\n\t"              \
 			"dsrl\t%0, %0, 32\n\t"              \
 			"li\t%1, 0\n"                       \
@@ -572,7 +572,7 @@ extern void show_registers(struct pt_regs *regs);
 			: "=&r" (value), "=r" (res)         \
 			: "r" (addr), "i" (-EFAULT));
 
-#define     LoadDW(addr, value, res)  \
+#define     _LoadDW(addr, value, res)  \
 		__asm__ __volatile__ (                      \
 			"1:\tldl\t%0, 7(%2)\n"              \
 			"2:\tldr\t%0, (%2)\n\t"             \
@@ -591,18 +591,18 @@ extern void show_registers(struct pt_regs *regs);
 			: "r" (addr), "i" (-EFAULT));
 #else
 /* MIPSR6 has not lwl and ldl instructions */
-#define	    LoadWU(addr, value, res) \
+#define	    _LoadWU(addr, value, res, type) \
 		__asm__ __volatile__ (			    \
 			".set\tpush\n\t"		    \
 			".set\tnoat\n\t"		    \
-			"1:"user_lbu("%0", "3(%2)")"\n\t"   \
-			"2:"user_lbu("$1", "2(%2)")"\n\t"   \
+			"1:"type##_lbu("%0", "3(%2)")"\n\t"   \
+			"2:"type##_lbu("$1", "2(%2)")"\n\t"   \
 			"sll\t%0, 0x8\n\t"		    \
 			"or\t%0, $1\n\t"		    \
-			"3:"user_lbu("$1", "1(%2)")"\n\t"   \
+			"3:"type##_lbu("$1", "1(%2)")"\n\t"   \
 			"sll\t%0, 0x8\n\t"		    \
 			"or\t%0, $1\n\t"		    \
-			"4:"user_lbu("$1", "0(%2)")"\n\t"   \
+			"4:"type##_lbu("$1", "0(%2)")"\n\t"   \
 			"sll\t%0, 0x8\n\t"		    \
 			"or\t%0, $1\n\t"		    \
 			"li\t%1, 0\n"			    \
@@ -622,7 +622,7 @@ extern void show_registers(struct pt_regs *regs);
 			: "=&r" (value), "=r" (res)	    \
 			: "r" (addr), "i" (-EFAULT));
 
-#define     LoadDW(addr, value, res)  \
+#define     _LoadDW(addr, value, res)  \
 		__asm__ __volatile__ (			    \
 			".set\tpush\n\t"		    \
 			".set\tnoat\n\t"		    \
@@ -670,12 +670,12 @@ extern void show_registers(struct pt_regs *regs);
 			: "r" (addr), "i" (-EFAULT));
 #endif /* CONFIG_CPU_MIPSR6 */
 
-#define     StoreHW(addr, value, res) \
+#define     _StoreHW(addr, value, res, type) \
 		__asm__ __volatile__ (                      \
 			".set\tnoat\n"                      \
-			"1:\t"user_sb("%1", "0(%2)")"\n"    \
+			"1:\t"type##_sb("%1", "0(%2)")"\n"    \
 			"srl\t$1,%1, 0x8\n"                 \
-			"2:\t"user_sb("$1", "1(%2)")"\n"    \
+			"2:\t"type##_sb("$1", "1(%2)")"\n"    \
 			".set\tat\n\t"                      \
 			"li\t%0, 0\n"                       \
 			"3:\n\t"                            \
@@ -691,10 +691,10 @@ extern void show_registers(struct pt_regs *regs);
 			: "=r" (res)                        \
 			: "r" (value), "r" (addr), "i" (-EFAULT));
 #ifndef CONFIG_CPU_MIPSR6
-#define     StoreW(addr, value, res)  \
+#define     _StoreW(addr, value, res, type)  \
 		__asm__ __volatile__ (                      \
-			"1:\t"user_swl("%1", "3(%2)")"\n"   \
-			"2:\t"user_swr("%1", "(%2)")"\n\t"  \
+			"1:\t"type##_swl("%1", "3(%2)")"\n"   \
+			"2:\t"type##_swr("%1", "(%2)")"\n\t"  \
 			"li\t%0, 0\n"                       \
 			"3:\n\t"                            \
 			".insn\n\t"                         \
@@ -709,7 +709,7 @@ extern void show_registers(struct pt_regs *regs);
 		: "=r" (res)                                \
 		: "r" (value), "r" (addr), "i" (-EFAULT));
 
-#define     StoreDW(addr, value, res) \
+#define     _StoreDW(addr, value, res) \
 		__asm__ __volatile__ (                      \
 			"1:\tsdl\t%1, 7(%2)\n"              \
 			"2:\tsdr\t%1, (%2)\n\t"             \
@@ -728,17 +728,17 @@ extern void show_registers(struct pt_regs *regs);
 		: "r" (value), "r" (addr), "i" (-EFAULT));
 #else
 /* MIPSR6 has no swl and sdl instructions */
-#define     StoreW(addr, value, res)  \
+#define     StoreW(addr, value, res, type)  \
 		__asm__ __volatile__ (                      \
 			".set\tpush\n\t"		    \
 			".set\tnoat\n\t"		    \
-			"1:"user_sb("%1", "0(%2)")"\n\t"    \
+			"1:"type##_sb("%1", "0(%2)")"\n\t"    \
 			"srl\t$1, %1, 0x8\n\t"		    \
-			"2:"user_sb("$1", "1(%2)")"\n\t"    \
+			"2:"type##_sb("$1", "1(%2)")"\n\t"    \
 			"srl\t$1, $1,  0x8\n\t"		    \
-			"3:"user_sb("$1", "2(%2)")"\n\t"    \
+			"3:"type##_sb("$1", "2(%2)")"\n\t"    \
 			"srl\t$1, $1, 0x8\n\t"		    \
-			"4:"user_sb("$1", "3(%2)")"\n\t"    \
+			"4:"type##_sb("$1", "3(%2)")"\n\t"    \
 			".set\tpop\n\t"			    \
 			"li\t%0, 0\n"			    \
 			"10:\n\t"			    \
@@ -801,6 +801,22 @@ extern void show_registers(struct pt_regs *regs);
 #endif /* CONFIG_CPU_MIPSR6 */
 #endif
 
+#define LoadHWU(addr, value, res)	_LoadHWU(addr, value, res, kernel)
+#define LoadHWUE(addr, value, res)	_LoadHWU(addr, value, res, user)
+#define LoadWU(addr, value, res)	_LoadWU(addr, value, res, kernel)
+#define LoadWUE(addr, value, res)	_LoadWU(addr, value, res, user)
+#define LoadHW(addr, value, res)	_LoadHW(addr, value, res, kernel)
+#define LoadHWE(addr, value, res)	_LoadHW(addr, value, res, user)
+#define LoadW(addr, value, res)		_LoadW(addr, value, res, kernel)
+#define LoadWE(addr, value, res)	_LoadW(addr, value, res, user)
+#define LoadDW(addr, value, res)	_LoadDW(addr, value, res)
+
+#define StoreHW(addr, value, res)	_StoreHW(addr, value, res, kernel)
+#define StoreHWE(addr, value, res)	_StoreHW(addr, value, res, user)
+#define StoreW(addr, value, res)	_StoreW(addr, value, res, kernel)
+#define StoreWE(addr, value, res)	_StoreW(addr, value, res, user)
+#define StoreDW(addr, value, res)	_StoreDW(addr, value, res)
+
 static void emulate_load_store_insn(struct pt_regs *regs,
 	void __user *addr, unsigned int __user *pc)
 {
@@ -872,7 +888,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 				set_fs(seg);
 				goto sigbus;
 			}
-			LoadHW(addr, value, res);
+			LoadHWE(addr, value, res);
 			if (res) {
 				set_fs(seg);
 				goto fault;
@@ -885,7 +901,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 				set_fs(seg);
 				goto sigbus;
 			}
-				LoadW(addr, value, res);
+				LoadWE(addr, value, res);
 			if (res) {
 				set_fs(seg);
 				goto fault;
@@ -898,7 +914,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 				set_fs(seg);
 				goto sigbus;
 			}
-			LoadHWU(addr, value, res);
+			LoadHWUE(addr, value, res);
 			if (res) {
 				set_fs(seg);
 				goto fault;
@@ -913,7 +929,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 			}
 			compute_return_epc(regs);
 			value = regs->regs[insn.spec3_format.rt];
-			StoreHW(addr, value, res);
+			StoreHWE(addr, value, res);
 			if (res) {
 				set_fs(seg);
 				goto fault;
@@ -926,7 +942,7 @@ static void emulate_load_store_insn(struct pt_regs *regs,
 			}
 			compute_return_epc(regs);
 			value = regs->regs[insn.spec3_format.rt];
-			StoreW(addr, value, res);
+			StoreWE(addr, value, res);
 			if (res) {
 				set_fs(seg);
 				goto fault;
-- 
2.3.0
