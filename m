Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Nov 2004 16:38:57 +0000 (GMT)
Received: from mail.romat.com ([IPv6:::ffff:212.143.245.3]:18692 "EHLO
	mail.romat.com") by linux-mips.org with ESMTP id <S8224922AbUKOQit>;
	Mon, 15 Nov 2004 16:38:49 +0000
Received: from localhost (localhost.lan [127.0.0.1])
	by mail.romat.com (Postfix) with ESMTP id D2344EB2A9;
	Mon, 15 Nov 2004 18:38:41 +0200 (IST)
Received: from mail.romat.com ([127.0.0.1])
 by localhost (mail.romat.com [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 48957-06; Mon, 15 Nov 2004 18:38:38 +0200 (IST)
Received: from gilad (unknown [192.168.1.167])
	by mail.romat.com (Postfix) with SMTP id 0EA02EB2EE;
	Mon, 15 Nov 2004 18:38:38 +0200 (IST)
Message-ID: <0b2001c4cb31$94b0b060$a701a8c0@lan>
From: "Gilad Rom" <gilad@romat.com>
To: <charles.eidsness@ieee.org>
Cc: <linux-mips@linux-mips.org>
References: <20041114184502.41815.qmail@web81007.mail.yahoo.com> <0a9001c4cae6$f1aa3890$a701a8c0@lan> <4198D6AB.2060005@ieee.org>
Subject: Re: GPIO on the Au1500
Date: Mon, 15 Nov 2004 18:38:43 +0200
Organization: Romat Telecom
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=response
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2180
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
X-Virus-Scanned: by amavisd-new at romat.com
Return-Path: <gilad@romat.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6333
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: gilad@romat.com
Precedence: bulk
X-list: linux-mips

Thanks Charles.

First of all, I managed to get it working today,
(mmapping /dev/mem) so it is possible ;)

Secondly, I am using the GPIO ports for our own custom
design, so I am not exposing /dev/mem to all kinds
of nasty userland apps.

Gilad.

----- Original Message ----- 
From: "Charles Eidsness" <charles.eidsness@ieee.org>
To: "Gilad Rom" <gilad@romat.com>
Cc: <linux-mips@linux-mips.org>
Sent: Monday, November 15, 2004 6:17 PM
Subject: Re: GPIO on the Au1500


> Hi Gilad,
>
> I'd be really surprised if it's possible. I think that those addresses are 
> beyond the valid physical address range for the mem driver. Even if it did 
> work I personally wouldn't feel comfortable doing that sort of thing. You 
> could inadvertently cause a lot of nasty things to happen. Maybe someone 
> else has a different (better) opinion.
>
> If you do use my driver I uploaded the wrong header file yesterday. I've 
> now uploaded the correct one.
>
> Cheers,
> Charles
>
> Gilad Rom wrote:
>> Thank you for the driver, I'm using it as a reference.
>>
>> Still, I am trying to acccess the GPIO ports of the Au1500
>> using /dev/mem, but I keep getting these odd values
>> (see previous messages to this list)
>>
>> Do you think it is possible, or should I stick to using the driver?
>>
>>
>> Thank you,
>> Gilad.
>>
>> ----- Original Message ----- From: "Pete Popov" 
>> <ppopov@embeddedalley.com>
>> To: <charles.eidsness@ieee.org>; "Gilad Rom" <gilad@romat.com>
>> Cc: <linux-mips@linux-mips.org>
>> Sent: Sunday, November 14, 2004 8:45 PM
>> Subject: Re: GPIO on the Au1500
>>
>>
>>>
>>> --- Charles Eidsness <charles.eidsness@ieee.org>
>>> wrote:
>>>
>>>> Hi Gilad,
>>>>
>>>> A little while ago I wrote my own GPIO driver for
>>>> the Au1000, mainly as a learning experience. I never bothered to 
>>>> release it because a driver already exists and I thought it was 
>>>> working.
>>>
>>>
>>> It was, a long time ago, when it was written for the
>>> Au1000. I had a user app and doc somewhere but can't
>>> find it anymore. The driver didn't support gpio2 and
>>> was, in general, stale. So perhaps your driver will
>>> help Gilad.
>>>
>>> Pete
>>>
>>>> I'm not sure if it will work on the Au1550, but if you're interested 
>>>> you can
>>>> find the source code here:
>>>>
>>>>
>>> http://members.rogers.com/charles.eidsness/au1000_gpio.c
>>>
>>>>
>>> http://members.rogers.com/charles.eidsness/au1000_gpio.h
>>>
>>>>
>>>> Cheers,
>>>> Charles
>>>>
>>>> Gilad Rom wrote:
>>>> > Thanks. Can't I just mmap /dev/mem and use the
>>>> > GPIO offset from SYS_BASE?
>>>> > > Gilad.
>>>> > > ----- Original Message ----- From: "Pete Popov"
>>>> <ppopov@embeddedalley.com>
>>>> > To: "Gilad Rom" <gilad@romat.com>;
>>>> <linux-mips@linux-mips.org>
>>>> > Sent: Friday, November 12, 2004 8:13 PM
>>>> > Subject: Re: GPIO on the Au1500
>>>> > > >>
>>>> >> --- Gilad Rom <gilad@romat.com> wrote:
>>>> >>
>>>> >>> Hello,
>>>> >>>
>>>> >>> I am trying to use the au1000_gpio driver, but
>>>> I'm a
>>>> >>> little clueless as to how it is meant to be
>>>> used. Can I use the GPIO >>> ioctl's from a userland program, or must I 
>>>> write
>>>> a kernel module?
>>>> >>
>>>> >>
>>>> >> I'll see if I can dig up some docs and the
>>>> example
>>>> >> userland program this weekend. That driver hasn't
>>>> been
>>>> >> tested in a while though.
>>>> >>
>>>> >> Pete
>>>> >>
>>>> >>> Thank you,
>>>> >>> Gilad Rom
>>>> >>> Romat Telecom
>>>> >>>
>>>> >>>
>>>> >>>
>>>> >>
>>>> > > >
>>>>
>>>
>>>
>>
>> 
