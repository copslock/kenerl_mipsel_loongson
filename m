Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f7OHUrb19275
	for linux-mips-outgoing; Fri, 24 Aug 2001 10:30:53 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f7OHUod19257
	for <linux-mips@oss.sgi.com>; Fri, 24 Aug 2001 10:30:50 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f7OHYBA26253;
	Fri, 24 Aug 2001 10:34:11 -0700
Message-ID: <3B868D96.18520607@mvista.com>
Date: Fri, 24 Aug 2001 10:23:34 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: "Gleb O. Raiko" <raiko@niisi.msk.ru>
CC: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux 2.4.5: Export mips_machtype
References: <Pine.GSO.3.96.1010823192712.21718H-100000@delta.ds2.pg.gda.pl> <3B86206C.832A9801@niisi.msk.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"Gleb O. Raiko" wrote:
> 
> "Maciej W. Rozycki" wrote:
> >  It sounds reasonable.  We may also check the Alpha port for solutions --
> > it supports multiple dissimilar systems as well.
> 
> Alpha is easy and simple from my POV, it has just SRM or MILO, kernel at
> fixed location anyway.
> 
> In our case, almost every box has own location for kernel varying from
> 0x80000000 for brave people to 0x80100000 for people who doesn't care
> much about 1 MB :-). (Well, I clearly understand it's firmware
> requirements, not people's preferences. Almost.) Then, various binary
> formats of the kernel image...
> 
> I personally prefer PPC with its _machine tricks and SPARC for BTFIXUP
> stuff.
> 
> However, I doubt whether we could support single kernel image for all
> MIPS boxes. MIPS is typical embedded platform, where standards are
> favourite because there are so many to choose from.
> 

No way to support all MIPS machines with a single kernel image - you have the
difference of BE and LE at least. :-)

Seriously, I found two cases where we do like to have one image supporting
multiple boards:

1) several CPU daughter boards plugging into one base baord - in the case we
really need to configure a kernel with multipe CPUs.

2) A reference design board is modified slightly and used in other products. 
- A typicaly change might be in interrupt routing, or some base address shift,
or removing some IOs.  In this case, we just need a slightly different board
setuo() function for each board.

I don't think it is fruitful trying to go to the extreme by having a single
image serving as many boxes as possible.

> BTW, I remember, Ralf tried to implement CPU type recognition at
> run-time, he dropped his efforts after he realized nobody could use this
> feature because boxes are so different.
>

CPU code is getting more crowded and uglier these days too, because more
vendors are adding their own CPUs.  Each CPU, in most cases, has its unique
hazards, which requires a separate low-level routines.  Even with the coming
MIPS32 and MIPS64 standard, we cannot count on vendors have totally conforming
CPUs.  I think it is about time to create a CPU abstraction which allows more
individualism.
 
Jun
