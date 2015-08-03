Received: with ECARTIS (v1.0.0; list linux-mips); Mon, 03 Aug 2015 16:12:02 +0200 (CEST)
Received: (from localhost user: 'macro', uid#1010) by eddie.linux-mips.org
        with ESMTP id S27011254AbbHCOMAYveIL (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Mon, 3 Aug 2015 16:12:00 +0200
Date:   Mon, 3 Aug 2015 15:12:00 +0100 (BST)
From:   "Maciej W. Rozycki" <macro@linux-mips.org>
To:     Ralf Baechle <ralf@linux-mips.org>
cc:     James Cowgill <James.Cowgill@imgtec.com>,
        linux-mips@linux-mips.org, stable@vger.kernel.org
Subject: Re: [PATCH] MIPS: replace add and sub instructions in relocate_kernel.S
 with addiu
In-Reply-To: <20150803133024.GB2843@linux-mips.org>
Message-ID: <alpine.LFD.2.20.1508031457140.1410@eddie.linux-mips.org>
References: <1434557570-30452-1-git-send-email-James.Cowgill@imgtec.com> <20150803133024.GB2843@linux-mips.org>
User-Agent: Alpine 2.20 (LFD 67 2015-01-07)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Return-Path: <macro@linux-mips.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 48544
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: macro@linux-mips.org
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

On Mon, 3 Aug 2015, Ralf Baechle wrote:

> > Fixes the assembler errors generated when compiling a MIPS R6 kernel with
> > CONFIG_KEXEC on, by replacing the offending add and sub instructions with
> > addiu instructions.
> > 
> > Build errors:
> > arch/mips/kernel/relocate_kernel.S: Assembler messages:
> > arch/mips/kernel/relocate_kernel.S:27: Error: invalid operands `dadd $16,$16,8'
> > arch/mips/kernel/relocate_kernel.S:64: Error: invalid operands `dadd $20,$20,8'
> > arch/mips/kernel/relocate_kernel.S:65: Error: invalid operands `dadd $18,$18,8'
> > arch/mips/kernel/relocate_kernel.S:66: Error: invalid operands `dsub $22,$22,1'
> > scripts/Makefile.build:294: recipe for target 'arch/mips/kernel/relocate_kernel.o' failed
> > 
> > Signed-off-by: James Cowgill <James.Cowgill@imgtec.com>
> > Cc: Ralf Baechle <ralf@linux-mips.org>
> > Cc: <stable@vger.kernel.org> # 4.0+
> > ---
> >  arch/mips/kernel/relocate_kernel.S | 8 ++++----
> >  1 file changed, 4 insertions(+), 4 deletions(-)
> > 
> > diff --git a/arch/mips/kernel/relocate_kernel.S b/arch/mips/kernel/relocate_kernel.S
> > index 74bab9d..c6bbf21 100644
> > --- a/arch/mips/kernel/relocate_kernel.S
> > +++ b/arch/mips/kernel/relocate_kernel.S
> > @@ -24,7 +24,7 @@ LEAF(relocate_new_kernel)
> >  
> >  process_entry:
> >  	PTR_L		s2, (s0)
> > -	PTR_ADD		s0, s0, SZREG
> > +	PTR_ADDIU	s0, s0, SZREG
> >  
> >  	/*
> >  	 * In case of a kdump/crash kernel, the indirection page is not
> > @@ -61,9 +61,9 @@ copy_word:
> >  	/* copy page word by word */
> >  	REG_L		s5, (s2)
> >  	REG_S		s5, (s4)
> > -	PTR_ADD		s4, s4, SZREG
> > -	PTR_ADD		s2, s2, SZREG
> > -	LONG_SUB	s6, s6, 1
> > +	PTR_ADDIU	s4, s4, SZREG
> > +	PTR_ADDIU	s2, s2, SZREG
> > +	LONG_ADDIU	s6, s6, -1
> 
> Thanks, applied.
> 
> But I was wondering if maybe we should redefine the PTR_ADD, LONG_SUB etc
> macros to expand into a signed operation for R6.  While I can't convince
> myself it's the right and conceptually clean thing to do, I don't think
> it'd be clearly wrong and it might help preventing numersous bugs by
> applications that use <asm/asm.h>.  Opinions?

 It looks to me like missing assembly language macro implementations.  For 
R6:

	dadd	$16, $16, 8

should merely expand to a sequence of machine instructions like this:

	addiu	$1, $0, 8
	dadd	$16, $16, $1

which for older ISA revisions would happen anyway if the third operand was 
immediate and fell outside the signed 16-bit range.  Here the immediate 
range simply got shrunk to 0 bits with the transition to R6.

 I know some people disagree, but I maintain my point of view, which is 
consistent with how the MIPS assembly language has always been defined. 
That helps with assembly language's backward compatibility at the source 
level too, just as previously observed with the transition to the 
microMIPS instruction set, where some immediate ranges were shrunk to 12 
or 10 bits.

 These macros have also been a part of the user API (defined in 
<sys/asm.h>), which is another argument in favour to fixing the assembler.

  Maciej
