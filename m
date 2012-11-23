Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 23 Nov 2012 22:33:54 +0100 (CET)
Received: from g1t0027.austin.hp.com ([15.216.28.34]:32678 "EHLO
        g1t0027.austin.hp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6824768Ab2KWVdyC8GxR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 23 Nov 2012 22:33:54 +0100
Received: from g1t0039.austin.hp.com (g1t0039.austin.hp.com [16.236.32.45])
        by g1t0027.austin.hp.com (Postfix) with ESMTP id 4F2DB381B4;
        Fri, 23 Nov 2012 21:33:47 +0000 (UTC)
Received: from [10.152.0.6] (swa01cs005-da01.atlanta.hp.com [16.114.29.155])
        by g1t0039.austin.hp.com (Postfix) with ESMTP id 7D95E342C2;
        Fri, 23 Nov 2012 21:33:43 +0000 (UTC)
Message-ID: <1353706422.5270.99.camel@lorien2>
Subject: [PATCH 4/9] microblaze: dma-mapping: support debug_dma_mapping_error
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
Date:   Fri, 23 Nov 2012 14:33:42 -0700
Organization: ISS-Linux
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0
X-archive-position: 35101
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

Add support for debug_dma_mapping_error() call to avoid warning from
debug_dma_unmap() interface when it checks for mapping error checked
status. Without this patch, device driver failed to check map error
warning is generated.

Signed-off-by: Shuah Khan <shuah.khan@hp.com>
Acked-by: Michal Simek <monstr@monstr.eu>
---

This patch is already in linux-next. Including it in this series for
completeness. linux-next commit f229605441030bcd315c21d97b25889d63ed0130

-- shuah
---
 arch/microblaze/include/asm/dma-mapping.h |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/microblaze/include/asm/dma-mapping.h b/arch/microblaze/include/asm/dma-mapping.h
index 01d2282..46460f1 100644
--- a/arch/microblaze/include/asm/dma-mapping.h
+++ b/arch/microblaze/include/asm/dma-mapping.h
@@ -114,6 +114,8 @@ static inline void __dma_sync(unsigned long paddr,
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
 	struct dma_map_ops *ops = get_dma_ops(dev);
+
+	debug_dma_mapping_error(dev, dma_addr);
 	if (ops->mapping_error)
 		return ops->mapping_error(dev, dma_addr);
 
-- 
1.7.9.5
