Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 18 Aug 2010 18:10:20 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:37344 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491194Ab0HRQKN (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 18 Aug 2010 18:10:13 +0200
Received: by ewy9 with SMTP id 9so539202ewy.36
        for <multiple recipients>; Wed, 18 Aug 2010 09:10:12 -0700 (PDT)
Received: by 10.213.48.193 with SMTP id s1mr2241561ebf.20.1282147812739;
        Wed, 18 Aug 2010 09:10:12 -0700 (PDT)
Received: from [192.168.11.174] (mail.dev.rtsoft.ru [213.79.90.226])
        by mx.google.com with ESMTPS id v8sm741541eeh.8.2010.08.18.09.10.10
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 18 Aug 2010 09:10:11 -0700 (PDT)
Message-ID: <4C6C05B3.7030908@mvista.com>
Date:   Wed, 18 Aug 2010 20:09:23 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
MIME-Version: 1.0
To:     naveen yadav <yad.naveen@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: kmalloc issue on MIPS target
References: <AANLkTiniH42L=-DdJ_XHOm1Uo_=YoAqE-j9Jrm45imtG@mail.gmail.com>        <20100818133336.GA25740@linux-mips.org>        <AANLkTin8LLH3DkX38B93Ap0mmz4hb9e=cEo9U3ZKmavr@mail.gmail.com>        <20100818144301.GC2849@linux-mips.org> <AANLkTi=zfuEvKCLBj7xuVnjdZXZZ63i2xvVZHKeby+BN@mail.gmail.com>
In-Reply-To: <AANLkTi=zfuEvKCLBj7xuVnjdZXZZ63i2xvVZHKeby+BN@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27644
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

naveen yadav wrote:

> Hi Ralf,

> I understand that that I need to make kmalloc.h in my arch specific
> folder. But I could not get answer, what should be appropriate
> value of  ARCH_KMALLOC_MINALIGN  is it 32 or 128 ?

    You've been replied already that you should set it to 32.

> Thanks.

> On Wed, Aug 18, 2010 at 8:13 PM, Ralf Baechle <ralf@linux-mips.org> wrote:
>> On Wed, Aug 18, 2010 at 07:56:16PM +0530, naveen yadav wrote:
>>
>>> I will give more info.
>>>
>>> CONFIG_MIPS_L1_CACHE_SHIFT=5
>>>
>>> CONFIG_DMA_NONCOHERENT=y
>>>
>>> mips 34kc is processor
>>>
>>> and File we are using is  arch/mips/include/asm/mach-generic/kmalloc.h
>>>
>>> #ifndef __ASM_MACH_GENERIC_KMALLOC_H
>>> #define __ASM_MACH_GENERIC_KMALLOC_H
>>>
>>>
>>> #ifndef CONFIG_DMA_COHERENT
>>> /*
>>>  * Total overkill for most systems but need as a safe default.
>>>  * Set this one if any device in the system might do non-coherent DMA.
>>>  */
>>> #define ARCH_KMALLOC_MINALIGN   128
>>> #endif
>>>
>>> #endif /* __ASM_MACH_GENERIC_KMALLOC_H */

>>> So shall we make value ARCH_KMALLOC_MINALIGN   from 128 to 32. is
>>> there any problem ?

>> No, that's just what you should do.  You do that by putting a file
>> that defines ARCH_KMALLOC_MINALIGN into your platforms's
>> arch/mips/include/asm/mach-<yourplatform>/kmalloc.h just like the ip32
>> file from your original posting.

>>  Ralf

WBR, Sergei
