Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 29 Jun 2013 01:43:59 +0200 (CEST)
Received: from arroyo.ext.ti.com ([192.94.94.40]:51863 "EHLO arroyo.ext.ti.com"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6824104Ab3F1XnzRcAV0 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Sat, 29 Jun 2013 01:43:55 +0200
Received: from dlelxv90.itg.ti.com ([172.17.2.17])
        by arroyo.ext.ti.com (8.13.7/8.13.7) with ESMTP id r5SNhGxq013054;
        Fri, 28 Jun 2013 18:43:16 -0500
Received: from DFLE73.ent.ti.com (dfle73.ent.ti.com [128.247.5.110])
        by dlelxv90.itg.ti.com (8.14.3/8.13.8) with ESMTP id r5SNhGga007518;
        Fri, 28 Jun 2013 18:43:16 -0500
Received: from dlelxv22.itg.ti.com (172.17.1.197) by DFLE73.ent.ti.com
 (128.247.5.110) with Microsoft SMTP Server id 14.2.342.3; Fri, 28 Jun 2013
 18:43:15 -0500
Received: from [158.218.103.117] (ula0393909.am.dhcp.ti.com [158.218.103.117])
        by dlelxv22.itg.ti.com (8.13.8/8.13.8) with ESMTP id r5SNhEhb007523;    Fri, 28
 Jun 2013 18:43:14 -0500
Message-ID: <51CE1F92.3070802@ti.com>
Date:   Fri, 28 Jun 2013 19:43:14 -0400
From:   Santosh Shilimkar <santosh.shilimkar@ti.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/17.0 Thunderbird/17.0
MIME-Version: 1.0
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
CC:     Jean-Christophe PLAGNIOL-VILLARD <plagnioj@jcrosoft.com>,
        Grant Likely <grant.likely@linaro.org>,
        Rob Herring <robherring2@gmail.com>,
        Nicolas Pitre <nicolas.pitre@linaro.org>,
        linux-mips <linux-mips@linux-mips.org>,
        Aurelien Jacquiot <a-jacquiot@ti.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Paul Mackerras <paulus@samba.org>,
        Jonas Bonn <jonas@southpole.se>,
        Russell King <linux@arm.linux.org.uk>,
        <linux-c6x-dev@linux-c6x.org>, <x86@kernel.org>, <arm@kernel.org>,
        <linux-xtensa@linux-xtensa.org>,
        James Hogan <james.hogan@imgtec.com>,
        devicetree-discuss <devicetree-discuss@lists.ozlabs.org>,
        Rob Herring <rob.herring@calxeda.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        Chris Zankel <chris@zankel.net>,
        Vineet Gupta <vgupta@synopsys.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Ralf Baechle <ralf@linux-mips.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] of: Specify initrd location using 64-bit
References: <1371775956-16453-1-git-send-email-santosh.shilimkar@ti.com> <51C4171C.9050908@linutronix.de> <51C48B5A.2040404@ti.com> <51CCA67C.2010803@gmail.com> <CACxGe6vOH0sCFVVXrYqD3dbYdOvithVu7-d1cvy5885i8x_Myw@mail.gmail.com> <20130628134931.GD21034@game.jcrosoft.org>
In-Reply-To: <20130628134931.GD21034@game.jcrosoft.org>
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-Path: <santosh.shilimkar@ti.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 37218
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: santosh.shilimkar@ti.com
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


Sebastian,

On Friday 28 June 2013 09:49 AM, Jean-Christophe PLAGNIOL-VILLARD wrote:
> On 10:59 Fri 28 Jun     , Grant Likely wrote:
>> On Thu, Jun 27, 2013 at 9:54 PM, Rob Herring <robherring2@gmail.com> wrote:
>>> On 06/21/2013 12:20 PM, Santosh Shilimkar wrote:
>>>> On Friday 21 June 2013 05:04 AM, Sebastian Andrzej Siewior wrote:
>>>>> On 06/21/2013 02:52 AM, Santosh Shilimkar wrote:
>>>>>> diff --git a/arch/microblaze/kernel/prom.c b/arch/microblaze/kernel/prom.c
>>>>>> index 0a2c68f..62e2e8f 100644
>>>>>> --- a/arch/microblaze/kernel/prom.c
>>>>>> +++ b/arch/microblaze/kernel/prom.c
>>>>>> @@ -136,8 +136,7 @@ void __init early_init_devtree(void *params)
>>>>>>  }
>>>>>>
>>>>>>  #ifdef CONFIG_BLK_DEV_INITRD
>>>>>> -void __init early_init_dt_setup_initrd_arch(unsigned long start,
>>>>>> -           unsigned long end)
>>>>>> +void __init early_init_dt_setup_initrd_arch(u64 start, u64 end)
>>>>>>  {
>>>>>>     initrd_start = (unsigned long)__va(start);
>>>>>>     initrd_end = (unsigned long)__va(end);
>>>>>
>>>>> I think it would better to go here for phys_addr_t instead of u64. This
>>>>> would force you in of_flat_dt_match() to check if the value passed from
>>>>> DT specifies a memory address outside of 32bit address space and the
>>>>> kernel can't deal with this because its phys_addr_t is 32bit only due
>>>>> to a Kconfig switch.
>>>>>
>>>>> For x86, the initrd has to remain in the 32bit address space so passing
>>>>> the initrd in the upper range would violate the ABI. Not sure if this
>>>>> is true for other archs as well (ARM obviously not).
>>>>>
>>>> That pretty much means phys_addr_t. It will work for me as well but
>>>> in last thread from consistency with memory and reserved node, Rob
>>>> insisted to keep it as u64. So before I re-spin another version,
>>>> would like to here what Rob has to say considering the x86 requirement.
>>>>
>>>> Rob,
>>>> Are you ok with phys_addr_t since your concern was about rest
>>>> of the memory specific bits of the device-tree code use u64 ?
>>>
>>> No. I still think it should be u64 for same reasons I said originally.
>>
>> +1
>>
> +1
> 
> fix type
> 
Apart from waste of 32bit, what is the other concern you
have ? I really want to converge on this patch because it
has been a open ended discussion for quite some time. Does
that really break any thing on x86 or your concern is more
from semantics of the physical address.

Thanks for help.

Regards,
Santosh
