Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 18 Aug 2008 22:58:19 +0100 (BST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:2951 "EHLO
	sj-iport-6.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28579334AbYHRV6N (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Mon, 18 Aug 2008 22:58:13 +0100
X-IronPort-AV: E=Sophos;i="4.32,230,1217808000"; 
   d="scan'208";a="141706685"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-6.cisco.com with ESMTP; 18 Aug 2008 21:58:03 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m7ILw35p017574;
	Mon, 18 Aug 2008 14:58:03 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m7ILw3L2006949;
	Mon, 18 Aug 2008 21:58:03 GMT
Received: from [127.0.0.1] ([64.101.20.200]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id VAA15949; Mon, 18 Aug 2008 21:57:54 GMT
Message-ID: <48A9F047.7050906@cisco.com>
Date:	Mon, 18 Aug 2008 14:57:27 -0700
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
References: <48A4AC39.7020707@sciatl.com>	<1218753308.23641.56.camel@nimitz>	<48A4C542.5000308@sciatl.com>	<20080815080331.GA6689@alpha.franken.de>	<1218815299.23641.80.camel@nimitz>	<48A5AADE.1050808@sciatl.com>	<20080815163302.GA9846@alpha.franken.de>	<48A5B9F1.3080201@sciatl.com>	<1218821875.23641.103.camel@nimitz>	<48A5C831.3070002@sciatl.com> <20080818094412.09086445.rdunlap@xenotime.net> <48A9E89C.4020408@linux-foundation.org>
In-Reply-To: <48A9E89C.4020408@linux-foundation.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
DKIM-Signature:	v=1; a=rsa-sha256; q=dns/txt; l=1233; t=1219096683; x=1219960683;
	c=relaxed/simple; s=sjdkim1004;
	h=Content-Type:From:Subject:Content-Transfer-Encoding:MIME-Version;
	d=cisco.com; i=dvomlehn@cisco.com;
	z=From:=20David=20VomLehn=20<dvomlehn@cisco.com>
	|Subject:=20Re=3A=20sparsemem=20support=20for=20mips=20with
	=20highmem
	|Sender:=20;
	bh=B6MdRFigCBcPD0QVe9hKfZE+cDl4X8zvStm2cAqcZjQ=;
	b=tUC2uq2+nnXhUgNIxao0Xu+R92P/bPPy/Rnug+2v0859jXe8hvsIj1icII
	1P8I+fIKchjUz7FC01xvNBc2L6foTaNRkKY4+RX7GbXW2jZDnmhzt7a1JJgB
	Tbp1uWRWs+xvvlbMNHnpAJhmJzut5626TiGVoP9lPtETOQzqJkp5Y=;
Authentication-Results:	sj-dkim-1; header.From=dvomlehn@cisco.com; dkim=pass (
	sig from cisco.com/sjdkim1004 verified; ); 
Return-Path: <dvomlehn@cisco.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dvomlehn@cisco.com
Precedence: bulk
X-list: linux-mips

Christoph Lameter wrote:
> Randy Dunlap wrote:
> 
>> +Sparsemem divides up physical memory in your system into N section of M
>>
>>                                                             sections
>>
>> +bytes. Page descriptors are created for only those sections that
>> +actually exist (as far as the sparsemem code is concerned). This allows
>> +for holes in the physical memory without having to waste space by
>> +creating page discriptors for those pages that do not exist.
>>
>>                descriptors
>>
>> +When page_to_pfn() or pfn_to_page() are called there is a bit of overhead to
>> +look up the proper memory section to get to the descriptors, but this
>> +is small compared to the memory you are likely to save. So, it's not the
>> +default, but should be used if you have big holes in physical memory.
> 
> This overhead can be avoided by configuring sparsemem to use a virtual vmemmap
> (CONFIG_SPARSEMEM_VMEMMAP). In that case it can be used for non NUMA since the
> overhead is less than even FLATMEM.

On MIPS processors, the kernel runs in unmapped memory, i.e. the TLB isn't even
used, so I don't think you can use that trick. So, this comment doesn't apply to
all processors.
