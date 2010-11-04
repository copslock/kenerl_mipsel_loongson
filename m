Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2010 18:33:35 +0100 (CET)
Received: from hall.aurel32.net ([88.191.82.174]:41150 "EHLO hall.aurel32.net"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S1491869Ab0KDRdc (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Nov 2010 18:33:32 +0100
Received: from [2001:660:5001:1a:200:5efe:86d6:4cf]
        by hall.aurel32.net with esmtpsa (TLS1.0:RSA_AES_256_CBC_SHA1:32)
        (Exim 4.69)
        (envelope-from <aurelien@aurel32.net>)
        id 1PE3gn-0000HR-Lz; Thu, 04 Nov 2010 18:33:29 +0100
Message-ID: <4CD2EE64.5060404@aurel32.net>
Date:   Thu, 04 Nov 2010 18:33:24 +0100
From:   Aurelien Jarno <aurelien@aurel32.net>
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
MIME-Version: 1.0
To:     David Daney <ddaney@caviumnetworks.com>
CC:     Robert Millan <rmh@gnu.org>, Ralf Baechle <ralf@linux-mips.org>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
References: <1288873119.12965.1@thorin> <4CD2E2F7.4090701@caviumnetworks.com>
In-Reply-To: <4CD2E2F7.4090701@caviumnetworks.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8bit
Return-Path: <aurelien@aurel32.net>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28300
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aurelien@aurel32.net
Precedence: bulk
X-list: linux-mips

David Daney a écrit :
> On 11/04/2010 05:18 AM, Robert Millan wrote:
>> Please consider this patch, it enables AT_PLATFORM for Loongson 2F CPU.
>>
>>
> [...]
>> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
>> index 71620e1..504f3b1 100644
>> --- a/arch/mips/kernel/cpu-probe.c
>> +++ b/arch/mips/kernel/cpu-probe.c
>> @@ -614,6 +614,8 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>>  	case PRID_IMP_LOONGSON2:
>>  		c->cputype = CPU_LOONGSON2;
>>  		__cpu_name[cpu] = "ICT Loongson-2";
>> +		if (cpu == 0)
>> +			__elf_platform = "loongson-2f";
>>  		c->isa_level = MIPS_CPU_ISA_III;
>>  		c->options = R4K_OPTS |
>>  			     MIPS_CPU_FPU | MIPS_CPU_LLSC |
> 
> This doesn't look right to me.
> 
> You are claiming that all loongson2 are loongson-2f.  Is that really 
> true?  Or are there other types of loongson2 that are not loongson-2f?
> 
> You need to be very careful here.  This is part of the userspace ABI, so 
> if you get it wrong, you are stuck with it forever.
> 
> One question you didn't address is why userspace would care that it is 
> running on exactly "loongson-2f" instead of just mips4.
> 
> The __elf_platform gets converted to a directory name by ld.so, so you 
> may want to choose a value without '-' in it.
> 
> My suggestion would be to set "loongson2" for the generic CPU_LOONGSON2, 
> and if there is a good reason for it, "loongson2f" for the 'f' variant.
> 

You should definitely define here loongson-2e and loongson-2f
separately. They have the same instruction set, but different opcodes
for the loongson specific instructions, hence they are not compatible.


-- 
Aurelien Jarno                          GPG: 1024D/F1BCDB73
aurelien@aurel32.net                 http://www.aurel32.net
