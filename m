Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 01 May 2015 08:48:00 +0200 (CEST)
Received: from mail-pd0-f172.google.com ([209.85.192.172]:34202 "EHLO
        mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009946AbbEAGr6OBUz8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 1 May 2015 08:47:58 +0200
Received: by pdbqa5 with SMTP id qa5so84432382pdb.1;
        Thu, 30 Apr 2015 23:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Jo+RJXNhtG1TNHl3r2dTDN+olDi3LXLiHzYUjvI8qsM=;
        b=e33XbyYjZgymK/U+CGWSBCOFHh2+Tjy03FUqKY0Vd4SPalyFe3Az51/x2W0K0Mx1/q
         NY/C+dwUxYcgV6qRHAaVI/PAb07odkyjZSJSs4Tus/stz4u+8okOekBKlch1nef13nqL
         HrsTOpvaV4dyLjzWqQAd713+/jhTNFXvRXm41AJfCVHMgLJOQxQ72RINjjkOzpMNKsGD
         Loybm62TzwF4OrK9M9J+b/OBlBzoYE21ygvfDKpE5LMiIcqJbnoIQZPpzS5mHv1QEOJV
         JvpkfUxUDYa2Pl8SEVMsTB3fAKTdsnCAU2/ZgRRZIsjAfC0d+BupXZJiYsR49Tl8iM4s
         UKxw==
X-Received: by 10.70.48.68 with SMTP id j4mr14965290pdn.5.1430462873843;
        Thu, 30 Apr 2015 23:47:53 -0700 (PDT)
Received: from localhost.localdomain (KD106168100169.ppp-bb.dion.ne.jp. [106.168.100.169])
        by mx.google.com with ESMTPSA id j10sm3933886pdp.83.2015.04.30.23.47.50
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 30 Apr 2015 23:47:52 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-arch@vger.kernel.org
Subject: [PATCH 5/5] mips: use for_each_sg()
Date:   Fri,  1 May 2015 15:47:26 +0900
Message-Id: <1430462846-12022-5-git-send-email-akinobu.mita@gmail.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1430462846-12022-1-git-send-email-akinobu.mita@gmail.com>
References: <1430462846-12022-1-git-send-email-akinobu.mita@gmail.com>
Return-Path: <akinobu.mita@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47182
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akinobu.mita@gmail.com
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

Since mips doesn't select ARCH_HAS_SG_CHAIN, it is not necessary to
use for_each_sg() in order to loop over each sg element.  But this can
help find problems with drivers that do not properly initialize their
sg tables when CONFIG_DEBUG_SG is enabled.

Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
Cc: Ralf Baechle <ralf@linux-mips.org>
Cc: linux-mips@linux-mips.org
Cc: linux-arch@vger.kernel.org
---
 arch/mips/mm/dma-default.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index 609d124..eeaf024 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -262,12 +262,13 @@ static void mips_dma_unmap_page(struct device *dev, dma_addr_t dma_addr,
 	plat_unmap_dma_mem(dev, dma_addr, size, direction);
 }
 
-static int mips_dma_map_sg(struct device *dev, struct scatterlist *sg,
+static int mips_dma_map_sg(struct device *dev, struct scatterlist *sglist,
 	int nents, enum dma_data_direction direction, struct dma_attrs *attrs)
 {
 	int i;
+	struct scatterlist *sg;
 
-	for (i = 0; i < nents; i++, sg++) {
+	for_each_sg(sglist, sg, nents, i) {
 		if (!plat_device_is_coherent(dev))
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
@@ -291,13 +292,14 @@ static dma_addr_t mips_dma_map_page(struct device *dev, struct page *page,
 	return plat_map_dma_mem_page(dev, page) + offset;
 }
 
-static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+static void mips_dma_unmap_sg(struct device *dev, struct scatterlist *sglist,
 	int nhwentries, enum dma_data_direction direction,
 	struct dma_attrs *attrs)
 {
 	int i;
+	struct scatterlist *sg;
 
-	for (i = 0; i < nhwentries; i++, sg++) {
+	for_each_sg(sglist, sg, nhwentries, i) {
 		if (!plat_device_is_coherent(dev) &&
 		    direction != DMA_TO_DEVICE)
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
@@ -324,26 +326,34 @@ static void mips_dma_sync_single_for_device(struct device *dev,
 }
 
 static void mips_dma_sync_sg_for_cpu(struct device *dev,
-	struct scatterlist *sg, int nelems, enum dma_data_direction direction)
+	struct scatterlist *sglist, int nelems,
+	enum dma_data_direction direction)
 {
 	int i;
+	struct scatterlist *sg;
 
-	if (cpu_needs_post_dma_flush(dev))
-		for (i = 0; i < nelems; i++, sg++)
+	if (cpu_needs_post_dma_flush(dev)) {
+		for_each_sg(sglist, sg, nelems, i) {
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
+		}
+	}
 	plat_post_dma_flush(dev);
 }
 
 static void mips_dma_sync_sg_for_device(struct device *dev,
-	struct scatterlist *sg, int nelems, enum dma_data_direction direction)
+	struct scatterlist *sglist, int nelems,
+	enum dma_data_direction direction)
 {
 	int i;
+	struct scatterlist *sg;
 
-	if (!plat_device_is_coherent(dev))
-		for (i = 0; i < nelems; i++, sg++)
+	if (!plat_device_is_coherent(dev)) {
+		for_each_sg(sglist, sg, nelems, i) {
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
+		}
+	}
 }
 
 int mips_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-- 
1.9.1
