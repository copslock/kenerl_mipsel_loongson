Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 24 Mar 2017 17:15:09 +0100 (CET)
Received: from bombadil.infradead.org ([65.50.211.133]:36851 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992213AbdCXQNlo24PA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 24 Mar 2017 17:13:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=1vk9dMeoOsoMI1QJG6IZ6+5jzXQAd/2iUTjP2u+2A9k=; b=J1akfdeO+bto+NIZJM4PrY4nv
        /VmMURUmgKwF674mm0gKXzVJmB6StxKuvLHpDpzuqwrjvQeIA9HisyEIms9RPX59tCSdRy/vkMVKu
        pvkSKOlcXqqiQIi95FEZ69EU99qs31nRDpQBn3MF/U6c8KFiR/4lNtdEW4ODKByy/2ua/4bZjmVbH
        hEHlc5Wzti2OdTtVDbcPo8JHfk9x32WMTvBYdZ6tZMgUw9rI1ert+BLiBp3ZCFwYPPlZA6NEvFdO9
        sWwgq5dqnLxGCvnQ3B3vJN0id6R40EEwpEcKmqI4NmW5oubw8pWbMfZWwAVYHclMmV/MexKtt+45o
        IJdGFa27g==;
Received: from willy by bombadil.infradead.org with local (Exim 4.87 #1 (Red Hat Linux))
        id 1crRqK-0004v1-Gj; Fri, 24 Mar 2017 16:13:36 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     linux-fbdev@vger.kernel.org, linux-arch@vger.kernel.org,
        linux-alpha@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        x86@kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, sparclinux@vger.kernel.org,
        Minchan Kim <minchan@kernel.org>,
        Matthew Wilcox <mawilcox@microsoft.com>
Subject: [PATCH v3 3/7] x86: Implement memset16, memset32 & memset64
Date:   Fri, 24 Mar 2017 09:13:14 -0700
Message-Id: <20170324161318.18718-4-willy@infradead.org>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20170324161318.18718-1-willy@infradead.org>
References: <20170324161318.18718-1-willy@infradead.org>
Return-Path: <willy@infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57438
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

These are single instructions on x86.  There's no 64-bit instruction
for x86-32, but we don't yet have any user for memset64() on 32-bit
architectures, so don't bother to implement it.

Signed-off-by: Matthew Wilcox <mawilcox@microsoft.com>
---
 arch/x86/include/asm/string_32.h | 24 ++++++++++++++++++++++++
 arch/x86/include/asm/string_64.h | 36 ++++++++++++++++++++++++++++++++++++
 2 files changed, 60 insertions(+)

diff --git a/arch/x86/include/asm/string_32.h b/arch/x86/include/asm/string_32.h
index 3d3e8353ee5c..84da91fe13ac 100644
--- a/arch/x86/include/asm/string_32.h
+++ b/arch/x86/include/asm/string_32.h
@@ -331,6 +331,30 @@ void *__constant_c_and_count_memset(void *s, unsigned long pattern,
 	 : __memset((s), (c), (count)))
 #endif
 
+#define __HAVE_ARCH_MEMSET16
+static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
+{
+	int d0, d1;
+	asm volatile("rep\n\t"
+		     "stosw"
+		     : "=&c" (d0), "=&D" (d1)
+		     : "a" (v), "1" (s), "0" (n)
+		     : "memory");
+	return s;
+}
+
+#define __HAVE_ARCH_MEMSET_32
+static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
+{
+	int d0, d1;
+	asm volatile("rep\n\t"
+		     "stosl"
+		     : "=&c" (d0), "=&D" (d1)
+		     : "a" (v), "1" (s), "0" (n)
+		     : "memory");
+	return s;
+}
+
 /*
  * find the first occurrence of byte 'c', or 1 past the area if none
  */
diff --git a/arch/x86/include/asm/string_64.h b/arch/x86/include/asm/string_64.h
index a164862d77e3..71c5e860c7da 100644
--- a/arch/x86/include/asm/string_64.h
+++ b/arch/x86/include/asm/string_64.h
@@ -56,6 +56,42 @@ extern void *__memcpy(void *to, const void *from, size_t len);
 void *memset(void *s, int c, size_t n);
 void *__memset(void *s, int c, size_t n);
 
+#define __HAVE_ARCH_MEMSET16
+static inline void *memset16(uint16_t *s, uint16_t v, size_t n)
+{
+	long d0, d1;
+	asm volatile("rep\n\t"
+		     "stosw"
+		     : "=&c" (d0), "=&D" (d1)
+		     : "a" (v), "1" (s), "0" (n)
+		     : "memory");
+	return s;
+}
+
+#define __HAVE_ARCH_MEMSET32
+static inline void *memset32(uint32_t *s, uint32_t v, size_t n)
+{
+	long d0, d1;
+	asm volatile("rep\n\t"
+		     "stosl"
+		     : "=&c" (d0), "=&D" (d1)
+		     : "a" (v), "1" (s), "0" (n)
+		     : "memory");
+	return s;
+}
+
+#define __HAVE_ARCH_MEMSET64
+static inline void *memset64(uint64_t *s, uint64_t v, size_t n)
+{
+	long d0, d1;
+	asm volatile("rep\n\t"
+		     "stosq"
+		     : "=&c" (d0), "=&D" (d1)
+		     : "a" (v), "1" (s), "0" (n)
+		     : "memory");
+	return s;
+}
+
 #define __HAVE_ARCH_MEMMOVE
 void *memmove(void *dest, const void *src, size_t count);
 void *__memmove(void *dest, const void *src, size_t count);
-- 
2.11.0
