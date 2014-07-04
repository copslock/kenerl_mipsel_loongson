Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Jul 2014 13:30:19 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3989 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6834666AbaGDLaQoQRmI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Jul 2014 13:30:16 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id F0B096B03DD4D;
        Fri,  4 Jul 2014 12:30:06 +0100 (IST)
Received: from KLMAIL02.kl.imgtec.org (10.40.60.222) by KLMAIL01.kl.imgtec.org
 (192.168.5.35) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 4 Jul
 2014 12:30:09 +0100
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 klmail02.kl.imgtec.org (10.40.60.222) with Microsoft SMTP Server (TLS) id
 14.3.195.1; Fri, 4 Jul 2014 12:30:08 +0100
Received: from localhost (192.168.79.111) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.195.1; Fri, 4 Jul
 2014 12:30:08 +0100
Date:   Fri, 4 Jul 2014 12:30:07 +0100
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Ed Swierk <eswierk@skyportsystems.com>,
        <linux-mips@linux-mips.org>, <ddaney.cavm@gmail.com>
Subject: Re: [PATCH v2 5/6] mips: use per-mm page to execute FP branch delay
 slots
Message-ID: <20140704113007.GA804@pburton-laptop>
References: <CAO_EM_k0Qp_VPEd2Q+WTJWsvE8cmyAuC780SwGfDxhTt_GzMeg@mail.gmail.com>
 <20140704080641.GY804@pburton-laptop>
 <20140704085246.GH13532@linux-mips.org>
 <20140704090601.GZ804@pburton-laptop>
 <20140704093809.GI13532@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20140704093809.GI13532@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [192.168.79.111]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41026
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

On Fri, Jul 04, 2014 at 11:38:09AM +0200, Ralf Baechle wrote:
> On Fri, Jul 04, 2014 at 10:06:01AM +0100, Paul Burton wrote:
> 
> > > The actual piece of code that needs to be installed is tiny.  So the page
> > > could be shared between many threads.  In fact a single page would
> > > suffice for most processes and only threads would require more slots
> > > than provided by a single page so more pags could be allocated or the
> > > process could sleep until a slot becomes available.
> > 
> > You just roughly described the v2 patch that we're replying to :)
> 
> Can't be that wrong then :-)
> 
> I seem to only have replies to that patch in my mail folder not the
> patch itself.

You can find it in patchwork if you're interested:

  http://patchwork.linux-mips.org/patch/6125/

> > > I'm also wondering how insane emulation would be.  We already have the
> > > capability to emulate a fair fraction of the instruction set.
> > 
> > Yeah, and I'm reasonably sure we're going to need some more once MIPSr6
> > is supported. I guess (perhaps only for the short term?) it could be
> > done in stages - if systems include ASEs or cop2 that the emulation
> > didn't implement then it could fall back to the current emuframe code.
> 
> And it's dependence on executable stackframe ...

...yup.

> > I'm in 2 minds about this - it sounds crazy but perhaps it's the most
> > sane option available :)
> 
> Sanity is overrated anyway ;-)

I had originally left this patch at the point I started considering
implementing emulation for the whole ISA in the kernel, figuring I was
going insane & should probably do something else for a while. Perhaps I
shouldn't worry so much ;)

Thanks,
    Paul
