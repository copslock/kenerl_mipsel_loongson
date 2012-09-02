Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Sep 2012 22:22:53 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:57651 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1903299Ab2IBUWr (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Sep 2012 22:22:47 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id 7CE08FA3;
        Sun,  2 Sep 2012 22:22:37 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id 3nDQm1eJTp0w; Sun,  2 Sep 2012 22:22:36 +0200 (CEST)
Received: from [192.168.178.21] (ppp-88-217-76-199.dynamic.mnet-online.de [88.217.76.199])
        (using TLSv1 with cipher DHE-RSA-CAMELLIA256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 14AF5F9B;
        Sun,  2 Sep 2012 22:22:18 +0200 (CEST)
Message-ID: <5043C005.8060907@metafoo.de>
Date:   Sun, 02 Sep 2012 22:22:29 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.16) Gecko/20120724 Icedove/3.0.11
MIME-Version: 1.0
To:     Thierry Reding <thierry.reding@avionic-design.de>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Antony Pavlov <antonynpavlov@gmail.com>,
        Maarten ter Huurne <maarten@treewalker.org>
Subject: Re: [PATCH 3/3] pwm: Add Ingenic JZ4740 support
References: <1346579550-5990-1-git-send-email-thierry.reding@avionic-design.de> <1346579550-5990-4-git-send-email-thierry.reding@avionic-design.de> <504370BF.6090702@metafoo.de> <20120902195917.GB10930@avionic-0098.mockup.avionic-design.de>
In-Reply-To: <20120902195917.GB10930@avionic-0098.mockup.avionic-design.de>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 34407
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
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
Return-Path: <linux-mips-bounce@linux-mips.org>

On 09/02/2012 09:59 PM, Thierry Reding wrote:
>>> +	is_enabled = jz4740_timer_is_enabled(pwm->hwpwm);
>>> +	if (is_enabled)
>>> +		pwm_disable(pwm);
>>
>> I think this should be jz4740_pwm_disable
>>
>>> +
>>> +	jz4740_timer_set_count(pwm->hwpwm, 0);
>>> +	jz4740_timer_set_duty(pwm->hwpwm, duty);
>>> +	jz4740_timer_set_period(pwm->hwpwm, period);
>>> +
>>> +	ctrl = JZ_TIMER_CTRL_PRESCALER(prescaler) | JZ_TIMER_CTRL_SRC_EXT |
>>> +		JZ_TIMER_CTRL_PWM_ABBRUPT_SHUTDOWN;
>>> +
>>> +	jz4740_timer_set_ctrl(pwm->hwpwm, ctrl);
>>> +
>>> +	if (is_enabled)
>>> +		pwm_enable(pwm);
>>
>> and jz4740_pwm_enable here.
> 
> I wonder if this is actually required here. Can the timer really not be
> reprogrammed while enabled?
>

It can, but we've observed this to cause permanent glitches until the timer is
reprogrammed again.

>>> +{
>>> +	struct jz4740_pwm_chip *jz4740 = platform_get_drvdata(pdev);
>>> +	int ret;
>>> +
>>> +	ret = pwmchip_remove(&jz4740->chip);
>>> +	if (ret < 0)
>>> +		return ret;
>>
>> remove is not really allowed to fail, the return value is never really tested
>> and the device is removed nevertheless. But this seems to be a problem with the
>> PWM API. It should be possible to remove a PWM chip even if it is currently in
>> use and after a PWM chip has been removed all calls to a pwm_device of that
>> chip it should return an error. This will require reference counting for the
>> pwm_device struct though. E.g. by adding a 'struct device' to it.
> 
> I beg to differ. It shouldn't be possible to remove a PWM chip that
> provides requested PWM devices. All other drivers do the same here.

Part of the Linux device driver model is that that a device may appear or
disappear at any given time (if the kernel has been compiled with
CONFIG_HOTPLUG). So you can't prevent removal. The fact that the remove
callback function return an int is kind of misleading and should probably be
fixed at some point. The return value is never checked and the device will be
removed nevertheless. So the PWM subsystem must cope with the case where the
PWM chip is removed while some of its pwm_devices are still in use.

[...]
>>
>>> +};
>>> +module_platform_driver(jz4740_pwm_driver);
>>
>> MODULE_LICENSE(...), MODULE_AUTHOR(...), MODULE_DESCRIPTION(...), MODULE_ALIAS(...)
> 
> Those weren't present previously. I suppose they should be "GPL", you,
> "Ingenic JZ4740 PWM driver" and "platform:jz4740-pwm", respectively?

Yes, sounds good. The old code couldn't be build as a module, so these were not
necessary previously.
