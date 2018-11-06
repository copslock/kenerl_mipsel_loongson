Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2018 22:52:02 +0100 (CET)
Received: from emh03.mail.saunalahti.fi ([62.142.5.109]:60562 "EHLO
        emh03.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992893AbeKFVv67UWhT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2018 22:51:58 +0100
Received: from darkstar.musicnaut.iki.fi (85-76-84-88-nat.elisa-mobile.fi [85.76.84.88])
        by emh03.mail.saunalahti.fi (Postfix) with ESMTP id E996C4002C;
        Tue,  6 Nov 2018 23:51:57 +0200 (EET)
Date:   Tue, 6 Nov 2018 23:51:57 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Robin Murphy <robin.murphy@arm.com>, Rob Herring <robh@kernel.org>,
        Paul Burton <paul.burton@mips.com>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org
Subject: Re: [REGRESSION] OCTEON MMC driver failure with v4.19
Message-ID: <20181106215157.GD14958@darkstar.musicnaut.iki.fi>
References: <20181026205423.GD3792@darkstar.musicnaut.iki.fi>
 <20181105220632.GA5083@darkstar.musicnaut.iki.fi>
 <20181106062724.GA12413@lst.de>
 <20181106090511.GA14958@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181106090511.GA14958@darkstar.musicnaut.iki.fi>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67105
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

On Tue, Nov 06, 2018 at 11:05:11AM +0200, Aaro Koskinen wrote:
> On Tue, Nov 06, 2018 at 07:27:24AM +0100, Christoph Hellwig wrote:
> > On Tue, Nov 06, 2018 at 12:06:32AM +0200, Aaro Koskinen wrote:
> > > With the below change, the MMC card probe seems to with v4.19. But it
> > > feels a bit hackish, don't you think... Is there some obvious simple
> > > fix that I'm missing? Any comments?
> > 
> > Please just use dma_coerce_mask_and_coherent in the platform drivers
> > instead.
> 
> Tried, but that doesn't help with v4.19:
> 
> [    1.290698] octeon_mmc 1180000002000.mmc: dma_coerce_mask_and_coherent(): -5
> [    1.297825] octeon_mmc: probe of 1180000002000.mmc failed with error -5
> 
> A.

Just for the archives, the fix is: https://patchwork.kernel.org/patch/10670177/

A.
