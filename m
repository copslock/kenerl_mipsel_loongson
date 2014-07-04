Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2014 11:06:14 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:11776 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6817535AbaGDJGKd1L5K (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jul 2014 11:06:10 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 7E80C2CCC1A06;
        Fri,  4 Jul 2014 10:06:01 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.10.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 4 Jul
 2014 10:06:03 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.10.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 4 Jul 2014 10:06:03 +0100
Received: from localhost (192.168.79.111) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 4 Jul
 2014 10:06:02 +0100
Date:   Fri, 4 Jul 2014 10:06:01 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Ed Swierk <eswierk@skyportsystems.com>,
        <linux-mips@linux-mips.org>, <ddaney.cavm@gmail.com>
Subject: Re: [PATCH v2 5/6] mips: use per-mm page to execute FP branch delay
 slots
Message-ID: <20140704090601.GZ804@pburton-laptop>
References: <CAO_EM_k0Qp_VPEd2Q+WTJWsvE8cmyAuC780SwGfDxhTt_GzMeg@mail.gmail.com>
 <20140704080641.GY804@pburton-laptop>
 <20140704085246.GH13532@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20140704085246.GH13532@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.79.111]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41018
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Fri, Jul 04, 2014 at 10:52:46AM +0200, Ralf Baechle wrote:
> On Fri, Jul 04, 2014 at 09:06:41AM +0100, Paul Burton wrote:
> 
> > Yes, I think it would. The reason I went with the per-mm approach though
> > was to try to avoid so much overhead. I suppose we could possibly
> > allocate the page on demand so that threads which don't use FP don't pay
> > for it, and maybe use the shrinker interface to free the page if we run
> > low on memory and aren't currently executing from it. Though it would
> > mean that the FP branch delay "emulation" could fail if memory is tight,
> > but I suppose that's no worse than now where it could blow the (user)
> > stack.
> > 
> > I'll try to get a v3 out at some point soon.
> 
> The actual piece of code that needs to be installed is tiny.  So the page
> could be shared between many threads.  In fact a single page would
> suffice for most processes and only threads would require more slots
> than provided by a single page so more pags could be allocated or the
> process could sleep until a slot becomes available.

You just roughly described the v2 patch that we're replying to :)

The problem is how to reliably free the frame after it has been used.
I can see ways to do it, but none that are particularly "nice".

> Assuming the smallest supported page size of 4k and slots of 128 bytes
> (that is the largest S-cache line size in common use) that's 32 slots.

Why S-cache line sized slots? I suppose it could simplify updating the
page slightly at the cost of space.

> I'm also wondering how insane emulation would be.  We already have the
> capability to emulate a fair fraction of the instruction set.

Yeah, and I'm reasonably sure we're going to need some more once MIPSr6
is supported. I guess (perhaps only for the short term?) it could be
done in stages - if systems include ASEs or cop2 that the emulation
didn't implement then it could fall back to the current emuframe code.

I'm in 2 minds about this - it sounds crazy but perhaps it's the most
sane option available :)

Paul
