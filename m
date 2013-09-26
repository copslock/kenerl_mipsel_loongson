Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 26 Sep 2013 12:21:05 +0200 (CEST)
Received: from mail-ie0-f174.google.com ([209.85.223.174]:42166 "EHLO
        mail-ie0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6818323Ab3IZKVBj860b (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 26 Sep 2013 12:21:01 +0200
Received: by mail-ie0-f174.google.com with SMTP id u16so1073206iet.5
        for <multiple recipients>; Thu, 26 Sep 2013 03:20:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=+LLXFZ2k9HQHPj6Xm6r0C4YcNzQ8BskeixVGGe/XGpY=;
        b=mC8qlzzvwtw/o6TYj2w3sJ/tG13cg9uqnnOKTuMZ9Psps2NLbjdfbZwc83c9NDYiNi
         vxuqhfSwJ9NOiNp+Z9WvUvAQO40cMddpkPki6yZOOthP8hpqZOiyAftqv8lngsel4EZb
         zfNcQq5Ob0ULf3WI+7Q+oDKk4+t6TgYwemVP975TOI/R0owSWfXFidZGiJw3kF69fprJ
         maQGIny/rDr2mO1AYYmxa73MemwSj7piqkRlQw1GnDrFleFFhaTwONuPEpQ8WobAuhWq
         sEeUv4wX0UpBnV/8N/z8ozOzDvqtzEtaOqSPFXm6qAoPNAQ5fVcNFhgUS7XfoRNFKYUx
         6dTw==
X-Received: by 10.43.104.73 with SMTP id dl9mr96579icc.39.1380190855188; Thu,
 26 Sep 2013 03:20:55 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.64.73.36 with HTTP; Thu, 26 Sep 2013 03:20:15 -0700 (PDT)
In-Reply-To: <1377073172-3662-2-git-send-email-richard@nod.at>
References: <1377073172-3662-1-git-send-email-richard@nod.at> <1377073172-3662-2-git-send-email-richard@nod.at>
From:   Ramkumar Ramachandra <artagnon@gmail.com>
Date:   Thu, 26 Sep 2013 15:50:15 +0530
Message-ID: <CALkWK0=W38JpZoGVkPYD4qd=+Pt1G7oYPEK_R=c8TAW6W=wxyg@mail.gmail.com>
Subject: Re: [PATCH 1/8] um: Create defconfigs for i386 and x86_64
To:     Richard Weinberger <richard@nod.at>
Cc:     linux-arch@vger.kernel.org, Michal Marek <mmarek@suse.cz>,
        geert@linux-m68k.org, ralf@linux-mips.org, lethal@linux-sh.org,
        Jeff Dike <jdike@addtoit.com>, gxt@mprc.pku.edu.cn,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        linux-kbuild@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>,
        linux-m68k@lists.linux-m68k.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        user-mode-linux-devel@lists.sourceforge.net
Content-Type: text/plain; charset=UTF-8
Return-Path: <artagnon@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37981
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
> This patch is based on: https://lkml.org/lkml/2013/7/4/396
>
> Cc: Ramkumar Ramachandra <artagnon@gmail.com>
> Signed-off-by: Richard Weinberger <richard@nod.at>
> ---
>  arch/um/configs/i386_defconfig   | 954 +++++++++++++++++++++++++++++++++++++++
>  arch/um/configs/x86_64_defconfig | 943 ++++++++++++++++++++++++++++++++++++++
>  2 files changed, 1897 insertions(+)
>  create mode 100644 arch/um/configs/i386_defconfig
>  create mode 100644 arch/um/configs/x86_64_defconfig

First, I'm pissed that the upstream tree doesn't build and run out of
the box months after I submitted a fix in July (and it's September
now). Fact that you dropped my sane patches aside and decided to write
a much larger series aside, user-mode Linux in upstream is broken.
This means that any user who does:

$ ARCH=um make defconfig
$ ARCH=um make

will end up with a *broken* Linux _today_. Unless the user is living
in the Stone Age with a 32-bit computer, this is what she will see
when she attempts to boot up Linux:

$ file linux
linux: ELF 32-bit LSB  executable, Intel 80386, version 1 (SYSV),
dynamically linked (uses shared libs), for GNU/Linux 2.6.32, not
stripped
$ ./linux ubd0=busybox-rootfs
[...]
Kernel panic - not syncing: No init found.  Try passing init= option
to kernel. See Linux Documentation/init.txt for guidance.
CPU: 0 PID: 1 Comm: swapper Not tainted 3.12.0-rc2-00083-g4b97280 #1
0b869fbc 08272f87 0b869fdc 0820c5cd 00000001 00000000 00000000 00000000
       0b869fe8 0820c126 08252593 0b869ff8 08059317 00000000 00000001 00000000
       00000000 0b869f94:  [<0805a11c>] show_stack+0x54/0x8c
0b869fb4:  [<0820e3c8>] dump_stack+0x16/0x1b
0b869fc8:  [<0820c5cd>] panic+0x67/0x149
0b869fe0:  [<0820c126>] kernel_init+0xab/0xaf
0b869fec:  [<08059317>] new_thread_handler+0x63/0x7c
0b869ffc:  [<00000000>] 0x0


EIP: 0023:[<f7717430>] CPU: 0 Not tainted ESP: 002b:ffc386dc EFLAGS: 00000296
    Not tainted
EAX: 00000000 EBX: 000063ba ECX: 00000013 EDX: 000063ba
ESI: 000063b6 EDI: 00000002 EBP: ffc38708 DS: 002b ES: 002b
0b869f44:  [<0806aff4>] show_regs+0xb4/0xbc
0b869f70:  [<0805b23b>] panic_exit+0x20/0x36
0b869f84:  [<0808521b>] notifier_call_chain+0x28/0x4b
0b869fac:  [<0808526c>] atomic_notifier_call_chain+0x15/0x17
0b869fbc:  [<0820c5de>] panic+0x78/0x149
0b869fe0:  [<0820c126>] kernel_init+0xab/0xaf
0b869fec:  [<08059317>] new_thread_handler+0x63/0x7c
0b869ffc:  [<00000000>] 0x0

[1]    25526 abort (core dumped)  linux ubd0=busybox-rootfs
                                                           %

Rubbish.

When I rebase my original patches (exactly 2 small independent
patches) onto the new upstream, stuff works as usual. If you're not
convinced, try the um-build branch from
https://github.com/artagnon/linux for yourself.

Are you against accepting good patches and stalling work? What is your
plan exactly?

Annoyed,
Ram
