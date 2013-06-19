Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Jun 2013 00:04:40 +0200 (CEST)
Received: from mail-pb0-f44.google.com ([209.85.160.44]:39268 "EHLO
        mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6835001Ab3FSWEj1Pr2S (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Jun 2013 00:04:39 +0200
Received: by mail-pb0-f44.google.com with SMTP id uo1so5529047pbc.17
        for <multiple recipients>; Wed, 19 Jun 2013 15:04:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=Dx7Ie3rTLG4tzyLJuTFdT4O5g8lUrSVdBoUgq9LoYC0=;
        b=LUXJ4x97aUqxhJrjvzRrB1QSRWjFVQx9D29gpgWEzNIegWwBeT9qtVo3cS8imFLOyu
         mY6D49gDnXZ+YM2NzbNfJFOErS8B5VW0J3NGhcFXqLgiFdylQ8Q17+mfPneDK+2ZPvdy
         3Ap9Ix3TG1CSxsxlLwfEch1y51d/tgvniXAkujJkc0q2Z4f+O6tryC7E77jOIRLuNRWm
         upsD+1Oc4pEKgcIBVVQpJKA7bHE+7o9imsQ6hY5w77BRXJX4OvqAiuHcfkc6CjaQ2nql
         bEo8NGcWz9DN9UnNLf5D+PDKMX8yggO9AUSAk4xFs6E2Zk6Tytx4HXD3OjOFs88l2MEY
         Xg9g==
X-Received: by 10.68.110.163 with SMTP id ib3mr4626058pbb.196.1371679472876;
        Wed, 19 Jun 2013 15:04:32 -0700 (PDT)
Received: from dl.caveonetworks.com (64.2.3.195.ptr.us.xo.net. [64.2.3.195])
        by mx.google.com with ESMTPSA id cc15sm26512978pac.1.2013.06.19.15.04.31
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 19 Jun 2013 15:04:31 -0700 (PDT)
Received: from dl.caveonetworks.com (localhost.localdomain [127.0.0.1])
        by dl.caveonetworks.com (8.14.5/8.14.5) with ESMTP id r5JM4UWL029514;
        Wed, 19 Jun 2013 15:04:30 -0700
Received: (from ddaney@localhost)
        by dl.caveonetworks.com (8.14.5/8.14.5/Submit) id r5JM4TrD029513;
        Wed, 19 Jun 2013 15:04:29 -0700
From:   David Daney <ddaney.cavm@gmail.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
Cc:     David Daney <david.daney@cavium.com>
Subject: [PATCH] MIPS: Fix OCTEON BUG() warnings a different way.
Date:   Wed, 19 Jun 2013 15:04:28 -0700
Message-Id: <1371679468-29479-1-git-send-email-ddaney.cavm@gmail.com>
X-Mailer: git-send-email 1.7.11.7
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37030
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

From: David Daney <david.daney@cavium.com>

Signed-off-by: David Daney <david.daney@cavium.com>
---
 arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
index 840399b..3531963 100644
--- a/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
+++ b/arch/mips/include/asm/mach-cavium-octeon/dma-coherence.h
@@ -24,21 +24,21 @@ static inline dma_addr_t plat_map_dma_mem(struct device *dev, void *addr,
 	size_t size)
 {
 	BUG();
-	unreachable();
+	return 0;
 }
 
 static inline dma_addr_t plat_map_dma_mem_page(struct device *dev,
 	struct page *page)
 {
 	BUG();
-	unreachable();
+	return 0;
 }
 
 static inline unsigned long plat_dma_addr_to_phys(struct device *dev,
 	dma_addr_t dma_addr)
 {
 	BUG();
-	unreachable();
+	return 0;
 }
 
 static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
@@ -50,7 +50,7 @@ static inline void plat_unmap_dma_mem(struct device *dev, dma_addr_t dma_addr,
 static inline int plat_dma_supported(struct device *dev, u64 mask)
 {
 	BUG();
-	unreachable();
+	return 0;
 }
 
 static inline void plat_extra_sync_for_device(struct device *dev)
@@ -67,7 +67,7 @@ static inline int plat_dma_mapping_error(struct device *dev,
 					 dma_addr_t dma_addr)
 {
 	BUG();
-	unreachable();
+	return 0;
 }
 
 dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr);
-- 
1.7.11.7
