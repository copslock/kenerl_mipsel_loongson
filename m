Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA82964 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 19:47:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA48474
	for linux-list;
	Fri, 17 Jul 1998 19:46:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA36468;
	Fri, 17 Jul 1998 19:45:56 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA20403; Fri, 17 Jul 1998 19:45:53 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (ralf@pmport-04.uni-koblenz.de [141.26.249.4])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id EAA19914;
	Sat, 18 Jul 1998 04:45:50 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id EAA01958;
	Sat, 18 Jul 1998 04:44:04 +0200
Message-ID: <19980718044403.F378@uni-koblenz.de>
Date: Sat, 18 Jul 1998 04:44:03 +0200
To: Greg Chesson <greg@xtp.engr.sgi.com>, Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: wje@fir.engr.sgi.com, adevries@engsoc.carleton.ca, anubis@BanjaLuka.NET,
        linux@cthulhu.engr.sgi.com
Subject: Re: What about...
References: <9807171047.ZM18720@xtp.engr.sgi.com> <m0yxF1A-000aOoC@the-village.bc.nu> <19980718033759.C378@uni-koblenz.de> <9807171858.ZM19563@xtp.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <9807171858.ZM19563@xtp.engr.sgi.com>; from Greg Chesson on Fri, Jul 17, 1998 at 06:58:07PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Jul 17, 1998 at 06:58:07PM -0700, Greg Chesson wrote:

> I think everyone is suggesting the same general path, and I'm gratified
> to know that the buddy system code anticipates non-contiguous physical
> memory.
> 
> I think you'd want to extend the design limit (XKSEG0) beyond 1 TB
> to handle the next rev of silicon.  I'd suggest 64 TB (48 bits) as
> the appropriate goal.

As far as the maximum amount of RAM goes, no problem.  The only assumption
which I make is that the entire available memory is visible in XKSEG0,
whatever it's size is.  That means the actual design limit is the maximum
possible size of XKSEG0 for the MIPS 64bit architecture which is 2^62 bytes.

I assume this also means the size limit of the XKUSEG has been extended
to 48 bits.  There we actually a somewhat more limiting design limit since
we only have three level page tables for 64 bit architectures which limits
us to a maximum mappable size of

  PAGE_SIZE * (PAGE_SIZE / sizeof(pte_t)) ^ 3

which for PAGE_SIZE = 4 kbytes and sizeof(pte_t) = 8 bytes is 512gb.

(And actually things are somewhat more complex.)

  Ralf
