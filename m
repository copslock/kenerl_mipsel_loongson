Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 17 Nov 2017 05:29:12 +0100 (CET)
Received: from mail-pf0-x242.google.com ([IPv6:2607:f8b0:400e:c00::242]:35024
        "EHLO mail-pf0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990411AbdKQE3GHhe6O (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 17 Nov 2017 05:29:06 +0100
Received: by mail-pf0-x242.google.com with SMTP id d28so1042604pfe.2
        for <linux-mips@linux-mips.org>; Thu, 16 Nov 2017 20:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=CTWpekBDybbpL+om6G6ltK+WYaheJmaK66byhzX9VcU=;
        b=DXp9mezgWmjGSu4EKg12XaNypgT4+zPGUnVfvImYIdrMj3aSY6OtnMJh+/Pg2AdQQj
         NA9LWd3aDwg08E9Xt9E7Ep8e0g3Fr/mM0+CjybZ80Sxd5JK7zhK1I0qf9kEE9ShZqaQd
         cqCzZgR8XtCXSoHpbTzjYqqN8QbQ7R8mfu2dl4j823SKGe63nny6D/7zToeBVE7zTxrl
         di90arxaev2ZTQh7To0ytZ/FKeZylo9tj+cia5pgKPn/nm6o1zmZC28rY6GZLGkyDhgP
         ecSMNmlgNUxgsG10UEETWTp3HDOan5rGDrOuN3qFxmEBNQ7ABF5Cj0bguf+2isoeIdoL
         Ii2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=CTWpekBDybbpL+om6G6ltK+WYaheJmaK66byhzX9VcU=;
        b=gn/8zq+mCiIzSwLONsacWB2xLgMH6midMKyhqPiAmMM3W5bvKPKVkVYah9FP266sJ3
         fcDB0IH1Dn9FarKb+JObCQitctpNL74BT0JHJS6RwPStVEZC0sPzoCQMVOzUzEjuwGhY
         SbB4DzuLKt3MKh0aqLoxRk0efmzYRZlfm618EnBs1vW4U9UeQljl9f4min1BnUlRD8VL
         fwvu4Iua72QraSCHVpjtHpEueXpejD1cjVB4ISQnANdlOQOUML0TqzEodCLhD/N7mXZ4
         3M+GD9luVm/0nPLgAK7IrDceAU4bODxeBZ5G8SajmJODthpfPw4lT8rKDG4/vs3+VmKo
         /RYg==
X-Gm-Message-State: AJaThX78Y034B8LQeYe9MOUfAqnbfZH1mXeMlUagltB77hUETZGNpY5Q
        bbuDwa1DU8qWdo61F94RFhw=
X-Google-Smtp-Source: AGs4zMalOBZazs8nTlQHNH5hLCodAIQK+krUMzHxMy+/P+bfBWn/TdO9KfGxcVquDEufYbs54CZlvw==
X-Received: by 10.84.139.1 with SMTP id 1mr4033493plq.20.1510892939815;
        Thu, 16 Nov 2017 20:28:59 -0800 (PST)
Received: from software.domain.org ([172.247.34.138])
        by smtp.gmail.com with ESMTPSA id r18sm4554280pge.87.2017.11.16.20.28.56
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 16 Nov 2017 20:28:59 -0800 (PST)
From:   Huacai Chen <chenhc@lemote.com>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Fuxin Zhang <zhangfx@lemote.com>, linux-mips@linux-mips.org,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        Huacai Chen <chenhc@lemote.com>
Subject: [PATCH V10 2/4] MIPS: Implement dma_map_ops::get_cache_alignment()
Date:   Fri, 17 Nov 2017 12:28:54 +0800
Message-Id: <1510892934-32743-1-git-send-email-chenhc@lemote.com>
X-Mailer: git-send-email 2.7.0
Return-Path: <chenhuacai@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60984
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

Currently, MIPS is an architecture which support coherent & noncoherent
devices co-exist. So implement get_cache_alignment() function pointer
in 'struct dma_map_ops' to return different dma alignments.

Signed-off-by: Huacai Chen <chenhc@lemote.com>
---
 arch/mips/cavium-octeon/dma-octeon.c            | 3 ++-
 arch/mips/include/asm/dma-coherence.h           | 2 ++
 arch/mips/include/asm/mach-loongson64/kmalloc.h | 6 ++++++
 arch/mips/loongson64/common/dma-swiotlb.c       | 1 +
 arch/mips/mm/dma-default.c                      | 9 +++++++++
 arch/mips/netlogic/common/nlm-dma.c             | 3 ++-
 6 files changed, 22 insertions(+), 2 deletions(-)
 create mode 100644 arch/mips/include/asm/mach-loongson64/kmalloc.h

diff --git a/arch/mips/cavium-octeon/dma-octeon.c b/arch/mips/cavium-octeon/dma-octeon.c
index c64bd87..41c29a85 100644
--- a/arch/mips/cavium-octeon/dma-octeon.c
+++ b/arch/mips/cavium-octeon/dma-octeon.c
@@ -324,7 +324,8 @@ static struct octeon_dma_map_ops _octeon_pci_dma_map_ops = {
 		.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
 		.sync_sg_for_device = octeon_dma_sync_sg_for_device,
 		.mapping_error = swiotlb_dma_mapping_error,
-		.dma_supported = swiotlb_dma_supported
+		.dma_supported = swiotlb_dma_supported,
+		.get_cache_alignment = mips_dma_get_cache_alignment
 	},
 };
 
