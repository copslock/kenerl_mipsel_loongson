Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Aug 2011 20:49:33 +0200 (CEST)
Received: from mx1.netlogicmicro.com ([12.203.210.36]:2282 "EHLO
        orion5.netlogicmicro.com" rhost-flags-OK-OK-OK-FAIL)
        by eddie.linux-mips.org with ESMTP id S1491755Ab1HDSt0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Aug 2011 20:49:26 +0200
X-TM-IMSS-Message-ID: <fc2a2e9f0003646f@netlogicmicro.com>
Received: from orion8.netlogicmicro.com ([10.10.16.60]) by netlogicmicro.com ([10.10.16.19]) with ESMTP (TREND IMSS SMTP Service 7.0) id fc2a2e9f0003646f ; Thu, 4 Aug 2011 11:47:44 -0700
Received: from jayachandranc.netlogicmicro.com ([10.7.0.77]) by orion8.netlogicmicro.com with Microsoft SMTPSVC(6.0.3790.3959);
         Thu, 4 Aug 2011 11:50:35 -0700
Date:   Fri, 5 Aug 2011 00:21:41 +0530
From:   "Jayachandran C." <jayachandranc@netlogicmicro.com>
To:     Hillf Danton <dhillf@gmail.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        LKML <linux-kernel@vger.kernel.org>, linux-mips@linux-mips.org
Subject: Re: [RFC patch] MIPS/netlogic: dont setup boot CPU twice
Message-ID: <20110804185139.GA11724@jayachandranc.netlogicmicro.com>
References: <CAJd=RBDv1wsdVYmwdtr2BGOCuya1eKg4PeWeggPbz5u_5545ig@mail.gmail.com>
 <CA+7sy7B7-zTr4MojT+7C+AD4+ap4aiiJKX4u+fOPzR52yEJGJA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CA+7sy7B7-zTr4MojT+7C+AD4+ap4aiiJKX4u+fOPzR52yEJGJA@mail.gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-OriginalArrivalTime: 04 Aug 2011 18:50:35.0451 (UTC) FILETIME=[651960B0:01CC52D7]
X-archive-position: 30839
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: jayachandranc@netlogicmicro.com
Precedence: bulk
X-list: linux-mips
Return-Path: <linux-mips-bounce@linux-mips.org>
X-Keywords:                  
X-UID: 3553

> 
> When do smp setup, check for boot CPU is added, then it is impossible to be
> initialized twice.
> 
> Signed-off-by: Hillf Danton <dhillf@gmail.com>
> ---
>  arch/mips/netlogic/xlr/smp.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/arch/mips/netlogic/xlr/smp.c b/arch/mips/netlogic/xlr/smp.c
> index b495a7f..e6f8c62 100644
> --- a/arch/mips/netlogic/xlr/smp.c
> +++ b/arch/mips/netlogic/xlr/smp.c
> @@ -167,6 +167,8 @@ void __init nlm_smp_setup(void)
> 
>        num_cpus = 1;
>        for (i = 0; i < NR_CPUS; i++) {
> +               if (i == boot_cpu)
> +                       continue;
>                if (nlm_cpu_ready[i]) {
>                        cpu_set(i, phys_cpu_present_map);
>                        __cpu_number_map[i] = num_cpus;

The nlm_cpu_ready[] entry is not set for the boot_cpu, it is set for only 
the secondary cpus in smpboot.S.  The code works as it is, but your patch
makes it more explicit.

My only commnet is that it might look better if you combine both the if checks.

JC.
