Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Apr 2011 17:52:02 +0200 (CEST)
Received: from mail-ww0-f43.google.com ([74.125.82.43]:51016 "EHLO
        mail-ww0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491031Ab1DPPvz (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Apr 2011 17:51:55 +0200
Received: by wwb17 with SMTP id 17so3579492wwb.24
        for <linux-mips@linux-mips.org>; Sat, 16 Apr 2011 08:51:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:sender:message-id:date:from:organization
         :user-agent:mime-version:to:cc:subject:references:in-reply-to
         :content-type:content-transfer-encoding;
        bh=GGRJpzTDbZPT0EGLm/Nxut+0r6J0MNSKporSEvfsjJQ=;
        b=RLgdpn7ToHCZiTRc3CxCdyxRIv/jsyKYmLjUU6mTvwUgsumc0iK9fYj8nOF6zItaEl
         LeAh0rAEsj3CIm88TyDe1gWFA7T/gvZttXDP09lkXsD8a+xW3TiyUgEow18LCC6GnO/I
         5Du15/xMb2k/ncYEP/UhNLrZSqBqW4VtmcA/8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:message-id:date:from:organization:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        b=U9HseavHqL0c8oB35obuUgyXT8zsvrWIHydnzvHpBSvCgygQPTq8JUA1n7x0lneYrU
         qnbmbC7J5/4BO+10haBouqZx69tKkLkvWIEr+fkxJIGCeP8NI7ADGuGwLCnn/CoDV9T4
         G++ZP537zhoSFOr5OTQ3zJIjR1tomQd9+LY8g=
Received: by 10.227.140.77 with SMTP id h13mr3165617wbu.217.1302969108672;
        Sat, 16 Apr 2011 08:51:48 -0700 (PDT)
Received: from [127.0.0.1] (fbx.mimichou.net [82.236.225.16])
        by mx.google.com with ESMTPS id o6sm2226719wbo.54.2011.04.16.08.51.46
        (version=SSLv3 cipher=OTHER);
        Sat, 16 Apr 2011 08:51:47 -0700 (PDT)
Message-ID: <4DA9BB10.5030309@openwrt.org>
Date:   Sat, 16 Apr 2011 17:51:44 +0200
From:   Florian Fainelli <florian@openwrt.org>
Organization: OpenWrt
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; fr; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Philby John <pjohn@mvista.com>
CC:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
References: <1302710833.14458.1.camel@localhost.localdomain> <4DA5DF7A.1030207@caviumnetworks.com> <201104151024.07859.florian@openwrt.org> <4DA8081D.9050608@mvista.com> <4DA871F5.40809@caviumnetworks.com> <4DA9B3F3.50805@mvista.com>
In-Reply-To: <4DA9B3F3.50805@mvista.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29764
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
Precedence: bulk
X-list: linux-mips

Hello,

Le 16/04/2011 17:21, Philby John a écrit :
> On 04/15/2011 09:57 PM, David Daney wrote:
>> On 04/15/2011 01:55 AM, Philby John wrote:
>>> On 04/15/2011 01:54 PM, Florian Fainelli wrote:
>>>> Hello,
>>>>
>>>> On Wednesday 13 April 2011 19:38:02 David Daney wrote:
>>>>> On 04/13/2011 09:07 AM, philby john wrote:
>>>>>> From: Philby John<pjohn@mvista.com>
>>>>>
>>>>> ^^^^^^^^ I believe that statement to be not entirely correct.
>>>>>
>>>>> Perhaps you should change it to something like:
>>>>> From: David Daney<ddaney@caviumnetworks.com>
>>>>>
>>>>>> Date: Wed, 13 Apr 2011 20:46:32 +0530
>>>>>> Subject: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
>>>>>>
>>>>>> Some early Octeon bootloaders cannot process PT_NOTE program
>>>>>> headers as reported in numerous sections of the web, here is
>>>>>> an example http://www.spinics.net/lists/mips/msg37799.html
>>>>>> Loading usually fails with such an error ...
>>>>>> Error allocating memory for elf image!
>>>>>>
>>>>>> The work around usually is to strip the .notes section by using
>>>>>> such a command $mips-gnu-strip -R .notes vmlinux -o fixed-vmlinux
>>>>>> It is expected that the vmlinux image got after compilation be
>>>>>> bootable. Add a Kconfig option to ignore the PT_NOTE section.
>>>>
>>>> Do we really want this to be in the kernel? In my opinion, this is a
>>>> fixup
>>>> which distributions should be aware of, but not necessarily take
>>>> place here in
>>>> the kernel Makefiles.
>>>
>>> You are right in one way. But as an OS vendor company we will definitely
>>> include this patch in our distribution. This incident has been reported
>>> many a times and its a pain to see the image not boot up, throw up an
>>> error, with the user having to search the work around on the web. What
>>> we are trying to do is save all that trouble. If it can be fixed why not
>>> fix it.
>>>
>>
>> I don't care one way or another.  We too (perhaps one and the same...)
>> provide kernels to our SDK customers with the patch applied.
>>
>> An alternative approach would be to put the $(CROSS_COMPILE)strip
>> command into the arch/mips/Makefile.
>
> I doubt that's any good, strip also removes debug symbols along with the
> notes section and I am not aware of a specific command to strip just the
> PT_NOTE section. Just these lines of code seem to get the job done
> though ...
>
> +#ifndef CONFIG_DISABLE_ELF_NOTE_HEADER
>        NOTES :text :note
> +#else
> +    NOTES :text
> +#endif

strip can be told to only strip a particular section, e.g: 
$(TARGET_CROSS)strip -R .notes

like David, I prefer this option rather than modifying the linker script.
--
Florian
