Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 22 Sep 2011 19:30:37 +0200 (CEST)
Received: from mail3.caviumnetworks.com ([12.108.191.235]:6157 "EHLO
        mail3.caviumnetworks.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S1491927Ab1IVRa3 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 22 Sep 2011 19:30:29 +0200
Received: from caexch01.caveonetworks.com (Not Verified[192.168.16.9]) by mail3.caviumnetworks.com with MailMarshal (v6,7,2,8378)
        id <B4e7b70fd0001>; Thu, 22 Sep 2011 10:31:41 -0700
Received: from caexch01.caveonetworks.com ([192.168.16.9]) by caexch01.caveonetworks.com with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 22 Sep 2011 10:30:26 -0700
Received: from dd1.caveonetworks.com ([64.2.3.195]) by caexch01.caveonetworks.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.4675);
         Thu, 22 Sep 2011 10:30:26 -0700
Message-ID: <4E7B70B1.2080607@cavium.com>
Date:   Thu, 22 Sep 2011 10:30:25 -0700
From:   David Daney <david.daney@cavium.com>
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Thunderbird/3.0.10
MIME-Version: 1.0
To:     David Daney <david.daney@cavium.com>
CC:     linux-mips@linux-mips.org, ralf@linux-mips.org
Subject: Re: [PATCH 2/2] MIPS: Add probes for more Octeon II CPUs.
References: <1316712378-7282-1-git-send-email-david.daney@cavium.com> <1316712378-7282-3-git-send-email-david.daney@cavium.com>
In-Reply-To: <1316712378-7282-3-git-send-email-david.daney@cavium.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 22 Sep 2011 17:30:26.0849 (UTC) FILETIME=[5130B110:01CC794D]
X-archive-position: 31134
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: david.daney@cavium.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 12729

Crap, this is the wrong patch, it is from the other patch set.

I will now send the right 2/5

On 09/22/2011 10:26 AM, David Daney wrote:
> Detect cn61XX, cn66XX and cn68XX CPUs in cpu_probe_cavium().
>
> Signed-off-by: David Daney<david.daney@cavium.com>
> ---
>   arch/mips/kernel/cpu-probe.c |    3 +++
>   1 files changed, 3 insertions(+), 0 deletions(-)
>
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index ebc0cd2..aa327a7 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -978,7 +978,10 @@ static inline void cpu_probe_cavium(struct cpuinfo_mips *c, unsigned int cpu)
>   platform:
>   		set_elf_platform(cpu, "octeon");
>   		break;
> +	case PRID_IMP_CAVIUM_CN61XX:
>   	case PRID_IMP_CAVIUM_CN63XX:
> +	case PRID_IMP_CAVIUM_CN66XX:
> +	case PRID_IMP_CAVIUM_CN68XX:
>   		c->cputype = CPU_CAVIUM_OCTEON2;
>   		__cpu_name[cpu] = "Cavium Octeon II";
>   		set_elf_platform(cpu, "octeon2");
