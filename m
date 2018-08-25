Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 25 Aug 2018 16:26:53 +0200 (CEST)
Received: from mx1.mailbox.org ([80.241.60.212]:23966 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S23994552AbeHYO0qkmGk8 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 25 Aug 2018 16:26:46 +0200
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id 4239E48CB5;
        Sat, 25 Aug 2018 16:26:41 +0200 (CEST)
X-Virus-Scanned: amavisd-new at heinlein-support.de
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id wRpLuhN9WlgT; Sat, 25 Aug 2018 16:26:39 +0200 (CEST)
Subject: Re: [PATCH] MIPS: BCM47XX: Enable USB power on Netgear WNDR3400v3
To:     Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org
References: <20180819192023.18463-1-tuomas.tynkkynen@iki.fi>
From:   Hauke Mehrtens <hauke@hauke-m.de>
Message-ID: <8b81db2e-050f-c467-04b5-d81244f2f500@hauke-m.de>
Date:   Sat, 25 Aug 2018 16:26:38 +0200
MIME-Version: 1.0
In-Reply-To: <20180819192023.18463-1-tuomas.tynkkynen@iki.fi>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65728
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



On 08/19/2018 09:20 PM, Tuomas Tynkkynen wrote:
> Setting GPIO 21 high seems to be required to enable power to USB ports
> on the WNDR3400v3. As there is already similar code for WNR3500L,
> make the existing USB power GPIO code generic and use that.
> 
> Signed-off-by: Tuomas Tynkkynen <tuomas.tynkkynen@iki.fi>

I didn't runtime tested this and didn't checked the board, but this
looks good.

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  arch/mips/bcm47xx/workarounds.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/mips/bcm47xx/workarounds.c b/arch/mips/bcm47xx/workarounds.c
> index 1a8a07e7a563..46eddbec8d9f 100644
> --- a/arch/mips/bcm47xx/workarounds.c
> +++ b/arch/mips/bcm47xx/workarounds.c
> @@ -5,9 +5,8 @@
>  #include <bcm47xx_board.h>
>  #include <bcm47xx.h>
>  
> -static void __init bcm47xx_workarounds_netgear_wnr3500l(void)
> +static void __init bcm47xx_workarounds_enable_usb_power(int usb_power)
>  {
> -	const int usb_power = 12;
>  	int err;
>  
>  	err = gpio_request_one(usb_power, GPIOF_OUT_INIT_HIGH, "usb_power");
> @@ -23,7 +22,10 @@ void __init bcm47xx_workarounds(void)
>  
>  	switch (board) {
>  	case BCM47XX_BOARD_NETGEAR_WNR3500L:
> -		bcm47xx_workarounds_netgear_wnr3500l();
> +		bcm47xx_workarounds_enable_usb_power(12);
> +		break;
> +	case BCM47XX_BOARD_NETGEAR_WNDR3400_V3:
> +		bcm47xx_workarounds_enable_usb_power(21);
>  		break;
>  	default:
>  		/* No workaround(s) needed */
> 
