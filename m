Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Aug 2015 01:52:40 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:37723 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27010669AbbHSXwi66Ocl (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Aug 2015 01:52:38 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 1037C140562;
        Thu, 20 Aug 2015 09:52:34 +1000 (AEST)
Date:   Thu, 20 Aug 2015 09:52:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, Ingo Molnar <mingo@kernel.org>,
        arnd@arndb.de, linux@arm.linux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, ysato@users.sourceforge.jp, monstr@monstr.eu,
        jonas@southpole.se, cmetcalf@ezchip.com, gxt@mprc.pku.edu.cn,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: provide more common DMA API functions V2
Message-ID: <20150820095233.30bb9689@canb.auug.org.au>
In-Reply-To: <20150819143656.3a38eb538ffac60386e1224a@linux-foundation.org>
References: <1439795216-32189-1-git-send-email-hch@lst.de>
        <20150817142429.95a3965e0b35d0f35d3c4cfe@linux-foundation.org>
        <20150818053825.GA20771@lst.de>
        <20150817224552.43d7267d.akpm@linux-foundation.org>
        <20150818075107.GA31884@gmail.com>
        <20150819080814.GA18115@lst.de>
        <20150819143656.3a38eb538ffac60386e1224a@linux-foundation.org>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.28; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48952
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sfr@canb.auug.org.au
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

Hi Andrew (sorry, I can't tell who made the incorrect statement below
that I am replying to),

On Wed, 19 Aug 2015 14:36:56 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 19 Aug 2015 10:08:14 +0200 Christoph Hellwig <hch@lst.de> wrote:
> 
> > On Tue, Aug 18, 2015 at 09:51:07AM +0200, Ingo Molnar wrote:
> > > I.e. shouldn't this be:
> > > 
> > > > I'll merge these 5 patches for 4.4.  That means I'll release them into 
> > > > linux-next after 4.2 is released.
> > > >
> > > > [...]
> > > > 
> > > > Linus will be releasing 4.2 in 1-2 weeks and until then, linux-next is supposed 
> > > > to contain only 4.3 material.  Once 4.2 is released and the 4.3 merge window 
> > > > opens, linux-next is open for 4.4 material.

Just to be clear: the above should read "Once 4.2 is released and the
4.3 merge window *closes* (i.e. v4.3-rc1 is released), linux-next is
open for 4.4 material".

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
