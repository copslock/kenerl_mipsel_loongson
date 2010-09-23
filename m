Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 23 Sep 2010 16:24:54 +0200 (CEST)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:55589 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491055Ab0IWOYw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 23 Sep 2010 16:24:52 +0200
Received: by wyb38 with SMTP id 38so1864668wyb.36
        for <multiple recipients>; Thu, 23 Sep 2010 07:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type;
        bh=Whd5V5j5K1jkZvAcqpTMezZHYLc6Bhqb0h+2pTTQrSU=;
        b=Xal/IhmEjydwltkwAISqPh7LuUv/ooGzqYZAOxnLdDbg36wQLdWX8PnpsmwcsQ7C5p
         iVpsY/zLNRgEMmx3Ca9vDoiXT7ORpnjt5si6BqHzuy/qvz4WKrRgzK1fJPYayMM/1tdI
         9YntIDtOi3/mZwRkhsu7BSD/4qJJDX1Jl30Fs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=rHbZRdxzPcuy3hlZqdSoHg1nDixNzWkDUX7FOm0WXWMpFipPUktUia3XiXrOhWzWE7
         YVuDW1/3VjnnAo8nS6YwZ2Cy/5dfRV7DA/Vs3tv7MroLpS6m4U+fjFz93WMB2wNzHmHa
         TlUCF48HV8ixPwHmBq8mV8zhvIR3rPPRpaW04=
MIME-Version: 1.0
Received: by 10.216.72.209 with SMTP id t59mr8294597wed.83.1285251884908; Thu,
 23 Sep 2010 07:24:44 -0700 (PDT)
Received: by 10.216.156.197 with HTTP; Thu, 23 Sep 2010 07:24:44 -0700 (PDT)
In-Reply-To: <4C9A327E.6030109@caviumnetworks.com>
References: <1285135150-14772-1-git-send-email-wuzhangjin@gmail.com>
        <4C9A327E.6030109@caviumnetworks.com>
Date:   Thu, 23 Sep 2010 22:24:44 +0800
Message-ID: <AANLkTi=_cg_OEnMr-c8jG4=hec_=qqxLmBkK3zfDBVWd@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Make EARLY_PRINTK selectable for !EMBEDDED
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     David Daney <ddaney@caviumnetworks.com>
Cc:     linux-mips@linux-mips.org, ralf@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
X-archive-position: 27801
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18332

On 9/23/10, David Daney <ddaney@caviumnetworks.com> wrote:
> On 09/21/2010 10:59 PM, wuzhangjin@gmail.com wrote:
>> From: Wu Zhangjin<wuzhangjin@gmail.com>
>>
>> When EMBEDDED is disabled, the EARLY_PRINTK option will be hiden and we
>> have no way to disable it.
>>
>> For EARLY_PRINTK is not necessary for !EMBEDDED, we should make it
>> selectable and only enable it by default for EMBEDDED.
>>
>> Signed-off-by: Wu Zhangjin<wuzhangjin@gmail.com>
>> ---
>>   arch/mips/Kconfig.debug |    4 ++--
>>   1 files changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/Kconfig.debug b/arch/mips/Kconfig.debug
>> index 43dc279..77eba81 100644
>> --- a/arch/mips/Kconfig.debug
>> +++ b/arch/mips/Kconfig.debug
>> @@ -7,9 +7,9 @@ config TRACE_IRQFLAGS_SUPPORT
>>   source "lib/Kconfig.debug"
>>
>>   config EARLY_PRINTK
>> -	bool "Early printk" if EMBEDDED
>> +	bool "Early printk"
>>   	depends on SYS_HAS_EARLY_PRINTK
>> -	default y
>> +	default y if EMBEDDED
>
> I hate to be a pedant, but how about if we don't make it depend on
> EMBEDDED at all?  I.E. just: 'default y'
>
> If the system has SYS_HAS_EARLY_PRINTK, the overhead of enabling
> EARLY_PRINTK is low, although it may slow down booting.  But it is
> really not at all related to EMBEDDED.

Yeah, we should remove this dependency eventually, will send a new
revision later.

Thanks & Regards,
Wu Zhangjin

>
> David Daney
>
>
>>   	help
>>   	  This option enables special console drivers which allow the kernel
>>   	  to print messages very early in the bootup process.
>
>
