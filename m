Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Nov 2004 17:09:13 +0000 (GMT)
Received: from smtp103.rog.mail.re2.yahoo.com ([IPv6:::ffff:206.190.36.81]:57754
	"HELO smtp103.rog.mail.re2.yahoo.com") by linux-mips.org with SMTP
	id <S8225221AbUKNRJI>; Sun, 14 Nov 2004 17:09:08 +0000
Received: from unknown (HELO ?192.168.1.100?) (charles.eidsness@rogers.com@24.157.59.167 with plain)
  by smtp103.rog.mail.re2.yahoo.com with SMTP; 14 Nov 2004 17:09:01 -0000
Message-ID: <41979129.1050200@ieee.org>
Date: Sun, 14 Nov 2004 12:08:57 -0500
From: Charles Eidsness <charles.eidsness@ieee.org>
Reply-To: charles.eidsness@ieee.org
User-Agent: Mozilla Thunderbird 0.8 (Windows/20040913)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Gilad Rom <gilad@romat.com>
CC: linux-mips@linux-mips.org
Subject: Re: GPIO on the Au1500
References: <20041112181335.13362.qmail@web81008.mail.yahoo.com> <09ac01c4ca24$e68a6740$a701a8c0@lan>
In-Reply-To: <09ac01c4ca24$e68a6740$a701a8c0@lan>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <charles.eidsness@ieee.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 6326
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: charles.eidsness@ieee.org
Precedence: bulk
X-list: linux-mips

Hi Gilad,

A little while ago I wrote my own GPIO driver for the Au1000, mainly as 
a learning experience. I never bothered to release it because a driver 
already exists and I thought it was working. I'm not sure if it will 
work on the Au1550, but if you're interested you can find the source 
code here:

http://members.rogers.com/charles.eidsness/au1000_gpio.c
http://members.rogers.com/charles.eidsness/au1000_gpio.h

Cheers,
Charles

Gilad Rom wrote:
> Thanks. Can't I just mmap /dev/mem and use the
> GPIO offset from SYS_BASE?
> 
> Gilad.
> 
> ----- Original Message ----- From: "Pete Popov" <ppopov@embeddedalley.com>
> To: "Gilad Rom" <gilad@romat.com>; <linux-mips@linux-mips.org>
> Sent: Friday, November 12, 2004 8:13 PM
> Subject: Re: GPIO on the Au1500
> 
> 
>>
>> --- Gilad Rom <gilad@romat.com> wrote:
>>
>>> Hello,
>>>
>>> I am trying to use the au1000_gpio driver, but I'm a
>>> little clueless as to how it is meant to be used. Can I use the GPIO 
>>> ioctl's from a userland program, or must I write a kernel module?
>>
>>
>> I'll see if I can dig up some docs and the example
>> userland program this weekend. That driver hasn't been
>> tested in a while though.
>>
>> Pete
>>
>>> Thank you,
>>> Gilad Rom
>>> Romat Telecom
>>>
>>>
>>>
>>
> 
> 
> 
