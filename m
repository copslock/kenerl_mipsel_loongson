Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 21 Dec 2015 07:43:57 +0100 (CET)
Received: from mail-yk0-f175.google.com ([209.85.160.175]:36149 "EHLO
        mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27007379AbbLUGnxAClb8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 21 Dec 2015 07:43:53 +0100
Received: by mail-yk0-f175.google.com with SMTP id x184so122615152yka.3;
        Sun, 20 Dec 2015 22:43:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=obgRF/susJ//DU7mC8odFru+Wfehzi+yuHZXDwC1zSw=;
        b=K1GBQvT0MKgfyosBW+KVNRrGGxCA0H6vvl0CJup1neCX/jktx025yw94rxnBCLn/qp
         Tchd5gbp/8mwMpkj+Vy/qX2byylXuD4Lkyhd2IdCQMu7nts+HCBOUwcHR8BR8fpG3jb7
         reLU+ETmg/FkD9kCb0lPkQcGLvArRfRJG434cgCaQocHAUzg1gcQqKqJYb1HdvvMxXch
         ASlWf+hULgTul/38yvUrJwK0gZtKPKyV+Pl5pDmsscE+p2mgph+O0cZftWx8kp/M26b8
         O5YHo2BpSjqfq/k560ujIW30klAqoaLd3wR3jQ6H7yi1O74Wpd3hO1YrCdA+mchcao5I
         ixmw==
X-Received: by 10.13.217.151 with SMTP id b145mr14698834ywe.226.1450680227131;
 Sun, 20 Dec 2015 22:43:47 -0800 (PST)
MIME-Version: 1.0
Received: by 10.37.230.137 with HTTP; Sun, 20 Dec 2015 22:43:27 -0800 (PST)
In-Reply-To: <1449296276-32208-1-git-send-email-yamada.masahiro@socionext.com>
References: <1449296276-32208-1-git-send-email-yamada.masahiro@socionext.com>
From:   Wan ZongShun <mcuos.com@gmail.com>
Date:   Mon, 21 Dec 2015 14:43:27 +0800
Message-ID: <CAKT61h_1+_1Cw1m4Tg1i+1fTD_eGz0=AFTR1+NaN1H==PGCzsQ@mail.gmail.com>
Subject: Re: [PATCH] clk: let clk_disable() return immediately if clk is NULL
 or error
To:     Masahiro Yamada <yamada.masahiro@socionext.com>
Cc:     linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-sh@vger.kernel.org,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Eric Miao <eric.y.miao@gmail.com>,
        Hartley Sweeten <hsweeten@visionengravers.com>,
        Greg Ungerer <gerg@uclinux.org>,
        Ryan Mallon <rmallon@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Steven Miao <realmz6@gmail.com>,
        Simon Horman <horms@verge.net.au>,
        Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        adi-buildroot-devel@lists.sourceforge.net,
        Russell King <linux@arm.linux.org.uk>,
        "Linux/m68k" <linux-m68k@lists.linux-m68k.org>,
        Roland Stigge <stigge@antcom.de>,
        linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Dmitry Eremin-Solenikov <dbaryshkov@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        John Crispin <blogic@openwrt.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <mcuos.com@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50710
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mcuos.com@gmail.com
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

2015-12-05 14:17 GMT+08:00 Masahiro Yamada <yamada.masahiro@socionext.com>:
> The clk_disable() in the common clock framework (drivers/clk/clk.c)
> returns immediately if the given clk is NULL or an error pointer.
> It allows drivers to call clk_disable() (and clk_disable_unprepare())
> with a clock that might be NULL or an error pointer as long as the
> drivers are only used along with the common clock framework.
>
> Unfortunately, NULL/error checking is missing from some of non-common
> clk_disable() implementations.  This prevents us from completely
> dropping NULL/error from callers.  Let's add IS_ERR_OR_NULL(clk)
> checks to all callees.
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm/mach-ep93xx/clock.c     |  2 +-
>  arch/arm/mach-lpc32xx/clock.c    |  3 +++
>  arch/arm/mach-mmp/clock.c        |  3 +++
>  arch/arm/mach-sa1100/clock.c     | 15 ++++++++-------
>  arch/arm/mach-w90x900/clock.c    |  3 +++
>  arch/blackfin/mach-bf609/clock.c |  3 +++
>  arch/m68k/coldfire/clk.c         |  4 ++++
>  arch/mips/bcm63xx/clk.c          |  3 +++
>  arch/mips/lantiq/clk.c           |  3 +++
>  drivers/sh/clk/core.c            |  2 +-
>  10 files changed, 32 insertions(+), 9 deletions(-)
>
> diff --git a/arch/arm/mach-ep93xx/clock.c b/arch/arm/mach-ep93xx/clock.c
> index 39ef3b6..4e11f7d 100644
> --- a/arch/arm/mach-ep93xx/clock.c
> +++ b/arch/arm/mach-ep93xx/clock.c
> @@ -293,7 +293,7 @@ void clk_disable(struct clk *clk)
>  {
>         unsigned long flags;
>
> -       if (!clk)
> +       if (IS_ERR_OR_NULL(clk))
>                 return;
>
>         spin_lock_irqsave(&clk_lock, flags);
> diff --git a/arch/arm/mach-lpc32xx/clock.c b/arch/arm/mach-lpc32xx/clock.c
> index 661c8f4..07faac2 100644
> --- a/arch/arm/mach-lpc32xx/clock.c
> +++ b/arch/arm/mach-lpc32xx/clock.c
> @@ -1125,6 +1125,9 @@ void clk_disable(struct clk *clk)
>  {
>         unsigned long flags;
>
> +       if (IS_ERR_OR_NULL(clk))
> +               return;
> +
>         spin_lock_irqsave(&global_clkregs_lock, flags);
>         local_clk_disable(clk);
>         spin_unlock_irqrestore(&global_clkregs_lock, flags);
> diff --git a/arch/arm/mach-mmp/clock.c b/arch/arm/mach-mmp/clock.c
> index 7c6f95f..7b33122 100644
> --- a/arch/arm/mach-mmp/clock.c
> +++ b/arch/arm/mach-mmp/clock.c
> @@ -67,6 +67,9 @@ void clk_disable(struct clk *clk)
>  {
>         unsigned long flags;
>
> +       if (IS_ERR_OR_NULL(clk))
> +               return;
> +
>         WARN_ON(clk->enabled == 0);
>
>         spin_lock_irqsave(&clocks_lock, flags);
> diff --git a/arch/arm/mach-sa1100/clock.c b/arch/arm/mach-sa1100/clock.c
> index cbf53bb..ea103fd 100644
> --- a/arch/arm/mach-sa1100/clock.c
> +++ b/arch/arm/mach-sa1100/clock.c
> @@ -85,13 +85,14 @@ void clk_disable(struct clk *clk)
>  {
>         unsigned long flags;
>
> -       if (clk) {
> -               WARN_ON(clk->enabled == 0);
> -               spin_lock_irqsave(&clocks_lock, flags);
> -               if (--clk->enabled == 0)
> -                       clk->ops->disable(clk);
> -               spin_unlock_irqrestore(&clocks_lock, flags);
> -       }
> +       if (IS_ERR_OR_NULL(clk))
> +               return;
> +
> +       WARN_ON(clk->enabled == 0);
> +       spin_lock_irqsave(&clocks_lock, flags);
> +       if (--clk->enabled == 0)
> +               clk->ops->disable(clk);
> +       spin_unlock_irqrestore(&clocks_lock, flags);
>  }
>  EXPORT_SYMBOL(clk_disable);
>
> diff --git a/arch/arm/mach-w90x900/clock.c b/arch/arm/mach-w90x900/clock.c
> index 2c371ff..90ec250 100644
> --- a/arch/arm/mach-w90x900/clock.c
> +++ b/arch/arm/mach-w90x900/clock.c
> @@ -46,6 +46,9 @@ void clk_disable(struct clk *clk)
>  {
>         unsigned long flags;
>
> +       if (IS_ERR_OR_NULL(clk))
> +               return;

Looks good for w90x900 platform.
Acked-by: Wan Zongshun <mcuos.com@gmail.com>

> +
>         WARN_ON(clk->enabled == 0);
>
>         spin_lock_irqsave(&clocks_lock, flags);
> diff --git a/arch/blackfin/mach-bf609/clock.c b/arch/blackfin/mach-bf609/clock.c
> index 3783058..fed8015 100644
> --- a/arch/blackfin/mach-bf609/clock.c
> +++ b/arch/blackfin/mach-bf609/clock.c
> @@ -97,6 +97,9 @@ EXPORT_SYMBOL(clk_enable);
>
>  void clk_disable(struct clk *clk)
>  {
> +       if (IS_ERR_OR_NULL(clk))
> +               return;
> +
>         if (clk->ops && clk->ops->disable)
>                 clk->ops->disable(clk);
>  }
> diff --git a/arch/m68k/coldfire/clk.c b/arch/m68k/coldfire/clk.c
> index fddfdcc..eb0e8c1 100644
> --- a/arch/m68k/coldfire/clk.c
> +++ b/arch/m68k/coldfire/clk.c
> @@ -101,6 +101,10 @@ EXPORT_SYMBOL(clk_enable);
>  void clk_disable(struct clk *clk)
>  {
>         unsigned long flags;
> +
> +       if (IS_ERR_OR_NULL(clk))
> +               return;
> +
>         spin_lock_irqsave(&clk_lock, flags);
>         if ((--clk->enabled == 0) && clk->clk_ops)
>                 clk->clk_ops->disable(clk);
> diff --git a/arch/mips/bcm63xx/clk.c b/arch/mips/bcm63xx/clk.c
> index 6375652..d6a39bf 100644
> --- a/arch/mips/bcm63xx/clk.c
> +++ b/arch/mips/bcm63xx/clk.c
> @@ -326,6 +326,9 @@ EXPORT_SYMBOL(clk_enable);
>
>  void clk_disable(struct clk *clk)
>  {
> +       if (IS_ERR_OR_NULL(clk))
> +               return;
> +
>         mutex_lock(&clocks_mutex);
>         clk_disable_unlocked(clk);
>         mutex_unlock(&clocks_mutex);
> diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
> index a0706fd..c8d87b1 100644
> --- a/arch/mips/lantiq/clk.c
> +++ b/arch/mips/lantiq/clk.c
> @@ -130,6 +130,9 @@ EXPORT_SYMBOL(clk_enable);
>
>  void clk_disable(struct clk *clk)
>  {
> +       if (IS_ERR_OR_NULL(clk))
> +               return;
> +
>         if (unlikely(!clk_good(clk)))
>                 return;
>
> diff --git a/drivers/sh/clk/core.c b/drivers/sh/clk/core.c
> index be56b22..3dd20cf 100644
> --- a/drivers/sh/clk/core.c
> +++ b/drivers/sh/clk/core.c
> @@ -252,7 +252,7 @@ void clk_disable(struct clk *clk)
>  {
>         unsigned long flags;
>
> -       if (!clk)
> +       if (IS_ERR_OR_NULL(clk))
>                 return;
>
>         spin_lock_irqsave(&clock_lock, flags);
> --
> 1.9.1
>



-- 
---
Vincent Wan(Zongshun)
www.mcuos.com
