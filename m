Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Apr 2005 17:45:41 +0100 (BST)
Received: from mail.timesys.com ([IPv6:::ffff:65.117.135.102]:48219 "EHLO
	exchange.timesys.com") by linux-mips.org with ESMTP
	id <S8225417AbVDHQp0>; Fri, 8 Apr 2005 17:45:26 +0100
Received: from [192.168.2.27] ([192.168.2.27]) by exchange.timesys.com with Microsoft SMTPSVC(5.0.2195.6713);
	 Fri, 8 Apr 2005 12:41:11 -0400
Message-ID: <4256B524.2080509@timesys.com>
Date:	Fri, 08 Apr 2005 12:45:24 -0400
From:	Greg Weeks <greg.weeks@timesys.com>
User-Agent: Mozilla Thunderbird 1.0 (X11/20041206)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	linux-mips@linux-mips.org
Subject: Re: another 4kc machine check.
References: <42553E49.7080004@timesys.com> <4256991C.4020601@timesys.com> <20050408161357.GB19166@linux-mips.org>
In-Reply-To: <20050408161357.GB19166@linux-mips.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Apr 2005 16:41:11.0593 (UTC) FILETIME=[C5A9E990:01C53C59]
Return-Path: <greg.weeks@timesys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 7654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: greg.weeks@timesys.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:

>On Fri, Apr 08, 2005 at 10:45:48AM -0400, Greg Weeks wrote:
>
>  
>
>>>This is the malta branch with the tlb patch from Ralf applied. The LTP 
>>>test:
>>>      
>>>
>
>Credits for this patch go to Maciej who actually went through the pain
>of debugging this problem that did show it's ugly head long, long after
>the affected revision has been obsoleted by newer revisions.
>
>  
>
>>>-bash-2.05b# shmem_test_06
>>>      
>>>
>>This test does some mucking with shmat at fixed addresses that might not 
>>be correct for mips. I still wouldn't expect to see a machine check when 
>>it goes to free the shared memory areas. I'm going to try it on a 24K 
>>malta as soon as I get yamon on it and can get it booted.
>>    
>>
>
>I've been able to reproduce it on on two 4Kc boards of different revisions
>so this seems to be something else.  It does not hit 5Kc and 24K.
>  
>
Have you tried a 4kec? That's the only other mips board I have available.

Greg Weeks
