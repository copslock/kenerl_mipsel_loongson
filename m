Received:  by oss.sgi.com id <S305252AbQD2W17>;
	Sat, 29 Apr 2000 15:27:59 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:40265 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305163AbQD2W1p>;
	Sat, 29 Apr 2000 15:27:45 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA13874; Sat, 29 Apr 2000 15:22:58 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA40025
	for linux-list;
	Sat, 29 Apr 2000 15:22:17 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA58173
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 29 Apr 2000 15:22:15 -0700 (PDT)
	mail_from (nick@ns.snowman.net)
From:   nick@ns.snowman.net
Received: from ns.snowman.net (ns.snowman.net [63.80.4.34]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA06756
	for <linux@cthulhu.engr.sgi.com>; Sat, 29 Apr 2000 15:22:10 -0700 (PDT)
	mail_from (nick@ns.snowman.net)
Received: from localhost (nick@localhost)
	by ns.snowman.net (8.9.1a/8.9.0) with ESMTP id SAA04205;
	Sat, 29 Apr 2000 18:33:55 -0400
Date:   Sat, 29 Apr 2000 18:33:54 -0400 (EDT)
To:     Ralf Baechle <ralf@oss.sgi.com>
cc:     Florian Lohoff <flo@rfc822.org>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: VC exceptions
In-Reply-To: <20000429071807.A491@uni-koblenz.de>
Message-ID: <Pine.LNX.4.05.10004291833360.3830-100000@ns.snowman.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

What is a r7000?  I've heard of the r8000, is that the same?
	Nick

On Sat, 29 Apr 2000, Ralf Baechle wrote:

> On Thu, Apr 27, 2000 at 04:58:03PM +0200, Florian Lohoff wrote:
> 
> > i had a conversation with Harald concerning a "strong" time drift
> > on my R4000 Decstation. He than was astonished on the large
> > number of VCE.
> 
> > On a medium loaded machine i see 40-50 VCEDs per second.
> 
> VCE isn't related to timekeeping and only may delay interrupts minimally;
> they're very lightweight.  In fact keeping the VCE statistics makes a
> significant part of the overhead.  So while the number of VCEs may look
> high the total price is not too bad.
> 
> > As a resume - The exception is taken when the index of the 1st and
> > the 2nd level cache are not identical - Right ?
> > So - why is there a mismatch ? Might it be due to some invalidation
> > of the 1st (and not the 2nd) level cache ?
> > 
> > As the exception is taken quiet often and the "Mips Risc Architecture" states
> > "Software can avoid the cost of this trap by using constistent virtual
> > primary cache indexes to access the same physical data".
> 
> Attached a small test program that generates a large number of vced exceptions.
> It's causing aliases with the page cache and these are not covered by my
> patch.
> 
> > Currently i dont think whats the exact cause of this exception and
> > a probably optimization which brings this down.
> 
> The easiest part of the solution is choosing apropriate addresses for all
> memory mappings without forced addresses, that is mmap(2) and mmap2(2)
> without MAP_FIXED.  A patch which fixes this part of the problem is attached.
> 
> This patch does not fix other types of aliases like mmap(2) and mmap2(2)
> with MAP_FIXED or aliases between multiple mappings out of the page cache.
> 
> Users of R2000 / R3000 / R7000 / R10000 CPUs can ignore this whole thread,
> those CPUs don't have such incredibly f*cked caches.
> 
>   Ralf
> 
