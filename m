Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Nov 2018 11:54:34 +0100 (CET)
Received: from mail-qk1-f193.google.com ([209.85.222.193]:40812 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990505AbeKTKycCz7zI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Nov 2018 11:54:32 +0100
Received: by mail-qk1-f193.google.com with SMTP id y16so2065261qki.7;
        Tue, 20 Nov 2018 02:54:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1ytHfs+LGC7Kt7FaIlYKMVZnBQtU1xZYDUo378mjB9o=;
        b=D/u+NFmz7aShMhmwUWU4wSQXdOmyj3DL6vFFL1fGz2nzxoWnztx4LtGlbbooP3PoZy
         GhPL10FIyg19BdpN33rEnsAtnHDR8hujXDqiwDJnxlgfyI7ijiPxJADiSZyLBr+qA7EG
         DAlqTaRO8n1pEyJ1XP13i0P/gFxPwnO+olI3Ofu/O2MXU2A31pyDNdCvGGnGHtDZYtts
         PkypyWaPIy6SB2IiREMjHpc4QeoG5vXotoqneK09S90ezKqvIBmr5pU6m+NVohCnFH5C
         8OnuMIPfpFKvLlAvRxxCjtwEpZxBgkF/zlOY/6ALzMsSuYlusfovhQlmNiB0QYqpELD2
         Yxrw==
X-Gm-Message-State: AGRZ1gLb2ccPRJrBCe57w9o+tqLdGd+alcl4qes8bd4o+IFEM/LmNsNk
        shLitxKNFevXAjYXAG0Jq0R3Le5NWkFdqomOLDk=
X-Google-Smtp-Source: AFSGD/VizlVYkgxMIG1ZsBTMuRYvngW0qZnrMXdfe/kM5yV6rlc7zlymK9L6gA5VjGA35dK2yarO7eZvMqm8e3WfwUI=
X-Received: by 2002:ac8:1d12:: with SMTP id d18mr1320428qtl.343.1542711271032;
 Tue, 20 Nov 2018 02:54:31 -0800 (PST)
MIME-Version: 1.0
References: <1542262461-29024-1-git-send-email-firoz.khan@linaro.org>
 <1542262461-29024-4-git-send-email-firoz.khan@linaro.org> <20181119222924.ybnl7qe4hobud5fb@pburton-laptop>
In-Reply-To: <20181119222924.ybnl7qe4hobud5fb@pburton-laptop>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Tue, 20 Nov 2018 11:54:07 +0100
Message-ID: <CAK8P3a2o+jKd0EF81TezmJbTLBPRN9frCBf3wvxySa0sEbC+-A@mail.gmail.com>
Subject: Re: [PATCH v2 3/5] mips: remove syscall table entries
To:     Paul Burton <paul.burton@mips.com>
Cc:     Firoz Khan <firoz.khan@linaro.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        "open list:RALINK MIPS ARCHITECTURE" <linux-mips@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        gregkh <gregkh@linuxfoundation.org>,
        Philippe Ombredanne <pombredanne@nexb.com>,
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
X-archive-position: 67400
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

On Mon, Nov 19, 2018 at 11:29 PM Paul Burton <paul.burton@mips.com> wrote:
>
> Hi Firoz,
>
> On Thu, Nov 15, 2018 at 11:44:19AM +0530, Firoz Khan wrote:
> > diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
> > index a9b895f..4eee437 100644
> > --- a/arch/mips/kernel/scall32-o32.S
> > +++ b/arch/mips/kernel/scall32-o32.S
> > @@ -208,6 +208,18 @@ einval: li       v0, -ENOSYS
> >       jr      ra
> >       END(sys_syscall)
> >
> > +#ifdef CONFIG_MIPS_MT_FPAFF
> > +     /*
> > +      * For FPU affinity scheduling on MIPS MT processors, we need to
> > +      * intercept sys_sched_xxxaffinity() calls until we get a proper hook
> > +      * in kernel/sched/core.c.  Considered only temporary we only support
> > +      * these hooks for the 32-bit kernel - there is no MIPS64 MT processor
> > +      * atm.
> > +      */
> > +#define mipsmt_sys_sched_setaffinity sys_sched_setaffinity
> > +#define mipsmt_sys_sched_getaffinity sys_sched_getaffinity
>
> Is this backwards? ie. should it be:
>
>     #define sys_sched_setaffinity mipsmt_sys_sched_setaffinity
>     #define sys_sched_getaffinity mipsmt_sys_sched_getaffinity
>
> ?
>
> I don't see how the mipsmt_* functions will ever be used after this
> patch.

Good catch!

> > -      * atm.
> > -      */
> > -     PTR     mipsmt_sys_sched_setaffinity
> > -     PTR     mipsmt_sys_sched_getaffinity
> > -#else
> >       PTR     sys_sched_setaffinity
> >       PTR     sys_sched_getaffinity           /* 4240 */
> > -#endif /* CONFIG_MIPS_MT_FPAFF */
> >       PTR     sys_io_setup

My guess would be that he removed the wrong lines here instead,
and the first half was intentional.

       Arnd
