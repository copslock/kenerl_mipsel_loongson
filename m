Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 14 Nov 2017 15:24:53 +0100 (CET)
Received: from mail-qk0-x242.google.com ([IPv6:2607:f8b0:400d:c09::242]:51671
        "EHLO mail-qk0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992724AbdKNOYquL3Py (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 14 Nov 2017 15:24:46 +0100
Received: by mail-qk0-x242.google.com with SMTP id f63so9726192qke.8;
        Tue, 14 Nov 2017 06:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=63wVBRFDD5IXE1oFYN4U5y23nIPoeFWTS7VC6hGV0j0=;
        b=fpoVBS7a20gbhNlmtdGvJF2PtXxYa89JxpGFL+3y8mTanrsTzF6BIqoRQrYg4z5qHq
         DE2NJoxj5AveuRn0l2kfjvQFpOsLklODETEvGH0NurD4Hh4RzKDdkzisUSOnzqbHhRbP
         nL977us3bga5Wvq1atagh4c92ZbcnLt0NQ9QdXTZLfBszKuR8yM60oXsP7SXn3MTY1UF
         yYyr2+C5/+t+bFZlOJpLtbIpBCgQlQMIgvc37X379PNcuZsgWGpGOilerCo/PCoet4rp
         QeR75Fhav762D/zOJvNwZgvA33JCCe6P+oHqU2uGHFM9BYYK1cIKSrDZb7zdjhXfOZK+
         ec2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=63wVBRFDD5IXE1oFYN4U5y23nIPoeFWTS7VC6hGV0j0=;
        b=e6LGmoikI8tNSFKtMjlY4WSi6GV6QDDCguUjnWrvwHnZwCCqtiEOLXPV9H/+MEl3Hr
         qYkePk8ienY7pR0EPVyviFpcg5wP47ybU9xztxkafPZzVjx2F2PfDmOhL63KSTU7dYDg
         kx0lyUDmEr9aMQU4dDBItooTajG+fqM9f15T0ndKyF8FdWgoCheaGQkPfcxUzQq/eGru
         tEeVGMng/2RwaQk18OwXmhcw8/ysPcxwaBNYLg+g3G7dvn9pXgG5kc8a/27xlr8aWvAI
         eqJ04JizaEH+Qyh064VYlMbmDRKeo+R924z6foq0//J2wgJDkf7OJuBBJ9exNG6zyJrx
         0/aw==
X-Gm-Message-State: AJaThX7x6Lp72dKJRxUafERivqejx0DU0jh4mnBfP7PDW1bZjOJNimeI
        OaDzmdzrhFb6nAu5EBWfhdzG19AFTdrqhkewg38=
X-Google-Smtp-Source: AGs4zMZlweHwtNJ6NextUglajEeNPPUaGSzd09g+fJXQyW3O5alqPoUzBXBqBh9Ui3vtwWew6M0bXdRwo85+QFpiClI=
X-Received: by 10.55.20.96 with SMTP id e93mr19272819qkh.253.1510669480719;
 Tue, 14 Nov 2017 06:24:40 -0800 (PST)
MIME-Version: 1.0
Received: by 10.200.47.182 with HTTP; Tue, 14 Nov 2017 06:24:40 -0800 (PST)
In-Reply-To: <20171110224259.15930-1-deepa.kernel@gmail.com>
References: <20171110224259.15930-1-deepa.kernel@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 14 Nov 2017 15:24:40 +0100
X-Google-Sender-Auth: GNPylGxIku_J1NINxTv2WxcotoI
Message-ID: <CAK8P3a2uD=xV5GKtL+nhVoPckb6uoXztEvXK-iP_OYbct8QvJA@mail.gmail.com>
Subject: Re: [PATCH 0/9] posix_clocks: Prepare syscalls for 64 bit time_t conversion
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
        Steven Rostedt <rostedt@goodmis.org>, rric@kernel.org,
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
X-archive-position: 60920
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

On Fri, Nov 10, 2017 at 11:42 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
> The series is a preparation series for individual architectures
> to use 64 bit time_t syscalls in compat and 32 bit emulation modes.
>
> This is a follow up to the series Arnd Bergmann posted:
> https://sourceware.org/ml/libc-alpha/2015-05/msg00070.html
>
> Big picture is as per the lwn article:
> https://lwn.net/Articles/643234/
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
> 1. Enable compat syscalls unconditionally.
> 2. Add a new __kernel_timespec type to be used as the data structure
>    for all the new syscalls.
> 3. Add new config CONFIG_64BIT_TIME(intead of the CONFIG_COMPAT_TIME in
>    [1] and [2] to switch to new definition of __kernel_timespec. It is
>    the same as struct timespec otherwise.
>
> Arnd Bergmann (1):
>   y2038: introduce CONFIG_64BIT_TIME

The series looks good to me overall, and I've added it to my build-testing tree
to see if it shows any regressions in random configurations.

I had on concern about x32, maybe we should check
for "COMPAT_USE_64BIT_TIME" before zeroing out the tv_nsec
bits.

Regarding CONFIG_COMPAT_TIME/CONFIG_64BIT_TIME, would
it help to just leave out that part for now and unconditionally
define '__kernel_timespec' as 'timespec' until we are ready to
convert the architectures?

       Arnd
