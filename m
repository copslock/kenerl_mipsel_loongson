Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Apr 2017 13:40:36 +0200 (CEST)
Received: from mail-oi0-x243.google.com ([IPv6:2607:f8b0:4003:c06::243]:35891
        "EHLO mail-oi0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991965AbdD0Lk3T41KA convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 27 Apr 2017 13:40:29 +0200
Received: by mail-oi0-x243.google.com with SMTP id a3so6500850oii.3
        for <linux-mips@linux-mips.org>; Thu, 27 Apr 2017 04:40:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-transfer-encoding;
        bh=1dhYe05HxJgq9/da6avkylIIcOHARlBtMhon14LYkaA=;
        b=e8VG+mOaUJzIA6D3my23D6dupRPs9N+uAQK1Iaaqz5oOqPnbOHLcka37OyBxnOET2n
         N1mewuDYga/VS3uZn77Oj5A0XJPKWC/tQkd8AhH2HMB7FyznEvArbIZZNZu0VT2m59bf
         1J6K11K/Kue1VvrTNkBEW+3UDBJDx5q1TJyNNAB/BJHu9xXEi1wLXHuQteF+HgU1P8Bd
         0iV05pp5821HyV2s2QVhENCdH+PN8Ba/CNKuI1FGp5ftyJWrya9fmAalok1WV0iofumr
         EOWYRJyqnbjoHDkv63r+46pwoSmD13TZUbYMebFMblsPNJ3j/GiYnKetZ/qMRXXrnVTg
         6kYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:sender:in-reply-to:references:from
         :date:message-id:subject:to:cc:content-transfer-encoding;
        bh=1dhYe05HxJgq9/da6avkylIIcOHARlBtMhon14LYkaA=;
        b=O5+1kMm22bGp8CWFk0iSbYHLahdLgIcqL2G9LeeuK0m/YNHpMVQiE0u75O6gjMbtn3
         QB5Jt2kZ7Oa5dieVDx6WU2Z66dGzJCiajkug4ETlq+EnMlBh1gZUruSDLifQPIC/6msn
         d8gh3h7SJMGIDS0B5/SlhttTzzTnjWzocc0b8Et5OQzUaKDUSHZpgou6uywJO5i08Qr8
         2EVYgqjBneHFKxze6R36UAd+LNJFtcczBCqJAm3JOuJoUgIwYZowccAi5Yln6PJT8tte
         6d9OUrAIT4wUaTaCMGNGyjRMEbVivzLN2cOK/9iWVTb2ntp7ujo2crBajY7tgCBPJ+JF
         lhxQ==
X-Gm-Message-State: AN3rC/5w7u+5sNDHBi1Vf4C7J/6vE1eBhfGtjUvOohL/WVDYILxRmhhH
        lzHQt8HSzeppyI37Elljgd6YdYWxkw==
X-Received: by 10.157.37.194 with SMTP id q60mr2252292ota.44.1493293223267;
 Thu, 27 Apr 2017 04:40:23 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.157.66.2 with HTTP; Thu, 27 Apr 2017 04:40:22 -0700 (PDT)
In-Reply-To: <20170427103348.GA9881@kroah.com>
References: <58f8ea00.84621c0a.da7d6.1c19@mx.google.com> <CAK8P3a3QsSMtc7AWjVjtM+tW8ARt1Ygw53=CSjgbG6Pvpq0QvQ@mail.gmail.com>
 <20170427103348.GA9881@kroah.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 27 Apr 2017 13:40:22 +0200
X-Google-Sender-Auth: ogS_Z-YEjMgjE0pVmKpW-vbPAUs
Message-ID: <CAK8P3a0QN_8PPGaMYA8GZG6axseRLcJq=--1NgfOAPaEGgiAjg@mail.gmail.com>
Subject: Re: stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35
 errors, 212 warnings (v3.18.49)
To:     gregkh <gregkh@linuxfoundation.org>
Cc:     "kernelci.org bot" <bot@kernelci.org>,
        kernel-build-reports@lists.linaro.org,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57794
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

On Thu, Apr 27, 2017 at 12:33 PM, gregkh <gregkh@linuxfoundation.org> wrote:
> On Fri, Apr 21, 2017 at 04:27:14PM +0200, Arnd Bergmann wrote:
>> On Thu, Apr 20, 2017 at 7:04 PM, kernelci.org bot <bot@kernelci.org> wrote:
>> > stable/linux-3.18.y build: 204 builds: 5 failed, 199 passed, 35 errors, 212 warnings (v3.18.49)
>>
>> I've gone through all these now and found a fix. In three cases, there is no
>> fix yet since the respective drivers got removed before the warning was
>> noticed. Do we have a policy for how to deal with those? Should I just
>> send patches to address the warnings for 3.18?
>
> I've wondered about this, and yeah, I would like to see the number drop
> to 0 if at all possible (the scsi driver will not change), so i'll be
> glad to take patches for the code that is no longer in upstream.

Ok, I'll have a go at this after the build report.

>> > drivers/scsi/advansys.c:71:2: warning: #warning this driver is still not
>> > properly converted to the DMA API [-Wcpp]
>>
>> The driver was properly converted in v4.2 and the warning removed, but the
>> conversion would be outside of stable-kernel-rules.
>
> Yeah, this one is going to have to stay as-is :(

How about just shutting up the #warning then, based on the argument that
the warning isn't helping anyone fix it, and all the other drivers that had not
been converted at the time don't come with a #warning?

>> > Section mismatches:
>> > WARNING: arch/x86/kernel/built-in.o(.text.unlikely+0x157f): Section mismatch
>> > in reference from the function cpumask_empty.constprop.3() to the variable
>> > .init.data:nmi_ipi_mask
>> > WARNING: arch/x86/built-in.o(.text.unlikely+0x189b): Section mismatch in
>> > reference from the function cpumask_empty.constprop.3() to the variable
>> > .init.data:nmi_ipi_mask
>> > WARNING: vmlinux.o(.text.unlikely+0x1962): Section mismatch in reference
>> > from the function cpumask_empty.constprop.3() to the variable
>> > .init.data:nmi_ipi_mask
>>
>> f0ba662a6e06f2 x86: Properly _init-annotate NMI selftest code
>
> That commit is from 3.4, so how can I add it to 3.18? :)

Very odd, my search was definitely going wrong there. The file that
we get the warning for was last changed in 3.6, so I accidentally looked
at ancient changes.

Upon a closer look it looks like the problem is the 'cpumask_empty()'
helper function getting uninlined with CONFIG_OPTIMIZE_INLINING,
but I cannot see why the warning is gone in later kernels. I'll probably
have to bisect it.

>> > allnoconfig (mips) — PASS, 0 errors, 1 warning, 0 section mismatches
>> >
>> > Warnings:
>> > mm/page_alloc.c:5346:34: warning: array subscript is below array bounds
>> > [-Warray-bounds]
>>
>> Also bisected this one now, this is also missing on 3.16:
>>
>> 90cae1fe1c35 ("mm/init: fix zone boundary creation")
>
> Now applied to 3.1_8_ :)

