Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 05 Mar 2008 22:56:08 +0000 (GMT)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:23379 "EHLO
	sj-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28602814AbYCEW4F (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 5 Mar 2008 22:56:05 +0000
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-2.cisco.com with ESMTP; 05 Mar 2008 14:55:57 -0800
Received: from sj-core-4.cisco.com (sj-core-4.cisco.com [171.68.223.138])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m25Mtv65026063
	for <linux-mips@linux-mips.org>; Wed, 5 Mar 2008 14:55:57 -0800
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-4.cisco.com (8.12.10/8.12.6) with ESMTP id m25MtvJt001158
	for <linux-mips@linux-mips.org>; Wed, 5 Mar 2008 22:55:57 GMT
Received: from [127.0.0.1] ([64.100.148.129]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id WAA08262 for <linux-mips@linux-mips.org>; Wed, 5 Mar 2008 22:55:56 GMT
Message-ID: <47CF24F4.4010508@cisco.com>
Date:	Wed, 05 Mar 2008 14:55:48 -0800
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.12 (Windows/20080213)
MIME-Version: 1.0
To:	linux-mips@linux-mips.org
Subject: Re: Does HIGHMEM work on 32-bit MIPS ports?
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=2467; t=1204757757; x=1205621757;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20Does=20HIGHMEM=20work=20on=2032-bit=20M
	IPS=20ports?
	|Sender:=20;
	bh=OllSub+IzBFbXhHc8sSRqFbdgkaVoYPay20En0pb9Fc=;
	b=bPgppIffRtg0BHu2mXdw+Y2UEtf0/YMyB5p0tRkmn4F1pZuzKdKdUM5flZ
	DBKHOL0o0aNdz7y8QGBUo28643qv/luzSHjby+oaf46mFEvNgbw1FMMIpb0w
	wly1GBVnBYNwSjswSJayJbYxQPFNMSTZHPTaPw/l5TCYXxJOfRbCU=;
Authentication-Results:	sj-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 18338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

We've made significant progress in getting HIGHMEM to work on our 24K 
processor, but things do not completely work yet. Since I don't yet have 
confidence that we know everything that's going on, I"m not ready to 
submit a full-blown patch, but here's what we've done so far. Please 
send comments/suggestions...

The function __flush_dcache_page (in arch/mips/mm/cache.c) was simply 
returning if the struct page* argument it was given indicated we had a 
page in high memory, so the dcache was never being flushed. This is an 
obvious Bad Thing.

Our first modification was to expand the check for high memory. If the 
page had a temporary mapping, i.e. it was mapped through kmap_atomic(), 
we call flush_data_cache_page(). We then immediately return:

    if (PageHighMem(page)) {
        addr = (unsigned long)kmap_atomic_to_vaddr(page);
        if (addr != 0) {
            flush_data_cache_page(addr);
        }
        return;
    }

(kmap_atomic_to_vaddr() returns the virtual address if the page is 
mapped with kmap_atomic(), otherwise it returns NULL). This change by 
itself is enough to be able to boot with NFS most of the time. I think 
it is not sufficient for permanently mapped kernel pages (those mapped 
with kmap_high()). So, I made two other modifications.

Additional Modification #1: To me, it looks like the return should be 
moved to right after the call to flush_data_cache_page() so that we only 
return immediately for temporary kernel mappings.

The next section of code, which I think already works correctly with 
high memory, is:

    if (mapping && !mapping_mapped(mapping)) {
        SetPageDcacheDirty(page);
        return;
    }

We then have the following:

    addr = (unsigned long) page_address(page);
    flush_data_cache_page(addr);

Additional Modification #2: If the page is in high memory, it may not 
have a kernel mapping, in which case page_address() will return NULL. 
So, I've modified the code to only call flush_data_cache_page() if the 
page_address() doesn't return NULL.

With the two additional modifications above, thing are still not 
completely reliable. So, two questions:

   1. Does what we've done so far make sense?
   2. Since the behavior is still somewhat flaky, I'm still missing
      something. Any suggestions?

-- 
David VomLehn, dvomlehn@cisco.com
The opinions expressed herein are likely mine, but might not be my employer's...
