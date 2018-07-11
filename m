Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 Jul 2018 14:39:27 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:43535 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993849AbeGKMjTaqhJi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 11 Jul 2018 14:39:19 +0200
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1fdEOr-0006mS-00; Wed, 11 Jul 2018 14:39:17 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 512D8C047A; Wed, 11 Jul 2018 14:39:04 +0200 (CEST)
Date:   Wed, 11 Jul 2018 14:39:04 +0200
From:   Tom Bogendoerfer <tsbogend@alpha.franken.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        David Daney <david.daney@cavium.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>,
        Huacai Chen <chenhc@lemote.com>,
        Paul Burton <paul.burton@mips.com>,
        iommu@lists.linux-foundation.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 21/25] MIPS: jazz: split dma mapping operations from
 dma-default
Message-ID: <20180711123904.GA9140@alpha.franken.de>
References: <20180615110854.19253-1-hch@lst.de>
 <20180615110854.19253-22-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180615110854.19253-22-hch@lst.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64792
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
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

On Fri, Jun 15, 2018 at 01:08:50PM +0200, Christoph Hellwig wrote:
> Jazz actually has a very basic IOMMU, so split the ops into a separate
> implementation from the generic default support (which is about to go
> away anyway).
> 
>  Signed-off-by: Christoph Hellwig <hch@lst.de>

Works on mips/jazz.

Tested-by: tsbogend@alpha.franken.de

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
