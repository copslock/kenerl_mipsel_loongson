Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 27 Nov 2017 23:30:13 +0100 (CET)
Received: from mail-it0-x244.google.com ([IPv6:2607:f8b0:4001:c0b::244]:36568
        "EHLO mail-it0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990416AbdK0WaG2B2iy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 27 Nov 2017 23:30:06 +0100
Received: by mail-it0-x244.google.com with SMTP id y71so11525658ita.1;
        Mon, 27 Nov 2017 14:30:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=jy+lcuRwNI2bAKCSVe0lxonNzdlf+H33DAqCOHP+mFQ=;
        b=L4DID3gBL0WwXehcziM36ClOfDdBOsb9JUqLaHoVXlukY2rRZ7o7rQt4VjhDXUW8gN
         eVgKPPmV/nbOyizWcwRrsTDD5WdAl/9MndBi3ES/1ZkqoxjsZ2qTHOz/iSW1Ei0OVlkB
         Sr8wxorNuBiday5c3Ar+dpf2y1dDoyOeM7XJJPBOEBlieWckmTRtl1pMvW7VFMLTQb2q
         MpImX8jESoynD6WA0uB56z8ZHQHUhSbPjdqalN9/90N7Fg38fqDl1+KoMT/RaPeMymz1
         +f7ZqzNRkwqEYjoCqxSlCR+Umvixuu0//eXZNWG3q+XtkyE3g9qHzokVXjElb4/WX0tO
         a7Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=jy+lcuRwNI2bAKCSVe0lxonNzdlf+H33DAqCOHP+mFQ=;
        b=evW3+TteSGl+CsBIaOFKoD54kPEqgz4178jgRXIDFBPKak06FfVJv7pjamxued8iUG
         q8og9oxakyoQjy1sSTJv11A8J94/ZdqiKQUE+xEwfc6fPFZgE5DDyLaxs5lHQ2bLNvjt
         QdkBVu8uUFTWaW2o/tQqyhLteQBHsahbkmxzIdm3yKLPTHpecvrpSojeQWrgDabdiLDB
         sQF0GEQ9nJeQaHJR9L3ixSlAsbHscFmW6aRu5y2kIJAWaYlsGE3AvqoU9JU+y4v78803
         MTG9P2UEThl61FFgdBFXU9qFl1W03eeomPgPTKRt6sY/edRSG9FuuGo3/Wr4q2/ShvEK
         OEqQ==
X-Gm-Message-State: AJaThX6t1RCGmlVq1A2Rhk8IOGsRskbpX2CGQ1yCCBh3fqgoKggprXX9
        nahPggouboH8mOIFyAohIpldKcm2ctxenZW3OKU=
X-Google-Smtp-Source: AGs4zMYZC40yPY78vKiQ47ujBbYaHqvgHQSi7STrtqewkxZW/sLpSyK4yrs2Gh5qeZcGYEcGrW503vGqzVyHxFsRgOA=
X-Received: by 10.36.160.201 with SMTP id o192mr28725915ite.58.1511821800260;
 Mon, 27 Nov 2017 14:30:00 -0800 (PST)
MIME-Version: 1.0
Received: by 10.107.31.205 with HTTP; Mon, 27 Nov 2017 14:29:59 -0800 (PST)
In-Reply-To: <CAK8P3a2pcpQqf_TNGVxLBePBSKYhxD90UN-FjBor4d-dKhAwbQ@mail.gmail.com>
References: <20171127193037.8711-1-deepa.kernel@gmail.com> <CAK8P3a2pcpQqf_TNGVxLBePBSKYhxD90UN-FjBor4d-dKhAwbQ@mail.gmail.com>
From:   Deepa Dinamani <deepa.kernel@gmail.com>
Date:   Mon, 27 Nov 2017 14:29:59 -0800
Message-ID: <CABeXuvrBOSVTNSbEZZMKmuTgWeU_VDqjSZkwGAM+bnPh0-72zA@mail.gmail.com>
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
X-archive-position: 61111
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

>> I decided against using LEGACY_TIME_SYSCALLS to conditionally compile
>> legacy time syscalls such as sys_nanosleep because this will need to
>> enclose compat_sys_nanosleep as well. So, defining it as
>>
>> config LEGACY_TIME_SYSCALLS
>>      def_bool 64BIT || !64BIT_TIME
>>
>> will not include compat_sys_nanosleep. We will instead need a new config to
>> exclusively mark legacy syscalls.
>
> Do you mean we would need to do this separately for native and compat
> syscalls, and have yet another option, like LEGACY_TIME_SYSCALLS
> and LEGACY_TIME_COMPAT_SYSCALLS, to cover all cases? I would
> think that CONFIG_COMPAT_32BIT_TIME handles all the compat versions,
> while CONFIG_LEGACY_TIME_SYSCALLS handles all the native ones.

I meant sys_nanosleep would be covered by LEGACY_TIME_SYSCALLS, but
compat_sys_nanosleep would be covered by CONFIG_COMPAT_32BIT_TIME
along with other compat syscalls.
So, if we define the LEGACY_TIME_SYSCALLS as


        "This controls the compilation of the following system calls:
        time, stime, gettimeofday, settimeofday, adjtimex, nanosleep,
alarm, getitimer,
        setitimer, select, utime, utimes, futimesat, and
{old,new}{l,f,}stat{,64}.
        These all pass 32-bit time_t arguments on 32-bit architectures and
        are replaced by other interfaces (e.g. posix timers and clocks, statx).
        C libraries implementing 64-bit time_t in 32-bit architectures have to
        implement the handles by wrapping around the newer interfaces.
        New architectures should not explicitly enable this."

This would not be really true as compat interfaces have nothing to do
with this config.

I was proposing that we could have LEGACY_TIME_SYSCALLS config, but
then have all these "deprecated" syscalls be enclosed within this,
compat or not.
This will also mean that we will have to come up representing these
syscalls in the syscall header files.
This can be a separate patch and this series can be merged as is if
everyone agrees.

-Deepa
