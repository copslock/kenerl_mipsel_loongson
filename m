Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Mar 2014 17:34:24 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:52672 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6823123AbaCBQeVTAKpw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Mar 2014 17:34:21 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id 78B5B7E26;
        Sun,  2 Mar 2014 17:34:20 +0100 (CET)
X-Virus-Scanned: Debian amavisd-new at hauke-m.de 
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id oCOO-IcQ5hla; Sun,  2 Mar 2014 17:34:16 +0100 (CET)
Received: from [192.168.1.178] (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id 6FDB37E25;
        Sun,  2 Mar 2014 17:34:16 +0100 (CET)
Message-ID: <53135D87.6080306@hauke-m.de>
Date:   Sun, 02 Mar 2014 17:34:15 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC V2][PATCH] MIPS: BCM47XX: Add new file for device specific
 workarounds
References: <1391286733-14333-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1391286733-14333-1-git-send-email-zajec5@gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39392
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hauke@hauke-m.de
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

On 02/01/2014 09:32 PM, Rafał Miłecki wrote:
> ---
> V2: Drop pr_debug for devices we don't need workarounds for. It was too
>     load and not useful at all.
> ---

This looks good to me, feel free to add my Acked-By. You have to send it
with a Signed-off-by line.

Hauke


>  arch/mips/bcm47xx/Makefile          |  2 +-
>  arch/mips/bcm47xx/bcm47xx_private.h |  3 +++
>  arch/mips/bcm47xx/setup.c           |  1 +
>  arch/mips/bcm47xx/workarounds.c     | 25 +++++++++++++++++++++++++
>  4 files changed, 30 insertions(+), 1 deletion(-)
>  create mode 100644 arch/mips/bcm47xx/workarounds.c
> 
> diff --git a/arch/mips/bcm47xx/Makefile b/arch/mips/bcm47xx/Makefile
> index 4688b6a..d58c51b 100644
> --- a/arch/mips/bcm47xx/Makefile
> +++ b/arch/mips/bcm47xx/Makefile
> @@ -4,4 +4,4 @@
>  #
>  
>  obj-y				+= irq.o nvram.o prom.o serial.o setup.o time.o sprom.o
> -obj-y				+= board.o buttons.o leds.o
> +obj-y				+= board.o buttons.o leds.o workarounds.o
> diff --git a/arch/mips/bcm47xx/bcm47xx_private.h b/arch/mips/bcm47xx/bcm47xx_private.h
> index 5c94ace..0194c3b 100644
> --- a/arch/mips/bcm47xx/bcm47xx_private.h
> +++ b/arch/mips/bcm47xx/bcm47xx_private.h
> @@ -9,4 +9,7 @@ int __init bcm47xx_buttons_register(void);
>  /* leds.c */
>  void __init bcm47xx_leds_register(void);
>  
> +/* workarounds.c */
> +void __init bcm47xx_workarounds(void);
> +
>  #endif
> diff --git a/arch/mips/bcm47xx/setup.c b/arch/mips/bcm47xx/setup.c
> index 12d77e9..fdd9692 100644
> --- a/arch/mips/bcm47xx/setup.c
> +++ b/arch/mips/bcm47xx/setup.c
> @@ -273,6 +273,7 @@ static int __init bcm47xx_register_bus_complete(void)
>  	}
>  	bcm47xx_buttons_register();
>  	bcm47xx_leds_register();
> +	bcm47xx_workarounds();
>  
>  	return 0;
>  }
> diff --git a/arch/mips/bcm47xx/workarounds.c b/arch/mips/bcm47xx/workarounds.c
> new file mode 100644
> index 0000000..24b850c
> --- /dev/null
> +++ b/arch/mips/bcm47xx/workarounds.c
> @@ -0,0 +1,25 @@
> +#include "bcm47xx_private.h"
> +
> +#include <linux/gpio.h>
> +#include <bcm47xx_board.h>
> +#include <bcm47xx.h>
> +
> +static void __init bcm47xx_workarounds_netgear_wnr3500l(void)
> +{
> +	/* Set GPIO 12 to 1 to pass power to the USB port */
> +	gpio_set_value(12, 1);
> +}
> +
> +void __init bcm47xx_workarounds(void)
> +{
> +	enum bcm47xx_board board = bcm47xx_board_get();
> +
> +	switch (board) {
> +	case BCM47XX_BOARD_NETGEAR_WNR3500L:
> +		bcm47xx_workarounds_netgear_wnr3500l();
> +		break;
> +	default:
> +		/* No workaround(s) needed */
> +		break;
> +	}
> +}
> 
