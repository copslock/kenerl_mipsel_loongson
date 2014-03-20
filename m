Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 20 Mar 2014 01:54:27 +0100 (CET)
Received: from mail1.windriver.com ([147.11.146.13]:40901 "EHLO
        mail1.windriver.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S6821115AbaCTAyYtrqS0 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 20 Mar 2014 01:54:24 +0100
Received: from ALA-HCA.corp.ad.wrs.com (ala-hca.corp.ad.wrs.com [147.11.189.40])
        by mail1.windriver.com (8.14.5/8.14.5) with ESMTP id s2K0rts6008824
        (version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=FAIL);
        Wed, 19 Mar 2014 17:53:55 -0700 (PDT)
Received: from [128.224.162.170] (128.224.162.170) by ALA-HCA.corp.ad.wrs.com
 (147.11.189.50) with Microsoft SMTP Server (TLS) id 14.3.169.1; Wed, 19 Mar
 2014 17:53:54 -0700
Message-ID: <532A3C18.40904@windriver.com>
Date:   Thu, 20 Mar 2014 08:53:44 +0800
From:   "Yang,Wei" <Wei.Yang@windriver.com>
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.0
MIME-Version: 1.0
To:     Andreas Herrmann <andreas.herrmann@caviumnetworks.com>,
        David Daney <ddaney@caviumnetworks.com>, <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>,
        "Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
Subject: Re: [PATCH] MIPS: octeon: Fix warning in of_device_alloc on cn3xxx
References: <1395118084-24018-1-git-send-email-Wei.Yang@windriver.com> <532968AD.4010402@windriver.com> <20140319162008.GA4368@alberich> <5329E343.60309@caviumnetworks.com> <20140319220330.GC4368@alberich>
In-Reply-To: <20140319220330.GC4368@alberich>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [128.224.162.170]
Return-Path: <Wei.Yang@windriver.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 39520
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Wei.Yang@windriver.com
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

On 03/20/2014 06:03 AM, Andreas Herrmann wrote:
> Starting with commit 3da5278727a895d49a601f67fd49dffa0b80f9a5 (of/irq:
> Rework of_irq_count()) the following warning is triggered on octeon
> cn3xxx:
>
> [    0.887281] WARNING: CPU: 0 PID: 1 at drivers/of/platform.c:171 of_device_alloc+0x228/0x230()
> [    0.895642] Modules linked in:
> [    0.898689] CPU: 0 PID: 1 Comm: swapper/0 Not tainted 3.14.0-rc7-00012-g9ae51f2-dirty #41
> [    0.906860] Stack : c8b439581166d96e ffffffff816b0000 0000000040808000 ffffffff81185ddc
> [    0.906860] 	  0000000000000000 0000000000000000 0000000000000000 000000000000000b
> [    0.906860] 	  000000000000000a 000000000000000a 0000000000000000 0000000000000000
> [    0.906860] 	  ffffffff81740000 ffffffff81720000 ffffffff81615900 ffffffff816b0177
> [    0.906860] 	  ffffffff81727d10 800000041f868fb0 0000000000000001 0000000000000000
> [    0.906860] 	  0000000000000000 0000000000000038 0000000000000001 ffffffff81568484
> [    0.906860] 	  800000041f86faa8 ffffffff81145ddc 0000000000000000 ffffffff811873f4
> [    0.906860] 	  800000041f868b88 800000041f86f9c0 0000000000000000 ffffffff81569c9c
> [    0.906860] 	  0000000000000000 0000000000000000 0000000000000000 0000000000000000
> [    0.906860] 	  0000000000000000 ffffffff811205e0 0000000000000000 0000000000000000
> [    0.906860] 	  ...
> [    0.971695] Call Trace:
> [    0.974139] [<ffffffff811205e0>] show_stack+0x68/0x80
> [    0.979183] [<ffffffff81569c9c>] dump_stack+0x8c/0xe0
> [    0.984196] [<ffffffff81145efc>] warn_slowpath_common+0x84/0xb8
> [    0.990110] [<ffffffff81436888>] of_device_alloc+0x228/0x230
> [    0.995726] [<ffffffff814368d8>] of_platform_device_create_pdata+0x48/0xd0
> [    1.002593] [<ffffffff81436a94>] of_platform_bus_create+0x134/0x1e8
> [    1.008837] [<ffffffff81436af8>] of_platform_bus_create+0x198/0x1e8
> [    1.015064] [<ffffffff81436cc4>] of_platform_bus_probe+0xa4/0x100
> [    1.021149] [<ffffffff81100570>] do_one_initcall+0xd8/0x128
> [    1.026701] [<ffffffff816e2a10>] kernel_init_freeable+0x144/0x210
> [    1.032753] [<ffffffff81564bc4>] kernel_init+0x14/0x110
> [    1.037973] [<ffffffff8111bb44>] ret_from_kernel_thread+0x14/0x1c
>
> With this commit the kernel starts mapping the interrupts listed for
> gpio-controller node. irq_domain_ops for CIU (octeon_irq_ciu_map and
> octeon_irq_ciu_xlat) refuse to handle the GPIO lines (returning -EINVAL)
> and this is causing above warning in of_device_alloc().
>
> Modify irq_domain_ops for CIU and CIU2 to "gracefully handle" GPIO
> lines (neither return error code nor call octeon_irq_set_ciu_mapping
> for it). This should avoid the warning.
>
> (As before the real setup for GPIO lines will happen using
> irq_domain_ops of gpio-controller.)
>
> This patch is based on Wei's patch v2 (see
> http://marc.info/?l=linux-mips&m=139511814813247).
>
> Reported-by: Yang Wei <wei.yang@windriver.com>
> Cc: David Daney <david.daney@caviumnetworks.com>
> Signed-off-by: Andreas Herrmann <andreas.herrmann@caviumnetworks.com>

Okay, Thank you Andreas and David for this review.


Thanks
Wei
> ---
>   arch/mips/cavium-octeon/octeon-irq.c |   22 ++++++++++++----------
>   1 file changed, 12 insertions(+), 10 deletions(-)
>
> diff --git a/arch/mips/cavium-octeon/octeon-irq.c b/arch/mips/cavium-octeon/octeon-irq.c
> index 25fbfae..c2bb4f8 100644
> --- a/arch/mips/cavium-octeon/octeon-irq.c
> +++ b/arch/mips/cavium-octeon/octeon-irq.c
> @@ -975,10 +975,6 @@ static int octeon_irq_ciu_xlat(struct irq_domain *d,
>   	if (ciu > 1 || bit > 63)
>   		return -EINVAL;
>   
> -	/* These are the GPIO lines */
> -	if (ciu == 0 && bit >= 16 && bit < 32)
> -		return -EINVAL;
> -
>   	*out_hwirq = (ciu << 6) | bit;
>   	*out_type = 0;
>   
> @@ -1007,6 +1003,10 @@ static int octeon_irq_ciu_map(struct irq_domain *d,
>   	if (!octeon_irq_virq_in_range(virq))
>   		return -EINVAL;
>   
> +	/* Don't map irq if it is reserved for GPIO. */
> +	if (line == 0 && bit >= 16 && bit <32)
> +		return 0;
> +
>   	if (line > 1 || octeon_irq_ciu_to_irq[line][bit] != 0)
>   		return -EINVAL;
>   
> @@ -1525,10 +1525,6 @@ static int octeon_irq_ciu2_xlat(struct irq_domain *d,
>   	ciu = intspec[0];
>   	bit = intspec[1];
>   
> -	/* Line 7  are the GPIO lines */
> -	if (ciu > 6 || bit > 63)
> -		return -EINVAL;
> -
>   	*out_hwirq = (ciu << 6) | bit;
>   	*out_type = 0;
>   
> @@ -1570,8 +1566,14 @@ static int octeon_irq_ciu2_map(struct irq_domain *d,
>   	if (!octeon_irq_virq_in_range(virq))
>   		return -EINVAL;
>   
> -	/* Line 7  are the GPIO lines */
> -	if (line > 6 || octeon_irq_ciu_to_irq[line][bit] != 0)
> +	/*
> +	 * Don't map irq if it is reserved for GPIO.
> +	 * (Line 7 are the GPIO lines.)
> +	 */
> +	if (line == 7)
> +		return 0;
> +
> +	if (line > 7 || octeon_irq_ciu_to_irq[line][bit] != 0)
>   		return -EINVAL;
>   
>   	if (octeon_irq_ciu2_is_edge(line, bit))
