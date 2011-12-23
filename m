Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Dec 2011 13:34:27 +0100 (CET)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:53181 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903779Ab1LWM2J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Dec 2011 13:28:09 +0100
Received: from euspt1 (mailout2.w1.samsung.com [210.118.77.12])
 by mailout2.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0LWN007OFPANV1@mailout2.w1.samsung.com> for
 linux-mips@linux-mips.org; Fri, 23 Dec 2011 12:28:02 +0000 (GMT)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0LWN008ECPANPZ@spt1.w1.samsung.com> for
 linux-mips@linux-mips.org; Fri, 23 Dec 2011 12:27:59 +0000 (GMT)
Received: from mcdsrvbld02.digital.local (unknown [106.116.37.23])
        by linux.samsung.com (Postfix) with ESMTP id 01AB627005F; Fri,
 23 Dec 2011 13:39:24 +0100 (CET)
Date:   Fri, 23 Dec 2011 13:27:33 +0100
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCH 14/14] common: DMA-mapping: add NON-CONSISTENT attribute
In-reply-to: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>
Message-id: <1324643253-3024-15-git-send-email-m.szyprowski@samsung.com>
MIME-version: 1.0
X-Mailer: git-send-email 1.7.7.3
Content-type: TEXT/PLAIN
Content-transfer-encoding: 7BIT
References: <1324643253-3024-1-git-send-email-m.szyprowski@samsung.com>
X-archive-position: 32172
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 18842

DMA_ATTR_NON_CONSISTENT lets the platform to choose to return either
consistent or non-consistent memory as it sees fit.  By using this API,
you are guaranteeing to the platform that you have all the correct and
necessary sync points for this memory in the driver should it choose to
return non-consistent memory.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
---
 Documentation/DMA-attributes.txt |    9 +++++++++
 include/linux/dma-attrs.h        |    1 +
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index 811a5d4..9120de2 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -41,3 +41,12 @@ buffered to improve performance.
 Since it is optional for platforms to implement DMA_ATTR_WRITE_COMBINE,
 those that do not will simply ignore the attribute and exhibit default
 behavior.
+
+DMA_ATTR_NON_CONSISTENT
+-----------------------
+
+DMA_ATTR_NON_CONSISTENT lets the platform to choose to return either
+consistent or non-consistent memory as it sees fit.  By using this API,
+you are guaranteeing to the platform that you have all the correct and
+necessary sync points for this memory in the driver should it choose to
+return non-consistent memory.
diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
index ada61e1..547ab56 100644
--- a/include/linux/dma-attrs.h
+++ b/include/linux/dma-attrs.h
@@ -14,6 +14,7 @@ enum dma_attr {
 	DMA_ATTR_WRITE_BARRIER,
 	DMA_ATTR_WEAK_ORDERING,
 	DMA_ATTR_WRITE_COMBINE,
+	DMA_ATTR_NON_CONSISTENT,
 	DMA_ATTR_MAX,
 };
 
-- 
1.7.1.569.g6f426
