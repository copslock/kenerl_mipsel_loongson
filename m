Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 19:14:52 +0100 (CET)
Received: from mail-yw0-x243.google.com ([IPv6:2607:f8b0:4002:c05::243]:35573
        "EHLO mail-yw0-x243.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994692AbeBTSOnQ2pvB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 19:14:43 +0100
Received: by mail-yw0-x243.google.com with SMTP id d205so4076187ywe.2
        for <linux-mips@linux-mips.org>; Tue, 20 Feb 2018 10:14:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=P/r+OAjG5XN94TMU6GmGyG4CXAT72zZWqCVMMpJeapw=;
        b=G8HBVF9inmd33tLYughZJQhhjp2OYaZKjsWfdohYYh81ksXOgQUYowff515ZYiN6Hf
         b5ITexSsNt2Z4EXz4SFRCK20d5f6JgbrM7cipnZWLnzXh1Qq7wLLCFpaFGATytweBzVa
         amgo7B9cloHyc6wtZgLYXeUqBHlEy37GaLIlA3DHv2ADDhA3lzXXK/sMM5b4394YT0I0
         1BfCSk/GE9xPQPzyzrtMmdbU9JNhIyc9sBQWsSWu0OIdMRwr36frEM6RJzm0aJMvT176
         ELGnLPQ+DN7nJGnMl7kevwph5fFmsKkORjvtBCkxArLXdCMeVJNOhe10Y3jKm4tA+iXq
         +VXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=P/r+OAjG5XN94TMU6GmGyG4CXAT72zZWqCVMMpJeapw=;
        b=s89sWZPXxbW5jb9ADvrUr3sMhwPufla0OKFe5rU01/M63tLYo3/rQ4nuJ5706E8eMi
         T3wmOCSV+yNzMbXxfmPdZ0AKNVZjjyn017pjJ3mX32F080AAVnKPsEdOSIq40S5OCUWw
         AHnb2GDkh/wL0Vr6vijiOymj5RB8bOZ6IIEg49Gc6zusngbWqPw+Q2fpsg3KGd/A98sF
         nFlc5BrhgucDNOqOb9q+QoActPm10t3arQ3IDnXAJ34rdJtv6lngnM3RzGGuSx7hx0AA
         aeuZJdm9JKbrHjtHl1k34ljpTSe1a4SonkrX4Wa/RahC0KtUdEynQgsnK3Jb4VbWYOFe
         poKg==
X-Gm-Message-State: APf1xPC+HhJtnrJ0oQAnn7OmNVMGXJj4PXJ7DQOI+KupxBuXltymvyo4
        TRgldN3XVQ73S9lKlYWMlXg=
X-Google-Smtp-Source: AH8x224lvuI92wIwnHH48tCtgnMuIxiYINMJ1m+9RsdIYWpFcxWGZU6ICHetc/DzC+FjHrKOwZllwg==
X-Received: by 10.129.46.4 with SMTP id u4mr492514ywu.164.1519150476525;
        Tue, 20 Feb 2018 10:14:36 -0800 (PST)
Received: from sophia ([72.188.97.40])
        by smtp.gmail.com with ESMTPSA id x190sm10325035ywg.51.2018.02.20.10.14.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Feb 2018 10:14:35 -0800 (PST)
Date:   Tue, 20 Feb 2018 13:14:27 -0500
From:   William Breathitt Gray <vilhelm.gray@gmail.com>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
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
Message-ID: <20180220181427.GA25467@sophia>
References: <20180220104542.32286-1-marcus.folkesson@gmail.com>
 <20180220124955.GA17814@sophia>
 <20180220132103.GD24311@gmail.com>
 <48db897e-8a61-a5bc-5a61-56349cafaa10@roeck-us.net>
 <20180220153326.GE24311@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180220153326.GE24311@gmail.com>
User-Agent: Mutt/1.9.3 (2018-01-21)
Return-Path: <vilhelm.gray@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62655
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

On Tue, Feb 20, 2018 at 04:33:26PM +0100, Marcus Folkesson wrote:
>On Tue, Feb 20, 2018 at 07:13:43AM -0800, Guenter Roeck wrote:
>> On 02/20/2018 05:21 AM, Marcus Folkesson wrote:
>> > Hello William,
>> > 
>> > On Tue, Feb 20, 2018 at 07:49:55AM -0500, William Breathitt Gray wrote:
>> > > On Tue, Feb 20, 2018 at 11:45:31AM +0100, Marcus Folkesson wrote:
>> > > > - Add SPDX identifier
>> > > > - Remove boiler plate license text
>> > > > - If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>> > > >   license
>> > > > 
>> > > > Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>> > > > Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
>> > > > Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>> > > > Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>> > > > Acked-by: Michal Simek <michal.simek@xilinx.com>
>> > > > ---
>> > > > 
>> > > > Notes:
>> > > >     v2:
>> > > >     	- Put back removed copyright texts for meson_gxbb_wdt and coh901327_wdt
>> > > >     	- Change to BSD-3-Clause for meson_gxbb_wdt
>> > > >     v1: Please have an extra look at meson_gxbb_wdt.c
>> > > 
>> > > [...]
>> > > 
>> > > > diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
>> > > > index 2170b275ea01..c173b6f5c866 100644
>> > > > --- a/drivers/watchdog/ebc-c384_wdt.c
>> > > > +++ b/drivers/watchdog/ebc-c384_wdt.c
>> > > > @@ -1,15 +1,8 @@
>> > > > +// SPDX-License-Identifier: GPL-2.0
>> > > > /*
>> > > >   * Watchdog timer driver for the WinSystems EBC-C384
>> > > >   * Copyright (C) 2016 William Breathitt Gray
>> > > >   *
>
>The copyright is untouched?
>
>> > > > - * This program is free software; you can redistribute it and/or modify
>> > > > - * it under the terms of the GNU General Public License, version 2, as
>> > > > - * published by the Free Software Foundation.
>> > > > - *
>> > > > - * This program is distributed in the hope that it will be useful, but
>> > > > - * WITHOUT ANY WARRANTY; without even the implied warranty of
>> > > > - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>> > > > - * General Public License for more details.
>> > > >   */
>> > > > #include <linux/device.h>
>> > > > #include <linux/dmi.h>
>> > 
>> > Thank you for your feedback!
>> > > 
>> > > I have no problem with adding a SPDX line to the top of this file, but
>> > > use "SPDX-License-Identifier: GPL-2.0-only" as I was very intentional
>> > > with the selection of GPL version 2 only when I published this code.
>> > 
>> > SPDX-License-Identifier: GPL-2.0
>> > Is GPL-2.0 only [1], so it respects your choice of license.

Ah, this should be fine then. :)

