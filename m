Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 25 Nov 2015 20:44:19 +0100 (CET)
Received: from proxima.lp0.eu ([81.2.80.65]:53467 "EHLO proxima.lp0.eu"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S27012581AbbKYToQQurjp (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Wed, 25 Nov 2015 20:44:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=fire.lp0.eu; s=exim;
        h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:Cc:References:To:Subject; bh=xLLUzsQBNUs5hj67mN3N0doPEpHFyRDlbmliVjMgLH4=;
        b=fC4CpKc+ruzMPwvIs879fkzjKMbViEY1jbmLey5329HDm5bTFYeZrmFfy3UhIxqq1ogLrjN7+e43Qfg/edZEfEXVXwpNuFVjIjMUM/rw4As6m4MiJxewh9K9454XGMWzD600R8aqM6sXsxviBW9KOWmPkmqlUYyhmVT9WSAlTHFXjkLpE6ZzKX6jbMkE9ojr675nycITys8Bs2KODWb2vBVORK+D0mYWzLKdIpIzEWK2t/HYF9Z5py1WXb4QBNo8fNz0Ek3c+uMqbgT6C8t6hknk03W38Wwj6Fa1YgHN3XPMlTAWKb7LzrDevv6eaRi3iRfbwhvdYcbNQ118ZqGFhA==;
Received: from redrum.lp0.eu ([2001:8b0:ffea:0:2e0:81ff:fe4d:2bec]:44472)
        by proxima.lp0.eu ([2001:8b0:ffea:0:205:b4ff:fe12:530]:465)
        with esmtpsav (UNKNOWN:DHE-RSA-AES256-SHA:256/CN=Simon Arlott)
        id 1a1fyq-0004JC-Jm (Exim); Wed, 25 Nov 2015 19:43:53 +0000
Subject: Re: [PATCH 5/10] watchdog: bcm63xx_wdt: Use WATCHDOG_CORE
To:     Guenter Roeck <linux@roeck-us.net>
References: <5650BFD6.5030700@simon.arlott.org.uk>
 <5650C08C.6090300@simon.arlott.org.uk> <5650E2FA.6090408@roeck-us.net>
 <5650E5BB.6020404@simon.arlott.org.uk> <56512937.6030903@roeck-us.net>
 <5651CB13.4090704@simon.arlott.org.uk> <5651CBF0.30904@simon.arlott.org.uk>
 <56552099.7070709@roeck-us.net>
 <726719450643bb69683224d731b582b0df27fe1f@8b5064a13e22126c1b9329f0dc35b8915774b7c3.invalid>
 <5655C149.5010008@roeck-us.net>
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
From:   Simon Arlott <simon@fire.lp0.eu>
Message-ID: <56560F76.60000@simon.arlott.org.uk>
Date:   Wed, 25 Nov 2015 19:43:50 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <5655C149.5010008@roeck-us.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-Path: <simon@fire.lp0.eu>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50113
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

On 25/11/15 14:10, Guenter Roeck wrote:
> On 11/25/2015 05:02 AM, Simon Arlott wrote:
>> On Wed, November 25, 2015 02:44, Guenter Roeck wrote:
>>> The "running" flag should no longer be needed. watchdog_active()
>>> should provide that information.
>>
>> I'm going to need to keep that because I need to know if it's running
>> in the interrupt handler, and wdd->lock is a mutex.
>>
>>>> @@ -306,17 +202,18 @@ unregister_timer:
>>>>
>>>>    static int bcm63xx_wdt_remove(struct platform_device *pdev)
>>>>    {
>>>> -	if (!nowayout)
>>>> -		bcm63xx_wdt_hw_stop();
>>>> +	struct watchdog_device *wdd = platform_get_drvdata(pdev);
>>>>
>>>> -	misc_deregister(&bcm63xx_wdt_miscdev);
>>>>    	bcm63xx_timer_unregister(TIMER_WDT_ID);
>>>> +	watchdog_unregister_device(wdd);
>>>
>>> Shouldn't that come first, before unregistering the timer ?
>>
>> No, because wdd->dev is used in the interrupt handler. I will have to
>> move registration of the interrupt to after creating the watchdog
>> because it could currently be used before wdd->dev is set.
>>
> 
> Does unregistering the timer disable the interrupt ?

No, it sets the callback for that timer to NULL so that it won't be
called.

-- 
Simon Arlott
