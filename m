Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 16 Nov 2017 09:35:58 +0100 (CET)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:47092
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992143AbdKPIfscAoWE (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 16 Nov 2017 09:35:48 +0100
Received: by mail-pf0-x242.google.com with SMTP id i15so8796782pfa.3;
        Thu, 16 Nov 2017 00:35:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=KnNuCo7U2WY3c6EZYsIHkUZeAQN+7NA7bXu6+sheReQ=;
        b=lCC0qGFjn6zM9l04nBvt/OWowDEZH7gZIk9/NnW/XMgxz4AEG9A61itNmuL60pXHRH
         IG7ODWzoHgAZ2pNZOFLSypvae6V4U/daJgqy/hgukN6Je+oHZhCpxb7n+KfuAcW+6vK/
         1ZGdkBbgW7CXD9yUmSqNHLXDe31ylEZv9CqxeDUvTGxUz67yxpbo0SQboBF5v1LLtUuy
         h+80bGWTHXYziJKsmeD+SiPF75/tuTlG0Dzu8xi/U+E+shwElH7JetcoJWGUD7sPzMj3
         dS/dzsKlDJVhUg2y2IA3pe2Q0JYEbb6L5JHfz5yDBOfspqm6WbyM5V6EMJ9xaPCQB5Sv
         hDTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=KnNuCo7U2WY3c6EZYsIHkUZeAQN+7NA7bXu6+sheReQ=;
        b=CZtcGWqBamCRHWjGmXzj5G3oL+vyeUcI7q1tRP3Ad1rbS95r6aX5W/v1vC8DG7eVg+
         ZcuOs+lGuZy32xvaDgM01maZ2aFqCwXTnGMVrAG7cGwXyZ5FJzgT+ym0RsN/g22mL34c
         DuLVZUmsAja1FPKqm9WeFAu1XAPzqxfryH+dfl5SMWg14IwmKWevu39UZdBXosj6Lm5N
         rzeLaQd18/9lz7P1MU/50qOtyeimrTtkMUb3a8LBoIBepB7x20J244xZGJ2XkRPS9F+m
         sQ9IF/Ft2ko5KuwNPOtjHdR5rLisL1AVX49AH9yEeA0gxJLbo7jIAcc30El93pUAUIxf
         2mFw==
X-Gm-Message-State: AJaThX7BZST7NZarnS7n0ckwvA19llDg1sSEb+wp6fpidyJkgmHBMgtt
        0TkyTztr2hlUtCHAVUr6xMSKhw==
X-Google-Smtp-Source: AGs4zMaLjKkVtNhl/RNBcXmRjSoeEZK2rKpdpWiA+aASzSiQTbRAL2gKB9WxS+xLtehZuOmyi4GN5g==
X-Received: by 10.99.130.74 with SMTP id w71mr922614pgd.31.1510821342356;
        Thu, 16 Nov 2017 00:35:42 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id w9sm1706032pfl.19.2017.11.16.00.35.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Nov 2017 00:35:41 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     James Hogan <James.Hogan@mips.com>,
        "Steven J . Hill" <Steven.Hill@cavium.com>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH 2/2] MIPS: Loongson64: Add cache_sync to loongson_dma_map_ops
Date:   Thu, 16 Nov 2017 16:35:55 +0800
Message-Id: <1510821355-24694-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60973
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: chenhc@lemote.com
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

To support coherent & non-coherent DMA co-exsistance, we should add
cache_sync to loongson_dma_map_ops.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/include/asm/dma-mapping.h       | 3 +++
 arch/mips/loongson64/common/dma-swiotlb.c | 1 +
 arch/mips/mm/dma-default.c                | 2 +-
 3 files changed, 5 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/dma-mapping.h b/arch/mips/include/asm/dma-mapping.h
index 0d9418d..5544276 100644
--- a/arch/mips/include/asm/dma-mapping.h
+++ b/arch/mips/include/asm/dma-mapping.h
@@ -37,4 +37,7 @@ static inline void arch_setup_dma_ops(struct device *dev, u64 dma_base,
 #endif
 }
 
+void mips_dma_cache_sync(struct device *dev, void *vaddr,
+		size_t size, enum dma_data_direction direction);
+
 #endif /* _ASM_DMA_MAPPING_H */
diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
index ef07740..17956f2 100644
--- a/arch/mips/loongson64/common/dma-swiotlb.c
+++ b/arch/mips/loongson64/common/dma-swiotlb.c
@@ -120,6 +120,7 @@ static const struct dma_map_ops loongson_dma_map_ops = {
 	.sync_sg_for_device = loongson_dma_sync_sg_for_device,
 	.mapping_error = swiotlb_dma_mapping_error,
 	.dma_supported = loongson_dma_supported,
+	.cache_sync = mips_dma_cache_sync,
 };
 
 void __init plat_swiotlb_setup(void)
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index e3e94d0..e86bf5d 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -383,7 +383,7 @@ static int mips_dma_supported(struct device *dev, u64 mask)
 	return plat_dma_supported(dev, mask);
 }
 
-static void mips_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
+void mips_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 			 enum dma_data_direction direction)
 {
 	BUG_ON(direction == DMA_NONE);
-- 
2.7.0
