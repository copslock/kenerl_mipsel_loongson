Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Mar 2018 17:12:57 +0100 (CET)
Received: from mail-it0-x241.google.com ([IPv6:2607:f8b0:4001:c0b::241]:32931
        "EHLO mail-it0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991128AbeCNQMvapO4D (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 14 Mar 2018 17:12:51 +0100
Received: by mail-it0-x241.google.com with SMTP id z143-v6so3479403itc.0;
        Wed, 14 Mar 2018 09:12:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=PXhAUM1ujti2ggMq33kfwOh80dumHST2nTNA53edVjI=;
        b=ppKoJqpsqRLnDYIaacNz+bKT8dIg/GhFKesaSHpKbql1NaxXjhOXprJi9rhoqT8AZp
         m8+a/W9k2hUMVfSmoA6HCSyKqMbrttUKEn5W7B2ykjiprS2bqfBW4aTllQCyD2kgIvQA
         H2VjVY80UO/bJ/CfaTvgfidozPqZtFGgGoOjAXxIawP2ELgE9aR6QVvLaOnlh3HeGfcj
         1kp95TNHAZdsdQ/sAnJEhy4TP4YCg/f67iMERJFfKbCGj2oYANLdTtpH390X79BPQDYX
         qLD5bqi0w75mz0HVGO3BUj9J6xF+V/k0KpMEQDQ6YZlRHChsdtvHSWu0ZyB95QZLIf3d
         YPtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=PXhAUM1ujti2ggMq33kfwOh80dumHST2nTNA53edVjI=;
        b=em90I0QI7b0NT6NmX8+9bsnwCCozIv4RrL61gcHed+YKUEuUYQ+hOIPpZBxkyeIadQ
         VF1bTC5vj/hQZfzTwMrE/DsSdjgdiMSp0V/DWd8VvlLGMQa6jPf5QdwNmj/gIBuKyTUR
         LChuhxJ9b/5u0k0BwPWQEgiGsnA6YrfsWNkTUmt4nSYBTnO7kBe8q+qVGmvNVNd1y1V7
         Hw30LX8klDbSic6uw2pKcDpj99agYSc8uRQqDqGhCtZLEPPaH6pXLkT8KFo74hw/gAQ1
         QPOBvx5P6oobmq4FXN3wHhXTloeypVU/iMum8iLgVGFY/Yq9GOb46FgrfDjajKpt7cxJ
         TxVA==
X-Gm-Message-State: AElRT7GpilhnPxKu2s6PCANaPqg27NigFl46ovtVbFO/b+H4ObwuavWV
        BeilbsJ9wWSyvQBysSWxQG6Jy5U0t3+wNpNmFIo=
X-Google-Smtp-Source: AG47ELttrolLvbH6pRWypHIk4oaUmp3fA0Mub2DNQZPCyhlM9dLz1gia3Qw2E7NjjxwliykkMaJzQUrnVxn1Ptp6LQk=
X-Received: by 2002:a24:be09:: with SMTP id i9-v6mr2488932itf.27.1521043965060;
 Wed, 14 Mar 2018 09:12:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.79.34.71 with HTTP; Wed, 14 Mar 2018 09:12:44 -0700 (PDT)
In-Reply-To: <20180314040333.3291-1-deepa.kernel@gmail.com>
References: <20180314040333.3291-1-deepa.kernel@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Wed, 14 Mar 2018 17:12:44 +0100
X-Google-Sender-Auth: luhBzRJ6eLFWYRsu7hdv5zZRR4g
Message-ID: <CAK8P3a3hbD=-P1wBwXEOnMdewGsUpZPERBHv6wo+3qqDkZD1qg@mail.gmail.com>
Subject: Re: [PATCH v5 00/10] posix_clocks: Prepare syscalls for 64 bit time_t conversion
To:     Deepa Dinamani <deepa.kernel@gmail.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        John Stultz <john.stultz@linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Chris Metcalf <cmetcalf@mellanox.com>, cohuck@redhat.com,
        David Miller <davem@davemloft.net>,
        Helge Deller <deller@gmx.de>, devel@driverdev.osuosl.org,
        gerald.schaefer@de.ibm.com, gregkh <gregkh@linuxfoundation.org>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Jan Hoeppner <hoeppner@linux.vnet.ibm.com>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "James E.J. Bottomley" <jejb@parisc-linux.org>,
        Julian Wiedmann <jwi@linux.vnet.ibm.com>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Parisc List <linux-parisc@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Peter Oberparleiter <oberpar@linux.vnet.ibm.com>,
        oprofile-list@lists.sf.net, Paul Mackerras <paulus@samba.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Robert Richter <rric@kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        sebott@linux.vnet.ibm.com, sparclinux <sparclinux@vger.kernel.org>,
        Stefan Haberland <sth@linux.vnet.ibm.com>,
        Ursula Braun <ubraun@linux.vnet.ibm.com>,
        Will Deacon <will.deacon@arm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62977
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arnd@arndb.de
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

On Wed, Mar 14, 2018 at 5:03 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> The series is a preparation series for individual architectures
> to use 64 bit time_t syscalls in compat and 32 bit emulation modes.
>
> This is a follow up to the series Arnd Bergmann posted:
> https://sourceware.org/ml/libc-alpha/2015-05/msg00070.html [1]
>
> Thomas, Arnd, this seems ready to be merged now.
> Can you help get this merged?
>
> Big picture is as per the lwn article:
> https://lwn.net/Articles/643234/ [2]
>
> The series is directed at converting posix clock syscalls:
> clock_gettime, clock_settime, clock_getres and clock_nanosleep
> to use a new data structure __kernel_timespec at syscall boundaries.
> __kernel_timespec maintains 64 bit time_t across all execution modes.
>
> vdso will be handled as part of each architecture when they enable
> support for 64 bit time_t.
>
> The compat syscalls are repurposed to provide backward compatibility
> by using them as native syscalls as well for 32 bit architectures.
> They will continue to use timespec at syscall boundaries.
>
> CONFIG_64_BIT_TIME controls whether the syscalls use __kernel_timespec
> or timespec at syscall boundaries.
>
> The series does the following:
> 1. Enable compat syscalls on 32 bit architectures.
> 2. Add a new __kernel_timespec type to be used as the data structure
>    for all the new syscalls.
> 3. Add new config CONFIG_64BIT_TIME(intead of the CONFIG_COMPAT_TIME in
>    [1] and [2] to switch to new definition of __kernel_timespec. It is
>    the same as struct timespec otherwise.
> 4. Add new CONFIG_32BIT_TIME to conditionally compile compat syscalls.

I've applied all 10 patches to my y2038 git branch [1], which is part
of linux-next,
to give it a little wider testing. If everything goes well, I'd send a
pull request to
Thomas next week so he can integrate it into tip from there, or (if he prefers)
send it directly to Linus in the merge window.

Thanks a lot for your persistence and your work on this!

      Arnd

[1] git://git.kernel.org/pub/scm/linux/kernel/git/arnd/playground.git#y2038
