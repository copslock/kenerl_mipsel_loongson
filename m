Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Apr 2018 14:39:00 +0200 (CEST)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:33249
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991307AbeDVMixManOd (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 22 Apr 2018 14:38:53 +0200
Received: by mail-qt0-x244.google.com with SMTP id f16-v6so10905069qth.0;
        Sun, 22 Apr 2018 05:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=XNCfJtB/O4thbrk2HCsmb8tu4gv6VXYIkjxoT5Ti7v8=;
        b=R1JwNAR16EUoAIjDIp1Zy9eV2Qn3/r7F9yTiNvQ1hEuqnbyQ3TgPtiN6d6E4OGwnd2
         d5+LKGIMpmJDSDQShG1cpLrrkrch1IAsSi+xWmvxb94WTHj6QVRBhsj0AcwV9H9/SDnq
         ZEtgCudQYctyhUhD4RhMy5wepCWDSq7t8pE/pyYkvlf9aa3pbRdXKc+DKfz7VZojKl4V
         Ch10B/To2Wdnzx7II4FkmAHKilR+abet5itpEJkfiRQlzDU6Z7Nk/mMvXqYtl/R6GKHZ
         5MSGb+4SC3c0fG0YM+9Sgp2FQ4u/SbsUdlnD/NUhlV7k2EEGdDE8p8ktuLAs8z1FxQjI
         UOdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=XNCfJtB/O4thbrk2HCsmb8tu4gv6VXYIkjxoT5Ti7v8=;
        b=gkYe7V0BGN4mkrvV8jhpvD+Ghb9DlqA3V2ZMUWtGfBdZtrtOb8OPeg5mgKdSWdy5Dp
         L9gwKuIAPnsuj660GCIeIn2YEg7CSMgBK2KdtvuoMSycF6c/dX/3eS0LfnH56cejUToN
         iDmmZp4BUGzS96dq/0UEGfSuZfTrbwRYxT3VukV7GhTO7Cx/NZuX+aXCcUlAwtWyemhq
         Svz91vKrObuZvNc3VjsRVky27JldkvvILudK/b6mJQ0f92GAalPy9R2pmPvdw8Mdfu1g
         AGkYVZgKohuhGE1paCw4SutgnDHNry1M5pNCzZDGYmlRBt+FcoCiIAoBRR5o7GpK6sCG
         8TBw==
X-Gm-Message-State: ALQs6tB5GBRz9FP9FXudGKj4QWwuriYg35aIOfgjrCGWwoi95f0N8y+0
        0wmG2aOw2J0GsX5QnvIexxIqjOaIuBRmsGdbynU=
X-Google-Smtp-Source: AB8JxZoXamGV+Dj/w2Q6SZOp/EOWIrfp3OZWsQNyT9Xb8MxcmKAIMXFrKpXU4nsGHUBVvFidOCQm9GQGgs05fxAthqE=
X-Received: by 2002:ac8:21b4:: with SMTP id 49-v6mr10065155qty.315.1524400726996;
 Sun, 22 Apr 2018 05:38:46 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.74.46.18 with HTTP; Sun, 22 Apr 2018 05:38:45 -0700 (PDT)
In-Reply-To: <CAK8P3a0nL4B+t6BMRhr36RrZ_jDgwnY1BviNPD+cFzsUGeppmA@mail.gmail.com>
References: <CAK8P3a3qAoR1afmTTK1CAp1L81dzwtBL+SKj=QMqD=dBr_8oRQ@mail.gmail.com>
 <20180420130346.3178914-1-arnd@arndb.de> <CAH8yC8mnfNnG86kgjnfwiZJ0=qN+w=5PVcLcxddaJdDtYbSanA@mail.gmail.com>
 <CAK8P3a0nL4B+t6BMRhr36RrZ_jDgwnY1BviNPD+cFzsUGeppmA@mail.gmail.com>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Sun, 22 Apr 2018 05:38:45 -0700
Message-ID: <CAMe9rOrTzgDmCF+A7nYdGR6BHZBuK5SMnJxeRxBFQW00VmdXvg@mail.gmail.com>
Subject: Re: [PATCH] x86: ipc: fix x32 version of shmid64_ds and msqid64_ds
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Jeffrey Walton <noloader@gmail.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
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
        Adam Borowski <kilobyte@angband.pl>,
        Thorsten Glaser <tg@mirbsd.de>,
        John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
        "# 3.4.x" <stable@vger.kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <hjl.tools@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hjl.tools@gmail.com
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

On Fri, Apr 20, 2018 at 7:38 AM, Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Apr 20, 2018 at 3:53 PM, Jeffrey Walton <noloader@gmail.com> wrote:
>>> +#if !defined(__x86_64__) || !defined(__ilp32__)
>>>  #include <asm-generic/msgbuf.h>
>>> +#else
>>
>> I understand there's some progress having Clang compile the kernel.
>> Clang treats __ILP32__ and friends differently than GCC. I believe
>> ILP32 shows up just about everywhere there are 32-bit ints, longs and
>> pointers. You might find it on Aarch64 or you might find it on MIPS64
>> when using Clang.
>>
>> I think that means this may be a little suspicious:
>>
>>     > +#if !defined(__x86_64__) || !defined(__ilp32__)
>>
>> I kind of felt LLVM was wandering away from the x32 ABI, but the LLVM
>> devs insisted they were within their purview. Also see
>> https://lists.llvm.org/pipermail/cfe-dev/2015-December/046300.html.
>>
>> Sorry about the top-post. I just wanted to pick out that one piece.
>
> It seems I made a typo and it needs to be __ILP32__ rather than
> __ilp32__ (corrected that locally, will resend once we have resolved
> this).
>
> Aside from that, the #if check seems to be correct to me: this
> is an x86-specific header, so it won't ever be seen on other
> architectures. On x86-32, __x86_64__ isn't set, so we don't care
> about whether __ilp32__ is set or not, and on x86-64 (lp64),
> __ilp32__ is never set, so we still get the asm-generic header.
>

Glibc has correct header files for system calls.  I have a very old
program to check if Linux kernel header files are correct for user
space:

https://github.com/hjl-tools/linux-header

It needs update to check uapi.

-- 
H.J.
