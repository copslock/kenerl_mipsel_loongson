Received:  by oss.sgi.com id <S42284AbQHBSOE>;
	Wed, 2 Aug 2000 11:14:04 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:39960 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42282AbQHBSNo>; Wed, 2 Aug 2000 11:13:44 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id LAA05838
	for <linux-mips@oss.sgi.com>; Wed, 2 Aug 2000 11:19:05 -0700 (PDT)
	mail_from (dom@mudchute.algor.co.uk)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA42365
	for <linux@engr.sgi.com>;
	Wed, 2 Aug 2000 11:12:45 -0700 (PDT)
	mail_from (dom@mudchute.algor.co.uk)
Received: from kenton.algor.co.uk (kenton.algor.co.uk [193.117.190.25]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA02652
	for <linux@engr.sgi.com>; Wed, 2 Aug 2000 11:12:43 -0700 (PDT)
	mail_from (dom@mudchute.algor.co.uk)
Received: from mudchute.algor.co.uk (dom@mudchute.algor.co.uk [193.117.190.19])
	by kenton.algor.co.uk (8.8.8/8.8.8) with ESMTP id TAA01458;
	Wed, 2 Aug 2000 19:12:38 +0100 (GMT/BST)
Received: (from dom@localhost)
	by mudchute.algor.co.uk (8.8.5/8.8.5) id TAA11550;
	Wed, 2 Aug 2000 19:12:34 +0100 (BST)
Date:   Wed, 2 Aug 2000 19:12:34 +0100 (BST)
Message-Id: <200008021812.TAA11550@mudchute.algor.co.uk>
From:   Dominic Sweetman <dom@algor.co.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To:     Jun Sun <jsun@mvista.com>
Cc:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr, ralf@oss.sgi.com
Subject: Re: PROPOSAL : multi-way cache support in Linux/MIPS
In-Reply-To: <398762B9.D8507860@mvista.com>
References: <398762B9.D8507860@mvista.com>
X-Mailer: VM 6.34 under 19.16 "Lille" XEmacs Lucid
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Jun Sun (jsun@mvista.com) writes:

> The first issue is multi-way cache support.  DDB5476 uses R5432 CPU
> which has two-way set-associative cache.  The problematic part is
> the index-based cache operations in r4xxcache.h does not cover all
> ways in a set.
> 
> I think this is a problem in general.  So far I have seen MIPS
> processors with 2-way, 4-way and 8-way sets.  And I have seen them
> using ether least- significant-addressing-bits or
> most-significant-addressing-bits within a cache line to select ways.

So far as I know the Vr5432 is the only CPU to do anything so silly as
using the lowest index bits to select the "way".  Certainly most CPUs
put the "way" bits above the cache-store-index; and MIPS now require
it to be done like that for MIPS32 and MIPS64 compatible parts.

The MS-selects-way organisation permits the cache to be initialised
without the software ever needing to know how many ways it has (just
crank the index up, but being careful about the tendency to recycle
the same way when pre-filling cache data).

Cache maintenance should always use "hit" type instructions, and you
don't need to know the cache organisation for those, even with the
Vr5432. 

I suggest you should implement the don't-care method, and then have a
cpu_info-driven special case for the unique and deprecated Vr5432.

Dominic Sweetman
Algorithmics Ltd
dom@algor.co.uk
