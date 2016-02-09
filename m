Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 09 Feb 2016 22:03:22 +0100 (CET)
Received: from mail-pa0-f41.google.com ([209.85.220.41]:36285 "EHLO
        mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27011766AbcBIVDUyt1Ib (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 9 Feb 2016 22:03:20 +0100
Received: by mail-pa0-f41.google.com with SMTP id yy13so96916362pab.3;
        Tue, 09 Feb 2016 13:03:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-type:content-transfer-encoding;
        bh=HAMoWWkVh1dRuNZwDrNnVMMfZTb7kmsvI9Y0+a23G44=;
        b=MFAtM6LS+dndd0XOPDDIXaN66nWbvQFPEwrQBPuG7gHQS4d+XEKkLOg9cwQwTmGB+c
         dtsb2yGHghiSYWMe/PjmjSJvjjDytQBc5LzKGg19DGAYnJJTyCQ/333TN6+CbLkKo8Ms
         GF6BDOdgpRf21MJ8UcpxN8EbUK48Oe1Fg3HmJxVi5AIMoWq22+uw01quEH6CNqesRFtl
         TjFSRc2/a+cz7hs/vbC4cqYkTSwYK4iNiL6sarj9XTM28p8gnjBCgXaFsFTTxOwet1da
         cE0oa1depklxwPPT/8XxqwM9DksCfrt4zT6/aqlfBz1dtOaSIlx6D5/4nk2wUlYFkdeX
         rskQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-type
         :content-transfer-encoding;
        bh=HAMoWWkVh1dRuNZwDrNnVMMfZTb7kmsvI9Y0+a23G44=;
        b=gWAWiBQ7pF323hlXYTP0s6Ri93BAv6Zqq/Lp7PAveRiW6GQ2t7shLPkB2dMBzbbfPL
         YKnl0QwEY2OwvgoCG7aLOYc/2PVpXGx7IJFFGKyeNcAmu66ZJ/jW0Z1+fgv1+ksGiWal
         ycRM9wSeNMQmTkQ07kRRFmyvpgtLZQpz5GGVNQ2+aReeVm3SCMAeLVxcf1xRzvCXaxEF
         XZzmsAWepjuv/8jvBSzclBh9h1WGer/duGnaD9Jr1w+Cjjs7/lUFFtxLkIhanJGccPXb
         z0l8in311vQxFij9DJ+1FPoiFlaoFdSgSBmKiCFkFzWV/ZRjuWJdectvxCb68ZnDiFH2
         wS2g==
X-Gm-Message-State: AG10YORMS/NOVFTgVGWfYCV30mR6veKdIsZI1Q4QjQEn2x7tK0JqztWA0VQdglvN08ClVQ==
X-Received: by 10.66.159.38 with SMTP id wz6mr53479553pab.12.1455051795210;
        Tue, 09 Feb 2016 13:03:15 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id xa9sm52659656pab.44.2016.02.09.13.03.13
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 09 Feb 2016 13:03:14 -0800 (PST)
Subject: Re: [PATCH 1/6] MIPS: BMIPS: Disable pref 30 for buggy CPUs
To:     linux-mips@linux-mips.org
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com>
 <1455051354-6225-2-git-send-email-f.fainelli@gmail.com>
Cc:     ralf@linux-mips.org, blogic@openwrt.org, cernekee@gmail.com,
        jon.fraser@broadcom.com, pgynther@google.com,
        paul.burton@imgtec.com, ddaney.cavm@gmail.com
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <56BA53C1.3080004@gmail.com>
Date:   Tue, 9 Feb 2016 13:01:53 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:44.0) Gecko/20100101
 Thunderbird/44.0
MIME-Version: 1.0
In-Reply-To: <1455051354-6225-2-git-send-email-f.fainelli@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51925
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: f.fainelli@gmail.com
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

On 09/02/16 12:55, Florian Fainelli wrote:
> Disable pref 30 by utilizing the standard quirk method and matching the
> affected SoCs: 7344, 7436, 7425.
> 
> Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
> ---
>  arch/mips/bmips/setup.c | 16 ++++++++++++++++
>  1 file changed, 16 insertions(+)
> 
> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
> index 35535284b39e..9c8f15daf5e9 100644
> --- a/arch/mips/bmips/setup.c
> +++ b/arch/mips/bmips/setup.c
> @@ -100,12 +100,28 @@ static void bcm6368_quirks(void)
>  	bcm63xx_fixup_cpu1();
>  }
>  
> +static void bmips5000_pref30_quirk(void)
> +{
> +	__asm__ __volatile__(
> +	"	.word	0x4008b008\n"	/* mfc0 $8, $22, 8 */
> +	"	lui	$9, 0x0100\n"
> +	"	or	$8, $9\n"
> +	/* disable "pref 30" on buggy CPUs */
> +	"	lui	$9, 0x0800\n"
> +	"	or	$8, $9\n"
> +	"	.word	0x4088b008\n"	/* mtc0 $8, $22, 8 */
> +	: : : "$8", "$9");

We are missing an additional load here to $8, I will respin this patch,
but would appreciate feedback on the other patches of the series so I
can address everything at once. Thanks!

> +}
> +
>  static const struct bmips_quirk bmips_quirk_list[] = {
>  	{ "brcm,bcm3384-viper",		&bcm3384_viper_quirks		},
>  	{ "brcm,bcm33843-viper",	&bcm3384_viper_quirks		},
>  	{ "brcm,bcm6328",		&bcm6328_quirks			},
>  	{ "brcm,bcm6368",		&bcm6368_quirks			},
>  	{ "brcm,bcm63168",		&bcm6368_quirks			},
> +	{ "brcm,bcm7344",		&bmips5000_pref30_quirk		},
> +	{ "brcm,bcm7346",		&bmips5000_pref30_quirk		},
> +	{ "brcm,bcm7425",		&bmips5000_pref30_quirk		},
>  	{ },
>  };
>  
> 


-- 
Florian
