Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 14 Oct 2016 19:43:25 +0200 (CEST)
Received: from bh-25.webhostbox.net ([208.91.199.152]:39063 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992104AbcJNRnRWlrJR (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 14 Oct 2016 19:43:17 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=In-Reply-To:Content-Type:MIME-Version:References
        :Message-ID:Subject:Cc:To:From:Date;
        bh=YEw8oNuUK+lphfFdT9NznUvO1SWf5FmlXy3WBdgPFlU=; b=wdI1QMfxwiGUHZgpY1DiNW8vF8
        DfKhbnPsISHsB4dBVk0WzUne25Q5PllAlTYviuMt+/7J5TYXjyYHlwRpmkUd9N7dU5WjFvkIs2JCF
        5odbMYe+pvZPAoLgBZWfzQMrUV3vmIrYYk/f/TIJct9FcMht8tYuU9m6NsEZUBsp84iK6ZVKjKYUG
        ejv7eilATDf/HP5nwuT3HRn2BK4u6asyJulh/MQbsfU66WKljEcH9SXCZ8DP/uYAGJE4sOluI75d+
        22DNfeTFbpdg+9k9atpZhSwUSKfVTv1Z+5Azgi0WVtt1qyALUW50FKf6PFA0FZbfXuHSwls9EKRKg
        o11rM5nA==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:50712 helo=localhost)
        by bh-25.webhostbox.net with esmtpa (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1bv6Ve-003W1x-Ar; Fri, 14 Oct 2016 17:43:07 +0000
Date:   Fri, 14 Oct 2016 10:43:08 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, Lee Jones <lee.jones@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [1/2] mfd: syscon: Support native-endian regmaps
Message-ID: <20161014174308.GA22866@roeck-us.net>
References: <20161014091732.27536-1-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20161014091732.27536-1-paul.burton@imgtec.com>
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
X-archive-position: 55435
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

On Fri, Oct 14, 2016 at 10:17:31AM +0100, Paul Burton wrote:
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

Needed for 'MIPS: malta: Fixup reboot' to work.

Tested-by: Guenter Roeck <linux@roeck-us.net>

Makes me wonder though how the other syscon nodes already using 
'native-endian' work.

Thanks,
Guenter

> ---
>  drivers/mfd/syscon.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
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
