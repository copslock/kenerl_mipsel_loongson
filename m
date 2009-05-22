Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 22 May 2009 02:19:17 +0100 (BST)
Received: from rex.securecomputing.com ([203.24.151.4]:39114 "EHLO
	cyberguard.com.au" rhost-flags-OK-OK-OK-FAIL) by ftp.linux-mips.org
	with ESMTP id S20023917AbZEVBTK (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Fri, 22 May 2009 02:19:10 +0100
Received: from localhost (localhost.localdomain [127.0.0.1])
	by bne.snapgear.com (Postfix) with ESMTP id 4B699EBBA8;
	Fri, 22 May 2009 11:19:02 +1000 (EST)
X-Virus-Scanned: amavisd-new at snapgear.com
Received: from bne.snapgear.com ([127.0.0.1])
	by localhost (bne.snapgear.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nVvdTGjyhIH7; Fri, 22 May 2009 11:19:01 +1000 (EST)
Received: from [10.46.12.2] (unknown [10.46.12.2])
	by bne.snapgear.com (Postfix) with ESMTP;
	Fri, 22 May 2009 11:19:01 +1000 (EST)
Message-ID: <4A15FD84.8050505@snapgear.com>
Date:	Fri, 22 May 2009 11:19:00 +1000
From:	Greg Ungerer <gerg@snapgear.com>
User-Agent: Thunderbird 2.0.0.19 (X11/20090105)
MIME-Version: 1.0
To:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>
CC:	ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: system lockup with 2.6.29 on Cavium/Octeon
References: <4A139F50.7050409@snapgear.com>	<20090520142604.GA29677@linux-mips.org> <20090521.235020.173372074.anemo@mba.ocn.ne.jp>
In-Reply-To: <20090521.235020.173372074.anemo@mba.ocn.ne.jp>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <gerg@snapgear.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 22920
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gerg@snapgear.com
Precedence: bulk
X-list: linux-mips

Hi Atsushi,

Atsushi Nemoto wrote:
> On Wed, 20 May 2009 15:26:04 +0100, Ralf Baechle <ralf@linux-mips.org> wrote:
>>> Now the vmalloc area starts at 0xc000000000000000 and the kernel code
>>> and data is all at 0xffffffff80000000 and above. I don't know if the
>>> start and end are reasonable values, but I can see some logic as to
>>> where they come from. The code path that leads to this is via
>>> __vunmap() and __purge_vmap_area_lazy(). So it is not too difficult
>>> to see how we end up with values like this.
>> Either start or end address is sensible but not the combination - both
>> addresses should be in the same segment.  Start is in XKSEG, end in CKSEG2
>> and in between there are vast wastelands of unused address space exabytes
>> in size.
>>
>>> But the size calculation above with these types of values will result
>>> in still a large number. Larger than the 32bit "int" that is "size".
>>> I see large negative values fall out as size, and so the following
>>> tlbsize check becomes true, and the code spins inside the loop inside
>>> that if statement for a _very_ long time trying to flush tlb entries.
>>>
>>> This is of course easily fixed, by making that size "unsigned long".
>>> The patch below trivially does this.
>>>
>>> But is this analysis correct?
>> Yes - but I think we have two issues here.  The one is the calculation
>> overflowing int for the arguments you're seeing.  The other being that
>> the arguments simply are looking wrong.
> 
> The wrong combination comes from lazy vunmapping which was introduced
> in 2.6.28 cycle.  Maybe we can add new API (non-lazy version of
> vfree()) to vmalloc.c to implement module_free(), but I suppose
> fallbacking to local_flush_tlb_all() in local_flush_tlb_kernel_range()
> is enough().

Is there any performance impact on falling back to that?

The flushing due to lazy vunmapping didn't seem to happen
often in the tests I was running.

Regards
Greg


------------------------------------------------------------------------
Greg Ungerer  --  Principal Engineer        EMAIL:     gerg@snapgear.com
SnapGear Group, McAfee                      PHONE:       +61 7 3435 2888
825 Stanley St,                             FAX:         +61 7 3891 3630
Woolloongabba, QLD, 4102, Australia         WEB: http://www.SnapGear.com
