Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Nov 2004 18:45:17 +0000 (GMT)
Received: from web81007.mail.yahoo.com ([IPv6:::ffff:206.190.37.152]:59520
	"HELO web81007.mail.yahoo.com") by linux-mips.org with SMTP
	id <S8225221AbUKNSpJ>; Sun, 14 Nov 2004 18:45:09 +0000
Message-ID: <20041114184502.41815.qmail@web81007.mail.yahoo.com>
Received: from [63.194.214.47] by web81007.mail.yahoo.com via HTTP; Sun, 14 Nov 2004 10:45:02 PST
X-RocketYMMF: pvpopov@pacbell.net
Date: Sun, 14 Nov 2004 10:45:02 -0800 (PST)
From: Pete Popov <ppopov@embeddedalley.com>
Reply-To: ppopov@embeddedalley.com
Subject: Re: GPIO on the Au1500
To: charles.eidsness@ieee.org, Gilad Rom <gilad@romat.com>
Cc: linux-mips@linux-mips.org
In-Reply-To: <41979129.1050200@ieee.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-Path: <ppopov@embeddedalley.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6328
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@embeddedalley.com
Precedence: bulk
X-list: linux-mips


--- Charles Eidsness <charles.eidsness@ieee.org>
wrote:

> Hi Gilad,
> 
> A little while ago I wrote my own GPIO driver for
> the Au1000, mainly as a learning experience. I 
> never bothered to release it because a driver 
> already exists and I thought it was working. 

It was, a long time ago, when it was written for the
Au1000. I had a user app and doc somewhere but can't
find it anymore. The driver didn't support gpio2 and
was, in general, stale. So perhaps your driver will
help Gilad.

Pete

> I'm not sure if it will 
> work on the Au1550, but if you're interested you can
> find the source 
> code here:
> 
>
http://members.rogers.com/charles.eidsness/au1000_gpio.c
>
http://members.rogers.com/charles.eidsness/au1000_gpio.h
> 
> Cheers,
> Charles
> 
> Gilad Rom wrote:
> > Thanks. Can't I just mmap /dev/mem and use the
> > GPIO offset from SYS_BASE?
> > 
> > Gilad.
> > 
> > ----- Original Message ----- From: "Pete Popov"
> <ppopov@embeddedalley.com>
> > To: "Gilad Rom" <gilad@romat.com>;
> <linux-mips@linux-mips.org>
> > Sent: Friday, November 12, 2004 8:13 PM
> > Subject: Re: GPIO on the Au1500
> > 
> > 
> >>
> >> --- Gilad Rom <gilad@romat.com> wrote:
> >>
> >>> Hello,
> >>>
> >>> I am trying to use the au1000_gpio driver, but
> I'm a
> >>> little clueless as to how it is meant to be
> used. Can I use the GPIO 
> >>> ioctl's from a userland program, or must I write
> a kernel module?
> >>
> >>
> >> I'll see if I can dig up some docs and the
> example
> >> userland program this weekend. That driver hasn't
> been
> >> tested in a while though.
> >>
> >> Pete
> >>
> >>> Thank you,
> >>> Gilad Rom
> >>> Romat Telecom
> >>>
> >>>
> >>>
> >>
> > 
> > 
> > 
> 
> 
