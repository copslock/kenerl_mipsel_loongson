Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 20 Jun 2003 18:08:15 +0100 (BST)
Received: from gateway-1237.mvista.com ([IPv6:::ffff:12.44.186.158]:57585 "EHLO
	av.mvista.com") by linux-mips.org with ESMTP id <S8224802AbTFTRIN>;
	Fri, 20 Jun 2003 18:08:13 +0100
Received: from zeus.mvista.com (av [127.0.0.1])
	by av.mvista.com (8.9.3/8.9.3) with ESMTP id KAA09362;
	Fri, 20 Jun 2003 10:08:01 -0700
Subject: Re: [PATCH 2.4] cpu-probe.c error
From: Pete Popov <ppopov@mvista.com>
To: Brian Murphy <brm@murphy.dk>
Cc: Ralf Baechle <ralf@linux-mips.org>,
	Linux MIPS mailing list <linux-mips@linux-mips.org>
In-Reply-To: <E19TPHY-0002ih-00@brian.localnet>
References: <E19TPHY-0002ih-00@brian.localnet>
Content-Type: text/plain
Organization: MontaVista Software
Message-Id: <1056128905.10307.4.camel@zeus.mvista.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 20 Jun 2003 10:08:25 -0700
Content-Transfer-Encoding: 7bit
Return-Path: <ppopov@mvista.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 2686
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ppopov@mvista.com
Precedence: bulk
X-list: linux-mips


FYI, I had tried the same patch and it works fine on my boards. I think
mips64 may be broken as well, if I remember correctly.

Pete

On Fri, 2003-06-20 at 10:02, Brian Murphy wrote:
> Hi Ralf,
> 	the latest change to cpu-probe.c requires a mips_cpu
> variable which no longer exists. I presume you meant the following.
> 
> /Brian
> 
> Index: arch/mips/kernel/cpu-probe.c
> ===================================================================
> RCS file: /cvs/linux/arch/mips/kernel/cpu-probe.c,v
> retrieving revision 1.1.2.21
> diff -u -r1.1.2.21 cpu-probe.c
> --- arch/mips/kernel/cpu-probe.c	15 Jun 2003 23:35:54 -0000	1.1.2.21
> +++ arch/mips/kernel/cpu-probe.c	20 Jun 2003 16:59:16 -0000
> @@ -498,21 +498,21 @@
>  #endif
>  			break;
>  		default:
> -			mips_cpu.cputype = CPU_UNKNOWN;
> +			c->cputype = CPU_UNKNOWN;
>  			break;
>  		}
>  		break;
>  
>  	case PRID_COMP_SANDCRAFT:
> -		switch (mips_cpu.processor_id & 0xff00) {
> +		switch (c->processor_id & 0xff00) {
>  		case PRID_IMP_SR71000:
> -			mips_cpu.cputype = CPU_SR71000;
> -			mips_cpu.isa_level = MIPS_CPU_ISA_M64;
> -			mips_cpu.options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
> +			c->cputype = CPU_SR71000;
> +			c->isa_level = MIPS_CPU_ISA_M64;
> +			c->options = MIPS_CPU_TLB | MIPS_CPU_4KEX |
>                                             MIPS_CPU_4KTLB | MIPS_CPU_FPU |
>  			                   MIPS_CPU_COUNTER | MIPS_CPU_MCHECK;
> -			mips_cpu.scache.ways = 8;
> -			mips_cpu.tlbsize = 64;
> +			c->scache.ways = 8;
> +			c->tlbsize = 64;
>  			break;
>  		default:
>  			c->cputype = CPU_UNKNOWN;
> 
> 
