Received:  by oss.sgi.com id <S42294AbQHBVlo>;
	Wed, 2 Aug 2000 14:41:44 -0700
Received: from deliverator.sgi.com ([204.94.214.10]:25137 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S42290AbQHBVlM>;
	Wed, 2 Aug 2000 14:41:12 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA18989
	for <linux-mips@oss.sgi.com>; Wed, 2 Aug 2000 14:33:07 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA58583
	for <linux@engr.sgi.com>;
	Wed, 2 Aug 2000 14:40:11 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA06345
	for <linux@engr.sgi.com>; Wed, 2 Aug 2000 14:40:04 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id OAA25892;
	Wed, 2 Aug 2000 14:38:52 -0700
Message-ID: <398894EC.233BB004@mvista.com>
Date:   Wed, 02 Aug 2000 14:38:52 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     Dominic Sweetman <dom@algor.co.uk>
CC:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr, ralf@oss.sgi.com
Subject: Re: PROPOSAL : multi-way cache support in Linux/MIPS
References: <398762B9.D8507860@mvista.com> <200008021812.TAA11550@mudchute.algor.co.uk>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Dominic Sweetman wrote:
> 
> Jun Sun (jsun@mvista.com) writes:
> 
> > The first issue is multi-way cache support.  DDB5476 uses R5432 CPU
> > which has two-way set-associative cache.  The problematic part is
> > the index-based cache operations in r4xxcache.h does not cover all
> > ways in a set.
> >
> > I think this is a problem in general.  So far I have seen MIPS
> > processors with 2-way, 4-way and 8-way sets.  And I have seen them
> > using ether least- significant-addressing-bits or
> > most-significant-addressing-bits within a cache line to select ways.
> 
> So far as I know the Vr5432 is the only CPU to do anything so silly as
> using the lowest index bits to select the "way". 

Actually Sony's R4500 uses the same low bits mechanism.

> Cache maintenance should always use "hit" type instructions, and you
> don't need to know the cache organisation for those, even with the
> Vr5432.
> 

Ideally - but no in reality.  Linux stills uses index-operations a lot.

Theorically, indexed flush is faster if the flushing are is bigger than
the cache size.

> I suggest you should implement the don't-care method, and then have a
> cpu_info-driven special case for the unique and deprecated Vr5432.
> 

If Vr5432 is really that unique, I think that is probably best way, at
least for now.

Jun
