Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 19 Oct 2014 20:07:20 +0200 (CEST)
Received: from mail-ie0-f180.google.com ([209.85.223.180]:39156 "EHLO
        mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011806AbaJSSHTEzBs5 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 19 Oct 2014 20:07:19 +0200
Received: by mail-ie0-f180.google.com with SMTP id x19so3472162ier.39
        for <linux-mips@linux-mips.org>; Sun, 19 Oct 2014 11:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=oEzlVylx1LrSAMziAEc4CSWZhIHFJNOkmRb0yClb5vc=;
        b=svaXpKq9ZTJZ+h732NLl91jJukKQVkx+2bqjAfqIn30/SmSdvL5oMWkZ0NbkkpWXRc
         yss6238DkFoe/WrYrcRwqKDe1TbNmbLc5uNBDjd6pu++tgKNHF5iRKW26bqfzvAmPRrA
         T9kf1qmgjkCPOGmuHnU0S17AvDW8XCAUeruFdHCCijEpkSgWVp1o+T1dZOaYnezf/pxd
         JXQkIP/aueytaNMZT6QOr+ZZX1kyKfzZtL+y+uqzUG/KmPTo1j7wZXk1Z1+BHcHRixkq
         ng06fztaEhoVu+Q/uJwWYq50h/SQWsnJoNdabbW0CrzDkyYBudxESC0Kli4qvnNmUFJ5
         P2tg==
X-Received: by 10.42.94.131 with SMTP id b3mr2426523icn.92.1413742033155; Sun,
 19 Oct 2014 11:07:13 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.107.33.203 with HTTP; Sun, 19 Oct 2014 11:06:32 -0700 (PDT)
In-Reply-To: <1413685818-32265-2-git-send-email-cernekee@gmail.com>
References: <1413685818-32265-1-git-send-email-cernekee@gmail.com> <1413685818-32265-2-git-send-email-cernekee@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Date:   Sun, 19 Oct 2014 11:06:32 -0700
Message-ID: <CAGVrzcYA8FWUTuDg1uksiOwMcJHwUcscbhEDkiv9PE02p9E1sw@mail.gmail.com>
Subject: Re: [PATCH 2/3] tty: serial: bcm63xx: Update the Kconfig help text
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
X-archive-position: 43339
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
> Remove incorrect "bcm963xx_uart" module name; add a list of known users;
> tweak grammar/indentation/capitalization.
>
> Signed-off-by: Kevin Cernekee <cernekee@gmail.com>

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

> ---
>  drivers/tty/serial/Kconfig | 16 +++++++++-------
>  1 file changed, 9 insertions(+), 7 deletions(-)
>
> diff --git a/drivers/tty/serial/Kconfig b/drivers/tty/serial/Kconfig
> index 4a5c0c8..815b652 100644
> --- a/drivers/tty/serial/Kconfig
> +++ b/drivers/tty/serial/Kconfig
> @@ -1281,22 +1281,24 @@ config SERIAL_TIMBERDALE
>         Add support for UART controller on timberdale.
>
>  config SERIAL_BCM63XX
> -       tristate "bcm63xx serial port support"
> +       tristate "Broadcom BCM63xx/BCM33xx UART support"
>         select SERIAL_CORE
>         depends on MIPS || ARM || COMPILE_TEST
>         help
> -         If you have a bcm63xx CPU, you can enable its onboard
> -         serial port by enabling this options.
> +         This enables the driver for the onchip UART core found on
> +         the following chipsets:
>
> -          To compile this driver as a module, choose M here: the
> -          module will be called bcm963xx_uart.
> +           BCM33xx (cable modem)
> +           BCM63xx/BCM63xxx (DSL)
> +           BCM68xx (PON)
> +           BCM7xxx (STB) - DOCSIS console
>
>  config SERIAL_BCM63XX_CONSOLE
> -       bool "Console on bcm63xx serial port"
> +       bool "Console on BCM63xx serial port"
>         depends on SERIAL_BCM63XX=y
>         select SERIAL_CORE_CONSOLE
>         help
> -         If you have enabled the serial port on the bcm63xx CPU
> +         If you have enabled the serial port on the BCM63xx CPU
>           you can make it the console by answering Y to this option.
>
>  config SERIAL_GRLIB_GAISLER_APBUART
> --
> 2.1.1
>



-- 
Florian
