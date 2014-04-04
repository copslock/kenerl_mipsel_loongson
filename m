Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Apr 2014 10:52:22 +0200 (CEST)
Received: from filtteri5.pp.htv.fi ([213.243.153.188]:57773 "EHLO
        filtteri5.pp.htv.fi" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6822271AbaDDIwUTu8Hj (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Apr 2014 10:52:20 +0200
Received: from localhost (localhost [127.0.0.1])
        by filtteri5.pp.htv.fi (Postfix) with ESMTP id E6B205A70AE;
        Fri,  4 Apr 2014 11:52:14 +0300 (EEST)
X-Virus-Scanned: Debian amavisd-new at pp.htv.fi
Received: from smtp4.welho.com ([213.243.153.38])
        by localhost (filtteri5.pp.htv.fi [213.243.153.188]) (amavisd-new, port 10024)
        with ESMTP id VPQFYyjkt8fZ; Fri,  4 Apr 2014 11:52:08 +0300 (EEST)
Received: from drone (91-145-91-118.bb.dnainternet.fi [91.145.91.118])
        by smtp4.welho.com (Postfix) with ESMTP id 5826A5BC015;
        Fri,  4 Apr 2014 11:52:11 +0300 (EEST)
Date:   Fri, 4 Apr 2014 11:48:05 +0300
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Huacai Chen <chenhc@lemote.com>
Cc:     Ralf Baechle <ralf@linux-mips.org>,
        John Crispin <john@phrozen.org>,
        "Steven J. Hill" <Steven.Hill@imgtec.com>,
        Aurelien Jarno <aurelien@aurel32.net>,
        linux-mips@linux-mips.org, Fuxin Zhang <zhangfx@lemote.com>,
        Zhangjin Wu <wuzhangjin@gmail.com>
Subject: Re: [PATCH 7/9] MIPS: Loongson: Make CPU name more clear
Message-ID: <20140404084805.GA7558@drone.musicnaut.iki.fi>
References: <1396599104-24370-1-git-send-email-chenhc@lemote.com>
 <1396599104-24370-8-git-send-email-chenhc@lemote.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1396599104-24370-8-git-send-email-chenhc@lemote.com>
User-Agent: Mutt/1.5.22 (2013-10-16)
Return-Path: <aaro.koskinen@iki.fi>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39650
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: aaro.koskinen@iki.fi
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

On Fri, Apr 04, 2014 at 04:11:42PM +0800, Huacai Chen wrote:
> Make names in /proc/cpuinfo more human-readable, Since GCC support the
> new-style names for a long time, this may not break -march=native any
> more.

NACK. There isn't a GCC release available yet that supports
new Loongson 2 names. You need to wait until such release is made
and everyone starts using it. That will take maybe 5-10 years.

A.

> Signed-off-by: Huacai Chen <chenhc@lemote.com>
> ---
>  arch/mips/kernel/cpu-probe.c |    8 ++++----
>  1 files changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/mips/kernel/cpu-probe.c b/arch/mips/kernel/cpu-probe.c
> index 585f996..2576d53 100644
> --- a/arch/mips/kernel/cpu-probe.c
> +++ b/arch/mips/kernel/cpu-probe.c
> @@ -742,23 +742,23 @@ static inline void cpu_probe_legacy(struct cpuinfo_mips *c, unsigned int cpu)
>  		switch (c->processor_id & PRID_REV_MASK) {
>  		case PRID_REV_LOONGSON2E:
>  			c->cputype = CPU_LOONGSON2;
> -			__cpu_name[cpu] = "ICT Loongson-2";
> +			__cpu_name[cpu] = "ICT Loongson-2E";
>  			set_elf_platform(cpu, "loongson2e");
>  			break;
>  		case PRID_REV_LOONGSON2F:
>  			c->cputype = CPU_LOONGSON2;
> -			__cpu_name[cpu] = "ICT Loongson-2";
> +			__cpu_name[cpu] = "ICT Loongson-2F";
>  			set_elf_platform(cpu, "loongson2f");
>  			break;
>  		case PRID_REV_LOONGSON3A:
>  			c->cputype = CPU_LOONGSON3;
> -			__cpu_name[cpu] = "ICT Loongson-3";
> +			__cpu_name[cpu] = "ICT Loongson-3A";
>  			set_elf_platform(cpu, "loongson3a");
>  			break;
>  		case PRID_REV_LOONGSON3B_R1:
>  		case PRID_REV_LOONGSON3B_R2:
>  			c->cputype = CPU_LOONGSON3;
> -			__cpu_name[cpu] = "ICT Loongson-3";
> +			__cpu_name[cpu] = "ICT Loongson-3B";
>  			set_elf_platform(cpu, "loongson3b");
>  			break;
>  		}
> -- 
> 1.7.7.3
> 
> 
