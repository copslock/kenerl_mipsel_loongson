Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 04 Oct 2004 06:24:26 +0100 (BST)
Received: from [IPv6:::ffff:202.9.170.7] ([IPv6:::ffff:202.9.170.7]:37818 "EHLO
	trishul.procsys.com") by linux-mips.org with ESMTP
	id <S8224858AbUJDFYU>; Mon, 4 Oct 2004 06:24:20 +0100
Received: from [192.168.1.36] ([192.168.1.36])
	by trishul.procsys.com (8.12.10/8.12.10) with ESMTP id i945KQGG012129;
	Mon, 4 Oct 2004 10:50:27 +0530
Message-ID: <4160DD47.5010005@procsys.com>
Date: Mon, 04 Oct 2004 10:49:03 +0530
From: "T. P. Saravanan" <sara@procsys.com>
User-Agent: Mozilla Thunderbird 0.7.2 (Windows/20040707)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-mips@linux-mips.org
Subject: Re: mips linux glibc-2.3.3 build - opcode not supported problem
References: <026b01c4a6d5$179b11e0$1701a8c0@vmbservice.ru>
In-Reply-To: <026b01c4a6d5$179b11e0$1701a8c0@vmbservice.ru>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-ProcSys-Com-Anti-Virus-Mail-Filter-Virus-Found: no
Return-Path: <sara@procsys.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 5929
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sara@procsys.com
Precedence: bulk
X-list: linux-mips

Hi,

okay.  Now I have put my CFLAGS to
   
    export CFLAGS="-mips32 -O2 -g"

This too takes me beyond "opcode not supported on this processor" error.

But, the build is breaking at a later point - it is something to do with
#defines like _MIPS_SIM _ABIN32 _ABI64 etc.  Anyway, I will post the
problem in an independent mail.

Thanks,
Saravanan.

Alec Voropay wrote:

>Hi!
>
> The original   mips1 (32-bit R3000) has no sc/ll instructions.
>
> This sc/ll instructions are from the mips3 (64-bit R4000) command set.
>
> It seems, you should use newest "hybrid"  mips32 (designed for the SOC)
>:
>the ISA-II+  architecture but 32bit + *extended instrution set* .
>
>--
>-=AV=-
>
>
>  
>
>>-----Original Message-----
>>From: linux-mips-bounce@linux-mips.org 
>>[mailto:linux-mips-bounce@linux-mips.org] On Behalf Of T. P. Saravanan
>>Sent: Thursday, September 30, 2004 9:43 AM
>>To: linux-mips@linux-mips.org
>>Subject: mips linux glibc-2.3.3 build - opcode not supported problem
>>
>>
>>    
>>
[-snip-]

>>The problem seems to go away if I put CFLAGS="-mips4 -O2 -g". 
>> Is it OK 
>>to do this?
>>Why did gcc/gas fail to use -mips4 opcodes by default?
>>
>>-Saravanan
>>
>>
>>
>>
>>    
>>
