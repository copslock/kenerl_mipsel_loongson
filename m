Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2018 17:31:45 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23991025AbeJaQbkPiy6m (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2018 17:31:40 +0100
Date:	Wed, 31 Oct 2018 16:31:40 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Christoph Hellwig <hch@lst.de>
cc:	iommu@lists.linux-foundation.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Burton <paul.burton@mips.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dma-mapping: merge direct and noncoherent ops
In-Reply-To: <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org>
Message-ID: <alpine.LFD.2.21.1810311559590.20378@eddie.linux-mips.org>
References: <20180914095808.22202-1-hch@lst.de> <20180914095808.22202-5-hch@lst.de> <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67012
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Wed, 31 Oct 2018, Maciej W. Rozycki wrote:

> > All the cache maintainance is already stubbed out when not enabled,
> > but merging the two allows us to nicely handle the case where
> > cache maintainance is required for some devices, but not others.
> 
>  FYI, you commit bc3ec75de545 ("dma-mapping: merge direct and noncoherent 
> ops") has caused:
> 
> fddi0: DMA command request failed!
> fddi0: Adapter open failed!
> 
> with the `defxx' driver on my R4400SC TURBOchannel DECstation (but not the 
> R3400 one) and consequently the interface does not work anymore.  Both are 
> non-coherent cache systems, however the R3400 implements the write-through 
> policy while the policy of the R4400SC is write-back (it also has 1MiB of 
> secondary cache), which I suspect is the reason of the difference.

 Doh!  It would have helped if I actually had the right adapter installed 
in the R3400 box.  I've got a spare one, which I have now plugged in there 
and the R3400 actually shows the same issue as the R4400SC does.  So this 
has nothing to do WRT write-through vs write-back.

 Hmm, in `dfx_hw_dma_cmd_req' the driver polls the consumer block (which 
is write-only by the adapter and read-only by the host, except for the 
initialisation time before adapter's DMA engines have been started, and 
write-through vs write-back indeed does not matter for this kind of use) 
and there's no DMA synchronisation whatsoever in that.

 However the block has been allocated with `dma_zalloc_coherent', which 
means no synchronisation is supposed to be required.  For non-coherent 
cache systems that essentially means an uncached memory allocation.

  Maciej
