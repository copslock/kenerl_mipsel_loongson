Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Apr 2018 10:05:36 +0200 (CEST)
Received: from mail-wr0-x242.google.com ([IPv6:2a00:1450:400c:c0c::242]:33857
        "EHLO mail-wr0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994588AbeDTIF1L5gvU (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 20 Apr 2018 10:05:27 +0200
Received: by mail-wr0-x242.google.com with SMTP id p18-v6so1320425wrm.1
        for <linux-mips@linux-mips.org>; Fri, 20 Apr 2018 01:05:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=LQaHYo34cmhrKVhL/tgxE4PmLNvezLMY8FOdLe3YElA=;
        b=fIe7BxY2hAuGvYKKI9EusA3nvJk9R1QENX6besE4asnDl4XfvTwHQH35EsXzGmGjBU
         Vq8KYvHLRP0qCO7wkSXhioLc2HaaiGqJ6MXtTciJ36/nb75HHc0CGUBlTo6Ki9O4lBgX
         nCZlq4DSLJJcL8IZ85zNUaUxAcYKt+TL9gDUs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=LQaHYo34cmhrKVhL/tgxE4PmLNvezLMY8FOdLe3YElA=;
        b=LlGD2dVSPD52sykW/gQcyZJuQZXLHZ5/NHwYmFOa84WymzpA5lgUubp2epeu9r/mMp
         hyhWhRpNctHFRWn6Nt1iq5A1u0FWJw48+wRwB2hfaJxuiTr78pCzutmaF1NsS00d2WdH
         LBocT+/jf/JrVMlf71jsUeV4ZyYaKlTo7EJJ9ZQ7nzZxYhnxNLWice0/jJdATtWQpRWN
         IgKg072jiITPORlVdahiWa1euFfDndfZoIfSixiJkx3dToik6Y/KPTYsg6gqSWCoFJeh
         gf8NfaoGy6y978KVkNZWu8zZJzBzTg1BPc/rDg2FGD0JTdBNlsN7i28cqc9Xx1pvyXPi
         KLog==
X-Gm-Message-State: ALQs6tCvG+tBbf1+yft48sHNXRmFjNmkTJ50R+00eVPUH0ovTuIuZsbx
        Sz7JkpdSFGcUT0ac1SCqxCl7ow==
X-Google-Smtp-Source: AIpwx49OWKRkJ1YoBOZk0/BVE7Y6wECmCESDxwwpRzdCQAK/wqioSM3qqDl3/+gp2XuarFAd0jP8jA==
X-Received: by 10.28.89.68 with SMTP id n65mr1067064wmb.96.1524211521188;
        Fri, 20 Apr 2018 01:05:21 -0700 (PDT)
Received: from dell ([2.27.167.70])
        by smtp.gmail.com with ESMTPSA id q21-v6sm4802752wra.24.2018.04.20.01.05.17
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 20 Apr 2018 01:05:20 -0700 (PDT)
Date:   Fri, 20 Apr 2018 09:05:16 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Wolfram Sang <wsa@the-dreams.de>
Cc:     linux-i2c@vger.kernel.org, Greg Ungerer <gerg@uclinux.org>,
        Russell King <linux@armlinux.org.uk>,
        Aaro Koskinen <aaro.koskinen@iki.fi>,
        Tony Lindgren <tony@atomide.com>,
        Sergey Lapin <slapin@ossfans.org>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Ralf Baechle <ralf@linux-mips.org>,
        James Hogan <jhogan@kernel.org>,
        Haavard Skinnemoen <hskinnemoen@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-omap@vger.kernel.org, linux-mips@linux-mips.org,
        linux-media@vger.kernel.org
Subject: Re: [PATCH 1/7] i2c: i2c-gpio: move header to platform_data
Message-ID: <20180420080516.hoa2wlubrnpnkl5z@dell>
References: <20180419200015.15095-1-wsa@the-dreams.de>
 <20180419200015.15095-2-wsa@the-dreams.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20180419200015.15095-2-wsa@the-dreams.de>
User-Agent: NeoMutt/20170609 (1.8.3)
Return-Path: <lee.jones@linaro.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63631
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

On Thu, 19 Apr 2018, Wolfram Sang wrote:

> This header only contains platform_data. Move it to the proper directory.
> 
> Signed-off-by: Wolfram Sang <wsa@the-dreams.de>
> ---
>  MAINTAINERS                                      | 2 +-
>  arch/arm/mach-ks8695/board-acs5k.c               | 2 +-
>  arch/arm/mach-omap1/board-htcherald.c            | 2 +-
>  arch/arm/mach-pxa/palmz72.c                      | 2 +-
>  arch/arm/mach-pxa/viper.c                        | 2 +-
>  arch/arm/mach-sa1100/simpad.c                    | 2 +-
>  arch/mips/alchemy/board-gpr.c                    | 2 +-
>  drivers/i2c/busses/i2c-gpio.c                    | 2 +-
>  drivers/media/platform/marvell-ccic/mmp-driver.c | 2 +-
>  drivers/mfd/sm501.c                              | 2 +-
>  include/linux/{ => platform_data}/i2c-gpio.h     | 0
>  11 files changed, 10 insertions(+), 10 deletions(-)
>  rename include/linux/{ => platform_data}/i2c-gpio.h (100%)

Acked-by: Lee Jones <lee.jones@linaro.org>

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