>> > 
>> > > 
>> > > Furthermore, please do not remove the existing copyright text; although
>> > 
>> 
>> It is not a matter if you CAN keep a copyright. You MUST NOT remove a copyright.
>> As long as you do, the series is
>> 
>> Nacked-by: Guenter Roeck <linux@roeck-us.net>
>> 
>> Guenter
>
>I'm sorry, I do not see where the copyright is removed unless you count
>the license text as part of the copyright.
>
>Can you please point it out?
>
>> 
>> > The copyright text:
>> > 
>> >   Copyright (C) 2016 William Breathitt Gray
>> > 
>> > Is still in the file.
>
>^^^
>
>> > 
>> > 
>> > > it's just boilerplate for some, I was careful with the selection of
>> > > these words, and I worry the SPDX line only -- despite its useful
>> > > conciseness -- may lead to misunderstandings about my intentioned
>> > > license for this code.
>> > 
>> > I'm not sure I understand your concerns here, the SPDX identifier is
>> > a shorthand for the GPL 2.0 only license. See [1] - Linux kernel licensing rules.
>> > 
>> > One of the biggest benefits with SPDX identifier is that it is hard to verify
>> > boiler plate licenses due to formatting, types, different formulations and so on.
>> > 
>> > If still worrying, I think we could keep the license text as
>> > well.

I'm sorry for the confusion, I should have wrote "license text" rather
than "copyright text" in my previous message. I agree with the benefits
of utilizing the SPDX identifier, and I see the addition of the SPDX
line as useful, but I would prefer the original license text remain as
well.

William Breathitt Gray

>> > 
>> > > 
>> > > For the time being, I can't Ack this patch with the changes it makes
>> > > currently:
>> > > 
>> > >          Nacked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>> > > 
>> > > William Breathitt Gray
>> > 
>> > Please let me know if I got you wrong at some point.
>> > 
>> > [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
>> > 
>> > Best regards
>> > Marcus Folkesson
>> > 
>> 
>
>Best regards
>Marcus Folkesson
