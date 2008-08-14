Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Aug 2008 00:16:56 +0100 (BST)
Received: from sj-iport-1.cisco.com ([171.71.176.70]:26494 "EHLO
	sj-iport-1.cisco.com") by ftp.linux-mips.org with ESMTP
	id S28596934AbYHNXQr (ORCPT <rfc822;linux-mips@linux-mips.org>);
	Fri, 15 Aug 2008 00:16:47 +0100
X-IronPort-AV: E=Sophos;i="4.32,211,1217808000"; 
   d="scan'208";a="65808060"
Received: from sj-dkim-2.cisco.com ([171.71.179.186])
  by sj-iport-1.cisco.com with ESMTP; 14 Aug 2008 23:16:37 +0000
Received: from sj-core-1.cisco.com (sj-core-1.cisco.com [171.71.177.237])
	by sj-dkim-2.cisco.com (8.12.11/8.12.11) with ESMTP id m7ENGbMk028250;
	Thu, 14 Aug 2008 16:16:37 -0700
Received: from cliff.cisco.com (cliff.cisco.com [171.69.11.141])
	by sj-core-1.cisco.com (8.13.8/8.13.8) with ESMTP id m7ENGbVZ013646;
	Thu, 14 Aug 2008 23:16:37 GMT
Received: from CUPLXSUNDISM01.corp.sa.net ([64.101.21.60]) by cliff.cisco.com (8.6.12/8.6.5) with ESMTP id XAA17680; Thu, 14 Aug 2008 23:16:29 GMT
Message-ID: <48A4BCCC.6090001@sciatl.com>
Date:	Thu, 14 Aug 2008 16:16:28 -0700
From:	C Michael Sundius <Michael.sundius@sciatl.com>
User-Agent: Thunderbird 2.0.0.14 (X11/20080501)
MIME-Version: 1.0
To:	Dave Hansen <dave@linux.vnet.ibm.com>
CC:	linux-mm@kvack.org, linux-mips@linux-mips.org,
	jfraser@broadcom.com, Andy Whitcroft <apw@shadowen.org>
Subject: Re: sparsemem support for mips with highmem
References: <48A4AC39.7020707@sciatl.com> <1218753308.23641.56.camel@nimitz>
In-Reply-To: <1218753308.23641.56.camel@nimitz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Authentication-Results:	sj-dkim-2; header.From=Michael.sundius@sciatl.com; dkim=neutral
Return-Path: <Michael.sundius@sciatl.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 20220
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Michael.sundius@sciatl.com
Precedence: bulk
X-list: linux-mips



>> +		if (boot_mem_map.map[i].type != BOOT_MEM_RAM)
>> +			continue;
>> +
>> +		start = PFN_UP(boot_mem_map.map[i].addr);
>> +		end   = PFN_DOWN(boot_mem_map.map[i].addr
>> +				    + boot_mem_map.map[i].size);
>> +
>> +		memory_present(0, start, end);
>> +	}
>>  }
>>     
>
> Is that aligning really necessary?  I'm just curious because if it is,
> it would probably be good to stick it inside memory_present().
>
>   
yaknow, there are several loops in this file that look through this 
boot_mem_ map structure.
they all have the same basic form (but of course are slightly 
different). Anyhow, I just
cut and pasted. I'm wondering if the MIPS folks have comment on how best 
to make
this change and possibly clean up this file. I'm happy to do it, but 
think I'd like some
guidance on this... anyone?


I'll fix and resubmit. sorry for posting this to the two lists, but I 
wasn't sure if I should
put it on the linux-mm list or the linux-mips list... I'll keep the 
distribution unless I
her complaints.

mike
