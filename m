Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 20 Aug 2016 10:36:18 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:50450 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992156AbcHTIgL0WX4J (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 20 Aug 2016 10:36:11 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
        bh=Ey2aYLrGeQzlly+801oio9EaxOI7kcSBy3nNkFgiuvQ=; b=tUon96N0B0I1/nIT7a/mN7ANkc
        jh3LlEEhvzK40sABfQibpjEglJ0inVkaB9HkUMK1kgW77GY7osZthb8hYxUNwEhI2WXbBnSohJMjt
        G8KpkiFB4+XfY5rEzMqArTooLnZq1U6TSZ6WCbpQBzJCE/nRT4kEq7SpsaKCXqMH21gaRjpHudlK9
        f4Hc+aAYbbPzVYrsDok6mh/agEcx+e3dDtfIB1Ezf34eQlIylsYYni7ZQTWReih+TTqxzkvMOiKst
        BJtD42aOJLednvl8KBddNhmKnJvqMPGEZCIWURLAWqc2rROcw18q0pX6YLmm6lRlNBR2IuKcBtOaN
        Fr/ZfBBQ==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:33818 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1bb1l4-002QNh-DE; Sat, 20 Aug 2016 08:36:02 +0000
Subject: Re: [PATCH 2/3] watchdog: txx9wdt: Add missing clock (un)prepare
 calls for CCF
To:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Atsushi Nemoto <anemo@mba.ocn.ne.jp>,
        Mark Brown <broonie@kernel.org>,
        Wim Van Sebroeck <wim@iguana.be>
References: <1471541667-30689-1-git-send-email-geert@linux-m68k.org>
 <1471541667-30689-3-git-send-email-geert@linux-m68k.org>
Cc:     linux-clk@vger.kernel.org, linux-mips@linux-mips.org,
        linux-spi@vger.kernel.org, linux-watchdog@vger.kernel.org
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <4a958a01-7772-dc9d-ff00-7e1cbad7ffe3@roeck-us.net>
Date:   Sat, 20 Aug 2016 01:36:02 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <1471541667-30689-3-git-send-email-geert@linux-m68k.org>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Authenticated-Sender: bh-25.webhostbox.net: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54703
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

On 08/18/2016 10:34 AM, Geert Uytterhoeven wrote:
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
>
