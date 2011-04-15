Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 15 Apr 2011 10:55:12 +0200 (CEST)
Received: from mail-pv0-f177.google.com ([74.125.83.177]:52114 "EHLO
        mail-pv0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491857Ab1DOIzI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 15 Apr 2011 10:55:08 +0200
Received: by pvh11 with SMTP id 11so1189491pvh.36
        for <linux-mips@linux-mips.org>; Fri, 15 Apr 2011 01:55:01 -0700 (PDT)
Received: by 10.68.55.33 with SMTP id o1mr1691275pbp.274.1302857701364;
        Fri, 15 Apr 2011 01:55:01 -0700 (PDT)
Received: from localhost.localdomain ([122.172.20.218])
        by mx.google.com with ESMTPS id k4sm315306pbi.62.2011.04.15.01.54.58
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 15 Apr 2011 01:55:00 -0700 (PDT)
Message-ID: <4DA8081D.9050608@mvista.com>
Date:   Fri, 15 Apr 2011 14:25:57 +0530
From:   Philby John <pjohn@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.7
MIME-Version: 1.0
To:     Florian Fainelli <florian@openwrt.org>
CC:     David Daney <ddaney@caviumnetworks.com>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
References: <1302710833.14458.1.camel@localhost.localdomain> <4DA5DF7A.1030207@caviumnetworks.com> <201104151024.07859.florian@openwrt.org>
In-Reply-To: <201104151024.07859.florian@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <pjohn@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: pjohn@mvista.com
Precedence: bulk
X-list: linux-mips

On 04/15/2011 01:54 PM, Florian Fainelli wrote:
> Hello,
> 
> On Wednesday 13 April 2011 19:38:02 David Daney wrote:
>> On 04/13/2011 09:07 AM, philby john wrote:
>>> From: Philby John<pjohn@mvista.com>
>>
>> ^^^^^^^^ I believe that statement to be not entirely correct.
>>
>> Perhaps you should change it to something like:
>> From: David Daney <ddaney@caviumnetworks.com>
>>
>>> Date: Wed, 13 Apr 2011 20:46:32 +0530
>>> Subject: [PATCH] MIPS: Octeon: add option to ignore PT_NOTE section
>>>
>>> Some early Octeon bootloaders cannot process PT_NOTE program
>>> headers as reported in numerous sections of the web, here is
>>> an example http://www.spinics.net/lists/mips/msg37799.html
>>> Loading usually fails with such an error ...
>>> Error allocating memory for elf image!
>>>
>>> The work around usually is to strip the .notes section by using
>>> such a command $mips-gnu-strip -R .notes vmlinux -o fixed-vmlinux
>>> It is expected that the vmlinux image got after compilation be
>>> bootable. Add a Kconfig option to ignore the PT_NOTE section.
> 
> Do we really want this to be in the kernel? In my opinion, this is a fixup 
> which distributions should be aware of, but not necessarily take place here in 
> the kernel Makefiles.

You are right in one way. But as an OS vendor company we will definitely
include this patch in our distribution. This incident has been reported
many a times and its a pain to see the image not boot up, throw up an
error, with the user having to search the work around on the web. What
we are trying to do is save all that trouble. If it can be fixed why not
fix it.

Cheers,
Philby
