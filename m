Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 01 Jun 2015 08:00:28 +0200 (CEST)
Received: from resqmta-ch2-02v.sys.comcast.net ([69.252.207.34]:38119 "EHLO
        resqmta-ch2-02v.sys.comcast.net" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27006819AbbFAGAWwEKe4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 1 Jun 2015 08:00:22 +0200
Received: from resomta-ch2-05v.sys.comcast.net ([69.252.207.101])
        by resqmta-ch2-02v.sys.comcast.net with comcast
        id au0B1q0022Bo0NV01u0BxK; Mon, 01 Jun 2015 06:00:11 +0000
Received: from [192.168.1.13] ([69.251.155.187])
        by resomta-ch2-05v.sys.comcast.net with comcast
        id au0A1q00F42s2jH01u0Bzo; Mon, 01 Jun 2015 06:00:11 +0000
Message-ID: <556BF4EA.8040605@gentoo.org>
Date:   Mon, 01 Jun 2015 02:00:10 -0400
From:   Joshua Kinard <kumba@gentoo.org>
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
CC:     Ralf Baechle <ralf@linux-mips.org>
Subject: Re: IP30: SMP, Almost there!
References: <55597B21.4010704@gentoo.org> <556142C5.7090206@gentoo.org> <556BE8C2.8050404@gentoo.org>
In-Reply-To: <556BE8C2.8050404@gentoo.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=comcast.net;
        s=q20140121; t=1433138411;
        bh=2fw7ie1Ffisg0Or3CfaJcydPGvpbxPkAyHyCCrQAY5E=;
        h=Received:Received:Message-ID:Date:From:MIME-Version:To:Subject:
         Content-Type;
        b=gJmZjh4j0j9rkNj8yGlwrzC/s/A+/4WNJiB3pMDOqb/LpFM6h/VAJYiXq1Kcb5jUj
         Chz6nq42vMfbSlt2Y44sSDuT7tr651btOzB3SaN5IUFejV1zfIpaVx3aEQID/U2ytc
         0v+0hVV5+6XLwsFRvPEwljI8b8EHwRp/rYsPLb8ZGF1CW8Yeq8px28wP6OdQwzvCyQ
         6KsMhz1Kdr6cIwrYnYgxQVDG4xKkq5O32tUjLO14h0DXvs8gOX7mpb41VHEkOE1Sw2
         K9pa7XMs0rf51BRmwQIXiLmSdmynp3R/MPT+usaULspPp7mQ4OClHRKLYuc3OhYaE2
         e3iWiXFLQCQiQ==
Return-Path: <kumba@gentoo.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 47758
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kumba@gentoo.org
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

On 06/01/2015 01:08, Joshua Kinard wrote:
> On 05/23/2015 23:17, Joshua Kinard wrote:
>> On 05/18/2015 01:39, Joshua Kinard wrote:
>>> So I've gotten the second CPU in Octane to "tick" again...somehow.  I am
>>> certain someone's cat went missing in the process...
>>
>> So, yeah, the problem appears to be specific to the R14000 CPU module.  I
>> swapped in an R12K dual CPU module, and after a little bit of tinkering to
>> revert a few hacks and clean up the code, it boots into SMP, mounts the
>> userland, and has successfully sync'ed a Gentoo Portage tree w/o annihilating
>> the XFS filesystem or the MD RAID5 array.  Even compiled a few C files.
>>
> [snip]
>>
>> I even got the IRQs to be fanned out across both CPUs.  Well, primarily the
>> qla1280 drivers.  They randomly hop between both CPUs, but no ill effects so far.
>>
>> But if I boot that *same* working kernel on an R14000 dual module, I get handed
>> an IBE as soon as the userland mounts.  The only documented differences that I
>> can find on the R14000 is that it supports DDR memory, being able to do memory
>> operations on the rising edge and falling edge of each clock.  Not sure if that
>> matters to the kernel at all, but I know of nothing else that describes the
>> R14K's internals, such as if there's some new bit in CP0 config,
>> branch-diagnostic, status, etc, that might explain why these IBE's are happening.
>>
>> Guess I need to hunt down my old dual R10K module next and verify that works
>> fine...
>>
>> Also, is there a way to hardcode the cca=5 setting for IP30?  Maybe it needs to
>> be a hidden Kconfig item?.  I tried setting cpu->writecombine in cpu-probe.c,
>> but no dice there.  If I boot an SMP kernel on dual R12K's w/o cca=5, I'll get
>> one or two pretty-specific oopses.  The one I did grab complains about bad
>> spinlock magic in the core tty driver somewhere.  I can transcribe that oops
>> later on if interested.
> 
> So far, the problem looks to have been blindly assigning all 64 HEART IRQs to
> 'handle_level_irq', including the SMP IPI IRQs.  I fixed that by assigning the
> four IPI IRQs and four unused debug IRQs to 'handle_percpu_irq'.  So far, no
> bus errors, even on R14000.  Also successfully tested 16KB PAGE_SIZE and no bus
> errors.  Next, 64KB PAGE_SIZE w/ CONFIG_TRANSPARENT_HUGEPAGE, which was pretty
> good at triggering bus errors.
> 
> </jinx>

CONFIG_TRANSPARENT_HUGEPAGE + HUGETLBFS is still not quite right on R14K CPUs.
 I can very easily trip up bus errors with that config by running 'sync', 'ls',
or 'swapon'/'swapoff' in rapid succession in a minimal bash shell
(init=/bin/bash).  But this was doable even with a single R14K module, so it
has to be a different problem.

At least 16KB and 64KB PAGE_SIZE seem to work well enough now.  Progress!

Also, is there a clear-cut explanation of the difference between
read[bwlq]/write[bwlq] and the raw/__raw/____raw variants?  Which is safe to
use in machine code (like in the SMP or IRQ setup code) versus elsewhere?  Any
warnings, gotchas, etc one has to be aware of?

--J
