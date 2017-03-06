Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Mar 2017 08:21:31 +0100 (CET)
Received: from mail1.windriver.com ([147.11.146.13]:56745 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990517AbdCFHVXRGy4E (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Mar 2017 08:21:23 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.15.2/8.15.1) with ESMTPS id v267L8vu029038
        (version=TLSv1 cipher=AES128-SHA bits=128 verify=FAIL);
        Sun, 5 Mar 2017 23:21:08 -0800 (PST)
Received: from [128.224.155.85] (128.224.155.85) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.294.0; Sun, 5 Mar
 2017 23:21:07 -0800
From:   jsun4 <Jiwei.Sun@windriver.com>
Subject: Re: [PATCH] MIPS: reset all task's asid to 0 after asid_cache(cpu)
 overflows
To:     Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>,
        <ralf@linux-mips.org>, <paul.burton@imgtec.com>,
        <james.hogan@imgtec.com>
References: <1488684260-18867-1-git-send-email-jiwei.sun@windriver.com>
 <6054d364-5095-d13b-ebf8-a7b6bf8b2024@cogentembedded.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        <jiwei.sun.bj@qq.com>
Message-ID: <58BD0E0A.9000402@windriver.com>
Date:   Mon, 6 Mar 2017 15:21:46 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.6.0
MIME-Version: 1.0
In-Reply-To: <6054d364-5095-d13b-ebf8-a7b6bf8b2024@cogentembedded.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.155.85]
Return-Path: <Jiwei.Sun@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57048
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Jiwei.Sun@windriver.com
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

Hello Sergei,

Thanks for your reply.

On 03/05/2017 05:38 PM, Sergei Shtylyov wrote:
> Hello!
> 
> On 3/5/2017 6:24 AM, Jiwei Sun wrote:
> 
>> If asid_cache(cpu) overflows, there may be two tasks with the same
>> asid. It is a risk that the two different tasks may have the same
>> address space.
>>
>> A process will update its asid to newer version only when switch_mm()
>> is called and matches the following condition:
>>     if ((cpu_context(cpu, next) ^ asid_cache(cpu))
>>                     & asid_version_mask(cpu))
>>             get_new_mmu_context(next, cpu);
>> If asid_cache(cpu) overflows, cpu_context(cpu,next) and asid_cache(cpu)
>> will be reset to asid_first_version(cpu), and start a new cycle. It
>> can result in two tasks that have the same ASID in the process list.
>>
>> For example, in CONFIG_CPU_MIPS32_R2, task named A's asid on CPU1 is
>> 0x100, and has been sleeping and been not scheduled. After a long period
>> of time, another running task named B's asid on CPU1 is 0xffffffff, and
>> asid cached in the CPU1 is 0xffffffff too, next task named C is forked,
>> when schedule from B to C on CPU1, asid_cache(cpu) will overflow, so C's
>> asid on CPU1 will be 0x100 according to get_new_mmu_context(). A's asid
>> is the same as C, if now A is rescheduled on CPU1, A's asid is not able
>> to renew according to 'if' clause, and the local TLB entry can't be
>> flushed too, A's address space will be the same as C.
>>
>> If asid_cache(cpu) overflows, all of user space task's asid on this CPU
>> are able to set a invalid value (such as 0), it will avoid the risk.
>>
>> Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
>> ---
>>  arch/mips/include/asm/mmu_context.h | 9 ++++++++-
>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>
>> diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
>> index ddd57ad..1f60efc 100644
>> --- a/arch/mips/include/asm/mmu_context.h
>> +++ b/arch/mips/include/asm/mmu_context.h
>> @@ -108,8 +108,15 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
>>  #else
>>          local_flush_tlb_all();    /* start new asid cycle */
>>  #endif
>> -        if (!asid)        /* fix version if needed */
>> +        if (!asid) {        /* fix version if needed */
>> +            struct task_struct *p;
>> +
>> +            for_each_process(p) {
>> +                if ((p->mm))
> 
>    Why double parens?

At the beginning, the code was written as following
	if ((p->mm) && (p->mm != mm))
		cpu_context(cpu, p->mm) = 0;

Because cpu_context(cpu,mm) will be changed to asid_first_version(cpu) after 'for' loop,
and in order to improve the efficiency of the loop, I deleted "&& (p->mm != mm)",
but I forgot to delete the redundant parentheses.

Thanks,
Best regards,
Jiwei

> 
>> +                    cpu_context(cpu, p->mm) = 0;
>> +            }
>>              asid = asid_first_version(cpu);
>> +        }
>>      }
>>
>>      cpu_context(cpu, mm) = asid_cache(cpu) = asid;
> 
> MBR, Sergei
> 
