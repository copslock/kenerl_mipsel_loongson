Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 15:06:05 +0200 (CEST)
Received: from mga01.intel.com ([192.55.52.88]:17698 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491094Ab0I1NGC (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 28 Sep 2010 15:06:02 +0200
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP; 28 Sep 2010 06:05:52 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="4.57,247,1283756400"; 
   d="scan'208";a="841620498"
Received: from unknown (HELO sortiz-mobl) ([10.255.18.134])
  by fmsmga001.fm.intel.com with ESMTP; 28 Sep 2010 06:05:48 -0700
Date:   Tue, 28 Sep 2010 15:06:11 +0200
From:   Samuel Ortiz <sameo@linux.intel.com>
To:     Hemanth V <hemanthv@ti.com>
Cc:     Arun Murthy <arun.murthy@stericsson.com>, lars@metafoo.de,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel@pengutronix.de, philipp.zabel@gmail.com,
        robert.jarzmik@free.fr, marek.vasut@gmail.com,
        eric.y.miao@gmail.com, rpurdie@rpsys.net, kgene.kim@samsung.com,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mips@linux-mips.org,
        STEricsson_nomadik_linux@list.st.com
Subject: Re: [PATCH 1/7] pwm: Add pwm core driver
Message-ID: <20100928130610.GB20749@sortiz-mobl>
References: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com>
 <1285670134-18063-2-git-send-email-arun.murthy@stericsson.com>
 <040c01cb5f0c$29bcb3b0$LocalHost@wipblrx0099946>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <040c01cb5f0c$29bcb3b0$LocalHost@wipblrx0099946>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27873
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sameo@linux.intel.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22350

On Tue, Sep 28, 2010 at 06:23:24PM +0530, Hemanth V wrote:
> ----- Original Message ----- From: "Arun Murthy"
> <arun.murthy@stericsson.com>
> 
> 
> >The existing pwm based led and backlight driver makes use of the
> >pwm(include/linux/pwm.h). So all the board specific pwm drivers will
> >be exposing the same set of function name as in include/linux/pwm.h.
> >As a result build fails in case of multi soc environments where each soc
> >has a pwm device in it.
> 
> This seems very specific to ST environment,  
No it's not. It's an issue Arun has hit while enabling one of the ST MFD chip,
but he's tackling a generic issue.

> looking at the driver list from
> ( [PATCH 4/7] pwm: Align existing pwm drivers with pwm-core ) it seems
> most multi SOC environments might support PWM in either one of the SOC.
> 
> arch/arm/plat-mxc/pwm.c
> arch/arm/plat-pxa/pwm.c
> arch/arm/plat-samsung/pwm.c
> arch/mips/jz4740/pwm.c
> drivers/mfd/twl6030-pwm.c
> 
> Unless people have examples of other SOCs which might use this,
> the better approach might be to go for a custom driver rather than changing
> the framework.
I wouldn't call the current pwm code a framework. It's a bunch of header
definitions that happens to work in the specific case of 1 pwm per
sub architecture.
What Arun is proposing is an actual framework. And it seems to be clean and
simple enough.

Cheers,
Samuel.

-- 
Intel Open Source Technology Centre
http://oss.intel.com/
