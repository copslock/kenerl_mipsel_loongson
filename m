Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 06 Nov 2016 06:12:58 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:55899 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992942AbcKFFMudwOc8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 6 Nov 2016 06:12:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=roeck-us.net; s=default; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject;
        bh=GXWRinI4Hi0tmdG3soNJj0xziHAasiGT50aXfNvwonM=; b=nYOw9M16/6gpZrUFXLXSzJYBtN
        zRdQw/AHxcubzmlpRTQvEL6A2i2EdR9x2ZyjMZY248hU048dIa6TN38ClUKG1a1i/67Tzw9Sp/U93
        fsEpfTHfDgSuGsvJV96gcMb1Tpq3hfkLTV1RqcMtrWOlXMBKcoUVHaeWf/fd1HfLWrbfwVxiYfRWb
        J6No2UuMxAGm5HEwQk8K1Moo0MuJzyqugoUE7IiySQhxbtsn34AUXI/DZ4Sdp+rtYpSO5j4C64IXx
        +L+r71wPZ49mNEkzOQaj6YxNO1KHdTNhT7lFqAptqXywcdEO8QCI63KPfA4GaoR6A8J4cR1c+/nKG
        aLhLwNxw==;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:33160 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.86_1)
        (envelope-from <linux@roeck-us.net>)
        id 1c3Fl2-000Bpp-1B; Sun, 06 Nov 2016 05:12:40 +0000
Subject: Re: [PATCH 1/2] mfd: syscon: Support native-endian regmaps
To:     Paul Burton <paul.burton@imgtec.com>, linux-mips@linux-mips.org
References: <e50cd48c-e0c4-9bfc-b265-383a33eac569@roeck-us.net>
 <20161014091732.27536-1-paul.burton@imgtec.com>
Cc:     Lee Jones <lee.jones@linaro.org>, Arnd Bergmann <arnd@arndb.de>,
        Ralf Baechle <ralf@linux-mips.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <6eee2835-43b2-ffa1-9be3-a1a9d8ed56cf@roeck-us.net>
Date:   Sat, 5 Nov 2016 22:12:42 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <20161014091732.27536-1-paul.burton@imgtec.com>
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
X-archive-position: 55680
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

On 10/14/2016 02:17 AM, Paul Burton wrote:
> The regmap devicetree binding documentation states that a native-endian
> property should be supported as well as big-endian & little-endian,
> however syscon in its duplication of the parsing of these properties
> omits support for native-endian. Fix this by setting
> REGMAP_ENDIAN_NATIVE when a native-endian property is found.
>

Any chance to get this patch applied to mainline ? It is in -next, but
big endian mips malta images still fail to reboot in mainline.

Thanks,
Guenter

> Signed-off-by: Paul Burton <paul.burton@imgtec.com>
> Cc: Lee Jones <lee.jones@linaro.org>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
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
>
