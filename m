Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 17:10:57 +0200 (CEST)
Received: from localhost.localdomain ([127.0.0.1]:46815 "EHLO
        localhost.localdomain" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860908Ab3IQPKyRAYrd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 17 Sep 2013 17:10:54 +0200
Date:   Tue, 17 Sep 2013 16:10:54 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: DECstation HRT calibration bug fixes
In-Reply-To: <20130917084126.GA9785@alpha.franken.de>
Message-ID: <alpine.LFD.2.03.1309171524240.5967@linux-mips.org>
References: <alpine.LFD.2.03.1309041410160.11570@linux-mips.org> <20130905180825.GB11592@linux-mips.org> <alpine.LFD.2.03.1309052118560.11570@linux-mips.org> <20130907073450.GE11592@linux-mips.org> <alpine.LFD.2.03.1309071304090.19552@linux-mips.org>
 <alpine.LFD.2.03.1309160606110.2176@linux-mips.org> <20130917084126.GA9785@alpha.franken.de>
User-Agent: Alpine 2.03 (LFD 1266 2009-07-14)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37830
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Tue, 17 Sep 2013, Thomas Bogendoerfer wrote:

> >  Thomas, what was the rationale behind arranging things in this way?  Did 
> > you mean to make this code shared among platforms needing it?  I would 
> 
> I really can't remember the reasoning any more, but I guess code sharing
> was a reason.

 That was my guess too, so I guess two guesses are enough to be sure. ;)

> > guess so, but then the copy in arch/mips/dec/prom/ would have to be 
> > removed and macros in <asm/dec/prom.h> adjusted according to the new API 
> > which you didn't do in your change.
> 
> because I didn't have a running DECstation handy.

 Well, TBH, you could have made the same mechanical adjustments across the 
DEC files you made to your platform, or at the very least ping me (cc on 
your patch submission), especially if code sharing was your objective.

> > Also why the need for stack 
> > switching?  It looks like an unnecessary complication to me, any firmware 
> > callbacks exported have to maintain stack integrity or they would be 
> > unusable.  Is that to work around some SNI firmware quirk?
> 
> a 64bit kernel with more than CKSEG0 addressable memory may end up having
> a stack outside of CKSEG0, which is something the 32bit SNI firmware
> doesn't like. I guess the same is true for DECstation, if there is a HW config
> with enough memory.

 Nope, 480MB is the maximum the most capable in this respect DECstation 
can ever take, so it never exceeds the KSEG0 space (the remaining 32MB of 
KSEG0-mapped space is taken for MMIO; some systems also take a further 
1.5GB for aliased TURBOchannel MMIO).  Thanks for confirming.

> >  [And does it work for the SNI in the first place? -- it looks to me like 
> > `o32_stk' has an alignment problem (8 is required for the stack pointer in 
> > the o32 ABI though 4 will often be enough to satisfy hardware); but 
> > perhaps it just happens to get correct alignment by virtue of merely 
> > always following a data object that enforces it, hmm...]
> 
> it worked, but nevertheless fixing the aligment isn't a bad thing.

 OK, I think I've got a plan now.  I don't want to burden the DECstation 
with stack switching or the extra memory use it requires, so I'll reshape 
arch/mips/fw/lib/call_o32.S a bit to fit both platforms.  Will you be able 
and willing to test my code once it's ready with a SNI system?

  Maciej
