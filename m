Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Aug 2015 07:53:27 +0200 (CEST)
Received: from verein.lst.de ([213.95.11.211]:55078 "EHLO newverein.lst.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006931AbbHRFx0A0COg (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 18 Aug 2015 07:53:26 +0200
Received: by newverein.lst.de (Postfix, from userid 2407)
        id 81BE4691E9; Tue, 18 Aug 2015 07:53:15 +0200 (CEST)
Date:   Tue, 18 Aug 2015 07:53:15 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     arnd@arndb.de, linux@arm.linux.org.uk, catalin.marinas@arm.com,
        will.deacon@arm.com, ysato@users.sourceforge.jp, monstr@monstr.eu,
        jonas@southpole.se, cmetcalf@ezchip.com, gxt@mprc.pku.edu.cn,
        x86@kernel.org, linux-alpha@vger.kernel.org,
        linux-hexagon@vger.kernel.org, linux-ia64@vger.kernel.org,
        linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
        linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
        sparclinux@vger.kernel.org, linux-kernel@vger.kernel.org,
        sfr@canb.auug.org.au
Subject: Re: provide more common DMA API functions V2
Message-ID: <20150818055315.GB20959@lst.de>
References: <1439795216-32189-1-git-send-email-hch@lst.de> <20150817142429.95a3965e0b35d0f35d3c4cfe@linux-foundation.org> <20150818053825.GA20771@lst.de> <20150817224552.43d7267d.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20150817224552.43d7267d.akpm@linux-foundation.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Return-Path: <hch@lst.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48929
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

On Mon, Aug 17, 2015 at 10:45:52PM -0700, Andrew Morton wrote:
> > > 
> > > I'll merge these 5 patches for 4.3.  That means I'll release them into
> > > linux-next after 4.2 is released.
> > 
> > So you only add for-4.3 code to -next after 4.2 is odd?  Isn't thast the
> > wrong way around?
> 
> Linus will be releasing 4.2 in 1-2 weeks and until then, linux-next is
> supposed to contain only 4.2 material.  Once 4.2 is released,
> linux-next is open for 4.3 material.

Hmm, I'm pretty sure there's tons of 4.3 material in linux-next at the
moment, at least I got merge warning messages from Stephen about
some yesterday.
