Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 18 Aug 2016 20:58:52 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:40162 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992466AbcHRS6orwW4y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 18 Aug 2016 20:58:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date;
        bh=GoB97x1lEOnpM1hWIq8wa5YQ3RN0Ju45IhCgDh3VeB8=; b=b/tATX7Rr0LaRRbCZKGwNAONtK
        jzNg/x7Or0TWn4jnlZF8cT442Ol/QhwmXFY1KNqA2XjBBmLbVlnSMzBYbLzC5uxoZrG6gDAHrAfVl
        +RwyRN5iIanY0JlWkoV+iSiAqZcNwQkSw4sU04IFHjT9RFbuQJqluRCEkVcFrSkZT/kGVVWScYO/b
        k3yu6bmuPF1J5wNF2ESlLr2bVB/sytfX5A7BMxpISOflvhBOT7zkTpicRw/LREok2XLtdoOl8Dp/Q
        orT9OZtX7dEpdKz3TT3xs5XMUzH260Q8uU1krzqsSIW0RHtklr9ei22e6pK8Xtxc6UmN02zTEP8vo
        uDYCNQWg==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:57798 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1baSWR-002Uad-Tp; Thu, 18 Aug 2016 18:58:36 +0000
Date:   Thu, 18 Aug 2016 11:58:36 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>, linux-clk@vger.kernel.org,
        linux-mips@linux-mips.org, linux-spi@vger.kernel.org,
        linux-watchdog@vger.kernel.org
Subject: Re: [PATCH 2/3] watchdog: txx9wdt: Add missing clock (un)prepare
 calls for CCF
Message-ID: <20160818185836.GA7221@roeck-us.net>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
 <1471541667-30689-3-git-send-email-geert@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1471541667-30689-3-git-send-email-geert@linux-m68k.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Authenticated_sender: guenter@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: guenter@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: guenter@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54661
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On Thu, Aug 18, 2016 at 07:34:26PM +0200, Geert Uytterhoeven wrote:
> While the custom minimal TXx9 clock implementation doesn't need or use
> clock (un)prepare calls (they are dummies if !CONFIG_HAVE_CLK_PREPARE),
> they are mandatory when using the Common Clock Framework.
> 
> Hence add them, to prepare for the advent of CCF.
> 
> Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> Tested on RBTX4927.
> ---
>  drivers/watchdog/txx9wdt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/watchdog/txx9wdt.c b/drivers/watchdog/txx9wdt.c
> index c2da880292bc2f32..6f7a9deb27d05d25 100644
> --- a/drivers/watchdog/txx9wdt.c
> +++ b/drivers/watchdog/txx9wdt.c
> @@ -112,7 +112,7 @@ static int __init txx9wdt_probe(struct platform_device *dev)
>  		txx9_imclk = NULL;
>  		goto exit;
>  	}
> -	ret = clk_enable(txx9_imclk);
> +	ret = clk_prepare_enable(txx9_imclk);
>  	if (ret) {
>  		clk_put(txx9_imclk);
>  		txx9_imclk = NULL;
> @@ -144,7 +144,7 @@ static int __init txx9wdt_probe(struct platform_device *dev)
>  	return 0;
>  exit:
>  	if (txx9_imclk) {
> -		clk_disable(txx9_imclk);
> +		clk_disable_unprepare(txx9_imclk);
>  		clk_put(txx9_imclk);
>  	}
>  	return ret;
> @@ -153,7 +153,7 @@ exit:
>  static int __exit txx9wdt_remove(struct platform_device *dev)
>  {
>  	watchdog_unregister_device(&txx9wdt);
> -	clk_disable(txx9_imclk);
> +	clk_disable_unprepare(txx9_imclk);
>  	clk_put(txx9_imclk);
>  	return 0;
>  }
> -- 
> 1.9.1
> 
