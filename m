Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2018 12:56:07 +0100 (CET)
Received: from usa-sjc-mx-foss1.foss.arm.com ([217.140.101.70]:48788 "EHLO
        foss.arm.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990411AbeKFLyXED0ek (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2018 12:54:23 +0100
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.72.51.249])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 12A70A78;
        Tue,  6 Nov 2018 03:54:21 -0800 (PST)
Received: from e110467-lin.cambridge.arm.com (e110467-lin.cambridge.arm.com [10.1.196.75])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 468323F5CF;
        Tue,  6 Nov 2018 03:54:19 -0800 (PST)
From:   Robin Murphy <robin.murphy@arm.com>
To:     hch@lst.de, robh+dt@kernel.org
Cc:     m.szyprowski@samsung.com, aaro.koskinen@iki.fi,
        jean-philippe.brucker@arm.com, john.stultz@linaro.org,
        iommu@lists.linux-foundation.org, devicetree@vger.kernel.org,
        linux-mips@linux-mips.org, linux-arm-kernel@lists.infradead.org
Subject: [PATCH] of/device: Really only set bus DMA mask when appropriate
Date:   Tue,  6 Nov 2018 11:54:15 +0000
Message-Id: <b06321ac25a1211e572e650a630e5e1aa9f8173f.1541504601.git.robin.murphy@arm.com>
X-Mailer: git-send-email 2.19.1.dirty
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-Path: <robin.murphy@arm.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67099
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robin.murphy@arm.com
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

of_dma_configure() was *supposed* to be following the same logic as
acpi_dma_configure() and only setting bus_dma_mask if some range was
specified by the firmware. However, it seems that subtlety got lost in
the process of fitting it into the differently-shaped control flow, and
as a result the force_dma==true case ends up always setting the bus mask
to the 32-bit default, which is not what anyone wants.

Make sure we only touch it if the DT actually said so.

Fixes: 6c2fb2ea7636 ("of/device: Set bus DMA mask as appropriate")
Reported-by: Aaro Koskinen <aaro.koskinen@iki.fi>
Reported-by: Jean-Philippe Brucker <jean-philippe.brucker@arm.com>
Signed-off-by: Robin Murphy <robin.murphy@arm.com>
---

Sorry about that... I guess I only have test setups that either have
dma-ranges or where a 32-bit bus mask goes unnoticed :(

The Octeon and SMMU issues sound like they're purely down to this, and
it's probably related to at least one of John's Hikey woes.

Robin.

 drivers/of/device.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 0f27fad9fe94..757ae867674f 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -149,7 +149,8 @@ int of_dma_configure(struct device *dev, struct device_node *np, bool force_dma)
 	 * set by the driver.
 	 */
 	mask = DMA_BIT_MASK(ilog2(dma_addr + size - 1) + 1);
-	dev->bus_dma_mask = mask;
+	if (!ret)
+		dev->bus_dma_mask = mask;
 	dev->coherent_dma_mask &= mask;
 	*dev->dma_mask &= mask;
 
-- 
2.19.1.dirty
