Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Jan 2008 16:10:05 +0000 (GMT)
Received: from mail.windriver.com ([147.11.1.11]:17847 "EHLO mail.wrs.com")
	by ftp.linux-mips.org with ESMTP id S28579714AbYAKQJ5 (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 11 Jan 2008 16:09:57 +0000
Received: from localhost.localdomain (yow-pgortmak-d1.ottawa.windriver.com [128.224.146.65])
	by mail.wrs.com (8.13.6/8.13.6) with ESMTP id m0BG9ZjC011536;
	Fri, 11 Jan 2008 08:09:36 -0800 (PST)
From:	Paul Gortmaker <paul.gortmaker@windriver.com>
To:	linux-mips@linux-mips.org
Cc:	Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: [PATCH] mips: fail if DMA coherency is unspecified
Date:	Fri, 11 Jan 2008 11:09:35 -0500
Message-Id: <12000677752237-git-send-email-paul.gortmaker@windriver.com>
X-Mailer: git-send-email 1.5.0.rc1.gf4b6c
Return-Path: <paul.gortmaker@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 17990
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.gortmaker@windriver.com
Precedence: bulk
X-list: linux-mips

Currently, if the DMA coherency is unspecified, you simply get a
warning about no return in a function returning int, which can be
easily overlooked.  This makes sure that if the platform hasn't
specified it, that it will get the required visibility.

Signed-off-by: Paul Gortmaker <paul.gortmaker@windriver.com>
---
 include/asm-mips/mach-generic/dma-coherence.h |    8 +++++---
 1 files changed, 5 insertions(+), 3 deletions(-)

diff --git a/include/asm-mips/mach-generic/dma-coherence.h b/include/asm-mips/mach-generic/dma-coherence.h
index 76e04e7..02492a6 100644
--- a/include/asm-mips/mach-generic/dma-coherence.h
+++ b/include/asm-mips/mach-generic/dma-coherence.h
@@ -34,11 +34,13 @@ static inline void plat_unmap_dma_mem(dma_addr_t dma_addr)
 
 static inline int plat_device_is_coherent(struct device *dev)
 {
-#ifdef CONFIG_DMA_COHERENT
+#if defined(CONFIG_DMA_COHERENT)
 	return 1;
-#endif
-#ifdef CONFIG_DMA_NONCOHERENT
+#elif defined(CONFIG_DMA_NONCOHERENT)
 	return 0;
+#else
+#error DMA coherency of platform is not defined.
+	return 0xbad;
 #endif
 }
 
-- 
1.5.0.rc1.gf4b6c
