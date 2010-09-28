Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 12:11:34 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:53658 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491049Ab0I1KLb (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Sep 2010 12:11:31 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id DA42F48D;
        Tue, 28 Sep 2010 12:11:23 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id VqGlauhtW-yL; Tue, 28 Sep 2010 12:11:22 +0200 (CEST)
Received: from [192.168.0.213] (e177160142.adsl.alicedsl.de [85.177.160.142])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id 9767B48A;
        Tue, 28 Sep 2010 12:11:11 +0200 (CEST)
Message-ID: <4CA1BF2D.2070609@metafoo.de>
Date:   Tue, 28 Sep 2010 12:10:53 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Arun MURTHY <arun.murthy@stericsson.com>
CC:     "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>,
        "linux@arm.linux.org.uk" <linux@arm.linux.org.uk>,
        "grinberg@compulab.co.il" <grinberg@compulab.co.il>,
        "mike@compulab.co.il" <mike@compulab.co.il>,
        "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "drwyrm@gmail.com" <drwyrm@gmail.com>,
        "stefan@openezx.org" <stefan@openezx.org>,
        "laforge@openezx.org" <laforge@openezx.org>,
        "ospite@studenti.unina.it" <ospite@studenti.unina.it>,
        "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>,
        "mad_soft@inbox.ru" <mad_soft@inbox.ru>,
        "maz@misterjones.org" <maz@misterjones.org>,
        "daniel@caiaq.de" <daniel@caiaq.de>,
        "haojian.zhuang@marvell.com" <haojian.zhuang@marvell.com>,
        "timur@freescale.com" <timur@freescale.com>,
        "ben-linux@fluff.org" <ben-linux@fluff.org>,
        "support@simtec.co.uk" <support@simtec.co.uk>,
        "arnaud.patard@rtp-net.org" <arnaud.patard@rtp-net.org>,
        "dgreenday@gmail.com" <dgreenday@gmail.com>,
        "anarsoul@gmail.com" <anarsoul@gmail.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "mcuelenaere@gmail.com" <mcuelenaere@gmail.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "andre.goddard@gmail.com" <andre.goddard@gmail.com>,
        "jkosina@suse.cz" <jkosina@suse.cz>,
        "tj@kernel.org" <tj@kernel.org>,
        "hsweeten@visionengravers.com" <hsweeten@visionengravers.com>,
        "u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
        "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
        "ralf@linux-mips.org" <ralf@linux-mips.org>,
        "mroth@nessie.de" <mroth@nessie.de>,
        "randy.dunlap@oracle.com" <randy.dunlap@oracle.com>,
        "lethal@linux-sh.org" <lethal@linux-sh.org>,
        "rusty@rustcorp.com.au" <rusty@rustcorp.com.au>,
        "damm@opensource.se" <damm@opensource.se>,
        "mst@redhat.com" <mst@redhat.com>,
        "rpurdie@rpsys.net" <rpurdie@rpsys.net>,
        "sguinot@lacie.co" <sguinot@lacie.co>,
        "sameo@linux.intel.com" <sameo@linux.intel.com>,
        "broonie@opensource.wolfsonmicro.com" 
        <broonie@opensource.wolfsonmicro.com>,
        "balajitk@ti.com" <balajitk@ti.com>,
        "rnayak@ti.com" <rnayak@ti.com>,
        "santosh.shilimkar@ti.com" <santosh.shilimkar@ti.com>,
        "hemanthv@ti.com" <hemanthv@ti.com>,
        "michael.hennerich@analog.com" <michael.hennerich@analog.com>,
        "vapier@gentoo.org" <vapier@gentoo.org>,
        "khali@linux-fr.org" <khali@linux-fr.org>,
        "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
        "re.emese@gmail.com" <re.emese@gmail.com>,
        "linux@simtec.co.uk" <linux@simtec.co.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Linus WALLEIJ <linus.walleij@stericsson.com>,
        Mattias WALLIN <mattias.wallin@stericsson.com>
Subject: Re: [PATCH 4/7] pwm: Align existing pwm drivers with pwm-core driver
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com> <1285659648-21409-5-git-send-email-arun.murthy@stericsson.com> <4CA1AE21.8070306@metafoo.de> <F45880696056844FA6A73F415B568C69532DC2FB98@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <F45880696056844FA6A73F415B568C69532DC2FB98@EXDCVYMBSTM006.EQ1STM.local>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 27859
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22230

Arun MURTHY wrote:
>>> mips-jz4740: pwm: Align with new pwm core driver
>>>
>>> PWM core driver has been added and has been enabled only for ARM
>>> platform. The same can be utilised for mips also.
>>> Please align with the pwm core driver(drivers/pwm-core.c).
>>
>> Is there any reason for artificially limiting it to ARM?
> 
> No not at all, right now I have aligned all existing pwm drivers in ARM to make use of the pwm core driver.
> But faced difficulty in aligning the mips-jz4740 pwm driver, without having much knowledge about the device/data sheet.
> Hence I have let it to the maintainer of that driver to align and thereafter this limitation will be removed.
> Have also comments the same as TODO in the driver.
> 

Ok, I'll take care of adjusting the jz4740 pwm driver once the pwm-core is in proper
shape.
But I still think it would be better to have a config symbol which would be selected
by SoC code and on which PWM_CORE would depend. Then it would be possible for SoC
implementation to device whether it wants to provide it's own PWM API implementation
or use pwm-core.

>>> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
>>> index 5d10106..a88640c 100644
>>> --- a/drivers/pwm/Kconfig
>>> +++ b/drivers/pwm/Kconfig
>>> @@ -4,6 +4,7 @@
>>>
>>>  menuconfig PWM_DEVICES
>>>  	bool "PWM devices"
>>> +	depends on ARM
>>>  	default y
>>>  	---help---
>>>  	  Say Y here to get to see options for device drivers from
>> various
>>> diff --git a/drivers/pwm/pwm-core.c b/drivers/pwm/pwm-core.c
>>> index b84027a..3a0d426 100644
>>
>>
>> Why can't these changes be in the initial patch which adds pwm-core?
>>
> Since by default this driver is enabled, and if there is some other pwm driver enabled, both happen to export the same function(pwm_enable/pwm_disable,..) After applying the first patch build may fail.
> 
I would understand that if you were just moving code around, but the pwm_device
struct looks completly different now.


> Thanks and Regards,
> Arun R Murthy
> -------------
> 
