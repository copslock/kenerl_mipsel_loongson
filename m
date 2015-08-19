Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 19 Aug 2015 23:37:06 +0200 (CEST)
Received: from mail.linuxfoundation.org ([140.211.169.12]:49198 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012920AbbHSVhDnqJvU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 19 Aug 2015 23:37:03 +0200
Received: from akpm3.mtv.corp.google.com (unknown [216.239.45.65])
        by mail.linuxfoundation.org (Postfix) with ESMTPSA id D53AC902;
        Wed, 19 Aug 2015 21:36:56 +0000 (UTC)
Date:   Wed, 19 Aug 2015 14:36:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     Ingo Molnar <mingo@kernel.org>, arnd@arndb.de,
        linux@arm.linux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, ysato@users.sourceforge.jp, monstr@monstr.eu,
        jonas@southpole.se, cmetcalf@ezchip.com, gxt@mprc.pku.edu.cn,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: provide more common DMA API functions V2
Message-Id: <20150819143656.3a38eb538ffac60386e1224a@linux-foundation.org>
In-Reply-To: <20150819080814.GA18115@lst.de>
References: <1439795216-32189-1-git-send-email-hch@lst.de>
        <20150817142429.95a3965e0b35d0f35d3c4cfe@linux-foundation.org>
        <20150818053825.GA20771@lst.de>
        <20150817224552.43d7267d.akpm@linux-foundation.org>
        <20150818075107.GA31884@gmail.com>
        <20150819080814.GA18115@lst.de>
X-Mailer: Sylpheed 3.4.1 (GTK+ 2.24.23; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <akpm@linux-foundation.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48951
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: akpm@linux-foundation.org
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

On Wed, 19 Aug 2015 10:08:14 +0200 Christoph Hellwig <hch@lst.de> wrote:

> On Tue, Aug 18, 2015 at 09:51:07AM +0200, Ingo Molnar wrote:
> > I.e. shouldn't this be:
> > 
> > > I'll merge these 5 patches for 4.4.  That means I'll release them into 
> > > linux-next after 4.2 is released.
> > >
> > > [...]
> > > 
> > > Linus will be releasing 4.2 in 1-2 weeks and until then, linux-next is supposed 
> > > to contain only 4.3 material.  Once 4.2 is released and the 4.3 merge window 
> > > opens, linux-next is open for 4.4 material.
> > 
> > ?
> 
> That would make a lot more sense.  But also be said as I intended
> these as the simple part of the dma work I'd like to get into 4.3.
> 
> Andrew, if you think it's not 4.3 material I'd rather keep them in
> my git tree for now so that I can stack additional patches I have
> in progress on top.  A non-git based tree like yours is unfortunately
> very bad for patches that are dependencies for others.

I think these will be OK for 4.3.  It's all quiet so far and any
problems will probably show up at compile time so they'll get fixed
promptly.
