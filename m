Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Oct 2018 11:14:57 +0200 (CEST)
Received: from mail-vs1-f66.google.com ([209.85.217.66]:47035 "EHLO
        mail-vs1-f66.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990509AbeJDJOxenjrx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Oct 2018 11:14:53 +0200
Received: by mail-vs1-f66.google.com with SMTP id i10so4922169vsm.13;
        Thu, 04 Oct 2018 02:14:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VVgNjryuYaHEROzjKlMjFdkmMkKjiB1Z+5pPT/j+3UI=;
        b=SiNe6UCAEKbsRhS+TN1CT+WvUIrb0W1ZbUyyA57nS74XXJsfLV3vwDq3FPOx36ZUNH
         31Wn4LSkiHhgqsq+2kWO7gx5vbXSM4AvoNIfuXQN82hFStyj12XindIdc5VYcA9yZAD8
         cPataNDnlOyMlayoph859G0Gl3eMnNpX6WcqiYEuinsz+TVwo7dOy0p+qByjxljhYMfS
         G4tIAjoAW05xjRGOVwmOlXEh1ysAie8zL2JfSSWsiuq8qG7TgmhzaiHqjr606JjebPMx
         eRpoRwMzLHICE6LGLrv3Y48ye9wFSkrgc6tcp2Q/lLn8slLPS2Wf2A4AK0eC5G/5I9Td
         uuqw==
X-Gm-Message-State: ABuFfogTWbsWsLiHd/rkrYX1F1Zurejz6AkNjgGSXiADEYtq1+TD3kGx
        Va8yboM2rUs8c6bIqF1dVAk0telbaj76PqUTaWg=
X-Google-Smtp-Source: ACcGV6050K7a4OCceP7Q5BEaBxMluu01m6ebcGv6+UbyyYVYYB9cFE/yJ3ZETo2VHlLhMUrZWVNmGch1UEsYEY1ubLk=
X-Received: by 2002:a67:7b56:: with SMTP id w83mr832115vsc.152.1538644487546;
 Thu, 04 Oct 2018 02:14:47 -0700 (PDT)
MIME-Version: 1.0
References: <1538587415-24126-1-git-send-email-maksym.kokhan@globallogic.com> <de95ca86-014d-77f6-6e2b-24f191147487@cogentembedded.com>
In-Reply-To: <de95ca86-014d-77f6-6e2b-24f191147487@cogentembedded.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 4 Oct 2018 11:14:35 +0200
Message-ID: <CAMuHMdWK0CsNsq7Sb8oG4ZvNFS3S1=8O_pUQHrY54KBV7a24FQ@mail.gmail.com>
Subject: Re: [PATCH] mips: delete duplication of BUILTIN_DTB selection
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Cc:     maksym.kokhan@globallogic.com, Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>, andrew.bordunov@gmail.com,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 66669
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: geert@linux-m68k.org
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

On Thu, Oct 4, 2018 at 10:38 AM Sergei Shtylyov
<sergei.shtylyov@cogentembedded.com> wrote:
> On 10/3/2018 8:23 PM, Maksym Kokhan wrote:
> > CONFIG_BUILTIN_DTB selection is duplicated in menu
> > "Machine selection" under MIPS_MALTA.
> >
> > Fixes: e81a8c7dabac ("MIPS: Malta: Setup RAM regions via DT")
> > Signed-off-by: Maksym Kokhan <maksym.kokhan@globallogic.com>
> > Signed-off-by: Andrii Bordunov <andrew.bordunov@gmail.com>
> > ---
> >   arch/mips/Kconfig | 1 -
> >   1 file changed, 1 deletion(-)
> >
> > diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> > index 3551199..71d6549 100644
> > --- a/arch/mips/Kconfig
> > +++ b/arch/mips/Kconfig
> > @@ -539,7 +539,6 @@ config MIPS_MALTA
> >       select USE_OF
> >       select LIBFDT
> >       select ZONE_DMA32 if 64BIT
> > -     select BUILTIN_DTB
> >       select LIBFDT
>
>     LIBFDT seems duplicated too.

Using random sort order doesn't help. Keep them sorted, please?

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
