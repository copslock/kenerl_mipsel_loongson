Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Aug 2016 19:48:41 +0200 (CEST)
Received: from mail-oi0-f65.google.com ([209.85.218.65]:35224 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992509AbcHDRseMLpiv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Aug 2016 19:48:34 +0200
Received: by mail-oi0-f65.google.com with SMTP id w143so26676114oiw.2;
        Thu, 04 Aug 2016 10:48:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=DzW9X0D+werzNk1aBJaOP3JRxx4nqcbwHKkZVG98Q7s=;
        b=CKWbJ8N2DC/FZKFHo+JinoGqJmhsX7PG0umuOejOSIkPzF3r+gQDlhQLueWBasQAJU
         WM7Ul2QyH7aMv5kkESpofP/HtP2EL4y3urT6pcbzy9zQx85QQb6raJo6Ys3fUTniFY5y
         yakzlwKLD+KekI8G8he7CbG9iabTumU9U5dqTtCE4Ft8CzJrVxrKmbTEklDJfVNtg1W9
         7O2ob2XnHWq4S0QvBB1RuRWZRRKALB2joWaHtPdogzFTZbXbJe9zPJ4QH67nS1wHFJqB
         bo3Cu6P2BpGxwyaEYBc4TnQOHe7E0mCHxaDUFnQuh7Kw0Gx/YXcv+Qz+bId7FatFdBbI
         pf3A==
X-Gm-Message-State: AEkoouvt+5qaLNWBvQxQeG2RCetfflCF+S7RJTJj8/4eH5l7ZHSgQ1ahlwbYhLP+c+8kYQ==
X-Received: by 10.202.221.212 with SMTP id u203mr31610673oig.36.1470332907099;
        Thu, 04 Aug 2016 10:48:27 -0700 (PDT)
Received: from localhost (72-48-98-129.dyn.grandenetworks.net. [72.48.98.129])
        by smtp.gmail.com with ESMTPSA id m36sm4894578otm.1.2016.08.04.10.48.26
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 04 Aug 2016 10:48:26 -0700 (PDT)
Date:   Thu, 4 Aug 2016 12:48:25 -0500
From:   Rob Herring <robh@kernel.org>
To:     =?iso-8859-1?Q?=C1lvaro_Fern=E1ndez?= Rojas <noltari@gmail.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, ralf@linux-mips.org,
        f.fainelli@gmail.com, jogo@openwrt.org, cernekee@gmail.com,
        simon@fire.lp0.eu, john@phrozen.org
Subject: Re: [PATCH v2 6/7] MIPS: BMIPS: Add BCM6362 support
Message-ID: <20160804174825.GA1169@rob-hp-laptop>
References: <1470218310-2978-6-git-send-email-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1470218310-2978-6-git-send-email-noltari@gmail.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <robherring2@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54416
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: robh@kernel.org
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

On Wed, Aug 03, 2016 at 11:58:29AM +0200, Álvaro Fernández Rojas wrote:
> BCM6362 is a BMIPS4350 SoC which needs the same fixup as BCM6368 in order to
> enable SMP support.
> 
> Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
> ---
>  Documentation/devicetree/bindings/mips/brcm/soc.txt | 2 +-
>  arch/mips/bmips/setup.c                             | 1 +
>  2 files changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/Documentation/devicetree/bindings/mips/brcm/soc.txt b/Documentation/devicetree/bindings/mips/brcm/soc.txt
> index 65bc572..e4e1cd9 100644
> --- a/Documentation/devicetree/bindings/mips/brcm/soc.txt
> +++ b/Documentation/devicetree/bindings/mips/brcm/soc.txt
> @@ -4,7 +4,7 @@ Required properties:
>  
>  - compatible: "brcm,bcm3368", "brcm,bcm3384", "brcm,bcm33843"
>                "brcm,bcm3384-viper", "brcm,bcm33843-viper"
> -              "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6368",
> +              "brcm,bcm6328", "brcm,bcm6358", "brcm,bcm6362", "brcm,bcm6368",

Same comment on this.

Acked-by: Rob Herring <robh@kernel.org>

>                "brcm,bcm63168", "brcm,bcm63268",
>                "brcm,bcm7125", "brcm,bcm7346", "brcm,bcm7358", "brcm,bcm7360",
>                "brcm,bcm7362", "brcm,bcm7420", "brcm,bcm7425"
> diff --git a/arch/mips/bmips/setup.c b/arch/mips/bmips/setup.c
> index 4fbd2f1..bde62bc 100644
> --- a/arch/mips/bmips/setup.c
> +++ b/arch/mips/bmips/setup.c
> @@ -115,6 +115,7 @@ static const struct bmips_quirk bmips_quirk_list[] = {
>  	{ "brcm,bcm33843-viper",	&bcm3384_viper_quirks		},
>  	{ "brcm,bcm6328",		&bcm6328_quirks			},
>  	{ "brcm,bcm6358",		&bcm6358_quirks			},
> +	{ "brcm,bcm6362",		&bcm6368_quirks			},
>  	{ "brcm,bcm6368",		&bcm6368_quirks			},
>  	{ "brcm,bcm63168",		&bcm6368_quirks			},
>  	{ "brcm,bcm63268",		&bcm6368_quirks			},
> -- 
> 2.1.4
> 
