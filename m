Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 29 Nov 2017 00:18:08 +0100 (CET)
Received: from mail-io0-x244.google.com ([IPv6:2607:f8b0:4001:c06::244]:44262
        "EHLO mail-io0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990485AbdK1XSB0vCCm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 29 Nov 2017 00:18:01 +0100
Received: by mail-io0-x244.google.com with SMTP id w127so1720939iow.11;
        Tue, 28 Nov 2017 15:18:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=6jzrGO/SlqO0SYjWCe7NpRczWAdQtxW9Jdd1Pwcnab4=;
        b=MLksuu88NaLObvyVNOSNBnNHSIdUM1eL33OhbBbZpdB9RUNkvmvqFqj9CE7tl/gR6h
         s6u0nF+x1KmdkteMXarHWd15Ql/3WNcf3JX6a+k5xsjJ9JhMXdix7AwSRZEsPYwb4LX4
         YAUGsu3yyGqi7ZDWtNyX2CgxeV7hX/NqhMo0HiOdf8qVwokvs64mvD/Kja+z6mNa0OBh
         H18KukHoY3Auh/vq7wvw+EmJRALVEONIYYwxuST2SD1ziyzsvOxWuam+Kye/foag7OY1
         Pyd+SNarLK9nLhAld7G5suZLunR+XwieGBh7wJ719rlwFtW25Ey/emgV9wzlw8oLDr6Y
         bUIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=6jzrGO/SlqO0SYjWCe7NpRczWAdQtxW9Jdd1Pwcnab4=;
        b=OI8V5rKCDA9/2nr9sILGNRo/qk2ICWbSjUXgOfG4w5X58E/9TsfUaCMfGirPaiIFFe
         JlLVw/WzsNOTIIBAUegF6vEf+h1p/yVcgeYSa+hu5ZcKxe+5N44XVMwa0YNS9fxOQD2p
         /bXGyinn+tMjS60BJew9iuKj4WXRymOsB36rp1c9iMBUwfvysRbBBeNaEv6bTce2HEVi
         h329WfrLIgqFpTpCzUdSxvjWOF0OEEtIOojoYF1x9WfmOyVQp7p8OZCe9URwAUr137bR
         Y95ecKT0qIueZIZsjYvWKjEHfN8GI7V3Vi42eGnUUifB0QJLkV3uqwITugKuFIESSpX+
         hIMw==
X-Gm-Message-State: AJaThX7DUVU90H4yQXYtOuASgcxBZf3DUBw11neq5+QPAFvy08YKrBCE
        GW3oomoboLBkZTwywzH33oSYU2Rw3sb21j9vNLI=
X-Google-Smtp-Source: AGs4zMadP/sBvkHRVd42jOND/pg1S8pNIcgTQfM0VLRrpBvHluKg8tQ3cfETCaD8kyTL0maPh2v+P+bsqgbDuVtfxaA=
X-Received: by 10.107.10.13 with SMTP id u13mr1122533ioi.252.1511911074845;
 Tue, 28 Nov 2017 15:17:54 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.31.205 with HTTP; Tue, 28 Nov 2017 15:17:54 -0800 (PST)
In-Reply-To: <CAK8P3a26g74UA5J5uQLwdjK3hq+htzjrdTYRKqfy_MawY7st+g@mail.gmail.com>
References: <20171127193037.8711-1-deepa.kernel@gmail.com> <CAK8P3a2pcpQqf_TNGVxLBePBSKYhxD90UN-FjBor4d-dKhAwbQ@mail.gmail.com>
 <CABeXuvrBOSVTNSbEZZMKmuTgWeU_VDqjSZkwGAM+bnPh0-72zA@mail.gmail.com> <CAK8P3a26g74UA5J5uQLwdjK3hq+htzjrdTYRKqfy_MawY7st+g@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Tue, 28 Nov 2017 15:17:54 -0800
Message-ID: <CABeXuvrtQfSsOipGTnfmONXS45Dqxy4_T7MAcfO4VajoSycW4w@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] posix_clocks: Prepare syscalls for 64 bit time_t conversion
To:     Arnd Bergmann <arnd@arndb.de>
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
Return-Path: <deepa.kernel@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61169
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: deepa.kernel@gmail.com
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

