Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 16 Mar 2011 13:02:56 +0100 (CET)
Received: from mail-wy0-f177.google.com ([74.125.82.177]:57562 "EHLO
        mail-wy0-f177.google.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491052Ab1CPMCy (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 16 Mar 2011 13:02:54 +0100
Received: by wyb28 with SMTP id 28so1608098wyb.36
        for <multiple recipients>; Wed, 16 Mar 2011 05:02:48 -0700 (PDT)
Received: by 10.227.21.145 with SMTP id j17mr741422wbb.33.1300276967739;
        Wed, 16 Mar 2011 05:02:47 -0700 (PDT)
Received: from [192.168.2.2] ([91.79.96.124])
        by mx.google.com with ESMTPS id h39sm538744wes.5.2011.03.16.05.02.45
        (version=TLSv1/SSLv3 cipher=OTHER);
        Wed, 16 Mar 2011 05:02:46 -0700 (PDT)
Message-ID: <4D80A691.2020902@mvista.com>
Date:   Wed, 16 Mar 2011 15:01:21 +0300
From:   Sergei Shtylyov <sshtylyov@mvista.com>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-GB; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
MIME-Version: 1.0
To:     Jayachandran C <jayachandranc@netlogicmicro.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 1/7] Netlogic XLR/XLS processor IDs.
References: <cover.1300275485.git.jayachandranc@netlogicmicro.com> <d1e612aba3921501184783470ef06de5fbc2bc51.1300275485.git.jayachandranc@netlogicmicro.com>
In-Reply-To: <d1e612aba3921501184783470ef06de5fbc2bc51.1300275485.git.jayachandranc@netlogicmicro.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-Path: <sshtylyov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29390
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: sshtylyov@mvista.com
Precedence: bulk
X-list: linux-mips

Hello.

On 16-03-2011 14:57, Jayachandran C wrote:

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
> +			MIPS_CPU_4KEX    |
> +			MIPS_CPU_COUNTER |
> +			MIPS_CPU_DIVEC   |
> +			MIPS_CPU_WATCH   |
> +			MIPS_CPU_EJTAG   |
> +			MIPS_CPU_LLSC);
> +
> +	switch (c->processor_id&  0xff00) {
> +	case PRID_IMP_NETLOGIC_XLR732:
> +	case PRID_IMP_NETLOGIC_XLR716:
> +	case PRID_IMP_NETLOGIC_XLR532:
> +	case PRID_IMP_NETLOGIC_XLR308:
> +	case PRID_IMP_NETLOGIC_XLR532C:
> +	case PRID_IMP_NETLOGIC_XLR516C:
> +	case PRID_IMP_NETLOGIC_XLR508C:
> +	case PRID_IMP_NETLOGIC_XLR308C:
> +		c->cputype = CPU_XLR;
> +		__cpu_name[cpu] = "Netlogic XLR";
> +		break;
> +
> +	case PRID_IMP_NETLOGIC_XLS608:
> +	case PRID_IMP_NETLOGIC_XLS408:
> +	case PRID_IMP_NETLOGIC_XLS404:
> +	case PRID_IMP_NETLOGIC_XLS208:
> +	case PRID_IMP_NETLOGIC_XLS204:
> +	case PRID_IMP_NETLOGIC_XLS108:
> +	case PRID_IMP_NETLOGIC_XLS104:
> +	case PRID_IMP_NETLOGIC_XLS616B:
> +	case PRID_IMP_NETLOGIC_XLS608B:
> +	case PRID_IMP_NETLOGIC_XLS416B:
> +	case PRID_IMP_NETLOGIC_XLS412B:
> +	case PRID_IMP_NETLOGIC_XLS408B:
> +	case PRID_IMP_NETLOGIC_XLS404B:
> +		c->cputype = CPU_XLR;
> +		__cpu_name[cpu] = "Netlogic XLS";
> +		break;
> +
> +	default:
> +		printk(KERN_INFO "Unknown Netlogic chip id [%02x]!\n",
> +		       c->processor_id);
> +		c->cputype = CPU_XLR;

    Why repeat this assignemnt in every case? Do it once only.

WBR, Sergei
