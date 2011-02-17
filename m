Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 17 Feb 2011 10:47:05 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:61335 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491075Ab1BQJrC (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 17 Feb 2011 10:47:02 +0100
Received: by wyf22 with SMTP id 22so2162227wyf.36
        for <multiple recipients>; Thu, 17 Feb 2011 01:46:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=aprv5tCK4uqXmtfan0pY1IWK6XZnYhYGgzNgrH8qLz0=;
        b=H/qgx/ilhafyeIanG0GfcfcrnIOIP2kRl3fwlQebONm8NyBEab3NWK3KNmtfWCc/2Y
         eeMZQFcDKvdCkNIY2EpSaehzX8Z99ddwOgx/AK4XRHXtZ0cwqIYD0iCrO4ubMUyymxu3
         ku75wSRyFGlltNzrwH+q7Ph8/Ecb9Vm8Ft6wQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=tN+7o0tp/AAUt/GXsr0BcVU2v4pitRwDNtQTy8hy611wakOOuV4ThSK9S02J8tcqUI
         mgdwl77vw4YYHpS0neioIhsYurAv5qVVNLKgc/xpgfo/hHgp7oncf8sav1kmDq1KBFeM
         y9YdyZLRzxNUmAQxw87nKLU0YLbdIN9Lc8KdY=
MIME-Version: 1.0
Received: by 10.216.166.68 with SMTP id f46mr120089wel.26.1297936016937; Thu,
 17 Feb 2011 01:46:56 -0800 (PST)
Received: by 10.216.220.199 with HTTP; Thu, 17 Feb 2011 01:46:56 -0800 (PST)
In-Reply-To: <1297931166-23957-1-git-send-email-antonynpavlov@gmail.com>
References: <1297931166-23957-1-git-send-email-antonynpavlov@gmail.com>
Date:   Thu, 17 Feb 2011 12:46:56 +0300
Message-ID: <AANLkTint742iP6y9eaupHywby-WbYk542B4GVdd6gJaX@mail.gmail.com>
Subject: Re: [PATCH] MIPS: Loongson: Kconfig: add MACH_LOONGSON dependency
From:   =?KOI8-R?B?4c7Uz84g8MHXzM/X?= <antonynpavlov@gmail.com>
To:     Ralf Baechle <ralf@linux-mips.org>
Cc:     linux-mips@linux-mips.org
Content-Type: text/plain; charset=ISO-8859-1
Return-Path: <antonynpavlov@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29200
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: antonynpavlov@gmail.com
Precedence: bulk
X-list: linux-mips

Sorry, the mail adresses in fields "From" and "Signed-off-by" are different.

I shall resend the patch in a few minutes.

2011/2/17, Antony Pavlov <antonynpavlov@gmail.com>:
> From: Antony Pavlov <antony@niisi.msk.ru>
>
> The options LOONGSON_SUSPEND, LOONGSON_UART_BASE et al. don't depend
> on MACH_LOONGSON option.
> So my configuration file (.config) for MIPS Malta board contains
>
>  # CONFIG_MACH_LOONGSON is not set
>  CONFIG_MIPS_MALTA=y
>
>  ...
>
>  CONFIG_LOONGSON_UART_BASE=y
>
> Signed-off-by: Antony Pavlov <antonynpavlov@gmail.com>
> ---
>  arch/mips/loongson/Kconfig |    6 ++++--
>  1 files changed, 4 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/loongson/Kconfig b/arch/mips/loongson/Kconfig
> index 6e1b77f..4f2cf08 100644
> --- a/arch/mips/loongson/Kconfig
> +++ b/arch/mips/loongson/Kconfig
> @@ -61,6 +61,7 @@ endchoice
>
>  config CS5536
>  	bool
> +	depends on MACH_LOONGSON
>
>  config CS5536_MFGPT
>  	bool "CS5536 MFGPT Timer"
> @@ -77,13 +78,14 @@ config CS5536_MFGPT
>  config LOONGSON_SUSPEND
>  	bool
>  	default y
> -	depends on CPU_SUPPORTS_CPUFREQ && SUSPEND
> +	depends on MACH_LOONGSON && CPU_SUPPORTS_CPUFREQ && SUSPEND
>
>  config LOONGSON_UART_BASE
>  	bool
>  	default y
> -	depends on EARLY_PRINTK || SERIAL_8250
> +	depends on MACH_LOONGSON && (EARLY_PRINTK || SERIAL_8250)
>
>  config LOONGSON_MC146818
>  	bool
>  	default n
> +	depends on MACH_LOONGSON
> --
> 1.7.1
>
>
