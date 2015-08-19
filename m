Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Aug 2015 10:08:17 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:59557 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010644AbbHSIIQCEGOg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 19 Aug 2015 10:08:16 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id B4750691F8; Wed, 19 Aug 2015 10:08:14 +0200 (CEST)
Date:   Wed, 19 Aug 2015 10:08:14 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Hellwig <hch@lst.de>, arnd@arndb.de,
        linux@arm.linux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, ysato@users.sourceforge.jp, monstr@monstr.eu,
        jonas@southpole.se, cmetcalf@ezchip.com, gxt@mprc.pku.edu.cn,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: provide more common DMA API functions V2
Message-ID: <20150819080814.GA18115@lst.de>
References: <1439795216-32189-1-git-send-email-hch@lst.de> <20150817142429.95a3965e0b35d0f35d3c4cfe@linux-foundation.org> <20150818053825.GA20771@lst.de> <20150817224552.43d7267d.akpm@linux-foundation.org> <20150818075107.GA31884@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150818075107.GA31884@gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48941
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

On Tue, Aug 18, 2015 at 09:51:07AM +0200, Ingo Molnar wrote:
> I.e. shouldn't this be:
> 
> > I'll merge these 5 patches for 4.4.  That means I'll release them into 
> > linux-next after 4.2 is released.
> >
> > [...]
> > 
> > Linus will be releasing 4.2 in 1-2 weeks and until then, linux-next is supposed 
> > to contain only 4.3 material.  Once 4.2 is released and the 4.3 merge window 
> > opens, linux-next is open for 4.4 material.
> 
> ?

That would make a lot more sense.  But also be said as I intended
these as the simple part of the dma work I'd like to get into 4.3.

Andrew, if you think it's not 4.3 material I'd rather keep them in
my git tree for now so that I can stack additional patches I have
in progress on top.  A non-git based tree like yours is unfortunately
very bad for patches that are dependencies for others.
