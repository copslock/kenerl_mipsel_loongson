Received:  by oss.sgi.com id <S42244AbQHBRJn>;
	Wed, 2 Aug 2000 10:09:43 -0700
Received: from pneumatic-tube.sgi.com ([204.94.214.22]:47115 "EHLO
        pneumatic-tube.sgi.com") by oss.sgi.com with ESMTP
	id <S42225AbQHBRJO>; Wed, 2 Aug 2000 10:09:14 -0700
Received: from nodin.corp.sgi.com (nodin.corp.sgi.com [192.26.51.193]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id KAA04140
	for <linux-mips@oss.sgi.com>; Wed, 2 Aug 2000 10:14:38 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by nodin.corp.sgi.com (980427.SGI.8.8.8/980728.SGI.AUTOCF) via ESMTP id KAA87606 for <linux-mips@oss.sgi.com>; Wed, 2 Aug 2000 10:08:11 -0700 (PDT)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA72901
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 2 Aug 2000 10:06:26 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from hermes.mvista.com (gateway-490.mvista.com [63.192.220.206]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA02205
	for <linux@cthulhu.engr.sgi.com>; Wed, 2 Aug 2000 10:06:17 -0700 (PDT)
	mail_from (jsun@mvista.com)
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.9.3/8.9.3) with ESMTP id KAA14494;
	Wed, 2 Aug 2000 10:05:58 -0700
Message-ID: <398854F5.EB3E73D6@mvista.com>
Date:   Wed, 02 Aug 2000 10:05:57 -0700
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.2.12-20b i586)
X-Accept-Language: en
MIME-Version: 1.0
To:     "Kevin D. Kissell" <kevink@mips.com>
CC:     linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr, ralf@oss.sgi.com
Subject: Re: PROPOSAL : multi-way cache support in Linux/MIPS
References: <008601bffc5b$6714c0a0$0deca8c0@Ulysses>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing


Kevin,

This looks great, something exactly I was hoping for!

A couple of questions :

. What about the actual cache operation routines (flush_cache_page,
...)?  Are they divided into R4xxx, R3xx, etc?  I guess I am curious how
the code is organized.

. Your structure gives the number of ways, but no info about how to
select a way.  How would do an index-based cache operation?  It seems to
me you probably need something like cache_way_selection_offset in the
cpu table.

Jun

"Kevin D. Kissell" wrote:
> 
> Rather than re-invent the wheel, please consider the
> cache descriptor data structures we developed at
> MIPS to deal with this problem.  I believe that the
> updated cache.h file, and maybe even the cpu_probe.c
> file, was checked into the 2.2 repository at SGI long ago.
> There are also a set of initialisation and invalidation routines
> that key off the cache descriptor structure, but those aren't
> in the SGI  repository (though anyone can get them from
> ftp.mips.com or www.paralogos.com).  The CPU probe
> logic (also on those sites, and already integrated
> into several variants because it also supports setting
> up state needed by the software FPU emulation)
> is table-based, and for each PrID value, there is
> a template for the cache characteristics, which
> can either be taken "as is" or probed, depending
> on a flag in the descriptor.  Since the number of
> "ways" cannot always be determined by probing,
> if the number of ways is specified, it is preserved
> even if a cache probe is performed.   I won't attach the
> full set of cache probe routines (which would only confuse
> things), but here is the cache data structure definition
> and the CPU descriptor template table that we use.
> 

...
