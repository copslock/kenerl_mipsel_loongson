Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 23 Nov 2015 20:00:39 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:37687 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007467AbbKWTAi0AIHd (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Mon, 23 Nov 2015 20:00:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=OIu6tmuytgtc9QzwmAEyyBEQUs+JKmqke9DVJRykjBA=;
        b=a4k6VnMXmW6AWsFBr7IAyfI2VEjsAKkrX1riaTkpro/RzjdU9i/kRPpyngfABxIrntffO49amySaCQ/25JYf8vMCRpycT2agoXBc5jgqfC+D8zw3oNFhzMRshPzmeLDjVo8pZhhvC7SrXXUNeN1Voc8I+Z8Fmqpfj4WdarkHzdzghvTc17+v3aDeRPstNfthQMAFUyI+04vqztW/fppuriv6GQRf+OBkeahabiB18GYUY4qzlU8yWG34jFXYEvGdiTqU0mdiOapaKJqxA2xKvxZUn96gSAr5AD7nrqgH+tRcUprHucyxVCqTTSoHQnIoTrmp37UUUwoe1cgCPSWFZw==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:36458 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a0wLk-0003Yh-Tq (Exim); Mon, 23 Nov 2015 19:00:29 +0000
Subject: Re: [PATCH 6/10] watchdog: bcm63xx_wdt: Obtain watchdog clock HZ from
 "periph" clk
To:     Florian Fainelli <f.fainelli@gmail.com>,
        Jonas Gorski <jogo@openwrt.org>
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk> <5651CC3C.5090200@simon.arlott.org.uk>
 <CAOiHx==Z=4H=-L2CY-FE5m6WMV0XzgsCmy1b9tUbsmOHydzkEw@mail.gmail.com>
 <565358AF.2090609@gmail.com>
Cc:     Guenter Roeck <linux@roeck-us.net>,
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
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <5653624C.3030101@simon.arlott.org.uk>
Date:   Mon, 23 Nov 2015 19:00:28 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <565358AF.2090609@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50067
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: simon@fire.lp0.eu
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

On 23/11/15 18:19, Florian Fainelli wrote:
> On 23/11/15 07:02, Jonas Gorski wrote:
>> On Sun, Nov 22, 2015 at 3:07 PM, Simon Arlott <simon@fire.lp0.eu> wrote:
>>> -#define WDT_HZ                 50000000                /* Fclk */
>>> +#define WDT_CLK_NAME           "periph"
>> 
>> @Florian:
>> Is this correct? The comment for the watchdog in 6358_map_part.h and
>> earlier claims that the clock is 40 MHz there, but the code uses 50MHz
>> - is this a bug in the comments or is it a bug taken over from the
>> original broadcom code? I'm sure that the periph clock being 50 MHz
>> even on the older chips is correct, else we'd have noticed that in
>> serial output (where it's also used).
> 
> There are references to a Fbus2 clock in documentation, but I could not
> find any actual documentation for its actual clock frequency, I would be
> surprised if this chip would have diverged from the previous and future
> ones and used a 40Mhz clock. 6345 started with a peripheral clock
> running at 50Mhz, and that is true for all chips since then AFAICT.
> 
> I agree we would have noticed this with the UART or SPI controllers if
> that was not true, so probably a code glitch here...

I've tested both the timer and the watchdog and they give near perfect
time intervals (within 1-2ms based on printk times over serial) so it'd
be obvious if they were out by 25%.

-- 
Simon Arlott
