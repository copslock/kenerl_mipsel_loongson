Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 01 Mar 2018 08:25:03 +0100 (CET)
Received: from mail-lf0-x243.google.com ([IPv6:2a00:1450:4010:c07::243]:45548
        "EHLO mail-lf0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992966AbeCAHY4EiBjV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 1 Mar 2018 08:24:56 +0100
Received: by mail-lf0-x243.google.com with SMTP id h127so6270855lfg.12
        for <linux-mips@linux-mips.org>; Wed, 28 Feb 2018 23:24:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=+SPY0sM7CWb6PUaXlbHstccj0lI4ULSUL1ZPWLG65+s=;
        b=MzYCBymVSfAkYaUJUeXaiHBisCP1ZG9oFEIiLWOSMmmbAA+t3UErXToZ+5PGT0AADw
         wSTh4PmZFUj6iXFW/rDYxW/KL+AYdjQreRjIinaMEnObHXo7OQK0evRXajQJd1icZc0p
         AQQ/yGvvj75iXo1TyCkdhOf1UbnxexcmRpIrVelDcEqlbgW+hejiGh5yxn2Nk8OHnoWk
         XI0yi/i7I8hg4D4mpaN5gcnm9L2XXWin20fMQtAxt3JYP2YtVhFc51+OnrIHuI/ajeg1
         0UQ2oywf5KjrtNVWxLgKJYt0VkGZNiPrqNOLvX8Tb4vVj5rPEsiYZgbPW6MPbSLQnkdJ
         djYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=+SPY0sM7CWb6PUaXlbHstccj0lI4ULSUL1ZPWLG65+s=;
        b=l0acVS6ykkZCvLf4J3DX3hYj38mSMjNUrPQzjGhcRXBMSSnt+oUgxRr59F8fPwDRLo
         P0orRqD6kleIzDedVBVWTLKE00+zx25zLn0xLPQoG8LsXi4lEKQ05tnOHG6/vz5tEp7k
         gBVwep6okWW857jS3RBXrEOE20W0+TMRF1I/ffxiBFk+6ec/yu40Vng72QN3AztURS/l
         ZOwUi7YlwFm8WRPANFPYVzk+HSCGQcrHqLaMqh8cNsxdg8hhkrdRBO258yQ123E2ePLD
         hb/vfPh1ADWT0msIc4tl7mKQabNoMTI7lW1O8pMhr7bIDfCvp5Eh/jGsclCn6wSpMUjG
         HDEQ==
X-Gm-Message-State: AElRT7EPqj85sEgXqQui3y+FCViFGTFNnTYzkbBDsLy2k06dCjmCfikb
        YDGUSTDWeYO9qjzWO2R93nY=
X-Google-Smtp-Source: AG47ELvLDjNfyyGRjnhBA44H8oU5VXEqBxJmSeIDpgseXB2dn7n9PeBglHAgSd3EkP9Y5YS04lQOQg==
X-Received: by 10.25.202.9 with SMTP id a9mr680531lfg.144.1519889090329;
        Wed, 28 Feb 2018 23:24:50 -0800 (PST)
Received: from gmail.com ([46.194.87.165])
        by smtp.gmail.com with ESMTPSA id s7sm753081lfg.13.2018.02.28.23.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 28 Feb 2018 23:24:49 -0800 (PST)
Date:   Thu, 1 Mar 2018 08:24:42 +0100
From:   Marcus Folkesson <marcus.folkesson@gmail.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
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
        Shawn Guo <shawnguo@kernel.org>,
        linux-watchdog@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org,
        adi-buildroot-devel@lists.sourceforge.net,
        linux-mips@linux-mips.org, linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, patches@opensource.cirrus.com
Subject: Re: [PATCH v4] watchdog: add SPDX identifiers for watchdog subsystem
Message-ID: <20180301072432.GA8901@gmail.com>
References: <20180228150209.2525-1-marcus.folkesson@gmail.com>
 <786d740d-f29c-8f09-4648-95244c06e59b@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <786d740d-f29c-8f09-4648-95244c06e59b@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Return-Path: <marcus.folkesson@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62761
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: marcus.folkesson@gmail.com
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

Florian,

On Wed, Feb 28, 2018 at 03:45:43PM -0800, Florian Fainelli wrote:
> On 02/28/2018 07:01 AM, Marcus Folkesson wrote:
> > - Add SPDX identifier
> > - Remove boiler plate license text
> > - If MODULE_LICENSE and boiler plate does not match, go for boiler plate
> >   license
> > 
> > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> > Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
> > Acked-by: Baruch Siach <baruch@tkos.co.il>
> > Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
> > Acked-by: Keiji Hayashibara <hayashibara.keiji@socionext.com>
> > Acked-by: Johannes Thumshirn <jth@kernel.org>
> > Acked-by: Mans Rullgard <mans@mansr.com>
> > Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
> > Acked-by: Michal Simek <michal.simek@xilinx.com>
> > Acked-by: Neil Armstrong <narmstrong@baylibre.com>
> > Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
> > Acked-by: Thierry Reding <treding@nvidia.com>
> > Acked-by: Tomas Winkler <tomas.winkler@intel.com>
> > Acked-by: Patrice Chotard <patrice.chotard@st.com>
> > Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> > Reviewed-by: Eric Anholt <eric@anholt.net>
> > ---
> > 
> > Notes:
> >     v4:
> >     	- Drop coh901327_wdt since it allready is a pending patch
> >     v3:
> >     	- Keep license text for ebc-c384_wdt
> >     v2:
> >     	- Put back removed copyright texts for meson_gxbb_wdt and coh901327_wdt
> >     	- Change to BSD-3-Clause for meson_gxbb_wdt
> >     v1: Please have an extra look at meson_gxbb_wdt.c
> > 
> 
> >  drivers/watchdog/ar7_wdt.c             | 14 +---------
> 
> >  drivers/watchdog/bcm2835_wdt.c         |  5 +---
> >  drivers/watchdog/bcm47xx_wdt.c         |  5 +---
> >  drivers/watchdog/bcm63xx_wdt.c         |  5 +---
> >  drivers/watchdog/bcm7038_wdt.c         | 12 ++------
> >  drivers/watchdog/bcm_kona_wdt.c        |  9 +-----
> 
> >  drivers/watchdog/mtx-1_wdt.c           | 11 +-------
> 
> For these drivers above:
> 
> Acked-by: Florian Fainelli <f.fainelli@gmail.com>
> 
> and it looks like you missed rdc321x_wdt.c, is there a specific reason?

Good catch!
I will fix that, thank you.

> -- 
> Florian


Best regards
Marcus Folkesson
