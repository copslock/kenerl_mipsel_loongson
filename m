Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 25 Mar 2011 12:28:36 +0100 (CET)
Received: from mail-ew0-f49.google.com ([209.85.215.49]:48642 "EHLO
        mail-ew0-f49.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491077Ab1CYL2c (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 25 Mar 2011 12:28:32 +0100
Received: by ewy3 with SMTP id 3so531299ewy.36
        for <multiple recipients>; Fri, 25 Mar 2011 04:28:26 -0700 (PDT)
Received: by 10.14.126.204 with SMTP id b52mr291327eei.9.1301052506369;
        Fri, 25 Mar 2011 04:28:26 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.93.46])
        by mx.google.com with ESMTPS id w59sm678898eeh.3.2011.03.25.04.28.23
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 25 Mar 2011 04:28:24 -0700 (PDT)
Message-ID: <4D8C7C01.9080107@mvista.com>
Date:   Fri, 25 Mar 2011 14:26:57 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Jayachandran C <jayachandranc@netlogicmicro.com>
CC:     ralf@linux-mips.org, linux-mips@linux-mips.org
Subject: Re: [PATCH 1/7] Netlogic XLR/XLS processor IDs.
References: <cover.1301028080.git.jayachandranc@netlogicmicro.com> <bf492d3d03640f86bdd9963d892545423567451d.1301028081.git.jayachandranc@netlogicmicro.com>
In-Reply-To: <bf492d3d03640f86bdd9963d892545423567451d.1301028081.git.jayachandranc@netlogicmicro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29548
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 25-03-2011 7:57, Jayachandran C wrote:

> Add Netlogic Microsystems company ID and processor IDs for XLR
> and XLS processors for CPU probe. Add CPU_XLR to cpu_type_enum.

> Signed-off-by: Jayachandran C<jayachandranc@netlogicmicro.com>
[...]

> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index f65d4c8..a995d56 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -988,6 +988,59 @@ static inline void cpu_probe_ingenic(struct cpuinfo_mips *c, unsigned int cpu)
>   	}
>   }
>
> +static inline void cpu_probe_netlogic(struct cpuinfo_mips *c, int cpu)
> +{
> +	decode_configs(c);
> +
> +	c->options = (MIPS_CPU_TLB     |

    Perhaps should align | with others...

> +			MIPS_CPU_4KEX    |
> +			MIPS_CPU_COUNTER |
> +			MIPS_CPU_DIVEC   |
> +			MIPS_CPU_WATCH   |
> +			MIPS_CPU_EJTAG   |
> +			MIPS_CPU_LLSC);
[...]
> +	default:
> +		printk(KERN_INFO "Unknown Netlogic chip id [%02x]!\n",

    Not %04x?

> +		       c->processor_id);
> +		c->cputype = CPU_XLR;
> +		break;
> +	}
> +
> +	c->isa_level = MIPS_CPU_ISA_M64R1;
> +	c->tlbsize = ((read_c0_config1() >> 25) & 0x3f) + 1;
> +}
> +
>   #ifdef CONFIG_64BIT
>   /* For use by uaccess.h */
>   u64 __ua_limit;

WBR, Sergei
