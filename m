Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 16 Jun 2008 17:27:20 +0100 (BST)
Received: from dns0.mips.com ([63.167.95.198]:42963 "EHLO dns0.mips.com")
	by ftp.linux-mips.org with ESMTP id S20022067AbYFPQ1R (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Mon, 16 Jun 2008 17:27:17 +0100
Received: from mercury.mips.com (mercury [192.168.64.101])
	by dns0.mips.com (8.12.11/8.12.11) with ESMTP id m5GGOrdk029063;
	Mon, 16 Jun 2008 09:24:54 -0700 (PDT)
Received: from [127.0.0.1] (grendel [192.168.236.16])
	by mercury.mips.com (8.13.5/8.13.5) with ESMTP id m5GGPllP012979;
	Mon, 16 Jun 2008 09:25:47 -0700 (PDT)
Message-ID: <4856946C.1040102@mips.com>
Date:	Mon, 16 Jun 2008 18:27:24 +0200
From:	"Kevin D. Kissell" <kevink@mips.com>
User-Agent: Thunderbird 2.0.0.14 (Windows/20080421)
MIME-Version: 1.0
To:	"Pelton, Dave" <dpelton@ciena.com>
CC:	David VomLehn <dvomlehn@cisco.com>, "J.Ma" <sync.jma@gmail.com>,
	Markus Gothe <markus.gothe@27m.se>, linux-mips@linux-mips.org
Subject: Re: linux-2.6.25.4 Porting OOPS
References: <dcf6addc0806082001m19d54184pc8ab42b0875c5238@mail.gmail.com> <20B109E2-594E-4329-95C7-F67E9A7882E2@27m.se> <dcf6addc0806120251t4785dc09tc4a6f0854c5cd425@mail.gmail.com> <A3BA2251DD85404FBBEF7478C29D8742F26EFE@onmxm01.ciena.com> <485303CE.8060504@cisco.com> <C34407D180E1CD45900A63F8E6448CBFFA44@onmxm01.ciena.com>
In-Reply-To: <C34407D180E1CD45900A63F8E6448CBFFA44@onmxm01.ciena.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <kevink@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19574
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@mips.com
Precedence: bulk
X-list: linux-mips

The MIPS32 EJTAG debug capability includes a set of memory mapped
registers from 0xff200000 to 0xff3ffff, which overlay kernel mapped memory
ONLY if the processor is in a Debug state.  If that's the way it's been
done, then one is constrained in one's ability to debug kernel code/data in
that region using EJTAG (it can still be done by slight-of-hand) but it 
won't
otherwise interfere with the kernel's use of the region.

That should be the case for all "true" MIPS32 processors, but EJTAG
pre-dates the MIPS32 architecture specification, and I know that some
processors were done in the late 1990's where this "dseg" overlay of kseg2
was larger and/or permanently mapped.  If you've got one of the later,
you may have to play games with FIXADDR_TOP etc.

          Regards,

          Kevin K.

Pelton, Dave wrote:
> David VomLehn wrote:
>   
>> Pelton, Dave wrote:
>>     
>>> <snip>
>>> Normally kseg2 is in the address range 0xC0000000-0xFFFFFFFF.
>>>       
> However,
>   
>>> on the BMIPS3300 (the embedded MIPS32 core used on my SOC), there is
>>>       
> a
>   
>>> range of addresses within kseg2 that are reserved
>>> (0xFF200000-0xFFFEFFFF).
>>> This means that the TLB entry that kmap_coherent creates will not
>>>       
> work
>   
>>> if it falls within the reserved range.  The virtual address space
>>>       
> used
>   
>>> by kmap_coherent is controlled by FIXADDR_TOP in
>>> include/asm-mips/fixmap.h.
>>> To fix my issue, I changed FIXADDR_TOP to avoid the reserved address
>>> space.
>>>       
>> <snip>
>>
>> Is your range of addresses reserved on the BMIPS3300 because it is
>>     
> being used as
>   
>> dseg, i.e. because it is being used for debugging? If I read the
>>     
> documentation on
>   
>> the processor I am using, the 24Kc, it has a similar issue. I don't
>>     
> need to be
>   
>> able to use kmap_coherent because the 24K hardware takes care of data
>>     
> coherence
>   
>> issues, i.e. cpu_has_dc_aliases is false, but I'm sort of thinking we
>>     
> might just
>   
>> generally want to change FIXADDR_TOP to avoid address in the dseg
>>     
> range for all
>   
>> MIPS32 processors. As we work our way through some of the cache
>>     
> flushing issues
>   
>> related to using high memory, I'd like to be able to develop code that
>>     
> works on
>   
>> processors for which cpu_has_dc_aliases is true. If my kmap_coherent
>>     
> is working I
>   
>> can check things out for those processors and then simply use
>>     
> kmap_atomic for
>   
>> processors where cpu_has_dc_aliases is false.
>>     
>
> Apologies in advance for what my plain-text impaired mail client is
> likely to do to this message.  The reserved range on the BMIPS3300 is
> used by memory mapped registers.  I am not a memory management expert,
> so I am not sure what implications there would be to moving FIXADDR_TOP
> as a general fix.  The impression I have from general MIPS documentation
> is that kseg2 should not be used for memory mapped i/o and hence
> platforms that do this should be treated as an exception case, rather
> than moving the general case to deal with this.
>
> - David Pelton
>
>
>   
