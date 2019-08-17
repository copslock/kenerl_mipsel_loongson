Return-Path: <SRS0=63qb=WN=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25A90C3A59B
	for <linux-mips@archiver.kernel.org>; Sat, 17 Aug 2019 07:50:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EE49221744
	for <linux-mips@archiver.kernel.org>; Sat, 17 Aug 2019 07:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="FqajDALy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfHQHsq (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sat, 17 Aug 2019 03:48:46 -0400
Received: from bombadil.infradead.org ([198.137.202.133]:35708 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbfHQHsq (ORCPT
        <rfc822;linux-mips@vger.kernel.org>); Sat, 17 Aug 2019 03:48:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From
        :Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=FX04uJGNdq/Yp5y2MJBzjZbPxUQfO+iCaj0twVF6zA4=; b=FqajDALycfb3RLQsUvPVbgMPZz
        dOpsoNefkCkTkLOaUQRGC8tl371AnmtMs6thFxyNwkW1yB+7T0jMHPB65jBRdYz/I80D14AQ6ZpBw
        BDYJQsjgjLlR04v31PZV0oT60nsijEpUHC1RRG+jxHwJlhBqHgVEGMZMTWIYDiOqybAapjylrP6Pq
        /qPcKzZV3rHqe7SwrY7J778iGraDjHz/Z+sErABUK//lsbWGR8mA4dxVHMpkCfqNTFN8YM0E3k+zr
        6pQnG2H5clsP0FQfNouxdRC54eU8Y7E2BTkOKJH/Oagbm2XrsbWa+ET09Ko1zazTtcz1PQzUXJ5qL
        cYcHBYyw==;
Received: from [2001:4bb8:18c:28b5:44f9:d544:957f:32cb] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.92 #3 (Red Hat Linux))
        id 1hytS3-0004wM-1D; Sat, 17 Aug 2019 07:48:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Arnd Bergmann <arnd@arndb.de>, Guo Ren <guoren@kernel.org>,
        Michal Simek <monstr@monstr.eu>,
        Greentime Hu <green.hu@gmail.com>,
        Vincent Chen <deanbo422@gmail.com>,
        Guan Xuetao <gxt@pku.edu.cn>, x86@kernel.org
Cc:     linux-alpha@vger.kernel.org, linux-snps-arc@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-m68k@lists.linux-m68k.org, linux-mips@vger.kernel.org,
        nios2-dev@lists.rocketboards.org, openrisc@lists.librecores.org,
        linux-parisc@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-xtensa@linux-xtensa.org,
        linux-mtd@lists.infradead.org, linux-arch@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/26] nios2: remove __ioremap
Date:   Sat, 17 Aug 2019 09:32:37 +0200
Message-Id: <20190817073253.27819-11-hch@lst.de>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190817073253.27819-1-hch@lst.de>
References: <20190817073253.27819-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

The cacheflag argument to __ioremap is always 0, so just implement
ioremap directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/nios2/include/asm/io.h | 20 ++++----------------
 arch/nios2/mm/ioremap.c     | 17 +++--------------
 2 files changed, 7 insertions(+), 30 deletions(-)

diff --git a/arch/nios2/include/asm/io.h b/arch/nios2/include/asm/io.h
index 9010243077ab..74ab34aa6731 100644
--- a/arch/nios2/include/asm/io.h
+++ b/arch/nios2/include/asm/io.h
@@ -25,29 +25,17 @@
 #define writew_relaxed(x, addr)	writew(x, addr)
 #define writel_relaxed(x, addr)	writel(x, addr)
 
-extern void __iomem *__ioremap(unsigned long physaddr, unsigned long size,
-			unsigned long cacheflag);
+void __iomem *ioremap(unsigned long physaddr, unsigned long size);
 extern void __iounmap(void __iomem *addr);
 
-static inline void __iomem *ioremap(unsigned long physaddr, unsigned long size)
-{
-	return __ioremap(physaddr, size, 0);
-}
-
-static inline void __iomem *ioremap_nocache(unsigned long physaddr,
-						unsigned long size)
-{
-	return __ioremap(physaddr, size, 0);
-}
-
 static inline void iounmap(void __iomem *addr)
 {
 	__iounmap(addr);
 }
 
-#define ioremap_nocache ioremap_nocache
-#define ioremap_wc ioremap_nocache
-#define ioremap_wt ioremap_nocache
+#define ioremap_nocache ioremap
+#define ioremap_wc ioremap
+#define ioremap_wt ioremap
 
 /* Pages to physical address... */
 #define page_to_phys(page)	virt_to_phys(page_to_virt(page))
diff --git a/arch/nios2/mm/ioremap.c b/arch/nios2/mm/ioremap.c
index 3a28177a01eb..7a1a27f3daa3 100644
--- a/arch/nios2/mm/ioremap.c
+++ b/arch/nios2/mm/ioremap.c
@@ -112,8 +112,7 @@ static int remap_area_pages(unsigned long address, unsigned long phys_addr,
 /*
  * Map some physical address range into the kernel address space.
  */
-void __iomem *__ioremap(unsigned long phys_addr, unsigned long size,
-			unsigned long cacheflag)
+void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
 {
 	struct vm_struct *area;
 	unsigned long offset;
@@ -139,15 +138,6 @@ void __iomem *__ioremap(unsigned long phys_addr, unsigned long size,
 				return NULL;
 	}
 
-	/*
-	 * Map uncached objects in the low part of address space to
-	 * CONFIG_NIOS2_IO_REGION_BASE
-	 */
-	if (IS_MAPPABLE_UNCACHEABLE(phys_addr) &&
-	    IS_MAPPABLE_UNCACHEABLE(last_addr) &&
-	    !(cacheflag & _PAGE_CACHED))
-		return (void __iomem *)(CONFIG_NIOS2_IO_REGION_BASE + phys_addr);
-
 	/* Mappings have to be page-aligned */
 	offset = phys_addr & ~PAGE_MASK;
 	phys_addr &= PAGE_MASK;
@@ -158,14 +148,13 @@ void __iomem *__ioremap(unsigned long phys_addr, unsigned long size,
 	if (!area)
 		return NULL;
 	addr = area->addr;
-	if (remap_area_pages((unsigned long) addr, phys_addr, size,
-		cacheflag)) {
+	if (remap_area_pages((unsigned long) addr, phys_addr, size, 0)) {
 		vunmap(addr);
 		return NULL;
 	}
 	return (void __iomem *) (offset + (char *)addr);
 }
-EXPORT_SYMBOL(__ioremap);
+EXPORT_SYMBOL(ioremap);
 
 /*
  * __iounmap unmaps nearly everything, so be careful
-- 
2.20.1

