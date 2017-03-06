Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 06 Mar 2017 09:34:23 +0100 (CET)
Received: from mail-lf0-x235.google.com ([IPv6:2a00:1450:4010:c07::235]:33186
        "EHLO mail-lf0-x235.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990517AbdCFIePpzgJB (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 6 Mar 2017 09:34:15 +0100
Received: by mail-lf0-x235.google.com with SMTP id a6so68986289lfa.0
        for <linux-mips@linux-mips.org>; Mon, 06 Mar 2017 00:34:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:references:cc:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-transfer-encoding;
        bh=UM8S3pD7EzxOg3gW1H4bxvR5grpaeHPINKB4wFI82y4=;
        b=1yak+4xsqRxSmm95kZYjHlDWD+R7DhgazsUJzGIluM6PmLMehtPdr3Jks1eeFYPmFV
         mIN1TKoSI5FPWq+4bDEIN4HhqYIDNcpUQiMNe4MMfCZm2IkFSR4o8HEQfSrKmS4IXEiu
         90G8a/wjJmuoOu7ketZAdO0E430ESjWFdzy+/AXTKnFDNVE/vYy4n//kGcITo9yRt3Ih
         u7aswXnAs2VTKlYmuCPsP6Mr+tYJx+nKd+s0MgKO6LxqYfWrSw/CUnK4W79nH4h6ZJmp
         NvuxBdhcqrqhDtqOGzS+dcSXHDrfSi3oZPbylHk85eD8BWc8TrOSJnWOrjRL5Ymoaf+a
         qVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:cc:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding;
        bh=UM8S3pD7EzxOg3gW1H4bxvR5grpaeHPINKB4wFI82y4=;
        b=YETv+PDZMuf7rLNW/iSpcPEfZxMDP0yHhI0KiqBacb5gzLNkOoVW17jRAGXwFALLPQ
         0y8IkZxKwQxeqUP0TeB9cBvsRkH1aiZ0ySH+zjLdB5Uk+5TP+kjT2ekS6oeputlA0+pc
         FUVN6D2OSsYCfBt4Dud4IqYGOaUVpnGL416eHOM7Pdih61MLIuu1gLU4BXrTORPLU85B
         gjMXzx5yN8wZVAnSO9V5dTEHguwj1KaQDYw3pfkmSEvUIuBIGhoVfQxysItWDGT3zf41
         s7E27shcFaWUhOI3KGC+wBuw4SjYbl7lqFcYQA04dEQ/d53ZvaNxQYWRpLMELpizbqAf
         uWYg==
X-Gm-Message-State: AMke39k3W9HRU0mMlhGu+Z7zVlot61JbNu2/iuDoiLyrrOfbtHHFGzj6grmElDHN36rITw==
X-Received: by 10.46.82.66 with SMTP id g63mr4782581ljb.113.1488789248033;
        Mon, 06 Mar 2017 00:34:08 -0800 (PST)
Received: from [192.168.4.126] ([31.173.84.13])
        by smtp.gmail.com with ESMTPSA id a63sm1230166lfa.22.2017.03.06.00.34.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 06 Mar 2017 00:34:07 -0800 (PST)
Subject: Re: [PATCH] MIPS: reset all task's asid to 0 after asid_cache(cpu)
 overflows
To:     jsun4 <Jiwei.Sun@windriver.com>, ralf@linux-mips.org,
        paul.burton@imgtec.com, james.hogan@imgtec.com
References: <1488684260-18867-1-git-send-email-jiwei.sun@windriver.com>
 <6054d364-5095-d13b-ebf8-a7b6bf8b2024@cogentembedded.com>
 <58BD0E0A.9000402@windriver.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        jiwei.sun.bj@qq.com
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <702ff6e3-9bc7-755b-56ec-86394d959230@cogentembedded.com>
Date:   Mon, 6 Mar 2017 11:34:03 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.1
MIME-Version: 1.0
In-Reply-To: <58BD0E0A.9000402@windriver.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sergei.shtylyov@cogentembedded.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 57050
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sergei.shtylyov@cogentembedded.com
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

On 3/6/2017 10:21 AM, jsun4 wrote:

>>> If asid_cache(cpu) overflows, there may be two tasks with the same
>>> asid. It is a risk that the two different tasks may have the same
>>> address space.
>>>
>>> A process will update its asid to newer version only when switch_mm()
>>> is called and matches the following condition:
>>>     if ((cpu_context(cpu, next) ^ asid_cache(cpu))
>>>                     & asid_version_mask(cpu))
>>>             get_new_mmu_context(next, cpu);
>>> If asid_cache(cpu) overflows, cpu_context(cpu,next) and asid_cache(cpu)
>>> will be reset to asid_first_version(cpu), and start a new cycle. It
>>> can result in two tasks that have the same ASID in the process list.
>>>
>>> For example, in CONFIG_CPU_MIPS32_R2, task named A's asid on CPU1 is
>>> 0x100, and has been sleeping and been not scheduled. After a long period
>>> of time, another running task named B's asid on CPU1 is 0xffffffff, and
>>> asid cached in the CPU1 is 0xffffffff too, next task named C is forked,
>>> when schedule from B to C on CPU1, asid_cache(cpu) will overflow, so C's
>>> asid on CPU1 will be 0x100 according to get_new_mmu_context(). A's asid
>>> is the same as C, if now A is rescheduled on CPU1, A's asid is not able
>>> to renew according to 'if' clause, and the local TLB entry can't be
>>> flushed too, A's address space will be the same as C.
>>>
>>> If asid_cache(cpu) overflows, all of user space task's asid on this CPU
>>> are able to set a invalid value (such as 0), it will avoid the risk.
>>>
>>> Signed-off-by: Jiwei Sun <jiwei.sun@windriver.com>
>>> ---
>>>  arch/mips/include/asm/mmu_context.h | 9 ++++++++-
>>>  1 file changed, 8 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/mips/include/asm/mmu_context.h b/arch/mips/include/asm/mmu_context.h
>>> index ddd57ad..1f60efc 100644
>>> --- a/arch/mips/include/asm/mmu_context.h
>>> +++ b/arch/mips/include/asm/mmu_context.h
>>> @@ -108,8 +108,15 @@ static inline void enter_lazy_tlb(struct mm_struct *mm, struct task_struct *tsk)
>>>  #else
>>>          local_flush_tlb_all();    /* start new asid cycle */
>>>  #endif
>>> -        if (!asid)        /* fix version if needed */
>>> +        if (!asid) {        /* fix version if needed */
>>> +            struct task_struct *p;
>>> +
>>> +            for_each_process(p) {
>>> +                if ((p->mm))
>>
>>    Why double parens?
>
> At the beginning, the code was written as following
> 	if ((p->mm) && (p->mm != mm))
> 		cpu_context(cpu, p->mm) = 0;
>
> Because cpu_context(cpu,mm) will be changed to asid_first_version(cpu) after 'for' loop,
> and in order to improve the efficiency of the loop, I deleted "&& (p->mm != mm)",
> but I forgot to delete the redundant parentheses.

    Note that parens around 'p->mm' were never needed. And neither around the 
right operand of &&.

> Thanks,
> Best regards,
> Jiwei

MBR, Sergei
