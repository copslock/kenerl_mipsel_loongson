Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 24 Mar 2018 01:52:54 +0100 (CET)
Received: from emh04.mail.saunalahti.fi ([62.142.5.110]:58716 "EHLO
        emh04.mail.saunalahti.fi" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990723AbeCXAwrFZDcr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 24 Mar 2018 01:52:47 +0100
Received: from darkstar.musicnaut.iki.fi (85-76-86-228-nat.elisa-mobile.fi [85.76.86.228])
        by emh04.mail.saunalahti.fi (Postfix) with ESMTP id 1CB1930039;
        Sat, 24 Mar 2018 02:52:46 +0200 (EET)
Date:   Sat, 24 Mar 2018 02:52:46 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        James Hogan <jhogan@kernel.org>, Dan Haab <riproute@gmail.com>,
        =?utf-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
Subject: Re: [PATCH] MIPS: BCM47XX: Use __initdata for the bcm47xx_leds_pdata
Message-ID: <20180324005245.23f252jlcdg2oknc@darkstar.musicnaut.iki.fi>
References: <20180323225807.13386-1-zajec5@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180323225807.13386-1-zajec5@gmail.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63209
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

Hi,

On Fri, Mar 23, 2018 at 11:58:07PM +0100, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This struct variable is used during init only. It gets passed to the
> gpio_led_register_device() which creates its own data copy. That allows
> using __initdata and saving some minimal amount of memory.
> 
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Reviewed-by: Aaro Koskinen <aaro.koskinen@iki.fi>

A.

> ---
>  arch/mips/bcm47xx/leds.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/bcm47xx/leds.c b/arch/mips/bcm47xx/leds.c
> index 8307a8a02667..fb87a6c54bc9 100644
> --- a/arch/mips/bcm47xx/leds.c
> +++ b/arch/mips/bcm47xx/leds.c
> @@ -521,7 +521,7 @@ bcm47xx_leds_simpletech_simpleshare[] __initconst = {
>   * Init
>   **************************************************/
>  
> -static struct gpio_led_platform_data bcm47xx_leds_pdata;
> +static struct gpio_led_platform_data bcm47xx_leds_pdata __initdata;
>  
>  #define bcm47xx_set_pdata(dev_leds) do {				\
>  	bcm47xx_leds_pdata.leds = dev_leds;				\
> -- 
> 2.11.0
> 
> 
