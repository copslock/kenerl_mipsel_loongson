Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Jun 2014 22:17:55 +0200 (CEST)
Received: from test.hauke-m.de ([5.39.93.123]:47272 "EHLO test.hauke-m.de"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6859936AbaFYURw56Iwv (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Jun 2014 22:17:52 +0200
Received: from [IPv6:2001:470:7259:0:3510:53e7:fc7e:801a] (unknown [IPv6:2001:470:7259:0:3510:53e7:fc7e:801a])
        by test.hauke-m.de (Postfix) with ESMTPSA id 3E1C52021F;
        Wed, 25 Jun 2014 22:17:52 +0200 (CEST)
Message-ID: <53AB2E6F.7000006@hauke-m.de>
Date:   Wed, 25 Jun 2014 22:17:51 +0200
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
CC:     Catalin Patulea <cat@vv.carleton.ca>
Subject: Re: [3.17][PATCH 2/2] MIPS: BCM47XX: Fix LEDs on WRT54GS V1.0
References: <1403243800-7849-1-git-send-email-zajec5@gmail.com> <1403243800-7849-2-git-send-email-zajec5@gmail.com>
In-Reply-To: <1403243800-7849-2-git-send-email-zajec5@gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40836
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

On 06/20/2014 07:56 AM, Rafał Miłecki wrote:
> Reported-by: Catalin Patulea <cat@vv.carleton.ca>
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>

These two patches are looking good to me.

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
>  arch/mips/bcm47xx/leds.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
> index 909e00f..23324e3 100644
> --- a/arch/mips/bcm47xx/leds.c
> +++ b/arch/mips/bcm47xx/leds.c
> @@ -306,6 +306,14 @@ bcm47xx_leds_linksys_wrt54g3gv2[] __initconst = {
>  	BCM47XX_GPIO_LED(3, "blue", "3g", 0, LEDS_GPIO_DEFSTATE_OFF),
>  };
>  
> +/* Verified on: WRT54GS V1.0 */
> +static const struct gpio_led
> +bcm47xx_leds_linksys_wrt54g_type_0101[] __initconst = {
> +	BCM47XX_GPIO_LED(0, "green", "wlan", 0, LEDS_GPIO_DEFSTATE_OFF),
> +	BCM47XX_GPIO_LED(1, "green", "power", 0, LEDS_GPIO_DEFSTATE_ON),
> +	BCM47XX_GPIO_LED(7, "green", "dmz", 1, LEDS_GPIO_DEFSTATE_OFF),
> +};
> +
>  static const struct gpio_led
>  bcm47xx_leds_linksys_wrt610nv1[] __initconst = {
>  	BCM47XX_GPIO_LED(0, "unk", "usb",  1, LEDS_GPIO_DEFSTATE_OFF),
> @@ -542,6 +550,8 @@ void __init bcm47xx_leds_register(void)
>  		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt54g3gv2);
>  		break;
>  	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0101:
> +		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt54g_type_0101);
> +		break;
>  	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0467:
>  	case BCM47XX_BOARD_LINKSYS_WRT54G_TYPE_0708:
>  		bcm47xx_set_pdata(bcm47xx_leds_linksys_wrt54g_generic);
> 
