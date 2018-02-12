Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 12 Feb 2018 10:32:13 +0100 (CET)
Received: from 9pmail.ess.barracuda.com ([64.235.150.225]:39565 "EHLO
        9pmail.ess.barracuda.com" rhost-flags-OK-OK-OK-OK)
        by eddie.linux-mips.org with ESMTP id S23990391AbeBLJcGg4GZP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 12 Feb 2018 10:32:06 +0100
Received: from MIPSMAIL01.mipstec.com (mailrelay.mips.com [12.201.5.28]) by mx3.ess.sfj.cudaops.com (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NO); Mon, 12 Feb 2018 09:32:02 +0000
Received: from [10.20.78.211] (10.20.78.211) by mips01.mipstec.com
 (10.20.43.31) with Microsoft SMTP Server id 14.3.361.1; Mon, 12 Feb 2018
 01:29:08 -0800
Date:   Mon, 12 Feb 2018 09:28:59 +0000
From:   "Maciej W. Rozycki" <macro@mips.com>
To:     Fredrik Noring <noring@nocrew.org>
CC:     =?UTF-8?Q?J=C3=BCrgen_Urban?= <JuergenUrban@gmx.de>,
        <linux-mips@linux-mips.org>
Subject: Re: [RFC] MIPS: R5900: Workaround exception NOP execution bug
 (FLX05)
In-Reply-To: <20180211075608.GC2222@localhost.localdomain>
Message-ID: <alpine.DEB.2.00.1802111239380.3553@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1709201705070.16752@tp.orcam.me.uk> <20170927172107.GB2631@localhost.localdomain> <alpine.DEB.2.00.1709272208300.16752@tp.orcam.me.uk> <20170930065654.GA7714@localhost.localdomain> <alpine.DEB.2.00.1709301305400.12020@tp.orcam.me.uk>
 <20171029172016.GA2600@localhost.localdomain> <alpine.DEB.2.00.1711102209440.10088@tp.orcam.me.uk> <20171111160422.GA2332@localhost.localdomain> <20180129202715.GA4817@localhost.localdomain> <alpine.DEB.2.00.1801312259410.4191@tp.orcam.me.uk>
 <20180211075608.GC2222@localhost.localdomain>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-BESS-ID: 1518427921-298554-22252-128369-4
X-BESS-VER: 2018.1-r1801291959
X-BESS-Apparent-Source-IP: 12.201.5.28
X-BESS-Outbound-Spam-Score: 0.00
X-BESS-Outbound-Spam-Report: Code version 3.2, rules version 3.2.2.189937
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------
        0.00 BSF_BESS_OUTBOUND      META: BESS Outbound 
X-BESS-Outbound-Spam-Status: SCORE=0.00 using account:ESS59374 scores of KILL_LEVEL=7.0 tests=BSF_BESS_OUTBOUND
X-BESS-BRTS-Status: 1
Return-Path: <Maciej.Rozycki@mips.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 62499
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@mips.com
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

On Sat, 10 Feb 2018, Fredrik Noring wrote:

> For the R5900, there are cases in which the first two instructions
> in an exception handler are executed as NOP instructions, when
> certain exceptions occur and then a bus error occurs immediately
> before jumping to the exception handler (FLX05).
> 
> The corrective measure is to place NOP in the first two instruction
> locations in all exception handlers.

 Well, but it would help if you only patched the handlers which are 
actually used by the R5900 (and only the handlers and not other code).

> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index c7b64f4a8ad3..4008298c1880 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -62,6 +66,8 @@ NESTED(except_vec3_r4000, 0, sp)
>  	.set	arch=r4000
>  	.set	noat
>  #ifdef CONFIG_CPU_R5900
> +	nop
> +	nop
>  	sync.p
>  #endif
>  	mfc0	k1, CP0_CAUSE

 This hunk makes no sense, the R5900 does not have virtual coherency 
exceptions and therefore makes no use of this handler.

> @@ -174,6 +180,10 @@ LEAF(__r4k_wait)
>  	.align	5
>  BUILD_ROLLBACK_PROLOGUE handle_int
>  NESTED(handle_int, PT_SIZE, sp)
> +#ifdef CONFIG_CPU_R5900
> +	nop
> +	nop
> +#endif

 This is not an exception handler entry, this is jumped to from 
`except_vec3_generic' via the `exception_handlers' dispatcher.

> @@ -275,6 +285,10 @@ NESTED(handle_int, PT_SIZE, sp)
>   * to fit into space reserved for the exception handler.
>   */
>  NESTED(except_vec4, 0, sp)
> +#ifdef CONFIG_CPU_R5900
> +	nop
> +	nop
> +#endif
>  1:	j	1b			/* Dummy, will be replaced */
>  	END(except_vec4)

 This is not going to work as per the comment.  See `set_except_vector'.

> @@ -285,6 +299,10 @@ NESTED(except_vec4, 0, sp)
>   * unconditional jump to this vector.
>   */
>  NESTED(except_vec_ejtag_debug, 0, sp)
> +#ifdef CONFIG_CPU_R5900
> +	nop
> +	nop
> +#endif

 This is not an exception handler entry and can only be jumped to from the 
firmware, redirected from the 0xffffffffbfc00480 hardwired EJTAG exception 
entry point (not supported by the R5900 anyway).

> @@ -300,6 +318,10 @@ NESTED(except_vec_ejtag_debug, 0, sp)
>   */
>  BUILD_ROLLBACK_PROLOGUE except_vec_vi
>  NESTED(except_vec_vi, 0, sp)
> +#ifdef CONFIG_CPU_R5900
> +	nop
> +	nop
> +#endif

 This is an exception handler entry template for vectored interrupts, 
which are not supported by the R5900.

> @@ -319,6 +341,10 @@ EXPORT(except_vec_vi_end)
>   * Complete the register saves and invoke the handler which is passed in $v0
>   */
>  NESTED(except_vec_vi_handler, 0, sp)
> +#ifdef CONFIG_CPU_R5900
> +	nop
> +	nop
> +#endif

 This is not an exception handler entry and is called from vectored 
interrupt handlers.

> @@ -378,6 +404,10 @@ NESTED(except_vec_vi_handler, 0, sp)
>  NESTED(ejtag_debug_handler, PT_SIZE, sp)
>  	.set	push
>  	.set	noat
> +#ifdef CONFIG_CPU_R5900
> +	nop
> +	nop
> +#endif

 This is not an exception handler entry, this can only be reached from one 
of the dispatchers scattered throughout the arch/mips/ tree.

> @@ -424,6 +454,10 @@ EXPORT(ejtag_debug_buffer)
>   * unconditional jump to this vector.
>   */
>  NESTED(except_vec_nmi, 0, sp)
> +#ifdef CONFIG_CPU_R5900
> +	nop
> +	nop
> +#endif

 This is not an exception handler entry and can only be jumped to from the 
firmware, redirected from the 0xffffffffbfc00000 hardwired NMI exception 
entry point.

> @@ -436,6 +470,10 @@ NESTED(nmi_handler, PT_SIZE, sp)
>  	.cfi_signal_frame
>  	.set	push
>  	.set	noat
> +#ifdef CONFIG_CPU_R5900
> +	nop
> +	nop
> +#endif

 This is not an exception handler entry, this can only be reached from one 
of the dispatchers scattered throughout the arch/mips/ tree.

> @@ -521,6 +559,10 @@ NESTED(nmi_handler, PT_SIZE, sp)
>  	NESTED(handle_\exception, PT_SIZE, sp)
>  	.cfi_signal_frame
>  	.set	noat
> +#ifdef CONFIG_CPU_R5900
> +	nop
> +	nop
> +#endif

 This is not an exception handler entry, this is jumped to from 
`except_vec3_generic' via the `exception_handlers' dispatcher.

> diff --git a/arch/mips/kernel/scall32-o32.S b/arch/mips/kernel/scall32-o32.S
> index 89b425646647..e56f988b5c20 100644
> --- a/arch/mips/kernel/scall32-o32.S
> +++ b/arch/mips/kernel/scall32-o32.S
> @@ -30,6 +30,18 @@ NESTED(handle_sys, PT_SIZE, sp)
>  	.set	noat
>  #ifdef CONFIG_CPU_R5900
>  	/*
> +	 * For the R5900, there are cases in which the first two instructions
> +	 * in an exception handler are executed as NOP instructions, when
> +	 * certain exceptions occur and then a bus error occurs immediately
> +	 * before jumping to the exception handler (FLX05).
> +	 *
> +	 * The corrective measure is to place NOP in the first two instruction
> +	 * locations in all exception handlers.
> +	 */
> +	nop
> +	nop
> +
> +	/*

 Likewise.

> diff --git a/arch/mips/mm/tlbex.c b/arch/mips/mm/tlbex.c
> index a18b013fd887..fc7ec8f9eed8 100644
> --- a/arch/mips/mm/tlbex.c
> +++ b/arch/mips/mm/tlbex.c
> @@ -2049,6 +2054,11 @@ build_r4000_tlbchange_handler_head(u32 **p, struct uasm_label **l,
>  {
>  	struct work_registers wr = build_get_work_registers(p);
>  
> +#ifdef CONFIG_CPU_R5900
> +	uasm_i_nop(p);
> +	uasm_i_nop(p);
> +#endif
> +

 Likewise.

 IOW the only places that look relevant to me are: `except_vec3_generic', 
`build_r4000_tlb_refill_handler' and `set_except_vector'.  Please update 
your change accordingly.

  Maciej
