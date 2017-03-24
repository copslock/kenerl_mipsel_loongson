Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2017 17:15:59 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:56161 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992214AbdCXQNlrIegA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2017 17:13:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=5+cOn2Gn8Nibze/5+ECwo8+tt6nu6qJcl04imTfRJuQ=; b=nDdeMUvXEeZp9tMPxLoJsgGGf
        SwKofnogaaUaVp17VpwAKVQvOEB/KD9cgnrgj7Kkm/vdJ9CZta7MujCSv9ZH8z7w+xmimxgIB2rDZ
        3WGElRjYXhQRAuZQdeQhRV+3wVOu6dJDkd8Cs4hX+zfZjcHkpOm2hZvupFltcHCpmSJGLqgyuzbcR
        pD6H7FPjrAFnwie5AlO4+362uUBrsegmKMSJheLxGLzCJFCrd9HPZPkFWy494GvJHcuO1n4keReIE
        bvCLVKVM9taTb81DBPGrsQEQ6EW4f7UMEHi9zHLgXItu5cBRVa8MxjEYzZZSAqopzfQT3GJzHXpvq
        /eRyp6n0Q==;
Received: from willy by bombadil.infradead.org with local (Exim 4.87 #1 (Red Hat Linux))
        id 1crRqK-0004v5-IK; Fri, 24 Mar 2017 16:13:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: [PATCH v3 4/7] alpha: Add support for memset16
Date:   Fri, 24 Mar 2017 09:13:15 -0700
Message-Id: <20170324161318.18718-5-willy@infradead.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170324161318.18718-1-willy@infradead.org>
References: <20170324161318.18718-1-willy@infradead.org>
Return-Path: <willy@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57440
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

Alpha already had an optimised memset-16-bit-quantity assembler routine
called memsetw().  It has a slightly different calling convention
from memset16() in that it takes a byte count, not a count of words.
That's the same convention used by ARM's __memset16(), so rename Alpha's
routine to match and add a memset16() wrapper around it.  Then convert
Alpha's scr_memsetw() to call memset16() instead of memsetw().

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 arch/alpha/include/asm/string.h | 15 ++++++++-------
 arch/alpha/include/asm/vga.h    |  2 +-
 arch/alpha/lib/memset.S         | 10 +++++-----
 3 files changed, 14 insertions(+), 13 deletions(-)

diff --git a/arch/alpha/include/asm/string.h b/arch/alpha/include/asm/string.h
index c2911f591704..74c0a693b76b 100644
--- a/arch/alpha/include/asm/string.h
+++ b/arch/alpha/include/asm/string.h
@@ -65,13 +65,14 @@ extern void * memchr(const void *, int, size_t);
    aligned values.  The DEST and COUNT parameters must be even for 
    correct operation.  */
 
-#define __HAVE_ARCH_MEMSETW
-extern void * __memsetw(void *dest, unsigned short, size_t count);
-
-#define memsetw(s, c, n)						 \
-(__builtin_constant_p(c)						 \
- ? __constant_c_memset((s),0x0001000100010001UL*(unsigned short)(c),(n)) \
- : __memsetw((s),(c),(n)))
+#define __HAVE_ARCH_MEMSET16
+extern void * __memset16(void *dest, unsigned short, size_t count);
+static inline void *memset16(uint16_t *p, uint16_t v, size_t n)
+{
+	if (__builtin_constant_p(v))
+		return __constant_c_memset(p, 0x0001000100010001UL * v, n * 2)
+	return __memset16(p, v, n * 2);
+}
 
 #endif /* __KERNEL__ */
 
diff --git a/arch/alpha/include/asm/vga.h b/arch/alpha/include/asm/vga.h
index c00106bac521..3c1c2b6128e7 100644
--- a/arch/alpha/include/asm/vga.h
+++ b/arch/alpha/include/asm/vga.h
@@ -34,7 +34,7 @@ static inline void scr_memsetw(u16 *s, u16 c, unsigned int count)
 	if (__is_ioaddr(s))
 		memsetw_io((u16 __iomem *) s, c, count);
 	else
-		memsetw(s, c, count);
+		memset16(s, c, count / 2);
 }
 
 /* Do not trust that the usage will be correct; analyze the arguments.  */
diff --git a/arch/alpha/lib/memset.S b/arch/alpha/lib/memset.S
index 89a26f5e89de..f824969e9e77 100644
--- a/arch/alpha/lib/memset.S
+++ b/arch/alpha/lib/memset.S
@@ -20,7 +20,7 @@
 	.globl memset
 	.globl __memset
 	.globl ___memset
-	.globl __memsetw
+	.globl __memset16
 	.globl __constant_c_memset
 
 	.ent ___memset
@@ -110,8 +110,8 @@ EXPORT_SYMBOL(___memset)
 EXPORT_SYMBOL(__constant_c_memset)
 
 	.align 5
-	.ent __memsetw
-__memsetw:
+	.ent __memset16
+__memset16:
 	.prologue 0
 
 	inswl $17,0,$1		/* E0 */
@@ -123,8 +123,8 @@ __memsetw:
 	or $1,$4,$17		/* E0 */
 	br __constant_c_memset	/* .. E1 */
 
-	.end __memsetw
-EXPORT_SYMBOL(__memsetw)
+	.end __memset16
+EXPORT_SYMBOL(__memset16)
 
 memset = ___memset
 __memset = ___memset
-- 
2.11.0
