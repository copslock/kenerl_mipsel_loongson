Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 14:55:58 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:42846 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993514AbeGKMzw3l6ji (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jul 2018 14:55:52 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 4645468B97; Wed, 11 Jul 2018 14:57:36 +0200 (CEST)
Date:   Wed, 11 Jul 2018 14:57:36 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     "Maciej W. Rozycki" <macro@mips.com>
Cc:     Christoph Hellwig <hch@lst.de>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Huacai Chen <chenhc@lemote.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        David Daney <david.daney@cavium.com>,
        Tom Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@linux-mips.org, iommu@lists.linux-foundation.org
Subject: Re: [PATCH 12/25] MIPS: loongson: untangle dma implementations
Message-ID: <20180711125736.GA19191@lst.de>
References: <20180525092111.18516-1-hch@lst.de> <20180525092111.18516-13-hch@lst.de> <alpine.DEB.2.00.1807110407510.30992@tp.orcam.me.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1807110407510.30992@tp.orcam.me.uk>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64794
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hch@lst.de
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

On Wed, Jul 11, 2018 at 01:46:31PM +0100, Maciej W. Rozycki wrote:
> > Only loongson-3 is DMA coherent and uses swiotlb.  So move the dma
> > address translations stubs directly to the loongson-3 code, and remove
> > a few Kconfig indirections.
> 
>  SiByte should too though, at least for those boards, such as the SWARM 
> and the BigSur, that can have DRAM over 4GiB (and 32-bit PCI devices 
> plugged).

Only in this case refers to loonson boards.

>  I never got to have the wiring of swiotlb completed for these boards as 
> I got distracted with getting set up to debug a DRAM controller issue 
> observed in the form of memory data corruption with the banks fully 
> populated (which might have to do something with the parameters of bank 
> interleaving enabled in such a configuration, as replacing a single 
> module with a smaller-sized one and therefore disabling interleaving, 
> which can only work with all modules being the same size, makes the 
> problem go away).

After this series enabling swiotlb for another board is trivial as all
the code has been consolidated.  Just select SWIOTLB and add a call to
swiotlb_init to the board setup code.

> 
>  FWIW,
> 
>   Maciej
---end quoted text---
