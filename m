Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 02 Nov 2004 17:36:10 +0000 (GMT)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:38129 "EHLO
	hermes.mvista.com") by linux-mips.org with ESMTP
	id <S8225218AbUKBRgG>; Tue, 2 Nov 2004 17:36:06 +0000
Received: from mvista.com (prometheus.mvista.com [10.0.0.139])
	by hermes.mvista.com (Postfix) with ESMTP
	id 87AA11845C; Tue,  2 Nov 2004 09:36:04 -0800 (PST)
Message-ID: <4187C584.4060000@mvista.com>
Date: Tue, 02 Nov 2004 09:36:04 -0800
From: Manish Lachwani <mlachwani@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Thomas Petazzoni <thomas.petazzoni@enix.org>
Cc: linux-mips@linux-mips.org
Subject: Re: Custom kernel crashes
References: <4187AF03.5030606@enix.org> <4187BB44.4030508@mvista.com> <4187BED1.2060208@enix.org> <4187BFF8.6000905@mvista.com> <4187C26E.1090402@enix.org>
In-Reply-To: <4187C26E.1090402@enix.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <mlachwani@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6249
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mlachwani@mvista.com
Precedence: bulk
X-list: linux-mips

Hello Thomas,

Quick suggestion since I dont know all the details: Can you increase the 
  size of the space mapped to say 16 MB (some larget value than 256 KB) 
and check if the bus error repeats?

#define NPP_BOARD_INTERNAL_SRAM_SIZE (16 *1024 * 1024)

Thanks
Manish Lachwani



Thomas Petazzoni wrote:
> Hello,
> 
> Manish Lachwani a écrit :
> 
>> What are these values: NPP_BOARD_INTERNAL_SRAM_BASE, 
>> NPP_BOARD_INTERNAL_SRAM_END and NPP_BOARD_INTERNAL_SRAM_BASE.
> 
> 
> #define NPP_BOARD_INTERNAL_SRAM_BASE 0xfe000000UL
> #define NPP_BOARD_INTERNAL_SRAM_SIZE (256*1024)
> #define NPP_BOARD_INTERNAL_SRAM_END  \
>         (NPP_BOARD_INTERNAL_SRAM_BASE + NPP_BOARD_INTERNAL_SRAM_SIZE)
> 
> Do you think it's a problem related to the SRAM ?
> 
>> Also, what is ENTRYLO() defined as?
> 
> 
> static inline unsigned long ENTRYLO(unsigned long paddr)
> {
>         return ((paddr & PAGE_MASK) |
>                (_PAGE_PRESENT | __READABLE | __WRITEABLE | _PAGE_GLOBAL |
>                 _CACHE_UNCACHED)) >> 6;
> }
> 
> This code is taken from the jaguar_atx setup.c file.
> 
> Thanks,
> 
> Thomas
