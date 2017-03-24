Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2017 17:14:18 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:47304 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993457AbdCXQNmzxbGA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2017 17:13:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=4PABV1MqcSsOm2Nv3z32v5KKzexZdPkcccPIjbAFZzQ=; b=eXEPm9CueKvrnH+4AyRhKDQVs
        0QbTu6ZIyT0CJ7W4c2/S/RkOakQq8d2qYKce3tlqf+cV2wZJWvkN8JMwKLLSOwSbTZ5DQsZ4Wad+C
        7VApnlC35+f2uBQH1RP4mOqCjMlq+MytlfRZ0Rgw8OFmSlKCbwuK1f9a+UyBRPdwzMhmmInAIL/NQ
        fp06tHYjIojEsD2MatRYBVLm7+lWZksXDoD/f4YLgsOjjZyRUPeiLGLy2XjyX+DtnAwh9Mg3fDq7l
        aNsTV7r4SZZmvpalF2ZfLPR/K4bQhg6Vqa8Uhomlkvt3+DU/gKOb7vhXIZJHragUl98q66bAoipIf
        tVm1kSfKA==;
Received: from willy by bombadil.infradead.org with local (Exim 4.87 #1 (Red Hat Linux))
        id 1crRqK-0004vZ-Qg; Fri, 24 Mar 2017 16:13:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: [PATCH v3 7/7] vga: Optimise console scrolling
Date:   Fri, 24 Mar 2017 09:13:18 -0700
Message-Id: <20170324161318.18718-8-willy@infradead.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170324161318.18718-1-willy@infradead.org>
References: <20170324161318.18718-1-willy@infradead.org>
Return-Path: <willy@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57436
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

Where possible, call memset16(), memmove() or memcpy() instead of using
open-coded loops.  If an architecture doesn't define VT_BUF_HAVE_RW,
we can do that from the generic code.  For the architectures which do
have special RW routines, usually we can do the special thing (pointer
test or byteswap) once (and then use a mem* call) instead of each time
around a loop.  Alpha is the only architecture missing a scr_memmovew()
definition (because it's non-trivial to write).

I don't like the calling convention that uses a byte count instead of
a count of u16s, but it's a little late to change that.  Reduces code
size of fbcon.o by almost 400 bytes on my laptop build.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 arch/mips/include/asm/vga.h    |  6 ++++++
 arch/powerpc/include/asm/vga.h |  8 ++++++++
 arch/sparc/include/asm/vga.h   | 24 ++++++++++++++++++++++++
 include/linux/vt_buffer.h      | 12 ++++++++++++
 4 files changed, 50 insertions(+)

diff --git a/arch/mips/include/asm/vga.h b/arch/mips/include/asm/vga.h
index f82c83749a08..7510f406e1e1 100644
--- a/arch/mips/include/asm/vga.h
+++ b/arch/mips/include/asm/vga.h
@@ -40,9 +40,15 @@ static inline u16 scr_readw(volatile const u16 *addr)
 	return le16_to_cpu(*addr);
 }
 
+static inline void scr_memsetw(u16 *s, u16 v, unsigned int count)
+{
+	memset16(s, cpu_to_le16(v), count / 2);
+}
+
 #define scr_memcpyw(d, s, c) memcpy(d, s, c)
 #define scr_memmovew(d, s, c) memmove(d, s, c)
 #define VT_BUF_HAVE_MEMCPYW
 #define VT_BUF_HAVE_MEMMOVEW
+#define VT_BUF_HAVE_MEMSETW
 
 #endif /* _ASM_VGA_H */
diff --git a/arch/powerpc/include/asm/vga.h b/arch/powerpc/include/asm/vga.h
index ab3acd2f2786..7a7b541b7493 100644
--- a/arch/powerpc/include/asm/vga.h
+++ b/arch/powerpc/include/asm/vga.h
@@ -33,8 +33,16 @@ static inline u16 scr_readw(volatile const u16 *addr)
 	return le16_to_cpu(*addr);
 }
 
+#define VT_BUF_HAVE_MEMSETW
+static inline void scr_memsetw(u16 *s, u16 v, unsigned int n)
+{
+	memset16(s, cpu_to_le16(v), n / 2);
+}
+
 #define VT_BUF_HAVE_MEMCPYW
+#define VT_BUF_HAVE_MEMMOVEW
 #define scr_memcpyw	memcpy
+#define scr_memmovew	memmove
 
 #endif /* !CONFIG_VGA_CONSOLE && !CONFIG_MDA_CONSOLE */
 
diff --git a/arch/sparc/include/asm/vga.h b/arch/sparc/include/asm/vga.h
index ec0e9967d93d..1fab92b110d9 100644
--- a/arch/sparc/include/asm/vga.h
+++ b/arch/sparc/include/asm/vga.h
@@ -11,6 +11,9 @@
 #include <asm/types.h>
 
 #define VT_BUF_HAVE_RW
+#define VT_BUF_HAVE_MEMSETW
+#define VT_BUF_HAVE_MEMCPYW
+#define VT_BUF_HAVE_MEMMOVEW
 
 #undef scr_writew
 #undef scr_readw
@@ -29,6 +32,27 @@ static inline u16 scr_readw(const u16 *addr)
 	return *addr;
 }
 
+static inline void scr_memsetw(u16 *p, u16 v, unsigned int n)
+{
+	BUG_ON((long) p >= 0);
+
+	memset16(s, cpu_to_le16(v), n / 2);
+}
+
+static inline void scr_memcpyw(u16 *d, u16 *s, unsigned int n)
+{
+	BUG_ON((long) d >= 0);
+
+	memcpy(d, s, n);
+}
+
+static inline void scr_memmovew(u16 *d, u16 *s, unsigned int n)
+{
+	BUG_ON((long) d >= 0);
+
+	memmove(d, s, n);
+}
+
 #define VGA_MAP_MEM(x,s) (x)
 
 #endif
diff --git a/include/linux/vt_buffer.h b/include/linux/vt_buffer.h
index f38c10ba3ff5..31b92fcd8f03 100644
--- a/include/linux/vt_buffer.h
+++ b/include/linux/vt_buffer.h
@@ -26,24 +26,33 @@
 #ifndef VT_BUF_HAVE_MEMSETW
 static inline void scr_memsetw(u16 *s, u16 c, unsigned int count)
 {
+#ifdef VT_BUF_HAVE_RW
 	count /= 2;
 	while (count--)
 		scr_writew(c, s++);
+#else
+	memset16(s, c, count / 2);
+#endif
 }
 #endif
 
 #ifndef VT_BUF_HAVE_MEMCPYW
 static inline void scr_memcpyw(u16 *d, const u16 *s, unsigned int count)
 {
+#ifdef VT_BUF_HAVE_RW
 	count /= 2;
 	while (count--)
 		scr_writew(scr_readw(s++), d++);
+#else
+	memcpy(d, s, count);
+#endif
 }
 #endif
 
 #ifndef VT_BUF_HAVE_MEMMOVEW
 static inline void scr_memmovew(u16 *d, const u16 *s, unsigned int count)
 {
+#ifdef VT_BUF_HAVE_RW
 	if (d < s)
 		scr_memcpyw(d, s, count);
 	else {
@@ -53,6 +62,9 @@ static inline void scr_memmovew(u16 *d, const u16 *s, unsigned int count)
 		while (count--)
 			scr_writew(scr_readw(--s), --d);
 	}
+#else
+	memmove(d, s, count);
+#endif
 }
 #endif
 
-- 
2.11.0
