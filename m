Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 08 May 2012 17:28:36 +0200 (CEST)
Received: from avon.wwwdotorg.org ([70.85.31.133]:45008 "EHLO
        avon.wwwdotorg.org" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1903633Ab2EHP2a (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 8 May 2012 17:28:30 +0200
Received: from severn.wwwdotorg.org (unknown [192.168.65.5])
        (using TLSv1 with cipher ADH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by avon.wwwdotorg.org (Postfix) with ESMTPS id 1F5D16412;
        Tue,  8 May 2012 09:30:04 -0600 (MDT)
Received: from [10.20.204.51] (searspoint.nvidia.com [216.228.112.21])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by severn.wwwdotorg.org (Postfix) with ESMTPSA id 89E32E461C;
        Tue,  8 May 2012 09:28:25 -0600 (MDT)
Message-ID: <4FA93B97.4070406@wwwdotorg.org>
Date:   Tue, 08 May 2012 09:28:23 -0600
From:   Stephen Warren <swarren@wwwdotorg.org>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:12.0) Gecko/20120430 Thunderbird/12.0.1
MIME-Version: 1.0
To:     Linus Walleij <linus.walleij@linaro.org>
CC:     John Crispin <blogic@openwrt.org>,
        Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        devicetree-discuss@lists.ozlabs.org
Subject: Re: [PATCH 04/14] OF: pinctrl: MIPS: lantiq: implement lantiq/xway
 pinctrl support
References: <1336133919-26525-1-git-send-email-blogic@openwrt.org> <1336133919-26525-4-git-send-email-blogic@openwrt.org> <CACRpkdYJDd84GbKM7r4Xy+d4iOtdD+rJ3kdq-zwVbf_Attj2Gw@mail.gmail.com>
In-Reply-To: <CACRpkdYJDd84GbKM7r4Xy+d4iOtdD+rJ3kdq-zwVbf_Attj2Gw@mail.gmail.com>
X-Enigmail-Version: 1.5pre
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.96.5 at avon.wwwdotorg.org
X-Virus-Status: Clean
X-archive-position: 33214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: swarren@wwwdotorg.org
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>

On 05/08/2012 07:21 AM, Linus Walleij wrote:
> On Fri, May 4, 2012 at 2:18 PM, John Crispin <blogic@openwrt.org> wrote:
> 
>> Implement support for pinctrl on lantiq/xway socs. The IO core found on these
>> socs has the registers for pinctrl, pinconf and gpio mixed up in the same
>> register range. As the gpio_chip handling is only a few lines, the driver also
>> implements the gpio functionality. This obseletes the old gpio driver that was
>> located in the arch/ folder.
...
>> diff --git a/drivers/pinctrl/Kconfig b/drivers/pinctrl/Kconfig
>> index f73a5ea..a19bac96 100644
>> --- a/drivers/pinctrl/Kconfig
>> +++ b/drivers/pinctrl/Kconfig
>> @@ -30,6 +30,11 @@ config PINCTRL_PXA3xx
>>        bool
>>        select PINMUX
>>
>> +config PINCTRL_LANTIQ
>> +       bool
>> +       select PINMUX
>> +       select PINCONF
> 
> depends on LANTIQ
> 
> ?
> 
> I don't think anyone else is going to want to compile
> this.

This Kconfig option is selected by the ARCH Kconfig, so only selected at
the right time. The user won't get prompted for it since there's no
string after "bool". I think this is OK. Tegra's pinctrl Kconfig option
doesn't have any "depends ARCH_TEGRA" here either, although I note that
many other pinctrl drivers do.

>>  config PINCTRL_MMP2
>>        bool "MMP2 pin controller driver"
>>        depends on ARCH_MMP
>> @@ -83,6 +88,10 @@ config PINCTRL_COH901
>>          COH 901 335 and COH 901 571/3. They contain 3, 5 or 7
>>          ports of 8 GPIO pins each.
>>
>> +config PINCTRL_XWAY
>> +       bool
>> +       select PINCTRL_LANTIQ
> 
> Shouldn't this be:
> 
> depends on SOC_TYPE_XWAY

Maybe, but see comments above.

> depends on PINCTRL_LANTIQ

Selecting PINCTRL_LANTIQ seems more appropriate; the ARCH Kconfig just
selects PINCTRL_XWAY when appropriate, and that then selects anything it
depends on.

(IIRC, the driver for SOC_TYPE_XWAY uses the driver for LANTIQ, not the
other way around?)

> So LANTIQ selects it's pinctrl driver, the the xway SoC
> selects its driver and they both are dependent on their
> respective system.
