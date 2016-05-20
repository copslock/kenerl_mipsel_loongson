Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 May 2016 00:29:23 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22771 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27029076AbcETW3CgyhYC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 21 May 2016 00:29:02 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 67CC02DB545AC;
        Fri, 20 May 2016 23:28:52 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 20 May 2016 23:28:56 +0100
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Fri, 20 May 2016 23:28:55 +0100
From:   James Hogan <james.hogan@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>, <linux-mips@linux-mips.org>
Subject: [PATCH for-v4.7 2/5] MIPS: Add missing VZ accessor microMIPS encodings
Date:   Fri, 20 May 2016 23:28:38 +0100
Message-ID: <1463783321-24442-3-git-send-email-james.hogan@imgtec.com>
X-Mailer: git-send-email 2.4.10
In-Reply-To: <1463783321-24442-1-git-send-email-james.hogan@imgtec.com>
References: <1463783321-24442-1-git-send-email-james.hogan@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53567
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
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

Toolchains may be used which support microMIPS but not VZ instructions
(i.e. binutis 2.22 & 2.23), so extend the explicitly encoded versions of
the guest COP0 register & guest TLB access macros to support microMIPS
encodings too, using the new macros.

This prevents non-microMIPS instructions being executed in microMIPS
mode during CPU probe on cores supporting VZ (e.g. M5150), which cause
reserved instruction exceptions early during boot.

Fixes: bad50d79255a ("MIPS: Fix VZ probe gas errors with binutils <2.24")
Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
---
 arch/mips/include/asm/mipsregs.h | 27 ++++++++++++++++++---------
 1 file changed, 18 insertions(+), 9 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 744dec36773c..fa0bde2fb881 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1770,7 +1770,8 @@ do {									\
 		".set\tpush\n\t"					\
 		".set\tnoat\n\t"					\
 		"# mfgc0\t$1, $%1, %2\n\t"				\
-		".word\t(0x40610000 | %1 << 11 | %2)\n\t"		\
+		_ASM_INSN_IF_MIPS(0x40610000 | %1 << 11 | %2)		\
+		_ASM_INSN32_IF_MM(0x002004fc | %1 << 16 | %2 << 11)	\
 		"move\t%0, $1\n\t"					\
 		".set\tpop"						\
 		: "=r" (__res)						\
@@ -1784,7 +1785,8 @@ do {									\
 		".set\tpush\n\t"					\
 		".set\tnoat\n\t"					\
 		"# dmfgc0\t$1, $%1, %2\n\t"				\
-		".word\t(0x40610100 | %1 << 11 | %2)\n\t"		\
+		_ASM_INSN_IF_MIPS(0x40610100 | %1 << 11 | %2)		\
+		_ASM_INSN32_IF_MM(0x582004fc | %1 << 16 | %2 << 11)	\
 		"move\t%0, $1\n\t"					\
 		".set\tpop"						\
 		: "=r" (__res)						\
@@ -1799,7 +1801,8 @@ do {									\
 		".set\tnoat\n\t"					\
 		"move\t$1, %z0\n\t"					\
 		"# mtgc0\t$1, $%1, %2\n\t"				\
-		".word\t(0x40610200 | %1 << 11 | %2)\n\t"		\
+		_ASM_INSN_IF_MIPS(0x40610200 | %1 << 11 | %2)		\
+		_ASM_INSN32_IF_MM(0x002006fc | %1 << 16 | %2 << 11)	\
 		".set\tpop"						\
 		: : "Jr" ((unsigned int)(value)),			\
 		    "i" (register), "i" (sel));				\
@@ -1812,7 +1815,8 @@ do {									\
 		".set\tnoat\n\t"					\
 		"move\t$1, %z0\n\t"					\
 		"# dmtgc0\t$1, $%1, %2\n\t"				\
-		".word\t(0x40610300 | %1 << 11 | %2)\n\t"		\
+		_ASM_INSN_IF_MIPS(0x40610300 | %1 << 11 | %2)		\
+		_ASM_INSN32_IF_MM(0x582006fc | %1 << 16 | %2 << 11)	\
 		".set\tpop"						\
 		: : "Jr" (value),					\
 		    "i" (register), "i" (sel));				\
@@ -2583,28 +2587,32 @@ static inline void guest_tlb_probe(void)
 {
 	__asm__ __volatile__(
 		"# tlbgp\n\t"
-		".word 0x42000010");
+		_ASM_INSN_IF_MIPS(0x42000010)
+		_ASM_INSN32_IF_MM(0x0000017c));
 }
 
 static inline void guest_tlb_read(void)
 {
 	__asm__ __volatile__(
 		"# tlbgr\n\t"
-		".word 0x42000009");
+		_ASM_INSN_IF_MIPS(0x42000009)
+		_ASM_INSN32_IF_MM(0x0000117c));
 }
 
 static inline void guest_tlb_write_indexed(void)
 {
 	__asm__ __volatile__(
 		"# tlbgwi\n\t"
-		".word 0x4200000a");
+		_ASM_INSN_IF_MIPS(0x4200000a)
+		_ASM_INSN32_IF_MM(0x0000217c));
 }
 
 static inline void guest_tlb_write_random(void)
 {
 	__asm__ __volatile__(
 		"# tlbgwr\n\t"
-		".word 0x4200000e");
+		_ASM_INSN_IF_MIPS(0x4200000e)
+		_ASM_INSN32_IF_MM(0x0000317c));
 }
 
 /*
@@ -2614,7 +2622,8 @@ static inline void guest_tlbinvf(void)
 {
 	__asm__ __volatile__(
 		"# tlbginvf\n\t"
-		".word 0x4200000c");
+		_ASM_INSN_IF_MIPS(0x4200000c)
+		_ASM_INSN32_IF_MM(0x0000517c));
 }
 
 #endif	/* !TOOLCHAIN_SUPPORTS_VIRT */
-- 
2.4.10
