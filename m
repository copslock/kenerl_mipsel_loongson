Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 14:04:59 +0200 (CEST)
Received: from b.ns.miles-group.at ([95.130.255.144]:9062 "EHLO radon.swed.at"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S6822345Ab3IZME4W7Vdp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 26 Sep 2013 14:04:56 +0200
Received: (qmail 19111 invoked by uid 89); 26 Sep 2013 12:04:57 -0000
Received: by simscan 1.3.1 ppid: 19103, pid: 19106, t: 0.0731s
         scanners: attach: 1.3.1 clamav: 0.96.5/m:
Received: from unknown (HELO ?192.168.0.11?) (richard@nod.at@212.186.22.124)
  by radon.swed.at with ESMTPA; 26 Sep 2013 12:04:57 -0000
Message-ID: <524422E5.9080203@nod.at>
Date:   Thu, 26 Sep 2013 14:04:53 +0200
From:   Richard Weinberger <richard@nod.at>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130620 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Ramkumar Ramachandra <artagnon@gmail.com>
CC:     linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>,
        geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org,
        Jeff Dike <jdike@addtoit.com>,
        Guan Xuetao <gxt@mprc.pku.edu.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net,
        =?UTF-8?B?VG9yYWxmIEbDtnJzdGVy?= <toralf.foerster@gmx.de>
Subject: Re: [PATCH 1/8] um: Create defconfigs for i386 and x86_64
References: <1377073172-3662-1-git-send-email-richard@nod.at> <1377073172-3662-2-git-send-email-richard@nod.at> <CALkWK0=W38JpZoGVkPYD4qd=+Pt1G7oYPEK_R=c8TAW6W=wxyg@mail.gmail.com> <52440DE0.1030807@nod.at> <CALkWK0nEy90VrWawTpYsLNJcnyRSizgArCa-qnzpuJQkyK6zHA@mail.gmail.com>
In-Reply-To: <CALkWK0nEy90VrWawTpYsLNJcnyRSizgArCa-qnzpuJQkyK6zHA@mail.gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-Path: <richard@nod.at>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: richard@nod.at
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

Am 26.09.2013 13:57, schrieb Ramkumar Ramachandra:
> Richard Weinberger wrote:
>>> $ file linux
>>> linux: ELF 32-bit LSB  executable, Intel 80386, version 1 (SYSV),
>>> dynamically linked (uses shared libs), for GNU/Linux 2.6.32, not
>>> stripped
>>> $ ./linux ubd0=busybox-rootfs
>>> [...]
>>> Kernel panic - not syncing: No init found.  Try passing init= option
>>> to kernel. See Linux Documentation/init.txt for guidance.
>>
>> I don't know that rootfs but it looks like there is no init.
> 
> Ofcourse there's an init on the busybox-rootfs, and I'm able to boot
> it with an x86_64 Linux. The reason for panic is incorrect: I think
> (although not sure) a 32-bit rootfs userland will work.

A 32Bit UML kernel can run 32Bit users, a 64Bit UML kernel can only
run 64Bit userland. We have no 32Bit compat layer on x86_64.
Patches are welcome.

>>> [1]    25526 abort (core dumped)  linux ubd0=busybox-rootfs
>>>                                                            %
>>>
>>> Rubbish.
>>
>> UML core dumps at panic() by design.
> 
> On a related note, why does it screw up my terminal? I have to `reset`
> to get a nice working terminal.

I really don't know. That is not by design.

>> Seriously, my plan is to get rid of SUBARCH, that's why I did not push your patches
>> upstream and I've send the rid of SUBARCH patch series.
>> It turned out that other archs depend on SUBARCH too therefore some more thinking is needed.
>> Time passed, merge window closed, $dayjob needed some attention...
> 
> Don't let some grand plan stall reasonable patches that fix immediate problems.
> 
>> That said, your "arch/um: make it work with defconfig and x86_64" patch is also not perfect.
>> "make defconfig ARCH=um SUBARCH=x86" will create x86_64 defconfig, which is wrong and breaks existing
>> setups.
> 
> Wrong.
> 
>   $ make defconfig ARCH=um SUBARCH=i386
>   *** Default configuration is based on 'i386_defconfig'
>   #
>   # configuration written to .config
>   #

I wrote "SUBARCH=x86" *not* SUBARCH=i386.

Again, if SUBARCH=x86 works too I'll happily merge it.
But as of now it breaks existing setups.

Thanks,
//richard
