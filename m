Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 16 Apr 2011 17:20:40 +0200 (CEST)
Received: from mail-pw0-f49.google.com ([209.85.160.49]:58002 "EHLO
        mail-pw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1490984Ab1DPPUg (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 16 Apr 2011 17:20:36 +0200
Received: by pwi8 with SMTP id 8so1873107pwi.36
        for <linux-mips@linux-mips.org>; Sat, 16 Apr 2011 08:20:29 -0700 (PDT)
Received: by 10.68.39.105 with SMTP id o9mr3920790pbk.45.1302967229113;
        Sat, 16 Apr 2011 08:20:29 -0700 (PDT)
Received: from localhost.localdomain ([122.167.175.128])
        by mx.google.com with ESMTPS id r10sm1128853pbn.94.2011.04.16.08.20.25
        (version=TLSv1/SSLv3 cipher=OTHER);
        Sat, 16 Apr 2011 08:20:27 -0700 (PDT)
Message-ID: <4DA9B3F3.50805@mvista.com>
Date:   Sat, 16 Apr 2011 20:51:23 +0530
From:   Philby John <pjohn@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.7
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Florian Fainelli <florian@openwrt.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
References: <1302710833.14458.1.camel@localhost.localdomain> <4DA5DF7A.1030207@caviumnetworks.com> <201104151024.07859.florian@openwrt.org> <4DA8081D.9050608@mvista.com> <4DA871F5.40809@caviumnetworks.com>
In-Reply-To: <4DA871F5.40809@caviumnetworks.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <pjohn@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29763
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pjohn@mvista.com
Precedence: bulk
X-list: linux-mips

On 04/15/2011 09:57 PM, David Daney wrote:
> On 04/15/2011 01:55 AM, Philby John wrote:
>> On 04/15/2011 01:54 PM, Florian Fainelli wrote:
>>> Hello,
>>>
>>> On Wednesday 13 April 2011 19:38:02 David Daney wrote:
>>>> On 04/13/2011 09:07 AM, philby john wrote:
>>>>> From: Philby John<pjohn@mvista.com>
>>>>
>>>> ^^^^^^^^ I believe that statement to be not entirely correct.
>>>>
>>>> Perhaps you should change it to something like:
>>>> From: David Daney<ddaney@caviumnetworks.com>
>>>>
>>>>> Date: Wed, 13 Apr 2011 20:46:32 +0530
>>>>> Subject: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
>>>>>
>>>>> Some early Octeon bootloaders cannot process PT_NOTE program
>>>>> headers as reported in numerous sections of the web, here is
>>>>> an example http://www.spinics.net/lists/mips/msg37799.html
>>>>> Loading usually fails with such an error ...
>>>>> Error allocating memory for elf image!
>>>>>
>>>>> The work around usually is to strip the .notes section by using
>>>>> such a command $mips-gnu-strip -R .notes vmlinux -o fixed-vmlinux
>>>>> It is expected that the vmlinux image got after compilation be
>>>>> bootable. Add a Kconfig option to ignore the PT_NOTE section.
>>>
>>> Do we really want this to be in the kernel? In my opinion, this is a
>>> fixup
>>> which distributions should be aware of, but not necessarily take
>>> place here in
>>> the kernel Makefiles.
>>
>> You are right in one way. But as an OS vendor company we will definitely
>> include this patch in our distribution. This incident has been reported
>> many a times and its a pain to see the image not boot up, throw up an
>> error, with the user having to search the work around on the web. What
>> we are trying to do is save all that trouble. If it can be fixed why not
>> fix it.
>>
> 
> I don't care one way or another.  We too (perhaps one and the same...)
> provide kernels to our SDK customers with the patch applied.
> 
> An alternative approach would be to put the $(CROSS_COMPILE)strip
> command into the arch/mips/Makefile.

I doubt that's any good, strip also removes debug symbols along with the
notes section and I am not aware of a specific command to strip just the
PT_NOTE section. Just these lines of code seem to get the job done
though ...

+#ifndef CONFIG_DISABLE_ELF_NOTE_HEADER
      NOTES :text :note
+#else
+    NOTES :text
+#endif

Regards,
Philby
