Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 07 Mar 2008 05:02:57 +0000 (GMT)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:22802 "EHLO
	sj-iport-6.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28640329AbYCGFCy (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 7 Mar 2008 05:02:54 +0000
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-6.cisco.com with ESMTP; 06 Mar 2008 21:02:48 -0800
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id m2752leP002815;
	Thu, 6 Mar 2008 21:02:47 -0800
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-1.cisco.com (8.12.10/8.12.6) with ESMTP id m2752ln1026460;
	Fri, 7 Mar 2008 05:02:47 GMT
Received: from [127.0.0.1] ([64.100.151.191]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id FAA25603; Fri, 7 Mar 2008 05:02:44 GMT
Message-ID: <47D0CC6C.3050904@cisco.com>
Date:	Thu, 06 Mar 2008 21:02:36 -0800
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
CC:	"dediao@cisco.com; williavi@cisco.com"@cisco.com
Subject: Re: Does HIGHMEM work on 32-bit MIPS ports?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=2118; t=1204866168; x=1205730168;
	c=relaxed/simple; s=sjdkim2002;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20Does=20HIGHMEM=20work=20on=2032-bit=20M
	IPS=20ports?
	|Sender:=20;
	bh=vykMZiGd2BDF/SNfX7DL76d4c+TOaCzv9REHOxydie0=;
	b=tOjeWIqhXjV6Jx48Ta4UjitY7PoMaN/5WnLkrYuM5raMyZqVvtETwt9w6h
	pMH+OoXKJiR/A/3IbAHvPCX2+oziYwN6rLAhKimOnQfB0o7GauVad/CTeueP
	VHSMHsLdpF;
Authentication-Results:	sj-dkim-2; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim2002 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18357
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

>> The function __flush_dcache_page (in arch/mips/mm/cache.c) was simply 
>> returning if the struct page* argument it was given indicated we had a 
>> page in high memory, so the dcache was never being flushed. This is an 
>> obvious Bad Thing.
> 
> Sort of.  It could be argued that the flushing of highmem pages should be
> done on kunmap but I haven't researched that into depth.

I find it hard to get my brain around caching, but my expectation is that you
would not normally need to flush the dcache because, with physical tagging, this
all happens automatically. The case where you do need to flush the cache is
where you may do DMA on the memory you mapped, which is only part of why you use
kmap_atomic. So, most of the flushes in kunmap_atomic would be unnecessary.
People expect to have to flush the dcache before doing DMA, so they'd call
flush_dcache_page/__flush_dcache_page.

>> We then have the following:
>>
>>    addr = (unsigned long) page_address(page);
>>    flush_data_cache_page(addr);
>>
>> Additional Modification #2: If the page is in high memory, it may not 
>> have a kernel mapping, in which case page_address() will return NULL. 
>> So, I've modified the code to only call flush_data_cache_page() if the
>> page_address() doesn't return NULL.
> 
> This assumes that kunmap and kunmap_atomic flush the cache.

I think we've already taken care of the kunmap_atomic case above. For the kunmap
case, if you call __flush_dcache_page and page_address returns NULL, then don't
you have to be working with a user-mapped page? If you do DMA from a user-mapped
page, then I don't know how you come up with a virtual address to use to flush
the cache.

> copy_user_highpage, copy_to_user_page and copy_from_user_page could use some review for correctness for the highmem case.

Thanks! I'll look at these, too.

>   Ralf

To me, this is one of the hairiest corners of the the kernel. I appreciate the
time you're taking to respond!

-- 
David VomLehn, dvomlehn@cisco.com
The opinions expressed herein are likely mine, but might not be my employer's...
