Received:  by oss.sgi.com id <S305169AbQBOAtC>;
	Mon, 14 Feb 2000 16:49:02 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:48172 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305156AbQBOAsz>;
	Mon, 14 Feb 2000 16:48:55 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA05751; Mon, 14 Feb 2000 16:44:24 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA52430
	for linux-list;
	Mon, 14 Feb 2000 16:38:30 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA77816;
	Mon, 14 Feb 2000 16:38:24 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA03591; Mon, 14 Feb 2000 16:38:23 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-16.uni-koblenz.de (cacc-16.uni-koblenz.de [141.26.131.16])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA00820;
	Tue, 15 Feb 2000 01:38:12 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407895AbQBOAhj>;
	Tue, 15 Feb 2000 01:37:39 +0100
Date:   Tue, 15 Feb 2000 01:37:39 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Dominic Sweetman <dom@algor.co.uk>
Cc:     "William J. Earl" <wje@cthulhu.engr.sgi.com>,
        "Kevin D. Kissell" <kevink@mips.com>, geert@linux-m68k.org,
        Ralf Baechle <ralf@oss.sgi.com>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: Indy crashes
Message-ID: <20000215013739.E828@uni-koblenz.de>
References: <022301bf7730$92b87180$0ceca8c0@satanas.mips.com> <14504.31299.82555.477086@liveoak.engr.sgi.com> <200002142345.XAA00626@gladsmuir.algor.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <200002142345.XAA00626@gladsmuir.algor.co.uk>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Mon, Feb 14, 2000 at 11:45:06PM +0000, Dominic Sweetman wrote:

> QED's RM7000 has an internal secondary cache which is more like (but
> not compatible with) an R4000.  As part of our Linux familiarisation
> we'll try to get that working.  It's 4-way set associative, 256Kbytes
> big, unified and write-back; so that should shake out some more bugs.

[...]

> I used to be an advocate of the MIPS position; but what this argument
> ignores is the difficulty of maintaining a portable software base,
> particulary an OS which (like Linux) has grown up with invisible x86
> caches.
> 
> To make sure that Linux/MIPS kernels are and remain robust we have to
> convince lots of people to take the trouble to learn about visible
> caches - even though the systems they're working on don't have them.
> And we have to hope that driver writers will do the right thing, even
> though they've never used a system which needs cache management code
> and have none at hand to test their drivers with...
> 
> This would be unlikely even if we all agreed what the word 'flush'
> meant (does it mean "invalidate"?  or "write-back"?  or perhaps "both,
> if necessary"? and can you build a robust OS without knowing the
> answer?)

Yes.

> It *could* happen.  MIPS are not the only family of CPUs with visible
> caches - though I think they probably have by far the most complicated
> ones, because of their high-end history.

Sparc.

> The meeting of Linux and MIPS is in this respect really good for Linux
> - great at finding portability problems.  But it's not particularly
> good for MIPS.  For now, Linux/MIPS kernels will only be reliable if
> maintained by people who understand this stuff, keep a safe distance
> from the x86 mainstream, and use only sanity-checked drivers.

No longer.  With Linux 2.3.41 Linux received a number of new software
interfaces which also could easily be backported to previous kernels.
As the side effect you even get scatter gather capabilities for every
driver.

Btw, please take a look at the new interfaces, they're documented in
Documentation/DMA-mapping.txt.  They're not yet cast into stone, so if
anybody has something to complain about these interfaces, better do it
soon.

> Kevin, I think you'd better tell your colleagues who design the chips
> that they'd better put some snooping in, and soon...

For I/O isn't not that bad to handle except a few cases like the
NCR 53c8xx driver.  And there is always the silver bullet solution of
using uncached accesses.

Things like mmap() and read/write right in the presence of virtual indexed
caches are the real vomit bag.  Linus & Co. so far refuse to accept any of
the optimal solutions.  And while I'd of course would like to such a
solution to get into the kernel I can well understand Linus' refusal.
>From that point of view the RM7000 is the first MIPS CPU that got caches
right since the R6000 ...

  Ralf
