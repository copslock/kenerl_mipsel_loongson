Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Sep 2010 16:40:25 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:42576 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491114Ab0IWOkU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Sep 2010 16:40:20 +0200
Received: by wyb38 with SMTP id 38so1884448wyb.36
        for <multiple recipients>; Thu, 23 Sep 2010 07:40:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=855Kanb4iLjSnc44fO4lvfNhiK3EGvFz/CuZ96qO40Y=;
        b=PxOW2yYhZUpq3949IF6BMsL807MnANsTGPmHC0vJFaMn8jqtsPbCbqRC7yrArK3I/Q
         xJ/mjBR2w6azDoSb3jE2BqOOov4D2LMBD+dem/F6CXSjug188F31fqOC4Swm4WLC8BfK
         t1+obOUZcRqQ9LBQ4QyexcYys2Msug2+4iQaY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bZ/IoLZzlWnQFaTlzN5JMWhgozXphUoYLzBW0yOPg+mYIXGGBWF3Lm3gKY9y6FjQYb
         rpGcuS3MTrhwHAKgd7CUmmAIDXNs71bXOYx8FzGbNqZ7HXHETKQhwCKg8i8zNgBl2KaQ
         DVleU0VGBDKYk7VeRKldnxsgpsQHbtgqBMjWE=
MIME-Version: 1.0
Received: by 10.227.144.206 with SMTP id a14mr1621105wbv.112.1285252815386;
 Thu, 23 Sep 2010 07:40:15 -0700 (PDT)
Received: by 10.216.156.197 with HTTP; Thu, 23 Sep 2010 07:40:15 -0700 (PDT)
In-Reply-To: <AANLkTi=_cg_OEnMr-c8jG4=hec_=qqxLmBkK3zfDBVWd@mail.gmail.com>
References: <1285135150-14772-1-git-send-email-wuzhangjin@gmail.com>
        <4C9A327E.6030109@caviumnetworks.com>
        <AANLkTi=_cg_OEnMr-c8jG4=hec_=qqxLmBkK3zfDBVWd@mail.gmail.com>
Date:   Thu, 23 Sep 2010 22:40:15 +0800
Message-ID: <AANLkTi=KvEO6v1gb+ABym5=mN4RG4-KNgEsaSfcmb4iX@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Make EARLY_PRINTK selectable for !EMBEDDED
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27802
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18337

On 9/23/10, wu zhangjin <wuzhangjin@gmail.com> wrote:
> On 9/23/10, David Daney <ddaney@caviumnetworks.com> wrote:
>> On 09/21/2010 10:59 PM, wuzhangjin@gmail.com wrote:
>>> From: Wu Zhangjin<wuzhangjin@gmail.com>
>>>
>>> When EMBEDDED is disabled, the EARLY_PRINTK option will be hiden and we
>>> have no way to disable it.
>>>
>>> For EARLY_PRINTK is not necessary for !EMBEDDED, we should make it
>>> selectable and only enable it by default for EMBEDDED.
>>>
>>> Signed-off-by: Wu Zhangjin<wuzhangjin@gmail.com>
>>> ---
>>>   arch/mips/Kconfig.debug |    4 ++--
>>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
>>> index 43dc279..77eba81 100644
>>> --- a/arch/mips/Kconfig.debug
>>> +++ b/arch/mips/Kconfig.debug
>>> @@ -7,9 +7,9 @@ config TRACE_IRQFLAGS_SUPPORT
>>>   source "lib/Kconfig.debug"
>>>
>>>   config EARLY_PRINTK
>>> -	bool "Early printk" if EMBEDDED
>>> +	bool "Early printk"
>>>   	depends on SYS_HAS_EARLY_PRINTK
>>> -	default y
>>> +	default y if EMBEDDED
>>
>> I hate to be a pedant, but how about if we don't make it depend on
>> EMBEDDED at all?  I.E. just: 'default y'
>>
>> If the system has SYS_HAS_EARLY_PRINTK, the overhead of enabling
>> EARLY_PRINTK is low, although it may slow down booting.  But it is
>> really not at all related to EMBEDDED.
>
> Yeah, we should remove this dependency eventually, will send a new
> revision later.

But for !EMBEDDED, most of the boards may don't need this
option(although no big influence on the booting, but why not disable
it?), if this 'default y' is there, they need to add an extra "#
CONFIG_EARLY_PRINTK is not set" in their defconfig, one board one such
line in the defconfig, as a result, keep this dependency there may
save more lines and avoid adding this extra line to the defconfig ;-)

And some embedded devices may only provide the serial port output, I
guess, this is the possible reason why it is enabled by default for
EMBEDDED before. this is similar to the reason why
CONFIG_SERIAL_8250_CONSOLE is always enabled for most of the embedded
devices.

So, keep this dependency there and no new revision for this patch.

Regards,
Wu Zhangjin

>
> Thanks & Regards,
> Wu Zhangjin
>
>>
>> David Daney
>>
>>
>>>   	help
>>>   	  This option enables special console drivers which allow the kernel
>>>   	  to print messages very early in the bootup process.
>>
>>
>
