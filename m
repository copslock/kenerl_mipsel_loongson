Return-Path: <SRS0=ChUC=OS=vger.kernel.org=linux-mips-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E32C6C65BAF
	for <linux-mips@archiver.kernel.org>; Sun,  9 Dec 2018 15:50:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9173C20867
	for <linux-mips@archiver.kernel.org>; Sun,  9 Dec 2018 15:50:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9173C20867
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=hauke-m.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-mips-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbeLIPuH (ORCPT <rfc822;linux-mips@archiver.kernel.org>);
        Sun, 9 Dec 2018 10:50:07 -0500
Received: from mx2.mailbox.org ([80.241.60.215]:20600 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726086AbeLIPuH (ORCPT <rfc822;linux-mips@vger.kernel.org>);
        Sun, 9 Dec 2018 10:50:07 -0500
Received: from smtp2.mailbox.org (unknown [IPv6:2001:67c:2050:105:465:1:2:0])
        (using TLSv1.2 with cipher ECDHE-RSA-CHACHA20-POLY1305 (256/256 bits))
        (No client certificate requested)
        by mx2.mailbox.org (Postfix) with ESMTPS id B2ED8A1134;
        Sun,  9 Dec 2018 16:50:04 +0100 (CET)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp2.mailbox.org ([80.241.60.241])
        by hefe.heinlein-support.de (hefe.heinlein-support.de [91.198.250.172]) (amavisd-new, port 10030)
        with ESMTP id a6gMjyD_zQuB; Sun,  9 Dec 2018 16:50:03 +0100 (CET)
From:   Hauke Mehrtens <hauke@hauke-m.de>
To:     ralf@linux-mips.org, paul.burton@mips.com, jhogan@kernel.org
Cc:     linux-mips@vger.kernel.org, nbd@nbd.name,
        Hauke Mehrtens <hauke@hauke-m.de>
Subject: [PATCH] MIPS: Compile post DMA flush only when needed
Date:   Sun,  9 Dec 2018 16:49:57 +0100
Message-Id: <20181209154957.28403-1-hauke@hauke-m.de>
Sender: linux-mips-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-mips.vger.kernel.org>
X-Mailing-List: linux-mips@vger.kernel.org

dma_sync_phys() is only called for some CPUs when a mapping is removed.
Add ARCH_HAS_SYNC_DMA_FOR_CPU only for the CPUs listed in
cpu_needs_post_dma_flush() which need this extra call and do not compile
this code in for other CPUs. We need this for R10000, R12000, BMIPS5000
CPUs and CPUs supporting MAAR which was introduced in MIPS32r5.

This will hopefully improve the performance of the not affected devices.

Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
---
 arch/mips/Kconfig              | 6 +++++-
 arch/mips/mm/dma-noncoherent.c | 2 ++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 653f52f2f383..c0708fdd7933 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1119,7 +1119,6 @@ config DMA_NONCOHERENT
 	bool
 	select ARCH_HAS_DMA_MMAP_PGPROT
 	select ARCH_HAS_SYNC_DMA_FOR_DEVICE
-	select ARCH_HAS_SYNC_DMA_FOR_CPU
 	select NEED_DMA_MAP_STATE
 	select ARCH_HAS_DMA_COHERENT_TO_PFN
 	select DMA_NONCOHERENT_CACHE_SYNC
@@ -1923,9 +1922,11 @@ config SYS_HAS_CPU_MIPS32_R3_5
 
 config SYS_HAS_CPU_MIPS32_R5
 	bool
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
 
 config SYS_HAS_CPU_MIPS32_R6
 	bool
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
 
 config SYS_HAS_CPU_MIPS64_R1
 	bool
@@ -1935,6 +1936,7 @@ config SYS_HAS_CPU_MIPS64_R2
 
 config SYS_HAS_CPU_MIPS64_R6
 	bool
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
 
 config SYS_HAS_CPU_R3000
 	bool
@@ -1971,6 +1973,7 @@ config SYS_HAS_CPU_R8000
 
 config SYS_HAS_CPU_R10000
 	bool
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
 
 config SYS_HAS_CPU_RM7000
 	bool
@@ -1999,6 +2002,7 @@ config SYS_HAS_CPU_BMIPS4380
 config SYS_HAS_CPU_BMIPS5000
 	bool
 	select SYS_HAS_CPU_BMIPS
+	select ARCH_HAS_SYNC_DMA_FOR_CPU
 
 config SYS_HAS_CPU_XLR
 	bool
diff --git a/arch/mips/mm/dma-noncoherent.c b/arch/mips/mm/dma-noncoherent.c
index cb38461391cb..f7e0fd6b7619 100644
--- a/arch/mips/mm/dma-noncoherent.c
+++ b/arch/mips/mm/dma-noncoherent.c
@@ -145,12 +145,14 @@ void arch_sync_dma_for_device(struct device *dev, phys_addr_t paddr,
 	dma_sync_phys(paddr, size, dir);
 }
 
+#ifdef CONFIG_ARCH_HAS_SYNC_DMA_FOR_CPU
 void arch_sync_dma_for_cpu(struct device *dev, phys_addr_t paddr,
 		size_t size, enum dma_data_direction dir)
 {
 	if (cpu_needs_post_dma_flush(dev))
 		dma_sync_phys(paddr, size, dir);
 }
+#endif
 
 void arch_dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		enum dma_data_direction direction)
-- 
2.11.0

