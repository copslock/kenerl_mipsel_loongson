Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Nov 2004 16:18:04 +0000 (GMT)
Received: from smtp102.rog.mail.re2.yahoo.com ([IPv6:::ffff:206.190.36.80]:45448
	"HELO smtp102.rog.mail.re2.yahoo.com") by linux-mips.org with SMTP
	id <S8224922AbUKOQR4>; Mon, 15 Nov 2004 16:17:56 +0000
Received: from unknown (HELO ?192.168.1.100?) (charles.eidsness@rogers.com@24.157.59.167 with plain)
  by smtp102.rog.mail.re2.yahoo.com with SMTP; 15 Nov 2004 16:17:48 -0000
Message-ID: <4198D6AB.2060005@ieee.org>
Date: Mon, 15 Nov 2004 11:17:47 -0500
From: Charles Eidsness <charles.eidsness@ieee.org>
Reply-To: charles.eidsness@ieee.org
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gilad Rom <gilad@romat.com>
CC: linux-mips@linux-mips.org
Subject: Re: GPIO on the Au1500
References: <20041114184502.41815.qmail@web81007.mail.yahoo.com> <0a9001c4cae6$f1aa3890$a701a8c0@lan>
In-Reply-To: <0a9001c4cae6$f1aa3890$a701a8c0@lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <charles.eidsness@ieee.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6332
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: charles.eidsness@ieee.org
Precedence: bulk
X-list: linux-mips

Hi Gilad,

I'd be really surprised if it's possible. I think that those addresses 
are beyond the valid physical address range for the mem driver. Even if 
it did work I personally wouldn't feel comfortable doing that sort of 
thing. You could inadvertently cause a lot of nasty things to happen. 
Maybe someone else has a different (better) opinion.

If you do use my driver I uploaded the wrong header file yesterday. I've 
now uploaded the correct one.

Cheers,
Charles

Gilad Rom wrote:
> Thank you for the driver, I'm using it as a reference.
> 
> Still, I am trying to acccess the GPIO ports of the Au1500
> using /dev/mem, but I keep getting these odd values
> (see previous messages to this list)
> 
> Do you think it is possible, or should I stick to using the driver?
> 
> 
> Thank you,
> Gilad.
> 
> ----- Original Message ----- From: "Pete Popov" <ppopov@embeddedalley.com>
> To: <charles.eidsness@ieee.org>; "Gilad Rom" <gilad@romat.com>
> Cc: <linux-mips@linux-mips.org>
> Sent: Sunday, November 14, 2004 8:45 PM
> Subject: Re: GPIO on the Au1500
> 
> 
>>
>> --- Charles Eidsness <charles.eidsness@ieee.org>
>> wrote:
>>
>>> Hi Gilad,
>>>
>>> A little while ago I wrote my own GPIO driver for
>>> the Au1000, mainly as a learning experience. I never bothered to 
>>> release it because a driver already exists and I thought it was working. 
>>
>>
>> It was, a long time ago, when it was written for the
>> Au1000. I had a user app and doc somewhere but can't
>> find it anymore. The driver didn't support gpio2 and
>> was, in general, stale. So perhaps your driver will
>> help Gilad.
>>
>> Pete
>>
>>> I'm not sure if it will work on the Au1550, but if you're interested 
>>> you can
>>> find the source code here:
>>>
>>>
>> http://members.rogers.com/charles.eidsness/au1000_gpio.c
>>
>>>
>> http://members.rogers.com/charles.eidsness/au1000_gpio.h
>>
>>>
>>> Cheers,
>>> Charles
>>>
>>> Gilad Rom wrote:
>>> > Thanks. Can't I just mmap /dev/mem and use the
>>> > GPIO offset from SYS_BASE?
>>> > > Gilad.
>>> > > ----- Original Message ----- From: "Pete Popov"
>>> <ppopov@embeddedalley.com>
>>> > To: "Gilad Rom" <gilad@romat.com>;
>>> <linux-mips@linux-mips.org>
>>> > Sent: Friday, November 12, 2004 8:13 PM
>>> > Subject: Re: GPIO on the Au1500
>>> > > >>
>>> >> --- Gilad Rom <gilad@romat.com> wrote:
>>> >>
>>> >>> Hello,
>>> >>>
>>> >>> I am trying to use the au1000_gpio driver, but
>>> I'm a
>>> >>> little clueless as to how it is meant to be
>>> used. Can I use the GPIO >>> ioctl's from a userland program, or must 
>>> I write
>>> a kernel module?
>>> >>
>>> >>
>>> >> I'll see if I can dig up some docs and the
>>> example
>>> >> userland program this weekend. That driver hasn't
>>> been
>>> >> tested in a while though.
>>> >>
>>> >> Pete
>>> >>
>>> >>> Thank you,
>>> >>> Gilad Rom
>>> >>> Romat Telecom
>>> >>>
>>> >>>
>>> >>>
>>> >>
>>> > > >
>>>
>>
>>
> 
> 
> 