diff --git a/arch/mips/include/asm/dma-coherence.h b/arch/mips/include/asm/dma-coherence.h
index 72d0eab..5f7a9fc 100644
--- a/arch/mips/include/asm/dma-coherence.h
+++ b/arch/mips/include/asm/dma-coherence.h
@@ -29,4 +29,6 @@ extern int hw_coherentio;
 #define hw_coherentio	0
 #endif /* CONFIG_DMA_MAYBE_COHERENT */
 
+int mips_dma_get_cache_alignment(struct device *dev);
+
 #endif
diff --git a/arch/mips/include/asm/mach-loongson64/kmalloc.h b/arch/mips/include/asm/mach-loongson64/kmalloc.h
new file mode 100644
index 0000000..2731d9e
--- /dev/null
+++ b/arch/mips/include/asm/mach-loongson64/kmalloc.h
@@ -0,0 +1,6 @@
+#ifndef __ASM_MACH_LOONGSON64_KMALLOC_H
+#define __ASM_MACH_LOONGSON64_KMALLOC_H
+
+#define ARCH_DMA_MINALIGN L1_CACHE_BYTES
+
+#endif /* __ASM_MACH_LOONGSON64_KMALLOC_H */
diff --git a/arch/mips/loongson64/common/dma-swiotlb.c b/arch/mips/loongson64/common/dma-swiotlb.c
index 17956f2..fc6a4bf 100644
--- a/arch/mips/loongson64/common/dma-swiotlb.c
+++ b/arch/mips/loongson64/common/dma-swiotlb.c
@@ -121,6 +121,7 @@ static const struct dma_map_ops loongson_dma_map_ops = {
 	.mapping_error = swiotlb_dma_mapping_error,
 	.dma_supported = loongson_dma_supported,
 	.cache_sync = mips_dma_cache_sync,
+	.get_cache_alignment = mips_dma_get_cache_alignment
 };
 
 void __init plat_swiotlb_setup(void)
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index e86bf5d..f006cd2 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -392,6 +392,14 @@ void mips_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		__dma_sync_virtual(vaddr, size, direction);
 }
 
+int mips_dma_get_cache_alignment(struct device *dev)
+{
+	if (plat_device_is_coherent(dev))
+		return 1;
+	else
+		return ARCH_DMA_MINALIGN;
+}
+
 static const struct dma_map_ops mips_default_dma_map_ops = {
 	.alloc = mips_dma_alloc_coherent,
 	.free = mips_dma_free_coherent,
@@ -407,6 +415,7 @@ static const struct dma_map_ops mips_default_dma_map_ops = {
 	.mapping_error = mips_dma_mapping_error,
 	.dma_supported = mips_dma_supported,
 	.cache_sync = mips_dma_cache_sync,
+	.get_cache_alignment = mips_dma_get_cache_alignment
 };
 
 const struct dma_map_ops *mips_dma_map_ops = &mips_default_dma_map_ops;
diff --git a/arch/mips/netlogic/common/nlm-dma.c b/arch/mips/netlogic/common/nlm-dma.c
index 0ec9d9d..e9a9ddc 100644
--- a/arch/mips/netlogic/common/nlm-dma.c
+++ b/arch/mips/netlogic/common/nlm-dma.c
@@ -79,7 +79,8 @@ const struct dma_map_ops nlm_swiotlb_dma_ops = {
 	.sync_sg_for_cpu = swiotlb_sync_sg_for_cpu,
 	.sync_sg_for_device = swiotlb_sync_sg_for_device,
 	.mapping_error = swiotlb_dma_mapping_error,
-	.dma_supported = swiotlb_dma_supported
+	.dma_supported = swiotlb_dma_supported,
+	.get_cache_alignment = mips_dma_get_cache_alignment
 };
 
 void __init plat_swiotlb_setup(void)
-- 
2.7.0
