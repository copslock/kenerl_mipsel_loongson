Received:  by oss.sgi.com id <S305171AbPLHDQP>;
	Tue, 7 Dec 1999 19:16:15 -0800
Received: from sgi.SGI.COM ([192.48.153.1]:11838 "EHLO sgi.com")
	by oss.sgi.com with ESMTP id <S305167AbPLHDPv>;
	Tue, 7 Dec 1999 19:15:51 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA04496; Tue, 7 Dec 1999 19:23:15 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA95529
	for linux-list;
	Tue, 7 Dec 1999 19:13:17 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from hollywood.engr.sgi.com (hollywood.engr.sgi.com [150.166.61.38])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id TAA97680
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 7 Dec 1999 19:13:15 -0800 (PST)
	mail_from (owner-linux@hollywood.engr.sgi.com)
Received: (from fisher@localhost) by hollywood.engr.sgi.com (940816.SGI.8.6.9/960327.SGI.AUTOCF) id TAA24823; Tue, 7 Dec 1999 19:13:09 -0800
From:   fisher@hollywood.engr.sgi.com (William Fisher)
Message-Id: <199912080313.TAA24823@hollywood.engr.sgi.com>
Subject: Re: Question for David Miller or anyone else about R6000 code
To:     ralf@oss.sgi.com, kevink@mips.com
Date:   Tue, 7 Dec 1999 19:13:05 -0800 (PST)
Cc:     linux@hollywood.engr.sgi.com,
        fisher@hollywood.engr.sgi.com (William Fisher)
In-Reply-To: <19991206092830.C765@uni-koblenz.de> from "Ralf Baechle" at Dec 6, 99 09:28:30 am
Reply-To: fisher@sgi.com
X-Mailer: ELM [version 2.4 PL3]
Content-Type: text
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

> 
> On Mon, Dec 06, 1999 at 10:58:10AM +0100, Kevin D. Kissell wrote:
> 
> > I'm working on cleaning up and enhancing the
> > MIPS/Linux code to support the new families
> > of CPUs coming out of MIPS Technologies Inc.
> > In doing so, I've come across and fixed a number
> > of bugs, most of which I've also passed back to
> > Ralf Baechle for integration with the moving
> > target at linux.sgi.com.   But I came across 
> > something this morning that, while not a problem
> > for us, puzzles me.   In arch/mips/mm/r6000.c,
> > which has your name on it, there is a compiler
> > directive to use MIPS III instructions, and the
> > resulting code does indeed end up containing
> > 64-bit (daddiu, etc.) instructions.   I've never
> > actually programmed an R6000, but all of the
> > information I have on that processor indicates
> > that it is a MIPS II, 32-bit design, and that those
> > instructions should therefore cause exceptions.
> > 
> > Am I mistaken, or is that directive a bug?
> 
> It obviously is.  The R6000 code isn't supposed to work and given that
> currently none of the Linux/MIPS hackers has a) R6000 documentation and
> b) an R6000 machine an R6000 port ever happening is highly unprobable.
> As the result of this I think I'm going to just burry the R6000 support
> and while I'm at it also the R8000.
> 
>   Ralf
> 
	Since the R6000 was an ECL machine produced in late 1992, just
	before the MIPS/SGI merger. There were only a few machines sold
	and the machine was designed to be a Fortran FP specialist.

	Hence the R6000 is long since dead. We still have the MIPS risc/os 5.01
	operating system source code, so if anybody has lots of free cycles
	to waste, I'm sure we can send them locore.

-- Bill
