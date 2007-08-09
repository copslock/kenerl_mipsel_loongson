Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 09 Aug 2007 02:26:08 +0100 (BST)
Received: from [222.92.8.141] ([222.92.8.141]:39854 "HELO lemote.com")
	by ftp.linux-mips.org with SMTP id S20022020AbXHIB0F (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Thu, 9 Aug 2007 02:26:05 +0100
Received: (qmail 9503 invoked by uid 511); 9 Aug 2007 01:32:01 -0000
Received: from unknown (HELO ?192.168.2.233?) (192.168.2.233)
  by lemote.com with SMTP; 9 Aug 2007 01:32:01 -0000
Message-ID: <46BA6CDD.7020907@lemote.com>
Date:	Thu, 09 Aug 2007 09:24:45 +0800
From:	Songmao Tian <tiansm@lemote.com>
User-Agent: Icedove 1.5.0.8 (X11/20061116)
MIME-Version: 1.0
To:	Ralf Baechle <ralf@linux-mips.org>
CC:	Atsushi Nemoto <anemo@mba.ocn.ne.jp>, jiankemeng@gmail.com,
	linux-mips@linux-mips.org, alsa-devel@alsa-project.org,
	tiwai@suse.de, greg@kroah.com
Subject: Re: ALSA on MIPS platform
References: <46B332AC.8020403@lemote.com> <5861a7880708062253x7133659cm1ff17f451e4f82f8@mail.gmail.com> <5861a7880708062317t21970c81w3f16580858bf50af@mail.gmail.com> <20070807.230157.59463765.anemo@mba.ocn.ne.jp> <20070807175402.GA24731@linux-mips.org>
In-Reply-To: <20070807175402.GA24731@linux-mips.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <tiansm@lemote.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 16144
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: tiansm@lemote.com
Precedence: bulk
X-list: linux-mips

Ralf Baechle wrote:
> On Tue, Aug 07, 2007 at 11:01:57PM +0900, Atsushi Nemoto wrote:
>
>   
>> On Tue, 7 Aug 2007 10:18:04 +0400, "Dajie Tan" <jiankemeng@gmail.com> wrote:
>>     
>>>  static inline unsigned long virt_to_phys(volatile const void *address)
>>>  {
>>> -       return (unsigned long)address - PAGE_OFFSET + PHYS_OFFSET;
>>> +       return ((unsigned long)address & 0x1fffffff) + PHYS_OFFSET;
>>>  }
>>>       
>> This makes virt_to_phys() a bit slower, and more importantly, breaks
>> 64-bit kernel.
>>     
>
> It's ALSA that is doing funny things here so there is no point in fixing
> the arch code to work for ALSA.
>
>   Ralf
>
>
>   
arm has made a dma_mmap_coherent, but I don't quite understand the code 
and I am not sure the situation is the same.


Tian
