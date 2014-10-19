Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Oct 2014 20:06:51 +0200 (CEST)
Received: from mail-ig0-f173.google.com ([209.85.213.173]:41242 "EHLO
        mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011799AbaJSSGuBnO0o (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Oct 2014 20:06:50 +0200
Received: by mail-ig0-f173.google.com with SMTP id h18so4156664igc.0
        for <linux-mips@linux-mips.org>; Sun, 19 Oct 2014 11:06:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=RtgJe+YPs1O4n3RHdQFKhbXg6Nj+vzhlDRRDMKyFZ5M=;
        b=aiGpL+3ttIdnXoHRCSyyD9ee7byNBoTXBYlwW3NV8uv33KM7p4z9i/ATUNyQIMQ1fp
         9SpBtyiaviV3K4MGpmJdkcbBeg+pFkWYLEWeC1Ay2GBa0JZh6AjYFcTjpupllEHwZC9T
         zG0aJFqzRLAPmy2LOK0FqjV38bOPmo4q8crrnp5xGg4JyF/Uxb5YIMAuWaOHEar6ihIp
         cRY61RQP1dGohWgL0i4yVqtNqTg8NzfkhcaZRN8AGZijQmqU/VnWY9owCK6U/Sr6MOTN
         Fc1cfKx6BT5PuRW0MyzjpGa9pobOlz6NSxP6uiwM8hJXDz5sia2Q+AjIwHAXjyUXh5mb
         iN3w==
X-Received: by 10.42.236.19 with SMTP id ki19mr2724083icb.73.1413742003806;
 Sun, 19 Oct 2014 11:06:43 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.33.203 with HTTP; Sun, 19 Oct 2014 11:06:03 -0700 (PDT)
In-Reply-To: <1413685818-32265-1-git-send-email-cernekee@gmail.com>
References: <1413685818-32265-1-git-send-email-cernekee@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Sun, 19 Oct 2014 11:06:03 -0700
Message-ID: <CAGVrzca5gOs1mCeVokC0NHJCf7P7CL5BLtR8dXiPwpL5nWnU9g@mail.gmail.com>
Subject: Re: [PATCH 1/3] tty: serial: bcm63xx: Allow bcm63xx_uart to be built
 on other platforms
To:     Kevin Cernekee <cernekee@gmail.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>, jslaby@suse.cz,
        mbizon <mbizon@freebox.fr>, Jonas Gorski <jogo@openwrt.org>,
        Linux-MIPS <linux-mips@linux-mips.org>,
        linux-serial@vger.kernel.org
Content-Type: text/plain; charset=UTF-8
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 43338
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

2014-10-18 19:30 GMT-07:00 Kevin Cernekee <cernekee@gmail.com>:
> This device was originally supported on bcm63xx only, but it shows up on
> a wide variety of MIPS and ARM chipsets spanning multiple product lines.
> Now that the driver has eliminated dependencies on bcm63xx-specific
> header files, we can build it on any non-bcm63xx kernel.
>
> Compile-tested on x86, both statically and as a module.  Tested for
> functionality on bcm3384 (a new MIPS platform under active development).
>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/tty/serial/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 649b784..4a5c0c8 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1283,7 +1283,7 @@ config SERIAL_TIMBERDALE
>  config SERIAL_BCM63XX
>         tristate "bcm63xx serial port support"
>         select SERIAL_CORE
> -       depends on BCM63XX
> +       depends on MIPS || ARM || COMPILE_TEST
>         help
>           If you have a bcm63xx CPU, you can enable its onboard
>           serial port by enabling this options.
> --
> 2.1.1
>



-- 
Florian
