Received:  by oss.sgi.com id <S305167AbQDQV1I>;
	Mon, 17 Apr 2000 14:27:08 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:33878 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305161AbQDQV05>;
	Mon, 17 Apr 2000 14:26:57 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA24907; Mon, 17 Apr 2000 14:22:12 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA01993
	for linux-list;
	Mon, 17 Apr 2000 14:14:47 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from dhcp-163-154-5-221.engr.sgi.com (dhcp-163-154-5-221.engr.sgi.com [163.154.5.221])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA91693
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 17 Apr 2000 14:14:46 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received:  by lappi.waldorf-gmbh.de id <S1406016AbQDQVLk>;
	Mon, 17 Apr 2000 14:11:40 -0700
Date:   Mon, 17 Apr 2000 14:11:40 -0700
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Michael Engel <engel@math.uni-siegen.de>
Cc:     linux@cthulhu.engr.sgi.com
Subject: Re: Indigo R3000 PROM calls /
Message-ID: <20000417141140.A3123@uni-koblenz.de>
References: <200004162112.XAA02036@jordan.numerik.math.uni-siegen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200004162112.XAA02036@jordan.numerik.math.uni-siegen.de>; from engel@math.uni-siegen.de on Sun, Apr 16, 2000 at 11:12:02PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Sun, Apr 16, 2000 at 11:12:02PM +0200, Michael Engel wrote:

> I had some time over the weekend and started to hack on Linux for my
> good old R3000 Indigo (oh yeah, I should better try to write drivers
> for the PMAG-F and the FDDI adapter in my DECstations but Indigo 
> hacking seemed to be more fun ;-)). I can load the kernel from sash 
> and it actually starts at kernel_entry (whow) and - no wonder - crashes 
> somewhere in init_arch (because I didn't change anything there ...).
> 
> Now, it would of course be nice to have some kind of debugging output
> early on. Does anyone know if the R3k Indigo has the same ARCS console 
> semantics as the Indy ? I.e. there is a PROMBLOCK struct at address 
> 0xa0001000 (as defined in include/asm-mips/sgiarcs.h) which points to 
> romvec which I can then use to dereference PROM functions ? Or is it 
> something completely different ? 

Check out include/asm-mips/mipsprom.h, it should be fairly close to what
you're looking for.  SGI used two different PROM styles for their machines,
those with 64-bit CPUs are ARCS, the older machines have another
firmware implementation.  I do have some tested code for this platform
but it's back at home while I'm here at SGI ...

> Of course, if someone unexpectedly finds some Indigo R3k hardware docs 
> somewhere, I'd appreciate it ;).

A few power series systems are the oldest stuff that I've seen over here
at SGI and even are mostly used as hightech door stops ...

  Ralf
