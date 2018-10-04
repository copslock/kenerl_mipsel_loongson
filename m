Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2018 14:06:36 +0200 (CEST)
Received: from mail-qt1-x841.google.com ([IPv6:2607:f8b0:4864:20::841]:34838
        "EHLO mail-qt1-x841.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992907AbeJDMG23Imzk (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2018 14:06:28 +0200
Received: by mail-qt1-x841.google.com with SMTP id v19-v6so9534134qtg.2
        for <linux-mips@linux-mips.org>; Thu, 04 Oct 2018 05:06:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/VbwHE1bXXqniZTPY+6B2Ii7QmdRY5vicNxdSSO9TY0=;
        b=fwle7fpaUg0plNQ8oNRkDsqParr9ec3l7Z0pXZwquBmXimcTAbStFViIVnjm+zVMHK
         e3gAhCBSCZzCwVECxau6hzypPwuH8bANK2UvkbAvX9Wzezv8TGQ+PJymMuf2mAhbcObM
         prEr7SV+gZxDsjAbvOt7NOSid4nhgc89GSHQo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/VbwHE1bXXqniZTPY+6B2Ii7QmdRY5vicNxdSSO9TY0=;
        b=WZ8R2GR69rprKhYQNlDx29LwL6+voG5et4mQoHas8qelkEtTuYoV5m92FLqnuKqBl9
         bR8YMYHUJFxedLBuYAN4JURCIYgzOEUUzoA8b98aogk2hXyIWS8nLJh9fZ0NUh8SbXQl
         fAA3N8qKWtwhLlKtfS80429laDXtXSOlGP6VZpY7GG7q7/dskCEqRt48nSbGTFX2SOm3
         sQlpCd1qbZyHr/GTpecmtXbCr1LIPRUabTcQ4DplVuFdjzUl02fd4TtwhMMMEOnlIxr4
         89Eno4D/Eu3gv5eQKSa/xWmV/kl3pMveyLFNKF0MrukxLKHywKoR/5lubiTpgArt/gAJ
         rGfQ==
X-Gm-Message-State: ABuFfojDeNtd0twsgXIkgYR27/zDxPza/raMEINt2LxYhutcar+uUoOK
        o4kX3AfyCDFeBE3QbQ7DybGiB2uD2Iq9rawvUYA3aA==
X-Google-Smtp-Source: ACcGV63c51LJQ1u+BcKSaswSxCPLevrAxs4JbEcHWt3BcVOEb6PwtzL8S1mTcDog8rHbWNiPU4c48/0e1xsxsGfj6KI=
X-Received: by 2002:aed:210e:: with SMTP id 14-v6mr5132611qtc.9.1538654782228;
 Thu, 04 Oct 2018 05:06:22 -0700 (PDT)
MIME-Version: 1.0
References: <1538587415-24126-1-git-send-email-maksym.kokhan@globallogic.com>
 <de95ca86-014d-77f6-6e2b-24f191147487@cogentembedded.com> <CAMuHMdWK0CsNsq7Sb8oG4ZvNFS3S1=8O_pUQHrY54KBV7a24FQ@mail.gmail.com>
In-Reply-To: <CAMuHMdWK0CsNsq7Sb8oG4ZvNFS3S1=8O_pUQHrY54KBV7a24FQ@mail.gmail.com>
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
Date:   Thu, 4 Oct 2018 15:06:11 +0300
Message-ID: <CAMT6-xhP=2wjsKJFumKUsUGVL6U_BynMv6RE0cxXgk6cyfjJkw@mail.gmail.com>
Subject: Re: [PATCH] mips: delete duplication of BUILTIN_DTB selection
To:     geert@linux-m68k.org
Cc:     sergei.shtylyov@cogentembedded.com,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Andrii Bordunov <andrew.bordunov@gmail.com>,
        linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Return-Path: <maksym.kokhan@globallogic.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66672
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: maksym.kokhan@globallogic.com
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

On Thu, Oct 4, 2018 at 12:14 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> On Thu, Oct 4, 2018 at 10:38 AM Sergei Shtylyov
> <sergei.shtylyov@cogentembedded.com> wrote:
> > On 10/3/2018 8:23 PM, Maksym Kokhan wrote:
> > > CONFIG_BUILTIN_DTB selection is duplicated in menu
> > > "Machine selection" under MIPS_MALTA.
> > >
> > > Fixes: e81a8c7dabac ("MIPS: Malta: Setup RAM regions via DT")
> > > Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
> > > Signed-off-by: Andrii Bordunov <andrew.bordunov@gmail.com>
> > > ---
> > >   arch/mips/Kconfig | 1 -
> > >   1 file changed, 1 deletion(-)
> > >
> > > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > > index 3551199..71d6549 100644
> > > --- a/arch/mips/Kconfig
> > > +++ b/arch/mips/Kconfig
> > > @@ -539,7 +539,6 @@ config MIPS_MALTA
> > >       select USE_OF
> > >       select LIBFDT
> > >       select ZONE_DMA32 if 64BIT
> > > -     select BUILTIN_DTB
> > >       select LIBFDT
> >
> >     LIBFDT seems duplicated too.
>
> Using random sort order doesn't help. Keep them sorted, please?

We are going to deal with it in the separate patch.

---
Regards,
Maksym Kokhan
