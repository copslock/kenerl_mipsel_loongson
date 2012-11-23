Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Nov 2012 22:36:47 +0100 (CET)
Received: from g1t0029.austin.hp.com ([15.216.28.36]:39873 "EHLO
        g1t0029.austin.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6825659Ab2KWVgqNwNM- (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Nov 2012 22:36:46 +0100
Received: from g1t0038.austin.hp.com (g1t0038.austin.hp.com [16.236.32.44])
        by g1t0029.austin.hp.com (Postfix) with ESMTP id 9623C3814F;
        Fri, 23 Nov 2012 21:36:38 +0000 (UTC)
Received: from [10.152.0.6] (swa01cs005-da01.atlanta.hp.com [16.114.29.155])
        by g1t0038.austin.hp.com (Postfix) with ESMTP id D84C7300B9;
        Fri, 23 Nov 2012 21:36:34 +0000 (UTC)
Message-ID: <1353706593.5270.103.camel@lorien2>
Subject: [PATCH 7/9] sh: dma_debug: add debug_dma_mapping_error support
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
Date:   Fri, 23 Nov 2012 14:36:33 -0700
Organization: ISS-Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-archive-position: 35104
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
 arch/sh/include/asm/dma-mapping.h |    1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sh/include/asm/dma-mapping.h b/arch/sh/include/asm/dma-mapping.h
index 8bd965e..b437f2c 100644
--- a/arch/sh/include/asm/dma-mapping.h
+++ b/arch/sh/include/asm/dma-mapping.h
@@ -46,6 +46,7 @@ static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
 
+	debug_dma_mapping_error(dev, dma_addr);
 	if (ops->mapping_error)
 		return ops->mapping_error(dev, dma_addr);
 
-- 
1.7.9.5
