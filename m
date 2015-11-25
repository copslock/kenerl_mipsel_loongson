Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 15:10:30 +0100 (CET)
Received: from bh-25.webhostbox.net ([208.91.199.152]:57040 "EHLO
        bh-25.webhostbox.net" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012825AbbKYOK2Zwrlw (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 25 Nov 2015 15:10:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=roeck-us.net; s=default;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=W8+S+9kJ3glkBX67SDrjgAcz8RJawiNISv5O5Z/kpSY=;
        b=nyWV0SFydS/8vg7+q6m1iNIbHqWxXbQZa2Ze7k5OQ5ORZfZRWeHqRqyfakNO3qAdbfvQEmdhpNffW4Wtjt1+0NZozV/zl6MLDQADNIjlcO8zz/s4PLXWuiyd3oUd4HxFRRpHiNp53bSW8B4/Le9ZvZcnCMn/0mq75do6YMR6T0c=;
Received: from 108-223-40-66.lightspeed.sntcca.sbcglobal.net ([108.223.40.66]:41123 helo=server.roeck-us.net)
        by bh-25.webhostbox.net with esmtpsa (TLSv1:DHE-RSA-AES128-SHA:128)
        (Exim 4.85)
        (envelope-from <linux@roeck-us.net>)
        id 1a1amC-004JKq-NP; Wed, 25 Nov 2015 14:10:28 +0000
Subject: Re: [PATCH 5/10] watchdog: bcm63xx_wdt: Use WATCHDOG_CORE
To:     Simon Arlott <simon@fire.lp0.eu>
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk> <5651CBF0.30904@simon.arlott.org.uk>
 <56552099.7070709@roeck-us.net>
 <726719450643bb69683224d731b582b0df27fe1f@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
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
        linux-mips@linux-mips.org, linux-watchdog@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Pawel Moll <pawel.moll@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ian Campbell <ijc+devicetree@hellion.org.uk>,
        Kumar Gala <galak@codeaurora.org>,
        Jonas Gorski <jogo@openwrt.org>
From:   Guenter Roeck <linux@roeck-us.net>
Message-ID: <5655C149.5010008@roeck-us.net>
Date:   Wed, 25 Nov 2015 06:10:17 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <726719450643bb69683224d731b582b0df27fe1f@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Authenticated_sender: linux@roeck-us.net
X-OutGoing-Spam-Status: No, score=-1.0
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - bh-25.webhostbox.net
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - roeck-us.net
X-Get-Message-Sender-Via: bh-25.webhostbox.net: authenticated_id: linux@roeck-us.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <linux@roeck-us.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50106
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

On 11/25/2015 05:02 AM, Simon Arlott wrote:
> On Wed, November 25, 2015 02:44, Guenter Roeck wrote:
>> The "running" flag should no longer be needed. watchdog_active()
>> should provide that information.
>
> I'm going to need to keep that because I need to know if it's running
> in the interrupt handler, and wdd->lock is a mutex.
>
>>> @@ -306,17 +202,18 @@ unregister_timer:
>>>
>>>    static int bcm63xx_wdt_remove(struct platform_device *pdev)
>>>    {
>>> -	if (!nowayout)
>>> -		bcm63xx_wdt_hw_stop();
>>> +	struct watchdog_device *wdd = platform_get_drvdata(pdev);
>>>
>>> -	misc_deregister(&bcm63xx_wdt_miscdev);
>>>    	bcm63xx_timer_unregister(TIMER_WDT_ID);
>>> +	watchdog_unregister_device(wdd);
>>
>> Shouldn't that come first, before unregistering the timer ?
>
> No, because wdd->dev is used in the interrupt handler. I will have to
> move registration of the interrupt to after creating the watchdog
> because it could currently be used before wdd->dev is set.
>

Does unregistering the timer disable the interrupt ?

Thanks,
Guenter
