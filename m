Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 19:47:37 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55085 "EHLO
        opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491139Ab0I1Rre (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Sep 2010 19:47:34 +0200
Received: from finisterre.wolfsonmicro.main (216-75-233-70.static.wiline.com [216.75.233.70])
        by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id 9A6D111472C;
        Tue, 28 Sep 2010 18:47:26 +0100 (BST)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.72)
        (envelope-from <broonie@opensource.wolfsonmicro.com>)
        id 1P0eHJ-00030N-9H; Tue, 28 Sep 2010 10:47:45 -0700
Date:   Tue, 28 Sep 2010 10:47:45 -0700
From:   Mark Brown <broonie@opensource.wolfsonmicro.com>
To:     Arun Murthy <arun.murthy@stericsson.com>
Cc:     eric.y.miao@gmail.com, linux@arm.linux.org.uk,
        grinberg@compulab.co.il, mike@compulab.co.il,
        robert.jarzmik@free.fr, marek.vasut@gmail.com, drwyrm@gmail.com,
        stefan@openezx.org, laforge@openezx.org, ospite@studenti.unina.it,
        philipp.zabel@gmail.com, mad_soft@inbox.ru, maz@misterjones.org,
        daniel@caiaq.de, haojian.zhuang@marvell.com, timur@freescale.com,
        ben-linux@fluff.org, support@simtec.co.uk,
        arnaud.patard@rtp-net.org, dgreenday@gmail.com, anarsoul@gmail.com,
        akpm@linux-foundation.org, mcuelenaere@gmail.com,
        kernel@pengutronix.de, andre.goddard@gmail.com, jkosina@suse.cz,
        tj@kernel.org, hsweeten@visionengravers.com,
        u.kleine-koenig@pengutronix.de, kgene.kim@samsung.com,
        ralf@linux-mips.org, lars@metafoo.de, dilinger@collabora.co.uk,
        mroth@nessie.de, randy.dunlap@oracle.com, lethal@linux-sh.org,
        rusty@rustcorp.com.au, damm@opensource.se, mst@redhat.com,
        rpurdie@rpsys.net, sguinot@lacie.co, sameo@linux.intel.com,
        balajitk@ti.com, rnayak@ti.com, santosh.shilimkar@ti.com,
        hemanthv@ti.com, michael.hennerich@analog.com, vapier@gentoo.org,
        khali@linux-fr.org, jic23@cam.ac.uk, re.emese@gmail.com,
        linux@simtec.co.uk, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        linus.walleij@stericsson.com, mattias.wallin@stericsson.com
Subject: Re: [PATCH 2/7] backlight:pwm: add an element 'name' to platform
 data
Message-ID: <20100928174744.GF10739@opensource.wolfsonmicro.com>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
 <1285659648-21409-3-git-send-email-arun.murthy@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1285659648-21409-3-git-send-email-arun.murthy@stericsson.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27880
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22617

On Tue, Sep 28, 2010 at 01:10:43PM +0530, Arun Murthy wrote:
> A new element 'name' is added to pwm backlight platform data structure.
> This is required to identify the pwm device.

> -	pb->pwm = pwm_request(data->pwm_id, "backlight");
> +	if (!data->name)
> +		data->name = "backlight";
> +	pb->pwm = pwm_request(data->pwm_id, data->name);

If we're going to go through and require that all PWM API users be
updated to take platform data for the name might it not be better to
switch over to the clock API style request by device interface?
