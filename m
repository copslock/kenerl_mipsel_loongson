Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Sep 2018 16:52:34 +0200 (CEST)
Received: from mail-qk1-f196.google.com ([209.85.222.196]:34206 "EHLO
        mail-qk1-f196.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992747AbeITOw3bOzyQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Sep 2018 16:52:29 +0200
Received: by mail-qk1-f196.google.com with SMTP id p84-v6so4930720qke.1;
        Thu, 20 Sep 2018 07:52:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eFGUqvFxzbIhaU83zPWhDHl1/BdgZLhy7pyCrpxunG8=;
        b=LiQ3aPr7yj2pABF61q0K3SKMd+LJ5zTX7uCdyfOfjfBH0MGvs6k7SV0HbYOkhgsBRp
         CW9m6BjecqSBGLUdy9gkbvhDJh86dgCAx2SQVi+NTU8pmPjkkSxOii+8byu7q3HZ9Dj9
         TxaYGLKrCyhmqvvlHbm8teo5F+ea/pjy+EwF71pCZqVGI6Nus4r4y8jsB7NcRqMVeeHm
         BQk9UX6Do7qfODhD8jQBoGCf9FRheQupUlVJhXSTd0acKHAEIZUantSdHaE2htrRFmi/
         PCXd8O+DjKmX8LX+fWkqcyiYrEyF4NXDDxqxZU/zbRUdmTbowwFxfwsqAfmNw4hvn+uf
         3HhQ==
X-Gm-Message-State: ABuFfojZ9CMmmr9MF3O3Smk9hTwWqarWshRgGISZxVah0A/tWHo3U+/h
        4igc/EK05u2FrBNrkRNC2OXaYPptTzyJdM2rNUU=
X-Google-Smtp-Source: ANB0VdatjAI8Q+jY0vSItZcKJ+EIA31CTskm+41nJN4JO0R3nyAQqnzfiUC3bQ3JXip0D9TZcalRgRtsQBITyBWHnaw=
X-Received: by 2002:a37:2b12:: with SMTP id r18-v6mr1287870qkh.343.1537455143443;
 Thu, 20 Sep 2018 07:52:23 -0700 (PDT)
MIME-Version: 1.0
References: <1536914314-5026-1-git-send-email-firoz.khan@linaro.org> <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
In-Reply-To: <20180917171720.wda5qrl7hyyacmwl@pburton-laptop>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Thu, 20 Sep 2018 07:52:03 -0700
Message-ID: <CAK8P3a1=BriZ7hgzgK4QpAT00MBEtXaKOSU+vdHN1=5owB9i4A@mail.gmail.com>
Subject: Re: [PATCH 0/3] System call table generation support
To:     Paul Burton <paul.burton@mips.com>
Cc:     Firoz Khan <firoz.khan@linaro.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Marcin Juszkiewicz <marcin.juszkiewicz@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <arndbergmann@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66460
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

On Mon, Sep 17, 2018 at 10:17 AM Paul Burton <paul.burton@mips.com> wrote:
> On Fri, Sep 14, 2018 at 02:08:31PM +0530, Firoz Khan wrote:
> > The purpose of this patch series is:
> > 1. We can easily add/modify/delete system call by changing entry
> > in syscall.tbl file. No need to manually edit many files.
> >
> > 2. It is easy to unify the system call implementation across all
> > the architectures.
> >
> > The system call tables are in different format in all architecture
> > and it will be difficult to manually add or modify the system calls
> > in the respective files manually. To make it easy by keeping a script
> > and which'll generate the header file and syscall table file so this
> > change will unify them across all architectures.
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

This looks like a very nice approach that we would probably prefer if we wanted
to do it only for mips. The way Firoz did it makes sense in the context of doing
it the same way on all architectures, where usually the information is more
accessible to human readers by using the number as the primary key.

Speaking of nanoMIPS, what is your plan for the syscall ABI there?
I can see two ways of approaching it:

a) keep all the MIPSisms in the data structures, and just use a subset of
    o32 that drops all the obsolete entry points
b) start over and stay as close as possible to the generic ABI, using the
    asm-generic versions of both the syscall table and the uapi header
    files instead of the traditional version.

         Arnd

         Arnd
