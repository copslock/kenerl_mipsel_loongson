Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Sep 2013 14:58:45 +0200 (CEST)
Received: from mms3.broadcom.com ([216.31.210.19]:4627 "EHLO mms3.broadcom.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816233Ab3IYM6l5H404 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Sep 2013 14:58:41 +0200
Received: from [10.9.208.57] by mms3.broadcom.com with ESMTP (Broadcom
 SMTP Relay (Email Firewall v6.5)); Wed, 25 Sep 2013 05:47:44 -0700
X-Server-Uuid: B86B6450-0931-4310-942E-F00ED04CA7AF
Received: from IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) by
 IRVEXCHCAS08.corp.ad.broadcom.com (10.9.208.57) with Microsoft SMTP
 Server (TLS) id 14.1.438.0; Wed, 25 Sep 2013 05:56:27 -0700
Received: from mail-irva-13.broadcom.com (10.10.10.20) by
 IRVEXCHSMTP1.corp.ad.broadcom.com (10.9.207.51) with Microsoft SMTP
 Server id 14.1.438.0; Wed, 25 Sep 2013 05:56:27 -0700
Received: from netl-snoppy.ban.broadcom.com (
 netl-snoppy.ban.broadcom.com [10.132.128.129]) by
 mail-irva-13.broadcom.com (Postfix) with ESMTP id 76781246A4; Wed, 25
 Sep 2013 05:56:26 -0700 (PDT)
From:   "Jayachandran C" <jchandra@broadcom.com>
To:     ralf@linux-mips.org
cc:     linux-mips@linux-mips.org, "Jayachandran C" <jchandra@broadcom.com>
Subject: [PATCH] MIPS: mm: Move some checks out of 'for' loop in DMA
 operations
Date:   Wed, 25 Sep 2013 18:31:05 +0530
Message-ID: <1380114065-9761-1-git-send-email-jchandra@broadcom.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
X-WSS-ID: 7E5C04E52L888359311-04-01
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-Path: <jchandra@broadcom.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37971
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

The check cpu_needs_post_dma_flush() in mips_dma_sync_sg_for_cpu() and
the check !plat_device_is_coherent() in mips_dma_sync_sg_for_device()
can be moved outside the for loop.

As a side effect, this also avoids a GCC bug that caused kernel compile
to fail with the error:

arch/mips/mm/dma-default.c: In function 'mips_dma_sync_sg_for_cpu':
arch/mips/mm/dma-default.c:316:1: internal compiler error: in add_insn_before, at emit-rtl.c:3852

This gcc failure is seen in Code Sourcery toolchains [e.g. gcc version
4.7.2 (Sourcery CodeBench Lite 2012.09-99)] after commit "MIPS: Optimize
current_cpu_type() for better code."
---
 arch/mips/mm/dma-default.c |   12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/arch/mips/mm/dma-default.c b/arch/mips/mm/dma-default.c
index e45e4b0..2e94185 100644
--- a/arch/mips/mm/dma-default.c
+++ b/arch/mips/mm/dma-default.c
@@ -307,12 +307,10 @@ static void mips_dma_sync_sg_for_cpu(struct device *dev,
 {
 	int i;
 
-	/* Make sure that gcc doesn't leave the empty loop body.  */
-	for (i = 0; i < nelems; i++, sg++) {
-		if (cpu_needs_post_dma_flush(dev))
+	if (cpu_needs_post_dma_flush(dev))
+		for (i = 0; i < nelems; i++, sg++)
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
-	}
 }
 
 static void mips_dma_sync_sg_for_device(struct device *dev,
@@ -320,12 +318,10 @@ static void mips_dma_sync_sg_for_device(struct device *dev,
 {
 	int i;
 
-	/* Make sure that gcc doesn't leave the empty loop body.  */
-	for (i = 0; i < nelems; i++, sg++) {
-		if (!plat_device_is_coherent(dev))
+	if (!plat_device_is_coherent(dev))
+		for (i = 0; i < nelems; i++, sg++)
 			__dma_sync(sg_page(sg), sg->offset, sg->length,
 				   direction);
-	}
 }
 
 int mips_dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
-- 
1.7.9.5
