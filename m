Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Nov 2017 22:58:51 +0100 (CET)
Received: from mail-ot0-x243.google.com ([IPv6:2607:f8b0:4003:c0f::243]:41478
        "EHLO mail-ot0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990412AbdK0V6oXGKQr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Nov 2017 22:58:44 +0100
Received: by mail-ot0-x243.google.com with SMTP id b54so25608854otd.8;
        Mon, 27 Nov 2017 13:58:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=Gzda+Nc8Imjuh/KDTEuL2OSCVh1qb8x0xC5d37cenNE=;
        b=s0q3Sc4aGtTlsOt9vK1DHxT13WamsQ+LOq/8mQWoa2jSI1j3jtdtN+JT8ocKzVQUS6
         UlIRujnjIZHpQYcyk5emUJkwCMWMa+o+iEhNOv9nZrRg0KfBW+JE/VHhSGDGym2daa0I
         VX9TsCtxT8ARt8K7vI5DnlI5g/t7chGLyHJoter4hd0W1lohWTIJwxKYVUEcMmMUMp6M
         93LP6JlxPer+nBd6YBlQl3cFkWYc9PzygSMwajcQFByFBAOLpfa9AfVcvZJ0EC3HoAOm
         58CfJxmO2gnMdWeXMfVs5oZLfLEAFQYyZ8wXMmGU0q3p3mBHfXMtgu2GnIgAnsa4kgvi
         Xq0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=Gzda+Nc8Imjuh/KDTEuL2OSCVh1qb8x0xC5d37cenNE=;
        b=qFB/zlVlL+/7Xs++zXUs7vh28kKRRV3xP9x2reeIkhD9fxR/5UB12LjG53k8t7dwvH
         STIJfmAoaPFub/73kFLxIIPFF2FN2ODidW0cQhIgrZnwxXbzg2YtyQ+pITA0RzPgqtKA
         3yh4ET/ycMHAumX90Z1hHvjAXnXjD0EdLWPDLS6F6EegkzT5mnIqQxUh63cLnTwQqFAw
         n/m9+5/AgchyP2P4nusqI0hk+lmH9OZPWeYHHwm6LfdmcMUIAZdnkiIpojyVHaUla0R/
         cxZDd6QP76o6jFWkr2Dww8OwiA8VCAHwmOqQdOAzgF0EhfYrUaT0VSj0KRvEkFrZsVuY
         dBRA==
X-Gm-Message-State: AJaThX5C41YMTbtgIq2VwPuSpVIKvyB1OEuuZFaJNIAeFU5JbSVAvnXJ
        KZx/Ksxsa7F9a+BB2dM7wXbRY46D8Stgd1UMUgs=
X-Google-Smtp-Source: AGs4zMZJYhM175BGS16AeFskx3P+MYn4LVr3VnsWDo6/ukdzwgEAvsKxu4T16RWpXTDaytHcsdPQfo04i7bRFwGxsIo=
X-Received: by 10.157.12.147 with SMTP id b19mr27076029otb.229.1511819917367;
 Mon, 27 Nov 2017 13:58:37 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.43.3 with HTTP; Mon, 27 Nov 2017 13:58:36 -0800 (PST)
In-Reply-To: <20171127193037.8711-1-deepa.kernel@gmail.com>
References: <20171127193037.8711-1-deepa.kernel@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 27 Nov 2017 22:58:36 +0100
X-Google-Sender-Auth: ePx-bqahvx1XbWy7Bt8HGp7O9vo
Message-ID: <CAK8P3a2pcpQqf_TNGVxLBePBSKYhxD90UN-FjBor4d-dKhAwbQ@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] posix_clocks: Prepare syscalls for 64 bit time_t conversion
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
        oberpar@linux.vnet.ibm.com, oprofile-list@lists.sf.net,
        Paul Mackerras <paulus@samba.org>,
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
X-archive-position: 61110
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

On Mon, Nov 27, 2017 at 8:30 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> The series is a preparation series for individual architectures
> to use 64 bit time_t syscalls in compat and 32 bit emulation modes.
>
> This is a follow up to the series Arnd Bergmann posted:
> https://sourceware.org/ml/libc-alpha/2015-05/msg00070.html [1]
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
>
> * Changes since v1:
>  * Introduce CONFIG_32BIT_TIME
>  * Fixed zeroing out of higher order bits of tv_nsec
>  * Included Arnd's changes to fix up use of compat headers

Very nice. I think it would be good to get this into linux-next soon so we
can build on top of this. I have submitted most other y2038 patches today
that don't depend on either this or one of my other patches.

There is one patch that I want to do but haven't imlpemented yet, to merge
get_timespec64() and compat_get_timespec() into one function that
take a bunch of flags (check nanosecond, nano/microsecond,
zero upper half of nanoseconds, 32-bit or 64-bit wide), since I found
a few functions that need more than one of these, and they don't
all need the same combinations. My patch will certainly conflict
with yours, as your touch the same functions, but that's fine.

If you end up doing another version of the series though, it might
be better to move the compat accessors into kernel/time/time.c
along with the native functions, that should make it easier to
consolidate them later.

> I decided against using LEGACY_TIME_SYSCALLS to conditionally compile
> legacy time syscalls such as sys_nanosleep because this will need to
> enclose compat_sys_nanosleep as well. So, defining it as
>
> config LEGACY_TIME_SYSCALLS
>      def_bool 64BIT || !64BIT_TIME
>
> will not include compat_sys_nanosleep. We will instead need a new config to
> exclusively mark legacy syscalls.

Do you mean we would need to do this separately for native and compat
syscalls, and have yet another option, like LEGACY_TIME_SYSCALLS
and LEGACY_TIME_COMPAT_SYSCALLS, to cover all cases? I would
think that CONFIG_COMPAT_32BIT_TIME handles all the compat versions,
while CONFIG_LEGACY_TIME_SYSCALLS handles all the native ones.

       Arnd
