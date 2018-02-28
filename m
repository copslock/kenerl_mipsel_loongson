Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2018 00:46:20 +0100 (CET)
Received: from mail-qt0-x244.google.com ([IPv6:2607:f8b0:400d:c0d::244]:41320
        "EHLO mail-qt0-x244.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992273AbeB1XqLw62uM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Mar 2018 00:46:11 +0100
Received: by mail-qt0-x244.google.com with SMTP id j4so5337547qth.8
        for <linux-mips@linux-mips.org>; Wed, 28 Feb 2018 15:46:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=CUpKolArgiCp4zuV+DcgnvwnYPfs55txz5kzAOu+85I=;
        b=JtqjPb4uRuO0WyOjolCGX4//sLnC3S+bWrBgye76ZcA2f7qmuwpBRQxA+g+iHG2LAZ
         aUgBbmo4/HGPuMYVXGNgawy58UlZNkCRFMZQLH6C5gelzq9f9A5TWOmxdAP04EBnEhPM
         l3DZBeg+4SCI+KTQK3yXjjwsHEGWeN/A8u/+iR3xfuAVIOWWD8kzJFw2zrVVZ+Zm6eJN
         B2X7NZpcVlXNpL6Iw/Sw1fnKn/fZ8vW4J4Ru7oRYf9DI0WPU7udFgCgwdxRym5gaqpHs
         WKPP8M+TUWwbajOMIFkjIObVkCNTOA5yjcAL9cxRqfLDtN4Bt8FkGT+bm7epNzWcDi1D
         avWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=CUpKolArgiCp4zuV+DcgnvwnYPfs55txz5kzAOu+85I=;
        b=b74UyASejtVgm7mOWDlD/VtDC/13A9TaRpob2dRTr7L+SsTGP2L6Wva07PcK21VlcD
         6NLt+T9oBTRi6LQTDf7E13Or7BuQ60eg3BmJPtsbVmCJ8r5iCPO7CE7I93hwq1BWgclI
         VsxQCmnvuUdzlNKS1i7dNUqFa163bYukoIv/kEUN33aaVQyprc4eRwABP9gsWUsm3Chp
         ltg1VAdgxYR/5YU3t1VhOuhTQKkwbaChd0Pa0XL33sPqbI9lLiD+2z5VTtpBBE80AACb
         EKyPOdwktcYlPTBm9NmWRt9Q48DbNsz34GbP2/G6YgXZQoChgcr3ddXTOVaIw0oBy25/
         W+eA==
X-Gm-Message-State: AElRT7FIRNStWvqWMN5A3VsBaT6s8NIjvvWrZzA7XWGBhvcY7OCuVFa9
        qcZECHSIiX04/5F7rtEBdRY=
X-Google-Smtp-Source: AG47ELsfbdOfjR40IUXECvMoGWQoyQcYnhAsdViZ6LGLMzoBZrjefQ3FtmGup2HFgs3p1fmt0tBbYQ==
X-Received: by 10.237.52.228 with SMTP id x91mr329620qtd.152.1519861565393;
        Wed, 28 Feb 2018 15:46:05 -0800 (PST)
Received: from [10.69.41.93] ([192.19.223.250])
        by smtp.googlemail.com with ESMTPSA id i37sm2104479qte.48.2018.02.28.15.45.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 28 Feb 2018 15:46:04 -0800 (PST)
Subject: Re: [PATCH v4] watchdog: add SPDX identifiers for watchdog subsystem
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
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
        Matthias Brugger <matthias.bgg@gmail.com>,
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
References: <20180228150209.2525-1-marcus.folkesson@gmail.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
Message-ID: <786d740d-f29c-8f09-4648-95244c06e59b@gmail.com>
Date:   Wed, 28 Feb 2018 15:45:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180228150209.2525-1-marcus.folkesson@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62755
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

On 02/28/2018 07:01 AM, Marcus Folkesson wrote:
> - Add SPDX identifier
> - Remove boiler plate license text
> - If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>   license
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> Acked-by: Baruch Siach <baruch@tkos.co.il>
> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> Acked-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> Acked-by: Johannes Thumshirn <jth@kernel.org>
> Acked-by: Mans Rullgard <mans@mansr.com>
> Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>
> Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> Acked-by: Thierry Reding <treding@nvidia.com>
> Acked-by: Tomas Winkler <tomas.winkler@intel.com>
> Acked-by: Patrice Chotard <patrice.chotard@st.com>
> Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> Reviewed-by: Eric Anholt <eric@anholt.net>
> ---
> 
> Notes:
>     v4:
>     	- Drop coh901327_wdt since it allready is a pending patch
>     v3:
>     	- Keep license text for ebc-c384_wdt
>     v2:
>     	- Put back removed copyright texts for meson_gxbb_wdt and coh901327_wdt
>     	- Change to BSD-3-Clause for meson_gxbb_wdt
>     v1: Please have an extra look at meson_gxbb_wdt.c
> 

>  drivers/watchdog/ar7_wdt.c             | 14 +---------

>  drivers/watchdog/bcm2835_wdt.c         |  5 +---
>  drivers/watchdog/bcm47xx_wdt.c         |  5 +---
>  drivers/watchdog/bcm63xx_wdt.c         |  5 +---
>  drivers/watchdog/bcm7038_wdt.c         | 12 ++------
>  drivers/watchdog/bcm_kona_wdt.c        |  9 +-----

>  drivers/watchdog/mtx-1_wdt.c           | 11 +-------

For these drivers above:

Acked-by: Florian Fainelli <f.fainelli@gmail.com>

and it looks like you missed rdc321x_wdt.c, is there a specific reason?
-- 
Florian
