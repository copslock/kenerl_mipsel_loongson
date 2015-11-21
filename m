Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 21 Nov 2015 22:44:53 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:60983 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012263AbbKUVouytXl2 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 21 Nov 2015 22:44:50 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=HQcevRNpTa6LykmCUpomDkzVtwTxsgaO7/sIIXXPNLs=;
        b=IIntRsbuY2cQrTpkjaC7Al8ddUFiH3/PQ/bXB7sYEPRQspXwjuEPnQoSwPfuTo8oclQtK1MR2l9miM3rdID/tgKNDtymLUVkrygy4ChBgj1KaxBDq36phDo9FbKqbFcB6Q9aAD4w5XpRErOakxS6ol5MC3Fz9qb4RwNh7nu4iSC5DkBqByypm0JmISy8XmeyWf9eEDdzDFUMIo7Sfv7ih1XVoQQfjo1oBjBaGsTIV2juDSOAkhpdfQzpoSon84QcLhZKXDywCKEfJr+ZxtMEQ9O4FxcTCfCc/cZrsP6Kewx3IFesW7n/6hqTmaZKJf8dJi7oX/PKxLgzl1TLfaOA6Q==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:58583 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a0FxO-0007dr-DG (Exim); Sat, 21 Nov 2015 21:44:31 +0000
Subject: Re: [PATCH 4/4] MIPS: bmips: Convert bcm63xx_wdt to use WATCHDOG_CORE
To:     Guenter Roeck <linux@roeck-us.net>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Miguel Gaio <miguel.gaio@efixo.com>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <5650E5BB.6020404@simon.arlott.org.uk>
Date:   Sat, 21 Nov 2015 21:44:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <5650E2FA.6090408@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50034
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

On 21/11/15 21:32, Guenter Roeck wrote:
> On 11/21/2015 11:05 AM, Simon Arlott wrote:
>> Convert bcm63xx_wdt to use WATCHDOG_CORE and add a device tree binding.
>>
>> Adds support for the time left value and provides a more effective
>> interrupt handler based on the watchdog warning interrupt behaviour.
>>
>> This removes the unnecessary software countdown timer and replaces the
>> use of bcm63xx_timer with a normal interrupt when not using mach-bcm63xx.
>>
> 
> Hi Simon,
> 
> this is really doing a bit too much in a single patch.
> Conversion to the watchdog infrastructure should probably be
> the first step, followed by further optimizations and improvements.

I'll split it into two patches, but that won't remove the need for #ifdefs.

> In general, it would be great if we can avoid #ifdef in the code.
> Maybe there is some other means to determine if one code path
> needs to be taken or another. The driver may be part of a
> multi-platform image, and #ifdefs in the code make that all
> but impossible. Besides, it makes the code really hard to read
> and understand.

It's impossible to avoid the #ifdefs because the driver needs to support
mach-bmips while still supporting mach-bcm63xx. I don't think they make
it too difficult to understand. Until there are device tree supporting
drivers for everything mach-bcm63xx needs, it can't be removed.

> We have some infrastructure changes in the works which will move
> the need for soft-timers from individual drivers into the watchdog core.
> Would this possibly be helpful here ? The timer-driven watchdog ping
> seems to accomplish pretty much the same.

There is no need for a software timer. This is not a timer-driven
watchdog ping, there is an unmaskable timer interrupt when the watchdog
timer has less than 50% remaining.

-- 
Simon Arlott
