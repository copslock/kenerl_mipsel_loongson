Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 16:49:17 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:22741 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012696AbcBDPtPrJ0r8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 16:49:15 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Websense Email Security Gateway with ESMTPS id 7D12345965F5A;
        Thu,  4 Feb 2016 15:49:06 +0000 (GMT)
Received: from LEMAIL01.le.imgtec.org (192.168.152.62) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.266.1; Thu, 4 Feb 2016 15:49:09 +0000
Received: from localhost (10.100.200.26) by LEMAIL01.le.imgtec.org
 (192.168.152.62) with Microsoft SMTP Server (TLS) id 14.3.210.2; Thu, 4 Feb
 2016 15:49:03 +0000
Date:   Thu, 4 Feb 2016 15:49:00 +0000
From:   Paul Burton <paul.burton@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     <linux-mips@linux-mips.org>, <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] MIPS: Stop using dla in 32 bit kernels
Message-ID: <20160204154900.GA31145@NP-P-BURTON>
References: <1454596317-5042-1-git-send-email-paul.burton@imgtec.com>
 <20160204151833.GE18491@linux-mips.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20160204151833.GE18491@linux-mips.org>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-Originating-IP: [10.100.200.26]
Return-Path: <Paul.Burton@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51777
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: paul.burton@imgtec.com
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

On Thu, Feb 04, 2016 at 04:18:34PM +0100, Ralf Baechle wrote:
> On Thu, Feb 04, 2016 at 02:31:57PM +0000, Paul Burton wrote:
> 
> >       CC      arch/mips/mm/c-r4k.o
> >     {standard input}: Assembler messages:
> >     {standard input}:4105: Warning: dla used to load 32-bit register;
> >         recommend using la instead
> >     {standard input}:4129: Warning: dla used to load 32-bit register;
> >         recommend using la instead
> 
> Sigh.  Another new binutils warning?
> 
> > Avoid this by instead making use of the PTR_LA macro which defines the
> > appropriate variant of the "la" instruction to use.
> > 
> > Tested with Codescape GNU Tools 2015.06-05 for MIPS IMG Linux, which
> > includes binutils 2.24.90 & gcc 4.9.2.
> 
> > @@ -54,22 +55,16 @@
> >  
> >  /*
> >   * gcc has a tradition of misscompiling the previous construct using the
> > - * address of a label as argument to inline assembler.	Gas otoh has the
> > - * annoying difference between la and dla which are only usable for 32-bit
> > - * rsp. 64-bit code, so can't be used without conditional compilation.
> > - * The alterantive is switching the assembler to 64-bit code which happens
> > - * to work right even for 32-bit code ...
> > + * address of a label as argument to inline assembler.
> >   */
> >  #define instruction_hazard()						\
> >  do {									\
> >  	unsigned long tmp;						\
> >  									\
> >  	__asm__ __volatile__(						\
> > -	"	.set "MIPS_ISA_LEVEL"				\n"	\
> > -	"	dla	%0, 1f					\n"	\
> > -	"	jr.hb	%0					\n"	\
> > -	"	.set	mips0					\n"	\
> > -	"1:							\n"	\
> > +	__stringify(PTR_LA) "	%0, 1f\n\t"				\
> > +	"jr.hb	%0\n\t"							\
> > +	"1:"								\
> >  	: "=r" (tmp));							\
> >  } while (0)
> 
> 
> The .set will need to stay or this will fail up on older processors
> with
> 
> /tmp/ccKNXiPT.s:21: Error: opcode not supported on this processor: mips1 (mips1) `jr.hb '
> 
> The opcode of JR.HB will by older processors be treated as just a JR afair.

Ok, I'll put the .set back.

> Or with less inline assembler obscurities something like:
> 
> void foo(void)
> {
>         void *jr = &&jr;
> 
>         __asm__ __volatile__(
> 	"       .set	"MIPS_ISA_LEVEL"				\n"
>         "       jr.hb							\n"
> 	"	.set	mips0						\n"
>         : /* no outputs */
>         : "r" (jr));
> jr:     ;
> }
> 
> Now GCC can even schedule loading the address or do other clever things.

Yes, but judging from the comment preceeding instruction_hazard() some
versions of gcc can also do clever things like miscompile that. Maybe we
don't care any more - the comment doesn't say which versions were
affected...

Thanks,
    Paul

>   Ralf
