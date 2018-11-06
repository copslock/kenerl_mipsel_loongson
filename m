Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2018 10:06:06 +0100 (CET)
Received: from emh06.mail.saunalahti.fi ([62.142.5.116]:44936 "EHLO
        emh06.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992824AbeKFJFMzBMIK (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2018 10:05:12 +0100
Received: from darkstar.musicnaut.iki.fi (85-76-96-200-nat.elisa-mobile.fi [85.76.96.200])
        by emh06.mail.saunalahti.fi (Postfix) with ESMTP id B3B6F30133;
        Tue,  6 Nov 2018 11:05:11 +0200 (EET)
Date:   Tue, 6 Nov 2018 11:05:11 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] OCTEON MMC driver failure with v4.19
Message-ID: <20181106090511.GA14958@darkstar.musicnaut.iki.fi>
References: <20181026205423.GD3792@darkstar.musicnaut.iki.fi>
 <20181105220632.GA5083@darkstar.musicnaut.iki.fi>
 <20181106062724.GA12413@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106062724.GA12413@lst.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67098
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Tue, Nov 06, 2018 at 07:27:24AM +0100, Christoph Hellwig wrote:
> On Tue, Nov 06, 2018 at 12:06:32AM +0200, Aaro Koskinen wrote:
> > With the below change, the MMC card probe seems to with v4.19. But it
> > feels a bit hackish, don't you think... Is there some obvious simple
> > fix that I'm missing? Any comments?
> 
> Please just use dma_coerce_mask_and_coherent in the platform drivers
> instead.

Tried, but that doesn't help with v4.19:

[    1.290698] octeon_mmc 1180000002000.mmc: dma_coerce_mask_and_coherent(): -5
[    1.297825] octeon_mmc: probe of 1180000002000.mmc failed with error -5

A.

diff --git a/drivers/mmc/host/cavium-octeon.c b/drivers/mmc/host/cavium-octeon.c
index 22aded1065ae..f7ce26ba6936 100644
--- a/drivers/mmc/host/cavium-octeon.c
+++ b/drivers/mmc/host/cavium-octeon.c
@@ -232,7 +232,8 @@ static int octeon_mmc_probe(struct platform_device *pdev)
 	 */
 	host->reg_off_dma = -0x20;
 
-	ret = dma_set_mask(&pdev->dev, DMA_BIT_MASK(64));
+	ret = dma_coerce_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	dev_err(&pdev->dev, "dma_coerce_mask_and_coherent(): %d", ret);
 	if (ret)
 		return ret;
 
