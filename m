Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 Feb 2018 13:40:48 +0100 (CET)
Received: from mail-yw0-x243.google.com ([IPv6:2607:f8b0:4002:c05::243]:39651
        "EHLO mail-yw0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23991416AbeBUMkj6OkxT (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 Feb 2018 13:40:39 +0100
Received: by mail-yw0-x243.google.com with SMTP id b20so439189ywe.6
        for <linux-mips@linux-mips.org>; Wed, 21 Feb 2018 04:40:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=MZj/5QeDKoWSLw5ma3F5fJnudei3GDct6k+11Ln2/es=;
        b=Y7zNVVBjN/V8PRaScCzuCr7ioYRPs3YIavqqjj1EbRStT9oArxXOQ12Sm8z+AvrQ1y
         CV7H3Arl4ed3JWpxmf++k5Nn6SFVjw2Os6YbkEZzXDCJxFPfr603kaDFTz05t0iSY/KN
         ARiGExb0Red44SdG0q0E7ATbIx5HE87peGxlscv21xutVkL7LvAKVtFdwY6XsRqmgPAM
         SnhtdJUqTVP2KBHGOaWnHVPlK+h/8Oc7wd1haEI/hjwQAmlwKBhKtCYfxdRvip1LUiBW
         eV8CxDMiDPzSzKEYD2DjFJPTBorBLofamU5LonC/GAk1qmBiL69FxHBeF1GQrHr20Azs
         vNFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=MZj/5QeDKoWSLw5ma3F5fJnudei3GDct6k+11Ln2/es=;
        b=pZ4W7lNaP+WDq/1snL1x7eKf3EYTBwggLH548Wgc5Cr3I7fq93WFH7j/DupszEpBDB
         nI5wYoqSaJ3Jz05nA4C9fLzr40+ZC+1YendJLy6yGlb1rrgBpqABrzh5FXE/RDPeKmGd
         7q8J21hmah1YicqLbtmKRM59XAMN/ijVZc22E9v0M9fbOxiwmGEd4DEtPY9nb6M+uLoj
         6yA6R/UUpiK2Yzx5O3KYUnyutNaoTHpu1F0T3rEe8cj+PS8snewq471EZxqn7QyhFvzo
         LTtRXerzHFsIl0GmYMBZtodtaZKG14VKm4snqcSdI6Lvr1ligSsrLVNysor7U8XlSPOB
         3/Lg==
X-Gm-Message-State: APf1xPDZe6PSznq3y9oIIo62ov2Th/uosqAs6f2KfjfDOYnPPDXRQxa2
        ldVXE+Jw/5gma6dKxUHtqWc=
X-Google-Smtp-Source: AH8x227C/tP1oQTSOvXAZte9KjDwIGvHQo8y28pnreh3FC9OIhM1SCSx0Le1HYd5RSr27qmVvNf2cw==
X-Received: by 10.13.202.150 with SMTP id m144mr2108294ywd.70.1519216833803;
        Wed, 21 Feb 2018 04:40:33 -0800 (PST)
Received: from sophia ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id l23sm11043755ywh.23.2018.02.21.04.40.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 21 Feb 2018 04:40:33 -0800 (PST)
Date:   Wed, 21 Feb 2018 07:40:25 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Joel Stanley <joel@jms.id.au>,
        Nicolas Ferre <nicolas.ferre@microchip.com>,
        Alexandre Belloni <alexandre.belloni@free-electrons.com>,
        Eric Anholt <eric@anholt.net>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Support Opensource <support.opensource@diasemi.com>,
        Baruch Siach <baruch@tkos.co.il>,
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
Subject: Re: [PATCH v3] watchdog: add SPDX identifiers for watchdog subsystem
Message-ID: <20180221124024.GA3773@sophia>
References: <20180221122744.28300-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180221122744.28300-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Return-Path: <vilhelm.gray@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62674
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: vilhelm.gray@gmail.com
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

On Wed, Feb 21, 2018 at 01:27:34PM +0100, Marcus Folkesson wrote:
>- Add SPDX identifier
>- Remove boiler plate license text
>- If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>  license
>
>Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
>Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>Acked-by: Mans Rullgard <mans@mansr.com>
>Acked-by: Matthias Brugger <matthias.bgg@gmail.com>
>Acked-by: Michal Simek <michal.simek@xilinx.com>
>Acked-by: Neil Armstrong <narmstrong@baylibre.com>
>Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>Acked-by: Thierry Reding <treding@nvidia.com>
>Reviewed-by: Eric Anholt <eric@anholt.net>
>---
>
>Notes:
>    v3:
>    	- Keep license text for ebc-c384_wdt
>    v2:
>    	- Put back removed copyright texts for meson_gxbb_wdt and coh901327_wdt
>    	- Change to BSD-3-Clause for meson_gxbb_wdt
>    v1: Please have an extra look at meson_gxbb_wdt.c

[...]

>diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
>index 2170b275ea01..4c4c8ce78021 100644
>--- a/drivers/watchdog/ebc-c384_wdt.c
>+++ b/drivers/watchdog/ebc-c384_wdt.c
>@@ -1,3 +1,4 @@
>+// SPDX-License-Identifier: GPL-2.0
> /*
>  * Watchdog timer driver for the WinSystems EBC-C384
>  * Copyright (C) 2016 William Breathitt Gray

For ebc-c384_wdt.c,

Acked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

William Breathitt Gray
