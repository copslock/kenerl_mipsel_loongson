Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 17:41:16 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:59394 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903633Ab2EHPlJ (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 17:41:09 +0200
Message-ID: <4FA93E37.70305@phrozen.org>
Date:   Tue, 08 May 2012 17:39:35 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Stephen Warren <swarren@wwwdotorg.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 04/14] OF: pinctrl: MIPS: lantiq: implement lantiq/xway
 pinctrl support
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org> <1336133919-26525-4-git-send-email-blogic@openwrt.org> <CACRpkdYJDd84GbKM7r4Xy+d4iOtdD+rJ3kdq-zwVbf_Attj2Gw@mail.gmail.com> <4FA93B97.4070406@wwwdotorg.org>
In-Reply-To: <4FA93B97.4070406@wwwdotorg.org>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33215
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

>> I don't think anyone else is going to want to compile
>> this.
>
> This Kconfig option is selected by the ARCH Kconfig, so only selected at
> the right time. The user won't get prompted for it since there's no
> string after "bool". I think this is OK. Tegra's pinctrl Kconfig option
> doesn't have any "depends ARCH_TEGRA" here either, although I note that
> many other pinctrl drivers do.

Hi,

I guess it makes it more apparent, that the symbol is specific to a
arch/soc. Tegra is a well known SoC, so its easy to figure out what the
codes purpose is. Other files might not be that easy to guess.

For the Lantiq SoC to function normally we need to always load these
drivers. PINTCTRL_LANTIQ has some generic functions and
PINTCTRL_LANTIQ_XWAY holds the code specific to the XWAY SoC. (i have a
patch in the local queue to add FALCON SoC support, giving
PINTCTRL_LANTIQ 2 users)

How about we do the following.

config LANTIQ
	select PINCTRL

config PINCTRL_LANTIQ
	def_bool y
	depends on LANTIQ

config PINCTRL_LANTIQ_XWAY
	def_bool y
	depends on SOC_TYPE_XWAY

This would auto select the right symbols, have all the dependency logic
in 1 place and reduce the size of arch/mips/lantiq/Kconfig

Thanks,
John
