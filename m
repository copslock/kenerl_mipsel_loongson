Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Mar 2010 03:08:55 +0100 (CET)
Received: from mail.windriver.com ([147.11.1.11]:56584 "EHLO
        mail.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S1492133Ab0CDCIv (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Mar 2010 03:08:51 +0100
Received: from ALA-MAIL03.corp.ad.wrs.com (ala-mail03 [147.11.57.144])
        by mail.windriver.com (8.14.3/8.14.3) with ESMTP id o2428dhY026535;
        Wed, 3 Mar 2010 18:08:39 -0800 (PST)
Received: from [128.224.162.222] ([128.224.162.222]) by ALA-MAIL03.corp.ad.wrs.com with Microsoft SMTPSVC(6.0.3790.1830);
         Wed, 3 Mar 2010 18:08:38 -0800
Message-ID: <4B8F1625.5060709@windriver.com>
Date:   Thu, 04 Mar 2010 10:08:37 +0800
From:   Yang Shi <yang.shi@windriver.com>
User-Agent: Thunderbird 2.0.0.23 (X11/20090817)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     ralf@linux-mips.org, f.fainelli@gmail.com,
        linux-mips@linux-mips.org
Subject: Re: [PATCH 1/3] MIPS: Octeon: Remove superfluous on_each_cpu parameter
References: <1267605801-5305-1-git-send-email-yang.shi@windriver.com> <fd8fb199609e60a5b6c10e2073976a3f6b599109.1267604875.git.yang.shi@windriver.com> <4B8EA1FD.5050007@caviumnetworks.com>
In-Reply-To: <4B8EA1FD.5050007@caviumnetworks.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 04 Mar 2010 02:08:38.0868 (UTC) FILETIME=[9AD84940:01CABB3F]
Return-Path: <Yang.Shi@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 26119
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: yang.shi@windriver.com
Precedence: bulk
X-list: linux-mips

David Daney 写道:
> On 03/03/2010 12:43 AM, Yang Shi wrote:
>   
>> Now, on_each_cpu just need three parameters, but the on_each_cpu
>> still uses four parameters in Octeon's setup.c. So, remove the
>> superfluous parameter.
>>
>> Signed-off-by: Yang Shi<yang.shi@windriver.com>
>>     
>
>
> NAK!  We are removing CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB completely.
>
> I will send the removal patch soon.
>   

Thanks David. Will apply your patch to remove WIRED_TLB.

Regards,
Yang

> David Daney
>
>   
>> ---
>>   arch/mips/cavium-octeon/setup.c |    2 +-
>>   1 files changed, 1 insertions(+), 1 deletions(-)
>>
>> diff --git a/arch/mips/cavium-octeon/setup.c b/arch/mips/cavium-octeon/setup.c
>> index b321d3b..4eaa35f 100644
>> --- a/arch/mips/cavium-octeon/setup.c
>> +++ b/arch/mips/cavium-octeon/setup.c
>> @@ -230,7 +230,7 @@ static void octeon_hal_setup_per_cpu_reserved32(void *unused)
>>   void octeon_hal_setup_reserved32(void)
>>   {
>>   #ifdef CONFIG_CAVIUM_RESERVE32_USE_WIRED_TLB
>> -	on_each_cpu(octeon_hal_setup_per_cpu_reserved32, NULL, 0, 1);
>> +	on_each_cpu(octeon_hal_setup_per_cpu_reserved32, NULL, 1);
>>   #endif
>>   }
>>
>>     
>
>
>   
