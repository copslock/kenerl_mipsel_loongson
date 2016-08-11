Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 11 Aug 2016 13:31:09 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:10291 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992728AbcHKLbDB9sQ8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 11 Aug 2016 13:31:03 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id C4C3E160FE219;
        Thu, 11 Aug 2016 12:30:42 +0100 (IST)
Received: from [127.0.0.1] (10.100.200.106) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 11 Aug
 2016 12:30:45 +0100
Subject: Re: [PATCH] MIPS: Delete unused file smp-gic.c
To:     Matt Redfearn <matt.redfearn@imgtec.com>, <ralf@linux-mips.org>
References: <1470845463-25269-1-git-send-email-matt.redfearn@imgtec.com>
 <a284afa7-caf7-b4fa-e936-03486ef14a7d@imgtec.com>
 <57AC54D1.5020900@imgtec.com>
CC:     <linux-mips@linux-mips.org>
From:   Paul Burton <paul.burton@imgtec.com>
Message-ID: <7087eb68-9369-f2e6-a8ec-97ad8a6e8968@imgtec.com>
Date:   Thu, 11 Aug 2016 12:30:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.2.0
MIME-Version: 1.0
In-Reply-To: <57AC54D1.5020900@imgtec.com>
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.100.200.106]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54484
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On 11/08/16 11:34, Matt Redfearn wrote:
>>> -    gic_send_ipi(intr);
>>> -
>>> -    if (mips_cpc_present() && (core != current_cpu_data.core)) {
>>> -        while (!cpumask_test_cpu(cpu, &cpu_coherent_mask)) {
>>> -            mips_cm_lock_other(core, 0);
>>> -            mips_cpc_lock_other(core);
>>> -            write_cpc_co_cmd(CPC_Cx_CMD_PWRUP);
>>> -            mips_cpc_unlock_other();
>>> -            mips_cm_unlock_other();
>>> -        }
>>> -    }
>> Hi Matt,
>>
>> This patch itself makes sense, but it does bring to light that the IPI
>> IRQ domain stuff will have broken cpuidle. When a core goes into one of
>> the deeper power saving states (becoming clock gated or power gated) it
>> won't automatically wake back up upon interrupts, which is why the bit
>> of code above exists to bring it back out of the power saving state via
>> the CPC.
> 
> There is equivalent code to that removed by the IPI IRQ domain here:
> http://lxr.free-electrons.com/source/arch/mips/kernel/smp.c#L185.
> 
> With a 2c2t Interaptiv, core 1 does seem to be getting clock & power gated:
> # cat /sys/devices/system/cpu/cpu2/cpuidle/state2/desc
> core clock gated
> # cat /sys/devices/system/cpu/cpu2/cpuidle/state3/desc
> core power gated
> # cat /sys/devices/system/cpu/cpu2/cpuidle/state2/time
> 7007
> # cat /sys/devices/system/cpu/cpu2/cpuidle/state3/time
> 300549307
> # cat /sys/devices/system/cpu/cpu3/cpuidle/state2/time
> 8556
> # cat /sys/devices/system/cpu/cpu3/cpuidle/state3/time
> 301527771
> 
> So I think it's all good.

Hi Matt,

Right you are :) I hadn't realised the code had been copied there.

Thanks,
    Paul
