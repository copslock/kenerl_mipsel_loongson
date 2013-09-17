Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 17 Sep 2013 10:42:08 +0200 (CEST)
Received: from elvis.franken.de ([193.175.24.41]:44988 "EHLO elvis.franken.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6816642Ab3IQImEyEUlE (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 17 Sep 2013 10:42:04 +0200
Received: from uucp (helo=solo.franken.de)
        by elvis.franken.de with local-bsmtp (Exim 3.36 #1)
        id 1VLqrE-0006pl-00; Tue, 17 Sep 2013 10:42:04 +0200
Received: by solo.franken.de (Postfix, from userid 1000)
        id ADFD45B90C7; Tue, 17 Sep 2013 10:41:26 +0200 (CEST)
Date:   Tue, 17 Sep 2013 10:41:26 +0200
From:   Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To:     "Maciej W. Rozycki" <macro@linux-mips.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: DECstation HRT calibration bug fixes
Message-ID: <20130917084126.GA9785@alpha.franken.de>
References: <alpine.LFD.2.03.1309041410160.11570@linux-mips.org>
 <20130905180825.GB11592@linux-mips.org>
 <alpine.LFD.2.03.1309052118560.11570@linux-mips.org>
 <20130907073450.GE11592@linux-mips.org>
 <alpine.LFD.2.03.1309071304090.19552@linux-mips.org>
 <alpine.LFD.2.03.1309160606110.2176@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.LFD.2.03.1309160606110.2176@linux-mips.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Return-Path: <tsbogend@alpha.franken.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37825
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tsbogend@alpha.franken.de
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

On Mon, Sep 16, 2013 at 06:54:55AM +0100, Maciej W. Rozycki wrote:
>  Thomas, what was the rationale behind arranging things in this way?  Did 
> you mean to make this code shared among platforms needing it?  I would 

I really can't remember the reasoning any more, but I guess code sharing
was a reason.

> guess so, but then the copy in arch/mips/dec/prom/ would have to be 
> removed and macros in <asm/dec/prom.h> adjusted according to the new API 
> which you didn't do in your change.

because I didn't have a running DECstation handy.

> Also why the need for stack 
> switching?  It looks like an unnecessary complication to me, any firmware 
> callbacks exported have to maintain stack integrity or they would be 
> unusable.  Is that to work around some SNI firmware quirk?

a 64bit kernel with more than CKSEG0 addressable memory may end up having
a stack outside of CKSEG0, which is something the 32bit SNI firmware
doesn't like. I guess the same is true for DECstation, if there is a HW config
with enough memory.

>  [And does it work for the SNI in the first place? -- it looks to me like 
> `o32_stk' has an alignment problem (8 is required for the stack pointer in 
> the o32 ABI though 4 will often be enough to satisfy hardware); but 
> perhaps it just happens to get correct alignment by virtue of merely 
> always following a data object that enforces it, hmm...]

it worked, but nevertheless fixing the aligment isn't a bad thing.

Thomas.

-- 
Crap can work. Given enough thrust pigs will fly, but it's not necessarily a
good idea.                                                [ RFC1925, 2.3 ]
