Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 02 Jul 2014 19:17:34 +0200 (CEST)
Received: from mail-ob0-f177.google.com ([209.85.214.177]:42252 "EHLO
        mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6860828AbaGBRRbLPKtT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 2 Jul 2014 19:17:31 +0200
Received: by mail-ob0-f177.google.com with SMTP id uy5so12059848obc.8
        for <linux-mips@linux-mips.org>; Wed, 02 Jul 2014 10:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=E9lSnexXsFqJ2QZ7feubgKb+psH2SlzYPJYGFg2R0l4=;
        b=xHjeKS7NGsAhVh4dnYxkMuzOoRpxqwQR/fgHqEphGGUnPEMDc7OFNn8C3g/vfNHR/u
         wgn3rH0wOaa8NzlJs0AUu06PxhLv6Fq0TzOVnKW+Pri7KFvcfBVheXFERj53yloEVD+v
         eOxKDY5r+pFWO9Zl4YxKJCb14IUrtrxfFNJJgwuO35cMo+ZcQtiarW8gGADwwaYfBipo
         bxd8evv61Dr3zT+DcpILHL5VRhLB0ps+J7edKh+3SJWIdMosa/NKM1aLpzBOBXC28SwV
         02Bj9qUOO91gItTO9XF6pX3jn2HjCZnZm41kkdnfsiyWBUFk16vep9Whnc36I2l+e1tF
         R7lw==
X-Received: by 10.60.132.44 with SMTP id or12mr19867746oeb.60.1404321444829;
 Wed, 02 Jul 2014 10:17:24 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.202.9.82 with HTTP; Wed, 2 Jul 2014 10:16:44 -0700 (PDT)
In-Reply-To: <20140702160908.GA12510@waldemar-brodkorb.de>
References: <20140702160908.GA12510@waldemar-brodkorb.de>
From:   Florian Fainelli <florian@openwrt.org>
Date:   Wed, 2 Jul 2014 10:16:44 -0700
X-Google-Sender-Auth: LiS1vczhMPfuCtmWaztfBxok4ag
Message-ID: <CAGVrzcYQDrEyc4kNvbh_XFv-Hxoq0NB+c88N7TW6=7mypX7aYQ@mail.gmail.com>
Subject: Re: [PATCH] fix reregistering of serial console
To:     Waldemar Brodkorb <wbx@openadk.org>
Cc:     Linux MIPS Mailing List <linux-mips@linux-mips.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40989
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: florian@openwrt.org
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

2014-07-02 9:09 GMT-07:00 Waldemar Brodkorb <wbx@openadk.org>:
> Runtime tested on Mikrotik RB532 board.
> Thanks goes to Geert Uytterhoeven for the explanation of the problem.

The subject should be something like "MIPS: rb532: fix reregistering
of serial console" to be consistent with the other changes.

>
> "I'm afraid this is not gonna help. When the port is unregistered,
> its type will be reset to PORT_UNKNOWN.
> So before registering it again, its type must be set again the actual
> serial driver, cfr. the change to of_serial.c."
>
> Signed-off-by: Waldemar Brodkorb <wbx@openadk.org>

Reviewed-by: Florian Fainelli <florian@openwrt.org>

Thanks!

> ---
>  arch/mips/rb532/devices.c |    1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/mips/rb532/devices.c b/arch/mips/rb532/devices.c
> index 3af00b2..ba61268 100644
> --- a/arch/mips/rb532/devices.c
> +++ b/arch/mips/rb532/devices.c
> @@ -223,6 +223,7 @@ static struct platform_device rb532_wdt = {
>
>  static struct plat_serial8250_port rb532_uart_res[] = {
>         {
> +               .type           = PORT_16550A,
>                 .membase        = (char *)KSEG1ADDR(REGBASE + UART0BASE),
>                 .irq            = UART0_IRQ,
>                 .regshift       = 2,
> --
> 1.7.10.4
>
>



-- 
Florian
