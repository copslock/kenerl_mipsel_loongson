Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 04 Feb 2016 17:15:36 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:51623 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27012696AbcBDQPeNiTg8 (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 4 Feb 2016 17:15:34 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id EED145515070E;
        Thu,  4 Feb 2016 16:15:24 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Thu, 4 Feb 2016
 16:15:27 +0000
Date:   Thu, 4 Feb 2016 16:15:26 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Ralf Baechle <ralf@linux-mips.org>
CC:     Paul Burton <paul.burton@imgtec.com>, <linux-mips@linux-mips.org>,
        <linux-kernel@vger.kernel.org>,
        James Hogan <james.hogan@imgtec.com>,
        "Maciej W. Rozycki" <macro@linux-mips.org>
Subject: Re: [PATCH] MIPS: Stop using dla in 32 bit kernels
In-Reply-To: <20160204151833.GE18491@linux-mips.org>
Message-ID: <alpine.DEB.2.00.1602041538370.15885@tp.orcam.me.uk>
References: <1454596317-5042-1-git-send-email-paul.burton@imgtec.com> <20160204151833.GE18491@linux-mips.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51786
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@imgtec.com
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

On Thu, 4 Feb 2016, Ralf Baechle wrote:

> >       CC      arch/mips/mm/c-r4k.o
> >     {standard input}: Assembler messages:
> >     {standard input}:4105: Warning: dla used to load 32-bit register;
> >         recommend using la instead
> >     {standard input}:4129: Warning: dla used to load 32-bit register;
> >         recommend using la instead
> 
> Sigh.  Another new binutils warning?

 It's been there almost since forever or specifically:

commit 3bec30a8305f9f5d5649b5e1fc9ed78a1c3c109a
Author: Thiemo Seufer <ths@networkno.de>
Date:   Tue May 14 23:35:59 2002 +0000

	* config/tc-mips.c (macro): Warn about wrong la/dla use.

It might be interesting to know what changed in the kernel to trigger this 
warning -- at the very least see the CONFIG_CPU option active and the 
compiler's command line hidden in the original report; I'm assuming 
arch/mips/mm/c-r4k.o is built with `-Werror', so it would be a 
catastrophic failure if it triggered before and it's indeed a regression 
rather than a bug which has always been there.

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
[...]
> The .set will need to stay or this will fail up on older processors
> with
> 
> /tmp/ccKNXiPT.s:21: Error: opcode not supported on this processor: mips1 (mips1) `jr.hb '
> 
> The opcode of JR.HB will by older processors be treated as just a JR afair.

 Some will run and some may trap with RI I believe.  IIRC the original 
MIPS32r1 4Kc (not 4KEc) traps, though this might merely have been an 
erratum we could handle in `do_ri', as the ERET at exit would do as well.

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

 This may have a chance to work, but I don't think it's a supported 
construct.  This is asking for trouble IMHO, as GCC expects an asm to fall 
through and you might be missing instructions which the compiler has 
placed between the asm and `jr' (IIUC this is even noted in the comment I 
left quoted above).  Of course here we expect nothing to be there, but 
still.

 With newer GCC versions I think you could use `asm goto', however it's a 
pretty recent addition and I don't think we want to limit people in the 
choice of the compiler to use to build Linux for such an obscure corner 
case.

  Maciej
