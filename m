Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 09 May 2003 20:08:43 +0100 (BST)
Received: from p508B7184.dip.t-dialin.net ([IPv6:::ffff:80.139.113.132]:5573
	"EHLO dea.linux-mips.net") by linux-mips.org with ESMTP
	id <S8225255AbTEITIl>; Fri, 9 May 2003 20:08:41 +0100
Received: from dea.linux-mips.net (localhost [127.0.0.1])
	by dea.linux-mips.net (8.12.8/8.12.8) with ESMTP id h49J8Rts012279;
	Fri, 9 May 2003 21:08:27 +0200
Received: (from ralf@localhost)
	by dea.linux-mips.net (8.12.8/8.12.8/Submit) id h49J8NtE012278;
	Fri, 9 May 2003 21:08:23 +0200
Date: Fri, 9 May 2003 21:08:23 +0200
From: Ralf Baechle <ralf@linux-mips.org>
To: Keith M Wesolowski <wesolows@foobazco.org>
Cc: Ladislav Michl <ladis@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] Highmem detection for Indigo2
Message-ID: <20030509190823.GA29398@linux-mips.org>
References: <20030428071639.GA7578@simek> <20030508061117.GA30191@foobazco.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030508061117.GA30191@foobazco.org>
User-Agent: Mutt/1.4.1i
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2327
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Wed, May 07, 2003 at 11:11:17PM -0700, Keith M Wesolowski wrote:

> > Following patch builds whole RAM map based of MC's memory configuration
> > registers, does some samity checks adds high system memory (if any) to
> > bootmem.
> 
> > +static void init_bootmem(void)
> ...
> > +	init_bootmem();
> 
> This is a pretty unfortunate choice of names for this function.  See
> mm/bootmem.c.
> 
> Other than that, your patch works fine for me; my Indy has 192MB
> memory and it's detected properly.  I do get an oops in do_be from
> xdm, but I get that without the patch also.
> 
> Determined physical RAM map:
>  memory: 00001000 @ 00000000 (reserved)
>  memory: 00001000 @ 00001000 (reserved)
>  memory: 001e1000 @ 08002000 (reserved)
>  memory: 0055d000 @ 081e3000 (usable)
>  memory: 000c0000 @ 08740000 (ROM data)
>  memory: 0b800000 @ 08800000 (usable)
> 
> I need to do the same kind of thing for ip32 as the ARC memory
> detection has the same shortcoming on that platform.  No sense having
> a machine support 1GB memory and only looking for 256MB of it,
> especially in a 64-bit kernel.  ARC[S] really does seem to be useless.

That's what I'm saying since '94.  ARC was a commitee approach of the
ACE consortium which soon died.  The firmware part of the ARC standard
was also published as the Microsoft Portable Bootloader Standard but
Today every ARC implementation has some major deviations from the
standard rendering the term standard into nothing but a cynic demonation ...

  Ralf
