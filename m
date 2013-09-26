Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 13:58:22 +0200 (CEST)
Received: from mail-ie0-f173.google.com ([209.85.223.173]:62798 "EHLO
        mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6822345Ab3IZL6Pw-1Ld (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Sep 2013 13:58:15 +0200
Received: by mail-ie0-f173.google.com with SMTP id ar20so1185369iec.32
        for <multiple recipients>; Thu, 26 Sep 2013 04:58:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=Qn3hU3X9Nx2bwPxSc7EIpzpEQGniY99mJm6uPPmj8Bw=;
        b=aY0gBhxbHv7/df15P8JxWIDI7kgccPRaZ46AezYoA4yE0BVo/1CggY+ogof8jLnRXG
         4ZQmEjyTxWY3bSll8dXNJsSe5QwX5hMUcuSsDni+PFMabDbesTBqjROIyKYMtUrudc5r
         mHM8Q055cgHllJM1lP+bvZ3LsX5bza6aJ35cNS6VkDwKm0uKN/1Jdw7ebLyZpP1HVXDj
         AEytqGjWNXmtiPY/D6x681T3DVGFrsh9vTfqBaoz1iImwQ6g4I+4S7Vs+KEIalnvMpeJ
         GWTcBnJw6M1FFgbGisU4IXvzjxZaNEaFgSTrLD1YwRaJKRqUm/jF9KDiQ6oy3P+tYLaM
         OGyg==
X-Received: by 10.43.126.68 with SMTP id gv4mr671342icc.48.1380196689642; Thu,
 26 Sep 2013 04:58:09 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.73.36 with HTTP; Thu, 26 Sep 2013 04:57:29 -0700 (PDT)
In-Reply-To: <52440DE0.1030807@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at>
 <1377073172-3662-2-git-send-email-richard@nod.at> <CALkWK0=W38JpZoGVkPYD4qd=+Pt1G7oYPEK_R=c8TAW6W=wxyg@mail.gmail.com>
 <52440DE0.1030807@nod.at>
From:   Ramkumar Ramachandra <artagnon@gmail.com>
Date:   Thu, 26 Sep 2013 17:27:29 +0530
Message-ID: <CALkWK0nEy90VrWawTpYsLNJcnyRSizgArCa-qnzpuJQkyK6zHA@mail.gmail.com>
Subject: Re: [PATCH 1/8] um: Create defconfigs for i386 and x86_64
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>,
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
        =?UTF-8?Q?Toralf_F=C3=B6rster?= <toralf.foerster@gmx.de>
Content-Type: text/plain; charset=UTF-8
Return-Path: <artagnon@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37987
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: artagnon@gmail.com
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

Richard Weinberger wrote:
>> $ file linux
>> linux: ELF 32-bit LSB  executable, Intel 80386, version 1 (SYSV),
>> dynamically linked (uses shared libs), for GNU/Linux 2.6.32, not
>> stripped
>> $ ./linux ubd0=busybox-rootfs
>> [...]
>> Kernel panic - not syncing: No init found.  Try passing init= option
>> to kernel. See Linux Documentation/init.txt for guidance.
>
> I don't know that rootfs but it looks like there is no init.

Ofcourse there's an init on the busybox-rootfs, and I'm able to boot
it with an x86_64 Linux. The reason for panic is incorrect: I think
(although not sure) a 32-bit rootfs userland will work.

>> [1]    25526 abort (core dumped)  linux ubd0=busybox-rootfs
>>                                                            %
>>
>> Rubbish.
>
> UML core dumps at panic() by design.

On a related note, why does it screw up my terminal? I have to `reset`
to get a nice working terminal.

> Seriously, my plan is to get rid of SUBARCH, that's why I did not push your patches
> upstream and I've send the rid of SUBARCH patch series.
> It turned out that other archs depend on SUBARCH too therefore some more thinking is needed.
> Time passed, merge window closed, $dayjob needed some attention...

Don't let some grand plan stall reasonable patches that fix immediate problems.

> That said, your "arch/um: make it work with defconfig and x86_64" patch is also not perfect.
> "make defconfig ARCH=um SUBARCH=x86" will create x86_64 defconfig, which is wrong and breaks existing
> setups.

Wrong.

  $ make defconfig ARCH=um SUBARCH=i386
  *** Default configuration is based on 'i386_defconfig'
  #
  # configuration written to .config
  #

I can build a 32-bit kernel just fine with my patch applied.
