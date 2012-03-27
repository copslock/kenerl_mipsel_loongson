Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2012 15:50:03 +0200 (CEST)
Received: from mailout2.w1.samsung.com ([210.118.77.12]:24066 "EHLO
        mailout2.w1.samsung.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903686Ab2C0Nnk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2012 15:43:40 +0200
Received: from euspt1 (mailout2.w1.samsung.com [210.118.77.12])
 by mailout2.w1.samsung.com
 (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14 2004))
 with ESMTP id <0M1J00LDMQ49KH@mailout2.w1.samsung.com> for
 linux-mips@linux-mips.org; Tue, 27 Mar 2012 14:43:27 +0100 (BST)
Received: from linux.samsung.com ([106.116.38.10])
 by spt1.w1.samsung.com (iPlanet Messaging Server 5.2 Patch 2 (built Jul 14
 2004)) with ESMTPA id <0M1J008F3Q4CGS@spt1.w1.samsung.com> for
 linux-mips@linux-mips.org; Tue, 27 Mar 2012 14:43:25 +0100 (BST)
Received: from mcdsrvbld02.digital.local (unknown [106.116.37.23])
        by linux.samsung.com (Postfix) with ESMTP id 2095427005A; Tue,
 27 Mar 2012 15:46:12 +0200 (CEST)
Date:   Tue, 27 Mar 2012 15:42:48 +0200
From:   Marek Szyprowski <m.szyprowski@samsung.com>
Subject: [PATCHv2 14/14] common: DMA-mapping: add NON-CONSISTENT attribute
In-reply-to: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
To:     linux-kernel@vger.kernel.org
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
        microblaze-uclinux@itee.uq.edu.au, linux-arch@vger.kernel.org,
        x86@kernel.org, linux-sh@vger.kernel.org,
        linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
        linux-ia64@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-mips@linux-mips.org, discuss@x86-64.org,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linaro-mm-sig@lists.linaro.org, Jonathan Corbet <corbet@lwn.net>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Andrzej Pietrasiewicz <andrzej.p@samsung.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Dezhong Diao <dediao@cisco.com>,
        Richard Kuo <rkuo@codeaurora.org>,
        "David S. Miller" <davem@davemloft.net>,
        Michal Simek <monstr@monstr.eu>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Paul Mundt <lethal@linux-sh.org>,
        Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Matt Turner <mattst88@gmail.com>,
        Tony Luck <tony.luck@intel.com>,
        Fenghua Yu <fenghua.yu@intel.com>
Message-id: <1332855768-32583-15-git-send-email-m.szyprowski@samsung.com>
MIME-version: 1.0
X-Mailer: git-send-email 1.7.9.1
Content-type: TEXT/PLAIN
Content-transfer-encoding: 7BIT
References: <1332855768-32583-1-git-send-email-m.szyprowski@samsung.com>
X-archive-position: 32789
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: m.szyprowski@samsung.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

DMA_ATTR_NON_CONSISTENT lets the platform to choose to return either
consistent or non-consistent memory as it sees fit.  By using this API,
you are guaranteeing to the platform that you have all the correct and
necessary sync points for this memory in the driver should it choose to
return non-consistent memory.

Signed-off-by: Marek Szyprowski <m.szyprowski@samsung.com>
Acked-by: Kyungmin Park <kyungmin.park@samsung.com>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
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
