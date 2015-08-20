Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Aug 2015 03:10:01 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:57605 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012824AbbHTBJ7uU0tr (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 20 Aug 2015 03:09:59 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 0929414010F;
        Thu, 20 Aug 2015 11:09:56 +1000 (AEST)
Message-ID: <1440032995.13406.6.camel@ellerman.id.au>
Subject: Re: provide more common DMA API functions V2
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Andrew Morton <akpm@linux-foundation.org>, jonas@southpole.se,
        linux-ia64@vger.kernel.org, monstr@monstr.eu,
        linux@arm.linux.org.uk, ysato@users.sourceforge.jp, arnd@arndb.de,
        linux-mips@linux-mips.org, linux-sh@vger.kernel.org,
        catalin.marinas@arm.com, x86@kernel.org, will.deacon@arm.com,
        linux-kernel@vger.kernel.org, Ingo Molnar <mingo@kernel.org>,
        cmetcalf@ezchip.com, linux-alpha@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-hexagon@vger.kernel.org,
        linux-s390@vger.kernel.org, gxt@mprc.pku.edu.cn,
        linuxppc-dev@lists.ozlabs.org, Christoph Hellwig <hch@lst.de>
Date:   Thu, 20 Aug 2015 11:09:55 +1000
In-Reply-To: <20150820095233.30bb9689@canb.auug.org.au>
References: <1439795216-32189-1-git-send-email-hch@lst.de>
         <20150817142429.95a3965e0b35d0f35d3c4cfe@linux-foundation.org>
         <20150818053825.GA20771@lst.de>
         <20150817224552.43d7267d.akpm@linux-foundation.org>
         <20150818075107.GA31884@gmail.com> <20150819080814.GA18115@lst.de>
         <20150819143656.3a38eb538ffac60386e1224a@linux-foundation.org>
         <20150820095233.30bb9689@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.12.11-0ubuntu3 
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-Path: <mpe@ellerman.id.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48953
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mpe@ellerman.id.au
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

On Thu, 2015-08-20 at 09:52 +1000, Stephen Rothwell wrote:
> Hi Andrew (sorry, I can't tell who made the incorrect statement below
> that I am replying to),
> 
> On Wed, 19 Aug 2015 14:36:56 -0700 Andrew Morton <akpm@linux-foundation.org> wrote:
> >
> > On Wed, 19 Aug 2015 10:08:14 +0200 Christoph Hellwig <hch@lst.de> wrote:
> > 
> > > On Tue, Aug 18, 2015 at 09:51:07AM +0200, Ingo Molnar wrote:
> > > > I.e. shouldn't this be:
> > > > 
> > > > > I'll merge these 5 patches for 4.4.  That means I'll release them into 
> > > > > linux-next after 4.2 is released.
> > > > >
> > > > > [...]
> > > > > 
> > > > > Linus will be releasing 4.2 in 1-2 weeks and until then, linux-next is supposed 
> > > > > to contain only 4.3 material.  Once 4.2 is released and the 4.3 merge window 
> > > > > opens, linux-next is open for 4.4 material.
> 
> Just to be clear: the above should read "Once 4.2 is released and the
> 4.3 merge window *closes* (i.e. v4.3-rc1 is released), linux-next is
> open for 4.4 material".

/me registers www.whatdamnkernelversionareweuptoagain.com

cheers
