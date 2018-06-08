Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 09 Jun 2018 00:37:26 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.210]:47147 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23994619AbeFHWhNsgbuL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 9 Jun 2018 00:37:13 +0200
Received: from mipsdag01.mipstec.com (mail1.mips.com [12.201.5.31]) by mx1414.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Fri, 08 Jun 2018 22:37:06 +0000
Received: from mipsdag02.mipstec.com (10.20.40.47) by mipsdag01.mipstec.com
 (10.20.40.46) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Fri, 8 Jun
 2018 15:37:15 -0700
Received: from localhost (10.20.2.29) by mipsdag02.mipstec.com (10.20.40.47)
 with Microsoft SMTP Server id 15.1.1415.2 via Frontend Transport; Fri, 8 Jun
 2018 15:37:15 -0700
Date:   Fri, 8 Jun 2018 15:37:05 -0700
From:   Paul Burton <paul.burton@mips.com>
To:     <r@hev.cc>
CC:     <linux-mips@linux-mips.org>, <jhogan@kernel.org>,
        <ralf@linux-mips.org>
Subject: Re: [PATCH] MIPS: Fix ejtag handler on SMP
Message-ID: <20180608223705.uaac4xsi2z5b7mnl@pburton-laptop>
References: <20180608055109.828-1-r@hev.cc>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20180608055109.828-1-r@hev.cc>
User-Agent: NeoMutt/20180512
X-BESS-ID: 1528497426-531716-17306-75259-1
X-BESS-VER: 2018.7-r1806072306
X-BESS-Apparent-Source-IP: 12.201.5.31
X-BESS-Envelope-From: Paul.Burton@mips.com
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.193893
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-Orig-Rcpt: r@hev.cc,linux-mips@linux-mips.org,jhogan@kernel.org,ralf@linux-mips.org
X-BESS-BRTS-Status: 1
Return-Path: <Paul.Burton@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 64214
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@mips.com
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

Hi Heiher,

On Fri, Jun 08, 2018 at 01:51:09PM +0800, r@hev.cc wrote:
> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index 37b9383eacd3..3804afd878f8 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -354,16 +354,56 @@ NESTED(ejtag_debug_handler, PT_SIZE, sp)
>  	sll	k0, k0, 30	# Check for SDBBP.
>  	bgez	k0, ejtag_return
>  
> +#ifdef CONFIG_SMP
> +1:	PTR_LA	k0, ejtag_debug_buffer_spinlock
> +	ll	k0, 0(k0)
> +	bnez	k0, 1b
> +	PTR_LA	k0, ejtag_debug_buffer_spinlock
> +	sc	k0, 0(k0)
> +	beqz	k0, 1b
> +# ifdef CONFIG_WEAK_REORDERING_BEYOND_LLSC
> +	sync
> +# endif
> +
> +	PTR_LA	k0, ejtag_debug_buffer
> +	LONG_S	k1, 0(k0)
> +
> +	mfc0	k1, CP0_EBASE
> +	andi	k1, MIPS_EBASE_CPUNUM
> +	PTR_SLL	k1, LONGLOG
> +	PTR_LA	k0, ejtag_debug_buffer_per_cpu
> +	PTR_ADDU k0, k1

Neat - I like the concept of using the spinlock for just a short window
to free up k1, then using a per-CPU buffer.

Unfortunately it's not going to be as simple as using EBase.CPUNum, for
at least 2 reasons:

  - EBase.CPUNum doesn't always equal the Linux CPU number. For example
    in many systems which implement multi-threading ASE CPUNum is
    actually just a concatenation of some fixed number of bits
    specifying the core number and some fixed number of bits specifying
    the VP(E) number. So for example we might have a system with 2 cores
    each of which have 2 threads, but whose numbering looks like this:

      Linux CPU Number | Core Number | VP(E) Number | EBase.CPUNum
      -----------------|-------------|--------------|-------------
                     0 |  0b00 / 0x0 |   0b00 / 0x0 | 0b0000 / 0x0
		     1 |  0b00 / 0x0 |   0b01 / 0x1 | 0b0001 / 0x1
		     2 |  0b01 / 0x1 |   0b00 / 0x0 | 0b0100 / 0x4
		     3 |  0b01 / 0x1 |   0b01 / 0x1 | 0b0101 / 0x5

    This means that it might be the case that EBase.CPUNum >= NR_CPUS,
    which would result in a buffer overflow here.

    There are other ways this could happen too, for example if the
    kernel is configured with CONFIG_NR_CPUS=2 and run on a system which
    actually has more than 2 CPUs we'd have problems if the kernel was
    actually running on CPUs besides the ones CPUNum refers to as 0 & 1.

  - Some newer MIPS CPUs such as the I6500 introduce the concept of
    clusters, which are a layer of CPU topology beyond cores. In these
    systems EBase.CPUNum may not be aware of clusters at all, so for
    example the first CPU in each cluster may both have EBase.CPUNum
    equal to zero. MIPSr6 introduced the GlobalNumber register to
    resolve this problem.

One option would be to load the CPU number the same way
smp_processor_id() does with:

    lw	k1, TI_CPU(gp)

This has the disadvantage that things may go wrong if we take an EJTAG
exception before the gp register has been setup when a CPU is onlined,
but that should hopefully be a very small window of time. I think that
may be our best option.

Thanks,
    Paul
