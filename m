Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 22 May 2018 14:35:43 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:35149 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23993577AbeEVMfgX5FFk (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 22 May 2018 14:35:36 +0200
Received: from uucp (helo=alpha)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1fL6Vs-0008MZ-00; Tue, 22 May 2018 14:35:36 +0200
Received: by alpha.franken.de (Postfix, from userid 1000)
        id 996ADC0104; Tue, 22 May 2018 14:35:10 +0200 (CEST)
Date:   Tue, 22 May 2018 14:35:10 +0200
From:   Tom Bogendoerfer <tsbogend@alpha.franken.de>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>, linux-mips@linux-mips.org
Subject: Re: status of arch/mips/jazz
Message-ID: <20180522123510.GA5891@alpha.franken.de>
References: <20180518135737.GA32605@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180518135737.GA32605@lst.de>
User-Agent: Mutt/1.5.23 (2014-03-12)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63997
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

On Fri, May 18, 2018 at 03:57:37PM +0200, Christoph Hellwig wrote:
> At the same time the port looks very much like bitrot given that the
> last real JAzz commit was from Thomas in 2007.  So if there is any
> chance to drop it, that would make my life a lot easier, if not
> I'll accomodate it but I might need some help.

I'd like to keep it. I've started to get my qemu magnum setup working again.
Later I'm also going to get my M700 running.

For your dma rework: How about ignoring  the vdma stuff and treat jazz like
other non cohoherent MIPS. Then I'll implement the vdma stuff similair to
other iommu hardware. Is this goog enough for you ?

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
