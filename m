Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2008 17:12:39 +0100 (BST)
Received: from sj-iport-6.cisco.com ([171.71.176.117]:25495 "EHLO
	sj-iport-6.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28576256AbYHOQMc (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Aug 2008 17:12:32 +0100
X-IronPort-AV: E=Sophos;i="4.32,216,1217808000"; 
   d="scan'208";a="140002791"
Received: from sj-dkim-1.cisco.com ([171.71.179.21])
  by sj-iport-6.cisco.com with ESMTP; 15 Aug 2008 16:12:21 +0000
Received: from sj-core-3.cisco.com (sj-core-3.cisco.com [171.68.223.137])
	by sj-dkim-1.cisco.com (8.12.11/8.12.11) with ESMTP id m7FGCLTi029200;
	Fri, 15 Aug 2008 09:12:21 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-3.cisco.com (8.13.8/8.13.8) with ESMTP id m7FGCLMW007430;
	Fri, 15 Aug 2008 16:12:21 GMT
Received: from CUPLXSUNDISM01.corp.sa.net ([64.101.21.60]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id QAA12573; Fri, 15 Aug 2008 16:12:15 GMT
Message-ID: <48A5AADE.1050808@sciatl.com>
Date:	Fri, 15 Aug 2008 09:12:14 -0700
From:	C Michael Sundius <Michael.sundius@sciatl.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Dave Hansen <dave@linux.vnet.ibm.com>
CC:	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	linux-mm@kvack.org, linux-mips@linux-mips.org,
	jfraser@broadcom.com, Andy Whitcroft <apw@shadowen.org>
Subject: Re: sparsemem support for mips with highmem
References: <48A4AC39.7020707@sciatl.com> <1218753308.23641.56.camel@nimitz>	 <48A4C542.5000308@sciatl.com>  <20080815080331.GA6689@alpha.franken.de> <1218815299.23641.80.camel@nimitz>
In-Reply-To: <1218815299.23641.80.camel@nimitz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Authentication-Results:	sj-dkim-1; header.From=Michael.sundius@sciatl.com; dkim=neutral
Return-Path: <Michael.sundius@sciatl.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20226
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Michael.sundius@sciatl.com
Precedence: bulk
X-list: linux-mips

Dave Hansen wrote:
> On Fri, 2008-08-15 at 10:03 +0200, Thomas Bogendoerfer wrote:
>   
>> On Thu, Aug 14, 2008 at 04:52:34PM -0700, C Michael Sundius wrote:
>>     
>>> +
>>> +#ifndef CONFIG_64BIT
>>> +#define SECTION_SIZE_BITS       27	/* 128 MiB */
>>> +#define MAX_PHYSMEM_BITS        31	/* 2 GiB   */
>>> +#else
>>>  #define SECTION_SIZE_BITS       28
>>>  #define MAX_PHYSMEM_BITS        35
>>> +#endif
>>>       
>> why is this needed ?
>>     
>
> I'm sure Michael can speak to the specifics.  But, in general, making
> SECTION_SIZE_BITS smaller is good if you have lots of small holes in
> memory.  It does this at the cost if increasing the size of the
> mem_section[] array.
>
> MAX_PHYSMEM_BITS should be as as small as possible, but not so small
> that it restricts the amount of RAM that your systems
> support.  ﻿Increasing it has the effect of increasing the size of the
> mem_section[] array.
>
> My guess would be that Michael knew that his 32-bit MIPS platform only
> ever has 2GB of memory.  He also knew that its holes (or RAM) come in
> 128MB sections.  This configuration lets him save the most amount of
> memory with SPARSEMEM.
>
> Michael, I *guess* you could also include a wee bit on how you chose
> your numbers in the documentation.  Not a big deal, though.
>
> -- Dave
>
>   
yes,  actually the top two bits are used in MIPS as segment bits.
For 64 bit MIPS machines there is a bigger physical address space.
In our case, we used either 128MiB or 256MiB blocks or RAM and they
are separated by holes at least that big. It seemed reasonable that that was
the biggest value that I could make it.

One thing that I had thought about and also came up when my peers here
reviewed my changes was that we probably could put those bit numbers
(at the very least the segment size) in the .config file.

we decided that the power that be might have had a reason for that and
we left it not wanting to meddle with the other arch's.

Dave, do you have a comment about that?
