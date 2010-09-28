Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 12:43:18 +0200 (CEST)
Received: from comal.ext.ti.com ([198.47.26.152]:37341 "EHLO comal.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491958Ab0I1KnP (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Sep 2010 12:43:15 +0200
Received: from dlep35.itg.ti.com ([157.170.170.118])
        by comal.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8SAfuTh021276
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 28 Sep 2010 05:42:01 -0500
Received: from dbdmail.itg.ti.com (localhost [127.0.0.1])
        by dlep35.itg.ti.com (8.13.7/8.13.7) with ESMTP id o8SAfbiv025720;
        Tue, 28 Sep 2010 05:41:38 -0500 (CDT)
Received: from 10.24.255.18
        (SquirrelMail authenticated user x0099946);
        by dbdmail.itg.ti.com with HTTP;
        Tue, 28 Sep 2010 16:11:55 +0530 (IST)
Message-ID: <48808.10.24.255.18.1285670515.squirrel@dbdmail.itg.ti.com>
In-Reply-To: <F45880696056844FA6A73F415B568C69532DC2FBF9@EXDCVYMBSTM006.EQ1STM.loca
     l>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>   
       <1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>      
    <201009281114.31223.anarsoul@gmail.com>      
    <F45880696056844FA6A73F415B568C69532DC2FA8F@EXDCVYMBSTM006.EQ1STM.local>
       <63731.10.24.255.18.1285663815.squirrel@dbdmail.itg.ti.com>   
    <F45880696056844FA6A73F415B568C69532DC2FB21@EXDCVYMBSTM006.EQ1STM.local>
    <19145.10.24.255.18.1285666483.squirrel@dbdmail.itg.ti.com>
    <F45880696056844FA6A73F415B568C69532DC2FBF9@EXDCVYMBSTM006.EQ1STM.local>
Date:   Tue, 28 Sep 2010 16:11:55 +0530 (IST)
Subject: RE: [PATCH 1/7] pwm: Add pwm core driver
From:   "Hemanth V" <hemanthv@ti.com>
To:     "Arun MURTHY" <arun.murthy@stericsson.com>
Cc:     "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "Vasily Khoruzhick" <anarsoul@gmail.com>,
        "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>,
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
        "lars@metafoo.de" <lars@metafoo.de>,
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
        "Linus WALLEIJ" <linus.walleij@stericsson.com>,
        "Mattias WALLIN" <mattias.wallin@stericsson.com>
User-Agent: SquirrelMail/1.4.3a
X-Mailer: SquirrelMail/1.4.3a
MIME-Version: 1.0
Content-Type:   text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Priority: 3 (Normal)
Importance: Normal
X-archive-position: 27870
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: hemanthv@ti.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22273

>> >> >> On 28 of September 2010 10:40:42 Arun Murthy wrote:
>> >> >> > The existing pwm based led and backlight driver makes use of
>> the
>> >> >> > pwm(include/linux/pwm.h). So all the board specific pwm drivers
>> >> will
>> >> >> > be exposing the same set of function name as in
>> >> include/linux/pwm.h.
>> >> >> > As a result build fails.
>> >> >>
>> >> >> Which build fails? One with multi-SoC support? Please be more
>> >> specific.
>> >> > Sure will add this in v2.
>> >> >
>> >>
>> >> Could you clarify for the benefit of all, which specific issues you
>> are
>> >> trying to address with this patch series
>> > 1. Now since all the pwm driver export same set of
>> function(pwm_enable, pwm_disable,..), if it happens that there are two
>> pwm driver enabled this
>> > leads to re-declaration and results in build failure. The proper way
>> to handle this would be to have a pwm core function, and let all the
>> pwm
>> > drivers register to the pwm core driver.
>> > 2. The above scenario also occurs in place of multi-soc environment.
>> Lets say OMAP has a pwm module and that is being used for primary lcd
>> backlight
>> > and twl has a backlight that is being used for controlling the
>> charging led brightness. In this case there exists 2 pwm drivers and
>> one pwm driver
>> > will be used by pwm_bl.c and other by leds-pwm.c
>>
>> Speaking specifically of OMAP4, twl6030 supports multiple PWMs i.e for
>> display/keypad backlight, charging
>> led. But there should not be need for multiple drivers since twl6030-
>> pwm should be able to support
>> all these (currently it doesnot though). So there would single
>> pwm_enable, pwm_disable exported and driver
>> internally takes care configuring the correct PWM based on id. Would it
>> not be similar
>> situation for other hardware also.
>>
> You are right, there is only one pwm module in twl4030/twl6030 and this module might have any number or pwm's line PWM1, PWM2, PWM3 etc.
> My consideration is when you have two separate pwm modules on different soc. Its not in case of OMAP boards. But that was just an example that I
> gave.
>
> Let me be more specific, consider an environment where there is an APE and Power Management subsystem(separate IC but on same board/platform)
> APE has a pwm module and Power Management SubSystem also has pwm module. Both are part of the platform.
> Not there exists two drivers in a single platform and both of them are enabled. Building such a kernel results in re-declaration build error.
>

Is this something specific to ST chipsets or do you know of any other chips which might use this feature.

Thanks
Hemanth
