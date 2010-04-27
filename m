Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Apr 2010 02:22:58 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:1910 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492694Ab0D0AWy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Apr 2010 02:22:54 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bd62e670002>; Mon, 26 Apr 2010 17:23:03 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 26 Apr 2010 17:22:17 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Mon, 26 Apr 2010 17:22:16 -0700
Message-ID: <4BD62E38.10707@caviumnetworks.com>
Date:   Mon, 26 Apr 2010 17:22:16 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     post@pfrst.de, Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips <linux-mips@linux-mips.org>
Subject: Re: [PATCH] MIPS: Calculate proper ebase value for 64-bit kernels
References: <Pine.LNX.4.21.1004270049440.1248-100000@Mobile0.Peter>
In-Reply-To: <Pine.LNX.4.21.1004270049440.1248-100000@Mobile0.Peter>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 27 Apr 2010 00:22:16.0932 (UTC) FILETIME=[B138A240:01CAE59F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26480
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 04/26/2010 06:25 PM, post@pfrst.de wrote:
>
>
> Hi David,
>
> please excuse me, i just couldn't resist to comment on this :-)
>
> Some time ago we needed to handle multiple (virtual) address-spaces
> (in TO_CAC/TO_UNCAC as well as in virt_to_phys and the like) for
> SGI's Indigo2/R10k and Octane (neither could run a 32bit kernel).
> So in addrspace.h we provided
> 	#ifdef CONFIG_64BIT
> 	static inline unsigned long kernel_physaddr(unsigned long kva)
> 	{
> 		if((kva&0xffffffff80000000UL)==0xffffffff80000000UL)
> 			return CPHYSADDR(kva);
> 		return XPHYSADDR(kva);
> 	}
> 	#else
> 	#define kernel_physaddr CPHYSADDR
> 	#endif
> while mach-ipXX/spaces.h defined
> 	#define TO_PHYS(x)	(             kernel_physaddr(x))
> 	#define TO_CAC(x)	(CAC_BASE   | kernel_physaddr(x))
> 	#define TO_UNCAC(x)	(UNCAC_BASE | kernel_physaddr(x))
> which did the job.
> But at that time these defines didn't meet much acceptance for general
> use in 64bit kernels.  Now, to my amusement, some modern processor
> (and/or system) seems to urge this kind of address-handling again  ;-)
>
>

FWIW, that seems cleaner than what I did (actually I didn't try my 
code).  That should be the default definition for 64-bit kernels I think.

David Daney

> Good luck!
>
>
>
> On Mon, 26 Apr 2010, David Daney wrote:
>
>> Date: Mon, 26 Apr 2010 10:19:04 -0700
>> From: David Daney<ddaney@caviumnetworks.com>
>> To: wuzhangjin@gmail.com
>> Cc: Ralf Baechle<ralf@linux-mips.org>,
>>       Thomas Bogendoerfer<tsbogend@alpha.franken.de>,
>>       linux-mips@linux-mips.org
>> Subject: Re: [PATCH] MIPS: Calculate proper ebase value for 64-bit kernels
>>
>> ...
>> I don't think so.  We should fix TO_UNCAC() so that it works with CKSEG0
>> addresses.  It should be at physical address 0.  So
>> TO_UNCAC(0xffffffff80000000), should yield 0x9000000000000000
>>
>>
>> #define TO_UNCAC(x) ({ \
>> 	u64 a = (u64)(x);     \
>> 	if (a&  0xffffffffc000000 == 0xffffffff80000000) \
>> 		a = UNCAC_BASE | (a&  0x30000000); \
>> 	else \
>> 		a = UNCAC_BASE | (a&  TO_PHYS_MASK) \
>> 	a; \
>> })
>>
>> David Daney
>>
>> ...
>
