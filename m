Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 14 Nov 2010 18:41:46 +0100 (CET)
Received: from phoenix3.szarvasnet.hu ([87.101.127.16]:41423 "EHLO
        phoenix3.szarvasnet.hu" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491919Ab0KNRl1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 14 Nov 2010 18:41:27 +0100
Received: from mail.szarvas.hu (localhost [127.0.0.1])
        by phoenix3.szarvasnet.hu (Postfix) with SMTP id 833833FC040;
        Sun, 14 Nov 2010 18:41:18 +0100 (CET)
Received: from [192.168.254.10] (catvpool-576570d8.szarvasnet.hu [87.101.112.216])
        by phoenix3.szarvasnet.hu (Postfix) with ESMTPA id E08221F0001;
        Sun, 14 Nov 2010 18:41:17 +0100 (CET)
Message-ID: <4CE01F3D.8070308@openwrt.org>
Date:   Sun, 14 Nov 2010 18:41:17 +0100
From:   Gabor Juhos <juhosg@openwrt.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; hu-HU; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To:     Sergei Shtylyov <sshtylyov@mvista.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        "Luis R. Rodriguez" <mcgrof@gmail.com>,
        Cliff Holden <Cliff.Holden@Atheros.com>,
        Imre Kaloz <kaloz@openwrt.org>
Subject: Re: [RFC 08/18] MIPS: ath79: add common watchdog device
References: <1289598684-30624-1-git-send-email-juhosg@openwrt.org> <1289598684-30624-9-git-send-email-juhosg@openwrt.org> <4CDE7C25.4080204@mvista.com>
In-Reply-To: <4CDE7C25.4080204@mvista.com>
X-Enigmail-Version: 1.1.1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
X-VBMS: A17DE314353 | phoenix3 | 127.0.0.1 |  | <juhosg@openwrt.org> | 
Return-Path: <juhosg@openwrt.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28389
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: juhosg@openwrt.org
Precedence: bulk
X-list: linux-mips

Hi Sergei,

> On 13-11-2010 0:51, Gabor Juhos wrote:
> 
>> All supported SoCs have a built-in hardware watchdog driver. This patch
>> registers a platform_device for that to make it usable.
> 
>> Signed-off-by: Gabor Juhos<juhosg@openwrt.org>
>> Signed-off-by: Imre Kaloz<kaloz@openwrt.org>
> [...]
> 
>> diff --git a/arch/mips/ath79/Kconfig b/arch/mips/ath79/Kconfig
>> index 2bd35ef..79bb528 100644
>> --- a/arch/mips/ath79/Kconfig
>> +++ b/arch/mips/ath79/Kconfig
>> @@ -28,4 +28,7 @@ config ATH79_DEV_LEDS_GPIO
>>   config ATH79_DEV_UART
>>       def_bool y
>>
>> +config ATH79_DEV_WDT
>> +    def_bool y
> 
>    What's the point of introducing this?

My first thought was that it will be selectable by the board specific config
options. Because the watchdog timer is integrated into the SoC it will be
available on all boards anyway. I will remove the ATH79_DEV_UART and
ATH79_DEV_WDT config options and will change the Makefile accordingly.

>> <...>
>> +void __init ath79_register_wdt(void)
>> +{
>> +    platform_device_register(&ath79_wdt_device);
>> +}
> 
>    I'm not sure creating a separate file for the WDT platfrom device is really
> worth it...

You are right probably. Because it is always used, it can be moved into a common
file instead. I will do that.

>> <..>
>> +#ifndef _ATH_DEV_WDT_H
>> +#define _ATH_DEV_WDT_H
>> +
>> +void ath79_register_wdt(void) __init;
>> +
>> +#endif
> 
>    I think this should better be put into some more common header...

Yes, i will move this too.

>> <...>
>> @@ -259,6 +260,7 @@ static int __init ath79_setup(void)
>>   {
>>       ath79_gpio_init();
>>       ath79_register_uart();
>> +    ath79_register_wdt();
> 
>    Now what if CONFIG_ATH79_DEV_WDT is not enabled? You'll siply get a linker
> error. 

Correct.

> I think you should define an empty inline ath79_register_wdt() in that case.

This won't be needed after the changes proposed above.

Thank you,
Gabor
