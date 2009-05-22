Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2009 10:23:57 +0100 (BST)
Received: from h5.dl5rb.org.uk ([81.2.74.5]:43996 "EHLO h5.dl5rb.org.uk"
	rhost-flags-OK-OK-OK-OK) by ftp.linux-mips.org with ESMTP
	id S20021978AbZEVJXu (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 22 May 2009 10:23:50 +0100
Received: from h5.dl5rb.org.uk (localhost.localdomain [127.0.0.1])
	by h5.dl5rb.org.uk (8.14.3/8.14.3) with ESMTP id n4M9NZvO029627;
	Fri, 22 May 2009 10:23:35 +0100
Received: (from ralf@localhost)
	by h5.dl5rb.org.uk (8.14.3/8.14.3/Submit) id n4M9NY6I029623;
	Fri, 22 May 2009 10:23:34 +0100
Date:	Fri, 22 May 2009 10:23:34 +0100
From:	Ralf Baechle <ralf@linux-mips.org>
To:	Greg Ungerer <gerg@snapgear.com>
Cc:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, linux-mips@linux-mips.org
Subject: Re: system lockup with 2.6.29 on Cavium/Octeon
Message-ID: <20090522092334.GC14047@linux-mips.org>
References: <4A139F50.7050409@snapgear.com> <20090520142604.GA29677@linux-mips.org> <20090521.235020.173372074.anemo@mba.ocn.ne.jp> <4A15FD84.8050505@snapgear.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4A15FD84.8050505@snapgear.com>
User-Agent: Mutt/1.5.18 (2008-05-17)
Return-Path: <ralf@h5.dl5rb.org.uk>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22924
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
Precedence: bulk
X-list: linux-mips

On Fri, May 22, 2009 at 11:19:00AM +1000, Greg Ungerer wrote:

> Atsushi Nemoto wrote:
>> On Wed, 20 May 2009 15:26:04 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
>>>> Now the vmalloc area starts at 0xc000000000000000 and the kernel code
>>>> and data is all at 0xffffffff80000000 and above. I don't know if the
>>>> start and end are reasonable values, but I can see some logic as to
>>>> where they come from. The code path that leads to this is via
>>>> __vunmap() and __purge_vmap_area_lazy(). So it is not too difficult
>>>> to see how we end up with values like this.
>>> Either start or end address is sensible but not the combination - both
>>> addresses should be in the same segment.  Start is in XKSEG, end in CKSEG2
>>> and in between there are vast wastelands of unused address space exabytes
>>> in size.
>>>
>>>> But the size calculation above with these types of values will result
>>>> in still a large number. Larger than the 32bit "int" that is "size".
>>>> I see large negative values fall out as size, and so the following
>>>> tlbsize check becomes true, and the code spins inside the loop inside
>>>> that if statement for a _very_ long time trying to flush tlb entries.
>>>>
>>>> This is of course easily fixed, by making that size "unsigned long".
>>>> The patch below trivially does this.
>>>>
>>>> But is this analysis correct?
>>> Yes - but I think we have two issues here.  The one is the calculation
>>> overflowing int for the arguments you're seeing.  The other being that
>>> the arguments simply are looking wrong.
>>
>> The wrong combination comes from lazy vunmapping which was introduced
>> in 2.6.28 cycle.  Maybe we can add new API (non-lazy version of
>> vfree()) to vmalloc.c to implement module_free(), but I suppose
>> fallbacking to local_flush_tlb_all() in local_flush_tlb_kernel_range()
>> is enough().
>
> Is there any performance impact on falling back to that?
>
> The flushing due to lazy vunmapping didn't seem to happen
> often in the tests I was running.

It would depend on the workload.  Some depend heavily on the performance
of vmalloc & co.  What I'm wondering now is if we no tend to always flush
the entire TLB instead of just a few entries.  The real cost of a TLB
flush is often not the flushing but the eventual reload of the entries.
That's factors that are hard to predict so benchmarking would be
interesting.

  Ralf
