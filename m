Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2017 17:13:51 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:55974 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993302AbdCXQNmld9WA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2017 17:13:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vLhH+tTt5d0g3g5K6NIF1+bSl0M6+PAcN7VtcL+BWzE=; b=rSnG0xJON8a/6MLJbyGShgKoA
        mZxSlt5M5MCaKkPMbGM/N+6xEp2v4H5a6ZG+vzDMbVgHPJxhyyXKe5hqebsVVJdctR4GlVKVxrzBf
        a5F0I0Jv3EpaiGYdoGVgQ0TXDqSq5lOzrPRHsozyhNvAx6RSuX1gyQR8WIfTVhCrzaC4rb4Xb+ZQz
        8LInhW+lYKMzz2REVXWJlwshxebzOq0uEg7vuGkl0c5LIDmepb2cvU4xesTUCKxGJtMBQfAnwpOj2
        f+LR+8yupX+Xmp77lFEVcf0M+A5JxVS6hQ06NFThJ/ByBrCN2xnEMJSlEv8d2sIphG9eVCGYKsKVR
        zRpv2RBLA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.87 #1 (Red Hat Linux))
        id 1crRqK-0004ux-F4; Fri, 24 Mar 2017 16:13:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: [PATCH v3 2/7] ARM: Implement memset16, memset32 & memset64
Date:   Fri, 24 Mar 2017 09:13:13 -0700
Message-Id: <20170324161318.18718-3-willy@infradead.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170324161318.18718-1-willy@infradead.org>
References: <20170324161318.18718-1-willy@infradead.org>
Return-Path: <willy@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57435
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: willy@infradead.org
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

From: Matthew Wilcox <mawilcox@microsoft.com>

ARM is only 32-bit, so it doesn't really need a memset64, but it was
essentially free to add it to the existing implementation.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
Reviewed-by: Russell King <rmk+kernel@armlinux.org.uk>
---
 arch/arm/include/asm/string.h | 21 +++++++++++++++++++++
 arch/arm/kernel/armksyms.c    |  3 +++
 arch/arm/lib/memset.S         | 44 ++++++++++++++++++++++++++++++++++---------
 3 files changed, 59 insertions(+), 9 deletions(-)

diff --git a/arch/arm/include/asm/string.h b/arch/arm/include/asm/string.h
index cf4f3aad0fc1..bc7a1be7a76a 100644
--- a/arch/arm/include/asm/string.h
+++ b/arch/arm/include/asm/string.h
@@ -24,6 +24,27 @@ extern void * memchr(const void *, int, __kernel_size_t);
 #define __HAVE_ARCH_MEMSET
 extern void * memset(void *, int, __kernel_size_t);
 
+#define __HAVE_ARCH_MEMSET16
+extern void *__memset16(uint16_t *, uint16_t v, __kernel_size_t);
+static inline void *memset16(uint16_t *p, uint16_t v, __kernel_size_t n)
+{
+	return __memset16(p, v, n * 2);
+}
+
+#define __HAVE_ARCH_MEMSET32
+extern void *__memset32(uint32_t *, uint32_t v, __kernel_size_t);
+static inline void *memset32(uint32_t *p, uint32_t v, __kernel_size_t n)
+{
+	return __memset32(p, v, n * 4);
+}
+
+#define __HAVE_ARCH_MEMSET64
+extern void *__memset64(uint64_t *, uint32_t low, __kernel_size_t, uint32_t hi);
+static inline void *memset64(uint64_t *p, uint64_t v, __kernel_size_t n)
+{
+	return __memset64(p, v, n * 8, v >> 32);
+}
+
 extern void __memzero(void *ptr, __kernel_size_t n);
 
 #define memset(p,v,n)							\
diff --git a/arch/arm/kernel/armksyms.c b/arch/arm/kernel/armksyms.c
index 8e8d20cdbce7..633341ed0713 100644
--- a/arch/arm/kernel/armksyms.c
+++ b/arch/arm/kernel/armksyms.c
@@ -87,6 +87,9 @@ EXPORT_SYMBOL(__raw_writesl);
 EXPORT_SYMBOL(strchr);
 EXPORT_SYMBOL(strrchr);
 EXPORT_SYMBOL(memset);
