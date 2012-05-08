Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 17:51:30 +0200 (CEST)
Received: from avon.wwwdotorg.org ([70.85.31.133]:38330 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903633Ab2EHPvW (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 May 2012 17:51:22 +0200
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id D1E636412;
        Tue,  8 May 2012 09:52:57 -0600 (MDT)
Received: from [10.20.204.51] (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id CBBBBE461C;
        Tue,  8 May 2012 09:51:19 -0600 (MDT)
Message-ID: <4FA940F3.4090008@wwwdotorg.org>
Date:   Tue, 08 May 2012 09:51:15 -0600
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To:     John Crispin <john@phrozen.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 04/14] OF: pinctrl: MIPS: lantiq: implement lantiq/xway
 pinctrl support
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org> <1336133919-26525-4-git-send-email-blogic@openwrt.org> <CACRpkdYJDd84GbKM7r4Xy+d4iOtdD+rJ3kdq-zwVbf_Attj2Gw@mail.gmail.com> <4FA93B97.4070406@wwwdotorg.org> <4FA93E37.70305@phrozen.org>
In-Reply-To: <4FA93E37.70305@phrozen.org>
X-Enigmail-Version: 1.5pre
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.96.5 at avon.wwwdotorg.org
X-Virus-Status: Clean
X-archive-position: 33216
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 05/08/2012 09:39 AM, John Crispin wrote:
>>> I don't think anyone else is going to want to compile
>>> this.
>>
>> This Kconfig option is selected by the ARCH Kconfig, so only selected at
>> the right time. The user won't get prompted for it since there's no
>> string after "bool". I think this is OK. Tegra's pinctrl Kconfig option
>> doesn't have any "depends ARCH_TEGRA" here either, although I note that
>> many other pinctrl drivers do.
> 
> Hi,
> 
> I guess it makes it more apparent, that the symbol is specific to a
> arch/soc. Tegra is a well known SoC, so its easy to figure out what the
> codes purpose is. Other files might not be that easy to guess.
> 
> For the Lantiq SoC to function normally we need to always load these
> drivers. PINTCTRL_LANTIQ has some generic functions and
> PINTCTRL_LANTIQ_XWAY holds the code specific to the XWAY SoC. (i have a
> patch in the local queue to add FALCON SoC support, giving
> PINTCTRL_LANTIQ 2 users)
> 
> How about we do the following.
> 
> config LANTIQ
> 	select PINCTRL
> 
> config PINCTRL_LANTIQ
> 	def_bool y
> 	depends on LANTIQ
> 
> config PINCTRL_LANTIQ_XWAY
> 	def_bool y
> 	depends on SOC_TYPE_XWAY
> 
> This would auto select the right symbols, have all the dependency logic
> in 1 place and reduce the size of arch/mips/lantiq/Kconfig

Is it useful to build a kernel for XWAY without pinctrl, once the driver
is there? That's the main difference between arch/mips/lantiq/Kconfig
selecting PINCTRL_LANTIQ_XWAY vs that being a def_bool, and hence
allowing the user to deselect it.
