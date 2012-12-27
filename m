Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 27 Dec 2012 10:45:14 +0100 (CET)
Received: from mail-vb0-f53.google.com ([209.85.212.53]:39519 "EHLO
        mail-vb0-f53.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816511Ab2L0JpNRthLW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 27 Dec 2012 10:45:13 +0100
Received: by mail-vb0-f53.google.com with SMTP id b23so9382574vbz.26
        for <multiple recipients>; Thu, 27 Dec 2012 01:45:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:date
         :x-google-sender-auth:message-id:subject:from:to:cc:content-type;
        bh=w3e+omSdnC7IU1HX45x4vvgOmXBjaW+pVKiwuoAu7lM=;
        b=NpZaFdcCf9jNlNhOtL8NR2RqyertzGGY09eaTSUyJRMnyyDW6LnNtYqVF5SbPFYiAd
         h6CpIM4VnBGUqRJwlmGMfDL/8e1ehqCSoLO5v5XhA5m2DskXA2MqTYorULU4bRfaUswA
         H2ESBlL9GYlz17R2yjLFaO716j/ZTzvwqDedrYVVgBT0DyWfko1EcTkHRDoWymYJ49wN
         aUbVQMjv9LO0d8ZEdtoyuOmWfawI2aBOLii6RxUCBgooYH9KsPj41ziE/uMfhnvKZ5X8
         GAi6jNXyaXkYE5cF0JLkr5aTKq5Fqz660RdJqczaMK0OoWa34bAglTVI70YwHGQUtdve
         e1Kg==
MIME-Version: 1.0
Received: by 10.220.238.148 with SMTP id ks20mr45880445vcb.5.1356601506795;
 Thu, 27 Dec 2012 01:45:06 -0800 (PST)
Received: by 10.58.228.71 with HTTP; Thu, 27 Dec 2012 01:45:06 -0800 (PST)
In-Reply-To: <50DC174D.6090302@gentoo.org>
References: <50DC174D.6090302@gentoo.org>
Date:   Thu, 27 Dec 2012 10:45:06 +0100
X-Google-Sender-Auth: wIpIVZ0aRo6dksnO2dJtjlNdIcs
Message-ID: <CAMuHMdXyMzQtejXOHEcSUO7fLh7CP+sPvNYdVnzKjwZx9Vj6xg@mail.gmail.com>
Subject: Re: [PATCH]: Fix 3.7 mips build if !CONFIG_MODULES
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Joshua Kinard <kumba@gentoo.org>
Cc:     Linux MIPS List <linux-mips@linux-mips.org>,
        Ralf Baechle <ralf@linux-mips.org>
Content-Type: text/plain; charset=UTF-8
X-archive-position: 35336
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On Thu, Dec 27, 2012 at 10:39 AM, Joshua Kinard <kumba@gentoo.org> wrote:
> The attached patch fixes a build failure if building a monolithic kernel due
> to arch/mips/kernel/Kconfig selecting MODULES_USE_ELF_REL[A] without
> checking to see if MODULES is set or not.  This leads to 'struct module' not
> existing, which triggers a compile failure in arch/mips/kernel/module-rela.c
> when the compiler attempts to dereference me->name on lines 36, 48, and 133.
>
> Signed-off-by: Joshua Kinard <kumba@gentoo.org>
> ---
>
>  Kconfig |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>
>
> diff -Naurp a/arch/mips/Kconfig b/arch/mips/Kconfig
> --- a/arch/mips/Kconfig 2012-12-22 22:52:28.264461836 -0500
> +++ b/arch/mips/Kconfig 2012-12-26 23:00:46.202996691 -0500
> @@ -39,8 +39,8 @@ config MIPS
>         select GENERIC_CLOCKEVENTS
>         select GENERIC_CMOS_UPDATE
>         select HAVE_MOD_ARCH_SPECIFIC
> -       select MODULES_USE_ELF_REL
> -       select MODULES_USE_ELF_RELA if 64BIT
> +       select MODULES_USE_ELF_REL && MODULES

Shouldn't that be

    select MODULES_USE_ELF_REL if MODULES

?

> +       select MODULES_USE_ELF_RELA if MODULES && 64BIT

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