+EXPORT_SYMBOL(__memset16);
+EXPORT_SYMBOL(__memset32);
+EXPORT_SYMBOL(__memset64);
 EXPORT_SYMBOL(memcpy);
 EXPORT_SYMBOL(memmove);
 EXPORT_SYMBOL(memchr);
diff --git a/arch/arm/lib/memset.S b/arch/arm/lib/memset.S
index 3c65e3bd790f..9adc9bdf3ffb 100644
--- a/arch/arm/lib/memset.S
+++ b/arch/arm/lib/memset.S
@@ -21,14 +21,14 @@ ENTRY(memset)
 UNWIND( .fnstart         )
 	ands	r3, r0, #3		@ 1 unaligned?
 	mov	ip, r0			@ preserve r0 as return value
+	orr	r1, r1, r1, lsl #8
 	bne	6f			@ 1
 /*
  * we know that the pointer in ip is aligned to a word boundary.
  */
-1:	orr	r1, r1, r1, lsl #8
-	orr	r1, r1, r1, lsl #16
+1:	orr	r1, r1, r1, lsl #16
 	mov	r3, r1
-	cmp	r2, #16
+7:	cmp	r2, #16
 	blt	4f
 
 #if ! CALGN(1)+0
@@ -41,7 +41,7 @@ UNWIND( .fnend              )
 UNWIND( .fnstart            )
 UNWIND( .save {r8, lr}      )
 	mov	r8, r1
-	mov	lr, r1
+	mov	lr, r3
 
 2:	subs	r2, r2, #64
 	stmgeia	ip!, {r1, r3, r8, lr}	@ 64 bytes at a time.
@@ -73,11 +73,11 @@ UNWIND( .fnend                 )
 UNWIND( .fnstart               )
 UNWIND( .save {r4-r8, lr}      )
 	mov	r4, r1
-	mov	r5, r1
+	mov	r5, r3
 	mov	r6, r1
-	mov	r7, r1
+	mov	r7, r3
 	mov	r8, r1
-	mov	lr, r1
+	mov	lr, r3
 
 	cmp	r2, #96
 	tstgt	ip, #31
@@ -114,12 +114,13 @@ UNWIND( .fnstart            )
 	tst	r2, #4
 	strne	r1, [ip], #4
 /*
- * When we get here, we've got less than 4 bytes to zero.  We
+ * When we get here, we've got less than 4 bytes to set.  We
  * may have an unaligned pointer as well.
  */
 5:	tst	r2, #2
+	movne	r3, r1, lsr #8		@ the top half of a 16-bit pattern
 	strneb	r1, [ip], #1
-	strneb	r1, [ip], #1
+	strneb	r3, [ip], #1
 	tst	r2, #1
 	strneb	r1, [ip], #1
 	ret	lr
@@ -135,3 +136,28 @@ UNWIND( .fnstart            )
 UNWIND( .fnend   )
 ENDPROC(memset)
 ENDPROC(mmioset)
+
+ENTRY(__memset16)
+UNWIND( .fnstart         )
+	tst	r0, #2			@ pointer unaligned?
+	mov	ip, r0			@ preserve r0 as return value
+	beq	1b			@ jump into the middle of memset
+	subs	r2, r2, #2		@ cope with n == 0
+	movge	r3, r1, lsr #8		@ r3 = r1 >> 8
+	strgeb	r1, [ip], #1		@ *ip = r1
+	strgeb	r3, [ip], #1		@ *ip = r3
+	bgt	1b			@ back into memset if n > 0
+	ret	lr			@ otherwise return
+UNWIND( .fnend   )
+ENDPROC(__memset16)
+ENTRY(__memset32)
+UNWIND( .fnstart         )
+	mov	r3, r1			@ copy r1 to r3 and fall into memset64
+UNWIND( .fnend   )
+ENDPROC(__memset32)
+ENTRY(__memset64)
+UNWIND( .fnstart         )
+	mov	ip, r0			@ preserve r0 as return value
+	b	7b			@ jump into the middle of memset
+UNWIND( .fnend   )
+ENDPROC(__memset64)
-- 
2.11.0
