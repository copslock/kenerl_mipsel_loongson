Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA93916 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Apr 1999 15:09:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA56332
	for linux-list;
	Thu, 15 Apr 1999 15:08:00 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from lappi.waldorf-gmbh.de ([150.166.40.201])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA08168;
	Thu, 15 Apr 1999 15:07:30 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id PAA04427;
	Thu, 15 Apr 1999 15:07:18 -0700
Message-ID: <19990415150718.B524@uni-koblenz.de>
Date: Thu, 15 Apr 1999 15:07:18 -0700
From: Ralf Baechle <ralfb@cthulhu.engr.sgi.com>
To: Andreas Jaeger <aj@arthur.rhein-neckar.de>,
        Ulf Carlsson <ulfc@bun.falkenberg.se>
Cc: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: glibc 2.1
References: <Pine.LNX.3.96.990414213802.29768C-100000@lager.engsoc.carleton.ca> <19990415091041.A3402@ruvild.bun.falkenberg.se> <u84smi7x5q.fsf@arthur.rhein-neckar.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <u84smi7x5q.fsf@arthur.rhein-neckar.de>; from Andreas Jaeger on Thu, Apr 15, 1999 at 04:53:21PM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Apr 15, 1999 at 04:53:21PM +0200, Andreas Jaeger wrote:

> At the end of last year I tried to integrate Ralf's patches into
> glibc 2.1.  A number of patches went into the glibc tree but some
> problems are still open.  Ralf can certainly better comment this from
> the mips side, I'm just a glibc developer without access to any mips
> machine who used a cross compiler:
> - glibc 2.1 needs symbol versioning but there're no binutils for mips
>   that support symbol versioning
> - there're some problems with the way glibc handles PIC which leads to 
>   problems on mips.

Fixed in my patches.

> - the system (mips) dependend part of the dynamic linker has to be
>   updated.

Done in my patches modulo debugging.

I've fixed several problems in H.J. Lu's binutils 2.9.1.0.15.  Symbol
version is still not working and building GNU libc still results in
amazing amounts of assertion messages in bfd/elf32-mips.c; building
kernels is broken as well.

> - some minor discrepancies between the kernel headers in the official
>   kernel and the glibc headers.  Ralf and I updated most (all?) but
>   somebody should recheck this.
> 
> IMO the first two problems to tackle is to get it running at all,
> meaning to fix the PIC problems (that's already planned by the glibc
> folks for 2.2) and the dynamic linker.  Without symbol versioning you
> loose binary compatibility with older and newer versions of glibc.
> Therefore the binutils have to be fixed to use glibc 2.1.

While that is correct for a production version we probably can temporarily
bump the major version number for development purposes and work on
both binutils and GNU binutils in parallel.

The latest versions I've worked on are GNU libc version 2.0.109 and
binutils 2.9.1.0.15.  I've put my patches on linus.linux.sgi.com into
/pub/linux/mips/test/{binutils-2.9.1.0.15.diff.gz,glibc-2.0.109.diff.gz}.

Have fun ;-)

  Ralf
