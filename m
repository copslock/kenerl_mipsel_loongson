Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 12 Apr 2013 15:01:17 +0200 (CEST)
Received: from mail-lb0-f174.google.com ([209.85.217.174]:63340 "EHLO
        mail-lb0-f174.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S6816859Ab3DLNBKSEULX (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 12 Apr 2013 15:01:10 +0200
Received: by mail-lb0-f174.google.com with SMTP id s10so2616233lbi.19
        for <linux-mips@linux-mips.org>; Fri, 12 Apr 2013 06:01:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=x-received:message-id:date:from:organization:user-agent
         :mime-version:to:cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding:x-gm-message-state;
        bh=41a81zpcg0ZVv0lO2GMItn8x9oiOQjwU8MJFXw0Jwqc=;
        b=XNT+sjMOtrcNNTtkTUv3t/3dm5T11GFH6I9VeJKp6SN3y/m9W7rgWzEgv8q7427dPv
         pgKXVRZtUKwUFc76rlYYVoO1GNtn0qlx2exvAIBxJuxkELouYSzE3gm51DmsjXHjRa4E
         3AAWe972B4GsSNnSyaVvYXaRoXNvSRWOobLlHuBZIPSfwGb04uO8YpUqCQZHmJR9Uu8/
         ip0QHwAPMwRuVvqzAKAoebjoxbGu45y35pUC/eAyS/u0TfW7kQ8SS5BNpavQ9dAtbpyK
         xO+KpsL5EJWxjUBNX5dELK2+yafTrH8kxLTjFg6cyzXU4zZukeiTodMxxQMxTLI5jMOj
         wAig==
X-Received: by 10.152.112.231 with SMTP id it7mr5292106lab.10.1365771664647;
        Fri, 12 Apr 2013 06:01:04 -0700 (PDT)
Received: from [192.168.2.2] (ppp91-79-86-58.pppoe.mtu-net.ru. [91.79.86.58])
        by mx.google.com with ESMTPS id v10sm1762712lae.9.2013.04.12.06.01.02
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 12 Apr 2013 06:01:03 -0700 (PDT)
Message-ID: <51680551.5040907@cogentembedded.com>
Date:   Fri, 12 Apr 2013 17:00:01 +0400
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Organization: Cogent Embedded
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
MIME-Version: 1.0
To:     John Crispin <blogic@openwrt.org>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH V2 02/16] MIPS: ralink: fix RT305x clock setup
References: <1365751663-5725-1-git-send-email-blogic@openwrt.org> <1365751663-5725-2-git-send-email-blogic@openwrt.org>
In-Reply-To: <1365751663-5725-2-git-send-email-blogic@openwrt.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Gm-Message-State: ALoCoQm0+Yz/WaWwxyB8eS4+57cw7DQnJUKeb09v94te2fcFBNSFobCj9CZJ2tE6iiS2OC1hycLD
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 36113
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

Hello.

On 12-04-2013 11:27, John Crispin wrote:

> Add a few missing clocks.

> Signed-off-by: John Crispin <blogic@openwrt.org>
> ---
>   arch/mips/ralink/rt305x.c |   13 ++++++++++++-
>   1 file changed, 12 insertions(+), 1 deletion(-)

> diff --git a/arch/mips/ralink/rt305x.c b/arch/mips/ralink/rt305x.c
> index 0a4bbdc..64a0336 100644
> --- a/arch/mips/ralink/rt305x.c
> +++ b/arch/mips/ralink/rt305x.c
[...]
> @@ -176,11 +177,21 @@ void __init ralink_clk_init(void)
>   		BUG();
>   	}
>
> +	if (soc_is_rt3352() || soc_is_rt5350()) {
> +		u32 val = rt_sysc_r32(RT3352_SYSC_REG_SYSCFG0);
> +
> +		if (!(val & RT3352_CLKCFG0_XTAL_SEL))
> +			wmac_rate = 20000000;
> +	}
> +
>   	ralink_clk_add("cpu", cpu_rate);
>   	ralink_clk_add("10000b00.spi", sys_rate);
>   	ralink_clk_add("10000100.timer", wdt_rate);
> +	ralink_clk_add("10000120.watchdog", wdt_rate);
>   	ralink_clk_add("10000500.uart", uart_rate);
>   	ralink_clk_add("10000c00.uartlite", uart_rate);
> +	ralink_clk_add("10100000.ethernet", sys_rate);
> +	ralink_clk_add("wmac@10180000", wmac_rate);

    Are you sure it's not "10180000.wmac"?

WBR, Sergei
