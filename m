Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Nov 2012 22:32:19 +0100 (CET)
Received: from g6t0184.atlanta.hp.com ([15.193.32.61]:39231 "EHLO
        g6t0184.atlanta.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824768Ab2KWVcSV1S6x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Nov 2012 22:32:18 +0100
Received: from g5t0030.atlanta.hp.com (g5t0030.atlanta.hp.com [16.228.8.142])
        by g6t0184.atlanta.hp.com (Postfix) with ESMTP id 2D601C0F7;
        Fri, 23 Nov 2012 21:32:12 +0000 (UTC)
Received: from [10.152.0.6] (swa01cs005-da01.atlanta.hp.com [16.114.29.155])
        by g5t0030.atlanta.hp.com (Postfix) with ESMTP id BEC3214280;
        Fri, 23 Nov 2012 21:32:07 +0000 (UTC)
Message-ID: <1353706326.5270.97.camel@lorien2>
Subject: [PATCH 2/9] c6x: dma_debug: add debug_dma_mapping_error support
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
Date:   Fri, 23 Nov 2012 14:32:06 -0700
Organization: ISS-Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-archive-position: 35099
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
Acked-by: Mark Salter <msalter@redhat.com>
---
 arch/c6x/include/asm/dma-mapping.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/c6x/include/asm/dma-mapping.h b/arch/c6x/include/asm/dma-mapping.h
index 03579fd..3c69406 100644
--- a/arch/c6x/include/asm/dma-mapping.h
+++ b/arch/c6x/include/asm/dma-mapping.h
@@ -32,6 +32,7 @@ static inline int dma_set_mask(struct device *dev, u64 dma_mask)
  */
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
+	debug_dma_mapping_error(dev, dma_addr);
 	return dma_addr == ~0;
 }
 
-- 
1.7.9.5
