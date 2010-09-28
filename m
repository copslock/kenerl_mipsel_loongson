Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 11:58:40 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:52624 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491049Ab0I1J6g (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Sep 2010 11:58:36 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id D1B333D4;
        Tue, 28 Sep 2010 11:58:29 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id ij0ftXqtgWQz; Tue, 28 Sep 2010 11:58:28 +0200 (CEST)
Received: from [192.168.0.213] (e177160142.adsl.alicedsl.de [85.177.160.142])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id CA88B3CE;
        Tue, 28 Sep 2010 11:57:59 +0200 (CEST)
Message-ID: <4CA1BC16.3020702@metafoo.de>
Date:   Tue, 28 Sep 2010 11:57:42 +0200
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
        "dilinger@collabora.co.uk" <dilinger@collabora.co.uk>,
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
        "jic23@cam.ac.uk" <jic23@cam.ac.uk>,
        "re.emese@gmail.com" <re.emese@gmail.com>,
        "linux@simtec.co.uk" <linux@simtec.co.uk>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        Linus WALLEIJ <linus.walleij@stericsson.com>,
        Mattias WALLIN <mattias.wallin@stericsson.com>
Subject: Re: [PATCH 1/7] pwm: Add pwm core driver
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com> <1285659648-21409-2-git-send-email-arun.murthy@stericsson.com> <4CA1AD2B.8000905@metafoo.de> <F45880696056844FA6A73F415B568C69532DC2FB6B@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <F45880696056844FA6A73F415B568C69532DC2FB6B@EXDCVYMBSTM006.EQ1STM.local>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 27858
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22226

Arun MURTHY wrote:
>>> +menuconfig PWM_DEVICES
>>> +	bool "PWM devices"
>>> +	default y
>>> +	---help---
>>> +	  Say Y here to get to see options for device drivers from
>> various
>>> +	  different categories. This option alone does not add any kernel
>> code.
>>> +
>>> +	  If you say N, all options in this submenu will be skipped and
>> disabled.
>>> +
>> Shouldn't PWM_DEVICES select HAVE_PWM?
> 
> 
> No not required, the entire concept is to remove HAVE_PWM and use PWM_CORE.

Well in patch 4 you say that PWM_CORE is currently limited to ARM. Furthermore you
change the pwm-backlight and pwm-led Kconfig entries to depend on HAVE_PWM ||
PWM_CORE. Adding a select HAVE_PWM here would make those changes unnecessary.
HAVE_PWM should be set, when pwm_* functions are available. When your pwm-core driver
is selected they are available.

> 
>>> +struct pwm_dev_info {
>>> +	struct pwm_device *pwm_dev;
>>> +	struct list_head list;
>>> +};
>>> +static struct pwm_dev_info *di;
>> Why not embed the list head into pwm_device. That would certainly make
>> pwm_device_unregister much simpler.
> pwm_device will be passed to each and every pwm driver that are registered as client with pwm core.
> The list consists of the registered pwm drivers and is to be handled by pwm core.
> Why should each and every pwm driver get to know about the entire pwm driver list?
Declare the list field to be private, by saying that it should only be touched by the
core. Right now you allocate a rather small additional structure for each registered
device. This could be easily be avoided by embedding the list field into the
pwm_device struct.

> And also since the pwm_request/register/unregister are the one which require this list having this list inst in local/static device information structure seems to be right.
> 
>>> +	}
>>> +	pwm->pwm_dev = pwm_dev;
>>> +	list_add_tail(&pwm->list, &di->list);
>>> +	up_write(&pwm_list_lock);
>>> +
>> I guess you only need to lock the list when accessing the list and
>> adding the new
>> pwm_dev.
> 
> Oops, thanks for pointing out, will implement this in the v2 patch.
>>> +struct pwm_ops {
>>> +	int (*pwm_config)(struct pwm_device *pwm, int duty_ns, int
>> period_ns);
>>> +	int (*pwm_enable)(struct pwm_device *pwm);
>>> +	int (*pwm_disable)(struct pwm_device *pwm);
>>> +	char *name;
>>> +};
>>> +
>> Shouldn't name be part of the pwm_device? That would allow the ops to
>> be shared
>> between different devices.
> Good catch, the reason being that 2 or more devices can share the same ops and get registered to pwm core.
> But the catch lies while identifying the pwm device while the clients are requesting for.
> The pwm backlight will request the pwm driver by name. This is parameter that distinguishes among different pwm devices irrespective of same ops or not.
Yes. And thats why it should go into the pwm_device struct itself.

If an additional ops struct is allocated for each device anyway we would be better of
embedding it directly into the device struct instead of just holding a pointer to it.

> 
>>> +int pwm_device_register(struct pwm_device *pwm_dev);
>>> +int pwm_device_unregister(struct pwm_device *pwm_dev);
>>> +
>>>  #endif /* __LINUX_PWM_H */
>> It might be also a good idea to add a device class for pwm devices.
> Sure, but can you please explain with an example the use case.
>
Well, for one it helps to keep data structured.
And there would be functions to traverse all devices of a class, so you could get rid
of your "di" list.


> Thanks and Regards,
> Arun R Murthy
> -------------
> 

- Lars
