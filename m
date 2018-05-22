Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2018 15:37:20 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:39232 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994737AbeEVNhLmqtJe (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 May 2018 15:37:11 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 21DF268D4A; Tue, 22 May 2018 15:42:28 +0200 (CEST)
Date:   Tue, 22 May 2018 15:42:27 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Tom Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     Christoph Hellwig <hch@lst.de>, Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: Re: status of arch/mips/jazz
Message-ID: <20180522134227.GA16716@lst.de>
References: <20180518135737.GA32605@lst.de> <20180522123510.GA5891@alpha.franken.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180522123510.GA5891@alpha.franken.de>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64000
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

On Tue, May 22, 2018 at 02:35:10PM +0200, Tom Bogendoerfer wrote:
> On Fri, May 18, 2018 at 03:57:37PM +0200, Christoph Hellwig wrote:
> > At the same time the port looks very much like bitrot given that the
> > last real JAzz commit was from Thomas in 2007.  So if there is any
> > chance to drop it, that would make my life a lot easier, if not
> > I'll accomodate it but I might need some help.
> 
> I'd like to keep it. I've started to get my qemu magnum setup working again.
> Later I'm also going to get my M700 running.
> 
> For your dma rework: How about ignoring  the vdma stuff and treat jazz like
> other non cohoherent MIPS. Then I'll implement the vdma stuff similair to
> other iommu hardware. Is this goog enough for you ?

I'm happy to implement it in the sense of writing some untested code,
I just really need testing and review feedback.

Thanks for the quick reply!
