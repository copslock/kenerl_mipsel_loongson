Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Nov 2017 15:17:44 +0100 (CET)
Received: from mail-ot0-x244.google.com ([IPv6:2607:f8b0:4003:c0f::244]:38992
        "EHLO mail-ot0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990475AbdK1ORdsWcdy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Nov 2017 15:17:33 +0100
Received: by mail-ot0-x244.google.com with SMTP id v15so405357ote.6;
        Tue, 28 Nov 2017 06:17:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=ZQEoUSgcTqv3amyzAYIsAMrVjGnnTfuiPj74CoMzZWY=;
        b=TjcAJru/ImpTaoWIB3elS8EWFRhWRK+keyFmS1GRTiSGuAVXg4A/Lglp+cb3yNOhNQ
         ufwq0LdVpja/hRWjL92D54/rMtfmJ32v/wppnXkfEVWpyZCJt18r/JYPg8YABKXduP0a
         hQfcyPM1o9Hkdmck7b1ocjDehYniL2ID1c/wDrdobWHvSRF//UU5Dw9MuFGntFue4vJq
         urmDf+bMzhNfY6QtlHPTVmu8D6H60k4WdqEGkbIZJPCPVIlpLUb/I5eYTNYDeHFgphBO
         hWtDFn/EsufIb5wjoAkeUzOo0jbRDQws5oCjOWaevcbAy3zkKQoXKE4N9O9RpbT39WrZ
         Ug5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=ZQEoUSgcTqv3amyzAYIsAMrVjGnnTfuiPj74CoMzZWY=;
        b=RhholvxWPMUiuE1bFtk9oC8GPwQVIXxpQxuYhx/WcUJxtRFPm6042/cjlY1GyneX5d
         64bLe5YsX6z5mUwGZoldEhHeYj4+N6QVY8IdsxIseDl/9FW86yk5d62PRRoL2+5JjqGW
         8Bu+m95s+7sX+JFK0VMJE0w6WLg4kQYrJTSBZUcQVTR/IJ/nF7F9TddfAeiiJpMk7dpF
         XXuukETx/cUbAtPmXJZKOD34pm37AA70fY4ASZBlbKf/Ne7KT5iM2p8/QmBkLzRniJ8e
         GwDNR75p9GTtvTxcMF9eqWi++bjuJnm20Qoz6LcLiNAuahagmy+AMCfnu/kOjupPXFvd
         VPxA==
X-Gm-Message-State: AJaThX4mbsRgjcuI4kM8Ef4rjrNLkjNND1tNDVdn6j2hL5l2sSJfIm6D
        gJx0285b1LXrsQ/H9B8O03b2ursxnyMHZ6Qpp7Y=
X-Google-Smtp-Source: AGs4zMY0NLif33JZqn6sBVRHZs9m+L+9co6gESZ3iAd+RBsavVFM4SmhYFgBIXHdZc9KttSk8hko4AwwifZxhKB75ko=
X-Received: by 10.157.12.147 with SMTP id b19mr28847317otb.229.1511878647152;
 Tue, 28 Nov 2017 06:17:27 -0800 (PST)
MIME-Version: 1.0
Received: by 10.157.43.3 with HTTP; Tue, 28 Nov 2017 06:17:26 -0800 (PST)
In-Reply-To: <CABeXuvrBOSVTNSbEZZMKmuTgWeU_VDqjSZkwGAM+bnPh0-72zA@mail.gmail.com>
References: <20171127193037.8711-1-deepa.kernel@gmail.com> <CAK8P3a2pcpQqf_TNGVxLBePBSKYhxD90UN-FjBor4d-dKhAwbQ@mail.gmail.com>
 <CABeXuvrBOSVTNSbEZZMKmuTgWeU_VDqjSZkwGAM+bnPh0-72zA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 28 Nov 2017 15:17:26 +0100
X-Google-Sender-Auth: YTQssOFLbGYl6XsKlDtwYxD9NFk
Message-ID: <CAK8P3a26g74UA5J5uQLwdjK3hq+htzjrdTYRKqfy_MawY7st+g@mail.gmail.com>
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
X-archive-position: 61135
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

On Mon, Nov 27, 2017 at 11:29 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>>> I decided against using LEGACY_TIME_SYSCALLS to conditionally compile
>>> legacy time syscalls such as sys_nanosleep because this will need to
>>> enclose compat_sys_nanosleep as well. So, defining it as
>>>
>>> config LEGACY_TIME_SYSCALLS
>>>      def_bool 64BIT || !64BIT_TIME
>>>
>>> will not include compat_sys_nanosleep. We will instead need a new config to
>>> exclusively mark legacy syscalls.
>>
>> Do you mean we would need to do this separately for native and compat
>> syscalls, and have yet another option, like LEGACY_TIME_SYSCALLS
>> and LEGACY_TIME_COMPAT_SYSCALLS, to cover all cases? I would
>> think that CONFIG_COMPAT_32BIT_TIME handles all the compat versions,
>> while CONFIG_LEGACY_TIME_SYSCALLS handles all the native ones.
>
> I meant sys_nanosleep would be covered by LEGACY_TIME_SYSCALLS, but
> compat_sys_nanosleep would be covered by CONFIG_COMPAT_32BIT_TIME
> along with other compat syscalls.
> So, if we define the LEGACY_TIME_SYSCALLS as
>
>
>         "This controls the compilation of the following system calls:
>         time, stime, gettimeofday, settimeofday, adjtimex, nanosleep,
> alarm, getitimer,
>         setitimer, select, utime, utimes, futimesat, and
> {old,new}{l,f,}stat{,64}.
>         These all pass 32-bit time_t arguments on 32-bit architectures and
>         are replaced by other interfaces (e.g. posix timers and clocks, statx).
>         C libraries implementing 64-bit time_t in 32-bit architectures have to
>         implement the handles by wrapping around the newer interfaces.
>         New architectures should not explicitly enable this."
>
> This would not be really true as compat interfaces have nothing to do
> with this config.
>
> I was proposing that we could have LEGACY_TIME_SYSCALLS config, but
> then have all these "deprecated" syscalls be enclosed within this,
> compat or not.
> This will also mean that we will have to come up representing these
> syscalls in the syscall header files.
> This can be a separate patch and this series can be merged as is if
> everyone agrees.

I think doing this separately  would be good, I don't see any interdependency
with the other patches, we just need to decide what we want in the long
run.

I agree my text that you cited doesn't capture the situation correctly,
as this is really about the obsolete system calls that take 64-bit time_t
arguments on architectures that are converted to allow 64-bit time_t
for non-obsolete system calls.

Maybe it's better to just reword this to

      "This controls the compilation of the following system calls:
      time, stime, gettimeofday, settimeofday, adjtimex, nanosleep,
alarm, getitimer,
      setitimer, select, utime, utimes, futimesat, and {old,new}{l,f,}stat{,64}.
      These are all replaced by other interfaces (e.g. posix timers and clocks,
      statx) on architectures that got converted from 32-bit time_t to
64-bit time_t.
      C libraries implementing 64-bit time_t in 32-bit architectures have to
      implement the handles by wrapping around the newer interfaces.
      New architectures should not explicitly enable this."

That would clarify that it's not about the compat system calls, while
also allowing the two options to be set independently.

        Arnd
