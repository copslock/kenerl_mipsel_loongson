Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA81088 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 18:39:41 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA21254
	for linux-list;
	Fri, 17 Jul 1998 18:39:10 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA49729;
	Fri, 17 Jul 1998 18:38:41 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA06558; Fri, 17 Jul 1998 18:38:39 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-04.uni-koblenz.de [141.26.249.4])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id DAA15447;
	Sat, 18 Jul 1998 03:38:08 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id DAA01498;
	Sat, 18 Jul 1998 03:38:00 +0200
Message-ID: <19980718033759.C378@uni-koblenz.de>
Date: Sat, 18 Jul 1998 03:37:59 +0200
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, Greg Chesson <greg@xtp.engr.sgi.com>
Cc: wje@fir.engr.sgi.com, adevries@engsoc.carleton.ca, anubis@BanjaLuka.NET,
        linux@cthulhu.engr.sgi.com
Subject: Re: What about...
References: <9807171047.ZM18720@xtp.engr.sgi.com> <m0yxF1A-000aOoC@the-village.bc.nu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <m0yxF1A-000aOoC@the-village.bc.nu>; from Alan Cox on Fri, Jul 17, 1998 at 07:14:04PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jul 17, 1998 at 07:14:04PM +0100, Alan Cox wrote:

> > many "holes"...  The idea of a simple buddy-system allocator as is
> > ingrained in the Linux kernel falls apart completely in the face of
> > this kind of architecture.   I suppose you could run a copy of Linux
> > on every node, but I consider that an excuse rather than a solution.
> 
> Actually the Linux buddy stuff is quite happy with holes. Its still
> completely inappropriate. From the above I deduce we'd have to do
> mips64 before we even considerd it anyway

At least in Vger CVS we alredy have code to efficiently deal with
non-dense memory architectures with buddy.

I think the memory allocator design as presented by Rik van Riel looks as
if it is a good base to deal much more efficiently with such an
memory architecture.  And then there is Sct with his big iron experience
working on something better than the buddy system.

I completly agree that we first have to go to MIPS64 before we really
can attack big iron problems.  The current Linux/MIPS kernel design limits
the memory to the size of KSEG0 which is 512mb.  Putting Linux into a
64bit universe we'd extend that design limit to the size of XKSEG0, or
1TB for current silicon.

  Ralf