Ok. To clarify, I was taking note of the fact this 3.16 needs it since this
is the most frequent warning I still see on Ben's 3.16.y tree, and the
last time I went through the 3.16 build report, I did not succeed in finding
this (without bisecting).

>> > ath79_defconfig (mips) — PASS, 0 errors, 2 warnings, 0 section mismatches
>> >
>> > Warnings:
>> > arch/mips/kernel/entry.S:170: Warning: tried to set unrecognized symbol:
>> > MIPS_ISA_LEVEL_RAW
>>
>> aebac99384f7 ("MIPS: kernel: entry.S: Set correct ISA level for mips_ihb")
>
> That was in 3.18.14, what kernel are you looking at here???

For most of the changes, I tried looking at 'git log v3.18..stable/linux-4.4.y'
and immediately found the obvious fix. If that didn't help, I tried a few other
things, but I usually did not look in 3.18.y to see if it was already there
if I found something at first that looked obviously right.

This is another case where I confused the patch that introduced the
warning with the one that fixed it. This one requires a another patch that
got merged into 3.20:

be5136988e25 ("MIPS: asm: compiler: Add new macros to set ISA and arch
asm annotations")

>> > cerfcube_defconfig (arm) — PASS, 0 errors, 2 warnings, 0 section mismatches
>> >
>> > Warnings:
>> > fs/nfsd/nfs4state.c:3781:3: warning: 'old_deny_bmap' may be used
>> > uninitialized in this function [-Wmaybe-uninitialized]
>>
>> 5368e1a6 ("nfsd: work around a gcc-5.1 warning")

It's a copy-paste mistake, missing the first digits of the commit ID,
I found the correct one now:

6ac75368e1a6 nfsd: work around a gcc-5.1 warning

> That commit id isn't in Linus's tree, where did you get it from?
>> > defconfig+CONFIG_LKDTM=y (mips) — PASS, 0 errors, 3 warnings, 0 section
>> > mismatches
>> >
>> > Warnings:
>> > include/asm-generic/div64.h:43:28: warning: comparison of distinct pointer
>> > types lacks a cast
>> > include/asm-generic/div64.h:43:28: warning: comparison of distinct pointer
>> > types lacks a cast
>>
>> 2ae83bf93882 ("[CIFS] Fix setting time before epoch (negative time values)")
>
> That was in 3.17, are you sure you are looking at 3.18 like the subject
> says???

Another similar mistake on my end, 2ae83bf93882 introduced the problem,
the fix we need was

97c7134ae22f ("Fix signed/unsigned pointer warning")

        Arnd
