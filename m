Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Nov 2010 17:44:53 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:12561 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491870Ab0KDQou (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Nov 2010 17:44:50 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4cd2e3230000>; Thu, 04 Nov 2010 09:45:23 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 4 Nov 2010 09:45:21 -0700
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 4 Nov 2010 09:45:21 -0700
Message-ID: <4CD2E2F7.4090701@caviumnetworks.com>
Date:   Thu, 04 Nov 2010 09:44:39 -0700
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.12) Gecko/20100907 Fedora/3.0.7-1.fc12 Thunderbird/3.0.7
MIME-Version: 1.0
To:     Robert Millan <rmh@gnu.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     linux-mips@linux-mips.org
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
References: <1288873119.12965.1@thorin>
In-Reply-To: <1288873119.12965.1@thorin>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Nov 2010 16:45:21.0121 (UTC) FILETIME=[AB6FDD10:01CB7C3F]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28299
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 11/04/2010 05:18 AM, Robert Millan wrote:
>
> Please consider this patch, it enables AT_PLATFORM for Loongson 2F CPU.
>
>
[...]
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 71620e1..504f3b1 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -614,6 +614,8 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>  	case PRID_IMP_LOONGSON2:
>  		c->cputype = CPU_LOONGSON2;
>  		__cpu_name[cpu] = "ICT Loongson-2";
> +		if (cpu == 0)
> +			__elf_platform = "loongson-2f";
>  		c->isa_level = MIPS_CPU_ISA_III;
>  		c->options = R4K_OPTS |
>  			     MIPS_CPU_FPU | MIPS_CPU_LLSC |

This doesn't look right to me.

You are claiming that all loongson2 are loongson-2f.  Is that really 
true?  Or are there other types of loongson2 that are not loongson-2f?

You need to be very careful here.  This is part of the userspace ABI, so 
if you get it wrong, you are stuck with it forever.

One question you didn't address is why userspace would care that it is 
running on exactly "loongson-2f" instead of just mips4.

The __elf_platform gets converted to a directory name by ld.so, so you 
may want to choose a value without '-' in it.

My suggestion would be to set "loongson2" for the generic CPU_LOONGSON2, 
and if there is a good reason for it, "loongson2f" for the 'f' variant.

David Daney
