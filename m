Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 20 Aug 2008 20:28:53 +0100 (BST)
Received: from sj-iport-2.cisco.com ([171.71.176.71]:24175 "EHLO
	sj-iport-2.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28583974AbYHTT2s (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Wed, 20 Aug 2008 20:28:48 +0100
X-IronPort-AV: E=Sophos;i="4.32,240,1217808000"; 
   d="scan'208";a="76936983"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-2.cisco.com with ESMTP; 20 Aug 2008 19:28:39 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m7KJSd6b004932;
	Wed, 20 Aug 2008 12:28:39 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m7KJSckK029856;
	Wed, 20 Aug 2008 19:28:38 GMT
Received: from [127.0.0.1] ([64.101.20.200]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id TAA29164; Wed, 20 Aug 2008 19:28:26 GMT
Message-ID: <48AC7056.8070903@cisco.com>
Date:	Wed, 20 Aug 2008 12:28:22 -0700
From:	David VomLehn <dvomlehn@cisco.com>
User-Agent: Thunderbird 2.0.0.16 (Windows/20080708)
MIME-Version: 1.0
To:	Christoph Lameter <cl@linux-foundation.org>
CC:	Randy Dunlap <rdunlap@xenotime.net>,
	C Michael Sundius <Michael.sundius@sciatl.com>,
	Dave Hansen <dave@linux.vnet.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mm@kvack.org, linux-mips@linux-mips.org,
	jfraser@broadcom.com, Andy Whitcroft <apw@shadowen.org>
Subject: Re: sparsemem support for mips with highmem
References: <48A4AC39.7020707@sciatl.com>	<1218753308.23641.56.camel@nimitz>	<48A4C542.5000308@sciatl.com>	<20080815080331.GA6689@alpha.franken.de>	<1218815299.23641.80.camel@nimitz>	<48A5AADE.1050808@sciatl.com>	<20080815163302.GA9846@alpha.franken.de>	<48A5B9F1.3080201@sciatl.com>	<1218821875.23641.103.camel@nimitz>	<48A5C831.3070002@sciatl.com> <20080818094412.09086445.rdunlap@xenotime.net> <48A9E89C.4020408@linux-foundation.org> <48A9F047.7050906@cisco.com> <48AAC54D.8020609@linux-foundation.org> <48AB5959.6090609@cisco.com> <48AC231B.3090801@linux-foundation.org>
In-Reply-To: <48AC231B.3090801@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=3778; t=1219260519; x=1220124519;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20sparsemem=20support=20for=20mips=20with
	=20highmem
	|Sender:=20;
	bh=wcC+eDKuc15XFdlONIuPPln4eVsoWVTIZtwBmauZYVo=;
	b=oaYa2cmjULL1NAlihSXwt8qFgTKjfHc0weft3/G6gUva3AtKPLVldoPv2Q
	MPa/OVB24nuEqHtqZeQW9Wom6EdnJyFs7TJv4piVuU9kfIHauFb/fZ+RnJ/5
	4yxsZtGVVO642tdQOiQIUTIuVV937gY4mjQi0VizbriMUNGV8vAaQ=;
Authentication-Results:	sj-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20290
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Christoph Lameter wrote:
> David VomLehn wrote:
> 
>>> The virtually mapped memmap results in smaller code and is typically more
>>> effective since the processor caches the TLB entries.
>> I'm pretty ignorant on this subject, but I think this is worth
>> discussing. On a MIPS processor, access to low memory bypasses the TLB
>> entirely. I think what you are suggesting is to use mapped addresses to
>> make all of low memory virtually contiguous. On a MIPS processor, we
> 
> No the virtual area is only used to map the memory map (the array of page
> structs). That is just a small fraction of memory.
> 
> 
>> could do this by allocating a "wired" TLB entry for each physically
>> contiguous block of memory. 
...
> That would consume precious resources.
> 
> Just place the memmap into the vmalloc area gets you there. TLB entries should
> be loaded on demand.
> 
> 
>> If I'm understand what you are suggesting correctly (a big if)
...
> 
> The cost going through a TLB mapping is only incurred for accesses to the
> memmap array. Not for general memory accesses.

The bottom line is that, no, I didn't understand correctly. And a part of my 
brain woke me up a 3:00 this morning to say, "duh", to me. I hate it when my 
brain does that, but I think I actually do understand this time. Let's see:

For a flat memory model, the page descriptors array memmap is contiguously 
allocated in low memory. For sparse memory, you only allocate memory to hold page 
descriptors that actually exist. If you don't enable CONFIG_SPARSEMEM_VMEMMAP, 
you introduce a level of indirection where the top bits of an address gives you 
an index into an array that points to an array of page descriptors for that 
section of memory. This has some performance impact relative to flat memory due 
to the extra memory access to read the pointer to the array of page descriptors.

If you do enable CONFIG_SPARSEMEM_VMEMMAP, you still allocate memory to hold page 
descriptors, but you map that memory into virtual space so that a given page 
descriptor for a physical address is at the offset from the beginning of the 
virtual memmap corresponding to the page frame number of that address. This gives 
you a single memmap, just like you had in the flat memory case, though memmap now 
lives in virtual address space. Since memmap now lives in virtual address space, 
you don't need to use any memory to back the virtual addresses that correspond to 
the holes in your physical memory, which is how you save a lot of physical 
memory. The performance impact relative to flag memory is now that of having to 
go through the TLB to get to the page descriptor.

If you are using CONFIG_SPARSEMEM_VMEMMAP and the corresponding TLB entry is 
present, you expect this will be faster than the extra memory access you do when 
CONFIG_SPARSEMEM_VMEMMAP is not enabled, even if that memory is in cache. This 
seems like a pretty reasonable expectation to me. Since TLB entries cover much 
more memory than the cache, it also seems like there would be a much better 
chance that you already have the corresponding TLB entry than having the indirect 
memory pointer in cache. And, in the worst case, reading the TLB entry is just 
another memory access, so it's closely equivalent to not enabling 
CONFIG_SPARSEMEM_VMEMMAP.

So, if I understand this right, the overhead on a MIPS processor using flat 
memory versus using sparse memory with CONFIG_SPARSEMEM_VMEMMAP enabled would be 
mostly the difference between accessing unmapped memory, which doesn't go through 
the TLB, and mapped memory, which does. Even though there is some impact due to 
TLB misses, this should be pretty reasonable. What a way cool approach!
--
David VomLehn
