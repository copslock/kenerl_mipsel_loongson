Received: from oss.sgi.com (localhost [127.0.0.1])
	by oss.sgi.com (8.12.3/8.12.3) with ESMTP id g5RJBPnC021082
	for <linux-mips-outgoing@oss.sgi.com>; Thu, 27 Jun 2002 12:11:25 -0700
Received: (from majordomo@localhost)
	by oss.sgi.com (8.12.3/8.12.3/Submit) id g5RJBP6S021081
	for linux-mips-outgoing; Thu, 27 Jun 2002 12:11:25 -0700
X-Authentication-Warning: oss.sgi.com: majordomo set sender to owner-linux-mips@oss.sgi.com using -f
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.12.3/8.12.3) with SMTP id g5RJBBnC021078;
	Thu, 27 Jun 2002 12:11:11 -0700
Received: from mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id MAA11423;
	Thu, 27 Jun 2002 12:14:32 -0700
Message-ID: <3D1B62A7.6010600@mvista.com>
Date: Thu, 27 Jun 2002 12:08:23 -0700
From: Jun Sun <jsun@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.2.1) Gecko/20010901
X-Accept-Language: en-us
MIME-Version: 1.0
To: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
CC: Ralf Baechle <ralf@oss.sgi.com>, Ladislav Michl <ladis@psi.cz>,
   linux-mips@oss.sgi.com
Subject: Re: [patch] linux: DBE/IBE handling rewrite
References: <Pine.GSO.3.96.1020627193348.21496G-100000@delta.ds2.pg.gda.pl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

Maciej W. Rozycki wrote:

> On Thu, 27 Jun 2002, Jun Sun wrote:
> 
> 
>>You missed the point - I like to see some open discussions before any big 
>>changes to MIPS.  If you look back of all the significant changes made to the 
>>
> 
>  Agreed.
> 
> 
>>MIPS tree, you will see a high percentage of them went in without any open 
>>
> 
>  I can't actually recall any significant changes recently (barring
> platform additions I don't really track), certainly not since 2.4.  All I
> observe are bug fixes, clean-ups and similar stuff.
> 


Here are some of those on top of my mind.  And I am pretty sure I am missing 
others:

1) /proc/cpuinfo and some bootinfo.h change  (I think these two come from one 
change)
2) split of cache and tlb files
3) some kind of flush_cache_LSB() routines.


> 
>>discussion or pre-warning.  It is this context that brought out :-(.  Not your 
>>patch per se.
>>
> 
>  If you suggest that this change qualifies as big, then I'd write you
> exaggerate. 


It is not big logically.  However, outside all the boards that are in oss 
tree, I can safely say there are at least twenty MIPS porting efforts going on 
at various stages.  Next time those people sync up with oss, they will find 
the missing symbol of bus_error_init().


 Anyway, I've sent a proposed function and then a real
> implementation of bits that were broken "since forever".  Even the
> previous clean-up, for 32-bit MIPS solely, was written by me -- apparently
> nobody else was interested in the subsystem.
> 


It wasn't my intention to dampen your MIPS contribution.  In fact, I start to 
regret about my first email which now looks a little irresponsible.

If anything out of this thread can increase the awareness of open discussion 
and awareness of the existence of many boards which are not part of oss tree 
yet, I shall be happy.


Jun
