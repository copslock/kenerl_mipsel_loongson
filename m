Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 10 Aug 2018 15:39:01 +0200 (CEST)
Received: from mail-pg1-x542.google.com ([IPv6:2607:f8b0:4864:20::542]:44721
        "EHLO mail-pg1-x542.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994777AbeHJNi5qMLZ6 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 10 Aug 2018 15:38:57 +0200
Received: by mail-pg1-x542.google.com with SMTP id r1-v6so4415623pgp.11;
        Fri, 10 Aug 2018 06:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=CJAtOyICmfBVF+2b9xRivOif51fkG1+/sq3UV/VsgYE=;
        b=mMHzJvwxGB7AXDylGbZuMBslUOOZwXnRPH4dwRAq8tQkwgvxTEPK6h06oqtlLTad4X
         maT4gqaWAuSgx98NdIZ+OJr35SXBhATGpw2Yp9jVHidRFzQHy07AcOIzdj6vwNCzWV//
         qk8TX3FeHAf26HEPRaakcU8tNAyustf98nEWgfhfpJS1FgB6tB65kdd1e3jQKKEytkOg
         MOPewg+AOns5thxhTCRchrkCCCYuS4EDKN1ocMTLz1GZIP10BNMSMpTLgH4mREbTF3zO
         ZrE/PR7LTYqbFGrRB4MOctUJ+7qsryZZJM7K4Zf/0bqhhUw8/+vV7HMVkZP/ZO+UWHRU
         F8MA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=CJAtOyICmfBVF+2b9xRivOif51fkG1+/sq3UV/VsgYE=;
        b=c7JcnqojSBChVgi1h2F5dlLmyj+06dTR3Q/2kGgC99aeIQ1AnYBIG/zOuckeCdEA+B
         oFEvnl+yJ5mI68j69jgo4TxyDl/wQ2KxznN6IC43f0TLA74OuTXZw/tae91oP+n1YzXu
         Fd20YO4V8HbQbthoBU034WlEBdLheBCsq13N67OHXPu5i3fzGLb4Pn/O79BgNiqFakdY
         1qb/ma1/IixhY7H4f0Yhe1l2cW/xgY0A+zFWK3594ZQtJn3Yi80+2dOe6lwRqBHH1OWK
         IVkqJr2YMnksv8rzo6QpNuuLAJE4vnXbCCoYFFk3caJ2iS3hkO41y5YsPyU44SISjv25
         L6qg==
X-Gm-Message-State: AOUpUlFgV27HcX32ePIlSo02Tmuj6/340bKPf0hcLYOZ+E/BlMEEq1/W
        qoPR27zjeydWy0iRYEdl42Y=
X-Google-Smtp-Source: AA+uWPwqAfy+TcZ7ruvNU2CyF7IpyyCeJNEH1u2AOxkwgF2kTC1HvHrCAAIgIsRALm2sSsFFrVOSEg==
X-Received: by 2002:a65:6243:: with SMTP id q3-v6mr6357017pgv.273.1533908331762;
        Fri, 10 Aug 2018 06:38:51 -0700 (PDT)
Received: from localhost (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id a20-v6sm19279646pfc.14.2018.08.10.06.38.51
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Aug 2018 06:38:51 -0700 (PDT)
Date:   Fri, 10 Aug 2018 06:38:50 -0700
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
Subject: Re: [PATCH v6 11/24] watchdog: jz4740: Drop dependency on
 MACH_JZ47xx, use COMPILE_TEST
Message-ID: <20180810133850.GD29028@roeck-us.net>
References: <20180809214414.20905-1-paul@crapouillou.net>
 <20180809214414.20905-12-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20180809214414.20905-12-paul@crapouillou.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 65537
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

On Thu, Aug 09, 2018 at 11:44:01PM +0200, Paul Cercueil wrote:
> Depending on MACH_JZ47xx prevent us from creating a generic kernel that
> works on more than one MIPS board. Instead, we just depend on MIPS being
> set.
> 
> On other architectures, this driver can still be built, thanks to
> COMPILE_TEST. This is used by automated tools to find bugs, for
> instance.
> 
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  drivers/watchdog/Kconfig | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
>  v5: New patch
> 
>  v6: No change
> 
> diff --git a/drivers/watchdog/Kconfig b/drivers/watchdog/Kconfig
> index 834222abbbdb..13a46cfa69b0 100644
> --- a/drivers/watchdog/Kconfig
> +++ b/drivers/watchdog/Kconfig
> @@ -1475,7 +1475,7 @@ config INDYDOG
>  
>  config JZ4740_WDT
>  	tristate "Ingenic jz4740 SoC hardware watchdog"
> -	depends on MACH_JZ4740 || MACH_JZ4780
> +	depends on MIPS || COMPILE_TEST
>  	depends on COMMON_CLK
>  	select WATCHDOG_CORE
>  	select INGENIC_TIMER
> -- 
> 2.11.0
> 
