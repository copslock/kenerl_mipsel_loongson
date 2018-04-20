Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2018 10:54:38 +0200 (CEST)
Received: from mail-qk0-x244.google.com ([IPv6:2607:f8b0:400d:c09::244]:34737
        "EHLO mail-qk0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990424AbeDTIycRBb0H (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Apr 2018 10:54:32 +0200
Received: by mail-qk0-x244.google.com with SMTP id p186so5482882qkd.1;
        Fri, 20 Apr 2018 01:54:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=u0SlBa3kExqllCTvIwYgpOnqwTg98nZ1vcreS4mqD1M=;
        b=BuLEFbtDxKskjQ7YRGItusQ5j4RqTAv0k5mA0uQi0+GNdqliMtQ4wWFhqGKoT0tLuA
         CkNbnE84XpdsE1YlB4frvKcIq97b+O0ZZVv9MDasYZzYmUokaWEwHJtxKc1h8jLtUJa7
         v+qWPJUcgjOSBmk11cSxN/St+s6tFYsTpFupxUIAPtPOwxbmGSm7QTRfmnkOD2lecjl3
         VDpDKnViSaIk5JiJstwfYDrZl3s7MXG5zIW+UtV6aj2E7WPNPBm/LRkDAaLUwAeTWYBt
         kOqKeloI6XotI6ZYTEthPfzAJG8uvB1rPuAFZPfbUpHInRqBUMWxe+YrphKqK7QxP5sO
         mGVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=u0SlBa3kExqllCTvIwYgpOnqwTg98nZ1vcreS4mqD1M=;
        b=aOhsTUsBFC7HLJ5rJlrNPAyZyrPxPTc86ltkUsE9yFqqGFlvx39Ee+zHlry99Sx7Tm
         gJsW+T/SN9wVuHqpE0B9cedqFJhkDVtETH2OHCwhsEf9X65lmz0/HobFupRuWVnMJlMa
         fUXYrjUx37BKgI9XEIms7ONWcstgXRtXvfbrKj0T063eCAeABugEA6kauJasvqFlyDin
         slVZ5Iz2eSdXFvTtr3JrZjtRpy48irS/+qFeD6x0G1Q77XJFpHc/6mhs6bscnHMQR7po
         UTCDEu3a1gdFALMw1L/zoHMu1qcCe6/iT97KSAR3lLFmeMw5P/JeBWzJ9jfsaUSpDHi9
         522w==
X-Gm-Message-State: ALQs6tBEHnQkqpnrtq1UVSlrvtTvax9xCVpSXYIxTx3zBPWfc/x4CZ60
        LzgpF+7nxT/C3GVNqBqPFnDLN3o1b8h7jl1dz88=
X-Google-Smtp-Source: AB8JxZqtUTnZIlasdnq0AkzllUsn5TyoUokukSVbapwu1EtpHMhAZpozgWc8R9CLrCcJUFcgrjqV75t+wGAnxHWEdHA=
X-Received: by 10.55.180.1 with SMTP id d1mr9191714qkf.283.1524214465778; Fri,
 20 Apr 2018 01:54:25 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.25 with HTTP; Fri, 20 Apr 2018 01:54:25 -0700 (PDT)
In-Reply-To: <87k1t2n8v5.fsf@xmission.com>
References: <20180419143737.606138-1-arnd@arndb.de> <20180419143737.606138-2-arnd@arndb.de>
 <87efjbnswr.fsf@xmission.com> <CAK8P3a196QYoM1egagMuZw4WhiwRiO83Qpj0CxoCeVQBEaj-gw@mail.gmail.com>
 <CAK8P3a2KR+0ZE5jHSmO6pSuiRPH83p75KetuQuHL1atChcTJGA@mail.gmail.com> <87k1t2n8v5.fsf@xmission.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 20 Apr 2018 10:54:25 +0200
X-Google-Sender-Auth: tOfzH-co8L5k2AQrWlQ-PMWJMfw
Message-ID: <CAK8P3a3qAoR1afmTTK1CAp1L81dzwtBL+SKj=QMqD=dBr_8oRQ@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] y2038: asm-generic: Extend sysvipc data structures
To:     "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Albert ARIBAUD <albert.aribaud@3adev.fr>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Jeffrey Walton <noloader@gmail.com>,
        Daniel Schepler <dschepler@gmail.com>,
        "H.J. Lu" <hjl.tools@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>, tg@mirbsd.de,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63632
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

