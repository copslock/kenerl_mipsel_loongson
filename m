Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 03 Feb 2015 01:35:42 +0100 (CET)
Received: from mail-la0-f45.google.com ([209.85.215.45]:43630 "EHLO
        mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27012430AbbBCAfkx0cdH (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 3 Feb 2015 01:35:40 +0100
Received: by mail-la0-f45.google.com with SMTP id gd6so46502033lab.4
        for <linux-mips@linux-mips.org>; Mon, 02 Feb 2015 16:35:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:organization:user-agent:mime-version:to:cc
         :subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=bKc6N3CPBz0mlQFM4LaguUEjct5campmmH5ot4GuTTE=;
        b=m2jrLmglMssmOOc2LA8SZdBm3wVEerTLaybRPDNr/VlZKidlOg8JAGqt6BZsurnqXo
         Ggxfi97hizY7Sq65spdUnPRTj9zsXBDuZG9QDC0pA86xjKEOfcfu4u5jwWtVOZMa1ZNc
         DoJTMZHetf7PFplrCw14yCfH2K+ylMZCqWGFrwCXpR8AGrhefZmT9zFOqHfQNgTbnbkt
         MD49g+G/7+kS95mdHU40XWfUoWjj31Qy4d7ezJPpDH6sXqHE5luwS7SbOVGlwkewO1yW
         kC0sT4065SsytBQrTZiKsL5F/dp9b+Z/0AGctO+5MO2nxWyzFeusZL4quuM5oTojavDs
         8Cxg==
X-Received: by 10.112.83.104 with SMTP id p8mr22134318lby.70.1422923735548;
        Mon, 02 Feb 2015 16:35:35 -0800 (PST)
Received: from [192.168.0.100] ([213.138.85.113])
        by mx.google.com with ESMTPSA id c6sm4700659lag.26.2015.02.02.16.35.33
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Feb 2015 16:35:34 -0800 (PST)
Message-ID: <54D017D4.70200@gmail.com>
Date:   Tue, 03 Feb 2015 03:35:32 +0300
From:   Oleg Kolosov <bazurbat@gmail.com>
Organization: Art System
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
MIME-Version: 1.0
To:     =?windows-1252?Q?M=E5ns_Rullg=E5rd?= <mans@mansr.com>,
        Kevin Cernekee <cernekee@chromium.org>
CC:     Linux MIPS Mailing List <linux-mips@linux-mips.org>
Subject: Re: Few questions about porting Linux to SMP86xx boards
References: <54CEACC1.1040701@gmail.com>        <CAJiQ=7AQuP1JsiApEs4yAR449w6-pcR_qqhSqKdpqNHL5L1mRQ@mail.gmail.com> <yw1xwq409odv.fsf@unicorn.mansr.com>
In-Reply-To: <yw1xwq409odv.fsf@unicorn.mansr.com>
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 8bit
Return-Path: <bazurbat@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 45622
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: bazurbat@gmail.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 02/02/15 21:09, Måns Rullgård wrote:
> Kevin Cernekee <cernekee@chromium.org> writes:
> 
>> On Sun, Feb 1, 2015 at 2:46 PM, Oleg Kolosov <bazurbat@gmail.com> wrote:
>>> 1. They (Sigma Designs) have overridden __fast_iob which is identical to
>>> the default one except for one line:
>>> ...
>>
>> I do not have any direct experience with these SoCs, but you might
>> want to look at the memory map to try to figure this one out.  i.e. if
>> __fast_iob() normally performs an uncached dummy read from the first
>> word of physical memory, does the address need to be adjusted by 64MB
>> on the Sigma chips because system memory (or the memory allocated to
>> the Linux application processor) starts at PA 0x0400_0000 instead of
>> 0x0000_0000?
>>
>> That theory would also explain why the exception vectors were adjusted
>> by the same offset.
> 
> The 86xx has two DRAM controllers mapped with 1GB windows at 0x8000_0000
> and 0xc000_0000, and also with 256MB windows at 0x1000_0000 and 0x2000_0000.
> To complicate matters, CPU physical addresses starting at 0x04000000 are
> subjected to a set of remapping registers translating 6 blocks of 64MB
> to an arbitrary (64MB-aligned) bus address (not that these addresses
> overlap with the low mappings of the DRAM controllers).  The obvious way
> to support this would be to simply set these registers to an identity
> mapping and use highmem for anything that doesn't fit the low windows.
> Obviously, they didn't do that.
> 

Thanks for the explanations! This is really useful.

>> BTW, you can override ebase from the platform code, as was done in
>> arch/mips/kernel/smp-bmips.c.  It probably isn't necessary to change
>> the common per_cpu_trap_init() code (but it may have been necessary
>> way back in 2.6.32).
> 
> Most of the hacks they've done to generic code are actually completely
> unnecessary, if not outright wrong.
> 

That was my suspicion as well. It is reassuring to have a confirmation
from someone more knowledgeable. Thanks!

>>> 2. In io.h they have added explicit __sync() to the end of
>>> pfx##write##bwlq and pfx##out##bwlq##p. Is this really necessary? I've
>>> not yet found any adverse effects of not doing so. Maybe this was a
>>> workaround for some old kernel issue which was fixed since then?
>>
>> Adding a barrier in writel(), as was done on ARM, might have something
>> to do with the SoC's busing or peripherals.  Sometimes there are chip
>> bugs that cause MMIO transaction ordering to break in unexpected ways.
>> Or it could be there to compensate for missing barriers or bad
>> assumptions in a driver somewhere.
>>
>> For #2 and #3, it is likely that somebody at Sigma could find a bug
>> report or changelog explaining why it was added.  In my experience
>> these sorts of changes are usually made to work around subtle problems
>> discovered in testing or production.  Figuring out the exact problem
>> that inspired the patch can be difficult without insider knowledge,
>> unless you happened to run across the same failure.
> 
> I suspect the Sigma patches were produced by randomly prodding a kernel
> with a stick until it started working.
> 

-- 
Regards, Oleg
Art System
