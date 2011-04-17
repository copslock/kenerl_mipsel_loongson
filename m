Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 17 Apr 2011 07:15:57 +0200 (CEST)
Received: from mail-pz0-f49.google.com ([209.85.210.49]:34508 "EHLO
        mail-pz0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490953Ab1DQFPx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 17 Apr 2011 07:15:53 +0200
Received: by pzk5 with SMTP id 5so1891316pzk.36
        for <linux-mips@linux-mips.org>; Sat, 16 Apr 2011 22:15:46 -0700 (PDT)
Received: by 10.68.46.200 with SMTP id x8mr4874828pbm.102.1303017346278;
        Sat, 16 Apr 2011 22:15:46 -0700 (PDT)
Received: from localhost.localdomain ([122.172.164.87])
        by mx.google.com with ESMTPS id g4sm1468958pbt.79.2011.04.16.22.15.43
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Apr 2011 22:15:44 -0700 (PDT)
Message-ID: <4DAA77B5.6000103@mvista.com>
Date:   Sun, 17 Apr 2011 10:46:37 +0530
From:   Philby John <pjohn@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
References: <1302710833.14458.1.camel@localhost.localdomain> <4DA5DF7A.1030207@caviumnetworks.com> <201104151024.07859.florian@openwrt.org> <4DA8081D.9050608@mvista.com> <4DA871F5.40809@caviumnetworks.com> <4DA9B3F3.50805@mvista.com> <4DA9BB10.5030309@openwrt.org>
In-Reply-To: <4DA9BB10.5030309@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <pjohn@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29772
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pjohn@mvista.com
Precedence: bulk
X-list: linux-mips

On 04/16/2011 09:21 PM, Florian Fainelli wrote:
> Hello,
> 
> Le 16/04/2011 17:21, Philby John a écrit :
>> On 04/15/2011 09:57 PM, David Daney wrote:
>>> On 04/15/2011 01:55 AM, Philby John wrote:
>>>> On 04/15/2011 01:54 PM, Florian Fainelli wrote:
>>>>> Hello,
>>>>>
>>>>> On Wednesday 13 April 2011 19:38:02 David Daney wrote:
>>>>>> On 04/13/2011 09:07 AM, philby john wrote:
>>>>>>> From: Philby John<pjohn@mvista.com>
>>>>>>
>>>>>> ^^^^^^^^ I believe that statement to be not entirely correct.
>>>>>>
>>>>>> Perhaps you should change it to something like:
>>>>>> From: David Daney<ddaney@caviumnetworks.com>
>>>>>>
>>>>>>> Date: Wed, 13 Apr 2011 20:46:32 +0530
>>>>>>> Subject: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
>>>>>>>
>>>>>>> Some early Octeon bootloaders cannot process PT_NOTE program
>>>>>>> headers as reported in numerous sections of the web, here is
>>>>>>> an example http://www.spinics.net/lists/mips/msg37799.html
>>>>>>> Loading usually fails with such an error ...
>>>>>>> Error allocating memory for elf image!
>>>>>>>
>>>>>>> The work around usually is to strip the .notes section by using
>>>>>>> such a command $mips-gnu-strip -R .notes vmlinux -o fixed-vmlinux
>>>>>>> It is expected that the vmlinux image got after compilation be
>>>>>>> bootable. Add a Kconfig option to ignore the PT_NOTE section.
>>>>>
>>>>> Do we really want this to be in the kernel? In my opinion, this is a
>>>>> fixup
>>>>> which distributions should be aware of, but not necessarily take
>>>>> place here in
>>>>> the kernel Makefiles.
>>>>
>>>> You are right in one way. But as an OS vendor company we will
>>>> definitely
>>>> include this patch in our distribution. This incident has been reported
>>>> many a times and its a pain to see the image not boot up, throw up an
>>>> error, with the user having to search the work around on the web. What
>>>> we are trying to do is save all that trouble. If it can be fixed why
>>>> not
>>>> fix it.
>>>>
>>>
>>> I don't care one way or another.  We too (perhaps one and the same...)
>>> provide kernels to our SDK customers with the patch applied.
>>>
>>> An alternative approach would be to put the $(CROSS_COMPILE)strip
>>> command into the arch/mips/Makefile.
>>
>> I doubt that's any good, strip also removes debug symbols along with the
>> notes section and I am not aware of a specific command to strip just the
>> PT_NOTE section. Just these lines of code seem to get the job done
>> though ...
>>
>> +#ifndef CONFIG_DISABLE_ELF_NOTE_HEADER
>>        NOTES :text :note
>> +#else
>> +    NOTES :text
>> +#endif
> 
> strip can be told to only strip a particular section, e.g:
> $(TARGET_CROSS)strip -R .notes
> 
But this strips the debug symbols as well, from what I saw. Problems
with the strip command? Anyways, I won't be pursuing this matter any
further given the limited scope of its inclusion.

Regards,
Philby
