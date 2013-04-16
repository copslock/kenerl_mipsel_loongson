Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Apr 2013 13:32:24 +0200 (CEST)
Received: from mail.nanl.de ([217.115.11.12]:43447 "EHLO mail.nanl.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6835171Ab3DPLcXFD7ER (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 16 Apr 2013 13:32:23 +0200
Received: from mail-vc0-f170.google.com (mail-vc0-f170.google.com [209.85.220.170])
        by mail.nanl.de (Postfix) with ESMTPSA id 438EE45F5D
        for <linux-mips@linux-mips.org>; Tue, 16 Apr 2013 11:32:20 +0000 (UTC)
Received: by mail-vc0-f170.google.com with SMTP id lf10so283404vcb.15
        for <linux-mips@linux-mips.org>; Tue, 16 Apr 2013 04:32:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=/g5VmxpK3yjgplePKr5LsIZZWaTCc+yMLY/gXORYF+g=;
        b=LI38uSHCe6PNO9MGO5i1i7bDtVrj1m/YtuWceXulb/ejvoY6nbEdJm0DSh+qEQRkHO
         0gDjw9P5T47YLEkrgir4IRChA85CFZYhEvg02kAF9xJFMc0athGxECLJWefxeMX8Hu7s
         EsRk5ksLoZSK1qdKFt2hwRmSIPHZx58pWic/tbly4cM81jKFzQIH6HlHWFMoqW1VRvC1
         oQizQrC2drHuvIrefXIAcwKtDy37tOlOWOD0u0OMxGLrO2is4lQ1hrzV7OSE4RZrP7wx
         fU4Bw0/inee9CPrImAGhnVQXIE6LQjoCDgWncS8NpjQCXWHv8ZGD6HuKEE6KUfcDnIXi
         UQMQ==
X-Received: by 10.52.237.137 with SMTP id vc9mr996528vdc.102.1366111938276;
 Tue, 16 Apr 2013 04:32:18 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.220.31.73 with HTTP; Tue, 16 Apr 2013 04:31:58 -0700 (PDT)
In-Reply-To: <1366093125-19352-1-git-send-email-blogic@openwrt.org>
References: <1366093125-19352-1-git-send-email-blogic@openwrt.org>
From:   Jonas Gorski <jogo@openwrt.org>
Date:   Tue, 16 Apr 2013 13:31:58 +0200
Message-ID: <CAOiHx=npmzXe8yk1NLwzK0dQ-XsM-0bbT+L5Yg5LL05n0a3BKA@mail.gmail.com>
Subject: Re: [PATCH V2] tty: serial: ralink: fix SERIAL_8250_RT288X dependency
To:     John Crispin <blogic@openwrt.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, linux-mips@linux-mips.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <jogo@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36240
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

On 16 April 2013 08:18, John Crispin <blogic@openwrt.org> wrote:
> With every Ralink SoC that we add, we would need to extend the dependency. In
> order to make life easier we make the symbol depend on MIPS & RALINK and then
> select it from within arch/mips/ralink/.
>
> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
> Hi Greg,
>
> this patch should go upstream via the mips tree to avoid merge conflicts.
> The tty part however requires your Ack.
>
>         John
>
>  arch/mips/Kconfig               |    1 +
>  drivers/tty/serial/8250/Kconfig |    4 ++--
>  2 files changed, 3 insertions(+), 2 deletions(-)
>
> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
> index c1997db..2e8939f 100644
> --- a/arch/mips/Kconfig
> +++ b/arch/mips/Kconfig
> @@ -441,6 +441,7 @@ config RALINK
>         select SYS_HAS_EARLY_PRINTK
>         select HAVE_MACH_CLKDEV
>         select CLKDEV_LOOKUP
> +       select SERIAL_8250_RT288X
>
>  config SGI_IP22
>         bool "SGI IP22 (Indy/Indigo2)"
> diff --git a/drivers/tty/serial/8250/Kconfig b/drivers/tty/serial/8250/Kconfig
> index 80fe91e..24ea3c8 100644
> --- a/drivers/tty/serial/8250/Kconfig
> +++ b/drivers/tty/serial/8250/Kconfig
> @@ -295,8 +295,8 @@ config SERIAL_8250_EM
>           If unsure, say N.
>
>  config SERIAL_8250_RT288X
> -       bool "Ralink RT288x/RT305x/RT3662/RT3883 serial port support"
> -       depends on SERIAL_8250 && (SOC_RT288X || SOC_RT305X || SOC_RT3883)
> +       bool
> +       depends on SERIAL_8250 && MIPS && RALINK

This won't work, Having RALINK=y, but SERIAL_8250=n will still result
in SERIAL_8250_RT288X=y, as select ignores dependencies. What could
work is removing the select from RALINK, and changing the depends from
this one to "default y if SERIAL_8250 && MIPS && RALINK".

>         help
>           If you have a Ralink RT288x/RT305x SoC based board and want to use the
>           serial port, say Y to this option. The driver can handle up to 2 serial
> --
> 1.7.10.4
>
>

Jonas
