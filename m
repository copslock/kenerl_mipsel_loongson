Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 05 Feb 2015 14:37:43 +0100 (CET)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27012224AbbBENhlXbw2X (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 5 Feb 2015 14:37:41 +0100
Date:   Thu, 5 Feb 2015 13:37:41 +0000 (GMT)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Kevin Cernekee <cernekee@chromium.org>
cc:     =?ISO-8859-15?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Oleg Kolosov <bazurbat@gmail.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Jim Quinlan <jim2101024@gmail.com>
Subject: Re: Few questions about porting Linux to SMP86xx boards
In-Reply-To: <CAJiQ=7B10R7___tMSoVsygzFbLfvpjCMyjFK6FDQQALsbpjDoA@mail.gmail.com>
Message-ID: <alpine.LFD.2.11.1502032235260.22715@eddie.linux-mips.org>
References: <54CEACC1.1040701@gmail.com> <CAJiQ=7AQuP1JsiApEs4yAR449w6-pcR_qqhSqKdpqNHL5L1mRQ@mail.gmail.com> <yw1xwq409odv.fsf@unicorn.mansr.com> <54D017D4.70200@gmail.com> <alpine.LFD.2.11.1502030930000.22715@eddie.linux-mips.org>
 <CAJiQ=7DWiSEeBUiKCPZKn8fUwxUdOrCqMLDYFTaXSMTGsJCJOA@mail.gmail.com> <yw1xsien9gna.fsf@unicorn.mansr.com> <CAJiQ=7B10R7___tMSoVsygzFbLfvpjCMyjFK6FDQQALsbpjDoA@mail.gmail.com>
User-Agent: Alpine 2.11 (LFD 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45723
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

On Tue, 3 Feb 2015, Kevin Cernekee wrote:

> >>>  With the introduction of revision 2 of the MIPS architecture the CP0
> >>> EBase register was added and consequently there is no longer a guarantee
> >>> that exception vectors reside at the base of KSEG1.  Using the value read
> >>> from CP0.EBase to determine a usable address might therefore be a better
> >>> idea, although the current revision of the MIPS architecture specification
> >>> that includes segmentation control makes it a bit complicated.  Using a
> >>> dummy page mapped uncached instead might work the best.
> >>
> >> Would something like this work, assuming __fast_iob() doesn't get
> >> called before mem_init()?
> >>
> >> CKSEG1ADDR((void *)empty_zero_page)
> >>
> >> It is currently a GPL export, so maybe that would need to change to
> >> allow non-GPL drivers to use iob().  But that's still easier than
> >> allocating another dummy page.

 You only need a mapping, not a separate page.  Maybe you can use `vmap' 
to alias a page from the kernel text -- no memory wasted then.

 And the point of segmentation is KSEG1 may not be uncached anymore, it 
may not be unmapped even.  So a virtual mapping is really the proper and 
only solution.  And this situation is another reason to avoid using 
CKSEG1ADDR and friends where possible.

 But this is more of a heads-up from me rather than a request for 
implementation as we don't support segmentation at this point.

> So there are two paths forward:
> 
> 1) Make SMP86xx behave like other currently-supported CPUs, i.e. use
> the remap registers to configure the chip so that uncached reads from
> PA 0 do something sensible.  This sounds like the easiest fix.
> 
> 2) Agree to support memory configurations where PA 0 doesn't map to
> RAM, changing __fast_iob (and maybe other code) accordingly.

 I suspect the latter is bound to happen sooner or later anyway.  However 
we handle setting CP0.EBase ourselves and we can use it to our advantage.  
So knowing that our CP0.EBase points to somewhere within KSEG0 we can make 
an example r2 `__fast_iob' implementation look like:

#define CKSEG1EBASE	((read_c0_ebase() | CKSEG1 | 0xfff) - 0xfff)

#define __fast_iob()				\
	__asm__ __volatile__(			\
		".set	push\n\t"		\
		".set	noreorder\n\t"		\
		"lw	$0,%a0\n\t"		\
		"nop\n\t"			\
		".set	pop"			\
		: /* no output */		\
		: "p" (CKSEG1EBASE)		\
		: "memory")

which at 6 instructions produced is I think the best you can get without 
using an auxiliary variable rather than CP0.EBase and then handcoding the 
whole address calculation in assembly or using indirection.

  Maciej
