Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 14 Aug 2013 13:13:26 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:43057 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6819547Ab3HNLNXc7XKu (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 14 Aug 2013 13:13:23 +0200
Received: from mail-ve0-x233.google.com (mail-ve0-x233.google.com [IPv6:2607:f8b0:400c:c01::233])
        by mail.nanl.de (Postfix) with ESMTPSA id C7D6A4033C
        for <linux-mips@linux-mips.org>; Wed, 14 Aug 2013 11:13:14 +0000 (UTC)
Received: by mail-ve0-f179.google.com with SMTP id c13so7513346vea.24
        for <linux-mips@linux-mips.org>; Wed, 14 Aug 2013 04:13:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=f8TM+18RGHWB27jHtmj4FgPWNKj9DccRS7RSOvxjrHE=;
        b=oC7AidKhQE2BeFwnnzW6s1ul75bgV/t8pQ6EXtSPfM7H5oygC1tKWTDmyagpeanRXM
         eyPFNbU+sGw2LjHyp+r38FaXIpP6WUmQES3GGdPvcTvOU0UwZstwiZPcWVebADzodDhs
         R3KIf4hIg7qY+4RbrTolHshtTn0WWvvv5aKcyDweAr3dvB4Iu0bOTHHbmmpiQym4Ms5D
         m4wgtlhQJ5IEWnMROj0uWqgdov1sUlT+noJCWMkfPSQXAr1eXTfRkzv6rVkXaXR7HcDr
         YJJn4cQHV69lsENiCPVax+Ak5WxzAVdHqRkF2543c6qSx6GulXEbcn08I0Psd/wtbApE
         Gy2w==
X-Received: by 10.220.91.16 with SMTP id k16mr9252713vcm.21.1376478796939;
 Wed, 14 Aug 2013 04:13:16 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.162.9 with HTTP; Wed, 14 Aug 2013 04:12:56 -0700 (PDT)
In-Reply-To: <1376384478-27424-1-git-send-email-markos.chandras@imgtec.com>
References: <1376384478-27424-1-git-send-email-markos.chandras@imgtec.com>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Wed, 14 Aug 2013 13:12:56 +0200
Message-ID: <CAOiHx==9E9m5Ds0trutySyaxM0VLJfh1+LKcxYfWFWFt-8dx1A@mail.gmail.com>
Subject: Re: [PATCH] MIPS: ath79: Avoid using unitialized 'reg' variable
To:     Markos Chandras <markos.chandras@imgtec.com>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37543
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jogo@openwrt.org
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

Hi,

On Tue, Aug 13, 2013 at 11:01 AM, Markos Chandras
<markos.chandras@imgtec.com> wrote:
> Fixes the following build error:
> arch/mips/include/asm/mach-ath79/ath79.h:139:20: error: 'reg' may be used
> uninitialized in this function [-Werror=maybe-uninitialized]
> arch/mips/ath79/common.c:62:6: note: 'reg' was declared here
> In file included from arch/mips/ath79/common.c:20:0:
> arch/mips/ath79/common.c: In function 'ath79_device_reset_clear':
> arch/mips/include/asm/mach-ath79/ath79.h:139:20:
> error: 'reg' may be used uninitialized in this function
> [-Werror=maybe-uninitialized]
> arch/mips/ath79/common.c:90:6: note: 'reg' was declared here
>
> Signed-off-by: Markos Chandras <markos.chandras@imgtec.com>
> ---
> This patch is for the upstream-sfr/mips-for-linux-next tree
> ---
>  arch/mips/ath79/common.c | 32 ++++++++++++++++++--------------
>  1 file changed, 18 insertions(+), 14 deletions(-)
>
> diff --git a/arch/mips/ath79/common.c b/arch/mips/ath79/common.c
> index eb3966c..6a8c00f 100644
> --- a/arch/mips/ath79/common.c
> +++ b/arch/mips/ath79/common.c
> @@ -62,20 +62,22 @@ void ath79_device_reset_set(u32 mask)
>         u32 reg;
>         u32 t;
>
> -       if (soc_is_ar71xx())
> +       if (soc_is_ar71xx()) {
>                 reg = AR71XX_RESET_REG_RESET_MODULE;
> -       else if (soc_is_ar724x())
> +       } else if (soc_is_ar724x()) {
>                 reg = AR724X_RESET_REG_RESET_MODULE;
> -       else if (soc_is_ar913x())
> +       } else if (soc_is_ar913x()) {
>                 reg = AR913X_RESET_REG_RESET_MODULE;
> -       else if (soc_is_ar933x())
> +       } else if (soc_is_ar933x()) {
>                 reg = AR933X_RESET_REG_RESET_MODULE;
> -       else if (soc_is_ar934x())
> +       } else if (soc_is_ar934x()) {
>                 reg = AR934X_RESET_REG_RESET_MODULE;
> -       else if (soc_is_qca955x())
> +       } else if (soc_is_qca955x()) {
>                 reg = QCA955X_RESET_REG_RESET_MODULE;
> -       else
> +       } else {
>                 BUG();
> +               panic("Unknown SOC!");

Both BUG() and panic() seems to be a bit overkill, especially since
the panic won't be reached unless BUG is disabled - just the panic()
should be enough.

Also the panic message isn't very helpful, maybe print the raw id of
the SoC here?

> +       }
>
>         spin_lock_irqsave(&ath79_device_reset_lock, flags);
>         t = ath79_reset_rr(reg);
> @@ -90,20 +92,22 @@ void ath79_device_reset_clear(u32 mask)
>         u32 reg;
>         u32 t;
>
> -       if (soc_is_ar71xx())
> +       if (soc_is_ar71xx()) {
>                 reg = AR71XX_RESET_REG_RESET_MODULE;
> -       else if (soc_is_ar724x())
> +       } else if (soc_is_ar724x()) {
>                 reg = AR724X_RESET_REG_RESET_MODULE;
> -       else if (soc_is_ar913x())
> +       } else if (soc_is_ar913x()) {
>                 reg = AR913X_RESET_REG_RESET_MODULE;
> -       else if (soc_is_ar933x())
> +       } else if (soc_is_ar933x()) {
>                 reg = AR933X_RESET_REG_RESET_MODULE;
> -       else if (soc_is_ar934x())
> +       } else if (soc_is_ar934x()) {
>                 reg = AR934X_RESET_REG_RESET_MODULE;
> -       else if (soc_is_qca955x())
> +       } else if (soc_is_qca955x()) {
>                 reg = QCA955X_RESET_REG_RESET_MODULE;
> -       else
> +       } else {
>                 BUG();
> +               panic("Unknown SOC!");

Same comment here.

> +       }
>
>         spin_lock_irqsave(&ath79_device_reset_lock, flags);
>         t = ath79_reset_rr(reg);
> --
> 1.8.3.2


Regards
Jonas
