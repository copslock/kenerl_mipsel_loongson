Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 31 Oct 2018 15:24:17 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
	with ESMTP id S23991025AbeJaOYNSQVxt (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Wed, 31 Oct 2018 15:24:13 +0100
Date:	Wed, 31 Oct 2018 14:24:13 +0000 (GMT)
From:	"Maciej W. Rozycki" <macro@linux-mips.org>
To:	Christoph Hellwig <hch@lst.de>
cc:	iommu@lists.linux-foundation.org,
	Marek Szyprowski <m.szyprowski@samsung.com>,
	Robin Murphy <robin.murphy@arm.com>,
	Paul Burton <paul.burton@mips.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 4/6] dma-mapping: merge direct and noncoherent ops
In-Reply-To: <20180914095808.22202-5-hch@lst.de>
Message-ID: <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org>
References: <20180914095808.22202-1-hch@lst.de> <20180914095808.22202-5-hch@lst.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67011
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

Hi Christoph,

On Fri, 14 Sep 2018, Christoph Hellwig wrote:

> All the cache maintainance is already stubbed out when not enabled,
> but merging the two allows us to nicely handle the case where
> cache maintainance is required for some devices, but not others.

 FYI, you commit bc3ec75de545 ("dma-mapping: merge direct and noncoherent 
ops") has caused:

fddi0: DMA command request failed!
fddi0: Adapter open failed!

with the `defxx' driver on my R4400SC TURBOchannel DECstation (but not the 
R3400 one) and consequently the interface does not work anymore.  Both are 
non-coherent cache systems, however the R3400 implements the write-through 
policy while the policy of the R4400SC is write-back (it also has 1MiB of 
secondary cache), which I suspect is the reason of the difference.

 I'll be experimenting with this commit to figure out what the real cause 
is, but it'll take a while as my resources are limited, so I'm sending 
this early heads-up in case you or someone else has an idea what might be 
going wrong here.

  Maciej
