Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 25 Nov 2010 16:57:59 +0100 (CET)
Received: from gateway12.websitewelcome.com ([67.18.21.19]:58695 "HELO
        gateway12.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with SMTP id S1491841Ab0KYP5z (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 25 Nov 2010 16:57:55 +0100
Received: (qmail 3949 invoked from network); 25 Nov 2010 15:57:23 -0000
Received: from gator750.hostgator.com (174.132.194.2)
  by gateway12.websitewelcome.com with SMTP; 25 Nov 2010 15:57:23 -0000
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws; s=default; d=paralogos.com;
        h=Received:Message-ID:Date:From:User-Agent:MIME-Version:To:CC:Subject:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:X-Source:X-Source-Args:X-Source-Dir;
        b=Pj5hOX6IoArmZbGdl9qJxqJ4kSlpoRjjyy2V4xl588nj2pVWvJvaLCPuC79n8ZpC1B7TGMzzzB5PIqKwDjcOx3s85OGt2HuzmWcmRz+/COnbiPBpyV1TwEGhnvyl39Ar;
Received: from [64.139.76.193] (port=50344 helo=kkissell-macbookpro.local)
        by gator750.hostgator.com with esmtpsa (TLSv1:AES256-SHA:256)
        (Exim 4.69)
        (envelope-from <kevink@paralogos.com>)
        id 1PLeCh-0006X7-Kl; Thu, 25 Nov 2010 09:57:48 -0600
Message-ID: <4CEE877C.7020309@paralogos.com>
Date:   Thu, 25 Nov 2010 07:57:48 -0800
From:   "Kevin D. Kissell" <kevink@paralogos.com>
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.5; en-US; rv:1.9.2.12) Gecko/20101027 Thunderbird/3.1.6
MIME-Version: 1.0
To:     Maksim Rayskiy <maksim.rayskiy@gmail.com>
CC:     Ralf Baechle <ralf@linux-mips.org>, linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: ASID conflict after CPU hotplug
References: <AANLkTi=yHm72=sM=QwLpm=aDRnxVf7ZM5=W6eNzgVoTN@mail.gmail.com>      <20101122034141.GA13138@linux-mips.org> <4CEAE1EE.9020406@paralogos.com> <AANLkTimuJLxG2KoibRxzcHkX3LoKsTWqJSF_e=ouFi+b@mail.gmail.com>
In-Reply-To: <AANLkTimuJLxG2KoibRxzcHkX3LoKsTWqJSF_e=ouFi+b@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator750.hostgator.com
X-AntiAbuse: Original Domain - linux-mips.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - paralogos.com
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Return-Path: <kevink@paralogos.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28527
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: kevink@paralogos.com
Precedence: bulk
X-list: linux-mips

This approach certainly makes per_cpu_trap_init() more readable and 
maintainable,  but it has the downside of creating state and 
infrastructure that have footprints elsewhere that add to global cruft 
and complexity.  Note that your patch, as written, wouldn't solve your 
problem, because it doesn't include the code that would actually set and 
clear the elements of your cpu_warm_boot[] array.  If we do need to pay 
attention to warm boot state elsewhere in the kernel (Does any other 
architecture?  That should be a clue...), then some bits in memory like 
that should perhaps be defined (though I'd wonder why it couldn't be a 
bit in some existing per-CPU state entity like cpu_data[]).  Otherwise, 
as I said earlier, the cleanest approach strikes me as one of resetting 
the value of EntryHi as well as the ASID cache when the hotplug event 
takes place.  The cleanest possible outcome would be if one could *move* 
the reset initialization of EntryHi from wherever it is now to 
per_cpu_trap_init(), so there would be *zero* net additional code, but 
it may be (it's Thanksgiving and I'm limited in time and internet 
access, so I can't really go look for you) that it's initialized as a 
side effect of something that happens repeatedly, such that actually 
*moving* it would be dangerous.  But if you have the time, try setting 
up EntryHi explicitly and unconditionally in per_cpu_trap_init() and see 
if it doesn't solve your initial problem.

Happy Holiday to you all,

/K.

On 11/24/10 7:03 PM, Maksim Rayskiy wrote:
> I certainly agree that it is a bad idea to look at the current value
> of asid_cache when figuring out if it is a warm or cold boot.
> I could not tell how the code ended up with this entryHi value after
> the hotplug. So, I can only address the simplest portion of issues you
> mentioned.
> How about we add a variable to tell warm restart from cold and
> preserve asid_cache across hotplug event. It is not much of an
> improvement over the original code, I must admit.
>
> Signed-off-by: Maksim Rayskiy<maksim.rayskiy@gmail.com>
>
> diff --git a/arch/mips/kernel/traps.c b/arch/mips/kernel/traps.c
> index d83f325..9116adb 100644
> --- a/arch/mips/kernel/traps.c
> +++ b/arch/mips/kernel/traps.c
> @@ -1489,6 +1489,8 @@ static int __init ulri_disable(char *s)
>   }
>   __setup("noulri", ulri_disable);
>
> +static int cpu_warm_boot[NR_CPUS];
> +
>   void __cpuinit per_cpu_trap_init(void)
>   {
>          unsigned int cpu = smp_processor_id();
> @@ -1577,7 +1579,9 @@ void __cpuinit per_cpu_trap_init(void)
>          }
>   #endif /* CONFIG_MIPS_MT_SMTC */
>
> -       cpu_data[cpu].asid_cache = ASID_FIRST_VERSION;
> +       if (!cpu_warm_boot[cpu])
> +               cpu_data[cpu].asid_cache = ASID_FIRST_VERSION;
> +       cpu_warm_boot[cpu] = 1;
>          TLBMISS_HANDLER_SETUP();
>
>          atomic_inc(&init_mm.mm_count);
>
>
> On Mon, Nov 22, 2010 at 1:34 PM, Kevin D. Kissell<kevink@paralogos.com>  wrote:
>> On 11/21/10 19:41, Ralf Baechle wrote:
>>> ...
>>> Need to think a little about potencial consequences of your suggested
>>> patch.  It seems ok.  Kevin, what do you think?
>>>
>> Since you ask, while I would imagine that Maksim's patch works fine for him,
>> I'm not sure that it's really the right fix.  I never did succeed in getting
>> CPU hotplugging working back in the 2.6.18 days, so I don't know as much
>> about it as I'd like, but if per_cpu_trap_init() needs to be invoked on a
>> hot plugin event, and if its behavior needs to be different , I'd really,
>> really prefer to see that state propagated explicitly, rather than inferring
>> it from whatever happens to be in cache/memory at cpu_data[cpu].asid_cache.
>>   But beyond that, if the problem arises because setting
>> cpu_data[cpu].asid_cache to a known initial state on a plugin event can
>> conflict with the residual content of EntryHi, rather than creating a
>> special case where we don't initialize the ASID cache, since we seem to be
>> (re)initializing a lot of other privileged state, why aren't we also setting
>> a known sane initial EntryHi value?   Wouldn't that be a cleaner fix?  (And
>> I don't mean that as a rhetorical question - there may be very good reasons
>> to let EntryHi values persist across hot unplug/plug events.  I just can't
>> imagine them offhand over coffee.)
>>
>> /K.
>>
>>
