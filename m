Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Dec 2015 09:20:16 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:8210 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011494AbbLDIUOeBXzY (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Dec 2015 09:20:14 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 48A2C3F8C0357;
        Fri,  4 Dec 2015 08:20:05 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Fri, 4 Dec 2015 08:20:06 +0000
Received: from [192.168.154.116] (192.168.154.116) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Fri, 4 Dec
 2015 08:20:05 +0000
Subject: Re: [PATCH 6/9] MIPS: Call relocate_kernel if CONFIG_RELOCATABLE=y
To:     James Hogan <james@albanarts.com>,
        Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <linux-mips@linux-mips.org>
References: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
 <1449137297-30464-7-git-send-email-matt.redfearn@imgtec.com>
 <56605081.5050307@cogentembedded.com> <5660577F.2020401@imgtec.com>
 <56607FE6.7040001@cogentembedded.com>
 <BA73413A-D335-4692-85A4-9330D7ACAC03@albanarts.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <56614CB5.9020002@imgtec.com>
Date:   Fri, 4 Dec 2015 08:20:05 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <BA73413A-D335-4692-85A4-9330D7ACAC03@albanarts.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50330
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi James,

On 03/12/15 18:54, James Hogan wrote:
> On 3 December 2015 17:46:14 GMT+00:00, Sergei Shtylyov <sergei.shtylyov@cogentembedded.com> wrote:
>> On 12/03/2015 05:53 PM, Matt Redfearn wrote:
>>
>>>>> If CONFIG_RELOCATABLE is enabled, jump to relocate_kernel.
>>>>>
>>>>> This function will return the entry point of the relocated kernel
>> if
>>>>> copy/relocate is sucessful or the original entry point if not. The
>> stack
>>>>> pointer must then be pointed into the new image.
>>>>>
>>>>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>>>> ---
>>>>>    arch/mips/kernel/head.S | 20 ++++++++++++++++++++
>>>>>    1 file changed, 20 insertions(+)
>>>>>
>>>>> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
>>>>> index 4e4cc5b9a771..7dc043349d66 100644
>>>>> --- a/arch/mips/kernel/head.S
>>>>> +++ b/arch/mips/kernel/head.S
>>>>> @@ -132,7 +132,27 @@ not_found:
>>>>>        set_saved_sp    sp, t0, t1
>>>>>        PTR_SUBU    sp, 4 * SZREG        # init stack pointer
>>>>>
>>>>> +#ifdef CONFIG_RELOCATABLE
>>>>> +    /* Copy kernel and apply the relocations */
>>>>> +    jal        relocate_kernel
>>>>> +
>>>>> +    /* Repoint the sp into the new kernel image */
>>>>> +    PTR_LI        sp, _THREAD_SIZE - 32 - PT_SIZE
>>>>> +    PTR_ADDU    sp, $28
>>>>     Can't you account for it in the previous PTR_LI?
>>> During relocate_kernel, $28, pointer to the current thread,
>> Ah, it's a register! I thought it was an immediate. Nevermind then. :-)
> Although, it could still be reduced:
> PTR_ADDU sp, gp, _THREAD_SIZE - 32 - PT_SIZE
>
> Assuming the immediate is in range of signed 16bit.

The immediate would be 32552, so in range of signed 16bit, but that 
would be brittle if either _THREAD_SIZE or PT_SIZE were to change in 
future....

Thanks,
Matt
>
> Cheers
> James
>
>> [...]
>>
>> MBR, Sergei
>
