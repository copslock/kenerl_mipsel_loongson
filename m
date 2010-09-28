Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 11:07:09 +0200 (CEST)
Received: from eu1sys200aog119.obsmtp.com ([207.126.144.147]:60635 "EHLO
        eu1sys200aog119.obsmtp.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491049Ab0I1JHF convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Sep 2010 11:07:05 +0200
Received: from source ([138.198.100.35]) (using TLSv1) by eu1sys200aob119.postini.com ([207.126.147.11]) with SMTP
        ID DSNKTKGv7Yy7lkR2CLa33MjLl4mjE3rCufCM@postini.com; Tue, 28 Sep 2010 09:07:05 UTC
Received: from zeta.dmz-ap.st.com (ns6.st.com [138.198.234.13])
        by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5BF33156;
        Tue, 28 Sep 2010 09:03:37 +0000 (GMT)
Received: from relay2.stm.gmessaging.net (unknown [10.230.100.18])
        by zeta.dmz-ap.st.com (STMicroelectronics) with ESMTP id AA67D443;
        Tue, 28 Sep 2010 09:03:35 +0000 (GMT)
Received: from exdcvycastm004.EQ1STM.local (alteon-source-exch [10.230.100.61])
        (using TLSv1 with cipher RC4-MD5 (128/128 bits))
        (Client CN "exdcvycastm004", Issuer "exdcvycastm004" (not verified))
        by relay2.stm.gmessaging.net (Postfix) with ESMTPS id 539A8A8065;
        Tue, 28 Sep 2010 11:03:30 +0200 (CEST)
Received: from EXDCVYMBSTM006.EQ1STM.local ([10.230.100.3]) by
 exdcvycastm004.EQ1STM.local ([10.230.100.2]) with mapi; Tue, 28 Sep 2010
 11:03:34 +0200
From:   Arun MURTHY <arun.murthy@stericsson.com>
To:     Hemanth V <hemanthv@ti.com>
Cc:     Vasily Khoruzhick <anarsoul@gmail.com>,
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
        Linus WALLEIJ <linus.walleij@stericsson.com>,
        Mattias WALLIN <mattias.wallin@stericsson.com>
Date:   Tue, 28 Sep 2010 11:03:34 +0200
Subject: RE: [PATCH 1/7] pwm: Add pwm core driver
Thread-Topic: [PATCH 1/7] pwm: Add pwm core driver
Thread-Index: Acte6n0b5OsB6Z8wQWiCKhEEjIKoyQAALhOA
Message-ID: <F45880696056844FA6A73F415B568C69532DC2FB21@EXDCVYMBSTM006.EQ1STM.local>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
    <1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
    <201009281114.31223.anarsoul@gmail.com>
    <F45880696056844FA6A73F415B568C69532DC2FA8F@EXDCVYMBSTM006.EQ1STM.local>
 <63731.10.24.255.18.1285663815.squirrel@dbdmail.itg.ti.com>
In-Reply-To: <63731.10.24.255.18.1285663815.squirrel@dbdmail.itg.ti.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-archive-position: 27853
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: arun.murthy@stericsson.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22186

> >> On 28 of September 2010 10:40:42 Arun Murthy wrote:
> >> > The existing pwm based led and backlight driver makes use of the
> >> > pwm(include/linux/pwm.h). So all the board specific pwm drivers
> will
> >> > be exposing the same set of function name as in
> include/linux/pwm.h.
> >> > As a result build fails.
> >>
> >> Which build fails? One with multi-SoC support? Please be more
> specific.
> > Sure will add this in v2.
> >
> 
> Could you clarify for the benefit of all, which specific issues you are
> trying to address with this patch series
1. Now since all the pwm driver export same set of function(pwm_enable, pwm_disable,..), if it happens that there are two pwm driver enabled this leads to re-declaration and results in build failure. The proper way to handle this would be to have a pwm core function, and let all the pwm drivers register to the pwm core driver.
2. The above scenario also occurs in place of multi-soc environment. Lets say OMAP has a pwm module and that is being used for primary lcd backlight and twl has a backlight that is being used for controlling the charging led brightness. In this case there exists 2 pwm drivers and one pwm driver will be used by pwm_bl.c and other by leds-pwm.c

Thanks and Regards,
Arun R Murthy
-------------
