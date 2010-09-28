Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 19:46:12 +0200 (CEST)
Received: from opensource.wolfsonmicro.com ([80.75.67.52]:55057 "EHLO
        opensource2.wolfsonmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491139Ab0I1RqJ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Sep 2010 19:46:09 +0200
Received: from finisterre.wolfsonmicro.main (216-75-233-70.static.wiline.com [216.75.233.70])
        by opensource2.wolfsonmicro.com (Postfix) with ESMTPSA id 9B79F114727;
        Tue, 28 Sep 2010 18:45:59 +0100 (BST)
Received: from broonie by finisterre.wolfsonmicro.main with local (Exim 4.72)
        (envelope-from <broonie@opensource.wolfsonmicro.com>)
        id 1P0eFu-00030H-90; Tue, 28 Sep 2010 10:46:18 -0700
Date:   Tue, 28 Sep 2010 10:46:18 -0700
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
        linus.walleij@stericsson.com, mattias.wallin@stericsson.com,
        Bill Gatliff <bgat@billgatliff.com>
Subject: Re: [PATCH 1/7] pwm: Add pwm core driver
Message-ID: <20100928174617.GE10739@opensource.wolfsonmicro.com>
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com>
 <1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1285659648-21409-2-git-send-email-arun.murthy@stericsson.com>
X-Cookie: Excellent day to have a rotten day.
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27879
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: broonie@opensource.wolfsonmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22616

On Tue, Sep 28, 2010 at 01:10:42PM +0530, Arun Murthy wrote:

> The existing pwm based led and backlight driver makes use of the
> pwm(include/linux/pwm.h). So all the board specific pwm drivers will
> be exposing the same set of function name as in include/linux/pwm.h.
> As a result build fails.

As others have said it's *really* not clear what the problem is here...

Please also take a look at the work which Bill Gatliff was doing on a
similar PWM core API and the resulting discussion - how does your code
differ from his, and is any of the feedback on his proposal relevant to
yours?

> +void __deprecated pwm_free(struct pwm_device *pwm)
> +{
> +}
> +

Shouldn't this either be an inline function directly in the header or
exported?

> +int pwm_config(struct pwm_device *pwm, int duty_ns, int period_ns)
> +{
> +	return pwm->pops->pwm_config(pwm, duty_ns, period_ns);
> +}
> +EXPORT_SYMBOL(pwm_config);

I'd expect some handling of fixed function PWMs (though I'd expect those
to be rare).

> +	down_write(&pwm_list_lock);
> +	pwm = kzalloc(sizeof(struct pwm_dev_info), GFP_KERNEL);
> +	if (!pwm) {
> +		up_write(&pwm_list_lock);
> +		return -ENOMEM;
> +	}

No need to take the lock until the allocation succeeded.

> +static int __init pwm_init(void)
> +{
> +	struct pwm_dev_info *pwm;
> +
> +	pwm = kzalloc(sizeof(struct pwm_dev_info), GFP_KERNEL);
> +	if (!pwm)
> +		return -ENOMEM;
> +	INIT_LIST_HEAD(&pwm->list);
> +	di = pwm;
> +	return 0;

Why not just use static data for the list head?

> +subsys_initcall(pwm_init);
> +module_exit(pwm_exit);

Usually these are located next to the functions.
