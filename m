Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 12:35:29 +0200 (CEST)
Received: from eu1sys200aog117.obsmtp.com ([207.126.144.143]:41426 "EHLO
        eu1sys200aog117.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491049Ab0I1KfV convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Sep 2010 12:35:21 +0200
Received: from source ([164.129.1.35]) (using TLSv1) by eu1sys200aob117.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKHEm8qVVsRTvBOxjOfqpluw9Yg/34iF@postini.com; Tue, 28 Sep 2010 10:35:21 UTC
Received: from zeta.dmz-eu.st.com (ns2.st.com [164.129.230.9])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2B70785;
        Tue, 28 Sep 2010 10:33:15 +0000 (GMT)
Received: from relay2.stm.gmessaging.net (unknown [10.230.100.18])
        by zeta.dmz-eu.st.com (STMicroelectronics) with ESMTP id C0EA421C3;
        Tue, 28 Sep 2010 10:33:13 +0000 (GMT)
Received: from exdcvycastm003.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm003", Issuer "exdcvycastm003" (not verified))
        by relay2.stm.gmessaging.net (Postfix) with ESMTPS id 5DF71A8094;
        Tue, 28 Sep 2010 12:33:08 +0200 (CEST)
Received: from EXDCVYMBSTM006.EQ1STM.local ([10.230.100.3]) by
 exdcvycastm003.EQ1STM.local ([10.230.100.1]) with mapi; Tue, 28 Sep 2010
 12:33:13 +0200
From:   Arun MURTHY <arun.murthy@stericsson.com>
To:     Lars-Peter Clausen <lars@metafoo.de>
Cc:     "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>,
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
Date:   Tue, 28 Sep 2010 12:33:08 +0200
Subject: RE: [PATCH 4/7] pwm: Align existing pwm drivers with pwm-core driver
Thread-Topic: [PATCH 4/7] pwm: Align existing pwm drivers with pwm-core
 driver
Thread-Index: Acte9YREgVS2Eek2RwSBOuSpkmCbJgAAlbJA
Message-ID: <F45880696056844FA6A73F415B568C69532DC2FC76@EXDCVYMBSTM006.EQ1STM.local>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
 <1285659648-21409-5-git-send-email-arun.murthy@stericsson.com>
 <4CA1AE21.8070306@metafoo.de>
 <F45880696056844FA6A73F415B568C69532DC2FB98@EXDCVYMBSTM006.EQ1STM.local>
 <4CA1BF2D.2070609@metafoo.de>
In-Reply-To: <4CA1BF2D.2070609@metafoo.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 27861
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22248

> Arun MURTHY wrote:
> >>> mips-jz4740: pwm: Align with new pwm core driver
> >>>
> >>> PWM core driver has been added and has been enabled only for ARM
> >>> platform. The same can be utilised for mips also.
> >>> Please align with the pwm core driver(drivers/pwm-core.c).
> >>
> >> Is there any reason for artificially limiting it to ARM?
> >
> > No not at all, right now I have aligned all existing pwm drivers in
> ARM to make use of the pwm core driver.
> > But faced difficulty in aligning the mips-jz4740 pwm driver, without
> having much knowledge about the device/data sheet.
> > Hence I have let it to the maintainer of that driver to align and
> thereafter this limitation will be removed.
> > Have also comments the same as TODO in the driver.
> >
> 
> Ok, I'll take care of adjusting the jz4740 pwm driver once the pwm-core
> is in proper
> shape.
> But I still think it would be better to have a config symbol which
> would be selected
> by SoC code and on which PWM_CORE would depend. Then it would be
> possible for SoC
> implementation to device whether it wants to provide it's own PWM API
> implementation
> or use pwm-core.

My intention is to make it a generic pwm driver. Like the one we do to register a led class driver / backlight class driver.

> >>
> >> Why can't these changes be in the initial patch which adds pwm-core?
> >>
> > Since by default this driver is enabled, and if there is some other
> pwm driver enabled, both happen to export the same
> function(pwm_enable/pwm_disable,..) After applying the first patch
> build may fail.
> >
> I would understand that if you were just moving code around, but the
> pwm_device
> struct looks completly different now.
Yes, that's the reason, I have modified all the existing pwm drivers except the mips to align with this.
And this looks more generic.
For example the element pwm_id, dev, data in pwm_device are all specific to a device and irrespective of any number of pwm devices each and every device will require this information, hence so.

Thanks and Regards,
Arun R Murthy
-------------
