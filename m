Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 24 Feb 2016 11:26:07 +0100 (CET)
Received: from mail-lf0-f49.google.com ([209.85.215.49]:33058 "EHLO
        mail-lf0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27010717AbcBXK0BnYh1z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 24 Feb 2016 11:26:01 +0100
Received: by mail-lf0-f49.google.com with SMTP id m1so8795889lfg.0
        for <linux-mips@linux-mips.org>; Wed, 24 Feb 2016 02:26:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-type:content-transfer-encoding;
        bh=Y7/4XwhJ67G9H+v7ifUCZmrQgPTj5YNr4g74y4mY9jY=;
        b=Eu/QcBZcTqvyQKcOwa3cstOAQ8KwKzf0AJ3xqUeutQojs6SIxcphBH0BLIDu/ThqJV
         HPFXjJCZ88TuGMuXZ/Q4sf5iU+wxhcOYsxZJNupjQs+w0WHgLGWIx7SLKxlEzpOeiHcR
         7VLALUFRNJFmmyfJAOxe/uQTHnAlHrWzSRqZ0EP9hO0rBle34WNNaPMXp/G2wBcPjMgC
         JPHYo0p42HJTMDBRvWWHi5ftrWy50GWOwpy7ynDS3LdqhHUASiccP+FgFw3FixwWz520
         lkf+EIDH2FCv/qKWd1vFvQfHZHtDHXyY+zXlPW0hYPCOMh/S7HXllHN4Oofq9F8sYpPu
         xKEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=Y7/4XwhJ67G9H+v7ifUCZmrQgPTj5YNr4g74y4mY9jY=;
        b=F2ohXZxi1f/bWjcb/KQFEs1SCcA+27DlOeRFoU/dLcu5qs8sMAqFQd50BRCrkYy8E2
         WmHPUdIMCG3cA88YKJC5f0Fi7pzbQLE5vtp+ye7zpgv6RoksDzSyGZ+sqhwUJ4WP2alA
         fP7EjiqwhJAUBEE09KZOsSlnI6Dg/ADgXHJIq4p3UR2/Ppui16hJJWKRpyQWaQusf0kF
         x2cb7KMPJwljEjQtpNTeYpfQZdBN1q+GBYmi688Pmp/68rxcdlnY7xq8UJ1FcIwBHH/f
         tIpQOrjMw1I/DKV8N6SunLmaN3lOmZhQM/No8/JaaR/ec46mcyMhsJd4+vTMiaQOvjBh
         N02A==
X-Gm-Message-State: AG10YOS63qw5vo6yHrL0UBfvxMFNTqDQXICdavONh9NIF39/KgFB1QUftPA2rkZHm+YZNg==
X-Received: by 10.25.15.216 with SMTP id 85mr10878613lfp.62.1456309556088;
        Wed, 24 Feb 2016 02:25:56 -0800 (PST)
Received: from [192.168.4.126] ([31.173.84.246])
        by smtp.gmail.com with ESMTPSA id n96sm284845lfi.45.2016.02.24.02.25.54
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 24 Feb 2016 02:25:55 -0800 (PST)
Subject: Re: [PATCH v2 2/3] MIPS: OCTEON: device_tree_init: don't fill mac if
 already set
To:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Ralf Baechle <ralf@linux-mips.org>,
        David Daney <ddaney.cavm@gmail.com>, linux-mips@linux-mips.org
References: <1456267927-2492-1-git-send-email-aaro.koskinen@iki.fi>
 <1456267927-2492-3-git-send-email-aaro.koskinen@iki.fi>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <56CD852F.4000204@cogentembedded.com>
Date:   Wed, 24 Feb 2016 13:25:51 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <1456267927-2492-3-git-send-email-aaro.koskinen@iki.fi>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 52187
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

On 2/24/2016 1:52 AM, Aaro Koskinen wrote:

> Don't fill MAC address if it's already set. This allows DTB to
> override the bootinfo.
>
> Acked-by: David Daney <david.daney@cavium.com>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
> ---
>   arch/mips/cavium-octeon/octeon-platform.c | 8 ++++++++
>   1 file changed, 8 insertions(+)
>
> diff --git a/arch/mips/cavium-octeon/octeon-platform.c b/arch/mips/cavium-octeon/octeon-platform.c
> index a7d9f07..7aeafed 100644
> --- a/arch/mips/cavium-octeon/octeon-platform.c
> +++ b/arch/mips/cavium-octeon/octeon-platform.c
> @@ -13,6 +13,7 @@
>   #include <linux/i2c.h>
>   #include <linux/usb.h>
>   #include <linux/dma-mapping.h>
> +#include <linux/etherdevice.h>
>   #include <linux/module.h>
>   #include <linux/mutex.h>
>   #include <linux/slab.h>
> @@ -525,10 +526,17 @@ static void __init octeon_fdt_set_phy(int eth, int phy_addr)
>
>   static void __init octeon_fdt_set_mac_addr(int n, u64 *pmac)
>   {
> +	const u8 *old_mac;
> +	int old_len;
>   	u8 new_mac[6];
>   	u64 mac = *pmac;
>   	int r;
>
> +	old_mac = fdt_getprop(initial_boot_params, n, "local-mac-address",
> +			      &old_len);
> +	if (!old_mac || old_len != 6 || is_valid_ether_addr(old_mac))
> +		return;

    So if there's no such prop or the length is not 6, you just return?

[...]

MBR, Sergei
