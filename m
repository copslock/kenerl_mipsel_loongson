Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Mar 2014 22:30:53 +0100 (CET)
Received: from server19320154104.serverpool.info ([193.201.54.104]:38492 "EHLO
        hauke-m.de" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6824789AbaCNVauyN-Vj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Mar 2014 22:30:50 +0100
Received: from localhost (localhost [127.0.0.1])
        by hauke-m.de (Postfix) with ESMTP id E80B27E24;
        Fri, 14 Mar 2014 22:30:49 +0100 (CET)
Received: from hauke-m.de ([127.0.0.1])
        by localhost (hauke-m.de [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id XPPypDnW7OgE; Fri, 14 Mar 2014 22:30:45 +0100 (CET)
Received: from [192.168.1.178] (spit-414.wohnheim.uni-bremen.de [134.102.133.158])
        by hauke-m.de (Postfix) with ESMTPSA id DD2517E23;
        Fri, 14 Mar 2014 22:30:44 +0100 (CET)
Message-ID: <53237502.20305@hauke-m.de>
Date:   Fri, 14 Mar 2014 22:30:42 +0100
From:   Hauke Mehrtens <hauke@hauke-m.de>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
MIME-Version: 1.0
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
CC:     linux-mips@linux-mips.org, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [3.14 FIX][PATCH] MIPS: BCM47XX: Check all (32) GPIOs when looking
 for a pin
References: <1392310092-27365-1-git-send-email-zajec5@gmail.com>
In-Reply-To: <1392310092-27365-1-git-send-email-zajec5@gmail.com>
X-Enigmail-Version: 1.5.2
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-Path: <hauke@hauke-m.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39475
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

On 02/13/2014 05:48 PM, Rafał Miłecki wrote:
> Broadcom boards support 32 GPIOs and NVRAM may have entires for higher
> ones too. Example:
> gpio23=wombo_reset
> 
> Signed-off-by: Rafał Miłecki <zajec5@gmail.com>

Acked-by: Hauke Mehrtens <hauke@hauke-m.de>

> ---
> Preferably this should go as a fix for 3.14. It's really trivial and
> allows support for some devices that require reset by GPIO after boot.
> ---
>  arch/mips/bcm47xx/nvram.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/bcm47xx/nvram.c b/arch/mips/bcm47xx/nvram.c
> index 6decb27..2bed73a 100644
> --- a/arch/mips/bcm47xx/nvram.c
> +++ b/arch/mips/bcm47xx/nvram.c
> @@ -196,7 +196,7 @@ int bcm47xx_nvram_gpio_pin(const char *name)
>  	char nvram_var[10];
>  	char buf[30];
>  
> -	for (i = 0; i < 16; i++) {
> +	for (i = 0; i < 32; i++) {
>  		err = snprintf(nvram_var, sizeof(nvram_var), "gpio%i", i);
>  		if (err <= 0)
>  			continue;
> 
