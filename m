Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 May 2018 11:21:37 +0200 (CEST)
Received: from bombadil.infradead.org ([IPv6:2607:7c80:54:e::133]:50466 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992851AbeEYJVSnQJXA (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 May 2018 11:21:18 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=References:In-Reply-To:Message-Id:
        Date:Subject:Cc:To:From:Sender:Reply-To:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=vq6vd0W/DwsHgRuRtqbiJxldqPYUqhwggCiSkxwHrnE=; b=E+NPozrbov288/NcDy7rEDXNn
        AL2aKrEU87yEXIENfEKHRnnEvIy+lWOjZZb7USeneM6HX5ROmS1/6XC7znnh0cc61TG7L0tg7U5nq
        6XakyvIoZOazqme0xP9T+hLPCw5+JpWo1hKrrlwgnppInRrrMQULCLW4kskSM60lF524gj8ljBD/I
        89oFpD7FNx6rTYHEkqcBiyvpiZCxUxayasZ+sRHgtIp5C1dtasRYXqiJeRDPfCXxesmm8RfglzvyJ
        JQHd3DX4WWd0ZBbylX/RkOV8ScfmA00q/rH0q5jKqJAJfnhqmnOef7OgzVXdi8V1vyGmBjWArQM6J
        t2aZHlOUg==;
Received: from 80-109-164-210.cable.dynamic.surfer.at ([80.109.164.210] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.90_1 #2 (Red Hat Linux))
        id 1fM8uT-0001cv-8T; Fri, 25 May 2018 09:21:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ralf Baechle <ralf@linux-mips.org>, James Hogan <jhogan@kernel.org>
Cc:     Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: [PATCH 01/25] MIPS: remove a dead ifdef from mach-ath25/dma-coherence.h
Date:   Fri, 25 May 2018 11:20:47 +0200
Message-Id: <20180525092111.18516-2-hch@lst.de>
X-Mailer: git-send-email 2.17.0
In-Reply-To: <20180525092111.18516-1-hch@lst.de>
References: <20180525092111.18516-1-hch@lst.de>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Return-Path: <BATV+5cb9c4fab7748cb05a15+5388+infradead.org+hch@bombadil.srs.infradead.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64014
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

ath25 is alwas non-coherent, so keeping these ifdefs doesn't make any sense.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/mips/include/asm/mach-ath25/dma-coherence.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/mips/include/asm/mach-ath25/dma-coherence.h b/arch/mips/include/asm/mach-ath25/dma-coherence.h
index d5defdde32db..124755d4f079 100644
--- a/arch/mips/include/asm/mach-ath25/dma-coherence.h
+++ b/arch/mips/include/asm/mach-ath25/dma-coherence.h
@@ -61,12 +61,7 @@ static inline int plat_dma_supported(struct device *dev, u64 mask)
 
 static inline int plat_device_is_coherent(struct device *dev)
 {
-#ifdef CONFIG_DMA_COHERENT
-	return 1;
-#endif
-#ifdef CONFIG_DMA_NONCOHERENT
 	return 0;
-#endif
 }
 
 static inline void plat_post_dma_flush(struct device *dev)
-- 
2.17.0
