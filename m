Received: with ECARTIS (v1.0.0; list linux-mips); Sun, 02 Oct 2011 10:31:03 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:1529 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491124Ab1JBIa4 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sun, 2 Oct 2011 10:30:56 +0200
X-TM-IMSS-Message-ID: <4c2468c30001169f@netlogicmicro.com>
Received: from hqcas01.netlogicmicro.com ([10.10.50.14]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0; TLS: TLSv1/SSLv3,128bits,AES128-SHA) id 4c2468c30001169f ; Sun, 2 Oct 2011 01:30:47 -0700
Date:   Sun, 2 Oct 2011 14:00:45 +0530
From:   Jayachandran C. <jayachandranc@netlogicmicro.com>
To:     Hillf Danton <dhillf@gmail.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>
Subject: Re: [RFC] mark Netlogic XLR chip as SMT capable
Message-ID: <20111002083044.GA23668@jayachandranc.netlogicmicro.com>
References: <CAJd=RBAc8Zv1JZfrAx2Ajj7fdJv=oA+eYHVBLfcFNOoZNyG7fg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <CAJd=RBAc8Zv1JZfrAx2Ajj7fdJv=oA+eYHVBLfcFNOoZNyG7fg@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 02 Oct 2011 08:30:46.0629 (UTC) FILETIME=[9534B950:01CC80DD]
X-archive-position: 31199
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 441

On Sun, Oct 02, 2011 at 03:26:14PM +0800, Hillf Danton wrote:
> Netlogic XLR chip has multiple cores. Each core includes four integrated
> hardware threads, and they share L1 data and instruction caches.
> 
> If XLR chip is marked to be SMT capable, linux scheduler then could do more,
> say idle load balancing.
> 
> Any comment is welcom, thanks.

I may be missing something here, but how about just setting cpu_data[].core in
the init_secondary method?  That would avoid the change to kernel/smp.c. 

> 
> Signed-off-by: Hillf Danton <dhillf@gmail.com>
> ---
> 
> --- a/arch/mips/netlogic/xlr/smp.c	Sun Oct  2 14:15:28 2011
> +++ b/arch/mips/netlogic/xlr/smp.c	Sun Oct  2 14:15:58 2011
> @@ -176,6 +176,7 @@ void __init nlm_smp_setup(void)
> 
>  void nlm_prepare_cpus(unsigned int max_cpus)
>  {
> +	smp_num_siblings = 4;
>  }
> 
>  struct plat_smp_ops nlm_smp_ops = {
> --- a/arch/mips/kernel/smp.c	Sun Oct  2 14:12:09 2011
> +++ b/arch/mips/kernel/smp.c	Sun Oct  2 14:14:58 2011
> @@ -73,7 +73,12 @@ static inline void set_cpu_sibling_map(i
> 
>  	if (smp_num_siblings > 1) {
>  		for_each_cpu_mask(i, cpu_sibling_setup_map) {
> -			if (cpu_data[cpu].core == cpu_data[i].core) {
> +			if (current_cpu_type() == CPU_XLR) {
> +				if (((i>>2) & 0x7) == ((cpu>>2) & 0x7))
> +					goto set;
> +			}
> +			else if (cpu_data[cpu].core == cpu_data[i].core) {
> +set:
>  				cpu_set(i, cpu_sibling_map[cpu]);
>  				cpu_set(cpu, cpu_sibling_map[i]);
>  			}

JC.
