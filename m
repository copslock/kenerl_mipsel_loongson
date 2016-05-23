Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 May 2016 19:15:30 +0200 (CEST)
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36021 "EHLO
        mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27033501AbcEWRP2CG-rr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 May 2016 19:15:28 +0200
Received: by mail-pa0-f68.google.com with SMTP id eu11so1457054pad.3;
        Mon, 23 May 2016 10:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-transfer-encoding;
        bh=4QjIJJ1DhmLl9kW/G1Cl0BCgNOtazdwguE8BY/NWCcA=;
        b=HZoVCS353rarG0/xVeXPbVe93kkfVdE/1D3VxBE3GvLDcKklZZXACIJwcVYNAQCGxO
         6OEgebo4+DUSHymAy6KmVkz2zgOaY4aXr64EiClcWvWl2oYz92P4KuGSb6ovlyy0A5Xb
         hrKwNjhfUvsigrd7u177Gq9kSNhlGb6SFUV0HJG8x5IN6uucHKYedhkClAs7LagXmCag
         +VX5Af531jhcYmNvuwb9hgN2sPrkrcllHAXRC8px0CdR6Tgty9Ea54YRZ5Xqp7PhNMk9
         JkCjC+/48o41tpbHRZcVgx8nxvrMxcVu+d9vnNUpskmPzZSQrJB5TM4oPzgH/Atr9jB6
         uAjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:date:from:user-agent:mime-version:to
         :cc:subject:references:in-reply-to:content-transfer-encoding;
        bh=4QjIJJ1DhmLl9kW/G1Cl0BCgNOtazdwguE8BY/NWCcA=;
        b=SAAlemnFFB7RkdKZgSkn6oT3OqO1KmAvmbBNDYAQJf5SGqwGofFasthWFNFOduYoQY
         jlVvfkfYGb6wswnjT8RWd4iP4nNuUSSTL09GFdgx8wesVZvCB8X9lU8KYeZlr8C83Vzt
         4OuzraK6Lb4MnrbO9k98fRHWA9mYFN19/x0gT74rfUGCwv7RQMq2FwatN/RZ1waXNNw7
         H1fHrdIKLqq3GUQ/aaYtjifLc2fhiIioX2ESLaCsqZg0vSEt6OgKBSyny56pQ7CssX/D
         wE9+tKXmo7h1JijpETvwJN6R/ZFg/S3Bq2xrwy/G3jZb32vxYpFWAAUEDIsVYO4/89CK
         vDdw==
X-Gm-Message-State: AOPr4FVPoWqYUg/HpNjSEf+auht4fh5epmvuRYeSzsETjWdej1fU2efA2qYwYz/IIfU9Pw==
X-Received: by 10.66.66.10 with SMTP id b10mr28945818pat.12.1464023721792;
        Mon, 23 May 2016 10:15:21 -0700 (PDT)
Received: from dl.caveonetworks.com ([50.233.148.158])
        by smtp.googlemail.com with ESMTPSA id j65sm17861765pfj.44.2016.05.23.10.15.19
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 23 May 2016 10:15:20 -0700 (PDT)
Message-ID: <57433AA7.2070005@gmail.com>
Date:   Mon, 23 May 2016 10:15:19 -0700
From:   David Daney <ddaney.cavm@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
MIME-Version: 1.0
To:     Aaro Koskinen <aaro.koskinen@nokia.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        Sivasubramanian Palanisamy <sivasubramanian.palanisamy@nokia.com>
Subject: Re: [PATCH] MIPS: OCTEON: use bootloader provided value for max memory
References: <1464016319-5266-1-git-send-email-aaro.koskinen@nokia.com>
In-Reply-To: <1464016319-5266-1-git-send-email-aaro.koskinen@nokia.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <ddaney.cavm@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53618
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney.cavm@gmail.com
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

On 05/23/2016 08:11 AM, Aaro Koskinen wrote:
> From: Sivasubramanian Palanisamy <sivasubramanian.palanisamy@nokia.com>
>
> Currently the maximum memory on OCTEON boards is limited to 512 MB unless
> user passes the mem= parameter. Use bootloader provided value for max
> memory instead of the hardcoded default limit.
>
> Signed-off-by: Sivasubramanian Palanisamy <sivasubramanian.palanisamy@nokia.com>
> Signed-off-by: Aaro Koskinen <aaro.koskinen@nokia.com>
> ---
>   arch/mips/cavium-octeon/setup.c | 2 ++
>   1 file changed, 2 insertions(+)
>
> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
> index cd7101f..ef9705d 100644
> --- a/arch/mips/cavium-octeon/setup.c
> +++ b/arch/mips/cavium-octeon/setup.c
> @@ -800,6 +800,8 @@ void __init prom_init(void)
>   	/* Default to 64MB in the simulator to speed things up */
>   	if (octeon_is_simulation())
>   		MAX_MEMORY = 64ull << 20;
> +	else if (octeon_bootinfo->dram_size)
> +		MAX_MEMORY = octeon_bootinfo->dram_size * 1024ull * 1024ull;

We can make this whole thing more sane by:

1) Rename MAX_MEMORY to max_memory, as it is not a macro.

2) Statically assign the default value at the variable definition site 
at the top of the file to something like ULLONG_MAX.

3) Don't add these two lines as they would now be redundant.

David Daney
