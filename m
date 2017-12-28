Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 28 Dec 2017 19:38:30 +0100 (CET)
Received: from mail-pl0-x241.google.com ([IPv6:2607:f8b0:400e:c01::241]:42254
        "EHLO mail-pl0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990506AbdL1SiWjpZLO (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 28 Dec 2017 19:38:22 +0100
Received: by mail-pl0-x241.google.com with SMTP id bd8so21566937plb.9;
        Thu, 28 Dec 2017 10:38:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=5nPcGFbEj90/j7QWIQ4tdhX8gN88GmENIdlTNaN2EPM=;
        b=PjVWr0q7L9j/nNPldhyLcSb21WiIGvxxyKM4k2jOhqA23732O69dD85LlHZCxtPZHz
         aaPwZaVT6FdevB818S6B9jqqi5xZXEuvjN6an9rHXUCg9i+/3gS9Szoz2WqO+xQ+n49Z
         4fektibVOWx+O6ca+ANyyTjwQpwXD/sx3CUepCkHblHplltz8FXJIpRRPKyfElWWZIsp
         oELzWcKV/XQgkMWdfsyJord3KQ3PdZEyj9IXukmty5PePyDrfFp2f+zYG98RF7Bb3bqx
         ZSP4fdBNpFe/t+xMf1pvrEWIiyxRI35zwY7TFIs/4TAbrMJZAufs+3vIHaLVrgYcarvU
         /IKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=5nPcGFbEj90/j7QWIQ4tdhX8gN88GmENIdlTNaN2EPM=;
        b=rShEF9UnyepYmB4+4t8YjWn9HeRTD4yKvrcaopKU/bqA2w7Lt1U9jNpRky3Q4a9aXu
         Ll49R2/i4m1ab83WMzTNS3kGmHaHMPRzIxSngy2W8SziYCM1eHtA+Y3N+50/f7roNHej
         EfeOl/HHY/9SueSWmpPbY1eK2zCSOW9DWonkJ4POpqT384cEo2SA378pG88z7D9YNlDV
         fHPaLMKCPilkEsLcsTk5S1AjbFwAeRXPsCo1vxQXbyxtibibQm1vlZQx5zO0m5dhdMda
         b+xcbXqPMYbgNdh+muZHBs4MjrrdTyoGgy3/b6CiHzYVCAeAlQUbBB0Mrl2xcpS1Hvc5
         EbeQ==
X-Gm-Message-State: AKGB3mLbQ8PfQaaGJ0WyH5UUsy+5rUHojaOhRTgYqJ408XO6irasnI3R
        y6Ofzek+ALod3qDqyI4Un04=
X-Google-Smtp-Source: ACJfBosSEJNTnC038Ld/plqH9/9JOx58r5xa9WPnQlzKK4hURetc+QaZ2ym/g4jP4KLcU10cj0hG6g==
X-Received: by 10.159.229.10 with SMTP id s10mr33122072plq.386.1514486296169;
        Thu, 28 Dec 2017 10:38:16 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id v23sm34282665pfe.72.2017.12.28.10.38.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Dec 2017 10:38:15 -0800 (PST)
Subject: Re: [PATCH 1/7] watchdog: JZ4740: Disable clock after stopping
 counter
To:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20171228162939.3928-1-paul@crapouillou.net>
 <20171228162939.3928-2-paul@crapouillou.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <1d54ed58-8e30-6fdc-60b8-541d3775280b@roeck-us.net>
Date:   Thu, 28 Dec 2017 10:38:14 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171228162939.3928-2-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61683
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

On 12/28/2017 08:29 AM, Paul Cercueil wrote:
> Previously, the clock was disabled first, which makes the watchdog
> component insensitive to register writes.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/jz4740_wdt.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index 20627f22baf6..6955deb100ef 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -124,8 +124,8 @@ static int jz4740_wdt_stop(struct watchdog_device *wdt_dev)
>   {
>   	struct jz4740_wdt_drvdata *drvdata = watchdog_get_drvdata(wdt_dev);
>   
> -	jz4740_timer_disable_watchdog();
>   	writeb(0x0, drvdata->base + JZ_REG_WDT_COUNTER_ENABLE);
> +	jz4740_timer_disable_watchdog();
>   
>   	return 0;
>   }
> 
