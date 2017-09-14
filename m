Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Sep 2017 11:30:33 +0200 (CEST)
Received: from mail-wr0-x22c.google.com ([IPv6:2a00:1450:400c:c0c::22c]:46869
        "EHLO mail-wr0-x22c.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992363AbdINJaZCE6sw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Sep 2017 11:30:25 +0200
Received: by mail-wr0-x22c.google.com with SMTP id o42so5084345wrb.3
        for <linux-mips@linux-mips.org>; Thu, 14 Sep 2017 02:30:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=1RcmgaZbz5mtDXvINfBx/OdM5AvORCMTeuEFo0fVrmA=;
        b=BH5pMrvk3puwXxGkCnIaDLLL/taa90rQOGYDFiyTzHiAwwlRhZ+ewfiyuBGDwf4ME7
         qzsQWyRgEgNnU+3Od7Eub/h3jlk5eYbxwsT+E7IaxEz5V9yLJ52nDGrIoniR2//JBfAV
         +9x9yOBfMOy6wi0/2V5T2hhXIHvf8YMsDRfdk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=1RcmgaZbz5mtDXvINfBx/OdM5AvORCMTeuEFo0fVrmA=;
        b=EG7flc10yDaXDgeyM0fw29OuZH/p0eAZ0/JMDln1LsE6yMQBBD+3AD/zqdGoVvFcqJ
         BJVAq6RwckuSaeMnJpZB9dRBzUOIlgDoSEHGUHcaD8ZwmjoosQFvgLGaDhSBxs5St+eb
         A0tg3W8NKXhuPQYTfQIHKNK++84VRiaGdK2SfrNIWsd+ETR+XNHbQN/qadBjYYuDfmxY
         4Y4TQLLHEAFzLJJcYtmlR3bvZTmZd1TaLIEs/34KAO8PWgQufUsTyF46zfdd0Y4sI5eC
         jQpBQYJh5Po3l6e6luAq5eSRCr3tBQcehCINohoyJ1BSWwk6CZY1y4cMPHVKuuFcu7Qn
         t8bg==
X-Gm-Message-State: AHPjjUjT9c/TUbvNor0ywsp0/IHbVcyMzKySoGx6U2lgCjdsJNT3/mSO
        3Q0N7dg0UUVegMVt
X-Google-Smtp-Source: ADKCNb6qHtYnmnauu9MwO55JXeUZEoRwps4tEMZC2PN3EunV6M1UGQSF1wzIEn9zbioDbQP4ouLWZg==
X-Received: by 10.223.134.83 with SMTP id 19mr16933142wrw.223.1505381419619;
        Thu, 14 Sep 2017 02:30:19 -0700 (PDT)
Received: from dell ([2.27.167.120])
        by smtp.gmail.com with ESMTPSA id m201sm689460wma.13.2017.09.14.02.30.18
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 14 Sep 2017 02:30:18 -0700 (PDT)
Date:   Thu, 14 Sep 2017 10:30:17 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Wolfram Sang <wsa@the-dreams.de>, linux-i2c@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-mips@linux-mips.org,
        adi-buildroot-devel@lists.sourceforge.net, arm@kernel.org,
        Steven Miao <realmz6@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 4/5] i2c: gpio: Augment all boardfiles to use open drain
Message-ID: <20170914093017.3xqgqomzt7i7gb5m@dell>
References: <20170910214424.14945-1-linus.walleij@linaro.org>
 <20170910214424.14945-5-linus.walleij@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170910214424.14945-5-linus.walleij@linaro.org>
User-Agent: NeoMutt/20170113 (1.7.2)
Return-Path: <lee.jones@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 59993
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

On Sun, 10 Sep 2017, Linus Walleij wrote:

> We now handle the open drain mode internally in the I2C GPIO
> driver, but we will get warnings from the gpiolib that we
> override the default mode of the line so it becomes open
> drain.
> 
> We can fix all in-kernel users by simply passing the right
> flag along in the descriptor table, and we already touched
> all of these files in the series so let's just tidy it up.
> 
> Cc: arm@kernel.org
> Cc: Steven Miao <realmz6@gmail.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: Lee Jones <lee.jones@linaro.org>
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ARM SoC folks: requesting ACK for Wolfram to take this patch.
> Steven (Blackfin): requesting ACK for Wolfram to take this patch.
> Ralf (MIPS): requesting ACK for Wolfram to take this patch.
> Lee: requesting ACK for Wolfram to take this patch.
> ---
>  arch/arm/mach-ep93xx/core.c                  | 6 ++++--
>  arch/arm/mach-ixp4xx/avila-setup.c           | 4 ++--
>  arch/arm/mach-ixp4xx/dsmg600-setup.c         | 4 ++--
>  arch/arm/mach-ixp4xx/fsg-setup.c             | 4 ++--
>  arch/arm/mach-ixp4xx/ixdp425-setup.c         | 4 ++--
>  arch/arm/mach-ixp4xx/nas100d-setup.c         | 4 ++--
>  arch/arm/mach-ixp4xx/nslu2-setup.c           | 4 ++--
>  arch/arm/mach-ks8695/board-acs5k.c           | 6 ++++--
>  arch/arm/mach-pxa/palmz72.c                  | 6 ++++--
>  arch/arm/mach-pxa/viper.c                    | 8 ++++----
>  arch/arm/mach-sa1100/simpad.c                | 6 ++++--
>  arch/blackfin/mach-bf533/boards/blackstamp.c | 4 ++--
>  arch/blackfin/mach-bf533/boards/ezkit.c      | 4 ++--
>  arch/blackfin/mach-bf533/boards/stamp.c      | 4 ++--
>  arch/blackfin/mach-bf561/boards/ezkit.c      | 4 ++--
>  arch/mips/alchemy/board-gpr.c                | 4 ++++
>  arch/mips/ath79/mach-pb44.c                  | 4 ++--

>  drivers/mfd/sm501.c                          | 4 ++--

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones
Linaro STMicroelectronics Landing Team Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
