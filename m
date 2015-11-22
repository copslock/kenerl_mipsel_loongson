Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 22 Nov 2015 15:03:31 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:54352 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27007233AbbKVOD3Uv33s (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sun, 22 Nov 2015 15:03:29 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=A6OUHBXe5/389OW7eqNOKUKtsY3bJ4+yMvsG84MEr/g=;
        b=EpLwM57ii/FxpksnF0dAqqoWv3PDJyQDp1+asmMPsgRl9FOx4tT2CZGFhFkwdzaPP3iXUb7e3lcEADdppUpMioRXd+d30PsQ/cfXbu84/WcKyXrCskTDMIQ1Ni/B14F/IKsXwp94lePAaejulDdvMhrLWQ7xklXp95+zt+xuyjtI2RdEqqpgYqVCLjgtggelueS63HbKib6gIluTGfnYjzJig74LkrtlJjEZ6xcCF5qt+J1nXGhtkjhCmh1P2lUxNatFWkngDcRXD5C7i6szcYT6QK7UrqUzwkg/tMJcpFCQX+wALS00CmHI7hCdlXdmF0uLVKLlab6OJivpgjAcEw==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:60487)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a0VER-0000fY-DU (Exim); Sun, 22 Nov 2015 14:03:07 +0000
Subject: Re: [PATCH 4/10] (Was: [PATCH 4/4]) MIPS: bmips: Convert bcm63xx_wdt
 to use WATCHDOG_CORE
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
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
Cc:     Rob Herring <robh+dt@kernel.org>, Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jonas Gorski <jogo@openwrt.org>
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <5651CB13.4090704@simon.arlott.org.uk>
Date:   Sun, 22 Nov 2015 14:02:59 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <56512937.6030903@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50040
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

On 22/11/15 02:32, Guenter Roeck wrote:
> On 11/21/2015 01:44 PM, Simon Arlott wrote:
>> On 21/11/15 21:32, Guenter Roeck wrote:
>>> this is really doing a bit too much in a single patch.
>>> Conversion to the watchdog infrastructure should probably be
>>> the first step, followed by further optimizations and improvements.
>>

I've split patch 4 up into 7 patches, which will be patches 4/10..10/10
in this thread.

Instead of using bcm63xx_timer_register in #ifdefs, I'll remove most of
bcm63xx_timer because it's only used by the watchdog.

>>> We have some infrastructure changes in the works which will move
>>> the need for soft-timers from individual drivers into the watchdog core.
>>> Would this possibly be helpful here ? The timer-driven watchdog ping
>>> seems to accomplish pretty much the same.
>>
>> There is no need for a software timer. This is not a timer-driven
>> watchdog ping, there is an unmaskable timer interrupt when the watchdog
>> timer has less than 50% remaining.
>>
> Ok. Maybe I got confused by the interrupt-triggered watchdog ping.
> I'll have to look into that much more closely; it is quite unusual
> and complex. The explanation is also not easy to understand.
> What does "The only way to stop this interrupt" mean ? Repeatedly

The interrupt is level triggered at less than 50% of the time remaining.
Unless the watchdog is stopped or restarted, the interrupt will not stop
occurring.

> triggering the interrupt in 1/2, 1/4, 1/8 of the remaining time is
> really odd.

It's a bit odd but there's no way to ack the interrupt. This seemed like
the best approach without adding the complexity of a software timer or
trying to mask and unmask the timer interrupt. I don't  want to ignore
the interrupt entirely because I'd like to know if the watchdog is going
to cause a reboot.

> On side note, the subject tag should be "watchdog:", not "MIPS:".

Fixed.

-- 
Simon Arlott
