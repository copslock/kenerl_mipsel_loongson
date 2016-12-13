Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 13 Dec 2016 11:33:52 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:60264 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23990521AbcLMKdovVsDS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 13 Dec 2016 11:33:44 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 0B7A2E5E332E7;
        Tue, 13 Dec 2016 10:33:36 +0000 (GMT)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Tue, 13 Dec
 2016 10:33:37 +0000
Subject: Re: [PATCH] MIPS: OCTEON: Enable KASLR
To:     David Daney <ddaney@caviumnetworks.com>,
        "Steven J. Hill" <Steven.Hill@cavium.com>,
        <linux-mips@linux-mips.org>, <ralf@linux-mips.org>
References: <4bc97883-39b4-1a00-6e06-518c598bbf3c@cavium.com>
 <bb09e7fa-d13d-979d-8496-83006014cedc@caviumnetworks.com>
 <d7c6f6b5-bbe4-2ede-4f68-7543db918bbe@imgtec.com>
 <dca26961-ba25-d256-36c0-aa0f8a848439@caviumnetworks.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <80d05ca7-cf27-7fe6-69ed-8f53266b5fe7@imgtec.com>
Date:   Tue, 13 Dec 2016 10:33:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <dca26961-ba25-d256-36c0-aa0f8a848439@caviumnetworks.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56023
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

Hi David,


