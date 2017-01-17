Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Jan 2017 16:24:30 +0100 (CET)
Received: from mout.kundenserver.de ([212.227.126.134]:65240 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993916AbdAQPWTC8ZRd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Jan 2017 16:22:19 +0100
Received: from wuerfel.lan ([78.43.21.235]) by mrelayeu.kundenserver.de
 (mreue001 [212.227.15.129]) with ESMTPA (Nemesis) id
 0MCDQW-1cKfri1EvY-008rtt; Tue, 17 Jan 2017 16:21:10 +0100
From:   Arnd Bergmann <arnd@arndb.de>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Robin Murphy <robin.murphy@arm.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] MIPS: loongson64: fix empty-body warning in dma_alloc
Date:   Tue, 17 Jan 2017 16:18:44 +0100
Message-Id: <20170117151911.4109452-10-arnd@arndb.de>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20170117151911.4109452-1-arnd@arndb.de>
References: <20170117151911.4109452-1-arnd@arndb.de>
X-Provags-ID: V03:K0:bNT879+tbA+DugZtVst12orWGQ+4bIkzK+HV139mp4Pjme5MCyr
 tbRJcugsg4WkiKxt1t0IsCAFmGBuI8LinuqZuBRtkgiC+9NUCajrFSI4p6vvuf4ck+Owulq
 2rCZbrz1UUQLr+Gn5bjiSVYYYeT0D7wdb3oHQYn1jB526KH1CTOOTQ5NTJT3EetjVorFlk2
 ZisixScDY9pv0bo5NUUUQ==
X-UI-Out-Filterresults: notjunk:1;V01:K0:K97BGpoKAHc=:BY9/QaN6Wx2QCWPhqcUtSz
 BF/rRSCIVMgJtolVl8HP3G78xhZdGHlg5N6xYU46f8BVo1KaoOo5mOF192JpFmgoZJEfQGvp9
 vZsv/YpeVOXsxfy++QLYHLdfqWcizWdRKcjTDZ8/Km+Uf9Avjjf2VGaq+kjA0v1RwmgktSuJ+
 GAzt5J0ByDFOms1tisS44BzEZ+UfRzOiwnOIx0KZL302HDOhWszd/01RUSTkXUwjVkeKjFhLp
 ReTjJbn++IccSs2cmunPKApAF6QF8X/R6kqgxEdauKcJuyHgP4ju/TTgfriUIAC4MdA7O2H37
 CkgsbODRbJJYAQSjohXb2d1yKMOjA/9GtRJw+OKBSNRx1n9kof/Cgch4McIdtl6O1gJ6SfrZd
 /nu+kh/QOZo0F4qYxVpdsCFL9lRow+XPRUwLTaB0donkICVofvLvrkJWXR4IQ8Ko1yawlwTW/
 WJpjMqGpiHgo3pLUjLm0ytQUHQ3NrlJFNZCREbR5cCI9jRQUCQE3RYYhSxyoGs/PtADHh2xbC
 K20RRurFRO857mxdB3dU0W1ZIL3D4sImH91TSNR2mxlzjAPTWXwvoujS0U+D18t36T8MVKoxb
 otGrhhZSCbq8rz75vcijEhxt7oMdl15ZLWnsSL1lX7JVnChY5mFTkuYGj4pmEEeuKtFgRpCHO
 vBNOjPX8wzGZ4oR8KV/5dkuidc/hB87EWCbVBU0/g8/+D4Kc5SJlW3rAB1hdGEurDiS4=
Return-Path: <arnd@arndb.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56353
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

A new gcc warning shows up for this old code with gcc-6:

arch/mips/loongson64/common/dma-swiotlb.c: In function 'loongson_dma_alloc_coherent':
arch/mips/loongson64/common/dma-swiotlb.c:35:2: error: suggest braces around empty body in an 'else' statement [-Werror=empty-body]

The code can be easily restructured to look more readable
and avoid the warning at the same time.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 arch/mips/loongson64/common/dma-swiotlb.c | 20 ++++++--------------
 1 file changed, 6 insertions(+), 14 deletions(-)

diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
index aab4fd681e1f..df7235e33499 100644
--- a/arch/mips/loongson64/common/dma-swiotlb.c
+++ b/arch/mips/loongson64/common/dma-swiotlb.c
@@ -17,22 +17,14 @@ static void *loongson_dma_alloc_coherent(struct device *dev, size_t size,
 	/* ignore region specifiers */
 	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
-#ifdef CONFIG_ISA
-	if (dev == NULL)
+	if ((IS_ENABLED(CONFIG_ISA) && dev == NULL) ||
+	    (IS_ENABLED(CONFIG_ZONE_DMA) &&
+	     dev->coherent_dma_mask < DMA_BIT_MASK(32)))
 		gfp |= __GFP_DMA;
-	else
-#endif
-#ifdef CONFIG_ZONE_DMA
-	if (dev->coherent_dma_mask < DMA_BIT_MASK(32))
-		gfp |= __GFP_DMA;
-	else
-#endif
-#ifdef CONFIG_ZONE_DMA32
-	if (dev->coherent_dma_mask < DMA_BIT_MASK(40))
+	else if (IS_ENABLED(CONFIG_ZONE_DMA32) &&
+		 dev->coherent_dma_mask < DMA_BIT_MASK(40))
 		gfp |= __GFP_DMA32;
-	else
-#endif
-	;
+
 	gfp |= __GFP_NORETRY;
 
 	ret = swiotlb_alloc_coherent(dev, size, dma_handle, gfp);
-- 
2.9.0
