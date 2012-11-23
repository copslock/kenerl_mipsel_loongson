Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Nov 2012 22:38:06 +0100 (CET)
Received: from g5t0008.atlanta.hp.com ([15.192.0.45]:23054 "EHLO
        g5t0008.atlanta.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825702Ab2KWViFcsF6q (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Nov 2012 22:38:05 +0100
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
        by g5t0008.atlanta.hp.com (Postfix) with ESMTP id F16A12403B;
        Fri, 23 Nov 2012 21:37:58 +0000 (UTC)
Received: from [10.152.0.6] (swa01cs005-da01.atlanta.hp.com [16.114.29.155])
        by g5t0030.atlanta.hp.com (Postfix) with ESMTP id BDCCF14287;
        Fri, 23 Nov 2012 21:37:55 +0000 (UTC)
Message-ID: <1353706674.5270.105.camel@lorien2>
Subject: [PATCH 9/9] tile: dma_debug: add debug_dma_mapping_error support
From:   Shuah Khan <shuah.khan@hp.com>
Reply-To: shuah.khan@hp.com
To:     Joerg Roedel <joro@8bytes.org>, a-jacquiot@ti.com,
        fenghua.yu@intel.com, catalin.marinas@arm.com, lethal@linux-sh.org,
        benh@kernel.crashing.org, ralf@linux-mips.org, tony.luck@intel.com,
        davem@davemloft.net, m.szyprowski@samsung.com, msalter@redhat.com,
        monstr@monstr.eu, Ming Lei <ming.lei@canonical.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-c6x-dev@linux-c6x.org,
        linux-ia64@vger.kernel.org, linux-mips@linux-mips.org,
        linuxppc-dev@lists.ozlabs.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, microblaze-uclinux@itee.uq.edu.au,
        shuahkhan@gmail.com, LKML <linux-kernel@vger.kernel.org>
Date:   Fri, 23 Nov 2012 14:37:54 -0700
Organization: ISS-Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-archive-position: 35106
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: shuah.khan@hp.com
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
Return-Path: <linux-mips-bounce@linux-mips.org>

Add dma-debug interface debug_dma_mapping_error() to debug drivers that fail
to check dma mapping errors on addresses returned by dma_map_single() and
dma_map_page() interfaces.

Signed-off-by: Shuah Khan <shuah.khan@hp.com>
---
 arch/tile/include/asm/dma-mapping.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/tile/include/asm/dma-mapping.h b/arch/tile/include/asm/dma-mapping.h
index 4b6247d..f2ff191 100644
--- a/arch/tile/include/asm/dma-mapping.h
+++ b/arch/tile/include/asm/dma-mapping.h
@@ -72,6 +72,7 @@ static inline bool dma_capable(struct device *dev, dma_addr_t addr, size_t size)
 static inline int
 dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
+	debug_dma_mapping_error(dev, dma_addr);
 	return get_dma_ops(dev)->mapping_error(dev, dma_addr);
 }
 
-- 
1.7.9.5
