Received:  by oss.sgi.com id <S553692AbRADD0M>;
	Wed, 3 Jan 2001 19:26:12 -0800
Received: from gateway-1237.mvista.com ([12.44.186.158]:55537 "EHLO
        hermes.mvista.com") by oss.sgi.com with ESMTP id <S553646AbRADDZu>;
	Wed, 3 Jan 2001 19:25:50 -0800
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f043NUC27427;
	Wed, 3 Jan 2001 19:23:30 -0800
Message-ID: <3A53ED5F.EC5E936F@mvista.com>
Date:   Wed, 03 Jan 2001 19:26:23 -0800
From:   Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.14-5.0 i686)
X-Accept-Language: en
MIME-Version: 1.0
To:     Ralf Baechle <ralf@oss.sgi.com>
CC:     linux-mips@oss.sgi.com
Subject: Re: missing data cache flush in trap_init?
References: <3A5277C6.89170BAD@mvista.com> <20010103150535.B904@bacchus.dhis.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linux-mips@oss.sgi.com>
X-Orcpt: rfc822;linux-mips-outgoing

Ralf Baechle wrote:
> 
> On Tue, Jan 02, 2001 at 04:52:22PM -0800, Jun Sun wrote:
> 
> > Someone reported this bug to me.  I think it is a valid one.  Basically
> > trap_init() installs the vectors through kseg0 address and then flushes
> > icache.  It is possible that the vectors are still in the data cache and not
> > written back to memory yet.  If an exception happens it may get the corrupted
> > the vector value.
> >
> > The following patch should fix it.  I am not sure if I can use
> > flush_cache_range() to have potentially better performance.
> 
> Flush_icache_range is correct;  the function is expected to do any dcache
> writebacks etc. to make dcache / icache / memory coherent.
> 
> Is it possible that you're using a CPU with additional vectors that aren't
> flushed by this flush_icache_call or?
> 
>   Ralf

You are right - flush_icache_range() practically flushes both caches in the
current implementation.  There might be some other problems.

Aside of that, the name of flush_icache_range() seems to be misleading.  Also
in general how does it know which part of dcache to flush() without a given
process mm struct?  If it does not know, the only choice is to flush the whole
dcache, which seems to make this function very close to flush_all().  

Is this function introduced by other CPU platforms?  How would it make a
difference there?  I am just curious ...

Jun
