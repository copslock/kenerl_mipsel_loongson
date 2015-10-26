Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 26 Oct 2015 11:50:54 +0100 (CET)
Received: from mail-lf0-f54.google.com ([209.85.215.54]:33635 "EHLO
        mail-lf0-f54.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009217AbbJZKuwiRIvY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 26 Oct 2015 11:50:52 +0100
Received: by lffv3 with SMTP id v3so142888885lff.0
        for <linux-mips@linux-mips.org>; Mon, 26 Oct 2015 03:50:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded_com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=gfcc902YHMKJ0GyB1ikjjnzhcA81uOidab6HGNwnydY=;
        b=EX7IgywzNzCd8QzH2PYa+ZCup4r6bEWW6ai88ryK+RWgFHijNUjfaEjFw/b1UXl4Bb
         2lje+41u3EkFrKg5lXJb6g3N1iM3nfYGDFBqidFO9WkoWwHN7fvQ3dgMkyh12uPnHqrh
         YP6796gjVuxgu+WjagbheVqF6sLGH5W0MjXJwUa0si4g4yOazppcf5Sz/6xuENaiKN0j
         ApRRaB1lDO2PxeGv220xnbv4ayFI7rjJQvnmQ+J1teahJYhCReO+xObHrW+XffRWCWg9
         9uHYh9owF8Y7REShwOFaEsLCfcNnIIFSMCQ6sJnX6hcwWZgNZ6VNtUN0yU0znbDKUBN8
         D6/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=gfcc902YHMKJ0GyB1ikjjnzhcA81uOidab6HGNwnydY=;
        b=BKuDfUG/6vRS/CV5CDzjnvYL5qxF6a42+mA/wPwdZBFoh1UtsuJWRmhgr+DeuOvzjY
         uV8a11tn2L4l4sR0eYDjzEkj/9B3z1KhXCSu5jzGV8A+ETC5AGv5QdDiySnBfpm6ngnR
         QUNtKwypRjsBLWjpcNHzrhX9+e1WtcdEzzM9KSPAY+OtwZIBcXczUPL919HRTr9JtVpv
         x7IzbljdZro/uE59/S4siLSrdWzCIKdQlNfusKv3k3IW26qqqeLm1JWxPuUegFAy7Paz
         WpLTrOtF2Dej2Qs02LUlsthMCbN3Zk9l0+uetp7ojnHVe+nkZVIDhxFwi8WE+YiCcFOk
         lyOg==
X-Gm-Message-State: ALoCoQm4EhwqH00DIs51WPn/6ZZ9E98DPXpxnL0Fenj6hzoz/FslwDA/m6dBWmwHhrRaNR2Vt2CG
X-Received: by 10.25.23.208 with SMTP id 77mr10928444lfx.44.1445856647127;
        Mon, 26 Oct 2015 03:50:47 -0700 (PDT)
Received: from [192.168.4.126] ([31.173.81.87])
        by smtp.gmail.com with ESMTPSA id f77sm5302725lfi.3.2015.10.26.03.50.45
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Oct 2015 03:50:46 -0700 (PDT)
Subject: Re: [PATCH] MIPS: lantiq: add clk_round_rate()
To:     Hauke Mehrtens <hauke@hauke-m.de>, ralf@linux-mips.org
References: <1445811702-27936-1-git-send-email-hauke@hauke-m.de>
Cc:     blogic@openwrt.org, linux-mips@linux-mips.org,
        "# 4 . 1+" <stable@vger.kernel.org>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <562E0585.1010801@cogentembedded.com>
Date:   Mon, 26 Oct 2015 13:50:45 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <1445811702-27936-1-git-send-email-hauke@hauke-m.de>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 49691
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

On 10/26/2015 1:21 AM, Hauke Mehrtens wrote:

> This adds a basic implementation of clk_round_rate()
> The clk_round_rate() function is called by multiple drivers and
> subsystems now and the lantiq clk driver is supposed to export this,
> but doesn't do so, this causes linking problems like this one:
> ERROR: "clk_round_rate" [drivers/media/v4l2-core/videodev.ko] undefined!
>
> Signed-off-by: Hauke Mehrtens <hauke@hauke-m.de>
> Cc: <stable@vger.kernel.org> # 4.1+
> ---
>   arch/mips/lantiq/clk.c | 17 +++++++++++++++++
>   1 file changed, 17 insertions(+)
>
> diff --git a/arch/mips/lantiq/clk.c b/arch/mips/lantiq/clk.c
> index 3fc2e6d..a0706fd 100644
> --- a/arch/mips/lantiq/clk.c
> +++ b/arch/mips/lantiq/clk.c
> @@ -99,6 +99,23 @@ int clk_set_rate(struct clk *clk, unsigned long rate)
>   }
>   EXPORT_SYMBOL(clk_set_rate);
>
> +long clk_round_rate(struct clk *clk, unsigned long rate)
> +{
> +	if (unlikely(!clk_good(clk)))
> +		return 0;
> +	if (clk->rates && *clk->rates) {
> +		unsigned long *r = clk->rates;
> +
> +		while (*r && (*r != rate))
> +			r++;
> +		if (!*r) {
> +			return clk->rate;
> +		}

    {} not needed here.

[...]

MBR, Sergei
