Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Aug 2015 18:29:21 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:60561 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012879AbbHYQ3TyJnAw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Aug 2015 18:29:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Message-Id:Date:Subject:Cc:To:From; bh=feFz5QzqXab0WpbHARC2NdSv3fkg009H2vFvxNXdINo=;
        b=oCHIiuKHwBiigfEouGpKMKouUoXikEcmOdl6CvkjDQfI6zcrezTgcZrOU0LFfAAS5n5UnWQZLadmYe9h63C5W/MVR7W50DOzHbPB0X/ASBQte0+jBCzXixcRzjqfFKm+zdM03gCsiVCjl8OTvoZmY4QkoEjbTXgvHvv3QNj/1jM=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:37992 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1ZUH5z-002pvP-LZ; Tue, 25 Aug 2015 16:29:12 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Guenter Roeck <linux@roeck-us.net>,
        Jayachandran C <jchandra@broadcom.com>,
        Ganesan Ramalingam <ganesanr@broadcom.com>
Subject: [PATCH -next] MIPS: Netlogic: Fix build error
Date:   Tue, 25 Aug 2015 09:29:10 -0700
Message-Id: <1440520150-2458-1-git-send-email-linux@roeck-us.net>
X-Mailer: git-send-email 2.1.4
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49011
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

dma_alloc_from_coherent is defined as (0) if HAVE_GENERIC_DMA_COHERENT
is not configured. This results in the following build error, seen
with nlm_xlp_defconfig.

arch/mips/netlogic/common/nlm-dma.c: In function 'nlm_dma_alloc_coherent':
arch/mips/netlogic/common/nlm-dma.c:50:8: error: unused variable 'ret'

Add __maybe_unused to the variable declaration to fix the problem.

Fixes: 79f8511c83f1 ("MIPS: Netlogic: SWIOTLB dma ops for 32-bit DMA")
Cc: Jayachandran C <jchandra@broadcom.com>
Cc: Ganesan Ramalingam <ganesanr@broadcom.com>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
 arch/mips/netlogic/common/nlm-dma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/netlogic/common/nlm-dma.c b/arch/mips/netlogic/common/nlm-dma.c
index f3d4ae87abc7..4982d97d279f 100644
--- a/arch/mips/netlogic/common/nlm-dma.c
+++ b/arch/mips/netlogic/common/nlm-dma.c
@@ -47,7 +47,7 @@ static char *nlm_swiotlb;
 static void *nlm_dma_alloc_coherent(struct device *dev, size_t size,
 	dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
 {
-	void *ret;
+	void __maybe_unused *ret;
 
 	if (dma_alloc_from_coherent(dev, size, dma_handle, &ret))
 		return ret;
-- 
2.1.4
