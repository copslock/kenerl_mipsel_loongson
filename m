Received:  by oss.sgi.com id <S305158AbPLFLgS>;
	Mon, 6 Dec 1999 03:36:18 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:38682 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305166AbPLFLft>;
	Mon, 6 Dec 1999 03:35:49 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id DAA27528; Mon, 6 Dec 1999 03:38:50 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA51262
	for linux-list;
	Mon, 6 Dec 1999 03:31:15 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA25646
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Dec 1999 03:31:13 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from lappi (animaniacs.conectiva.com.br [200.250.58.146]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA07236
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Dec 1999 03:31:09 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S407621AbPLFL2a>;
	Mon, 6 Dec 1999 09:28:30 -0200
Date:   Mon, 6 Dec 1999 09:28:30 -0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Linux SGI <linux@cthulhu.engr.sgi.com>
Subject: Re: Question for David Miller or anyone else about R6000 code
Message-ID: <19991206092830.C765@uni-koblenz.de>
References: <004c01bf3fd0$68336790$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <004c01bf3fd0$68336790$0ceca8c0@satanas.mips.com>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Dec 06, 1999 at 10:58:10AM +0100, Kevin D. Kissell wrote:

> I'm working on cleaning up and enhancing the
> MIPS/Linux code to support the new families
> of CPUs coming out of MIPS Technologies Inc.
> In doing so, I've come across and fixed a number
> of bugs, most of which I've also passed back to
> Ralf Baechle for integration with the moving
> target at linux.sgi.com.   But I came across 
> something this morning that, while not a problem
> for us, puzzles me.   In arch/mips/mm/r6000.c,
> which has your name on it, there is a compiler
> directive to use MIPS III instructions, and the
> resulting code does indeed end up containing
> 64-bit (daddiu, etc.) instructions.   I've never
> actually programmed an R6000, but all of the
> information I have on that processor indicates
> that it is a MIPS II, 32-bit design, and that those
> instructions should therefore cause exceptions.
> 
> Am I mistaken, or is that directive a bug?

It obviously is.  The R6000 code isn't supposed to work and given that
currently none of the Linux/MIPS hackers has a) R6000 documentation and
b) an R6000 machine an R6000 port ever happening is highly unprobable.
As the result of this I think I'm going to just burry the R6000 support
and while I'm at it also the R8000.

  Ralf
