Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Feb 2014 19:39:32 +0100 (CET)
Received: from mail-ee0-f47.google.com ([74.125.83.47]:48201 "EHLO
        mail-ee0-f47.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824766AbaBRSjIXflpE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Feb 2014 19:39:08 +0100
Received: by mail-ee0-f47.google.com with SMTP id d49so7868897eek.6
        for <linux-mips@linux-mips.org>; Tue, 18 Feb 2014 10:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=B/UvgUc+FaRRufn/Qf+t/04fRkXFUL1Rt8tQSnFo0h4=;
        b=qHy/xbfCF0aUksJ3NYIiPtw2vYRAA4jc6wW7/LJBWKRjmiLULttusG6AcDsHqxFi6S
         bHBcHg7XrjOo6T49Qv8BydEVxbbfag+kurX7NQ8L11zDsCujCT5x4QBwVOJ3J2cxiS2c
         o5V6J6qjyLPSj2F4AHUbgv+6dTdnKL+1m43SvLECqV3spERD6GMVvPibf0fKJbQRn5+V
         41+Qx+lCF89rsN6Jwt/8QIui5b9HCt0/66nCrbOLPfFdkWqTCLb86UeY+ip+14U+zYDN
         H45fbi3A5ZENw8ExnnK3AEVsGLzr1DkxNorNywmHvJwxFgeUeRYtZoxfyWH7KV+309E9
         zxsw==
X-Received: by 10.14.204.9 with SMTP id g9mr5647581eeo.82.1392748743117;
        Tue, 18 Feb 2014 10:39:03 -0800 (PST)
Received: from localhost.localdomain (p54B21680.dip0.t-ipconnect.de. [84.178.22.128])
        by mx.google.com with ESMTPSA id j42sm73785779eep.21.2014.02.18.10.39.02
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 18 Feb 2014 10:39:02 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [RFC PATCH 1/3] MIPS: extend DMA_MAYBE_COHERENT logic to DMA_NONCOHERENT use
Date:   Tue, 18 Feb 2014 19:38:53 +0100
Message-Id: <1392748735-16745-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.8.5.5
In-Reply-To: <1392748735-16745-1-git-send-email-manuel.lauss@gmail.com>
References: <1392748735-16745-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39336
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: manuel.lauss@gmail.com
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

setting DMA_MAYBE_COHERENT gives a platform the opportunity to select
use of cache ops at boot.

Signed-off-by: Manuel Lauss <manuel.lauss@gmail.com>
---
 arch/mips/include/asm/io.h | 4 ++--
 arch/mips/mm/c-r4k.c       | 6 +++---
 arch/mips/mm/cache.c       | 4 ++--
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/arch/mips/include/asm/io.h b/arch/mips/include/asm/io.h
index 3321dd5..e221d1d 100644
--- a/arch/mips/include/asm/io.h
+++ b/arch/mips/include/asm/io.h
@@ -584,7 +584,7 @@ static inline void memcpy_toio(volatile void __iomem *dst, const void *src, int
  *
  * This API used to be exported; it now is for arch code internal use only.
  */
-#ifdef CONFIG_DMA_NONCOHERENT
+#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
 
 extern void (*_dma_cache_wback_inv)(unsigned long start, unsigned long size);
 extern void (*_dma_cache_wback)(unsigned long start, unsigned long size);
@@ -603,7 +603,7 @@ extern void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 #define dma_cache_inv(start,size)	\
 	do { (void) (start); (void) (size); } while (0)
 
-#endif /* CONFIG_DMA_NONCOHERENT */
+#endif /* CONFIG_DMA_NONCOHERENT || CONFIG_DMA_MAYBE_COHERENT */
 
 /*
  * Read a 32-bit register that requires a 64-bit read cycle on the bus.
diff --git a/arch/mips/mm/c-r4k.c b/arch/mips/mm/c-r4k.c
index c14259e..a3d97e1 100644
--- a/arch/mips/mm/c-r4k.c
+++ b/arch/mips/mm/c-r4k.c
@@ -617,7 +617,7 @@ static void r4k_flush_icache_range(unsigned long start, unsigned long end)
 	instruction_hazard();
 }
 
-#ifdef CONFIG_DMA_NONCOHERENT
+#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
 
 static void r4k_dma_cache_wback_inv(unsigned long addr, unsigned long size)
 {
@@ -688,7 +688,7 @@ static void r4k_dma_cache_inv(unsigned long addr, unsigned long size)
 	bc_inv(addr, size);
 	__sync();
 }
-#endif /* CONFIG_DMA_NONCOHERENT */
+#endif /* CONFIG_DMA_NONCOHERENT || CONFIG_DMA_MAYBE_COHERENT */
 
 /*
  * While we're protected against bad userland addresses we don't care
@@ -1492,7 +1492,7 @@ void r4k_cache_init(void)
 	flush_icache_range	= r4k_flush_icache_range;
 	local_flush_icache_range	= local_r4k_flush_icache_range;
 
-#if defined(CONFIG_DMA_NONCOHERENT)
+#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
 	if (coherentio) {
 		_dma_cache_wback_inv	= (void *)cache_noop;
 		_dma_cache_wback	= (void *)cache_noop;
diff --git a/arch/mips/mm/cache.c b/arch/mips/mm/cache.c
index fde7e56..e422b38 100644
--- a/arch/mips/mm/cache.c
+++ b/arch/mips/mm/cache.c
@@ -49,7 +49,7 @@ EXPORT_SYMBOL_GPL(local_flush_data_cache_page);
 EXPORT_SYMBOL(flush_data_cache_page);
 EXPORT_SYMBOL(flush_icache_all);
 
-#ifdef CONFIG_DMA_NONCOHERENT
+#if defined(CONFIG_DMA_NONCOHERENT) || defined(CONFIG_DMA_MAYBE_COHERENT)
 
 /* DMA cache operations. */
 void (*_dma_cache_wback_inv)(unsigned long start, unsigned long size);
@@ -58,7 +58,7 @@ void (*_dma_cache_inv)(unsigned long start, unsigned long size);
 
 EXPORT_SYMBOL(_dma_cache_wback_inv);
 
-#endif /* CONFIG_DMA_NONCOHERENT */
+#endif /* CONFIG_DMA_NONCOHERENT || CONFIG_DMA_MAYBE_COHERENT */
 
 /*
  * We could optimize the case where the cache argument is not BCACHE but
-- 
1.8.5.5
