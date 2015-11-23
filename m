Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2015 19:20:44 +0100 (CET)
Received: from mail-pa0-f43.google.com ([209.85.220.43]:35193 "EHLO
        mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S27013023AbbKWSUmFQ0jM (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 23 Nov 2015 19:20:42 +0100
Received: by pacej9 with SMTP id ej9so198434635pac.2;
        Mon, 23 Nov 2015 10:20:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=gf8s1Cb3Yj/HzcpFLoKaFajNYcVz4+rrj9LnWmbSlrE=;
        b=zDLQ03MsioBqUu7fwpM3EP9MfoLOjbWWjbxQhIovaAIHHS43Yt6twjtoVCCGRMyUS9
         7xp2MhgUG6aePJ+0JcIsxqLMIKQ78+dD3OyfBKjN8DqPFjAvTwVkeIVyB3CRkpl4JBuh
         gWYXxGW5hajlYYtSvP4vnT6udoY76HT02tCy+3lqa0R+VTZa3jbhg64RTvTlfvN1+SP6
         LRob3TwqWI6PQh0qpkVUxsMEeCT37/PlAWTI+w42hqO9yNNm9tpoRA01wyZtIIelFice
         tZhz8U0gJyw7ovuS1N1MpGoQZ7rslyqq9dUlki6t/8fsHr+bF9hH4ntumv3KIe8UHnPX
         C+rg==
X-Received: by 10.66.180.48 with SMTP id dl16mr37154121pac.39.1448302834939;
        Mon, 23 Nov 2015 10:20:34 -0800 (PST)
Received: from [10.12.156.244] (5520-maca-inet1-outside.broadcom.com. [216.31.211.11])
        by smtp.googlemail.com with ESMTPSA id qn5sm11324813pac.41.2015.11.23.10.20.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 23 Nov 2015 10:20:33 -0800 (PST)
Message-ID: <565358AF.2090609@gmail.com>
Date:   Mon, 23 Nov 2015 10:19:27 -0800
From:   Florian Fainelli <f.fainelli@gmail.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:31.0) Gecko/20100101 Thunderbird/31.8.0
MIME-Version: 1.0
To:     Jonas Gorski <jogo@openwrt.org>, Simon Arlott <simon@fire.lp0.eu>
CC:     Guenter Roeck <linux@roeck-us.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        MIPS Mailing List <linux-mips@linux-mips.org>,
        linux-watchdog@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
Subject: Re: [PATCH 6/10] watchdog: bcm63xx_wdt: Obtain watchdog clock HZ
 from "periph" clk
References: <5650BFD6.5030700@simon.arlott.org.uk> <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net> <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net> <5651CB13.4090704@simon.arlott.org.uk> <5651CC3C.5090200@simon.arlott.org.uk> <CAOiHx==Z=4H=-L2CY-FE5m6WMV0XzgsCmy1b9tUbsmOHydzkEw@mail.gmail.com>
In-Reply-To: <CAOiHx==Z=4H=-L2CY-FE5m6WMV0XzgsCmy1b9tUbsmOHydzkEw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <f.fainelli@gmail.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50064
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

On 23/11/15 07:02, Jonas Gorski wrote:
> Hi,
> 
> On Sun, Nov 22, 2015 at 3:07 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
>> Instead of using a fixed clock HZ in the driver, obtain it from the
>> "periph" clk that the watchdog timer uses.
>>
>> Signed-off-by: Simon Arlott <simon@fire.lp0.eu>
>> ---
>>  drivers/watchdog/bcm63xx_wdt.c | 36 +++++++++++++++++++++++++++++++-----
>>  1 file changed, 31 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/watchdog/bcm63xx_wdt.c b/drivers/watchdog/bcm63xx_wdt.c
>> index 1d2a501..eb5e551 100644
>> --- a/drivers/watchdog/bcm63xx_wdt.c
>> +++ b/drivers/watchdog/bcm63xx_wdt.c
>> @@ -13,6 +13,7 @@
>>
>>  #define pr_fmt(fmt) KBUILD_MODNAME ": " fmt
>>
>> +#include <linux/clk.h>
>>  #include <linux/errno.h>
>>  #include <linux/io.h>
>>  #include <linux/kernel.h>
>> @@ -32,11 +33,13 @@
>>
>>  #define PFX KBUILD_MODNAME
>>
>> -#define WDT_HZ                 50000000                /* Fclk */
>> +#define WDT_CLK_NAME           "periph"
> 
> @Florian:
> Is this correct? The comment for the watchdog in 6358_map_part.h and
> earlier claims that the clock is 40 MHz there, but the code uses 50MHz
> - is this a bug in the comments or is it a bug taken over from the
> original broadcom code? I'm sure that the periph clock being 50 MHz
> even on the older chips is correct, else we'd have noticed that in
> serial output (where it's also used).

There are references to a Fbus2 clock in documentation, but I could not
find any actual documentation for its actual clock frequency, I would be
surprised if this chip would have diverged from the previous and future
ones and used a 40Mhz clock. 6345 started with a peripheral clock
running at 50Mhz, and that is true for all chips since then AFAICT.

I agree we would have noticed this with the UART or SPI controllers if
that was not true, so probably a code glitch here...
-- 
Florian
