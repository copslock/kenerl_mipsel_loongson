Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Jan 2014 21:33:55 +0100 (CET)
Received: from multi.imgtec.com ([194.200.65.239]:44752 "EHLO multi.imgtec.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817294AbaA0UZ1ZCKqy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 27 Jan 2014 21:25:27 +0100
From:   Markos Chandras <markos.chandras@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>,
        Markos Chandras <markos.chandras@imgtec.com>
Subject: [PATCH 40/58] MIPS: asm: r4kcache: Add protected cache operation for EVA
Date:   Mon, 27 Jan 2014 20:19:27 +0000
Message-ID: <1390853985-14246-41-git-send-email-markos.chandras@imgtec.com>
X-Mailer: git-send-email 1.8.5.3
In-Reply-To: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
References: <1390853985-14246-1-git-send-email-markos.chandras@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.154.47]
X-SEF-Processed: 7_3_0_01192__2014_01_27_20_25_22
Return-Path: <Markos.Chandras@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39159
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

From: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>

Signed-off-by: Leonid Yegoshin <Leonid.Yegoshin@imgtec.com>
Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
---
 arch/mips/include/asm/r4kcache.h | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index a89e86d..ae026bf 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -212,6 +212,20 @@ static inline void flush_scache_line(unsigned long addr)
 	:							\
 	: "i" (op), "r" (addr))
 
+#define protected_cachee_op(op,addr)				\
+	__asm__ __volatile__(					\
+	"	.set	push			\n"		\
+	"	.set	noreorder		\n"		\
+	"	.set	mips0			\n"		\
+	"	.set	eva			\n"		\
+	"1:	cachee	%0, (%1)		\n"		\
+	"2:	.set	pop			\n"		\
+	"	.section __ex_table,\"a\"	\n"		\
+	"	"STR(PTR)" 1b, 2b		\n"		\
+	"	.previous"					\
+	:							\
+	: "i" (op), "r" (addr))
+
 /*
  * The next two are for badland addresses like signal trampolines.
  */
@@ -223,7 +237,11 @@ static inline void protected_flush_icache_line(unsigned long addr)
 		break;
 
 	default:
+#ifdef CONFIG_EVA
+		protected_cachee_op(Hit_Invalidate_I, addr);
+#else
 		protected_cache_op(Hit_Invalidate_I, addr);
+#endif
 		break;
 	}
 }
-- 
1.8.5.3
