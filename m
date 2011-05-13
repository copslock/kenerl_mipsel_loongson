Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 13 May 2011 18:21:20 +0200 (CEST)
Received: from mail-qy0-f170.google.com ([209.85.216.170]:33637 "EHLO
        mail-qy0-f170.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491849Ab1EMQVR convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Fri, 13 May 2011 18:21:17 +0200
Received: by qyk32 with SMTP id 32so489430qyk.15
        for <linux-mips@linux-mips.org>; Fri, 13 May 2011 09:21:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:in-reply-to:references:from
         :date:x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        bh=s/l/zcuCEpQ1P+oWGDhPrms+zWvO88WLBEz6RYEwbL8=;
        b=bDd7XAcFL95OSPdNil/rgZnD2qbDsDCsquyM74l7eOxk5JeVkIwnSTB4Xf+dIUwYXi
         ZDTS0Gg6ZNGt7Semm1x5RAJof3Zh+x92wxFfmEIuOAzssvuNcR2rlxgY8p0j8eVci6EW
         5uEI9rYEY8MFkVZiL/KSfO7oEk87uY9Nfn6Pw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:in-reply-to:references:from:date
         :x-google-sender-auth:message-id:subject:to:cc:content-type
         :content-transfer-encoding;
        b=q2TYJHX7ShKFE8K7RJCZ0H2QPAnc7O/Qs3pUG/GDJvTwl0XQr/rE9wU+zad6uozMu1
         evWMdT2q9+3cr8vQvgau547290lUPmIPRmw+OEdcDPjH/n1Muo+Xj9jFQl1AvBspFKHX
         tITHMHdI9b1moBD47bXVb5l9LORueIb6nyRww=
Received: by 10.229.17.17 with SMTP id q17mr1331515qca.154.1305303671107; Fri,
 13 May 2011 09:21:11 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.229.37.19 with HTTP; Fri, 13 May 2011 09:20:51 -0700 (PDT)
In-Reply-To: <20110513152855.GM25017@chipmunk>
References: <20110513152855.GM25017@chipmunk>
From:   Jonas Gorski <jonas.gorski+openwrt@gmail.com>
Date:   Fri, 13 May 2011 18:20:51 +0200
X-Google-Sender-Auth: cvG0Lf4tSwBPOFOqsmwbJ-5BOP8
Message-ID: <BANLkTimN7yWxsS+xdfbgPWjd=cKdyQY_YA@mail.gmail.com>
Subject: Re: [PATCH] MIPS: AR7: Fix GCC 4.6.0 build error.
To:     Alexander Clouter <alex@digriz.org.uk>
Cc:     linux-mips@linux-mips.org, florian@openwrt.org
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Return-Path: <jonas.gorski@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 30007
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jonas.gorski+openwrt@gmail.com
Precedence: bulk
X-list: linux-mips

On 13 May 2011 17:28, Alexander Clouter <alex@digriz.org.uk> wrote:
>  CC      arch/mips/ar7/gpio.o
> arch/mips/ar7/gpio.c: In function 'ar7_gpio_init':
> arch/mips/ar7/gpio.c:318:11: error: variable 'size' set but not used [-Werror=unused-but-set-variable]
> cc1: all warnings being treated as errors
>
> Signed-off-by: Alexander Clouter <alex@digriz.org.uk>
> ---
>  arch/mips/ar7/gpio.c |   12 ++----------
>  1 files changed, 2 insertions(+), 10 deletions(-)
>
> diff --git a/arch/mips/ar7/gpio.c b/arch/mips/ar7/gpio.c
> index 425dfa5..6917427 100644
> --- a/arch/mips/ar7/gpio.c
> +++ b/arch/mips/ar7/gpio.c
> @@ -314,16 +314,8 @@ static void titan_gpio_init(void)
>  int __init ar7_gpio_init(void)
>  {
>        int ret;
> -       struct ar7_gpio_chip *gpch;
> -       unsigned size;
> -
> -       if (!ar7_is_titan()) {
> -               gpch = &ar7_gpio_chip;
> -               size = 0x10;
> -       } else {
> -               gpch = &titan_gpio_chip;
> -               size = 0x1f;
> -       }
> +       struct ar7_gpio_chip *gpch = (!ar7_is_titan())
> +               ? &ar7_gpio_chip : &titan_gpio_chip;
>
>        gpch->regs = ioremap_nocache(AR7_REGS_GPIO,
>                                        AR7_REGS_GPIO + 0x10);

Without any AR7 knowledge, it looks like the size is supposed to be
used here instead of the 0x10 - also the "AR7_REGS_GPIO + 0x10" looks
wrong - I don't think the regs are 0x8610910 bytes big ;-).

Regards
Jonas
