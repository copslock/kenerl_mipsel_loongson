Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 09:17:34 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:37104 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27006588AbbKYIRbxr60p (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2015 09:17:31 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=HA7G9dAUmpuknYFGGhaBDtRDcZ5UFv7jlgvAPqu1SnQ=;
        b=s0TebOdw01ta/p61WGj/X42po4lL0dlWNCMZARgRjZpBjklyGW/RB+Yk3sIPLjTW3I18fHlicheE4BA/V0MAGoO1b+9L6RwwQyYfDDUFgDV6ayD+bonEWNex4dOBd5w+95Ppyyu8NcS/2UChcyRkOhe/lwfuH1N7cL6TqBCKvyJJdDpR+P9vO4D8Ujxe7Otkh5dZIYLLiAYcQeU7/VqANH9oyKJSHFXuApAb6v4PKcngRPw+OOLOcgKCg0a/CeDsnyNXNsjiQ9EdiwoCgENONWvasXm40rtHSmfKR8jvRcqM/XtYU7kdvS2msFerfxhYEGo45RUBt4Y74lhqfLP/Zw==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:43341 ident=simon)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a1VGJ-0006y0-Ds (Exim); Wed, 25 Nov 2015 08:17:12 +0000
Subject: Re: [PATCH (v2) 7/10] watchdog: bcm63xx_wdt: Add get_timeleft
 function
To:     Guenter Roeck <linux@roeck-us.net>, linux-watchdog@vger.kernel.org
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk> <5651CC90.7090402@simon.arlott.org.uk>
 <a1461a17c94353f38316d2c6ae04d6b77c91bfd4@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <56552214.2050808@roeck-us.net>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Kevin Cernekee <cernekee@gmail.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Wim Van Sebroeck <wim@iguana.be>,
        Maxime Bizon <mbizon@freebox.fr>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jonas Gorski <jogo@openwrt.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <56556E84.50202@simon.arlott.org.uk>
Date:   Wed, 25 Nov 2015 08:17:08 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <56552214.2050808@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50079
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

On 25/11/15 02:51, Guenter Roeck wrote:
> On 11/24/2015 02:15 PM, Simon Arlott wrote:
>> Return the remaining time from the hardware control register.
>>
>> Warn when the device is registered if the hardware watchdog is currently
>> running and report the remaining time left.
> 
> This is really two logical changes, isn't it ?

If you insist then I'll split it out into yet another patch.

> Nice trick to figure out if the watchdog is running.
> 
> What is the impact ? Will this result in interrupts ?

Yes, if it is running it will receive interrupts and check hw->running
to determine if it should stop the watchdog or not.

> If so, would it make sense to _not_ reset the system after a timeout
> in this case, but to keep pinging the watchdog while the watchdog device
> is not open ?

As the whole point of a hardware watchdog is to reset the system when
there is a problem with the software, it should not be automatically
reset by the driver on startup. If the watchdog is already running then
it needs to be pinged by userspace before the timeout.

The bootloader (CFE) doesn't leave the watchdog running. On my system I
prepend some code before vmlinuz that starts it running at the maximum
timeout.

A module parameter could be added to automatically ping/stop it if it's
running, but this should be in the watchdog core and not an individual
driver.

-- 
Simon Arlott
