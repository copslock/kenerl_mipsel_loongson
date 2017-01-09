Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 09 Jan 2017 21:53:57 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:6717 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993866AbdAIUx2PXW8P (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 9 Jan 2017 21:53:28 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E21EEC56EB078;
        Mon,  9 Jan 2017 20:53:17 +0000 (GMT)
Received: from jhogan-linux.le.imgtec.org (192.168.154.110) by
 HHMAIL01.hh.imgtec.org (10.100.10.21) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Mon, 9 Jan 2017 20:53:21 +0000
From:   James Hogan <james.hogan@imgtec.com>
To:     <linux-mips@linux-mips.org>
CC:     James Hogan <james.hogan@imgtec.com>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        =?UTF-8?q?Radim=20Kr=C4=8Dm=C3=A1=C5=99?= <rkrcmar@redhat.com>,
        <kvm@vger.kernel.org>
Subject: [PATCH 1/10] MIPS: Add return errors to protected cache ops
Date:   Mon, 9 Jan 2017 20:51:53 +0000
Message-ID: <0e04ff4dd4267b0d9c08d44a4f535e7223a070ea.1483993967.git-series.james.hogan@imgtec.com>
X-Mailer: git-send-email 2.11.0
MIME-Version: 1.0
In-Reply-To: <cover.4133d2f24fd73c1889a46ea05bb8924867b33747.1483993967.git-series.james.hogan@imgtec.com>
References: <cover.4133d2f24fd73c1889a46ea05bb8924867b33747.1483993967.git-series.james.hogan@imgtec.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [192.168.154.110]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56236
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

The protected cache ops contain no out of line fixup code to return an
error code in the event of a fault, with the cache op being skipped in
that case. For KVM however we'd like to detect this case as page
faulting will be disabled so it could happen during normal operation if
the GVA page tables were flushed, and need to be handled by the caller.

Add the out-of-line fixup code to load the error value -EFAULT into the
return variable, and adapt the protected cache line functions to pass
the error back to the caller.

Signed-off-by: James Hogan <james.hogan@imgtec.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: "Radim Krčmář" <rkrcmar@redhat.com>
Cc: linux-mips@linux-mips.org
Cc: kvm@vger.kernel.org
---
 arch/mips/include/asm/r4kcache.h | 55 +++++++++++++++++++++------------
 1 file changed, 35 insertions(+), 20 deletions(-)

diff --git a/arch/mips/include/asm/r4kcache.h b/arch/mips/include/asm/r4kcache.h
index b42b513007a2..7227c158cbf8 100644
--- a/arch/mips/include/asm/r4kcache.h
+++ b/arch/mips/include/asm/r4kcache.h
@@ -147,49 +147,64 @@ static inline void flush_scache_line(unsigned long addr)
 }
 
 #define protected_cache_op(op,addr)				\
+({								\
+	int __err = 0;						\
 	__asm__ __volatile__(					\
 	"	.set	push			\n"		\
 	"	.set	noreorder		\n"		\
 	"	.set "MIPS_ISA_ARCH_LEVEL"	\n"		\
-	"1:	cache	%0, (%1)		\n"		\
+	"1:	cache	%1, (%2)		\n"		\
 	"2:	.set	pop			\n"		\
+	"	.section .fixup,\"ax\"		\n"		\
+	"3:	li	%0, %3			\n"		\
+	"	j	2b			\n"		\
+	"	.previous			\n"		\
 	"	.section __ex_table,\"a\"	\n"		\
-	"	"STR(PTR)" 1b, 2b		\n"		\
+	"	"STR(PTR)" 1b, 3b		\n"		\
 	"	.previous"					\
-	:							\
-	: "i" (op), "r" (addr))
+	: "+r" (__err)						\
+	: "i" (op), "r" (addr), "i" (-EFAULT));			\
+	__err;							\
+})
+
 
 #define protected_cachee_op(op,addr)				\
+({								\
+	int __err = 0;						\
 	__asm__ __volatile__(					\
 	"	.set	push			\n"		\
 	"	.set	noreorder		\n"		\
 	"	.set	mips0			\n"		\
 	"	.set	eva			\n"		\
-	"1:	cachee	%0, (%1)		\n"		\
+	"1:	cachee	%1, (%2)		\n"		\
 	"2:	.set	pop			\n"		\
+	"	.section .fixup,\"ax\"		\n"		\
+	"3:	li	%0, %3			\n"		\
+	"	j	2b			\n"		\
+	"	.previous			\n"		\
 	"	.section __ex_table,\"a\"	\n"		\
-	"	"STR(PTR)" 1b, 2b		\n"		\
+	"	"STR(PTR)" 1b, 3b		\n"		\
 	"	.previous"					\
-	:							\
-	: "i" (op), "r" (addr))
+	: "+r" (__err)						\
+	: "i" (op), "r" (addr), "i" (-EFAULT));			\
+	__err;							\
+})
 
 /*
  * The next two are for badland addresses like signal trampolines.
  */
-static inline void protected_flush_icache_line(unsigned long addr)
+static inline int protected_flush_icache_line(unsigned long addr)
 {
 	switch (boot_cpu_type()) {
 	case CPU_LOONGSON2:
-		protected_cache_op(Hit_Invalidate_I_Loongson2, addr);
-		break;
+		return protected_cache_op(Hit_Invalidate_I_Loongson2, addr);
 
 	default:
 #ifdef CONFIG_EVA
-		protected_cachee_op(Hit_Invalidate_I, addr);
+		return protected_cachee_op(Hit_Invalidate_I, addr);
 #else
-		protected_cache_op(Hit_Invalidate_I, addr);
+		return protected_cache_op(Hit_Invalidate_I, addr);
 #endif
-		break;
 	}
 }
 
@@ -199,21 +214,21 @@ static inline void protected_flush_icache_line(unsigned long addr)
  * caches.  We're talking about one cacheline unnecessarily getting invalidated
  * here so the penalty isn't overly hard.
  */
-static inline void protected_writeback_dcache_line(unsigned long addr)
+static inline int protected_writeback_dcache_line(unsigned long addr)
 {
 #ifdef CONFIG_EVA
-	protected_cachee_op(Hit_Writeback_Inv_D, addr);
+	return protected_cachee_op(Hit_Writeback_Inv_D, addr);
 #else
-	protected_cache_op(Hit_Writeback_Inv_D, addr);
+	return protected_cache_op(Hit_Writeback_Inv_D, addr);
 #endif
 }
 
-static inline void protected_writeback_scache_line(unsigned long addr)
+static inline int protected_writeback_scache_line(unsigned long addr)
 {
 #ifdef CONFIG_EVA
-	protected_cachee_op(Hit_Writeback_Inv_SD, addr);
+	return protected_cachee_op(Hit_Writeback_Inv_SD, addr);
 #else
-	protected_cache_op(Hit_Writeback_Inv_SD, addr);
+	return protected_cache_op(Hit_Writeback_Inv_SD, addr);
 #endif
 }
 
-- 
git-series 0.8.10
