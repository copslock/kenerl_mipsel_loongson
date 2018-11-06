Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 06 Nov 2018 16:29:56 +0100 (CET)
Received: from mail-qt1-x842.google.com ([IPv6:2607:f8b0:4864:20::842]:40579
        "EHLO mail-qt1-x842.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992869AbeKFP3wBfz2g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 6 Nov 2018 16:29:52 +0100
Received: by mail-qt1-x842.google.com with SMTP id k12so3013446qtf.7
        for <linux-mips@linux-mips.org>; Tue, 06 Nov 2018 07:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=globallogic.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=YLwoVVb0vdb+k7Wj3hDL/gN5lfWGYvzdtPiYZHIl41E=;
        b=fh2SwPwfZv2CexklQmNGOLyybQM6hyTe7CTMcRH7FVaLbF5V5DkHz/HUY0HDUPSMPJ
         nR1gdtl0+Oj7lXrYu375cn+Rz4YXIrGvdx5R28YCsqgBsvDQm6yj72CRi/7tPlxCoRLR
         FUQawRddVWE/woFqCNKEZogln2hK8Itvz4q5w=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=YLwoVVb0vdb+k7Wj3hDL/gN5lfWGYvzdtPiYZHIl41E=;
        b=Vpj64hL8jZ2sgjEyBtNipKbIfpJRmpE+YojFR1cmlq7QOoUz3k6CzyuMlhGqaioALf
         DyVe8GV+SIwTAsm4PoivfBnAPagC+Kl9UpdDPLFH23QP9MVHC2VO1lLuUcKRvVytzEJ2
         YUgyjFrDD4el8F2zysXnSjq1dFB3lhE4ySVsw6QpKD0uYnsWxusOUa5r18AV+ATdcDN5
         yVibU4vdoKEwtNmhmTbOxx8bHcCRx+zhiFYw9yjTJ7DiBnG23sRIixdrY4csar7rt+G2
         pJcC6pSIusnfyqJflMUPZARiZv6a2WWhtt8a/iupWYib8QvyBUsAbbEg1YldpQrRM4xq
         KktA==
X-Gm-Message-State: AGRZ1gKrcG6GwjRS8ITUc4XkYbmlNeqZpI7HIm12MX59BtG2RmLfXDGV
        F4p2FQt6DeIy/X7hJoQ+eu6VGpYkG9hk8fTDEXRkpQ==
X-Google-Smtp-Source: AJdET5c94s+Zb+yrg0xu6oaM2qDRnSywjXiafK9ovnA3zif3V3+huIotKaZheoMOLfcPpsRR9P5qzyyWG2kqvw+Vpuc=
X-Received: by 2002:ac8:1c50:: with SMTP id j16mr26922584qtk.320.1541518191320;
 Tue, 06 Nov 2018 07:29:51 -0800 (PST)
MIME-Version: 1.0
References: <1538587415-24126-1-git-send-email-maksym.kokhan@globallogic.com>
 <de95ca86-014d-77f6-6e2b-24f191147487@cogentembedded.com> <CAMuHMdWK0CsNsq7Sb8oG4ZvNFS3S1=8O_pUQHrY54KBV7a24FQ@mail.gmail.com>
 <CAMT6-xhP=2wjsKJFumKUsUGVL6U_BynMv6RE0cxXgk6cyfjJkw@mail.gmail.com>
In-Reply-To: <CAMT6-xhP=2wjsKJFumKUsUGVL6U_BynMv6RE0cxXgk6cyfjJkw@mail.gmail.com>
From:   Maksym Kokhan <maksym.kokhan@globallogic.com>
Date:   Tue, 6 Nov 2018 17:29:40 +0200
Message-ID: <CAMT6-xji=XrteXm6KbUYLiKqSH_-RHzXzwn3zi5hYbtq_R_sRg@mail.gmail.com>
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
X-archive-position: 67101
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

On Thu, Oct 4, 2018 at 3:06 PM Maksym Kokhan
<maksym.kokhan@globallogic.com> wrote:
>
> On Thu, Oct 4, 2018 at 12:14 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> >
> > On Thu, Oct 4, 2018 at 10:38 AM Sergei Shtylyov
> > <sergei.shtylyov@cogentembedded.com> wrote:
> > > On 10/3/2018 8:23 PM, Maksym Kokhan wrote:
> > > > CONFIG_BUILTIN_DTB selection is duplicated in menu
> > > > "Machine selection" under MIPS_MALTA.
> > > >
> > > > Fixes: e81a8c7dabac ("MIPS: Malta: Setup RAM regions via DT")
> > > > Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
> > > > Signed-off-by: Andrii Bordunov <andrew.bordunov@gmail.com>
> > > > ---
> > > >   arch/mips/Kconfig | 1 -
> > > >   1 file changed, 1 deletion(-)
> > > >
> > > > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > > > index 3551199..71d6549 100644
> > > > --- a/arch/mips/Kconfig
> > > > +++ b/arch/mips/Kconfig
> > > > @@ -539,7 +539,6 @@ config MIPS_MALTA
> > > >       select USE_OF
> > > >       select LIBFDT
> > > >       select ZONE_DMA32 if 64BIT
> > > > -     select BUILTIN_DTB
> > > >       select LIBFDT
> > >
> > >     LIBFDT seems duplicated too.
> >
> > Using random sort order doesn't help. Keep them sorted, please?
>
> We are going to deal with it in the separate patch.

Is it OK to leave this patch as it is and make another patch/patches
for other changes or it would be better to modify it to remove
duplication of LIBFDT too and sort this list of configs?

--
Regards,
Maksym Kokhan
