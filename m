Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 16:18:43 +0100 (CET)
Received: from localhost.localdomain ([127.0.0.1]:55014 "EHLO linux-mips.org"
        rhost-flags-OK-OK-OK-FAIL) by eddie.linux-mips.org with ESMTP
        id S27012696AbcBDPSlYtlkK (ORCPT <rfc822;linux-mips@linux-mips.org>);
        Thu, 4 Feb 2016 16:18:41 +0100
Received: from scotty.linux-mips.net (localhost.localdomain [127.0.0.1])
        by scotty.linux-mips.net (8.15.2/8.14.8) with ESMTP id u14FIaLu020230;
        Thu, 4 Feb 2016 16:18:36 +0100
Received: (from ralf@localhost)
        by scotty.linux-mips.net (8.15.2/8.15.2/Submit) id u14FIYrS020229;
        Thu, 4 Feb 2016 16:18:34 +0100
Date:   Thu, 4 Feb 2016 16:18:34 +0100
From:   Ralf Baechle <ralf@linux-mips.org>
To:     Paul Burton <paul.burton@imgtec.com>
Cc:     linux-mips@linux-mips.org, linux-kernel@vger.kernel.org,
        James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] MIPS: Stop using dla in 32 bit kernels
Message-ID: <20160204151833.GE18491@linux-mips.org>
References: <1454596317-5042-1-git-send-email-paul.burton@imgtec.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1454596317-5042-1-git-send-email-paul.burton@imgtec.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Return-Path: <ralf@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51776
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: ralf@linux-mips.org
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

On Thu, Feb 04, 2016 at 02:31:57PM +0000, Paul Burton wrote:

>       CC      arch/mips/mm/c-r4k.o
>     {standard input}: Assembler messages:
>     {standard input}:4105: Warning: dla used to load 32-bit register;
>         recommend using la instead
>     {standard input}:4129: Warning: dla used to load 32-bit register;
>         recommend using la instead

Sigh.  Another new binutils warning?

> Avoid this by instead making use of the PTR_LA macro which defines the
> appropriate variant of the "la" instruction to use.
> 
> Tested with Codescape GNU Tools 2015.06-05 for MIPS IMG Linux, which
> includes binutils 2.24.90 & gcc 4.9.2.

> @@ -54,22 +55,16 @@
>  
>  /*
>   * gcc has a tradition of misscompiling the previous construct using the
> - * address of a label as argument to inline assembler.	Gas otoh has the
> - * annoying difference between la and dla which are only usable for 32-bit
> - * rsp. 64-bit code, so can't be used without conditional compilation.
> - * The alterantive is switching the assembler to 64-bit code which happens
> - * to work right even for 32-bit code ...
> + * address of a label as argument to inline assembler.
>   */
>  #define instruction_hazard()						\
>  do {									\
>  	unsigned long tmp;						\
>  									\
>  	__asm__ __volatile__(						\
> -	"	.set "MIPS_ISA_LEVEL"				\n"	\
> -	"	dla	%0, 1f					\n"	\
> -	"	jr.hb	%0					\n"	\
> -	"	.set	mips0					\n"	\
> -	"1:							\n"	\
> +	__stringify(PTR_LA) "	%0, 1f\n\t"				\
> +	"jr.hb	%0\n\t"							\
> +	"1:"								\
>  	: "=r" (tmp));							\
>  } while (0)


The .set will need to stay or this will fail up on older processors
with

/tmp/ccKNXiPT.s:21: Error: opcode not supported on this processor: mips1 (mips1) `jr.hb '

The opcode of JR.HB will by older processors be treated as just a JR afair.

Or with less inline assembler obscurities something like:

void foo(void)
{
        void *jr = &&jr;

        __asm__ __volatile__(
	"       .set	"MIPS_ISA_LEVEL"				\n"
        "       jr.hb							\n"
	"	.set	mips0						\n"
        : /* no outputs */
        : "r" (jr));
jr:     ;
}

Now GCC can even schedule loading the address or do other clever things.

  Ralf
