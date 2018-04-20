Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2018 16:38:43 +0200 (CEST)
Received: from mail-qt0-x242.google.com ([IPv6:2607:f8b0:400d:c0d::242]:35553
        "EHLO mail-qt0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990480AbeDTOigZA1iP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Apr 2018 16:38:36 +0200
Received: by mail-qt0-x242.google.com with SMTP id s2-v6so9777466qti.2;
        Fri, 20 Apr 2018 07:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc;
        bh=98OyFl144wVGX53G/lcneDRh2auqmhwtC1rmf0wkfGU=;
        b=jsDjPzCNvCPr9B92sx7kqPHuh4WLas5moPFKKazo8Cbqr927nRegV/cdnGIgRhO79Z
         2mmwrVXiF1y4XScWOF6ANe8u5JUMtxy+8lmn1o0cTAdN8hvRClyeYDfGGS3B9eJImc3S
         Ece9CJaS3SgSfY0W0vxm50Z41VlMCiF8UkRWRwHGuzGeqTWmoA5OTOQZFsIhpxr30f4q
         XRsrKpEJgeuGcZ7zCXFsnDbcW1dtqkzZKCx3yqzaT86zO5LgU++og16DTiGYZdk/TTaV
         WgEaYR+QhOivJqhUx1OG8y+9rfHvxjS/C92P+dh+i3m98Ha6K2l+X7WgQca/BfoLkuSI
         Hhvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc;
        bh=98OyFl144wVGX53G/lcneDRh2auqmhwtC1rmf0wkfGU=;
        b=IDrlYao8WRIHoXDjAfSExLrSh23SbKpJnB7y23tq0KgVRGizu62AMyndjwz6jt9cMI
         75leu3h38C6CSTiJoWzPgoNjwIekd0Z8A+yQCMRQGkRgiw8zNaG6dqBN5c17dmPMJfHi
         6Rw22gYGkYeus1UGrwfcaI/5AQb80ACyEUc+mfEtlUxpCdrXVeOC8eSSgyG/3/u2zIlF
         bBOfztvjAA57Vf7uxcS7dX/0Z1GBT7UsmkZKA4NTSmuIuyALClZ0oEYW170TmSSNst2h
         jhAtL8PWBALCE/pQzlyHlOM4nIiDbTcntbSFWW8ar+NkBe99SPVnc3SCb6+zsE53lAPF
         gj+A==
X-Gm-Message-State: ALQs6tDOT13/nYhCOImJeVLlMufb8zHNOU4ao3M+ZF+TvobZZxZ6IJoV
        PIsu66wMU/L0a52zwbotLAPWwKJ2+hYc31UtmFs=
X-Google-Smtp-Source: AIpwx4/7TBwTVjIOe5IqMxQe3h3pFx3pXqcdGLqT5XTu3uywcswchrGOHDONgbkDy8+mck1Xqs5Eymfa1gY2aZ+X2uM=
X-Received: by 10.55.33.169 with SMTP id f41mr10833525qki.174.1524235110074;
 Fri, 20 Apr 2018 07:38:30 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.12.185.25 with HTTP; Fri, 20 Apr 2018 07:38:29 -0700 (PDT)
In-Reply-To: <CAH8yC8mnfNnG86kgjnfwiZJ0=qN+w=5PVcLcxddaJdDtYbSanA@mail.gmail.com>
References: <CAK8P3a3qAoR1afmTTK1CAp1L81dzwtBL+SKj=QMqD=dBr_8oRQ@mail.gmail.com>
 <20180420130346.3178914-1-arnd@arndb.de> <CAH8yC8mnfNnG86kgjnfwiZJ0=qN+w=5PVcLcxddaJdDtYbSanA@mail.gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 20 Apr 2018 16:38:29 +0200
X-Google-Sender-Auth: J-Jrsq7jwkqvvWVW0-6W9coGyEE
Message-ID: <CAK8P3a0nL4B+t6BMRhr36RrZ_jDgwnY1BviNPD+cFzsUGeppmA@mail.gmail.com>
Subject: Re: [PATCH] x86: ipc: fix x32 version of shmid64_ds and msqid64_ds
To:     Jeffrey Walton <noloader@gmail.com>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>,
        "Eric W . Biederman" <ebiederm@xmission.com>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux API <linux-api@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        GNU C Library <libc-alpha@sourceware.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Albert ARIBAUD <albert.aribaud@3adev.fr>,
        linux-s390 <linux-s390@vger.kernel.org>,
        Martin Schwidefsky <schwidefsky@de.ibm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        sparclinux <sparclinux@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        Daniel Schepler <dschepler@gmail.com>,
        "H . J . Lu" <hjl.tools@gmail.com>,
        Adam Borowski <kilobyte@angband.pl>, tg@mirbsd.de,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "# 3.4.x" <stable@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63644
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

On Fri, Apr 20, 2018 at 3:53 PM, Jeffrey Walton <noloader@gmail.com> wrote:
>> +#if !defined(__x86_64__) || !defined(__ilp32__)
>>  #include <asm-generic/msgbuf.h>
>> +#else
>
> I understand there's some progress having Clang compile the kernel.
> Clang treats __ILP32__ and friends differently than GCC. I believe
> ILP32 shows up just about everywhere there are 32-bit ints, longs and
> pointers. You might find it on Aarch64 or you might find it on MIPS64
> when using Clang.
>
> I think that means this may be a little suspicious:
>
>     > +#if !defined(__x86_64__) || !defined(__ilp32__)
>
> I kind of felt LLVM was wandering away from the x32 ABI, but the LLVM
> devs insisted they were within their purview. Also see
> https://lists.llvm.org/pipermail/cfe-dev/2015-December/046300.html.
>
> Sorry about the top-post. I just wanted to pick out that one piece.

It seems I made a typo and it needs to be __ILP32__ rather than
__ilp32__ (corrected that locally, will resend once we have resolved
this).

Aside from that, the #if check seems to be correct to me: this
is an x86-specific header, so it won't ever be seen on other
architectures. On x86-32, __x86_64__ isn't set, so we don't care
about whether __ilp32__ is set or not, and on x86-64 (lp64),
__ilp32__ is never set, so we still get the asm-generic header.

      Arnd
