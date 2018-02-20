Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 17:27:05 +0100 (CET)
Received: from mail-pl0-x242.google.com ([IPv6:2607:f8b0:400e:c01::242]:45516
        "EHLO mail-pl0-x242.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994696AbeBTQ0zt900y (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 17:26:55 +0100
Received: by mail-pl0-x242.google.com with SMTP id p5so7672842plo.12
        for <linux-mips@linux-mips.org>; Tue, 20 Feb 2018 08:26:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=PgJFbQtqeZryVOI/wqgS4HV+UF/XWObWn51FNmVqnHg=;
        b=hThEHySRlI2reW54C1hujSkXnT4gpxKMzEzsP3OMQrpXlPECh+vYvGTL9InxHjNz2e
         VqAHAOBKjR6lqQ4cs17nNK9mYvTTbsruXoeq7xoBjIR8iNacVIxOP2FbD6UvgAJNYRmr
         m4z5fEA85s1JytbT5UTVSdeRI5H8ER7zQlG1wS1caKkWaVUzOkqr7N/wamdvbydiZohl
         56lwlST3nCpWmIbC5vHMf9jfGnOUlBtv5OFRGKR4uNyLTN/mCR3nW/6+7IYsmVqgsdqK
         I0bbIXCGOMvDRJO3touUOYPQX5kbEZu9U0cQS8qdZHtHOzc28C3mudopQ5pFAeZJNqm3
         Covw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=PgJFbQtqeZryVOI/wqgS4HV+UF/XWObWn51FNmVqnHg=;
        b=fFDJMjzZk/bgFSElSLv/TKY+5uFv638AGm3yV8WLpi1gEgSZd4lo1G5kAWCs/CfMYz
         +fLGwTca3mp+4D52gO37v4arABStH4OkRuDvsjh7bumIb5pX5S1X7c5skHZZJpUcbfXX
         i48qf+YDwD8LrB/R00lfWZvxBd+ckJ5a3NUWL9EUzi/b7OdDQTq6n/gu2dxjTCZueWMS
         Rpx9es0BzlklR2lElP3qd76L9qHABdw5+yNDQBylQlNRDoQ6HXMO3WltQxmqbxRHGddg
         BtxQFrGIXn5zTyVFiS85ppScX1bqVQGPCKaAscXiDQdKZmQUruDrKEgKWO4LH8vTOUbh
         jZIw==
X-Gm-Message-State: APf1xPCLgmsPe4vQQnzhEqT51MwL5q3owZsHyOYc4Qa0byhUj0GsMigZ
        Oypm9fV9wszAl4vECdKYcbE=
X-Google-Smtp-Source: AH8x225U2KAm/XkKOfIfS78SY2rtiHxLsD7epHldvKLeA0TNaB8A7el6g4J9mphVUo81wPcIuprurg==
X-Received: by 2002:a17:902:328:: with SMTP id 37-v6mr160360pld.398.1519144007640;
        Tue, 20 Feb 2018 08:26:47 -0800 (PST)
Received: from ziggy.stardust ([37.223.138.75])
        by smtp.gmail.com with ESMTPSA id x5sm29576595pfm.49.2018.02.20.08.26.35
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Feb 2018 08:26:46 -0800 (PST)
Subject: Re: [PATCH v2] watchdog: add SPDX identifiers for watchdog subsystem
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Baruch Siach <baruch@tkos.co.il>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Jimmy Vance <jimmy.vance@hpe.com>,
        Keguang Zhang <keguang.zhang@gmail.com>,
        Joachim Eastwood <manabian@gmail.com>,
        Tomas Winkler <tomas.winkler@intel.com>,
        Johannes Thumshirn <morbidrsa@gmail.com>,
        Andreas Werner <andreas.werner@men.de>,
        Carlo Caione <carlo@caione.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Wan ZongShun <mcuos.com@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Vladimir Zapolskiy <vz@mleia.com>,
        Sylvain Lemieux <slemieux.tyco@gmail.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Zwane Mwaikambo <zwanem@gmail.com>,
        Jim Cromie <jim.cromie@gmail.com>,
        Barry Song <baohua@kernel.org>,
        Patrice Chotard <patrice.chotard@st.com>,
        Maxime Ripard <maxime.ripard@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Marc Gonzalez <marc.w.gonzalez@free.fr>,
        Mans Rullgard <mans@mansr.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Jun Nie <jun.nie@linaro.org>,
        Baoyou Xie <baoyou.xie@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-mips@linux-mips.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, patches@opensource.cirrus.com
References: <20180220104542.32286-1-marcus.folkesson@gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Message-ID: <c5dece62-c129-fdb2-7e91-dbe587055cc0@gmail.com>
Date:   Tue, 20 Feb 2018 17:26:34 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220104542.32286-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <matthias.bgg@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62654
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matthias.bgg@gmail.com
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



On 02/20/2018 11:45 AM, Marcus Folkesson wrote:
> - Add SPDX identifier
> - Remove boiler plate license text
> - If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>   license
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> ---
> 
> Notes:
>     v2:
>     	- Put back removed copyright texts for meson_gxbb_wdt and coh901327_wdt
>     	- Change to BSD-3-Clause for meson_gxbb_wdt
>     v1: Please have an extra look at meson_gxbb_wdt.c
> 
>  drivers/watchdog/acquirewdt.c          |  6 +---

[...]

>  drivers/watchdog/mpc8xxx_wdt.c         |  6 +---
>  drivers/watchdog/mt7621_wdt.c          |  5 +---
>  drivers/watchdog/mtk_wdt.c             | 11 +-------
>  drivers/watchdog/mtx-1_wdt.c           | 11 +-------
>  drivers/watchdog/mv64x60_wdt.c         |  6 ++--

[...]

> diff --git a/drivers/watchdog/mtk_wdt.c b/drivers/watchdog/mtk_wdt.c
> index 7ed417a765c7..498e7d4e1b66 100644
> --- a/drivers/watchdog/mtk_wdt.c
> +++ b/drivers/watchdog/mtk_wdt.c
> @@ -1,3 +1,4 @@
> +// SPDX-License-Identifier: GPL-2.0+
>  /*
>   * Mediatek Watchdog Driver
>   *
> @@ -5,16 +6,6 @@
>   *
>   * Matthias Brugger <matthias.bgg@gmail.com>
>   *
> - * This program is free software; you can redistribute it and/or modify
> - * it under the terms of the GNU General Public License as published by
> - * the Free Software Foundation; either version 2 of the License, or
> - * (at your option) any later version.
> - *
> - * This program is distributed in the hope that it will be useful,
> - * but WITHOUT ANY WARRANTY; without even the implied warranty of
> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
> - * GNU General Public License for more details.
> - *
>   * Based on sunxi_wdt.c
>   */
>  

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
