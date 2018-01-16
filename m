Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Jan 2018 16:18:51 +0100 (CET)
Received: from mail-oi0-x242.google.com ([IPv6:2607:f8b0:4003:c06::242]:34923
        "EHLO mail-oi0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994630AbeAPPSodEx8f (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Jan 2018 16:18:44 +0100
Received: by mail-oi0-x242.google.com with SMTP id j139so7806858oih.2;
        Tue, 16 Jan 2018 07:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=jajhbmIdbICo5gmpwu28sFz07TcnGk31k3BPn2lO4Ls=;
        b=OwGrKFsGrRG2Oqy/oLAusSEZrAGRUq5I79UE1jQOMWzbG38vCW2kNNlkWq/RFze+u3
         mMlEfKnPmdpJM4JBz4591CbBXlm0oZlfZv6cMWd1TMkSESdtq7kJ/dgGTVCwOUN0T1lD
         9pSYK2u7hTlCdX5wkUL6r1TS4dyZBGH1DyX24K8JYrZ9fDfZR57sUG4XKy3JQ6Hb6Ryf
         hIOFmlfUIhz8E36ZZY3e7y2JgsVxlgnXcVfio9Y3osIGc5xmBvgakvIMUQqx8bewSvPl
         pKWgLyvn96PsKzkOWOVSpnFpj8Vg5ydQtLz9Mxf29XzN4qjINgmTX0nDSFCR+I1ij3NQ
         YKkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=jajhbmIdbICo5gmpwu28sFz07TcnGk31k3BPn2lO4Ls=;
        b=hS2P3OYs3w3wtkOrmO0lR3mncAsRgSmMn2WwnF4TYe+ecYZ7h/N7yUa4fHN/CgFS0w
         9X+UluzK+OQtoix91BJ6wbBLl4sDHBiRa8w1f7eCsivKyRKl5d83mzIPrTMR6yxKeDuV
         eTWvlZW5W73AiE0XAYD7suUxEGyh6+8BXjMnuNJZijHFXCM86r0SVm3oEVE6gz5NgdYL
         oHfH7569f0cgFKsAfq5wwygUeP2KvFlR3WD0lklBtGoFCm1LxNfXGhh4xk0K6j8lB2jU
         JAPrVC1zEBo3zlOrvk8+hjMgatGPBi68wWAlmSI83qwglMfR5/Q9lRkQY4w1/5tuYIGw
         x1RQ==
X-Gm-Message-State: AKwxyteX0uUTAKg7GKMdsTFZQemDWosx91xv/leGCCRHr2jLbPkGo+v1
        7uR/o2v7PeJkU4H0wCHjnbKTaicydXe0kVA97IY=
X-Google-Smtp-Source: ACJfBovo6Xgi6PaPplq9SoC00vsrK9bJIICRm/RTSLTBFLSbVXoUQ5muUvbzhoHdQIcEGkNK09nTsf4PXotb/CTe71c=
X-Received: by 10.202.175.76 with SMTP id y73mr16393112oie.53.1516115918026;
 Tue, 16 Jan 2018 07:18:38 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.17.89 with HTTP; Tue, 16 Jan 2018 07:18:37 -0800 (PST)
In-Reply-To: <20180116021818.24791-1-deepa.kernel@gmail.com>
References: <20180116021818.24791-1-deepa.kernel@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 16 Jan 2018 16:18:37 +0100
X-Google-Sender-Auth: RJCEzeST_QtE5ITgzNn3zM3ATVY
Message-ID: <CAK8P3a2NjS2tTS0Jzrv2HoAg5Xz=DbOJD=0-JZi65_uGmKa8sA@mail.gmail.com>
Subject: Re: [PATCH v3 00/10] posix_clocks: Prepare syscalls for 64 bit time_t conversion
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
X-archive-position: 62173
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

On Tue, Jan 16, 2018 at 3:18 AM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
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

This looks all good to me. I think we should have this included in linux-next as
soon as possible, but this probably means after -rc1 at the current point, since
it's a bit late for 4.16.

I'll pick up the series into my randconfig build tree again to find
possible build
time regressions. Otherwise the way I'd stage it out is to put it into my y2038
branch after -rc1 and then send a pull request to Thomas for the tip tree
a week later. It seems unlikely that any major problems come up, so we could
plan to address additional requests for changes by adding commits on top
once it's in linux-next.

       Arnd
