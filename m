Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:30:22 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:43611 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6870551AbaA0UXyc0owH (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:23:54 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 30/58] MIPS: kernel: unaligned: Add EVA instruction wrappers
Date:   Mon, 27 Jan 2014 20:19:17 +0000
Message-ID: <1390853985-14246-31-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_23_49
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39148
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

Use the load/store instruction wrappers from asm/asm.h to
perform such operations when operating in EVA mode.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/kernel/unaligned.c | 49 ++++++++++++++++++++++----------------------
 1 file changed, 25 insertions(+), 24 deletions(-)

diff --git a/arch/mips/kernel/unaligned.c b/arch/mips/kernel/unaligned.c
index c369a5d..5ec8f00 100644
--- a/arch/mips/kernel/unaligned.c
+++ b/arch/mips/kernel/unaligned.c
@@ -7,6 +7,7 @@
  *
  * Copyright (C) 1996, 1998, 1999, 2002 by Ralf Baechle
  * Copyright (C) 1999 Silicon Graphics, Inc.
+ * Copyright (C) 2014 Imagination Technologies Ltd.
  *
  * This file contains exception handler for address error exception with the
  * special capability to execute faulting instructions in software.  The
@@ -110,8 +111,8 @@ extern void show_registers(struct pt_regs *regs);
 #ifdef __BIG_ENDIAN
 #define     LoadHW(addr, value, res)  \
 		__asm__ __volatile__ (".set\tnoat\n"        \
-			"1:\tlb\t%0, 0(%2)\n"               \
-			"2:\tlbu\t$1, 1(%2)\n\t"            \
+			"1:\t"user_lb("%0", "0(%2)")"\n"    \
+			"2:\t"user_lbu("$1", "1(%2)")"\n\t" \
 			"sll\t%0, 0x8\n\t"                  \
 			"or\t%0, $1\n\t"                    \
 			"li\t%1, 0\n"                       \
@@ -130,8 +131,8 @@ extern void show_registers(struct pt_regs *regs);
 
 #define     LoadW(addr, value, res)   \
 		__asm__ __volatile__ (                      \
-			"1:\tlwl\t%0, (%2)\n"               \
-			"2:\tlwr\t%0, 3(%2)\n\t"            \
+			"1:\t"user_lwl("%0", "(%2)")"\n"    \
+			"2:\t"user_lwr("%0", "3(%2)")"\n\t" \
 			"li\t%1, 0\n"                       \
 			"3:\n\t"                            \
 			".insn\n\t"                         \
@@ -149,8 +150,8 @@ extern void show_registers(struct pt_regs *regs);
 #define     LoadHWU(addr, value, res) \
 		__asm__ __volatile__ (                      \
 			".set\tnoat\n"                      \
-			"1:\tlbu\t%0, 0(%2)\n"              \
-			"2:\tlbu\t$1, 1(%2)\n\t"            \
+			"1:\t"user_lbu("%0", "0(%2)")"\n"   \
+			"2:\t"user_lbu("$1", "1(%2)")"\n\t" \
 			"sll\t%0, 0x8\n\t"                  \
 			"or\t%0, $1\n\t"                    \
 			"li\t%1, 0\n"                       \
@@ -170,8 +171,8 @@ extern void show_registers(struct pt_regs *regs);
 
 #define     LoadWU(addr, value, res)  \
 		__asm__ __volatile__ (                      \
-			"1:\tlwl\t%0, (%2)\n"               \
-			"2:\tlwr\t%0, 3(%2)\n\t"            \
+			"1:\t"user_lwl("%0", "(%2)")"\n"    \
+			"2:\t"user_lwr("%0", "3(%2)")"\n\t" \
 			"dsll\t%0, %0, 32\n\t"              \
 			"dsrl\t%0, %0, 32\n\t"              \
 			"li\t%1, 0\n"                       \
@@ -209,9 +210,9 @@ extern void show_registers(struct pt_regs *regs);
 #define     StoreHW(addr, value, res) \
 		__asm__ __volatile__ (                      \
 			".set\tnoat\n"                      \
-			"1:\tsb\t%1, 1(%2)\n\t"             \
+			"1:\t"user_sb("%1", "1(%2)")"\n"    \
 			"srl\t$1, %1, 0x8\n"                \
-			"2:\tsb\t$1, 0(%2)\n\t"             \
+			"2:\t"user_sb("$1", "0(%2)")"\n"    \
 			".set\tat\n\t"                      \
 			"li\t%0, 0\n"                       \
 			"3:\n\t"                            \
@@ -229,8 +230,8 @@ extern void show_registers(struct pt_regs *regs);
 
 #define     StoreW(addr, value, res)  \
 		__asm__ __volatile__ (                      \
-			"1:\tswl\t%1,(%2)\n"                \
-			"2:\tswr\t%1, 3(%2)\n\t"            \
+			"1:\t"user_swl("%1", "(%2)")"\n"    \
+			"2:\t"user_swr("%1", "3(%2)")"\n\t" \
 			"li\t%0, 0\n"                       \
 			"3:\n\t"                            \
 			".insn\n\t"                         \
@@ -267,8 +268,8 @@ extern void show_registers(struct pt_regs *regs);
 #ifdef __LITTLE_ENDIAN
 #define     LoadHW(addr, value, res)  \
 		__asm__ __volatile__ (".set\tnoat\n"        \
-			"1:\tlb\t%0, 1(%2)\n"               \
-			"2:\tlbu\t$1, 0(%2)\n\t"            \
+			"1:\t"user_lb("%0", "1(%2)")"\n"    \
+			"2:\t"user_lbu("$1", "0(%2)")"\n\t" \
 			"sll\t%0, 0x8\n\t"                  \
 			"or\t%0, $1\n\t"                    \
 			"li\t%1, 0\n"                       \
@@ -287,8 +288,8 @@ extern void show_registers(struct pt_regs *regs);
 
 #define     LoadW(addr, value, res)   \
 		__asm__ __volatile__ (                      \
-			"1:\tlwl\t%0, 3(%2)\n"              \
-			"2:\tlwr\t%0, (%2)\n\t"             \
+			"1:\t"user_lwl("%0", "3(%2)")"\n"   \
+			"2:\t"user_lwr("%0", "(%2)")"\n\t"  \
 			"li\t%1, 0\n"                       \
 			"3:\n\t"                            \
 			".insn\n\t"                         \
@@ -306,8 +307,8 @@ extern void show_registers(struct pt_regs *regs);
 #define     LoadHWU(addr, value, res) \
 		__asm__ __volatile__ (                      \
 			".set\tnoat\n"                      \
-			"1:\tlbu\t%0, 1(%2)\n"              \
-			"2:\tlbu\t$1, 0(%2)\n\t"            \
+			"1:\t"user_lbu("%0", "1(%2)")"\n"   \
+			"2:\t"user_lbu("$1", "0(%2)")"\n\t" \
 			"sll\t%0, 0x8\n\t"                  \
 			"or\t%0, $1\n\t"                    \
 			"li\t%1, 0\n"                       \
@@ -327,8 +328,8 @@ extern void show_registers(struct pt_regs *regs);
 
 #define     LoadWU(addr, value, res)  \
 		__asm__ __volatile__ (                      \
-			"1:\tlwl\t%0, 3(%2)\n"              \
-			"2:\tlwr\t%0, (%2)\n\t"             \
+			"1:\t"user_lwl("%0", "3(%2)")"\n"   \
+			"2:\t"user_lwr("%0", "(%2)")"\n\t"  \
 			"dsll\t%0, %0, 32\n\t"              \
 			"dsrl\t%0, %0, 32\n\t"              \
 			"li\t%1, 0\n"                       \
@@ -366,9 +367,9 @@ extern void show_registers(struct pt_regs *regs);
 #define     StoreHW(addr, value, res) \
 		__asm__ __volatile__ (                      \
 			".set\tnoat\n"                      \
-			"1:\tsb\t%1, 0(%2)\n\t"             \
+			"1:\t"user_sb("%1", "0(%2)")"\n"    \
 			"srl\t$1,%1, 0x8\n"                 \
-			"2:\tsb\t$1, 1(%2)\n\t"             \
+			"2:\t"user_sb("$1", "1(%2)")"\n"    \
 			".set\tat\n\t"                      \
 			"li\t%0, 0\n"                       \
 			"3:\n\t"                            \
@@ -386,8 +387,8 @@ extern void show_registers(struct pt_regs *regs);
 
 #define     StoreW(addr, value, res)  \
 		__asm__ __volatile__ (                      \
-			"1:\tswl\t%1, 3(%2)\n"              \
-			"2:\tswr\t%1, (%2)\n\t"             \
+			"1:\t"user_swl("%1", "3(%2)")"\n"   \
+			"2:\t"user_swr("%1", "(%2)")"\n\t"  \
 			"li\t%0, 0\n"                       \
 			"3:\n\t"                            \
 			".insn\n\t"                         \
-- 
1.8.5.3
