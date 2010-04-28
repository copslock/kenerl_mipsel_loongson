Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 28 Apr 2010 20:59:31 +0200 (CEST)
Received: from smtp2.caviumnetworks.com ([209.113.159.134]:10786 "EHLO
        smtp2.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492160Ab0D1S71 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 28 Apr 2010 20:59:27 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by smtp2.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4bd8854d0000>; Wed, 28 Apr 2010 14:58:21 -0400
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 28 Apr 2010 11:59:06 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
         Wed, 28 Apr 2010 11:59:06 -0700
Message-ID: <4BD88575.1030505@caviumnetworks.com>
Date:   Wed, 28 Apr 2010 11:59:01 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.9) Gecko/20100330 Fedora/3.0.4-1.fc12 Thunderbird/3.0.4
MIME-Version: 1.0
To:     Manuel Lauss <manuel.lauss@googlemail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Linux-MIPS <linux-mips@linux-mips.org>
Subject: Re: use bootmem in platform code on MIPS
References: <k2lf861ec6f1004270514k199cace5wafd6dd269ded8911@mail.gmail.com>         <20100428155439.GA19468@linux-mips.org> <k2tf861ec6f1004280928r92dba2c2u94b9a488a1e5f41c@mail.gmail.com>
In-Reply-To: <k2tf861ec6f1004280928r92dba2c2u94b9a488a1e5f41c@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 28 Apr 2010 18:59:06.0619 (UTC) FILETIME=[E0852CB0:01CAE704]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26501
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 04/28/2010 09:28 AM, Manuel Lauss wrote:
> On Wed, Apr 28, 2010 at 5:54 PM, Ralf Baechle<ralf@linux-mips.org>  wrote:
>> On Tue, Apr 27, 2010 at 02:14:32PM +0200, Manuel Lauss wrote:
>>
>>> I'd like to use bootmem to reserve large chunks of RAM (at a particular physical
>>> address; for Au1200 MAE, CIM and framebuffer, and later Au1300 OpenGL block)
>>> but it seems that it can't be done:  Doing __alloc_bootmem() in
>>> plat_mem_setup() is
>>> too early, while an arch_initcall() is too late because by then the
>>> slab allocator is
>>> already up and handing out random addresses and/or refusing allocations larger
>>> than a few MBytes.
>>
>> The maximum is actually configurable.  CONFIG_FORCE_MAX_ZONEORDER defaults
>> to 11 which means with 4kB pages you get 8MB maximum allocation - more for
>> larger pages.
>
> I already had to modify it for large display resolutions.

You also have to modify it for huge pages combined with larger pages.

I have:

config FORCE_MAX_ZONEORDER
	int "Maximum zone order"
	range 13 64 if SYS_SUPPORTS_HUGETLBFS && PAGE_SIZE_32KB
	default "13" if SYS_SUPPORTS_HUGETLBFS && PAGE_SIZE_32KB
	range 12 64 if SYS_SUPPORTS_HUGETLBFS && PAGE_SIZE_16KB
	default "12" if SYS_SUPPORTS_HUGETLBFS && PAGE_SIZE_16KB
	range 11 64
	default "11"
	help
	  The kernel memory allocator divides physically contiguous memory
	  blocks into "zones", where each zone is a power of two number of
	  pages.  This option selects the largest power of two that the kernel
	  keeps in the memory allocator.  If you need to allocate very large
	  blocks of physically contiguous memory, then you may need to
	  increase this value.

	  This config option is actually maximum order plus one. For example,
	  a value of 11 means that the largest free memory block is 2^10 pages.

	  The page size is not necessarily 4KB.  Keep this in mind
	  when choosing a value for this option.




>
>
>> CONFIG_FORCE_MAX_ZONEORDER is a tradeoff though.  A smaller value will give
>> slightly better performance and safe a bit of memory but I can't really
>> quantify these numbers - I assume it's a small difference.
>>
>> It may actually be preferable to never tell the bootmem allocator about the
>> memory you need for these devices that is bypass the mm code entirely.
>
> Do you mean by not adding the whole RAM area with add_memory_region()?
> Can I give the memory back later (if it's not required)?  Right now I think with
> bootmem that is actually possible.
>
>
>>> Is there another callback I could use which would allow me to use bootmem (short
>>> of abusing plat_smp_setup)?
>>>
>>> Would a separate callback like this be an acceptable solution?
>>
>> Certainly better than using plat_smp_setup which would require enabling
>> SMP support for no good reason at all.
>>
>> I know we will eventually have to add another platform hooks to run after
>> bootmem_init.  The name of plat_mem_setup() already shows what this hook
>> originally was meant for but it ended up as the everything-and-the-kitchen-
>> sink hook for platform-specific early initialization.  I just dislike
>
> The comment above arch_mem_init() too mentions a separate function.
>
>
>> conditional hooks.  Let's add a call to a new hook function and fix whatever
>> breaks or think about what other hooks needs there should be.
>
> Okay, I'll cook something up.
>
> Thank you,
>          Manuel Lauss
>
>
