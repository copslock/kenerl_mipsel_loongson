Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 27 Mar 2018 15:29:47 +0200 (CEST)
Received: from 9pmail.ess.barracuda.com ([64.235.154.211]:58968 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23992916AbeC0N3jBG2lm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Tue, 27 Mar 2018 15:29:39 +0200
Received: from mipsdag02.mipstec.com (mail2.mips.com [12.201.5.32]) by mx1411.ess.rzc.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA256 bits=128 verify=NO); Tue, 27 Mar 2018 13:29:18 +0000
Received: from [192.168.155.41] (192.168.155.41) by mipsdag02.mipstec.com
 (10.20.40.47) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1415.2; Tue, 27
 Mar 2018 06:29:26 -0700
Subject: Re: [PATCH] mips: ftrace: fix static function graph tracing
To:     Matthias Schiffer <mschiffer@universe-factory.net>,
        <ralf@linux-mips.org>, <rostedt@goodmis.org>, <mingo@redhat.com>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>
References: <7dc2bb7f712c1e3cfeaafaefe3a3f97668dee549.1521909650.git.mschiffer@universe-factory.net>
From:   Matt Redfearn <matt.redfearn@mips.com>
Message-ID: <f2dd3d8c-201d-b90d-859e-82f7ab6d2c9d@mips.com>
Date:   Tue, 27 Mar 2018 14:29:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.6.0
MIME-Version: 1.0
In-Reply-To: <7dc2bb7f712c1e3cfeaafaefe3a3f97668dee549.1521909650.git.mschiffer@universe-factory.net>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [192.168.155.41]
X-ClientProxiedBy: mipsdag02.mipstec.com (10.20.40.47) To
 mipsdag02.mipstec.com (10.20.40.47)
X-BESS-ID: 1522157358-452059-31176-50479-1
X-BESS-VER: 2018.3.1-r1803262126
X-BESS-Apparent-Source-IP: 12.201.5.32
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.191447
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Matt.Redfearn@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 63248
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: matt.redfearn@mips.com
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

Hi Matthias,

On 24/03/18 16:57, Matthias Schiffer wrote:
> ftrace_graph_caller was never run after calling ftrace_trace_function,
> breaking the function graph tracer. Fix this, bringing it in line with the
> x86 implementation.
> 
> While we're at it, also streamline the control flow of _mcount a bit to
> reduce the number of branches.
> 
> This issue was reported before:
> https://www.linux-mips.org/archives/linux-mips/2014-11/msg00295.html
> 
> Signed-off-by: Matthias Schiffer <mschiffer@universe-factory.net>
> ---
> 
> Caveats: I've only tested this on 32bit; it would be great if someone with
> MIPS64 hardware or a working emulator setup could give it a spin. My test

I've tested this patch fixes static function graph tracing on the 
following platforms:
QEMU (MIPS32r2 P5600)
Creator Ci40 (MIPS32r2 InterAptiv)
Cavium Octeon II (MIPS64r2)
MIPS Boston FPGA with I6400 (MIPS64r6)

So
Tested-by: Matt Redfearn <matt.redfearn@mips.com>

> device runs on kernel 4.9.y, but I don't expect any problems applying the
> fix to newer kernels, given that this code is basically unchanged since
> 2014.

Indeed, applies fine to v4.16-rc7 (which I mainly tested with)

> 
> I'm not sure what the correct Fixes: line would be. I did not bother to
> bisect the issue and could not find the commit introducing it by inspecting
> the log (assuming the tracer worked at some point).

I verified that the patch applies to and fixes the issue as far back as 
3.19 on the malta platform using qemu. Going further back I ran into 
toolchain issues that prevented builds. The earliest version the patch 
applies cleanly to is v3.17.
Like you, I don't see where this got broken from just looking at 
mcount.S, and not being able to bisect with build / test makes it rather 
difficult to find out.

Thanks,
Matt

> 
> 
>   arch/mips/kernel/mcount.S | 27 ++++++++++++---------------
>   1 file changed, 12 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/mips/kernel/mcount.S b/arch/mips/kernel/mcount.S
> index f2ee7e1e3342..cff52b283e03 100644
> --- a/arch/mips/kernel/mcount.S
> +++ b/arch/mips/kernel/mcount.S
> @@ -119,10 +119,20 @@ NESTED(_mcount, PT_SIZE, ra)
>   EXPORT_SYMBOL(_mcount)
>   	PTR_LA	t1, ftrace_stub
>   	PTR_L	t2, ftrace_trace_function /* Prepare t2 for (1) */
> -	bne	t1, t2, static_trace
> +	beq	t1, t2, fgraph_trace
>   	 nop
>   
> +	MCOUNT_SAVE_REGS
> +
> +	move	a0, ra		/* arg1: self return address */
> +	jalr	t2		/* (1) call *ftrace_trace_function */
> +	 move	a1, AT		/* arg2: parent's return address */
> +
> +	MCOUNT_RESTORE_REGS
> +
> +fgraph_trace:
>   #ifdef	CONFIG_FUNCTION_GRAPH_TRACER
> +	PTR_LA	t1, ftrace_stub
>   	PTR_L	t3, ftrace_graph_return
>   	bne	t1, t3, ftrace_graph_caller
>   	 nop
> @@ -131,24 +141,11 @@ EXPORT_SYMBOL(_mcount)
>   	bne	t1, t3, ftrace_graph_caller
>   	 nop
>   #endif
> -	b	ftrace_stub
> -#ifdef CONFIG_32BIT
> -	 addiu sp, sp, 8
> -#else
> -	 nop
> -#endif
>   
> -static_trace:
> -	MCOUNT_SAVE_REGS
> -
> -	move	a0, ra		/* arg1: self return address */
> -	jalr	t2		/* (1) call *ftrace_trace_function */
> -	 move	a1, AT		/* arg2: parent's return address */
> -
> -	MCOUNT_RESTORE_REGS
>   #ifdef CONFIG_32BIT
>   	addiu sp, sp, 8
>   #endif
> +
>   	.globl ftrace_stub
>   ftrace_stub:
>   	RETURN_BACK
> 
