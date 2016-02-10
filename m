Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 10 Feb 2016 01:54:40 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:53843 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27011376AbcBJAyjLKRSx (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 10 Feb 2016 01:54:39 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email Security Gateway with ESMTPS id D0EA68B7685F3;
        Wed, 10 Feb 2016 00:54:28 +0000 (GMT)
Received: from [10.100.200.149] (10.100.200.149) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Wed, 10 Feb 2016
 00:54:32 +0000
Date:   Wed, 10 Feb 2016 00:54:31 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
CC:     <linux-mips@linux-mips.org>, Ralf Baechle <ralf@linux-mips.org>,
        <blogic@openwrt.org>, <cernekee@gmail.com>,
        <jon.fraser@broadcom.com>, <pgynther@google.com>,
        <paul.burton@imgtec.com>, <ddaney.cavm@gmail.com>
Subject: Re: [PATCH 1/6] MIPS: BMIPS: Disable pref 30 for buggy CPUs
In-Reply-To: <56BA7E94.6080302@gmail.com>
Message-ID: <alpine.DEB.2.00.1602100013570.15885@tp.orcam.me.uk>
References: <1455051354-6225-1-git-send-email-f.fainelli@gmail.com> <1455051354-6225-2-git-send-email-f.fainelli@gmail.com> <alpine.DEB.2.00.1602092101240.15885@tp.orcam.me.uk> <56BA6AD3.9050308@gmail.com> <alpine.DEB.2.00.1602092245180.15885@tp.orcam.me.uk>
 <56BA7E94.6080302@gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.100.200.149]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 51959
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

On Wed, 10 Feb 2016, Florian Fainelli wrote:

> >  So first, are you aware of support for these Broadcom instruction 
> > encoding extensions being considered for inclusion in binutils?  I'll be 
> > happy to accept a patch and AFAICT it's a simple extension of the `sel' 
> > field within the existing MFC0/MTC0 instruction definitions.
> 
> That's a bit of a stretch for something that a) nobody is likely to
> benefit from except these two patches, b) introducing a 3 way dependency
> with: getting these current patches accepted, wait for the new binutils
> to be widely spread we can count on the assembler to know about these
> additional selectors, update the kernel again...

 No need to wait, we have all the build tools at hand, that is we could 
conditionalise it on $(as-instr), formulated appropriately.  See 
Documentation/kbuild/makefiles.txt and examples in our tree.

 Overall I think the toolchain should be complete, even if for an exotic 
case here or there.  If a processor has an instruction, then the assembler 
should support it.  As I say this addition looks very simple to me and I 
could (and, if nobody beats me to, probably will, now that I'm aware) make 
such a change to binutils myself, but I'd prefer to get a change from 
someone actually having a documentation reference for the instruction set 
extension.

 An immediate benefit will be that you'll get a proper disassembly in 
`objdump' so the unaware poor soul debugging an odd issue won't have to 
scratch their head wondering what the heck 0x4008b008 in disassembly is, 
and if this is toolchain bug or some corruption (though it would likely 
still require telling the disassembler to use BMIPS5000 as the processor 
to disassemble for).

> > #define __read_32bit_c0_brcm_register(reg, sel)				\
> > ({									\
> > 	register unsigned int __res asm("t0");				\

 Actually on second thoughts explicit asm("$8") will be better here.  For 
GCC both variants are equivalent, unlike GAS the compiler does not have a 
concept of ABI register names, so no `a4' in place of `t0', etc., but 0x08 
is embedded in the instruction word used, so better have it consistent.

> > (why is ROTR set along NO_PREF30 BTW? -- it does not seem related).
> 
> They are not, Petri is quoting the downstream kernel which does thing
> completely differently because it has separate build options per SoC.
> The upstream kernel does not, it can run the sam binary on multiple SoCs
> and perform run-time detection, hence the two patches which changes
> things at two different spots because, unrelated.

 Hmm, maybe call the quirk `bmips5000_pref30_rotr_quirk' or suchlike then?

> >  I hope you agree this all is reasonable from a maintainer's point of 
> > view.  I'll leave it up to you to make a patch out of it.  You'll then be 
> > able to use this stuff in 2/6 too.
> 
> It seems reasonable to adopt your suggestion, but I will certainly drop
> the binutils suggestion, that's just way out of the scope of this patch,
> and creates a dependency issue that I do not want to deal with, as
> history showed recently, testing correctly for a proper ld version
> turned out to be interesting, so pardon my skepticism here.

 Fine with me, I just wanted to have a full picture and also hoped a 
little a patch might have already been in the works.

 The LD version case?  Well, the lack of experience with the toolchain has 
certainly contributed here (not a blame, not especially for kernel hackers 
who need not necessarily go down to such details, just an observation -- 
though I think a question how to correctly interpret binutils versioning 
posted to <binutils@sourceware.org> would have certainly been addressed 
with a correct answer).  We've had an LD version check sorted out since 
forever in glibc's build machinery for example, by using prefix matching, 
essentially. :)

> >  Please try to give meaningful names to the other magic numbers you 
> > introduce too.
> 
> These are actually *magic* register values, I swear to you, I had to dig
> in the RTL to understand what this does, there is zero documentation
> besides the code.

 OK, fair enough.  Thanks for your patience in explaining the details!

  Maciej
