Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 18:01:09 +0200 (CEST)
Received: from nbd.name ([46.4.11.11]:38162 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1903633Ab2EHQBD (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 8 May 2012 18:01:03 +0200
Message-ID: <4FA942E5.20906@phrozen.org>
Date:   Tue, 08 May 2012 17:59:33 +0200
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.24) Gecko/20111114 Icedove/3.1.16
MIME-Version: 1.0
To:     Stephen Warren <swarren@wwwdotorg.org>
CC:     Linus Walleij <linus.walleij@linaro.org>,
        linux-mips@linux-mips.org, devicetree-discuss@lists.ozlabs.org,
        Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [PATCH 04/14] OF: pinctrl: MIPS: lantiq: implement lantiq/xway
 pinctrl support
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org> <1336133919-26525-4-git-send-email-blogic@openwrt.org> <CACRpkdYJDd84GbKM7r4Xy+d4iOtdD+rJ3kdq-zwVbf_Attj2Gw@mail.gmail.com> <4FA93B97.4070406@wwwdotorg.org> <4FA93E37.70305@phrozen.org> <4FA940F3.4090008@wwwdotorg.org>
In-Reply-To: <4FA940F3.4090008@wwwdotorg.org>
X-Enigmail-Version: 1.1.2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-archive-position: 33217
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>


>> How about we do the following.
>>
>> config LANTIQ
>> 	select PINCTRL
>>
>> config PINCTRL_LANTIQ
>> 	def_bool y
>> 	depends on LANTIQ
>>
>> config PINCTRL_LANTIQ_XWAY
>> 	def_bool y
>> 	depends on SOC_TYPE_XWAY
>>
>> This would auto select the right symbols, have all the dependency logic
>> in 1 place and reduce the size of arch/mips/lantiq/Kconfig
> 
> Is it useful to build a kernel for XWAY without pinctrl, once the driver
> is there? That's the main difference between arch/mips/lantiq/Kconfig
> selecting PINCTRL_LANTIQ_XWAY vs that being a def_bool, and hence
> allowing the user to deselect it.
> 

it would not make sense to build an image without.

config LANTIQ and config SOC_TYPE_XWAY should explicitly select the
symbols that they need.
