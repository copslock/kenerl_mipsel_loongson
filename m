Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 04 Aug 2015 11:24:09 +0200 (CEST)
Received: from mail-wi0-f175.google.com ([209.85.212.175]:33046 "EHLO
        mail-wi0-f175.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27009868AbbHDJYHVy74x (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 4 Aug 2015 11:24:07 +0200
Received: by wicmv11 with SMTP id mv11so167684144wic.0
        for <linux-mips@linux-mips.org>; Tue, 04 Aug 2015 02:24:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-type
         :content-transfer-encoding;
        bh=VDQ1woHk/cnlnPJmeAd1EKGWkN05zhvZONf4R7ozDvE=;
        b=lXblXDNrbwsH3cCe+guKAqdq9OaFJram4E9076VxqJtlGBORTSTEfgsZV22p04ruVM
         /CKWwRzbCnEeDepWg4spciWcq7rtQcVJqQeeu5cp2bVvCpxxHGaE3GbXyfp0V4YVUaIG
         Cq7CKz+JCP+uLoY33TvgzpYiQfMzihkpSlEG/MULnwMQOac/6IjUDD79X5q4dxBJl0RJ
         ErLu3y0R3IU9elzyq/M6CX64kfMbYDy3qEzM5AMKAbEsUuZ9V9gYl+PoBOo7SSEYYQO8
         Oi7CRvVRzq+kh2TwYIJkoWEyb8Coxz0E+KKf87fg0sEkXIF9pGpVStjl7I1pA1nkAxMf
         1C9A==
X-Gm-Message-State: ALoCoQlNyANcL5PLPNISOg+zXvS/IBNVPL+aqV8jE3WWosOf8aKAeUzdGw5qob7sVAOrOg02mqWx
X-Received: by 10.180.108.203 with SMTP id hm11mr6202876wib.54.1438680241944;
        Tue, 04 Aug 2015 02:24:01 -0700 (PDT)
Received: from [192.168.1.150] (185.Red-213-96-199.staticIP.rima-tde.net. [213.96.199.185])
        by smtp.googlemail.com with ESMTPSA id n6sm1343460wix.1.2015.08.04.02.23.59
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Aug 2015 02:24:00 -0700 (PDT)
Message-ID: <55C084AF.7060606@linaro.org>
Date:   Tue, 04 Aug 2015 11:23:59 +0200
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
MIME-Version: 1.0
To:     Govindraj Raja <govindraj.raja@imgtec.com>,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        devicetree@vger.kernel.org
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Bresticker <abrestic@chromium.org>,
        James Hartley <James.Hartley@imgtec.com>,
        Damien Horsley <Damien.Horsley@imgtec.com>,
        James Hogan <James.Hogan@imgtec.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Ezequiel Garcia <ezequiel.garcia@imgtec.com>
Subject: Re: [PATCH v4 1/7] clocksource: mips-gic: Enable the clock before
 using it
References: <1438005618-27003-1-git-send-email-govindraj.raja@imgtec.com> <1438005618-27003-2-git-send-email-govindraj.raja@imgtec.com>
In-Reply-To: <1438005618-27003-2-git-send-email-govindraj.raja@imgtec.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Return-Path: <daniel.lezcano@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48563
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: daniel.lezcano@linaro.org
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

On 07/27/2015 04:00 PM, Govindraj Raja wrote:
> From: Ezequiel Garcia <ezequiel.garcia@imgtec.com>
>
> For the clock to be used (e.g. get its rate through clk_get_rate)
> it should be prepared and enabled first.
>
> Also, while the clock is enabled the driver must hold a reference to it,
> so let's remove the call to clk_put.
>
> Reviewed-by: Andrew Bresticker <abrestic@chromium.org>
> Signed-off-by: Ezequiel Garcia <ezequiel.garcia@imgtec.com>

Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>

> ---
>   drivers/clocksource/mips-gic-timer.c | 7 ++++++-
>   1 file changed, 6 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/clocksource/mips-gic-timer.c b/drivers/clocksource/mips-gic-timer.c
> index b81ed1a..913585d 100644
> --- a/drivers/clocksource/mips-gic-timer.c
> +++ b/drivers/clocksource/mips-gic-timer.c
> @@ -158,8 +158,13 @@ static void __init gic_clocksource_of_init(struct device_node *node)
>
>   	clk = of_clk_get(node, 0);
>   	if (!IS_ERR(clk)) {
> +		if (clk_prepare_enable(clk) < 0) {
> +			pr_err("GIC failed to enable clock\n");
> +			clk_put(clk);
> +			return;
> +		}
> +
>   		gic_frequency = clk_get_rate(clk);
> -		clk_put(clk);
>   	} else if (of_property_read_u32(node, "clock-frequency",
>   					&gic_frequency)) {
>   		pr_err("GIC frequency not specified.\n");
>


-- 
  <http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog
