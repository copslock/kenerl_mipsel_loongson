Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 20 Feb 2018 16:14:12 +0100 (CET)
Received: from mail-pl0-x241.google.com ([IPv6:2607:f8b0:400e:c01::241]:36888
        "EHLO mail-pl0-x241.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994692AbeBTPN5PCdQI (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 20 Feb 2018 16:13:57 +0100
Received: by mail-pl0-x241.google.com with SMTP id ay8so7564503plb.4
        for <linux-mips@linux-mips.org>; Tue, 20 Feb 2018 07:13:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y34bTknDNKXY+MEzQSqwAz/ZO1mzx4llC5TzgdiaIRw=;
        b=cOHSDrhilFFMQlfyFSxiiHDgc6PPK2h0SI24+h0TOI3AQ1ATDhtxNJobE0sC6zpapv
         rO2pswNogmE7F2HbyrjTFSlhVyD6Fbck0JoracYtGvOdOquGq0OziNeMk4WsFBWZJtLy
         2oNcnqxwiMerEAjZPMPqp8lSODItbEA4JKnZqb0+YKmYdZvJmh+A4OsvMHH0D5m1+HM6
         Jirt8PJvsnhzCVS5aV93LNm6oZO08aDrUW+9+/9MCi6V6lpO9/5WUDO1WHiMopCekmGX
         fw1W7IHYeIZ+nPBT/UPw1gr/ddvawqayunTKEtGGfELhk/4wleX6sfD6yDXkSTvcvouA
         se9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=y34bTknDNKXY+MEzQSqwAz/ZO1mzx4llC5TzgdiaIRw=;
        b=Zq0mwLhrlQQmND+L4JYRfdIZQnepkfeJHlPGc2WbqtHls/iFjIRQa7PHn/NyrfrCfZ
         0Ds63Qpe1NTba4NEhkK2vbGkhStTy0nNpoc7UGKpFRvjouqreXwogCSnxr1KwCMp0cHa
         SmGH7uk1l31MCdTgx/AwnFYOKK7iaJbzjtluNpPzwIJ6GGNXbzGOF7f1TEX5LfFXdTAl
         KVkntVDCe91KSdyI6ZiSKHGfxqlRCjewZFRj6qX1fs3bj7rfhm17J4ULvj9BfS8F6XfS
         tIMJI5qncBH4B3ZYW6punoLFLSSdhVBrX+hMivzHdUxhZlOs4Z9YiYhizbEcufi+PNqV
         w85g==
X-Gm-Message-State: APf1xPBq+WvHliCxrdkwr7HnDRNvOt5kql4xk6gI1RE1c+3HDiafTr+y
        HF4has0HXOSy1SFowLeeOmo=
X-Google-Smtp-Source: AH8x224fX7bOUGsPtGUHYfTrxSKH2PQibDq4aRlyJY3v5ywdhjB4c0zTFUSbyqgLImz8XdDypS+4dQ==
X-Received: by 2002:a17:902:d68a:: with SMTP id v10-v6mr17615278ply.206.1519139630832;
        Tue, 20 Feb 2018 07:13:50 -0800 (PST)
Received: from server.roeck-us.net (108-223-40-66.lightspeed.sntcca.sbcglobal.net. [108.223.40.66])
        by smtp.gmail.com with ESMTPSA id e125sm9874049pgc.76.2018.02.20.07.13.44
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 20 Feb 2018 07:13:48 -0800 (PST)
Subject: Re: [PATCH v2] watchdog: add SPDX identifiers for watchdog subsystem
To:     Marcus Folkesson <marcus.folkesson@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
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
References: <20180220104542.32286-1-marcus.folkesson@gmail.com>
 <20180220124955.GA17814@sophia> <20180220132103.GD24311@gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <48db897e-8a61-a5bc-5a61-56349cafaa10@roeck-us.net>
Date:   Tue, 20 Feb 2018 07:13:43 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180220132103.GD24311@gmail.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Return-Path: <groeck7@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62651
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: linux@roeck-us.net
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

On 02/20/2018 05:21 AM, Marcus Folkesson wrote:
> Hello William,
> 
> On Tue, Feb 20, 2018 at 07:49:55AM -0500, William Breathitt Gray wrote:
>> On Tue, Feb 20, 2018 at 11:45:31AM +0100, Marcus Folkesson wrote:
>>> - Add SPDX identifier
>>> - Remove boiler plate license text
>>> - If MODULE_LICENSE and boiler plate does not match, go for boiler plate
>>>   license
>>>
>>> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
>>> Acked-by: Adam Thomson <Adam.Thomson.Opensource@diasemi.com>
>>> Acked-by: Charles Keepax <ckeepax@opensource.cirrus.com>
>>> Acked-by: Nicolas Ferre <nicolas.ferre@microchip.com>
>>> Acked-by: Michal Simek <michal.simek@xilinx.com>
>>> ---
>>>
>>> Notes:
>>>     v2:
>>>     	- Put back removed copyright texts for meson_gxbb_wdt and coh901327_wdt
>>>     	- Change to BSD-3-Clause for meson_gxbb_wdt
>>>     v1: Please have an extra look at meson_gxbb_wdt.c
>>
>> [...]
>>
>>> diff --git a/drivers/watchdog/ebc-c384_wdt.c b/drivers/watchdog/ebc-c384_wdt.c
>>> index 2170b275ea01..c173b6f5c866 100644
>>> --- a/drivers/watchdog/ebc-c384_wdt.c
>>> +++ b/drivers/watchdog/ebc-c384_wdt.c
>>> @@ -1,15 +1,8 @@
>>> +// SPDX-License-Identifier: GPL-2.0
>>> /*
>>>   * Watchdog timer driver for the WinSystems EBC-C384
>>>   * Copyright (C) 2016 William Breathitt Gray
>>>   *
>>> - * This program is free software; you can redistribute it and/or modify
>>> - * it under the terms of the GNU General Public License, version 2, as
>>> - * published by the Free Software Foundation.
>>> - *
>>> - * This program is distributed in the hope that it will be useful, but
>>> - * WITHOUT ANY WARRANTY; without even the implied warranty of
>>> - * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
>>> - * General Public License for more details.
>>>   */
>>> #include <linux/device.h>
>>> #include <linux/dmi.h>
> 
> Thank you for your feedback!
>>
>> I have no problem with adding a SPDX line to the top of this file, but
>> use "SPDX-License-Identifier: GPL-2.0-only" as I was very intentional
>> with the selection of GPL version 2 only when I published this code.
> 
> SPDX-License-Identifier: GPL-2.0
> Is GPL-2.0 only [1], so it respects your choice of license.
> 
>>
>> Furthermore, please do not remove the existing copyright text; although
> 

It is not a matter if you CAN keep a copyright. You MUST NOT remove a copyright.
As long as you do, the series is

Nacked-by: Guenter Roeck <linux@roeck-us.net>

Guenter

> The copyright text:
> 
>   Copyright (C) 2016 William Breathitt Gray
> 
> Is still in the file.
> 
> 
>> it's just boilerplate for some, I was careful with the selection of
>> these words, and I worry the SPDX line only -- despite its useful
>> conciseness -- may lead to misunderstandings about my intentioned
>> license for this code.
> 
> I'm not sure I understand your concerns here, the SPDX identifier is
> a shorthand for the GPL 2.0 only license. See [1] - Linux kernel licensing rules.
> 
> One of the biggest benefits with SPDX identifier is that it is hard to verify
> boiler plate licenses due to formatting, types, different formulations and so on.
> 
> If still worrying, I think we could keep the license text as
> well.
> 
>>
>> For the time being, I can't Ack this patch with the changes it makes
>> currently:
>>
>>          Nacked-by: William Breathitt Gray <vilhelm.gray@gmail.com>
>>
>> William Breathitt Gray
> 
> Please let me know if I got you wrong at some point.
> 
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/Documentation/process/license-rules.rst
> 
> Best regards
> Marcus Folkesson
> 
