Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Feb 2014 15:00:00 +0100 (CET)
Received: from mail-ee0-f41.google.com ([74.125.83.41]:34566 "EHLO
        mail-ee0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6871404AbaBTN7jgLyen (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Feb 2014 14:59:39 +0100
Received: by mail-ee0-f41.google.com with SMTP id e49so995894eek.28
        for <linux-mips@linux-mips.org>; Thu, 20 Feb 2014 05:59:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eUlih2uc5d30934+ee8d5aFz6ZRDM6DtyLaXB3UKvq4=;
        b=vYz7/HM71uz1Bz29PKwLIqR9ThiRSzvI6BN3R1qmVd89knUnbo/aFnNjvQVQS1ijnS
         nTn9JlNeqlBbNaIHXfXvaCpmY0zz8ZCoBgzwvJaVZM8bfRfA/9f8hMIZg3Lp0K7NlQiX
         T6zxYw7Kdl4t4KGPTpoQ410soUmhXlcOkY1bxzMTke5B6eWTLo8DVUlv04TqGoB4gXF1
         GOfvlKgV/BB/0T11i8hX1dAC8P5YFkDhfzRKy3hMdKuyNZJ70IkBhhR4T26615/E3ymV
         9D3AwQDVvqMzDaBiT+Vn6t90pj9/0h6BBE95SG2VTdBom66brYUhAGmGwefE6ntQZVkT
         qAzQ==
X-Received: by 10.14.214.3 with SMTP id b3mr2112755eep.88.1392904774186;
        Thu, 20 Feb 2014 05:59:34 -0800 (PST)
Received: from localhost.localdomain (p54B231AB.dip0.t-ipconnect.de. [84.178.49.171])
        by mx.google.com with ESMTPSA id n41sm14102379eeg.16.2014.02.20.05.59.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 20 Feb 2014 05:59:33 -0800 (PST)
From:   Manuel Lauss <manuel.lauss@gmail.com>
To:     Linux-MIPS <linux-mips@linux-mips.org>
Cc:     Manuel Lauss <manuel.lauss@gmail.com>
Subject: [PATCH v2 1/3] MIPS: extend DMA_MAYBE_COHERENT logic to DMA_NONCOHERENT use
Date:   Thu, 20 Feb 2014 14:59:22 +0100
Message-Id: <1392904764-5432-2-git-send-email-manuel.lauss@gmail.com>
X-Mailer: git-send-email 1.8.5.5
In-Reply-To: <1392904764-5432-1-git-send-email-manuel.lauss@gmail.com>
References: <1392904764-5432-1-git-send-email-manuel.lauss@gmail.com>
Return-Path: <manuel.lauss@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39356
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
v2: no changes

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
