Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Nov 2018 15:32:07 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S23991034AbeKAOae1ajmS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Nov 2018 15:30:34 +0100
Date:   Thu, 1 Nov 2018 14:30:34 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Christoph Hellwig <hch@lst.de>
cc:     Paul Burton <paul.burton@mips.com>,
        iommu@lists.linux-foundation.org,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: Fix `dma_alloc_coherent' returning a non-coherent
 allocation
In-Reply-To: <20181101083346.GA7136@lst.de>
Message-ID: <alpine.LFD.2.21.1811011405530.20378@eddie.linux-mips.org>
References: <20180914095808.22202-1-hch@lst.de> <20180914095808.22202-5-hch@lst.de> <alpine.LFD.2.21.1810311414200.20378@eddie.linux-mips.org> <alpine.LFD.2.21.1810311559590.20378@eddie.linux-mips.org> <20181031203206.GA28337@lst.de>
 <alpine.LFD.2.21.1810312043250.20378@eddie.linux-mips.org> <20181101051359.GA4164@lst.de> <alpine.LFD.2.21.1811010523440.20378@eddie.linux-mips.org> <20181101083346.GA7136@lst.de>
User-Agent: Alpine 2.21 (LFD 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 67029
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

On Thu, 1 Nov 2018, Christoph Hellwig wrote:

> Oops, yes this looks good:

 BTW, for anyone missing hardware suitable for serious DMA testing I can 
recommend getting a pair of DEFPA cards, the ubiquitous PCI version of 
this board, cheaply available, which is the same except for a different 
host bus bridge ASIC, developed later.  They can be wired back to back 
similarly to Ethernet adapters (or in a loop if you have 2 or more dual 
attachment versions), no other hardware is required save for patch cords.
Version 3 (DEFPA-xC) boards support universal PCI signalling, older ones 
are 5V-only.

 These devices are a stellar example of fine engineering[1].  Our `defxx' 
driver, which I believe has been adapted from the DEC OSF/1 one referred 
in the said document, has some latency and other issues that I plan to 
address sometime, once I have sorted higher-priority issues, however 
hardware itself is excellent.

References:

[1] Chran-Ham Chang et al., "High-performance TCP/IP and UDP/IP Networking 
    in DEC OSF/1 for Alpha AXP", Digital Technical Journal, vol. 5, no. 1 
    (Winter 1993), "Network Adapter Characteristics", p. 7
    <ftp://ftp.linux-mips.org/pub/linux/mips/people/macro/DEC/DTJ/DTJ904/DTJ904PF.PDF>

  Maciej
