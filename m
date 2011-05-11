Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 11 May 2011 08:25:49 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:2427 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491100Ab1EKGZm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 11 May 2011 08:25:42 +0200
X-TM-IMSS-Message-ID: <43c5c14e00043fd2@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id 43c5c14e00043fd2 ; Tue, 10 May 2011 23:25:08 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Tue, 10 May 2011 23:19:23 -0700
Date:   Wed, 11 May 2011 11:50:05 +0530
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     ralf@linux-mips.org
Cc:     linux-mips@linux-mips.org
Subject: Re: [PATCH 1/8] Netlogic XLR/XLS processor IDs.
Message-ID: <20110511062004.GA10462@jayachandranc.netlogicmicro.com>
References: <cover.1304712046.git.jayachandranc@netlogicmicro.com>
 <96a6fe21ee649e119f4d6b8053e0c1cd781c27a8.1304712046.git.jayachandranc@netlogicmicro.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <96a6fe21ee649e119f4d6b8053e0c1cd781c27a8.1304712046.git.jayachandranc@netlogicmicro.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
X-OriginalArrivalTime: 11 May 2011 06:19:23.0708 (UTC) FILETIME=[5F226FC0:01CC0FA3]
Return-Path: <jayachandranc@netlogicmicro.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 29919
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips

On Sat, May 07, 2011 at 01:35:47AM +0530, Jayachandran C wrote:
> Add Netlogic Microsystems company ID and processor IDs for XLR
> and XLS processors for CPU probe. Add CPU_XLR to cpu_type_enum.
> 
> Signed-off-by: Jayachandran C <jayachandranc@netlogicmicro.com>
> ---
>  arch/mips/include/asm/cpu.h  |   27 ++++++++++++++++++++
>  arch/mips/kernel/cpu-probe.c |   55 ++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 82 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index 8687753..34c0d3c 100644
[...]
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index f65d4c8..130aa7a 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -1034,6 +1087,8 @@ __cpuinit void cpu_probe(void)
>  		break;
>  	case PRID_COMP_INGENIC:
>  		cpu_probe_ingenic(c, cpu);
> +	case PRID_COMP_NETLOGIC:
> +		cpu_probe_netlogic(c, cpu);
>  		break;
>  	}

Found an issue here on review, this removed a break after PRID_COMP_INGENIC, 
I will send an updated patch today.

JC.