On Tue, Nov 28, 2017 at 6:17 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Mon, Nov 27, 2017 at 11:29 PM, Deepa Dinamani <deepa.kernel@gmail.com> wrote:
>>>> I decided against using LEGACY_TIME_SYSCALLS to conditionally compile
>>>> legacy time syscalls such as sys_nanosleep because this will need to
>>>> enclose compat_sys_nanosleep as well. So, defining it as
>>>>
>>>> config LEGACY_TIME_SYSCALLS
>>>>      def_bool 64BIT || !64BIT_TIME
>>>>
>>>> will not include compat_sys_nanosleep. We will instead need a new config to
>>>> exclusively mark legacy syscalls.
>>>
>>> Do you mean we would need to do this separately for native and compat
>>> syscalls, and have yet another option, like LEGACY_TIME_SYSCALLS
>>> and LEGACY_TIME_COMPAT_SYSCALLS, to cover all cases? I would
>>> think that CONFIG_COMPAT_32BIT_TIME handles all the compat versions,
>>> while CONFIG_LEGACY_TIME_SYSCALLS handles all the native ones.
>>
>> I meant sys_nanosleep would be covered by LEGACY_TIME_SYSCALLS, but
>> compat_sys_nanosleep would be covered by CONFIG_COMPAT_32BIT_TIME
>> along with other compat syscalls.
>> So, if we define the LEGACY_TIME_SYSCALLS as
>>
>>
>>         "This controls the compilation of the following system calls:
>>         time, stime, gettimeofday, settimeofday, adjtimex, nanosleep,
>> alarm, getitimer,
>>         setitimer, select, utime, utimes, futimesat, and
>> {old,new}{l,f,}stat{,64}.
>>         These all pass 32-bit time_t arguments on 32-bit architectures and
>>         are replaced by other interfaces (e.g. posix timers and clocks, statx).
>>         C libraries implementing 64-bit time_t in 32-bit architectures have to
>>         implement the handles by wrapping around the newer interfaces.
>>         New architectures should not explicitly enable this."
>>
>> This would not be really true as compat interfaces have nothing to do
>> with this config.
>>
>> I was proposing that we could have LEGACY_TIME_SYSCALLS config, but
>> then have all these "deprecated" syscalls be enclosed within this,
>> compat or not.
>> This will also mean that we will have to come up representing these
>> syscalls in the syscall header files.
>> This can be a separate patch and this series can be merged as is if
>> everyone agrees.
>
> I think doing this separately  would be good, I don't see any interdependency
> with the other patches, we just need to decide what we want in the long
> run.

Right. There are three options:

1. Use two configs to identify which syscalls need not be supported by
new architectures.
In this case it makes sense to say LEGACY_TIME_SYSCALLS and
COMPAT_32BIT_TIME both need to be disabled for new architectures. And,
I can reword the config to what you mention below.

2. Make the LEGACY_TIME_SYSCALLS eliminate non y2038 safe syscalls
mentioned below only.
In this case only the native and compat functions of the below
mentioned syscalls need to be identified by the config. I like this
option as this clearly identifies which syscalls are deprecated and do
not have a 64 bit counterpart. Not all architectures need to support
turning this off.

3. If we don't need either 1 or 2, then we could stick with what we
have today in the series as CONFIG_64BIT_TIME will be deleted and they
only need #ifdef CONFIG_64BIT.

Let me know if anyone prefers something else.

> I agree my text that you cited doesn't capture the situation correctly,
> as this is really about the obsolete system calls that take 64-bit time_t
> arguments on architectures that are converted to allow 64-bit time_t
> for non-obsolete system calls.
>
> Maybe it's better to just reword this to
>
>       "This controls the compilation of the following system calls:
>       time, stime, gettimeofday, settimeofday, adjtimex, nanosleep,
> alarm, getitimer,
>       setitimer, select, utime, utimes, futimesat, and {old,new}{l,f,}stat{,64}.
>       These are all replaced by other interfaces (e.g. posix timers and clocks,
>       statx) on architectures that got converted from 32-bit time_t to
> 64-bit time_t.
>       C libraries implementing 64-bit time_t in 32-bit architectures have to
>       implement the handles by wrapping around the newer interfaces.
>       New architectures should not explicitly enable this."
>
> That would clarify that it's not about the compat system calls, while
> also allowing the two options to be set independently.

-Deepa
