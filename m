Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 30 Dec 2017 17:08:54 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:39655
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990424AbdL3QIiEK8Ih (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 30 Dec 2017 17:08:38 +0100
Received: by mail-pl0-x242.google.com with SMTP id bi12so24623732plb.6;
        Sat, 30 Dec 2017 08:08:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=npNpL8HDVupXoTAcn9uEeOgCz156pfXEYir3frQssHk=;
        b=AIQEu7e7exeHH4aOPA9yTOungQVhBlpeyt42qFKaSSy/1n96maj9A/XQX4Cs996w+m
         96PP0T+k6imHPFQf8uu+jxGxZ0KLEpPgweCozwVmUPJJjPEY/dJ3kE2gekhMe4GACW1+
         AOBGzHHR+GjuTw/BhQsb+EQNPUDjGqMjpF/Bd64ACG3opcBOQ6DXrz79OpqoQBYaGH2q
         uBUPMGMTrDN1KN4asrOg87HOUakBU1JF+MNsDMIhfEX78tqZYRXAeldNhk1A+uYWyXo7
         9kM3tMTLW1ib8Nnt2q+mif9VFmz/6qkVw9Pw5rSmP1SIk/skqFe9V3rGQJfP7jNU5xa3
         lY8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=npNpL8HDVupXoTAcn9uEeOgCz156pfXEYir3frQssHk=;
        b=RvIrxm2G78869Asab0zLYVhl5j/aboZl2uk70ZCGtMkTLERBR7MJ9M29L/NqbhSWzj
         WsCjU3ouVHqfJdmLYGszxCZH01Dar1vO5tpogdfG00EgRUsM+1Tu1b6nO2/BbwPsPuEw
         3nU67Omt+5OvIGpA3LrWUO8NIOQZciIqVTjIv8sfXf5sf0ZrilI6/jLUkql2ljC2SyQB
         zjGLH7+cUG5grSfCuQXJDuNxD2R1l3jItu82jyFgFiOqqGT1LoWKI4vQb5SlJjpVWIA4
         01yy3sVKVQVPw/233F9Dcb5/q4n2w+hV+J+y4gZxmPzAoNpo8MRXzhR8v6+S2owzrwZB
         FG/A==
X-Gm-Message-State: AKGB3mKIqGS06LMxwy0enFnUldAYQm9TQ0z1mE4ZfVW37EtAzVdkv/mY
        7Bt1oSM73PF+PrsMMYOnP+8IVQ==
X-Google-Smtp-Source: ACJfBovysp9tdK+3JiNmmP6b4G85JFWPaQ1d1i424oJsdEDor136I+pAl7sMhQpL95/3RDIs2lW6TQ==
X-Received: by 10.84.215.2 with SMTP id k2mr37882496pli.60.1514650112053;
        Sat, 30 Dec 2017 08:08:32 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id l73sm81994766pfi.82.2017.12.30.08.08.31
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 30 Dec 2017 08:08:31 -0800 (PST)
Subject: Re: [PATCH v2 4/8] watchdog: JZ4740: Drop module remove function
To:     Paul Cercueil <paul@crapouillou.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Wim Van Sebroeck <wim@iguana.be>
Cc:     devicetree@vger.kernel.org, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org, linux-watchdog@vger.kernel.org
References: <20171228162939.3928-2-paul@crapouillou.net>
 <20171230135108.6834-1-paul@crapouillou.net>
 <20171230135108.6834-4-paul@crapouillou.net>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <8454df76-df77-c57f-2f87-be03c4cda63b@roeck-us.net>
Date:   Sat, 30 Dec 2017 08:08:30 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.5.0
MIME-Version: 1.0
In-Reply-To: <20171230135108.6834-4-paul@crapouillou.net>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 61787
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

On 12/30/2017 05:51 AM, Paul Cercueil wrote:
> When the watchdog was configured for nowayout, and after the
> userspace watchdog daemon closed the dev node without sending the
> magic character, unloading this module stopped the watchdog
> hardware, which was clearly a problem.
> 
> Besides, unloading the module is not possible when the userspace
> watchdog daemon is running, so it's safe to assume that we don't
> need to stop the watchdog hardware in the jz4740_wdt_remove()
> function.
> 
> For this reason, the jz4740_wdt_remove() function can then be
> dropped alltogether.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   drivers/watchdog/jz4740_wdt.c | 8 --------
>   1 file changed, 8 deletions(-)
> 
>   v2: New patch in this series
> 
> diff --git a/drivers/watchdog/jz4740_wdt.c b/drivers/watchdog/jz4740_wdt.c
> index fa7f49a3212c..02b9b8e946a2 100644
> --- a/drivers/watchdog/jz4740_wdt.c
> +++ b/drivers/watchdog/jz4740_wdt.c
> @@ -205,16 +205,8 @@ static int jz4740_wdt_probe(struct platform_device *pdev)
>   	return 0;
>   }
>   
> -static int jz4740_wdt_remove(struct platform_device *pdev)
> -{
> -	struct jz4740_wdt_drvdata *drvdata = platform_get_drvdata(pdev);
> -
> -	return jz4740_wdt_stop(&drvdata->wdt);
> -}
> -
>   static struct platform_driver jz4740_wdt_driver = {
>   	.probe = jz4740_wdt_probe,
> -	.remove = jz4740_wdt_remove,
>   	.driver = {
>   		.name = "jz4740-wdt",
>   		.of_match_table = of_match_ptr(jz4740_wdt_of_matches),
> 