On Fri, Apr 20, 2018 at 12:12 AM, Eric W. Biederman
<ebiederm@xmission.com> wrote:
> Arnd Bergmann <arnd@arndb.de> writes:
>
>> On Thu, Apr 19, 2018 at 5:20 PM, Arnd Bergmann <arnd@arndb.de> wrote:
>>> On Thu, Apr 19, 2018 at 4:59 PM, Eric W. Biederman <ebiederm@xmission.com> wrote:
>>>> I suspect you want to use __kernel_ulong_t here instead of a raw
>>>> unsigned long.  If nothing else it seems inconsistent to use typedefs
>>>> in one half of the structure and no typedefs in the other half.
>>>
>>> Good catch, there is definitely something wrong here, but I think using
>>> __kernel_ulong_t for all members would also be wrong, as that
>>> still changes the layout on x32, which effectively is
>>>
>>> struct msqid64_ds {
>>>      ipc64_perm msg_perm;
>>>      u64 msg_stime;
>>>      u32 __unused1;
>>>      /* 32 bit implict padding */
>>>      u64 msg_rtime;
>>>      u32 __unused2;
>>>      /* 32 bit implict padding */
>>>      u64 msg_ctime;
>>>      u32 __unused3;
>>>      /* 32 bit implict padding */
>>>      __kernel_pid_t          shm_cpid;       /* pid of creator */
>>>      __kernel_pid_t          shm_lpid;       /* pid of last operator */
>>>      ....
>>> };
>>>
>>> The choices here would be to either use a mix of
>>> __kernel_ulong_t and unsigned long, or taking the x32
>>> version back into arch/x86/include/uapi/asm/ so the
>>> generic version at least makes some sense.
>>>
>>> I can't use __kernel_time_t for the lower half on 32-bit
>>> since it really should be unsigned.
>>
>> After thinking about it some more, I conclude that the structure is simply
>> incorrect on x32: The __kernel_ulong_t usage was introduced in 2013
>> in commit b9cd5ca22d67 ("uapi: Use __kernel_ulong_t in struct
>> msqid64_ds") and apparently was correct initially as __BITS_PER_LONG
>> evaluated to 64, but it broke with commit f4b4aae18288 ("x86/headers/uapi:
>> Fix __BITS_PER_LONG value for x32 builds") that changed the value
>> of __BITS_PER_LONG and introduced the extra padding in 2015.
>>
>> The same change apparently also broke a lot of other definitions, e.g.
>>
>> $ echo "#include <linux/types.h>" | gcc -mx32 -E -xc - | grep -A3
>> __kernel_size_t
>> typedef unsigned int __kernel_size_t;
>> typedef int __kernel_ssize_t;
>> typedef int __kernel_ptrdiff_t;
>>
>> Those used to be defined as 'unsigned long long' and 'long long'
>> respectively, so now all kernel interfaces using those on x32
>> became incompatible!
>
> Is this just for the uapi header as seen by userspace?  I expect we are
> using the a normal kernel interface with 64bit longs and 64bit pointers
> when we build the kernel.

Yes, that patch shouldn't have changed anything in the kernel, which
continues to be built with __BITS_PER_LONG=64. I haven't
checked the vdso, which is the only bit of the kernel that gets built
with -mx32, but I assume it's fine as well.

> If this is just a header as seen from userspace mess it seems
> unfortunate but fixable.

Right. I'll fix the IPC stuff for this series to make it work with
any value of __BITS_PER_LONG on x32, but I don't plan to
do anything about the rest of x32. The patch that caused the
problem was intended as a bugfix, so we can't just revert it
without first understanding how to properly fix the original bug,
and which other interfaces have now come to rely on
__BITS_PER_LONG=32 for x32.

Adding a few other folks that have been involved in the x32
kernel support or the Debian port in the past. Maybe one of
them is motivated to figure out how to fix this properly.

       Arnd
