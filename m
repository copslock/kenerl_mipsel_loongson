Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 16 Nov 2010 00:59:50 +0100 (CET)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:11492 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1492263Ab0KOX7r (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 16 Nov 2010 00:59:47 +0100
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4ce1c9970000>; Mon, 15 Nov 2010 16:00:23 -0800
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 15 Nov 2010 16:00:30 -0800
Received: from dd1.caveonetworks.com ([12.108.191.236]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Mon, 15 Nov 2010 16:00:30 -0800
Message-ID: <4CE1C96F.1030909@caviumnetworks.com>
Date:   Mon, 15 Nov 2010 15:59:43 -0800
From:   David Daney <ddaney@caviumnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     Robert Millan <rmh@gnu.org>, Ralf Baechle <ralf@linux-mips.org>
CC:     wu zhangjin <wuzhangjin@gmail.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org
Subject: Re: [PATCH] Enable AT_PLATFORM for Loongson 2F CPU
References: <20101109154055.GD10799@linux-mips.org>     <1289486855.14828.0@thorin> <1289865028.9277.0@thorin>
In-Reply-To: <1289865028.9277.0@thorin>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 16 Nov 2010 00:00:30.0560 (UTC) FILETIME=[486B5600:01CB8521]
Return-Path: <David.Daney@caviumnetworks.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 28402
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ddaney@caviumnetworks.com
Precedence: bulk
X-list: linux-mips

On 11/15/2010 03:50 PM, Robert Millan wrote:
> El 11/11/10 15:47:35, en/na Robert Millan va escriure:
>> >  -		__cpu_name[cpu] = "ICT Loongson-2";
>> >  +		switch (c->processor_id&  PRID_REV_MASK) {
>> >  +		case PRID_REV_LOONGSON2E:
>> >  +			__cpu_name[cpu] = "ICT Loongson-2E";
> Actually, the V0.2 / V0.3 that follows in cpuinfo output
> already indicates revision.  And I noticed that appending
> the 'E' or 'F' breaks GCC's -march=native option (which
> works by parsing /proc/cpuinfo).
>

Good catch, this is true, __cpu_name for better or worse is part of the 
kernel/user ABI.  GCC parses this in gcc/config/mips/driver-native.c


> Please use this patch instead.
>
>
>
> loongson2f.diff
>
>
>
> Signed-off-by: Robert Millan<rmh@gnu.org>
>

Acked-by: David Daney <ddaney@caviumnetworks.com>


> diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
> index fd1d39e..58844f6 100644
> --- a/arch/mips/include/asm/elf.h
> +++ b/arch/mips/include/asm/elf.h
> @@ -344,6 +344,12 @@ extern int dump_task_fpu(struct task_struct *, elf_fpregset_t *);
>   #define ELF_PLATFORM  __elf_platform
>   extern const char *__elf_platform;
>
> +static inline void set_elf_platform(int cpu, const char *plat)
> +{
> +	if (cpu == 0)
> +		__elf_platform = plat;
> +}
> +
>   /*
>    * See comments in asm-alpha/elf.h, this is the same thing
>    * on the MIPS.
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 71620e1..accde65 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -614,6 +614,14 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>   	case PRID_IMP_LOONGSON2:
>   		c->cputype = CPU_LOONGSON2;
>   		__cpu_name[cpu] = "ICT Loongson-2";
> +		switch (c->processor_id&  PRID_REV_MASK) {
> +		case PRID_REV_LOONGSON2E:
> +			set_elf_platform(cpu, "loongson2e");
> +			break;
> +		case PRID_REV_LOONGSON2F:
> +			set_elf_platform(cpu, "loongson2f");
> +			break;
> +		}
>   		c->isa_level = MIPS_CPU_ISA_III;
>   		c->options = R4K_OPTS |
>   			     MIPS_CPU_FPU | MIPS_CPU_LLSC |
> @@ -957,14 +965,12 @@ static inline void cpu_probe_cavium(struct cpuinfo_mips *c, unsigned int cpu)
>   		c->cputype = CPU_CAVIUM_OCTEON_PLUS;
>   		__cpu_name[cpu] = "Cavium Octeon+";
>   platform:
> -		if (cpu == 0)
> -			__elf_platform = "octeon";
> +		set_elf_platform(cpu, "octeon");
>   		break;
>   	case PRID_IMP_CAVIUM_CN63XX:
>   		c->cputype = CPU_CAVIUM_OCTEON2;
>   		__cpu_name[cpu] = "Cavium Octeon II";
> -		if (cpu == 0)
> -			__elf_platform = "octeon2";
> +		set_elf_platform(cpu, "octeon2");
>   		break;
>   	default:
>   		printk(KERN_INFO "Unknown Octeon chip!\n");
>
