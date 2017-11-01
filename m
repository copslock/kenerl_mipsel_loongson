Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 01 Nov 2017 10:28:14 +0100 (CET)
Received: from 19pmail.ess.barracuda.com ([64.235.154.231]:43060 "EHLO
        19pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990504AbdKAJ2H0Ayp0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 1 Nov 2017 10:28:07 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Wed, 01 Nov 2017 09:27:21 +0000
Received: from [10.150.130.83] (10.150.130.83) by MIPSMAIL01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server (TLS) id 14.3.361.1; Wed, 1 Nov 2017
 02:26:46 -0700
Subject: Re: [PATCH v4 13/13] openrisc: add tick timer multi-core sync logic
To:     Stafford Horne <shorne@gmail.com>
CC:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Jan Henrik Weinstock <jan.weinstock@ice.rwth-aachen.de>,
        Matt Redfearn <matt.redfearn@imgtec.com>,
        James Hogan <james.hogan@imgtec.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        <openrisc@lists.librecores.org>,
        Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>,
        James Hogan <james.hogan@mips.com>,
        Linux MIPS Mailing List <linux-mips@linux-mips.org>
References: <20171029231123.27281-1-shorne@gmail.com>
 <20171029231123.27281-14-shorne@gmail.com>
 <05333dd1-f8df-c96e-03df-1623ff67ab39@mips.com>
 <20171031231759.GB29237@lianli.shorne-pla.net>
 <20171101003447.GC29237@lianli.shorne-pla.net>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <132de3e6-52b5-b5fe-8199-9da427a1baf4@mips.com>
Date:   Wed, 1 Nov 2017 09:26:43 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20171101003447.GC29237@lianli.shorne-pla.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
X-Originating-IP: [10.150.130.83]
X-BESS-ID: 1509528440-452059-3093-481479-1
X-BESS-VER: 2017.12.1-r1710261623
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.186476
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 60629
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



On 01/11/17 00:34, Stafford Horne wrote:
> On Wed, Nov 01, 2017 at 08:17:59AM +0900, Stafford Horne wrote:
>> On Tue, Oct 31, 2017 at 02:06:21PM +0000, Matt Redfearn wrote:
>>> Hi,
>>>
>>>
>>> On 29/10/17 23:11, Stafford Horne wrote:
>>>> In case timers are not in sync when cpus start (i.e. hot plug / offset
>>>> resets) we need to synchronize the secondary cpus internal timer with
>>>> the main cpu.  This is needed as in OpenRISC SMP there is only one
>>>> clocksource registered which reads from the same ttcr register on each
>>>> cpu.
>>>>
>>>> This synchronization routine heavily borrows from mips implementation that
>>>> does something similar.
>> [..]
>>>> diff --git a/arch/openrisc/kernel/smp.c b/arch/openrisc/kernel/smp.c
>>>> index 4763b8b9161e..4d80ce6fa045 100644
>>>> --- a/arch/openrisc/kernel/smp.c
>>>> +++ b/arch/openrisc/kernel/smp.c
>>>> @@ -100,6 +100,7 @@ int __cpu_up(unsigned int cpu, struct task_struct *idle)
>>>>    		pr_crit("CPU%u: failed to start\n", cpu);
>>>>    		return -EIO;
>>>>    	}
>>>> +	synchronise_count_master(cpu);
>>>>    	return 0;
>>>>    }
>>>> @@ -129,6 +130,8 @@ asmlinkage __init void secondary_start_kernel(void)
>>>>    	set_cpu_online(cpu, true);
>>>>    	complete(&cpu_running);
>>>> +	synchronise_count_slave(cpu);
>>>> +
>>>
>>> Note that until 8f46cca1e6c06a058374816887059bcc017b382f, the MIPS timer
>>> synchronization code contained the possibility of deadlock. If you mark a
>>> CPU online before it goes into the synchronize loop, then the boot CPU can
>>> schedule a different thread and send IPIs to all "online" CPUs. It gets
>>> stuck waiting for the secondary to ack it's IPI, since this secondary CPU
>>> has not enabled IRQs yet, and is stuck waiting for the master to synchronise
>>> with it. The system then deadlocks.
>>> Commit 8f46cca1e6c06a058374816887059bcc017b382f fixed this for MIPS and you
>>> might want to similarly move the
>>>
>>> set_cpu_online(cpu, true);
>>>
>>> after counters are synchronized.
>> Thank you for the heads up.  I do remember having interim issues with the timer
>> syncing but I havent seen it for a while.  I think I fixed it by also moving
>> synchronise_count_slave.
>>
>> Let me double check.  Also, I see your patch 8f46cca1e6c06a0583748168 was merged
>> last year?
> Hello,
>
> I should have read a bit more closely, definitely this could be an issue if the
> boot cpu has other things running.
>
> However, looking at mainline I can see the clock sync comes after set_cpu_online
> again after this patch in mips.
>
>    6f542ebeaee0 MIPS: Fix race on setting and getting cpu_online_mask
>    Author: Matija Glavinic Pecotic <matija.glavinic-pecotic.ext@nokia.com>
>
> Is this deadlock an issue in mips again?
>
> -Stafford

Hi Stafford,

Yes - the deadlock is an issue again, it was re-introduced by 
6f542ebeaee0. That patch was based on testing with 4.4, where the core 
CPU hotplug code did not contain it's own completion event. Since commit 
8df3e07e7f21f ("cpu/hotplug: Let upcoming cpu bring itself fully up"), 
which was added in 4.6, this is no longer the case and there is no race 
condition. I have https://patchwork.linux-mips.org/patch/17376/ pending 
which fixes this race in pre-4.6 stable kernels, and guards against the 
deadlock as well. Unfortunately because of the backport to stable this 
gets a little more complex.

Unless your patches to add SMP are going to be applied to pre-4.6 
kernels, then you will not suffer the race condition. The potential 
deadlock is the only pitfall you need to guard against - which will be 
OK if you put the clock sync before marking the CPU online.

Thanks,
Matt
