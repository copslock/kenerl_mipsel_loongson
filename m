Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 08 Aug 2014 03:40:04 +0200 (CEST)
Received: from mail1.windriver.com ([147.11.146.13]:45513 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6854765AbaHHBkBE3XBQ (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 8 Aug 2014 03:40:01 +0200
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.14.9/8.14.5) with ESMTP id s781druw004757
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Thu, 7 Aug 2014 18:39:53 -0700 (PDT)
Received: from [128.224.162.170] (128.224.162.170) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.174.1; Thu, 7 Aug
 2014 18:39:52 -0700
Message-ID: <53E42A42.3000707@windriver.com>
Date:   Fri, 8 Aug 2014 09:39:14 +0800
From:   "Yang,Wei" <Wei.Yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     "Yang,Wei" <Wei.Yang@windriver.com>, <Wei.Yang@windriver.com>,
        <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v1] MIPS:KDUMP: set a right value to kexec_indirection_page
 variable
References: <1406806949-27039-1-git-send-email-Wei.Yang@windriver.com> <53DF0204.6000904@windriver.com>
In-Reply-To: <53DF0204.6000904@windriver.com>
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.162.170]
Return-Path: <Wei.Yang@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 41902
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Wei.Yang@windriver.com
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

Ralf,

What do you think of this patch?

Thanks
Wei
On 08/04/2014 11:46 AM, Yang,Wei wrote:
> ping.
>
> BR,
> Wei
> On 07/31/2014 07:42 PM, Wei.Yang@windriver.com wrote:
>> From: Yang Wei <Wei.Yang@windriver.com>
>>
>> Since there is not indirection page in crash type, so the vaule of 
>> the head
>> field of kimage structure is not equal to the address of indirection 
>> page but
>> IND_DONE. so we have to set kexec_indirection_page variable to the 
>> address of
>> the head field of image structure.
>>
>> Signed-off-by: Yang Wei <Wei.Yang@windriver.com>
>>
>>            Hi Ralf,
>>
>>           Please help me take a look at this patch, I have already 
>> verified it on Cavium 6100EVB board.
>>
>>           Thanks
>>           Wei
>> ---
>>   arch/mips/kernel/machine_kexec.c |    9 +++++++--
>>   1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/mips/kernel/machine_kexec.c 
>> b/arch/mips/kernel/machine_kexec.c
>> index 992e184..531b70d 100644
>> --- a/arch/mips/kernel/machine_kexec.c
>> +++ b/arch/mips/kernel/machine_kexec.c
>> @@ -71,8 +71,13 @@ machine_kexec(struct kimage *image)
>>       kexec_start_address =
>>           (unsigned long) phys_to_virt(image->start);
>>   -    kexec_indirection_page =
>> -        (unsigned long) phys_to_virt(image->head & PAGE_MASK);
>> +    if (image->type == KEXEC_TYPE_DEFAULT) {
>> +        kexec_indirection_page =
>> +            (unsigned long) phys_to_virt(image->head & PAGE_MASK);
>> +    } else {
>> +        kexec_indirection_page = (unsigned long)&image->head;
>> +    }
>> +
>>         memcpy((void*)reboot_code_buffer, relocate_new_kernel,
>>              relocate_new_kernel_size);
>
>
>
