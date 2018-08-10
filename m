Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Aug 2018 15:37:46 +0200 (CEST)
Received: from mail-pg1-x541.google.com ([IPv6:2607:f8b0:4864:20::541]:42946
        "EHLO mail-pg1-x541.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993920AbeHJNhnCM7j6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Aug 2018 15:37:43 +0200
Received: by mail-pg1-x541.google.com with SMTP id y4-v6so4419602pgp.9;
        Fri, 10 Aug 2018 06:37:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WtxEI4l3KMgN+mKQ13uzMgZlocJDJEpYaCFOClNnnEU=;
        b=fHdEWPGqISYB+gPXIuF9SGHcP6XZfCvxW6OiyCSDIPTEEYcfA3cXNegMFb4KTDw2Ah
         tzS1xpzyO3r4r4Vzjn5qoO9xf7n5zFx5pwrc8h2dAteNPl9f1wJOKAMTUYdFDXUVkedR
         iIAxxfbPRrqXZOQqwvH2GUbTFi76AXiIc3XXc1ojfqx0/aVoBLzziwHHusOnJnC7XNjh
         /KZoYPVTbdV73LrpjWB6Sh8u30ZD1LhlA4QxeREaLJRpXoiPh18HAlBQ2qb1YFi+0WAz
         XS74FSaNCKPMWbBdB33Uoder6Wb1rLbEU0CP4VwivWFLMI7Oj1JKboB7bDAK4f/1zozk
         LJGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=WtxEI4l3KMgN+mKQ13uzMgZlocJDJEpYaCFOClNnnEU=;
        b=Rd4abV88GYfDdmmL72G4hhdFW9+W6+/ECCQv9ExnNkIaRZF59b+8R4EM2fs9oduCRv
         z06KriRN2URuqnQSHBDnYBiGqJNL41TAJjiV5sdMHzkUtYKGkNC0d/SL58bIlJ0q4xeb
         ySFup7GiILWqSL6JJ/whgUeEt5oetRZhmPDo35vbOQo7HtPSaFtqvyZ9L0rCct7IoLy4
         uF37cs8vghXpUSv+QLotVwRyb+glZ7EGsSiQ5/61tnMd/7CNBUsyqxNDS/yAiDCHoeD+
         hjUiy4Zkic7F1zZmJqcjnhXV+MKeVN4WwM3vZrg8056jz3tAm6KPMqrN/aWjeRriQInX
         CiDA==
X-Gm-Message-State: AOUpUlEyDEKLxFjGSqkSly4vThkSCcEMdmeMl0VS2wsLZUj+te62SECN
        2UkVRdzFHllJvZNyi257v/U=
X-Google-Smtp-Source: AA+uWPyWlyfhKhrqHdFUIHs4pe24NmmOWzHcj5W9qXr6EyufSqUHZg3wKFgzuezZYM5vzdm4jrVKTA==
X-Received: by 2002:a63:a042:: with SMTP id u2-v6mr6429924pgn.80.1533908257018;
        Fri, 10 Aug 2018 06:37:37 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id j15-v6sm12160378pfn.52.2018.08.10.06.37.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 06:37:36 -0700 (PDT)
Date:   Fri, 10 Aug 2018 06:37:35 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Paul Burton <paul.burton@mips.com>,
        James Hogan <jhogan@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Lee Jones <lee.jones@linaro.org>,
        Mathieu Malaterre <malat@debian.org>,
        Ezequiel Garcia <ezequiel@collabora.co.uk>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mips@linux-mips.org, linux-doc@vger.kernel.org,
        linux-clk@vger.kernel.org
Subject: Re: [PATCH v6 10/24] watchdog: jz4740: Avoid starting watchdog in
 set_timeout
Message-ID: <20180810133735.GC29028@roeck-us.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
 <20180809214414.20905-11-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809214414.20905-11-paul@crapouillou.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65536
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

On Thu, Aug 09, 2018 at 11:44:00PM +0200, Paul Cercueil wrote:
> Previously the jz4740_wdt_set_timeout() function was starting the timer
> unconditionally, even if it was stopped when that function was entered.
> 
> Now, the timer will be restarted only if it was already running before
> this function is called.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/jz4740_wdt.c | 5 ++++-
>  1 file changed, 4 insertions(+), 1 deletion(-)
> 
>  v6: New patch
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 0f54306aee25..45d9495170e5 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -64,13 +64,15 @@ static int jz4740_wdt_set_timeout(struct watchdog_device *wdt_dev,
>  {
>  	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
>  	u16 timeout_value = (u16)(drvdata->clk_rate * new_timeout);
> +	u32 tcer;
>  
> +	regmap_read(drvdata->map, TCU_REG_WDT_TCER, &tcer);
>  	regmap_write(drvdata->map, TCU_REG_WDT_TCER, 0);
>  
>  	regmap_write(drvdata->map, TCU_REG_WDT_TDR, timeout_value);
>  	regmap_write(drvdata->map, TCU_REG_WDT_TCNT, 0);
>  
> -	regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, tcer & TCU_WDT_TCER_TCEN);
>  
>  	wdt_dev->timeout = new_timeout;
>  	return 0;
> @@ -86,6 +88,7 @@ static int jz4740_wdt_start(struct watchdog_device *wdt_dev)
>  		return ret;
>  
>  	jz4740_wdt_set_timeout(wdt_dev, wdt_dev->timeout);
> +	regmap_write(drvdata->map, TCU_REG_WDT_TCER, TCU_WDT_TCER_TCEN);
>  
>  	return 0;
>  }
> -- 
> 2.11.0
> 
