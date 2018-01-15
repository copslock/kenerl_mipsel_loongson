Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 15 Jan 2018 12:18:26 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:36590 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992866AbeAOLSScM7xV (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 15 Jan 2018 12:18:18 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1412.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 15 Jan 2018 11:17:18 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Mon, 15 Jan
 2018 03:16:59 -0800
Subject: Re: [PATCH] bcma: Prevent build of PCI host features in module
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        <linux-wireless@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Guenter Roeck" <linux@roeck-us.net>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
References: <1515767119-17117-1-git-send-email-matt.redfearn@mips.com>
 <87zi5f1lm0.fsf@purkki.adurom.net>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <85b96369-ebd6-1f04-13c2-1757ac716723@mips.com>
Date:   Mon, 15 Jan 2018 11:16:57 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <87zi5f1lm0.fsf@purkki.adurom.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1516015037-452060-11649-383533-9
X-BESS-VER: 2017.17.1-r1801090054
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189004
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.50 BSF_RULE7568M          META: Custom Rule 7568M 
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.50 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_RULE7568M, BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62108
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

Hi Kalle,

On 15/01/18 10:07, Kalle Valo wrote:
> Matt Redfearn <matt.redfearn@mips.com> writes:
> 
>> Attempting to build bcma.ko with BCMA_DRIVER_PCI_HOSTMODE=y results in
>> a build error due to use of symbols not exported from vmlinux:
>>
>> ERROR: "pcibios_enable_device" [drivers/bcma/bcma.ko] undefined!
>> ERROR: "register_pci_controller" [drivers/bcma/bcma.ko] undefined!
>> make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
>>
>> To prevent this, don't allow the host mode feature to be built if
>> CONFIG_BCMA=m
>>
>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>>
>> ---
>>
>>   drivers/bcma/Kconfig | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/bcma/Kconfig b/drivers/bcma/Kconfig
>> index 02d78f6cecbb..4294784b9cf1 100644
>> --- a/drivers/bcma/Kconfig
>> +++ b/drivers/bcma/Kconfig
>> @@ -55,7 +55,7 @@ config BCMA_DRIVER_PCI
>>   
>>   config BCMA_DRIVER_PCI_HOSTMODE
>>   	bool "Driver for PCI core working in hostmode"
>> -	depends on MIPS && BCMA_DRIVER_PCI
>> +	depends on MIPS && BCMA_DRIVER_PCI && BCMA = y
> 
> Is this a new regression? Do you know the commit which broke this?

As far as I can see, pcibios_enable_device and register_pci_controller 
have never being exported symbols from vmlinux, and an allmodconfig 
build with CONFIG_MIPS_COBALT=y (MIPS cobalt platform) which attempts to 
put this this functionality into a module would never have linked 
successfully. As such it can be traced back to when this functionality 
was added, 49dc9577155576b10ff79f0c1486c816b01f58bf ("bcma: add PCIe 
host controller").

> 
> Is it somehow related to this:
> 
> bcma: Fix 'allmodconfig' and BCMA builds on MIPS targets
> https://patchwork.kernel.org/patch/10162839/
> 
> Or are these two separate issues?
> 

Separate issues - that one fixes allmodconfig when CONFIG_MIPS_GENERIC=y 
(MIPS generic platform) which does not define the struct pci_controller 
- that error was really introduced when that struct definition was 
removed for the generic platform by 
c5611df968047fb0b38156497b4242730ef66108 ("MIPS: PCI: Introduce 
CONFIG_PCI_DRIVERS_LEGACY").

I think both patches are valid since they fix errors building 
allmodconfig on 2 separate MIPS platforms.

Thanks,
Matt
