Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 26 Oct 2016 15:55:44 +0200 (CEST)
Received: from mail-wm0-f52.google.com ([74.125.82.52]:35376 "EHLO
        mail-wm0-f52.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992227AbcJZNzgZQSxc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 26 Oct 2016 15:55:36 +0200
Received: by mail-wm0-f52.google.com with SMTP id e69so32261457wmg.0
        for <linux-mips@linux-mips.org>; Wed, 26 Oct 2016 06:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=ddGsr8N6mn6IXXuM1RXSMHVGtB1ybuAXQVDVfqC+ozY=;
        b=a+cWGKpT0xZDsBlEw5ykqdRfHkGCHWeLuj1JrS2ma2k/mdfS9gjOhOoVKlPiLpHzzd
         u3XLu6DZM5On7UacQvl+BMGo6BYfJ8tkzSdVW2edjHq2UcWUuOckpRUE/roPz8yiUl2E
         S9HvS81gTkr/bd1SCg4gDiJEwARxj3xTbdt4I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=ddGsr8N6mn6IXXuM1RXSMHVGtB1ybuAXQVDVfqC+ozY=;
        b=VcWAa0N7HrM7aao5up3fFEBBNmDuZR9jt3zMD64UB9ilqcsQ9mb7yOqvy62bnkyxuz
         sG1oWDeJNlWnaUUKrQXZtWDNnNEdUtviHYJZWvIc4lIIR3T8Yl7QfnS3BHO94hDViaK9
         P1Gtn5AruTdDPq5HZUdVd5UzjzEq1Tzi3t4OS3bgjW54eVsjynTH0ICPgLLnehQ4cVqC
         cNIfNdjwQk5F6vfT29WLEgW4/JrxGuBrsL/ZyHX40W4oUIz/I4KwNGfwt49+5rJEk8ca
         NxzLkUWHnH8Jk4PI0lsWfOBuCg/nMSjbvrcKLSIOsNqI585GGtHdj/jyXkw/GR8HGhcG
         IlJg==
X-Gm-Message-State: ABUngve0k/b3YZQJBo/Bj2HH5Fq739eeKBNDYPC+E5nIPJ11Oa7GXN7XKUPxCX6gftNDHzWg
X-Received: by 10.28.12.77 with SMTP id 74mr3742444wmm.115.1477490128338;
        Wed, 26 Oct 2016 06:55:28 -0700 (PDT)
Received: from dell (host86-178-207-242.range86-178.btcentralplus.com. [86.178.207.242])
        by smtp.gmail.com with ESMTPSA id k17sm9763969wmd.8.2016.10.26.06.55.27
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Oct 2016 06:55:27 -0700 (PDT)
Date:   Wed, 26 Oct 2016 14:58:02 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Arnd Bergmann <arnd@arndb.de>,
        Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 1/2] mfd: syscon: Support native-endian regmaps
Message-ID: <20161026135802.GD13127@dell>
References: <e50cd48c-e0c4-9bfc-b265-383a33eac569@roeck-us.net>
 <20161014091732.27536-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20161014091732.27536-1-paul.burton@imgtec.com>
User-Agent: Mutt/1.6.2 (2016-07-01)
Return-Path: <lee.jones@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55586
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lee.jones@linaro.org
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

On Fri, 14 Oct 2016, Paul Burton wrote:

> The regmap devicetree binding documentation states that a native-endian
> property should be supported as well as big-endian & little-endian,
> however syscon in its duplication of the parsing of these properties
> omits support for native-endian. Fix this by setting
> REGMAP_ENDIAN_NATIVE when a native-endian property is found.
> 
> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
>  drivers/mfd/syscon.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)

Applied, thanks.

> diff --git a/drivers/mfd/syscon.c b/drivers/mfd/syscon.c
> index 2f2225e..b93fe4c 100644
> --- a/drivers/mfd/syscon.c
> +++ b/drivers/mfd/syscon.c
> @@ -73,8 +73,10 @@ static struct syscon *of_syscon_register(struct device_node *np)
>  	/* Parse the device's DT node for an endianness specification */
>  	if (of_property_read_bool(np, "big-endian"))
>  		syscon_config.val_format_endian = REGMAP_ENDIAN_BIG;
> -	 else if (of_property_read_bool(np, "little-endian"))
> +	else if (of_property_read_bool(np, "little-endian"))
>  		syscon_config.val_format_endian = REGMAP_ENDIAN_LITTLE;
> +	else if (of_property_read_bool(np, "native-endian"))
> +		syscon_config.val_format_endian = REGMAP_ENDIAN_NATIVE;
>  
>  	/*
>  	 * search for reg-io-width property in DT. If it is not provided,

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
