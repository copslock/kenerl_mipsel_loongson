Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 28 Sep 2010 15:35:51 +0200 (CEST)
Received: from devils.ext.ti.com ([198.47.26.153]:33522 "EHLO
        devils.ext.ti.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1491895Ab0I1Nfs (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 28 Sep 2010 15:35:48 +0200
Received: from dlep33.itg.ti.com ([157.170.170.112])
        by devils.ext.ti.com (8.13.7/8.13.7) with ESMTP id o8SDZ6DT008861
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
        Tue, 28 Sep 2010 08:35:06 -0500
Received: from legion.dal.design.ti.com (localhost [127.0.0.1])
        by dlep33.itg.ti.com (8.13.7/8.13.7) with ESMTP id o8SDZ5tv017859;
        Tue, 28 Sep 2010 08:35:05 -0500 (CDT)
Received: from localhost (h0-167.vpn.ti.com [172.24.0.167])
        by legion.dal.design.ti.com (8.11.7p1+Sun/8.11.7) with ESMTP id o8SDZ1f27901;
        Tue, 28 Sep 2010 08:35:02 -0500 (CDT)
Date:   Tue, 28 Sep 2010 16:35:01 +0300
From:   Felipe Balbi <balbi@ti.com>
To:     Samuel Ortiz <sameo@linux.intel.com>
Cc:     "V, Hemanth" <hemanthv@ti.com>,
        Arun Murthy <arun.murthy@stericsson.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "philipp.zabel@gmail.com" <philipp.zabel@gmail.com>,
        "robert.jarzmik@free.fr" <robert.jarzmik@free.fr>,
        "marek.vasut@gmail.com" <marek.vasut@gmail.com>,
        "eric.y.miao@gmail.com" <eric.y.miao@gmail.com>,
        "rpurdie@rpsys.net" <rpurdie@rpsys.net>,
        "kgene.kim@samsung.com" <kgene.kim@samsung.com>,
        "linux-omap@vger.kernel.org" <linux-omap@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "STEricsson_nomadik_linux@list.st.com" 
        <STEricsson_nomadik_linux@list.st.com>
Subject: Re: [PATCH 1/7] pwm: Add pwm core driver
Message-ID: <20100928133501.GB8575@legolas.emea.dhcp.ti.com>
Reply-To: balbi@ti.com
References: <1285670134-18063-1-git-send-email-arun.murthy@stericsson.com>
 <1285670134-18063-2-git-send-email-arun.murthy@stericsson.com>
 <040c01cb5f0c$29bcb3b0$LocalHost@wipblrx0099946>
 <20100928130610.GB20749@sortiz-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline
In-Reply-To: <20100928130610.GB20749@sortiz-mobl>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-archive-position: 27874
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: balbi@ti.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                 
X-UID: 22377

On Tue, Sep 28, 2010 at 08:06:11AM -0500, Samuel Ortiz wrote:
>On Tue, Sep 28, 2010 at 06:23:24PM +0530, Hemanth V wrote:
>> ----- Original Message ----- From: "Arun Murthy"
>> <arun.murthy@stericsson.com>
>>
>>
>> >The existing pwm based led and backlight driver makes use of the
>> >pwm(include/linux/pwm.h). So all the board specific pwm drivers will
>> >be exposing the same set of function name as in include/linux/pwm.h.
>> >As a result build fails in case of multi soc environments where each soc
>> >has a pwm device in it.
>>
>> This seems very specific to ST environment,
>No it's not. It's an issue Arun has hit while enabling one of the ST MFD chip,
>but he's tackling a generic issue.
>
>> looking at the driver list from
>> ( [PATCH 4/7] pwm: Align existing pwm drivers with pwm-core ) it seems
>> most multi SOC environments might support PWM in either one of the SOC.
>>
>> arch/arm/plat-mxc/pwm.c
>> arch/arm/plat-pxa/pwm.c
>> arch/arm/plat-samsung/pwm.c
>> arch/mips/jz4740/pwm.c
>> drivers/mfd/twl6030-pwm.c
>>
>> Unless people have examples of other SOCs which might use this,
>> the better approach might be to go for a custom driver rather than changing
>> the framework.
>I wouldn't call the current pwm code a framework. It's a bunch of header
>definitions that happens to work in the specific case of 1 pwm per
>sub architecture.
>What Arun is proposing is an actual framework. And it seems to be clean and
>simple enough.

FWIW, I agree with you Sam. Sooner or later, this will hit other SoCs.

-- 
balbi
