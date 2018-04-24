Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 24 Apr 2018 14:06:24 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:54122 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23993885AbeDXMGQsmEG0 convert rfc822-to-8bit
        (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 24 Apr 2018 14:06:16 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 24 Apr 2018 12:05:57 +0000
Received: from [192.168.155.41] (192.168.155.41) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 24
 Apr 2018 05:06:16 -0700
Subject: Re: MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for BCM47XX
 PCIe erratum
To:     James Hogan <jhogan@kernel.org>,
        IKEGAMI Tokunori <ikegami@allied-telesis.co.jp>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        PACKHAM Chris <chris.packham@alliedtelesis.co.nz>,
        Hauke Mehrtens <hauke@hauke-m.de>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
References: <TY1PR01MB0954C80E15BA87D03E3A6880DC880@TY1PR01MB0954.jpnprd01.prod.outlook.com>
 <20180424114956.GA28813@saruman>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <f7af849f-f720-fc95-b6b9-8a0f94e04e9f@mips.com>
Date:   Tue, 24 Apr 2018 13:06:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <20180424114956.GA28813@saruman>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1524571557-298552-7327-12529-1
X-BESS-VER: 2018.5-r1804232011
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.50
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.192327
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
X-archive-position: 63724
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

On 24/04/18 12:49, James Hogan wrote:
> Hi,
> 
> On Tue, Apr 24, 2018 at 07:33:51AM +0000, IKEGAMI Tokunori wrote:
>> Let us consult to change MIPS BCM47XX to enable MIPS32 74K Core ExternalSync.
>> Can we change the MIPS BCM47XX driver like this?
>> If any comment or concern please let us know.
> 
> Thanks for the patch.
> 
> Please use git-send-email to send patches in future if possible (you can
> put additional comments that aren't part of the commit message after a
> "---" separator). That should help format it correctly and will put a
> [PATCH] prefix etc.
> 
> I've also Cc'd Hauke and Rafał who maintain the BCM47XX platform.
> Running scripts/get_maintainer.pl on the patch will list some
> maintainers who might be worth Cc'ing on a patch.
> 
>>
>>
>>  From d6904a5fc90aaf205e982755e4d6cda62ad21273 Mon Sep 17 00:00:00 2001
>> From: Tokunori Ikegami <ikegami@allied-telesis.co.jp>
>> Date: Thu, 22 Feb 2018 12:02:16 +0900
>> Subject: [PATCH 1/2] MIPS: BCM47XX: Enable MIPS32 74K Core ExternalSync for
>>   BCM47XX PCIe erratum
>>
>> The erratum and workaround are described by BCM5300X-ES300-RDS.pdf as below.
> 
> Is that document accessible anywhere publicly?
> 
>>
>>    R10: PCIe Transactions Periodically Fail
>>
>>      Description: The BCM5300X PCIe does not maintain transaction ordering.
>>                   This may cause PCIe transaction failure.
>>      Fix Comment: Add a dummy PCIe configuration read after a PCIe
>>                   configuration write to ensure PCIe configuration access
>>                   ordering. Set ES bit of CP0 configu7 register to enable
>>                   sync function so that the sync instruction is functional.
>>      Resolution:  hndpci.c: extpci_write_config()
>>                   hndmips.c: si_mips_init()
>>                   mipsinc.h CONF7_ES
>>
>> This is fixed by the CFE MIPS bcmsi chipset driver also for BCM47XX.
>> Also the dummy PCIe configuration read is already implemented in the Linux
>> BCMA driver.
> 
>> This patch is just to enable ExternalSync in the Linux driver.
> 
> I suggest rewording this line to explain how ES helps, maybe something
> along the lines of:
> "Enable ExternalSync in Config7 when CONFIG_BCMA_DRIVER_PCI_HOSTMODE=y
> too so that the sync instruction is externalised..."
> 
> (Best not to refer to "this patch", just say what it does, and in Linux
> terminology this is architecture code, not really a driver).
> 
>>
>> Change-Id: Ifc7a0ce46962933731297ad0c82682e7d39328ff
> 
> You can drop this from upstream submissions in future.
> 
> You also need a signed-off-by line as described in
> Documentation/process/submitting-patches.rst to certify the work as
> complying with the "Developer's Certificate of Origin".
> 
>> Reviewed-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
>> ---
>>   arch/mips/include/asm/mipsregs.h | 2 ++
>>   arch/mips/kernel/cpu-probe.c     | 7 +++++++
>>   2 files changed, 9 insertions(+)
>>
>> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
>> index 858752dac337..1d1f4416a0f3 100644
>> --- a/arch/mips/include/asm/mipsregs.h
>> +++ b/arch/mips/include/asm/mipsregs.h
>> @@ -680,6 +680,8 @@
>>   #define MIPS_CONF7_WII		(_ULCAST_(1) << 31)
>>   
>>   #define MIPS_CONF7_RPS		(_ULCAST_(1) << 2)
>> +/* ExternalSync */
>> +#define MIPS_CONF7_ES		(_ULCAST_(1) << 8)

Since the config7 register is implementation specific, may I suggest 
changing the MIPS_ prefix to something vendor specific such as
BRCM_CONF7_ES and start a new section with a comment like:

/* Config7 Bits specific to Broadcom implementations */

Thanks,
Matt

>>   
>>   #define MIPS_CONF7_IAR		(_ULCAST_(1) << 10)
>>   #define MIPS_CONF7_AR		(_ULCAST_(1) << 16)
>> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
>> index cf3fd549e16d..9171928c40dd 100644
>> --- a/arch/mips/kernel/cpu-probe.c
>> +++ b/arch/mips/kernel/cpu-probe.c
>> @@ -429,6 +429,13 @@ static inline void check_errata(void)
>>   		if ((c->processor_id & PRID_REV_MASK) <= PRID_REV_34K_V1_0_2)
>>   			write_c0_config7(read_c0_config7() | MIPS_CONF7_RPS);
>>   		break;
>> +#ifdef CONFIG_BCMA_DRIVER_PCI_HOSTMODE
>> +	case CPU_74K:
>> +		/* Enable ExternalSync for sync instruction to take effect */
> 
> I think it would be helpful to mention the affected device and any
> errata number in this comment.
> 
>> +		pr_info("ExternalSync has been enabled\n");
>> +		write_c0_config7(read_c0_config7() | MIPS_CONF7_ES);
>   
> (I would have suggested adding:
> 
> diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
> index f65859784a4c..af6e59cfc763 100644
> --- a/arch/mips/include/asm/mipsregs.h
> +++ b/arch/mips/include/asm/mipsregs.h
> @@ -2760,6 +2760,7 @@ __BUILD_SET_C0(status)
>   __BUILD_SET_C0(cause)
>   __BUILD_SET_C0(config)
>   __BUILD_SET_C0(config5)
> +__BUILD_SET_C0(config7)
>   __BUILD_SET_C0(intcontrol)
>   __BUILD_SET_C0(intctl)
>   __BUILD_SET_C0(srsmap)
> 
> Then you can just do:
> 
> set_c0_config7(MIPS_CONF7_ES);
> 
> But I see the write(read() | x) form is already there in that file, so
> probably best to remain consistent with that. Using set_c0_config7() can
> always be done later as a separate patch.)
> 
> Otherwise the change itself looks reasonable to me.
> 
> Thanks
> James
> 
