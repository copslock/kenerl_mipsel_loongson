Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 28 Jun 2010 03:15:50 +0200 (CEST)
Received: from mail-px0-f177.google.com ([209.85.212.177]:55398 "EHLO
        mail-px0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491812Ab0F1BPn convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 28 Jun 2010 03:15:43 +0200
Received: by pxi4 with SMTP id 4so2630158pxi.36
        for <linux-mips@linux-mips.org>; Sun, 27 Jun 2010 18:15:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=03T9DdUSjPF+TBl/AG+GsLwjmrX5MRzedvDinv9/+eo=;
        b=WyRDO+Ofo/gXG/YU7hdlOg1HWbg8IMqtCA/M10vIcANUILbLfIQT5bbrfXwZf14QJP
         CcFJloeokZ8O9UxCAX/PwjOZD7t6K99z43R+2a2LQlM+fvENCL4kT3NM34j3Xu8FhVFK
         ky5PRYHQ8LoNTdJrA7+OtKYKbZ0EnFRwXtH2E=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=X48b7L7tPpzBAchg9IVBCVRX4Rhx0aTJ0sajtjygpXbF4MViuUjSkcRImu9FtAcfH5
         nGmKxcyUn3tmovFW3sBU0rsO0KJmHpexDTRNwhchiyEtUDbnzZ+KR9r8Mrsdex2Drl/9
         JtCney7GGRm4wFQqmFMbhwq3x4oLNBOzm9HLw=
MIME-Version: 1.0
Received: by 10.142.248.9 with SMTP id v9mr4741110wfh.6.1277687736236; Sun, 27 
        Jun 2010 18:15:36 -0700 (PDT)
Received: by 10.142.211.3 with HTTP; Sun, 27 Jun 2010 18:15:36 -0700 (PDT)
In-Reply-To: <4C275781.8000904@pobox.com>
References: <4C275781.8000904@pobox.com>
Date:   Mon, 28 Jun 2010 09:15:36 +0800
Message-ID: <AANLkTilpxx_3qXB5G7odDlPT_TIlERWxLemQ9HfCc0dX@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Loongson: irq.c: Misc cleanups
From:   wu zhangjin <wuzhangjin@gmail.com>
To:     Shinya Kuribayashi <skuribay@pobox.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 27261
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: wuzhangjin@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 18337

Hi,

Looks find to me, thanks!

Acked-by: Wu Zhangjin <wuzhangjin@gmail.com>

On Sun, Jun 27, 2010 at 9:52 PM, Shinya Kuribayashi <skuribay@pobox.com> wrote:
> * Remove unnecessary 'if (int_status & (1 <<10))' statement
> * s/if (foo != 0)/if (foo)/
> * Remove unused 'inst_status &= ~(1 << i);' line
>
> Signed-off-by: Shinya Kuribayashi <skuribay@pobox.com>
> ---
>  Noticed while I'm reworking on interrupt code for EMMA2RH.
>  This is not for inclusion, but just for letting Wu-san know.
>
>  arch/mips/loongson/common/irq.c |   11 ++++-------
>  1 files changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/arch/mips/loongson/common/irq.c b/arch/mips/loongson/common/irq.c
> index 20e7328..25a11df 100644
> --- a/arch/mips/loongson/common/irq.c
> +++ b/arch/mips/loongson/common/irq.c
> @@ -21,19 +21,16 @@ void bonito_irqdispatch(void)
>
>        /* workaround the IO dma problem: let cpu looping to allow DMA finish */
>        int_status = LOONGSON_INTISR;
> -       if (int_status & (1 << 10)) {
> -               while (int_status & (1 << 10)) {
> -                       udelay(1);
> -                       int_status = LOONGSON_INTISR;
> -               }
> +       while (int_status & (1 << 10)) {
> +               udelay(1);
> +               int_status = LOONGSON_INTISR;
>        }
>
>        /* Get pending sources, masked by current enables */
>        int_status = LOONGSON_INTISR & LOONGSON_INTEN;
>
> -       if (int_status != 0) {
> +       if (int_status) {
>                i = __ffs(int_status);
> -               int_status &= ~(1 << i);
>                do_IRQ(LOONGSON_IRQ_BASE + i);
>        }
>  }
> --
> 1.7.1
>
>
