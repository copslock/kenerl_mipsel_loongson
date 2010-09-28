Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 12:45:12 +0200 (CEST)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:45701 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491958Ab0I1Ko7 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Sep 2010 12:44:59 +0200
Received: by ewy9 with SMTP id 9so2076933ewy.36
        for <linux-mips@linux-mips.org>; Tue, 28 Sep 2010 03:44:59 -0700 (PDT)
Received: by 10.213.89.196 with SMTP id f4mr1090422ebm.3.1285670698977;
        Tue, 28 Sep 2010 03:44:58 -0700 (PDT)
Received: from [192.168.2.2] (ppp83-237-248-241.pppoe.mtu-net.ru [83.237.248.241])
        by mx.google.com with ESMTPS id u9sm10222466eeh.17.2010.09.28.03.44.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 03:44:57 -0700 (PDT)
Message-ID: <4CA1C6C4.20504@mvista.com>
Date:   Tue, 28 Sep 2010 14:43:16 +0400
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.9) Gecko/20100915 Thunderbird/3.1.4
MIME-Version: 1.0
To:     Arun Murthy <arun.murthy@stericsson.com>
CC:     lars@metafoo.de, akpm@linux-foundation.org, kernel@pengutronix.de,
        philipp.zabel@gmail.com, robert.jarzmik@free.fr,
        marek.vasut@gmail.com, eric.y.miao@gmail.com, rpurdie@rpsys.net,
        sameo@linux.intel.com, kgene.kim@samsung.com,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        STEricsson_nomadik_linux@list.st.com
Subject: Re: [PATCH 3/7] leds: pwm: add a new element 'name' to platform data
References: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com> <1285670134-18063-4-git-send-email-arun.murthy@stericsson.com>
In-Reply-To: <1285670134-18063-4-git-send-email-arun.murthy@stericsson.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-archive-position: 27871
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22275

Hello.

On 28-09-2010 14:35, Arun Murthy wrote:

> A new element 'name' is added to pwm led platform data structure.
> This is required to identify the pwm device.

> Signed-off-by: Arun Murthy<arun.murthy@stericsson.com>
> Acked-by: Linus Walleij<linus.walleij@stericsson.com>

[...]

> diff --git a/include/linux/leds_pwm.h b/include/linux/leds_pwm.h
> index 33a0711..7a847a0 100644
> --- a/include/linux/leds_pwm.h
> +++ b/include/linux/leds_pwm.h
> @@ -16,6 +16,7 @@ struct led_pwm {
>   struct led_pwm_platform_data {
>   	int			num_leds;
>   	struct led_pwm	*leds;
> +	char *name;
>   };

    Shouldn't '*name'be aligned, at least with '*leds'?

WBR, Sergei
