Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 12 Jan 2017 10:40:11 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51780 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23992800AbdALJkDeYxS1 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 12 Jan 2017 10:40:03 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 90E70F4901D4B;
        Thu, 12 Jan 2017 09:39:52 +0000 (GMT)
Received: from [10.150.130.83] (10.150.130.83) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server (TLS) id 14.3.294.0; Thu, 12 Jan
 2017 09:39:54 +0000
Subject: Re: [PATCH] MIPS: Add cacheinfo support
To:     <justinpopo6@gmail.com>, <linux-mips@linux-mips.org>
References: <20170111194432.24283-1-justinpopo6@gmail.com>
CC:     <bcm-kernel-feedback-list@broadcom.com>,
        <leonid.yegoshin@imgtec.com>, <f.fainelli@gmail.com>,
        Justin Chen <justin.chen@broadcom.com>
From:   Matt Redfearn <matt.redfearn@imgtec.com>
Message-ID: <f29103b9-d215-b832-54dd-28298b6045cf@imgtec.com>
Date:   Thu, 12 Jan 2017 09:39:54 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.4.0
MIME-Version: 1.0
In-Reply-To: <20170111194432.24283-1-justinpopo6@gmail.com>
Content-Type: text/plain; charset="windows-1252"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.150.130.83]
Return-Path: <Matt.Redfearn@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 56280
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@imgtec.com
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

Hi Justin,


On 11/01/17 19:44, justinpopo6@gmail.com wrote:
> From: Justin Chen <justin.chen@broadcom.com>
>
> Add cacheinfo support for MIPS architectures.
>
> Use information from the cpuinfo_mips struct to populate the
> cacheinfo struct. This allows an architecture agnostic approach,
> however this also means if cache information is not properly
> populated within the cpuinfo_mips struct, there is nothing
> we can do. (I.E. c-r3k.c)
>
> Signed-off-by: Justin Chen <justin.chen@broadcom.com>
> ---
>   arch/mips/kernel/Makefile    |  2 +-
>   arch/mips/kernel/cacheinfo.c | 85 ++++++++++++++++++++++++++++++++++++++++++++
>   2 files changed, 86 insertions(+), 1 deletion(-)
>   create mode 100644 arch/mips/kernel/cacheinfo.c
>
> diff --git a/arch/mips/kernel/Makefile b/arch/mips/kernel/Makefile
> index 4a603a3..904a9c4 100644
> --- a/arch/mips/kernel/Makefile
> +++ b/arch/mips/kernel/Makefile
> @@ -7,7 +7,7 @@ extra-y		:= head.o vmlinux.lds
>   obj-y		+= cpu-probe.o branch.o elf.o entry.o genex.o idle.o irq.o \
>   		   process.o prom.o ptrace.o reset.o setup.o signal.o \
>   		   syscall.o time.o topology.o traps.o unaligned.o watch.o \
> -		   vdso.o
> +		   vdso.o cacheinfo.o

Please maintain alphabetical order.

>   
>   ifdef CONFIG_FUNCTION_TRACER
>   CFLAGS_REMOVE_ftrace.o = -pg
> diff --git a/arch/mips/kernel/cacheinfo.c b/arch/mips/kernel/cacheinfo.c
> new file mode 100644
> index 0000000..a92bbba
> --- /dev/null
> +++ b/arch/mips/kernel/cacheinfo.c
> @@ -0,0 +1,85 @@
> +/*
> + * MIPS cacheinfo support
> + *
> + * This program is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + *
> + * This program is distributed "as is" WITHOUT ANY WARRANTY of any
> + * kind, whether express or implied; without even the implied warranty
> + * of MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
> + * GNU General Public License for more details.
> + *
> + * You should have received a copy of the GNU General Public License
> + * along with this program.  If not, see <http://www.gnu.org/licenses/>.
> + */
> +#include <linux/cacheinfo.h>
> +
> +/* Populates leaf and increments to next leaf */
> +#define populate_cache(cache, leaf, c_level, c_type)		\

The way "cache" is used within this macro is unclear, and you don't pass 
"c" as a parameter. I think it would be clearer to pass cache as 
(&c->dcache) etc.

> +	leaf->type = c_type;					\
> +	leaf->level = c_level;					\
> +	leaf->coherency_line_size = c->cache.linesz;		\
> +	leaf->number_of_sets = c->cache.sets;			\
> +	leaf->ways_of_associativity = c->cache.ways;		\
> +	leaf->size = c->cache.linesz * c->cache.sets *		\
> +		c->cache.ways;					\
> +	leaf++;

I don't like this side effect incrementing leaf - please do it when 
invoking the macro so it is more obvious.

Thanks,
Matt

> +
> +static int __init_cache_level(unsigned int cpu)
> +{
> +	struct cpuinfo_mips *c = &current_cpu_data;
> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> +	int levels = 0, leaves = 0;
> +
> +	/*
> +	 * If Dcache is not set, we assume the cache structures
> +	 * are not properly initialized.
> +	 */
> +	if (c->dcache.waysize)
> +		levels += 1;
> +	else
> +		return -ENOENT;
> +
> +
> +	leaves += (c->icache.waysize) ? 2 : 1;
> +
> +	if (c->scache.waysize) {
> +		levels++;
> +		leaves++;
> +	}
> +
> +	if (c->tcache.waysize) {
> +		levels++;
> +		leaves++;
> +	}
> +
> +	this_cpu_ci->num_levels = levels;
> +	this_cpu_ci->num_leaves = leaves;
> +	return 0;
> +}
> +
> +static int __populate_cache_leaves(unsigned int cpu)
> +{
> +	struct cpuinfo_mips *c = &current_cpu_data;
> +	struct cpu_cacheinfo *this_cpu_ci = get_cpu_cacheinfo(cpu);
> +	struct cacheinfo *this_leaf = this_cpu_ci->info_list;
> +
> +	if (c->icache.waysize) {
> +		populate_cache(dcache, this_leaf, 1, CACHE_TYPE_DATA);
> +		populate_cache(icache, this_leaf, 1, CACHE_TYPE_INST);
> +	} else {
> +		populate_cache(dcache, this_leaf, 1, CACHE_TYPE_UNIFIED);
> +	}
> +
> +	if (c->scache.waysize)
> +		populate_cache(scache, this_leaf, 2, CACHE_TYPE_UNIFIED);
> +
> +	if (c->tcache.waysize)
> +		populate_cache(tcache, this_leaf, 3, CACHE_TYPE_UNIFIED);
> +
> +	return 0;
> +}
> +
> +DEFINE_SMP_CALL_CACHE_FUNCTION(init_cache_level)
> +DEFINE_SMP_CALL_CACHE_FUNCTION(populate_cache_leaves)
