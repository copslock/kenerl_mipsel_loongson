Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 20 Oct 2014 09:21:51 +0200 (CEST)
Received: from mail-la0-f45.google.com ([209.85.215.45]:54418 "EHLO
        mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011777AbaJTHVtOBf26 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 20 Oct 2014 09:21:49 +0200
Received: by mail-la0-f45.google.com with SMTP id q1so3396012lam.32
        for <multiple recipients>; Mon, 20 Oct 2014 00:21:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date:message-id:subject
         :from:to:cc:content-type:content-transfer-encoding;
        bh=Mauj8OJ0gP3iOPPHmepjyMbkqvu4ZsaVgnm+XLChJlY=;
        b=lgXpxdsVKXaqmF4D/Wo8R6tfF1HU9/53+6nDjE46awBKN9Danjp5iPlcZQbVCzwHZ5
         ckW1mJ/tRM63tieFLqMC4OfFhKqE3DomFcNAKZ0EuUxuxPpw5U59311hTUs/a5Lg8MJZ
         92E+M5NmeCw1yKKEBgEUtcbm9BJXilIryiviM4UELrmDGKkzfBmBeNlSQzr47OR2Yrb9
         1j9kcaJyDFrIQ69cDkaC8K0lgpKSo4B2fo86RBR69WeWn9yMMAc1s97mY5QGqZ0vqaQ7
         JEM+rCXXK/CQ9jng5G9+riC36OtSTR1OSsacfLt+RcRQSlIdLaxuJiHe6SjTOGBjoCQI
         1sdA==
MIME-Version: 1.0
X-Received: by 10.112.97.135 with SMTP id ea7mr25610758lbb.46.1413789703718;
 Mon, 20 Oct 2014 00:21:43 -0700 (PDT)
Received: by 10.152.30.34 with HTTP; Mon, 20 Oct 2014 00:21:43 -0700 (PDT)
In-Reply-To: <1413741866-48496-1-git-send-email-stefan.hengelein@fau.de>
References: <1413741866-48496-1-git-send-email-stefan.hengelein@fau.de>
Date:   Mon, 20 Oct 2014 09:21:43 +0200
X-Google-Sender-Auth: DajWq-TIoe5lQvweGOrtfQL_ti8
Message-ID: <CAMuHMdU_z+vAFR1VdRpTGUYNOOpzdRmfQJAQ7Nqe40pdvx9Y1w@mail.gmail.com>
Subject: Re: [PATCH] MIPS: MSP71xx: remove compilation error
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Stefan Hengelein <stefan.hengelein@fau.de>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <geert.uytterhoeven@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43348
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

On Sun, Oct 19, 2014 at 8:04 PM, Stefan Hengelein
<stefan.hengelein@fau.de> wrote:
> When CONFIG_MIPS_MT_SMP is enabled, the following compilation error
> occurs:
>
> arch/mips/pmcs-msp71xx/msp_irq_cic.c:134: error: ‘irq’ undeclared
>
> This code clearly never saw a compiler.
> The surrounding code suggests, that 'd->irq' was intended, not
> 'irq'.
>
> This error was found with vampyr.
>
> Signed-off-by: Stefan Hengelein <stefan.hengelein@fau.de>

Acked-by: Geert Uytterhoeven <geert@linux-m68k.org>
Fixes: d7881fbdf866d7d0 ("MIPS: msp71xx: Convert to new irq_chip functions")

(from 2011 ;-)

> ---
>  arch/mips/pmcs-msp71xx/msp_irq_cic.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/pmcs-msp71xx/msp_irq_cic.c b/arch/mips/pmcs-msp71xx/msp_irq_cic.c
> index b8df2f7..1207ec4 100644
> --- a/arch/mips/pmcs-msp71xx/msp_irq_cic.c
> +++ b/arch/mips/pmcs-msp71xx/msp_irq_cic.c
> @@ -131,11 +131,11 @@ static int msp_cic_irq_set_affinity(struct irq_data *d,
>         int cpu;
>         unsigned long flags;
>         unsigned int  mtflags;
> -       unsigned long imask = (1 << (irq - MSP_CIC_INTBASE));
> +       unsigned long imask = (1 << (d->irq - MSP_CIC_INTBASE));
>         volatile u32 *cic_mask = (volatile u32 *)CIC_VPE0_MSK_REG;
>
>         /* timer balancing should be disabled in kernel code */
> -       BUG_ON(irq == MSP_INT_VPE0_TIMER || irq == MSP_INT_VPE1_TIMER);
> +       BUG_ON(d->irq == MSP_INT_VPE0_TIMER || d->irq == MSP_INT_VPE1_TIMER);
>
>         LOCK_CORE(flags, mtflags);
>         /* enable if any of each VPE's TCs require this IRQ */

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
