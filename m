Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Aug 2015 08:07:32 +0200 (CEST)
Received: from ozlabs.org ([103.22.144.67]:52820 "EHLO ozlabs.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006931AbbHRGHaBxhig (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Aug 2015 08:07:30 +0200
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by ozlabs.org (Postfix) with ESMTPSA id 2C2D614032E;
        Tue, 18 Aug 2015 16:07:24 +1000 (AEST)
Date:   Tue, 18 Aug 2015 16:07:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Christoph Hellwig <hch@lst.de>, arnd@arndb.de,
        linux@arm.linux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, ysato@users.sourceforge.jp, monstr@monstr.eu,
        jonas@southpole.se, cmetcalf@ezchip.com, gxt@mprc.pku.edu.cn,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: provide more common DMA API functions V2
Message-ID: <20150818160723.0569197f@canb.auug.org.au>
In-Reply-To: <20150818055315.GB20959@lst.de>
References: <1439795216-32189-1-git-send-email-hch@lst.de>
        <20150817142429.95a3965e0b35d0f35d3c4cfe@linux-foundation.org>
        <20150818053825.GA20771@lst.de>
        <20150817224552.43d7267d.akpm@linux-foundation.org>
        <20150818055315.GB20959@lst.de>
X-Mailer: Claws Mail 3.11.1 (GTK+ 2.24.28; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-Path: <sfr@canb.auug.org.au>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48930
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

Hi Andrew,

On Tue, 18 Aug 2015 07:53:15 +0200 Christoph Hellwig <hch@lst.de> wrote:
>
> On Mon, Aug 17, 2015 at 10:45:52PM -0700, Andrew Morton wrote:
> > > > 
> > > > I'll merge these 5 patches for 4.3.  That means I'll release them into
> > > > linux-next after 4.2 is released.
> > > 
> > > So you only add for-4.3 code to -next after 4.2 is odd?  Isn't thast the
> > > wrong way around?
> > 
> > Linus will be releasing 4.2 in 1-2 weeks and until then, linux-next is
> > supposed to contain only 4.2 material.  Once 4.2 is released,
> > linux-next is open for 4.3 material.
> 
> Hmm, I'm pretty sure there's tons of 4.3 material in linux-next at the
> moment, at least I got merge warning messages from Stephen about
> some yesterday.

Yeah, we are at v4.2-rc7 so linux-next is full of stuff to be merged by
Linus for v4.3. Nothing for v4.4 should be in linux-next until after
v4.3-rc1 is released in 3-4 weeks i.e. after the next merge window
closes.

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