On 12/12/16 18:52, David Daney wrote:
> On 12/12/2016 01:56 AM, Matt Redfearn wrote:
>> Hi David,
>>
>>
>> On 09/12/16 18:46, David Daney wrote:
>>> On 12/09/2016 01:35 AM, Steven J. Hill wrote:
>>>> This patch enables KASLR for OCTEON systems. The SMP startup code is
>>>> such that the secondaries monitor the volatile variable
>>>> 'octeon_processor_relocated_kernel_entry' for any non-zero value.
>>>> The 'plat_post_relocation hook' is used to set that value to the
>>>> kernel entry point of the relocated kernel. The secondary CPUs will
>>>> then jumps to the new kernel, perform their initialization again
>>>> and begin waiting for the boot CPU to start them via the relocated
>>>> loop 'octeon_spin_wait_boot'. Inspired by Steven's code from Cavium.
>>>>
>>>> Signed-off-by: Matt Redfearn <matt.redfearn@imgtec.com>
>>>> Signed-off-by: Steven J. Hill <Steven.Hill@cavium.com>
>>>> ---
>>>>  arch/mips/Kconfig |  3 ++-
>>>>  arch/mips/cavium-octeon/smp.c |  7 +++++--
>>>>  .../include/asm/mach-cavium-octeon/kernel-entry-init.h    | 15
>>>> ++++++++++++++-
>>>>  3 files changed, 21 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
>>>> index b3c5bde..65d7e20 100644
>>>> --- a/arch/mips/Kconfig
>>>> +++ b/arch/mips/Kconfig
>>>> @@ -909,6 +909,7 @@ config CAVIUM_OCTEON_SOC
>>>>      select NR_CPUS_DEFAULT_16
>>>>      select BUILTIN_DTB
>>>>      select MTD_COMPLEX_MAPPINGS
>>>> +    select SYS_SUPPORTS_RELOCATABLE
>>>>      help
>>>>        This option supports all of the Octeon reference boards from
>>>> Cavium
>>>>        Networks. It builds a kernel that dynamically determines the
>>>> Octeon
>>>> @@ -2570,7 +2571,7 @@ config SYS_SUPPORTS_NUMA
>>>>
>>>>  config RELOCATABLE
>>>>      bool "Relocatable kernel"
>>>> -    depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 ||
>>>> CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6)
>>>> +    depends on SYS_SUPPORTS_RELOCATABLE && (CPU_MIPS32_R2 ||
>>>> CPU_MIPS64_R2 || CPU_MIPS32_R6 || CPU_MIPS64_R6 || CAVIUM_OCTEON_SOC)
>>>>      help
>>>>        This builds a kernel image that retains relocation information
>>>>        so it can be loaded someplace besides the default 1MB.
>>>> diff --git a/arch/mips/cavium-octeon/smp.c
>>>> b/arch/mips/cavium-octeon/smp.c
>>>> index 256fe6f..65c8369 100644
>>>> --- a/arch/mips/cavium-octeon/smp.c
>>>> +++ b/arch/mips/cavium-octeon/smp.c
>>>> @@ -24,12 +24,17 @@
>>>>  volatile unsigned long octeon_processor_boot = 0xff;
>>>>  volatile unsigned long octeon_processor_sp;
>>>>  volatile unsigned long octeon_processor_gp;
>>>> +#ifdef CONFIG_RELOCATABLE
>>>> +volatile unsigned long octeon_processor_relocated_kernel_entry;
>>>> +#endif /* CONFIG_RELOCATABLE */
>>>>
>>>>  #ifdef CONFIG_HOTPLUG_CPU
>>>>  uint64_t octeon_bootloader_entry_addr;
>>>>  EXPORT_SYMBOL(octeon_bootloader_entry_addr);
>>>>  #endif
>>>>
>>>> +extern void kernel_entry(unsigned long arg1, ...);
>>>> +
>>>>  static void octeon_icache_flush(void)
>>>>  {
>>>>      asm volatile ("synci 0($0)\n");
>>>> @@ -333,8 +338,6 @@ void play_dead(void)
>>>>          ;
>>>>  }
>>>>
>>>> -extern void kernel_entry(unsigned long arg1, ...);
>>>> -
>>>>  static void start_after_reset(void)
>>>>  {
>>>>      kernel_entry(0, 0, 0);    /* set a2 = 0 for secondary core */
>>>> diff --git
>>>> a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
>>>> b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
>>>> index c4873e8..f69611c 100644
>>>> --- a/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
>>>> +++ b/arch/mips/include/asm/mach-cavium-octeon/kernel-entry-init.h
>>>> @@ -99,9 +99,22 @@
>>>>      # to begin
>>>>      #
>>>>
>>>> +octeon_spin_wait_boot:
>>>> +#ifdef CONFIG_RELOCATABLE
>>>> +    PTR_LA    t0, octeon_processor_relocated_kernel_entry
>>>> +    LONG_L    t0, (t0)
>>>> +    beq    zero, t0, 1f
>>>> +
>>>
>>> This doesn't look correct.
>>>
>>> Please explain how this code implements:
>>>
>>>    loop here until octeon_processor_relocated_kernel_entry is set.
>>
>> This part of the loop is checking if
>> octeon_processor_relocated_kernel_entry becomes set, in which case don't
>> take the branch and jump to the relocated kernel entry point that has
>> been stored in octeon_processor_relocated_kernel_entry by the boot CPU
>> (that part was missing from Stephens v1 post of this patch). Otherwise
>> the semantics of the loop remain the same as before, checking for
>> octeon_processor_boot to be non-zero to start a secondary running this
>> kernel.
>>
>> This same loop is executed in the relocated kernel and of course in that
>> case octeon_processor_relocated_kernel_entry will not be set, just
>> octeon_processor_boot will be set when the boot CPU is starting the
>> secondary CPUs.
>
> OK, I now understand what is being done.
>
> Is it ever the case that we will have CONFIG_RELOCATABLE, and not do 
> the relocation?
>
> If not, before relocation we never need to poll octeon_processor_boot 
> before relocation.  We could branch to a point that polls 
> octeon_processor_boot after we leave the loop that waits for the 
> relocation to complete.
>
> Maybe it is not that big a deal.

There are a few bail-out paths that can be taken if the kernel cannot be 
relocated, for example if any relocation fails to apply, or if "nokaslr" 
is passed on the command line, so yes that is possible.

>
>>
>>>
>>>
>>>
>>>> +    /* If kernel has been relocated, jump to it's new entry point */
>>>> +    move    a0, zero
>>>> +    move    a1, zero
>>>> +    move    a2, zero
>>>
>>> Why change the values of a*?  Don't these registers already contain
>>> the proper values from the bootloader?
>>
>> I don't see where the secondaries make use of any arguments passed from
>> the bootloader in the entry code.
>
>
> In the line that says:
>    bne    a2, zero, octeon_main_processor
>
>
>> But this follows the same semantics as
>> the CPU hotplug code, which restarts secondaries with their arguments
>> set to 0.
>
> Yes, for the secondaries the argument registers are set to zero, but 
> that is so that when they pass through the branch shown above that 
> they get to the proper place.
>
> In this code, we are coming from the bootloader, and these registers 
> already have the proper value.
>
> Adding these three MOVE instructions makes it look like you are taking 
> some needed action when in fact it is unneeded code that only serves 
> to confuse.
>
> I would really like that removed as it just clutters things up and 
> will lead people to think that it is necessary.

OK, makes sense, Steven, could you make the changes, test and re-post?

Thanks,
Matt

>
>
> David.
>
>>
>> Thanks,
>> Matt
>>
>>>
>>>> +    jr    t0
>>>> +1:
>>>> +#endif /* CONFIG_RELOCATABLE */
>>>> +
>>>>      # This is the variable where the next core to boot os stored
>>>>      PTR_LA    t0, octeon_processor_boot
>>>> -octeon_spin_wait_boot:
>>>>      # Get the core id of the next to be booted
>>>>      LONG_L    t1, (t0)
>>>>      # Keep looping if it isn't me
>>>>
>>>
>>>
>>
>
