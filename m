Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 08 Mar 2018 13:04:45 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.224]:50948 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994738AbeCHMEeK7-F1 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 8 Mar 2018 13:04:34 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx2.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Thu, 08 Mar 2018 12:04:26 +0000
Received: from [192.168.155.41] (192.168.155.41) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Thu, 8 Mar 2018
 04:00:29 -0800
Subject: Re: [PATCH v2] bcma: Prevent build of PCI host features in module
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        Kalle Valo <kvalo@codeaurora.org>
CC:     <zajec5@gmail.com>, <linux-wireless@vger.kernel.org>,
        <linux-mips@linux-mips.org>, <jhogan@kernel.org>
References: <1519898292-12155-1-git-send-email-matt.redfearn@mips.com>
 <87lgfcnkey.fsf@kamboji.qca.qualcomm.com>
 <c5929bb5-c50f-e73e-3117-fb0a862bb0fc@lwfinger.net>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <7a1695c0-45cf-e3d6-8524-8d2aeccc6490@mips.com>
Date:   Thu, 8 Mar 2018 12:00:27 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <c5929bb5-c50f-e73e-3117-fb0a862bb0fc@lwfinger.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.155.41]
X-BESS-ID: 1520510665-298553-1889-49075-1
X-BESS-VER: 2018.2-r1802232356
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.190829
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
X-archive-position: 62856
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

Hi,

On 02/03/18 17:56, Larry Finger wrote:
> On 03/01/2018 04:45 AM, Kalle Valo wrote:
>> Matt Redfearn <matt.redfearn@mips.com> writes:
>>
>>> Attempting to build bcma.ko with BCMA_DRIVER_PCI_HOSTMODE=y results in
>>> a build error due to use of symbols not exported from vmlinux:
>>>
>>> ERROR: "pcibios_enable_device" [drivers/bcma/bcma.ko] undefined!
>>> ERROR: "register_pci_controller" [drivers/bcma/bcma.ko] undefined!
>>> make[1]: *** [scripts/Makefile.modpost:92: __modpost] Error 1
>>>
>>> To prevent this, don't allow the host mode feature to be built if
>>> CONFIG_BCMA=m
>>>
>>> Signed-off-by: Matt Redfearn <matt.redfearn@mips.com>
>>>
>>> ---
>>>
>>> Changes in v2:
>>> Rebase on v4.16-rc1
>>>
>>>   drivers/bcma/Kconfig | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/bcma/Kconfig b/drivers/bcma/Kconfig
>>> index ba8acca036df..cb0f1aad20b7 100644
>>> --- a/drivers/bcma/Kconfig
>>> +++ b/drivers/bcma/Kconfig
>>> @@ -55,7 +55,7 @@ config BCMA_DRIVER_PCI
>>>   config BCMA_DRIVER_PCI_HOSTMODE
>>>       bool "Driver for PCI core working in hostmode"
>>> -    depends on MIPS && BCMA_DRIVER_PCI && PCI_DRIVERS_LEGACY
>>> +    depends on MIPS && BCMA_DRIVER_PCI && PCI_DRIVERS_LEGACY && BCMA 
>>> = y
>>
>> Due to the recent regression in bcma I would prefer extra careful review
>> before I apply this. So does this look ok to everyone?
> 
> I have a preference for wireless device drivers to be modules. For that 
> reason, I would have submitted a patch exporting those two missing 
> globals rather than forcing bcma to be built in. That said, it seems 
> that the patch will do no further harm.


This patch was purely intended to fix the build breakage caused by 
attempting to build host-mode PCI into a module, which fails due to 
necessary symbols not being exported by the kernel for use by modules.

Making it possible to build the driver including host mode may not be as 
trivial as "lets just export the symbols", and testing that it works 
correctly once it can be built as a module will require hardware with 
this device present (which I don't have).

So I would propose that this patch be merged as is, since as you say, it 
does no further harm - it should just fix build breakage - and if the 
driver, including this host mode feature, is really required as a 
module, perhaps someone with access to the hardware could spin a patch 
to implement that.

Thanks,
Matt

> 
> Larry
> 
> 
