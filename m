Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 22 Aug 2011 02:19:55 +0200 (CEST)
Received: from mail-vw0-f49.google.com ([209.85.212.49]:60983 "EHLO
        mail-vw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492221Ab1HVATv convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 22 Aug 2011 02:19:51 +0200
Received: by vws8 with SMTP id 8so4350184vws.36
        for <linux-mips@linux-mips.org>; Sun, 21 Aug 2011 17:19:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :content-type:content-transfer-encoding;
        bh=iwbV51cgYAmfbR2moIJQf1znXEBpb4OtlTgiTNJTzTc=;
        b=PpzqgP19VWzgvaO/fkrOpE/7uf+WLx6aYR8NlXF8aLjnAJ8lo4bEOLwUMqkl36Mc+c
         yDlgXRAY7Qkh+uMdjVxxNRHKC64M33e13F5rT8T/Zck2VSIxyZfDTHS4rE4/h7vfUgxg
         Ne58spXef58BIsyDay7Y33P384YZiE4g2TfpI=
Received: by 10.52.66.40 with SMTP id c8mr1625463vdt.21.1313972385120; Sun, 21
 Aug 2011 17:19:45 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.52.156.131 with HTTP; Sun, 21 Aug 2011 17:19:25 -0700 (PDT)
In-Reply-To: <20110821010513.GZ2657@mails.so.argh.org>
References: <20110821010513.GZ2657@mails.so.argh.org>
From:   Matt Turner <mattst88@gmail.com>
Date:   Sun, 21 Aug 2011 20:19:25 -0400
Message-ID: <CAEdQ38G8VEh+Q0gOZb7_YgvQK6n2f3u=Bep59tZ9hGJfz+C08Q@mail.gmail.com>
Subject: Re: [PATCH] mips/loongson: unify compiler flags and load location for
 Loongson 2E and 2F
To:     Andreas Barth <aba@not.so.argh.org>, linux-mips@linux-mips.org,
        debian-mips@lists.debian.org
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
X-archive-position: 30942
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: mattst88@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 15455

On Sat, Aug 20, 2011 at 9:05 PM, Andreas Barth <aba@not.so.argh.org> wrote:
> This patch is the first one in a series to unify the kernels for the different
> loongson machines. More patches will follow after more testing.
>
> Signed-off-by: Andreas Barth <aba@not.so.argh.org>
> ---
>  arch/mips/Kconfig           |    4 ++--
>  arch/mips/loongson/Platform |    9 +++------
>  2 files changed, 5 insertions(+), 8 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index b122adc..5d3e753 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -1481,7 +1481,7 @@ config CPU_XLR
>          Netlogic Microsystems XLR/XLS processors.
>  endchoice
>
> -if CPU_LOONGSON2F
> +if CPU_LOONGSON2
>  config CPU_NOP_WORKAROUNDS
>        bool
>
> @@ -1506,7 +1506,7 @@ config CPU_LOONGSON2F_WORKAROUNDS
>          systems.
>
>          If unsure, please say Y.
> -endif # CPU_LOONGSON2F
> +endif # CPU_LOONGSON2
>
>  config SYS_SUPPORTS_ZBOOT
>        bool

OK, I understand this hunk. This just allows you to enable the 2F
workarounds even if you're building for Loongson 2E, which simplifies
life for distributions. Works for me.

> diff --git a/arch/mips/loongson/Platform b/arch/mips/loongson/Platform
> index 29692e5..d6471a5 100644
> --- a/arch/mips/loongson/Platform
> +++ b/arch/mips/loongson/Platform
> @@ -4,10 +4,8 @@
>
>  # Only gcc >= 4.4 have Loongson specific support
>  cflags-$(CONFIG_CPU_LOONGSON2) += -Wa,--trap
> -cflags-$(CONFIG_CPU_LOONGSON2E) += \
> -       $(call cc-option,-march=loongson2e,-march=r4600)
> -cflags-$(CONFIG_CPU_LOONGSON2F) += \
> -       $(call cc-option,-march=loongson2f,-march=r4600)
> +cflags-$(CONFIG_CPU_LOONGSON2) += \
> +       $(call cc-option,-march=r4600)
>  # Enable the workarounds for Loongson2f
>  ifdef CONFIG_CPU_LOONGSON2F_WORKAROUNDS
>   ifeq ($(call as-option,-Wa$(comma)-mfix-loongson2f-nop,),)

... but I don't understand this one.

So, in the name of simplification, let's just remove the ability to
compile with -march=loongson2{e,f}? What?

Is there some case where a -march=loongson2e kernel won't work on a 2F
system? If not, why not just build for Loongson2E for
ease-of-distribution purposes? And if so, just add a generic
CONFIG_CPU_LOONGSON2 case without removing the 2F case.

The commit message should explain this stuff.

Matt
