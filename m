Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 21 Jan 2014 17:53:06 +0100 (CET)
Received: from nbd.name ([46.4.11.11]:51476 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org with ESMTP
        id S6822672AbaAUQxE1I367 (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Tue, 21 Jan 2014 17:53:04 +0100
Message-ID: <52DEA5D9.2000904@phrozen.org>
Date:   Tue, 21 Jan 2014 17:52:41 +0100
From:   John Crispin <john@phrozen.org>
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.9; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
MIME-Version: 1.0
To:     linux-mips@linux-mips.org
Subject: Re: [PATCH] MIPS: Add P5600 PRid and probe support
References: <1390315820-15723-1-git-send-email-james.hogan@imgtec.com>
In-Reply-To: <1390315820-15723-1-git-send-email-james.hogan@imgtec.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-Path: <john@phrozen.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39039
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: john@phrozen.org
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

Hi,

> Add a Processor ID for the P5600 core and a case in cpu_probe_mips() for
> it. The cputype is set to CPU_PROAPTIV for now as it is in the same
> range of cores as proAptiv and doesn't currently need to be
> distinguished from it in the kernel.
The "currently" in that sentence tells me that you expect there to be a
need to distinguish it in future ?
If this is the case, then the code should be added now rather than
correcting the code later.
I immediately had to think of the 1074k vs 74k patch that is in
linux-mti-3.10 and was posted a few days ago.

     John




> Signed-off-by: James Hogan <james.hogan@imgtec.com>
> Cc: Ralf Baechle <ralf@linux-mips.org>
> Cc: linux-mips@linux-mips.org
> ---
>  arch/mips/include/asm/cpu.h  | 1 +
>  arch/mips/kernel/cpu-probe.c | 4 ++++
>  2 files changed, 5 insertions(+)
>
> diff --git a/arch/mips/include/asm/cpu.h b/arch/mips/include/asm/cpu.h
> index 76411df3d971..b69e7306cdb1 100644
> --- a/arch/mips/include/asm/cpu.h
> +++ b/arch/mips/include/asm/cpu.h
> @@ -115,6 +115,7 @@
>  #define PRID_IMP_INTERAPTIV_MP	0xa100
>  #define PRID_IMP_PROAPTIV_UP	0xa200
>  #define PRID_IMP_PROAPTIV_MP	0xa300
> +#define PRID_IMP_P5600		0xa800
>  
>  /*
>   * These are the PRID's for when 23:16 == PRID_COMP_SIBYTE
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 530f832de02c..7bf4634ff045 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -825,6 +825,10 @@ static inline void cpu_probe_mips(struct cpuinfo_mips *c, unsigned int cpu)
>  		c->cputype = CPU_PROAPTIV;
>  		__cpu_name[cpu] = "MIPS proAptiv (multi)";
>  		break;
> +	case PRID_IMP_P5600:
> +		c->cputype = CPU_PROAPTIV;
> +		__cpu_name[cpu] = "MIPS P5600";
> +		break;
>  	}
>  
>  	decode_configs(c);
