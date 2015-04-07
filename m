Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 07 Apr 2015 22:35:43 +0200 (CEST)
Received: from mail-pa0-f52.google.com ([209.85.220.52]:34165 "EHLO
        mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27014474AbbDGUfHnd2au (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 7 Apr 2015 22:35:07 +0200
Received: by pacyx8 with SMTP id yx8so89902242pac.1;
        Tue, 07 Apr 2015 13:35:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mZHWm7DNreckHc3fqfCLVMs6zdykLh1Yndp8BnQkIOw=;
        b=TWUF5yiBPHTLYDW0c6Z+NjrFVH19h0aXwJXmLJyCAJBm1jKZF+3hKpSoZV8PUAon3b
         XjGP1jFSk+uWVCJiCS5JEAe3Fw3iZYg2dvh0bAywG9NLG7KP1iZ/b8M3rnrs8gPXveCs
         TrAUOd3dKlzvLYThczZTdxdnT1y8k6do9N1ktTqi1eL0ButMLL/aHcFHtSEKRD5O1Zb/
         R3LLQ3Hhsk9pNts9ArqzGrC1Vh5+Abwz0NK14+HjaybJNUz0qzr/wIr+iz0bOJB0HjdC
         caP1+GbEqmEttPM5yLBmKqcIgIdlHBj0DLlFbJ7FC8L8FoYbv84WzVa6boQ2VMKcSnBr
         XG4g==
X-Received: by 10.68.230.137 with SMTP id sy9mr39729053pbc.111.1428438903279;
        Tue, 07 Apr 2015 13:35:03 -0700 (PDT)
Received: from fainelli-desktop.broadcom.com (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by mx.google.com with ESMTPSA id ve3sm8856029pbc.22.2015.04.07.13.35.02
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 07 Apr 2015 13:35:02 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-mips@linux-mips.org
Cc:     ralf@linux-mips.org, cernekee@gmail.com, jogo@openwrt.org,
        Florian Fainelli <f.fainelli@gmail.com>
Subject: [PATCH 2/3] MIPS: DMA: Allow platforms to override only the post DMA hook
Date:   Tue,  7 Apr 2015 13:34:01 -0700
Message-Id: <1428438842-5728-3-git-send-email-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.1.0
In-Reply-To: <1428438842-5728-1-git-send-email-f.fainelli@gmail.com>
References: <1428438842-5728-1-git-send-email-f.fainelli@gmail.com>
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 46819
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

Instead of having platforms to copy the entirety of
mach-generic/dma-coherence.h, check whether these platforms have already
defined a plat_post_dma_flush hook, and if not, provide an inline stub.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 arch/mips/include/asm/mach-generic/dma-coherence.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index 671330928e67..0f8a354fd468 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -52,9 +52,11 @@ static inline int plat_device_is_coherent(struct device *dev)
 	return coherentio;
 }
 
+#ifndef plat_post_dma_flush
 static inline void plat_post_dma_flush(struct device *dev)
 {
 }
+#endif
 
 #ifdef CONFIG_SWIOTLB
 static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
-- 
2.1.0
