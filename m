Received:  by oss.sgi.com id <S305171AbPLHEdG>;
	Tue, 7 Dec 1999 20:33:06 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:14901 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305167AbPLHEci>;
	Tue, 7 Dec 1999 20:32:38 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id UAA02101; Tue, 7 Dec 1999 20:35:47 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id UAA28943
	for linux-list;
	Tue, 7 Dec 1999 20:33:07 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from hollywood.engr.sgi.com (hollywood.engr.sgi.com [150.166.61.38])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id UAA95703
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 7 Dec 1999 20:33:04 -0800 (PST)
	mail_from (owner-linux@hollywood.engr.sgi.com)
Received: from soyuz.wellington.sgi.com (soyuz.wellington.sgi.com [134.14.64.194]) by hollywood.engr.sgi.com (940816.SGI.8.6.9/960327.SGI.AUTOCF) via ESMTP id UAA24949; Tue, 7 Dec 1999 20:32:56 -0800
Received: from csd.sgi.com by soyuz.wellington.sgi.com via ESMTP (980427.SGI.8.8.8/940406.SGI)
	 id RAA80676; Wed, 8 Dec 1999 17:30:57 +1300 (NZD)
Message-ID: <384DDEF9.E3BE1F10@csd.sgi.com>
Date:   Wed, 08 Dec 1999 17:30:49 +1300
From:   Alistair Lambie <alambie@rock.csd.sgi.com>
Organization: SGI
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20 i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     fisher@sgi.com
CC:     ralf@oss.sgi.com, kevink@mips.com, linux@hollywood.engr.sgi.com,
        William Fisher <fisher@hollywood.engr.sgi.com>
Subject: Re: Question for David Miller or anyone else about R6000 code
References: <199912080313.TAA24823@hollywood.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

William Fisher wrote:
> 
> >
> > On Mon, Dec 06, 1999 at 10:58:10AM +0100, Kevin D. Kissell wrote:
> >
> > > I'm working on cleaning up and enhancing the
> > > MIPS/Linux code to support the new families
> > > of CPUs coming out of MIPS Technologies Inc.
> > > In doing so, I've come across and fixed a number
> > > of bugs, most of which I've also passed back to
> > > Ralf Baechle for integration with the moving
> > > target at linux.sgi.com.   But I came across
> > > something this morning that, while not a problem
> > > for us, puzzles me.   In arch/mips/mm/r6000.c,
> > > which has your name on it, there is a compiler
> > > directive to use MIPS III instructions, and the
> > > resulting code does indeed end up containing
> > > 64-bit (daddiu, etc.) instructions.   I've never
> > > actually programmed an R6000, but all of the
> > > information I have on that processor indicates
> > > that it is a MIPS II, 32-bit design, and that those
> > > instructions should therefore cause exceptions.
> > >
> > > Am I mistaken, or is that directive a bug?
> >
> > It obviously is.  The R6000 code isn't supposed to work and given that
> > currently none of the Linux/MIPS hackers has a) R6000 documentation and
> > b) an R6000 machine an R6000 port ever happening is highly unprobable.
> > As the result of this I think I'm going to just burry the R6000 support
> > and while I'm at it also the R8000.
> >
> >   Ralf
> >
>         Since the R6000 was an ECL machine produced in late 1992, just
>         before the MIPS/SGI merger. There were only a few machines sold
>         and the machine was designed to be a Fortran FP specialist.
> 
>         Hence the R6000 is long since dead. We still have the MIPS risc/os 5.01
>         operating system source code, so if anybody has lots of free cycles
>         to waste, I'm sure we can send them locore.
> 

Don't forget CDC used the R6000 and ramped it to 90MHz.  They also got
it going in an SMP configuration with 4 processors from what I can
remember.  I guess it is possible that someone could actually want to
burn some cycles on this, although they had better have a cheap source
of power and good airconditioning :-)

Alistair

-- 
Alistair Lambie                                alambie@csd.sgi.com
SGI Global Product Support
Level 5, Cigna House,                                M/S: INZ-3780
PO Box 24 093,                                  Ph: +64-4-494 6325
40 Mercer St, Wellington,                      Fax: +64-4-494 6321
New Zealand                                 Mobile: +64-21-635 262
