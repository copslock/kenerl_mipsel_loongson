Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Dec 2014 16:15:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:45020 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27009160AbaLRPLvN6zf9 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Dec 2014 16:11:51 +0100
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 6DF4A60D15EB1
        for <linux-mips@linux-mips.org>; Thu, 18 Dec 2014 15:11:41 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Thu, 18 Dec 2014 15:11:44 +0000
Received: from mchandras-linux.le.imgtec.org (192.168.154.125) by
 LEMAIL01.le.imgtec.org (192.168.152.62) with Microsoft SMTP Server (TLS) id
 14.3.210.2; Thu, 18 Dec 2014 15:11:43 +0000
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH RFC 17/67] MIPS: asm: r4kcache: Add MIPS R6 cache unroll functions
Date:   Thu, 18 Dec 2014 15:09:26 +0000
Message-ID: <1418915416-3196-18-git-send-email-markos.chandras@imgtec.com>
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
X-archive-position: 44752
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

MIPS R6 changed the 'cache' instruction opcode and reduced the
offset field to 8 bits. This means we now have to adjust the
base register every 256 bytes and as a result of which we can
no longer use the previous cache functions.

Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/r4kcache.h | 149 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 147 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index cd6e0afc6833..6a32e16a45d8 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -39,7 +39,7 @@ extern void (*r4k_blast_icache)(void);
 	__asm__ __volatile__(						\
 	"	.set	push					\n"	\
 	"	.set	noreorder				\n"	\
-	"	.set	arch=r4000				\n"	\
+	"	.set "MIPS_ISA_ARCH_LEVEL"			\n"	\
 	"	cache	%0, %1					\n"	\
 	"	.set	pop					\n"	\
 	:								\
@@ -206,7 +206,7 @@ static inline void flush_scache_line(unsigned long addr)
 	__asm__ __volatile__(					\
 	"	.set	push			\n"		\
 	"	.set	noreorder		\n"		\
-	"	.set	arch=r4000		\n"		\
+	"	.set "MIPS_ISA_ARCH_LEVEL"	\n"		\
 	"1:	cache	%0, (%1)		\n"		\
 	"2:	.set	pop			\n"		\
 	"	.section __ex_table,\"a\"	\n"		\
@@ -277,6 +277,7 @@ static inline void invalidate_tcache_page(unsigned long addr)
 	cache_op(Page_Invalidate_T, addr);
 }
 
+#ifndef CONFIG_CPU_MIPSR6
 #define cache16_unroll32(base,op)					\
 	__asm__ __volatile__(						\
 	"	.set push					\n"	\
@@ -381,6 +382,150 @@ static inline void invalidate_tcache_page(unsigned long addr)
 		: "r" (base),						\
 		  "i" (op));
 
+#else
+/*
+ * MIPS R6 changed the cache opcode and moved to a 8-bit offset field.
+ * This means we now need to increment the base register before we flush
+ * more cache lines
+ */
+#define cache16_unroll32(base,op)				\
+	__asm__ __volatile__(					\
+	"	.set push\n"					\
+	"	.set noreorder\n"				\
+	"	.set mips64r6\n"				\
+	"	.set noat\n"					\
+	"	cache %1, 0x000(%0); cache %1, 0x010(%0)\n"	\
+	"	cache %1, 0x020(%0); cache %1, 0x030(%0)\n"	\
+	"	cache %1, 0x040(%0); cache %1, 0x050(%0)\n"	\
+	"	cache %1, 0x060(%0); cache %1, 0x070(%0)\n"	\
+	"	cache %1, 0x080(%0); cache %1, 0x090(%0)\n"	\
+	"	cache %1, 0x0a0(%0); cache %1, 0x0b0(%0)\n"	\
+	"	cache %1, 0x0c0(%0); cache %1, 0x0d0(%0)\n"	\
+	"	cache %1, 0x0e0(%0); cache %1, 0x0f0(%0)\n"	\
+	"	addiu $1, $0, 0x100			\n"	\
+	"	cache %1, 0x000($1); cache %1, 0x010($1)\n"	\
+	"	cache %1, 0x020($1); cache %1, 0x030($1)\n"	\
+	"	cache %1, 0x040($1); cache %1, 0x050($1)\n"	\
+	"	cache %1, 0x060($1); cache %1, 0x070($1)\n"	\
+	"	cache %1, 0x080($1); cache %1, 0x090($1)\n"	\
+	"	cache %1, 0x0a0($1); cache %1, 0x0b0($1)\n"	\
+	"	cache %1, 0x0c0($1); cache %1, 0x0d0($1)\n"	\
+	"	cache %1, 0x0e0($1); cache %1, 0x0f0($1)\n"	\
+	"	.set pop\n"					\
+		:						\
+		: "r" (base),					\
+		  "i" (op));
+
+#define cache32_unroll32(base,op)				\
+	__asm__ __volatile__(					\
+	"	.set push\n"					\
+	"	.set noreorder\n"				\
+	"	.set mips64r6\n"				\
+	"	.set noat\n"					\
+	"	cache %1, 0x000(%0); cache %1, 0x020(%0)\n"	\
+	"	cache %1, 0x040(%0); cache %1, 0x060(%0)\n"	\
+	"	cache %1, 0x080(%0); cache %1, 0x0a0(%0)\n"	\
+	"	cache %1, 0x0c0(%0); cache %1, 0x0e0(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000($1); cache %1, 0x020($1)\n"	\
+	"	cache %1, 0x040($1); cache %1, 0x060($1)\n"	\
+	"	cache %1, 0x080($1); cache %1, 0x0a0($1)\n"	\
+	"	cache %1, 0x0c0($1); cache %1, 0x0e0($1)\n"	\
+	"	addiu $1, $1, 0x100\n"				\
+	"	cache %1, 0x000($1); cache %1, 0x020($1)\n"	\
+	"	cache %1, 0x040($1); cache %1, 0x060($1)\n"	\
+	"	cache %1, 0x080($1); cache %1, 0x0a0($1)\n"	\
+	"	cache %1, 0x0c0($1); cache %1, 0x0e0($1)\n"	\
+	"	addiu $1, $1, 0x100\n"				\
+	"	cache %1, 0x000($1); cache %1, 0x020($1)\n"	\
+	"	cache %1, 0x040($1); cache %1, 0x060($1)\n"	\
+	"	cache %1, 0x080($1); cache %1, 0x0a0($1)\n"	\
+	"	cache %1, 0x0c0($1); cache %1, 0x0e0($1)\n"	\
+	"	.set pop\n"					\
+		:						\
+		: "r" (base),					\
+		  "i" (op));
+
+#define cache64_unroll32(base,op)				\
+	__asm__ __volatile__(					\
+	"	.set push\n"					\
+	"	.set noreorder\n"				\
+	"	.set mips64r6\n"				\
+	"	.set noat\n"					\
+	"	cache %1, 0x000(%0); cache %1, 0x040(%0)\n"	\
+	"	cache %1, 0x080(%0); cache %1, 0x0c0(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000($1); cache %1, 0x040($1)\n"	\
+	"	cache %1, 0x080($1); cache %1, 0x0c0($1)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000($1); cache %1, 0x040($1)\n"	\
+	"	cache %1, 0x080($1); cache %1, 0x0c0($1)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000($1); cache %1, 0x040($1)\n"	\
+	"	cache %1, 0x080($1); cache %1, 0x0c0($1)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000($1); cache %1, 0x040($1)\n"	\
+	"	cache %1, 0x080($1); cache %1, 0x0c0($1)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000($1); cache %1, 0x040($1)\n"	\
+	"	cache %1, 0x080($1); cache %1, 0x0c0($1)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000($1); cache %1, 0x040($1)\n"	\
+	"	cache %1, 0x080($1); cache %1, 0x0c0($1)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000($1); cache %1, 0x040($1)\n"	\
+	"	cache %1, 0x080($1); cache %1, 0x0c0($1)\n"	\
+	"	.set pop\n"					\
+		:						\
+		: "r" (base),					\
+		  "i" (op));
+
+#define cache128_unroll32(base,op)				\
+	__asm__ __volatile__(					\
+	"	.set push\n"					\
+	"	.set noreorder\n"				\
+	"	.set mips64r6\n"				\
+	"	.set noat\n"					\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	cache %1, 0x000(%0); cache %1, 0x080(%0)\n"	\
+	"	addiu $1, %0, 0x100\n"				\
+	"	.set pop\n"					\
+		:						\
+		: "r" (base),					\
+		  "i" (op));
+#endif /* CONFIG_CPU_MIPSR6 */
+
 /*
  * Perform the cache operation specified by op using a user mode virtual
  * address while in kernel mode.
-- 
2.2.0
