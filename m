Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2014 11:38:14 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:44665 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6856084AbaGDJiM56Kgi (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 4 Jul 2014 11:38:12 +0200
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.14.7/8.14.4) with ESMTP id s649c9SN007669;
        Fri, 4 Jul 2014 11:38:09 +0200
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.14.7/8.14.7/Submit) id s649c9xx007668;
        Fri, 4 Jul 2014 11:38:09 +0200
Date:   Fri, 4 Jul 2014 11:38:09 +0200
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     Ed Swierk <eswierk@skyportsystems.com>, linux-mips@linux-mips.org,
        ddaney.cavm@gmail.com
Subject: Re: [PATCH v2 5/6] mips: use per-mm page to execute FP branch delay
 slots
Message-ID: <20140704093809.GI13532@linux-mips.org>
References: <CAO_EM_k0Qp_VPEd2Q+WTJWsvE8cmyAuC780SwGfDxhTt_GzMeg@mail.gmail.com>
 <20140704080641.GY804@pburton-laptop>
 <20140704085246.GH13532@linux-mips.org>
 <20140704090601.GZ804@pburton-laptop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20140704090601.GZ804@pburton-laptop>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41020
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Fri, Jul 04, 2014 at 10:06:01AM +0100, Paul Burton wrote:

> > The actual piece of code that needs to be installed is tiny.  So the page
> > could be shared between many threads.  In fact a single page would
> > suffice for most processes and only threads would require more slots
> > than provided by a single page so more pags could be allocated or the
> > process could sleep until a slot becomes available.
> 
> You just roughly described the v2 patch that we're replying to :)

Can't be that wrong then :-)

I seem to only have replies to that patch in my mail folder not the
patch itself.

> The problem is how to reliably free the frame after it has been used.
> I can see ways to do it, but none that are particularly "nice".
> 
> > Assuming the smallest supported page size of 4k and slots of 128 bytes
> > (that is the largest S-cache line size in common use) that's 32 slots.
> 
> Why S-cache line sized slots? I suppose it could simplify updating the
> page slightly at the cost of space.

That's to handle the worst case - R4000/R4400 SC and MC variants it is
possible to split the S-cache as SI-cache and SD-cache.  That means
modified instructions need to be written back all the way to memory
otherwise potencially stale instructions might be fetched from the
SI-cache.

That's more theoretical - I'm not aware of any system that's using split
S-caches.  Still using S-cache line sized slots might reduce the cache
line ping pong on multi-core systems a bit.

> > I'm also wondering how insane emulation would be.  We already have the
> > capability to emulate a fair fraction of the instruction set.
> 
> Yeah, and I'm reasonably sure we're going to need some more once MIPSr6
> is supported. I guess (perhaps only for the short term?) it could be
> done in stages - if systems include ASEs or cop2 that the emulation
> didn't implement then it could fall back to the current emuframe code.

And it's dependence on executable stackframe ...

> I'm in 2 minds about this - it sounds crazy but perhaps it's the most
> sane option available :)

Sanity is overrated anyway ;-)

  Ralf
