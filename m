Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 13:50:20 +0100 (CET)
Received: from mail-yb0-x243.google.com ([IPv6:2607:f8b0:4002:c09::243]:40550
        "EHLO mail-yb0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994684AbeBTMuKlfhP1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 13:50:10 +0100
Received: by mail-yb0-x243.google.com with SMTP id i15-v6so3884403ybg.7
        for <linux-mips@linux-mips.org>; Tue, 20 Feb 2018 04:50:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=byKJGfnbKvzJbMtIXntFX85ARosKvyaw6K0Z7kupIOw=;
        b=Wlz2tyHkAN5NzEQXJxrw67mC7k2DcnkqBE0GhPaD0bzzKWw69+hzpf5j5R8w4Pi5MK
         XDQBLTRars5G9DojsH7zWd0AtPGVjwIPDyx6n7d6AILf7vx7BMyLtBERQeLwgdi0i472
         oDPyQWd8ekkLbOftCvrbsJXpdV5OxRU6e/3p/Rjb183g+BapeACCTdhgXz1I3+ula4RV
         E4dLpHJ4+oJ3K1j6HmqUL8S+UF6gIXO6z2VLgH7Egdcm4Fbbij18mrA7tZBEiar7e4vV
         Ozq253WvCyXIN1hqqpyzVu/YDwmnx6ZB6m769VFUKwDTB9jB1jIPiv9+MpKFkjQJlHyK
         Y7Lw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=byKJGfnbKvzJbMtIXntFX85ARosKvyaw6K0Z7kupIOw=;
        b=crZ1pLzHbvgrKa2raWZOLR/MwH9P0SmmgdmhUNxzUbRlYO+tOnNs5sd96D6vaCrjuM
         sv9hV3Ph2BqmU6etgeaUOoxhUx1dKUzFGOzQgyejjz1inL5YoWGB8PoHPcFGepYd0//I
         bBY/C3MFhsvzZ2ZIPJu8I84W9DR0RUfB8yJFvZXsGAv0ywtOxKnTxlvCnKBTPB0HMGdV
         p+lhn3Lk7lk+c17EnygbvUN//2RO2MVCNgWO5ugmpcmoaq9tlk8QzFmyPnL3WRkJOWcl
         wf/MkRqfN+ju0rxzqBcWALOHBtgvr1Moefv4p7Bd6cv2ocwuvge0fLXyO8TeeeCrHyxc
         Zo8g==
X-Gm-Message-State: APf1xPCN+9W7FdFqWqKo0qDjhH390E3yaFAg4SQnloybsi7UuG385/XZ
        y1tY8WSZBoinGKHwGF8NKYw=
X-Google-Smtp-Source: AH8x224mDgEi0DdQJXTFPsuPWY33qQvpyHGIwxfBe1gyHC/DMSyijV2IgzAJH7E3frSSyKGv9XQMSA==
X-Received: by 10.37.200.194 with SMTP id y185mr12887689ybf.243.1519131004398;
        Tue, 20 Feb 2018 04:50:04 -0800 (PST)
Received: from sophia ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id m184sm9876557ywe.98.2018.02.20.04.50.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Feb 2018 04:50:03 -0800 (PST)
Date:   Tue, 20 Feb 2018 07:49:55 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
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
Subject: Re: [PATCH v2] watchdog: add SPDX identifiers for watchdog subsystem
Message-ID: <20180220124955.GA17814@sophia>
References: <20180220104542.32286-1-marcus.folkesson@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180220104542.32286-1-marcus.folkesson@gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Return-Path: <vilhelm.gray@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62647
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

On Tue, Feb 20, 2018 at 11:45:31AM +0100, Marcus Folkesson wrote:
>- Add SPDX identifier
>- Remove boiler plate license text
>- If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>  license
>
>Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
>Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>Acked-by: Michal Simek <michal.simek@xilinx.com>
>---
>
>Notes:
>    v2:
>    	- Put back removed copyright texts for meson_gxbb_wdt and coh901327_wdt
>    	- Change to BSD-3-Clause for meson_gxbb_wdt
>    v1: Please have an extra look at meson_gxbb_wdt.c

[...]

>diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
>index 2170b275ea01..c173b6f5c866 100644
>--- a/drivers/watchdog/ebc-c384_wdt.c
>+++ b/drivers/watchdog/ebc-c384_wdt.c
>@@ -1,15 +1,8 @@
>+// SPDX-License-Identifier: GPL-2.0
> /*
>  * Watchdog timer driver for the WinSystems EBC-C384
>  * Copyright (C) 2016 William Breathitt Gray
>  *
>- * This program is free software; you can redistribute it and/or modify
>- * it under the terms of the GNU General Public License, version 2, as
>- * published by the Free Software Foundation.
>- *
>- * This program is distributed in the hope that it will be useful, but
>- * WITHOUT ANY WARRANTY; without even the implied warranty of
>- * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>- * General Public License for more details.
>  */
> #include <linux/device.h>
> #include <linux/dmi.h>

I have no problem with adding a SPDX line to the top of this file, but
use "SPDX-License-Identifier: GPL-2.0-only" as I was very intentional
with the selection of GPL version 2 only when I published this code.

Furthermore, please do not remove the existing copyright text; although
it's just boilerplate for some, I was careful with the selection of
these words, and I worry the SPDX line only -- despite its useful
conciseness -- may lead to misunderstandings about my intentioned
license for this code.

For the time being, I can't Ack this patch with the changes it makes
currently:

        Nacked-by: William Breathitt Gray <vilhelm.gray@gmail.com>

William Breathitt Gray
