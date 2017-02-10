Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Feb 2017 01:01:59 +0100 (CET)
Received: from mail-ua0-x233.google.com ([IPv6:2607:f8b0:400c:c08::233]:35572
        "EHLO mail-ua0-x233.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993331AbdBJABwzuTvd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Feb 2017 01:01:52 +0100
Received: by mail-ua0-x233.google.com with SMTP id y9so16208378uae.2;
        Thu, 09 Feb 2017 16:01:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=iKM36eXWukzXjVZmL1HUUsw2gKJZLS+R3pdVntMOrwU=;
        b=GIwGmcMOWwZI83KspycxoTCnNIfmI24rRD2d58xL/32fvrYUgseVsYpmZD2dZ3WI0C
         KbjdVqS7jh1YjsQoGm+v6yaNDsck8gm58EN4wZrZ4NaFKHlXSQfOLZ0pzBn3RF9yvzRi
         1PRmFbzzKKW8Fy1huEhkfGsV9zlKXMJfgx55rigEgAYqveTGUBN/8l7HmUKI7KjnjzK/
         mnTKxieqlCrFuUTWsulLO2hEtZTSneRVylM/U+laAG41qgwsDQ7pI0At4pSU0BlIrgAm
         8TXbI7m0SEyFoqZHPaZpBclKFriTT6NTMLjjhcd//tWce8qeNnN0eOrP2MuLqsXN37lI
         8FYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=iKM36eXWukzXjVZmL1HUUsw2gKJZLS+R3pdVntMOrwU=;
        b=KvgM3MFpYtyHWVtywO5d807iyUWshq+zBTzc1fh3DBhsYD4JtCpZ2kiRDqtkCo3vk3
         umn2/OCS22KdDupdlvCO106jpO/X4x56ZTr0xylTeEhaGC6YeU0Lm8KsrCoKaouvZ3i1
         5g4DF98Ly/ORY9JlueSdaB5R5IeNJjMU7DC6kVD+NOzCI3R4K2ONS5HwO3QfWyt6YJFu
         /NOu6tcixxus2n+pCu3CVI05dv7YuBuPfDOW029Wzwpl4FO+Xol4FhY1iHyzUGL2N3Qk
         VpnaCckRFwDwWpViCaBr7S0IlohZMA3fEjJXqfIfHSSX67j8jq1JQLhFFI2K89fVrWUz
         +MZA==
X-Gm-Message-State: AMke39ntJPypApbG/oZelNrdiO7a12M2a0Sf41Ue9LugYHOuv8PhcPZIUS0f9kQtpKmefSro4EBuFjn35X46uA==
X-Received: by 10.176.6.3 with SMTP id f3mr2620769uaf.37.1486684907026; Thu,
 09 Feb 2017 16:01:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.103.20.2 with HTTP; Thu, 9 Feb 2017 16:01:46 -0800 (PST)
In-Reply-To: <20170208234523.GA13263@roeck-us.net>
References: <20170208234523.GA13263@roeck-us.net>
From:   Justin Chen <justinpopo6@gmail.com>
Date:   Thu, 9 Feb 2017 16:01:46 -0800
Message-ID: <CAJx26kWDuH2AbibrOdHi7yh9YG314T7J5Zz7CwgTrZCfwDGuYw@mail.gmail.com>
Subject: Re: Crash in -next due to 'MIPS: Add cacheinfo support'
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Justin Chen <justin.chen@broadcom.com>, linux-mips@linux-mips.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <justinpopo6@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56749
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: justinpopo6@gmail.com
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

Hello Guenter,

I am unable to reproduce the problem. May you give me more details?

I rebased my patch onto of 4.10-rc7 and compiled with malta defconfig
with disabled SMP. Then booted with qemu. Doesn't seem to have an
error with the way I have it set up.

I am using the command:
qemu-system-mipsel -kernel vmlinux -nographic -smp 0

Thanks,
Justin

On Wed, Feb 8, 2017 at 3:45 PM, Guenter Roeck <linux@roeck-us.net> wrote:
> Hi Justin,
>
> The 32-bit qemu mips runtime tests for -next at kerneltests.org are crashing
> for non-SMP builds as follows.
>
> cacheinfo: Failed to find cpu0 device node
> cacheinfo: Unable to detect cache hierarchy for CPU 0
> CPU 0 Unable to handle kernel paging request at virtual address 00000004, epc ==
> 8013c6a8, ra == 8013cb54
> Oops[#1]:
> CPU: 0 PID: 5 Comm: kworker/u2:0 Not tainted 4.10.0-rc7-next-20170208 #1
> Workqueue: events_unbound call_usermodehelper_exec_work
> task: 8704a420 task.stack: 87068000
> $ 0   : 00000000 80770000 873a8204 8700c214
> $ 4   : 00000000 873a8200 00000000 ffff00fe
> $ 8   : 8706bfe0 0000a400 fffffffc 8704a459
> $12   : 00000000 00000000 00000000 00000720
> $16   : 873a8200 87045880 00000000 8700c200
> $20   : 87014000 87014005 8700c200 8700c200
> $24   : 00000000 8014d1e8
> $28   : 87068000 8706be70 87045880 8013cb54
> Hi    : 00077698
> Lo    : ab801af8
> epc   : 8013c6a8 process_one_work+0xd4/0x408
> ra    : 8013cb54 worker_thread+0x178/0x598
> Status: 1000a402        KERNEL EXL
> Cause : 0080000c (ExcCode 03)
> BadVA : 00000004
> PrId  : 00019300 (MIPS 24Kc)
> Modules linked in:
> Process kworker/u2:0 (pid: 5, threadinfo=87068000, task=8704a420, tls=00000000)
> Stack : 80700000 8700c214 00000088 80700000 8700c200 8700c200 8700c200 87045898
>         80700000 8700c214 00000088 80700000 8700c200 8013cb54 8013c9dc 8704fe00
>         87045600 87045700 80700000 80700000 80700000 80676560 87045600 87045700
>         87045618 87045880 8013c9dc 8704fe00 80670000 80760000 806e0000 80142958
>         00000000 00000000 00000000 00000000 80142850 80142850 87045700 8704b380
>         ...
> Call Trace:
> [<8013c6a8>] process_one_work+0xd4/0x408
> [<8013cb54>] worker_thread+0x178/0x598
> [<80142958>] kthread+0x108/0x138
> [<80105e18>] ret_from_kernel_thread+0x14/0x1c
> Code: 8e030008  8e040004  8e150000 <ac830004> 7eb51900  ac640000  ae020004 16400094  ae020008
>
> Bisect points to 'MIPS: Add cacheinfo support'; see below for details.
> Reverting this patch fixes te problem.
>
> Configuration is pretty much malta_defconfig with SMP disabled.
> I can provide more details if needed.
>
> Thanks,
> Guenter
>
> ---
> # bad: [e3e6c5f3544c5d05c6b3b309a34f4f2c3537e993] Add linux-next specific files for 20170208
> # good: [d5adbfcd5f7bcc6fa58a41c5c5ada0e5c826ce2c] Linux 4.10-rc7
> git bisect start 'HEAD' 'v4.10-rc7'
> # bad: [403e468309f9e2b2dbe264be1ad29b1486ed720e] Merge remote-tracking branch 'crypto/master'
> git bisect bad 403e468309f9e2b2dbe264be1ad29b1486ed720e
> # bad: [44448c3f07a3ae77164de4405fa97baca4f103f5] Merge remote-tracking branch 'hid/for-next'
> git bisect bad 44448c3f07a3ae77164de4405fa97baca4f103f5
> # good: [dd4318312c6fc5c00ae7619f875fb73538a2c1e6] Merge remote-tracking branch 'omap/for-next'
> git bisect good dd4318312c6fc5c00ae7619f875fb73538a2c1e6
> # bad: [2fe482530119a6d07acca625b29d527dc22435e6] Merge remote-tracking branch 'powerpc/next'
> git bisect bad 2fe482530119a6d07acca625b29d527dc22435e6
> # good: [8576190cecf3370ce07ed04178cb3ecbf17dc2d9] Merge remote-tracking branch 'clk/clk-next'
> git bisect good 8576190cecf3370ce07ed04178cb3ecbf17dc2d9
> # bad: [bf0505dfeac3f7df81b62d9d81987aaef6739ffd] MIPS: Fix special case in 64 bit IP checksumming.
> git bisect bad bf0505dfeac3f7df81b62d9d81987aaef6739ffd
> # good: [e89ef66d7682f031f026eee6bba03c8c2248d2a9] MIPS: init: Ensure reserved memory regions are not added to bootmem
> git bisect good e89ef66d7682f031f026eee6bba03c8c2248d2a9
> # bad: [a8b3b0c94ac282628f0668d1366239a3fa72dc9d] MIPS: Netlogic: Fix assembler warning from smpboot.S
> git bisect bad a8b3b0c94ac282628f0668d1366239a3fa72dc9d
> # bad: [07724712bf22aec5fe44e5d399f115755f436721] MIPS: ralink: Add missing symbol for highmem support.
> git bisect bad 07724712bf22aec5fe44e5d399f115755f436721
> # good: [856b0f591e951a234d6642cc466023df182eb51c] MIPS: kexec: add debug info about the new kexec'ed image
> git bisect good 856b0f591e951a234d6642cc466023df182eb51c
> # bad: [2517caf19dbfac3b39f2db5500c5fd03c4370e81] MIPS: ralink: Add missing I2C and I2S clocks.
> git bisect bad 2517caf19dbfac3b39f2db5500c5fd03c4370e81
> # bad: [ef462f3b64e9fb0c8e1cd5d60f5bd7f13ac2156d] MIPS: Add cacheinfo support
> git bisect bad ef462f3b64e9fb0c8e1cd5d60f5bd7f13ac2156d
> # good: [0014dea6b71ae3e0384c3358f632b4728c3d432e] MIPS: generic/kexec: add support for a DTB passed in a separate buffer
> git bisect good 0014dea6b71ae3e0384c3358f632b4728c3d432e
> # first bad commit: [ef462f3b64e9fb0c8e1cd5d60f5bd7f13ac2156d] MIPS: Add cacheinfo support
>
>
