Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f6B1eVC22926
	for linux-mips-outgoing; Tue, 10 Jul 2001 18:40:31 -0700
Received: from hermes.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f6B1eTV22920
	for <linux-mips@oss.sgi.com>; Tue, 10 Jul 2001 18:40:30 -0700
Received: from mvista.com (IDENT:jsun@orion.mvista.com [10.0.0.75])
	by hermes.mvista.com (8.11.0/8.11.0) with ESMTP id f6B1eN003522;
	Tue, 10 Jul 2001 18:40:23 -0700
Message-ID: <3B4BADBF.D3E27F42@mvista.com>
Date: Tue, 10 Jul 2001 18:37:03 -0700
From: Jun Sun <jsun@mvista.com>
X-Mailer: Mozilla 4.72 [en] (X11; U; Linux 2.2.18 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org, linux-mips@oss.sgi.com
Subject: Re: memory alloc failuer : __alloc_pages: 1-order allocation failed.
References: <3B4BA24E.1FB614B0@mvista.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk


Just found more about this problem....

Jun Sun wrote:
> 
> I am running 2.4.2 on a linux/mips box, with 32MB system RAM (no swap).  When
> I run a stress test, I will hit memory allocation failure:
> 
> __alloc_pages: 1-order allocation failed.
> IP: queue_glue: no memory for gluing queue 8108cce0
> 
> However, I traced the system and found several questions.
> 
> First, free reports enough free memory and LOTS of cache memory.  See below.
> Should'nt Linux free cache memory to satisfy this request?
> 
>              total       used       free     shared    buffers     cached
> Mem:         30052      29296        756          0          0      16928
> -/+ buffers/cache:      12368      17684
> Swap:            0          0          0
>

The memory allocation is invoked with GFP_ATOMIC, and thus does not free up
the cached pages.  (Why? because it is invoked from interrupt context?)
 
> I used kgdb and dig into rmqueue() in mm/page_alloc.c file.  There are two
> zones in this system.  They do have many free pages but none of free blocks
> seem to be big enough for the 2-page request.  Does this make sense?  Why does
> kernel end up with so many fragmented 1-page free areas?  See the kgdb output
> below.
>

Shouldn't some kernel daemon try to maintain a "reasonable" free_area,
including a 2-page block?  It seems like in my case the daemon failed to do
the job.  (Which daemon is it? kflushd?)  What is the condition to kick start
this daemon?  I suppose in my case the total free page count is still high,
which may fail to start the daemon.

In the end, allocating memory from interrupt context for re-assembling IP
packet does not sound pretty either ...


Jun
