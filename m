Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 21 May 2014 15:48:16 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51561 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6837162AbaEUNsMiUnQt (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 21 May 2014 15:48:12 +0200
Received: from KLMAIL01.kl.imgtec.org (unknown [192.168.5.35])
        by Websense Email Security Gateway with ESMTPS id 42CDEE41ACB97;
        Wed, 21 May 2014 14:48:03 +0100 (IST)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 KLMAIL01.kl.imgtec.org (192.168.5.35) with Microsoft SMTP Server (TLS) id
 14.3.181.6; Wed, 21 May 2014 14:48:05 +0100
Received: from [192.168.154.101] (192.168.154.101) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.174.1; Wed, 21 May
 2014 14:48:05 +0100
Message-ID: <537CADD1.5020006@imgtec.com>
Date:   Wed, 21 May 2014 14:44:49 +0100
From:   James Hogan <james.hogan@imgtec.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        <linux-mips@linux-mips.org>
CC:     David Daney <ddaney.cavm@gmail.com>,
        Ralf Baechle <ralf@linux-mips.org>, <kvm@vger.kernel.org>
Subject: Re: [PATCH 15/15] MIPS: paravirt: Provide _machine_halt function
 to exit VM on shutdown of guest
References: <1400597236-11352-1-git-send-email-andreas.herrmann@caviumnetworks.com> <1400597236-11352-16-git-send-email-andreas.herrmann@caviumnetworks.com>
In-Reply-To: <1400597236-11352-16-git-send-email-andreas.herrmann@caviumnetworks.com>
X-Enigmail-Version: 1.6
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.154.101]
Return-Path: <James.Hogan@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 40221
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: james.hogan@imgtec.com
Precedence: bulk
List-help: <mailto:ecartis@linux-mips.org?Subject=help>
List-unsubscribe: <mailto:ecartis@linux-mips.org?subject=unsubscribe%20linux-mips>
List-software: Ecartis version 1.0.0
List-Id: linux-mips <linux-mips.eddie.linux-mips.org>
X-List-ID: linux-mips <linux-mips.eddie.linux-mips.org>
List-subscribe: <mailto:ecartis@linux-mips.org?subject=subscribe%20linux-mips>
List-owner: <mailto:ralf@linux-mips.org>
List-post: <mailto:linux-mips@linux-mips.org>
List-archive: <http://www.linux-mips.org/archives/linux-mips/>
X-list: linux-mips

On 20/05/14 15:47, Andreas Herrmann wrote:
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>

Does it make sense to provide a _machine_restart too?

I think this should be squashed into patch 10 really, or else patch 10
split up into several parts (irq, smp, serial, other).

Cheers
James

> ---
>  arch/mips/paravirt/setup.c |    7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/arch/mips/paravirt/setup.c b/arch/mips/paravirt/setup.c
> index f80c3bc..6d2781c 100644
> --- a/arch/mips/paravirt/setup.c
> +++ b/arch/mips/paravirt/setup.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/kernel.h>
>  
> +#include <asm/reboot.h>
>  #include <asm/bootinfo.h>
>  #include <asm/mipsregs.h>
>  #include <asm/smp-ops.h>
> @@ -27,6 +28,11 @@ void __init plat_time_init(void)
>  	preset_lpj = mips_hpt_frequency / (2 * HZ);
>  }
>  
> +static void pv_machine_halt(void)
> +{
> +	hypcall0(1 /* Exit VM */);
> +}
> +
>  /*
>   * Early entry point for arch setup
>   */
> @@ -47,6 +53,7 @@ void __init prom_init(void)
>  		if (i < argc - 1)
>  			strlcat(arcs_cmdline, " ", COMMAND_LINE_SIZE);
>  	}
> +	_machine_halt = pv_machine_halt;
>  	register_smp_ops(&paravirt_smp_ops);
>  }
>  
> 
