Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 10:48:55 +0200 (CEST)
Received: from mail-bw0-f49.google.com ([209.85.214.49]:52191 "EHLO
        mail-bw0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491049Ab0I1Isv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Sep 2010 10:48:51 +0200
Received: by bwz19 with SMTP id 19so5478521bwz.36
        for <multiple recipients>; Tue, 28 Sep 2010 01:48:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:message-id;
        bh=AncmpYgrnyE5ZzhwIYTiD8W4S54tK6jVhT0VurwK03U=;
        b=egQi47Dnb+cOCXShsZFNC59fUNumHJQ3tZ16Jf506IMEGiFAZckqM4SNhmQ5gw6Af5
         LEC13f/Psmw/stfscOSwDBvqZZuWEF8TAPVQkfjJp0lAQ8EvJQinEW2fZSZZUEYVBJbV
         cZ9AG8BrLSHE+aBZh6+qCiE4jQYpFnQNVo7wc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding:message-id;
        b=MgUBfxusFExesGK51bfp/L1rOsx5WqvkneUrpzKRLoxNi08Xmpm/ZRxHcZsw9igvF+
         nBPJIjyjysrLFsTvoLH5gTgEHNywq032a3ixmdqBKzlsWvEORJlhVOkgBx9/j0sk3T9v
         moFkY9oymgzHdS0v45hriUdlp6v44aEOrk7tE=
Received: by 10.204.54.199 with SMTP id r7mr2555640bkg.106.1285663725484;
        Tue, 28 Sep 2010 01:48:45 -0700 (PDT)
Received: from anarsoul-laptop.localnet ([86.57.155.118])
        by mx.google.com with ESMTPS id 24sm5332253bkr.19.2010.09.28.01.48.38
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 28 Sep 2010 01:48:43 -0700 (PDT)
From:   Vasily Khoruzhick <anarsoul@gmail.com>
To:     Arun MURTHY <arun.murthy@stericsson.com>
Subject: Re: [PATCH 1/7] pwm: Add pwm core driver
Date:   Tue, 28 Sep 2010 11:47:20 +0300
User-Agent: KMail/1.13.5 (Linux/2.6.35-gentoo-r8-anarsoul; KDE/4.5.1; i686; ; )
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
References: <1285659648-21409-1-git-send-email-arun.murthy@stericsson.com> <201009281114.31223.anarsoul@gmail.com> <F45880696056844FA6A73F415B568C69532DC2FA8F@EXDCVYMBSTM006.EQ1STM.local>
In-Reply-To: <F45880696056844FA6A73F415B568C69532DC2FA8F@EXDCVYMBSTM006.EQ1STM.local>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <201009281147.20871.anarsoul@gmail.com>
X-archive-position: 27848
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: anarsoul@gmail.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22165

On 28 of September 2010 11:38:26 Arun MURTHY wrote:

> > 
> > Why pwm_free is marked __deprecated? What is its successor?
> 
> This function is to be removed.

What should be used as replacement?

Regards
Vasily
