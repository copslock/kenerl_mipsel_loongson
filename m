Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 14:02:21 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:43478 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012702AbbKYNCTeaJiy (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2015 14:02:19 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Cc:To:From:Subject:Date:References:In-Reply-To:Message-ID; bh=P+Z05xNzgMDnQ6PEYUfqfgIRsQ/8gu/gnSgEcpUH87Y=;
        b=keRxjO9mRR4rTzFLHfVdrl1iycKuP+BZBKHgFdqZoez4+4s0e/crv1GfbLUf3OSYhCBTBKCBYFIJpUJ5C4tkOx149OT0L6JqeKuMXEVrCZphv1TOKgaSE1ONym3WIVZsljwN/BEmR7MlCif1vzHklmc2h5PuJZH2GXfpyfELOtLjxAZmiedJPtSMXE62t2GJR4YfhBT5sKCWGAAASs6OvsZaYjK91E7n5WwWfY8jzAzYiJib0V+TU7j5VcGEvsRk24wzAr2vD1k+NtHewfQk1d5UTVPZZmafsBRJfGad6OkBN9eQ+Bftc3fiId6sWZaBah/yZ2gSLWElmNkB8s3JMQ==;
Received: from lp0_webmail by proxima.lp0.eu with local 
        id 1a1Zi6-0005FL-K9 (Exim); Wed, 25 Nov 2015 13:02:11 +0000
Received: from simon by proxima.lp0.eu with https;
        Wed, 25 Nov 2015 13:02:10 -0000
Message-ID: <726719450643bb69683224d731b582b0df27fe1f@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
In-Reply-To: <56552099.7070709@roeck-us.net>
References: <5650BFD6.5030700@simon.arlott.org.uk>
    <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
    <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
    <5651CB13.4090704@simon.arlott.org.uk>
    <5651CBF0.30904@simon.arlott.org.uk> <56552099.7070709@roeck-us.net>
Date:   Wed, 25 Nov 2015 13:02:10 -0000
Subject: Re: [PATCH 5/10] watchdog: bcm63xx_wdt: Use WATCHDOG_CORE
From:   "Simon Arlott" <simon@fire.lp0.eu>
To:     "Guenter Roeck" <linux@roeck-us.net>
Cc:     "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "Ralf Baechle" <ralf@linux-mips.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Jason Cooper" <jason@lakedaemon.net>,
        "Marc Zyngier" <marc.zyngier@arm.com>,
        "Kevin Cernekee" <cernekee@gmail.com>,
        "Florian Fainelli" <f.fainelli@gmail.com>,
        "Wim Van Sebroeck" <wim@iguana.be>,
        "Maxime Bizon" <mbizon@freebox.fr>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        "Rob Herring" <robh+dt@kernel.org>,
        "Pawel Moll" <pawel.moll@arm.com>,
        "Mark Rutland" <mark.rutland@arm.com>,
        "Ian Campbell" <ijc+devicetree@hellion.org.uk>,
        "Kumar Gala" <galak@codeaurora.org>,
        "Jonas Gorski" <jogo@openwrt.org>
User-Agent: SquirrelMail/1.4.22
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Priority: 3 (Normal)
Importance: Normal
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50105
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

On Wed, November 25, 2015 02:44, Guenter Roeck wrote:
> The "running" flag should no longer be needed. watchdog_active()
> should provide that information.

I'm going to need to keep that because I need to know if it's running
in the interrupt handler, and wdd->lock is a mutex.

>> @@ -306,17 +202,18 @@ unregister_timer:
>>
>>   static int bcm63xx_wdt_remove(struct platform_device *pdev)
>>   {
>> -	if (!nowayout)
>> -		bcm63xx_wdt_hw_stop();
>> +	struct watchdog_device *wdd = platform_get_drvdata(pdev);
>>
>> -	misc_deregister(&bcm63xx_wdt_miscdev);
>>   	bcm63xx_timer_unregister(TIMER_WDT_ID);
>> +	watchdog_unregister_device(wdd);
>
> Shouldn't that come first, before unregistering the timer ?

No, because wdd->dev is used in the interrupt handler. I will have to
move registration of the interrupt to after creating the watchdog
because it could currently be used before wdd->dev is set.

-- 
Simon Arlott
