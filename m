Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 13 Nov 2014 07:06:35 +0100 (CET)
Received: from home.bethel-hill.org ([63.228.164.32]:33765 "EHLO
        home.bethel-hill.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012561AbaKMGF77Kt9B (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 13 Nov 2014 07:05:59 +0100
Received: by home.bethel-hill.org with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <Steven.Hill@imgtec.com>)
        id 1XonXV-0007Qu-2x; Thu, 13 Nov 2014 00:05:53 -0600
From:   "Steven J. Hill" <Steven.Hill@imgtec.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org
Subject: [PATCH 06/11] MIPS: Add CP0 macros for extended EntryLo registers
Date:   Thu, 13 Nov 2014 00:05:38 -0600
Message-Id: <1415858743-24492-7-git-send-email-Steven.Hill@imgtec.com>
X-Mailer: git-send-email 1.7.10.4
In-Reply-To: <1415858743-24492-1-git-send-email-Steven.Hill@imgtec.com>
References: <1415858743-24492-1-git-send-email-Steven.Hill@imgtec.com>
Return-Path: <Steven.Hill@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 44093
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

Add read/write macros to access the upper bits of the
extended EntryLo0 and EntryLo1 registers used by XPA.

Signed-off-by: Steven J. Hill <Steven.Hill@imgtec.com>
---
 arch/mips/include/asm/mipsregs.h |   39 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 39 insertions(+)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index d767838..eaae8b0 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -997,6 +997,39 @@ do {									\
 	local_irq_restore(__flags);					\
 } while (0)
 
+#define __readx_32bit_c0_register(source)				\
+({									\
+	unsigned int __res;						\
+									\
+	__asm__ __volatile__(						\
+	"	.set	push					\n"	\
+	"	.set	noat					\n"	\
+	"	.set	mips32r2				\n"	\
+	"	.insn						\n"	\
+	"	# mfhc0 $1, %1					\n"	\
+	"	.word	(0x40410000 | ((%1 & 0x1f) << 11))	\n"	\
+	"	move	%0, $1					\n"	\
+	"	.set	pop					\n"	\
+	: "=r" (__res)							\
+	: "i" (source));						\
+	__res;								\
+})
+
+#define __writex_32bit_c0_register(register, value)			\
+do {									\
+	__asm__ __volatile__(						\
+	"	.set	push					\n"	\
+	"	.set	noat					\n"	\
+	"	.set	mips32r2				\n"	\
+	"	move	$1, %0					\n"	\
+	"	# mthc0 $1, %1					\n"	\
+	"	.insn						\n"	\
+	"	.word	(0x40c10000 | ((" #register " & 0x1f) << 11))	\n"	\
+	"	.set	pop					\n"	\
+	:								\
+	: "r" (value), "i" (register));					\
+} while (0)
+
 #define read_c0_index()		__read_32bit_c0_register($0, 0)
 #define write_c0_index(val)	__write_32bit_c0_register($0, 0, val)
 
@@ -1006,9 +1039,15 @@ do {									\
 #define read_c0_entrylo0()	__read_ulong_c0_register($2, 0)
 #define write_c0_entrylo0(val)	__write_ulong_c0_register($2, 0, val)
 
+#define readx_c0_entrylo0()	__readx_32bit_c0_register(2)
+#define writex_c0_entrylo0(val)	__writex_32bit_c0_register(2, val)
+
 #define read_c0_entrylo1()	__read_ulong_c0_register($3, 0)
 #define write_c0_entrylo1(val)	__write_ulong_c0_register($3, 0, val)
 
+#define readx_c0_entrylo1()	__readx_32bit_c0_register(3)
+#define writex_c0_entrylo1(val)	__writex_32bit_c0_register(3, val)
+
 #define read_c0_conf()		__read_32bit_c0_register($3, 0)
 #define write_c0_conf(val)	__write_32bit_c0_register($3, 0, val)
 
-- 
1.7.10.4
