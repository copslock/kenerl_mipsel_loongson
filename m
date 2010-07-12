Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Jul 2010 00:08:36 +0200 (CEST)
Received: from mailhost.informatik.uni-hamburg.de ([134.100.9.70]:35628 "EHLO
        mailhost.informatik.uni-hamburg.de" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492008Ab0GLWIc (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Jul 2010 00:08:32 +0200
Received: from localhost (localhost [127.0.0.1])
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTP id BE6F0467;
        Tue, 13 Jul 2010 00:08:25 +0200 (CEST)
X-Virus-Scanned: amavisd-new at informatik.uni-hamburg.de
Received: from mailhost.informatik.uni-hamburg.de ([127.0.0.1])
        by localhost (mailhost.informatik.uni-hamburg.de [127.0.0.1]) (amavisd-new, port 10024)
        with LMTP id LMZLN2TgkzIf; Tue, 13 Jul 2010 00:08:25 +0200 (CEST)
Received: from [172.31.16.228] (d043121.adsl.hansenet.de [80.171.43.121])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: 7clausen)
        by mailhost.informatik.uni-hamburg.de (Postfix) with ESMTPSA id C3BCE465;
        Tue, 13 Jul 2010 00:08:14 +0200 (CEST)
Message-ID: <4C3B923F.1090703@metafoo.de>
Date:   Tue, 13 Jul 2010 00:07:59 +0200
From:   Lars-Peter Clausen <lars@metafoo.de>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     Randy Dunlap <randy.dunlap@oracle.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Matt Fleming <matt@console-pimps.org>,
        linux-mmc@vger.kernel.org
Subject: Re: [PATCH v4] MMC: Add JZ4740 mmc driver
References: <1277688041-23522-1-git-send-email-lars@metafoo.de> <1278970413-21617-1-git-send-email-lars@metafoo.de> <4C3B8C13.3040009@oracle.com>
In-Reply-To: <4C3B8C13.3040009@oracle.com>
X-Enigmail-Version: 0.95.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <lars@metafoo.de>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 27379
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: lars@metafoo.de
Precedence: bulk
X-list: linux-mips

Hi

Randy Dunlap wrote:
> Lars-Peter Clausen wrote:
>> This patch adds support for the mmc controller on JZ4740 SoCs.
>>
>> Signed-off-by: Lars-Peter Clausen <lars@metafoo.de>
>> Acked-by: Matt Fleming <matt@console-pimps.org>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: Matt Fleming <matt@console-pimps.org>
>> Cc: linux-mmc@vger.kernel.org
>>
>> ---
>>  arch/mips/include/asm/mach-jz4740/jz4740_mmc.h |   15 +
>>  drivers/mmc/host/Kconfig                       |    8 +
>>  drivers/mmc/host/Makefile                      |    1 +
>>  drivers/mmc/host/jz4740_mmc.c                  | 1024 ++++++++++++++++++++++++
>>  4 files changed, 1048 insertions(+), 0 deletions(-)
>>  create mode 100644 arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
>>  create mode 100644 drivers/mmc/host/jz4740_mmc.c
>>
>> diff --git a/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h b/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
>> new file mode 100644
>> index 0000000..8543f43
>> --- /dev/null
>> +++ b/arch/mips/include/asm/mach-jz4740/jz4740_mmc.h
>> @@ -0,0 +1,15 @@
>> +#ifndef __LINUX_MMC_JZ4740_MMC
>> +#define __LINUX_MMC_JZ4740_MMC
>> +
>> +struct jz4740_mmc_platform_data {
>> +	int gpio_power;
>> +	int gpio_card_detect;
>> +	int gpio_read_only;
>> +	unsigned card_detect_active_low:1;
>> +	unsigned read_only_active_low:1;
>> +	unsigned power_active_low:1;
>> +
>> +	unsigned data_1bit:1;
>> +};
>> +
>> +#endif
>> diff --git a/drivers/mmc/host/Kconfig b/drivers/mmc/host/Kconfig
>> index f06d06e..546fc49 100644
>> --- a/drivers/mmc/host/Kconfig
>> +++ b/drivers/mmc/host/Kconfig
>> @@ -81,6 +81,14 @@ config MMC_RICOH_MMC
>>  
>>  	  If unsure, say Y.
>>  
>> +config MMC_JZ4740
>> +	tristate "JZ4740 SD/Multimedia Card Interface support"
>> +	depends on MACH_JZ4740
> 
> What tree has the kconfig symbol MACH_JZ4740 in it?
> I can't seem to find it...
> 
> Should the depends also say anything about GPIO?
> I only ask because the header file above mentions gpio.
> 

None yet, mips hopefully soon. Version 1 of this patch was part of a series adding
support for the JZ4740.
Since the jz4740 platform code provides the gpio functions I don't think it is
necessary to add an additional depends on GENERIC_GPIO.

>> +	help
>> +	  This selects the Ingenic Z4740 SD/Multimedia card Interface.
>> +	  If you have an ngenic platform with a Multimedia Card slot,
> 
> 	                 Ingenic ?
> 

Woops, yes.

>> +	  say Y or M here.
>> +
>>  config MMC_SDHCI_OF
>>  	tristate "SDHCI support on OpenFirmware platforms"
>>  	depends on MMC_SDHCI && PPC_OF
> 
> 

Thanks for reviewing
- Lars
