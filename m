Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 18 Sep 2018 16:13:18 +0200 (CEST)
Received: from mail-yb1-xb42.google.com ([IPv6:2607:f8b0:4864:20::b42]:39860
        "EHLO mail-yb1-xb42.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994607AbeIRONM43of1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 18 Sep 2018 16:13:12 +0200
Received: by mail-yb1-xb42.google.com with SMTP id c4-v6so862254ybl.6
        for <linux-mips@linux-mips.org>; Tue, 18 Sep 2018 07:13:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=hac5pA7WjfhQS3IltEqWiih/FiZdrS6bVORPC4vEDLA=;
        b=MO667b/np5AysEkSuTzWmBwvHGCHU6fnsr6hLjVt07LPN2HrfU1Tl6C3Gk2hKwkRS+
         tGC//NDv1/qQkURyIn+lAXD4dSisb2u1CAbUHo1lhhJ879T21yXelrKbD6dySMDntEPK
         cJfC6CIGQouuDn/SDvJn9ZEfbj3lFOzyeIXt8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=hac5pA7WjfhQS3IltEqWiih/FiZdrS6bVORPC4vEDLA=;
        b=RJsi7gPCfq7DZ0k3OfJq5omyUV8qjty1/4u64LGHEt7NakVI5I804ajCkKK/uWPIW8
         uVBq5F0sqleQJeB+UEp+sDH4gizCyHo8noyGcdSCduQRIfKfdkqi4ub8iZ6igO7uPSfb
         H3pJqFPN4my0bzNFtOrS5INs2CL8oLEIIgKtM4yuAVxauOw8EFfClAV8LblYdAmLJxVb
         2EKgUuzVgqUCiS9OL8RXbSlQyb4svdOfCC1zYdvzPdzUGL0pTRLaoBaBwsboNEiuuHxt
         G0wOuwOUMwpBekCUWeBQGvQan/ITNruYiZwWTYYZWTzGaOklgfWqHleAAWny2WQ88glN
         P+Gg==
X-Gm-Message-State: APzg51DfAKFB3KyAC85KtHXpjEbyCN/BsbfAKeR2YRRRbUo7gyfrpNLY
        wMWFCRU+4yM0lij+Yic+rBITyxoi4WglZwsMPVDSMg==
X-Google-Smtp-Source: ANB0VdYfNYyllvLEXmIeZLqJt4DpW+JgS9MWYqLAjPKKgCjJuhFb9aaMbtfw7YRYDAYBgTNwLfa9pqbYekqUZKNiq6k=
X-Received: by 2002:a25:9702:: with SMTP id d2-v6mr13290148ybo.77.1537279986498;
 Tue, 18 Sep 2018 07:13:06 -0700 (PDT)
MIME-Version: 1.0
Received: by 2002:a0d:cc4f:0:0:0:0:0 with HTTP; Tue, 18 Sep 2018 07:13:06
 -0700 (PDT)
In-Reply-To: <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org> <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
From:   Firoz Khan <firoz.khan@linaro.org>
Date:   Tue, 18 Sep 2018 19:43:06 +0530
Message-ID: <CALxhOngEqaA6sNKG_eRTTgnjj94vM2OftbpgHPEXMZ0Yv_nC2w@mail.gmail.com>
Subject: Re: [PATCH 0/3] System call table generation support
To:     Paul Burton <paul.burton@mips.com>
Cc:     Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "y2038@lists.linaro.org" <y2038@lists.linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "deepa.kernel@gmail.com" <deepa.kernel@gmail.com>,
        "marcin.juszkiewicz@linaro.org" <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <firoz.khan@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66396
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: firoz.khan@linaro.org
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

On 17 September 2018 at 22:47, Paul Burton <paul.burton@mips.com> wrote:
> Hi Firoz,
>
> On Fri, Sep 14, 2018 at 02:08:31PM +0530, Firoz Khan wrote:
>> The purpose of this patch series is:
>> 1. We can easily add/modify/delete system call by changing entry
>> in syscall.tbl file. No need to manually edit many files.
>>
>> 2. It is easy to unify the system call implementation across all
>> the architectures.
>>
>> The system call tables are in different format in all architecture
>> and it will be difficult to manually add or modify the system calls
>> in the respective files manually. To make it easy by keeping a script
>> and which'll generate the header file and syscall table file so this
>> change will unify them across all architectures.
>
> Interesting :)
>
> I actually started on something similar recently with the goals of
> reducing the need to adjust both asm/unistd.h & the syscall entry tables
> when adding syscalls, clean up asm/unistd.h a bit & make it
> easier/cleaner to add support for nanoMIPS & the P32 ABI.
>
> My branch still needed some work but it's here if you're interested:
>
>     git://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git wip-mips-syscalls
>
>     https://git.kernel.org/pub/scm/linux/kernel/git/mips/linux.git/log/?h=wip-mips-syscalls
>
> There are some differences:
>
>   - I'd placed syscall numbers the 3 current MIPS ABIs in one table,
>     rather than splitting it up. I can see pros & cons to both though so
>     I'm not tied to having a single all-encompassing table.
>
>   - I'd mostly inferred the entry point names from the syscall names,
>     only specifying them where they differ. Again I'm not particularly
>     tied to this.
>
>   - I'd made asm/unistd.h behave like asm-generic/unistd.h with the
>     __SYSCALL() macro, where you generate separate syscall_table_*
>     headers. I'm fine with that too.
>
> So I'm pretty happy to go with your series, though I agree with Arnd on
> the ABI/file naming & the missing syscalls that were added in the 4.18
> cycle. We probably need to provide mipsmt_sys_sched_[gs]etaffinity as
> aliases to sys_sched_[gs]etaffinity when CONFIG_MIPS_MT_FPAFF isn't
> enabled in order to fix the issue the kbuild test robot reported.
>
> But I'm looking forward to v2 :)
>
> Thanks,
>     Paul

Thanks for your comments :)

We're planning to come up with a generic script for system call table
generation across all the architecture. So certain things I have to keep
same across  all the architecture.

Having a single script is always our plan for long run. But I have to keep a
separate versions for the start so each architecture can be handled  in one
series. Which would make easier to merge in the initial version.

we could probably add it to scripts/*.sh first, but that requires more
coordination between the architectures.

- Firoz
