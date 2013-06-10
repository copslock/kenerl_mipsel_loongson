Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 10 Jun 2013 09:27:14 +0200 (CEST)
Received: from mms1.broadcom.com ([216.31.210.17]:4029 "EHLO mms1.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6817528Ab3FJH1KMLwt5 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 10 Jun 2013 09:27:10 +0200
Received: from [10.9.208.55] by mms1.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Mon, 10 Jun 2013 00:23:17 -0700
X-Server-Uuid: 06151B78-6688-425E-9DE2-57CB27892261
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS07.corp.ad.broadcom.com (10.9.208.55) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Mon, 10 Jun 2013 00:26:56 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Mon, 10 Jun 2013 00:26:56 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 8930EF2D73; Mon, 10
 Jun 2013 00:26:55 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     linux-mips@linux-mips.org, ralf@linux-mips.org
cc:     "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH 1/2] MIPS: Support SWIOTLB in default dma operations
Date:   Mon, 10 Jun 2013 12:58:08 +0530
Message-ID: <1370849289-4877-2-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1370849289-4877-1-git-send-email-jchandra@broadcom.com>
References: <1370849289-4877-1-git-send-email-jchandra@broadcom.com>
MIME-Version: 1.0
X-WSS-ID: 7DABA16F31W33899126-01-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jchandra@broadcom.com
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

Provide a default implementation of phys_to_dma and dma_to_phys in
mach-generic/dma_coherence.h.

If CONFIG_NEED_SG_DMA_LENGTH is defined, the dma_length field in
struct scatterlist is used. Set this up in mips_dma_map_sg so that
the default mips DMA ops can be used when SWIOTLB is enabled.

Signed-off-by: Jayachandran C <jchandra@broadcom.com>
---
 arch/mips/include/asm/mach-generic/dma-coherence.h |   12 ++++++++++++
 arch/mips/mm/dma-default.c                         |    3 +++
 2 files changed, 15 insertions(+)

diff --git a/arch/mips/include/asm/mach-generic/dma-coherence.h b/arch/mips/include/asm/mach-generic/dma-coherence.h
index fe23034..74cb992 100644
--- a/arch/mips/include/asm/mach-generic/dma-coherence.h
+++ b/arch/mips/include/asm/mach-generic/dma-coherence.h
@@ -66,4 +66,16 @@ static inline int plat_device_is_coherent(struct device *dev)
 #endif
 }
 
+#ifdef CONFIG_SWIOTLB
+static inline dma_addr_t phys_to_dma(struct device *dev, phys_addr_t paddr)
+{
+	return paddr;
+}
+
+static inline phys_addr_t dma_to_phys(struct device *dev, dma_addr_t daddr)
+{
+	return daddr;
+}
+#endif
+
 #endif /* __ASM_MACH_GENERIC_DMA_COHERENCE_H */
diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index caf92ec..aaccf1c 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -246,6 +246,9 @@ static int mips_dma_map_sg(struct device *dev, struct scatterlist *sg,
 		if (!plat_device_is_coherent(dev))
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
+#ifdef CONFIG_NEED_SG_DMA_LENGTH
+		sg->dma_length = sg->length;
+#endif
 		sg->dma_address = plat_map_dma_mem_page(dev, sg_page(sg)) +
 				  sg->offset;
 	}
-- 
1.7.9.5
