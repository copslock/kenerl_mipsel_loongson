Received:  by oss.sgi.com id <S305294AbQEBN3w>;
	Tue, 2 May 2000 06:29:52 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:61217 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305164AbQEBN3j>;
	Tue, 2 May 2000 06:29:39 -0700
Received: from nodin.corp.sgi.com (fddi-nodin.corp.sgi.com [198.29.75.193]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id GAA10581; Tue, 2 May 2000 06:24:51 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id GAA80462; Tue, 2 May 2000 06:27:52 -0700 (PDT)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA58827
	for linux-list;
	Tue, 2 May 2000 06:18:41 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA11078
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 2 May 2000 06:18:38 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA07448
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 May 2000 06:18:14 -0700 (PDT)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-22.uni-koblenz.de (cacc-22.uni-koblenz.de [141.26.131.22])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id PAA07112;
	Tue, 2 May 2000 15:18:05 +0200 (MET DST)
Received:  by lappi.waldorf-gmbh.de id <S1405679AbQEBNR6>;
	Tue, 2 May 2000 15:17:58 +0200
Date:   Tue, 2 May 2000 15:17:58 +0200
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     "Kevin D. Kissell" <kevink@mips.com>
Cc:     Florian Lohoff <flo@rfc822.org>, linux@cthulhu.engr.sgi.com
Subject: Re: VC exceptions
Message-ID: <20000502151758.E822@uni-koblenz.de>
References: <001a01bfb349$59f95440$0ceca8c0@satanas.mips.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <001a01bfb349$59f95440$0ceca8c0@satanas.mips.com>; from kevink@mips.com on Mon, May 01, 2000 at 10:43:34AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, May 01, 2000 at 10:43:34AM +0200, Kevin D. Kissell wrote:

> >I'm only worried because I don't know how much software such a change
> >would break.
> 
> But it's already broken - it just doesn't know it.  The difference is that
> now the software will fail in a systematic and recoverable way, whereas
> before it would simply be randomly corrupt.  I agree that it's regrettable,
> but the job of the OS (IMHO) is to provide a known-reliable access
> to the underlying hardware, and to refuse accesses that compromise
> the integrity of the system and the application.

I think we're about to mix two issues.  The one is about fixing a bug,
the other is a design issue is ``Do we want to support coherency between
mmap and read/write of the mapped fd''.

[Linus cite]
Oh, but that's the easy case. You just say that you don't guarantee cache
coherency between writes and mmap's. Problem solved.

It's actually the right solution. Few other systems guarantee cache
coherency under those circumstances either, so basically no existing
applications depend on it anyway. Certainly not in an embedded space.
[...]

> >IRIX uses something they call page ownership switching.  Essentially they
> >ensure that only mappings of one colour are accessible at any time.
> >Accessing a page's mapping of a different colour will make the mm flush
> >caches, make the old colour inaccessible and the new colour accessible
> >in the page tables.  That requires a reverse mapping of physical to virtual
> >addresses, something that Linus so far has always refused to accept.
> 
> Just what has he refused to accept, and what was his rationale?

He does not want a facility that allows to find all virtual addresses
to which a page is mapped as part of the generic memory managment.
That's actually not a big problem, it can be handled in update_mmu_cache,
that is in machine specific code.

  Ralf
