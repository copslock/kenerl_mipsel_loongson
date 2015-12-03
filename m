Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 03 Dec 2015 15:54:02 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:62235 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012083AbbLCOx6oPeuD (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 3 Dec 2015 15:53:58 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id 1CA8415AA0AA9;
        Thu,  3 Dec 2015 14:53:50 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.235.1; Thu, 3 Dec 2015 14:53:52 +0000
Received: from [192.168.154.116] (192.168.154.116) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 3 Dec
 2015 14:53:51 +0000
Subject: Re: [PATCH 6/9] MIPS: Call relocate_kernel if CONFIG_RELOCATABLE=y
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <linux-mips@linux-mips.org>
References: <1449137297-30464-1-git-send-email-matt.redfearn@imgtec.com>
 <1449137297-30464-7-git-send-email-matt.redfearn@imgtec.com>
 <56605081.5050307@cogentembedded.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <5660577F.2020401@imgtec.com>
Date:   Thu, 3 Dec 2015 14:53:51 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
MIME-Version: 1.0
In-Reply-To: <56605081.5050307@cogentembedded.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.116]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 50318
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

Hi Sergei,

On 03/12/15 14:24, Sergei Shtylyov wrote:
> Hello.
>
> On 12/3/2015 1:08 PM, Matt Redfearn wrote:
>
>> If CONFIG_RELOCATABLE is enabled, jump to relocate_kernel.
>>
>> This function will return the entry point of the relocated kernel if
>> copy/relocate is sucessful or the original entry point if not. The stack
>> pointer must then be pointed into the new image.
>>
>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>> ---
>>   arch/mips/kernel/head.S | 20 ++++++++++++++++++++
>>   1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/mips/kernel/head.S b/arch/mips/kernel/head.S
>> index 4e4cc5b9a771..7dc043349d66 100644
>> --- a/arch/mips/kernel/head.S
>> +++ b/arch/mips/kernel/head.S
>> @@ -132,7 +132,27 @@ not_found:
>>       set_saved_sp    sp, t0, t1
>>       PTR_SUBU    sp, 4 * SZREG        # init stack pointer
>>
>> +#ifdef CONFIG_RELOCATABLE
>> +    /* Copy kernel and apply the relocations */
>> +    jal        relocate_kernel
>> +
>> +    /* Repoint the sp into the new kernel image */
>> +    PTR_LI        sp, _THREAD_SIZE - 32 - PT_SIZE
>> +    PTR_ADDU    sp, $28
>
>    Can't you account for it in the previous PTR_LI?
During relocate_kernel, $28, pointer to the current thread, has been 
moved by an unknown (here) number of bytes to point to the 
init_thread_union within the new kernel. The stack pointer must now be 
pointed there too. Since we don't know the offset from the original 
kernel it's easier to simply recalculate it.

Thanks,
Matt
>
>> +    set_saved_sp    sp, t0, t1
>> +    PTR_SUBU    sp, 4 * SZREG        # init stack pointer
> [...]
>
> MBR, Sergei
>
