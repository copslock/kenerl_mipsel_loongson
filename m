Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2017 17:15:32 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:59146 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993907AbdCXQNnbGYrA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2017 17:13:43 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=TAZGnAuRaKMrcqlbVbH3R+/FXmf1EYPr4C/foevCU6I=; b=M/wCAAXA60dFoqDFXZo0xS2m6
        MiDs1kui9uC25WJa1n3EcuI+rvG3bKgwHaT682lEaBbwO31LXw88HiGVxliUvPPCxnnMNTnTmpMbm
        LFNorfravDcW6IRcWUREBxJBVduEzeEbTGWZ0k4a/SBRir7IVruwA51LNVHFxR2QHdkvBPdAWy7zP
        JalaaenzTjCSaDNOeUm6h0Inhi3NEmIzG/LoTdnkt8YRiy6jW9z+D7bDKe8yTtvORVUx4XrTTZFIz
        +ElfUqnxGLG4i/GJlzSdEHmeGiA2JbdtVJSyiXpMsLRcvo7BWAjN4fLMwsy1eeQFe3C6gpR2sRHAJ
        MBhgDT1pg==;
Received: from willy by bombadil.infradead.org with local (Exim 4.87 #1 (Red Hat Linux))
        id 1crRqK-0004ut-DM; Fri, 24 Mar 2017 16:13:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: [PATCH v3 1/7] Add multibyte memset functions
Date:   Fri, 24 Mar 2017 09:13:12 -0700
Message-Id: <20170324161318.18718-2-willy@infradead.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170324161318.18718-1-willy@infradead.org>
References: <20170324161318.18718-1-willy@infradead.org>
Return-Path: <willy@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57439
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

memset16(), memset32() and memset64() are like memset(), but allow the
caller to fill the destination with a multibyte pattern.  memset_l()
and memset_p() allow the caller to use unsigned long and pointer
values respectively.  memset64() is currently only available on 64-bit
architectures.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 include/linux/string.h | 30 ++++++++++++++++++++++
 lib/string.c           | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 98 insertions(+)

diff --git a/include/linux/string.h b/include/linux/string.h
index 26b6f6a66f83..b376875b650c 100644
--- a/include/linux/string.h
+++ b/include/linux/string.h
@@ -99,6 +99,36 @@ extern __kernel_size_t strcspn(const char *,const char *);
 #ifndef __HAVE_ARCH_MEMSET
 extern void * memset(void *,int,__kernel_size_t);
 #endif
+
+#ifndef __HAVE_ARCH_MEMSET16
+extern void *memset16(uint16_t *, uint16_t, __kernel_size_t);
+#endif
+
+#ifndef __HAVE_ARCH_MEMSET32
+extern void *memset32(uint32_t *, uint32_t, __kernel_size_t);
+#endif
+
+#ifndef __HAVE_ARCH_MEMSET64
+extern void *memset64(uint64_t *, uint64_t, __kernel_size_t);
+#endif
+
+static inline void *memset_l(unsigned long *p, unsigned long v,
+		__kernel_size_t n)
+{
+	if (BITS_PER_LONG == 32)
+		return memset32((uint32_t *)p, v, n);
+	else
+		return memset64((uint64_t *)p, v, n);
+}
+
+static inline void *memset_p(void **p, void *v, __kernel_size_t n)
+{
+	if (BITS_PER_LONG == 32)
+		return memset32((uint32_t *)p, (uintptr_t)v, n);
+	else
+		return memset64((uint64_t *)p, (uintptr_t)v, n);
+}
+
 #ifndef __HAVE_ARCH_MEMCPY
 extern void * memcpy(void *,const void *,__kernel_size_t);
 #endif
diff --git a/lib/string.c b/lib/string.c
index ed83562a53ae..f18ba402e503 100644
--- a/lib/string.c
+++ b/lib/string.c
@@ -697,6 +697,74 @@ void memzero_explicit(void *s, size_t count)
 }
 EXPORT_SYMBOL(memzero_explicit);
 
+#ifndef __HAVE_ARCH_MEMSET16
+/**
+ * memset16() - Fill a memory area with a uint16_t
+ * @s: Pointer to the start of the area.
+ * @v: The value to fill the area with
+ * @count: The number of values to store
+ *
+ * Differs from memset() in that it fills with a uint16_t instead
+ * of a byte.  Remember that @count is the number of uint16_ts to
+ * store, not the number of bytes.
+ */
+void *memset16(uint16_t *s, uint16_t v, size_t count)
+{
+	uint16_t *xs = s;
+
+	while (count--)
+		*xs++ = v;
+	return s;
+}
+EXPORT_SYMBOL(memset16);
+#endif
+
+#ifndef __HAVE_ARCH_MEMSET32
+/**
+ * memset32() - Fill a memory area with a uint32_t
+ * @s: Pointer to the start of the area.
+ * @v: The value to fill the area with
+ * @count: The number of values to store
+ *
+ * Differs from memset() in that it fills with a uint32_t instead
+ * of a byte.  Remember that @count is the number of uint32_ts to
+ * store, not the number of bytes.
+ */
+void *memset32(uint32_t *s, uint32_t v, size_t count)
+{
+	uint32_t *xs = s;
+
+	while (count--)
+		*xs++ = v;
+	return s;
+}
+EXPORT_SYMBOL(memset32);
+#endif
+
+#ifndef __HAVE_ARCH_MEMSET64
+#if BITS_PER_LONG > 32
+/**
+ * memset64() - Fill a memory area with a uint64_t
+ * @s: Pointer to the start of the area.
+ * @v: The value to fill the area with
+ * @count: The number of values to store
+ *
+ * Differs from memset() in that it fills with a uint64_t instead
+ * of a byte.  Remember that @count is the number of uint64_ts to
+ * store, not the number of bytes.
+ */
+void *memset64(uint64_t *s, uint64_t v, size_t count)
+{
+	uint64_t *xs = s;
+
+	while (count--)
+		*xs++ = v;
+	return s;
+}
+EXPORT_SYMBOL(memset64);
+#endif
+#endif
+
 #ifndef __HAVE_ARCH_MEMCPY
 /**
  * memcpy - Copy one area of memory to another
-- 
2.11.0
