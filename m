Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 25 Aug 2015 22:16:03 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:52197 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27013212AbbHYUQBxp7-I (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 25 Aug 2015 22:16:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Message-Id:Date:Subject:Cc:To:From; bh=Edd1NNRH1ToJsOySGJMlB0G4D1AMV0VqcbQy7c4PwUg=;
        b=fndMYUlfrpg9nDIbpddqmSAh6G7ArPQaRn1kD5qsZtzsHqzugzv2VZTXfD++nKVgGyZyIp/5UsY3xEUNCi2x0f1Bc1oRcxjUjlorsCxfZFJq9RASABIRRgx6tBAOO0mndachVILQp7fUb5lo4rWA97xPkNgJBSibRJNtJ1szwhE=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:39806 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1ZUKdM-000Kze-Q8; Tue, 25 Aug 2015 20:15:54 +0000
From:   Guenter Roeck <linux@roeck-us.net>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v2 -next] MIPS: Netlogic: Fix build error
Date:   Tue, 25 Aug 2015 13:15:51 -0700
Message-Id: <1440533751-26147-1-git-send-email-linux@roeck-us.net>
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
X-archive-position: 49013
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

The variable 'ret' is no longer used in nlm_dma_alloc_coherent()
and causes the following build error.

arch/mips/netlogic/common/nlm-dma.c: In function 'nlm_dma_alloc_coherent':
arch/mips/netlogic/common/nlm-dma.c:50:8: error: unused variable 'ret'

Fixes: e4d0d18739dc ("dma-mapping: consolidate dma_{alloc,free}_{attrs,coherent}")
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
---
Previous version was based on next-20150824 and got it all wrong.
It might make sense to merge this into Andrew's tree, or even into
the offending patch.

 arch/mips/netlogic/common/nlm-dma.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/mips/netlogic/common/nlm-dma.c b/arch/mips/netlogic/common/nlm-dma.c
index 3e4f3bb1cf59..3758715d4ab6 100644
--- a/arch/mips/netlogic/common/nlm-dma.c
+++ b/arch/mips/netlogic/common/nlm-dma.c
@@ -47,8 +47,6 @@ static char *nlm_swiotlb;
 static void *nlm_dma_alloc_coherent(struct device *dev, size_t size,
 	dma_addr_t *dma_handle, gfp_t gfp, struct dma_attrs *attrs)
 {
-	void *ret;
-
 	/* ignore region specifiers */
 	gfp &= ~(__GFP_DMA | __GFP_DMA32 | __GFP_HIGHMEM);
 
-- 
2.1.4
