Received: with ECARTIS (v1.0.0; list linux-mips); Wed, 23 Nov 2016 01:08:53 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:36711 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993072AbcKWAIqCmypP (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Wed, 23 Nov 2016 01:08:46 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id E6F2CE51E1D82;
        Wed, 23 Nov 2016 00:08:31 +0000 (GMT)
Received: from [10.20.78.128] (10.20.78.128) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Wed, 23 Nov 2016
 00:08:34 +0000
Date:   Wed, 23 Nov 2016 00:08:26 +0000
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>
CC:     Guenter Roeck <linux@roeck-us.net>,
        Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <Alex.Smith@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hogan <James.Hogan@imgtec.com>
Subject: RE: [PATCH] MIPS: VDSO: Always select -msoft-float
In-Reply-To: <6D39441BF12EF246A7ABCE6654B0235380AB79B7@HHMAIL01.hh.imgtec.org>
Message-ID: <alpine.DEB.2.00.1611041537570.13938@tp.orcam.me.uk>
References: <1477843551-21813-1-git-send-email-linux@roeck-us.net> <alpine.DEB.2.00.1611012208400.24498@tp.orcam.me.uk> <20161101233038.GA25472@roeck-us.net> <alpine.DEB.2.00.1611022043010.24498@tp.orcam.me.uk>
 <6D39441BF12EF246A7ABCE6654B0235380AB79B7@HHMAIL01.hh.imgtec.org>
User-Agent: Alpine 2.20.17 (DEB 179 2016-10-28)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.128]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55863
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

On Fri, 4 Nov 2016, Matthew Fortune wrote:

> > > I don't think that generated assembly is going to help, though, since
> > > the compiler fails to compile the code in the first place because, as
> > > it says, it doesn't like '-march=r3000' without '-mfp32'.
> > 
> >  Indeed I got that confused, even though there is supposed to be a
> > mention in the compiler's diagnostics if a warning or error has
> > originated from an external tool invoked.  Sorry about that.  The
> > message itself could well have come from the assembler though as the
> > same options are accepted by that tool.
> > 
> >  And indeed I have just guessed what the cause might be, that is the
> > compiler must have been configured with an explicit `--with-fp-32=xx' or
> > `--with-fp-32=64' option.
> 
> This is almost certainly using --with-fp-32=xx

 Thanks for reconfirming.

> >  Here's quite an extensive analysis of what these options do and why:
> > <https://dmz-portal.mips.com/wiki/MIPS_O32_ABI_-
> > _FR0_and_FR1_Interlinking>
> > and I note that there is a mention of a setup which would have avoided
> > the situation we have now:
> > 
> > "Ideally any MIPS I arch/core will default to -mfp32 Any MIPS II ->
> > MIPS32r2 arch/core will default to -mfpxx. However, this should be
> > controlled via a configure time option to adjust the default ABI from
> > O32
> > FP32 to O32 FPXX (or O32 FP64 as needed). The new configure time option
> > is --with-fp-32=[32|xx|64] and this affects the FP mode only when
> > targetting the O32 ABI."
> > 
> > however this ideal arrangement, which I would expect a configuration
> > option like `--with-fp-32=from-isa' (and a corresponding `-mfp=from-isa'
> > compiler option) would handle, got lost/forgotten in the works somehow.
> 
> The intention of these comments was about vendor tool configurations that
> often do more option inference than standard tools. We could do a
> --with-fp-32=from-isa but that would not be used by debian anyway as it
> does not meet the goal of reliably generating FP compatible code. There are
> also subjective answers to the 'from-isa' question as mips32r1 could be
> fp32 or fpxx depending on what the toolchain owner wanted to achieve.

 Why?

 With the use of `--with-fp-32=xx' the lone effect is a requirement for 
`-march=mips1' (or an equivalent CPU setting) compilations to pass an 
explicit `-mfp32' option or otherwise they fail.  Likewise you need to 
pass `-mfp64' for `-march=mips32r6' compilations.

 The effect on `-march=mips32' is I think irrelevant because it can just 
use `-mfpxx' as being MIPS II compatible the ISA does support LDC1/SDC1 
instructions unconditionally, even though the FPU implementation option is 
limited to 32 bits (not that any MIPS32r1 FPU hardware exist anyway 
AFAIK).  So we can just document the intent for `from-isa' to be maximum 
flexibility (link/load-time compatibility) and explicitly state that for 
`-march=mips32' `from-isa' means `xx'.

 By having `--with-fp-32=from-isa' you'd keep the current `-mfpxx' default 
for the currently working ISAs whereas those which now fail to build would 
not require the user to stick extra options which are implied by the ISA 
constraints anyway.  So you'd have a consistent compatible code unless the 
ISA contradicts it.

 Debian should not care as it's supposed to build all the packages using 
the same `-march=' setting (be it an ISA or CPU); presumably also wired as 
the default by using `--with-arch=' or `--with-arch-32='/`--with-arch-64=' 
as applicable.  Unless there's a packaging error that is, but I don't 
think checking for such a situation should be addressed in the compiler 
which is a generic tool.

> >  Matthew has been the expert in this area and might be able to add some
> > more -- Matthew?  Also shall we call it a compiler defect?  We seem to
> > be getting more and more toolchain configurations which break the
> > existing setups in a way requiring them to add more and more compiler
> > options to Makefiles for preexisting targets even though the Makefiles
> > were previously already prepared to choose the right compiler options
> > for the target.  This seems the wrong way to go to me as it's causing
> > people burden when upgrading their toolchains while it's supposed to be
> > seamless (it's one aspect of maintaining backwards compatibility).
> 
> I agree we don't want to take decisions lightly that end up breaking
> builds but we should not shy away from them.
> 
> In this specific case a kernel for a MIPS I arch is being built from a
> toolchain in a distribution that requires MIPS II as a minimum and is
> moving towards requiring MIPS32R2 as a minimum. The decisions made when
> configuring this toolchain are there to support the intended users so
> as we move forward there will be some things that stop working as
> before (by default).

 The Linux kernel has always been considered a special compilation case, 
starting from that you use a hosted compiler configuration to build a 
freestanding (bare-metal) program that the Linux kernel is.  So we have 
always strived to support building the kernel for ISAs and ABIs different 
from ones configured for userland apps, so that people do not have to 
struggle and get a separate bare-metal cross-compiler just to be able to 
build the kernel.  I think we want to maintain this situation; at least 
this is something I am going to strongly defend myself and neither I have 
heard of anyone else actually wanting to change it.

> Given that then I think this is reasonable fall-out. The options are:
> Build this configuration of the kernel using an older distribution,
> Build a custom toolchain, Update the kernel to cope with this new
> configuration.
> 
> In general I think it is reasonable for people to request continued
> support for architectures or configurations that are older and have a
> smaller user-base but such users may have to invest a little more effort
> in configuring as focus is moved to support the wider used variants.
> 
> We are also talking about a relatively new feature in the kernel and I
> would go so far as to say this is a great example of why trying to
> support every MIPS variant is futile; even those with the greatest
> knowledge of the architecture, toolchain and history cannot make it
> work in every case.

 That I think is a matter of resource availability rather than an inherent 
problem with the architecture.

> An even simpler solution to this, and better for long term support, is
> to disable the vDSO feature for architectures older than 'x' where we
> could choose MIPS II or even MIPS32R2 depending on how much simpler
> we would like life to be.

 That might well be an option, for instance because we don't have the CP0 
Count register anyway below MIPS III and have no RDHWR to read it from the 
user mode before MIPSr2 either, and also we have no XI bit in the TLB 
across these older implementations (the earliest incarnation of XI is 4KS 
or MIPSr1+SmartMIPS), so there's no benefit from avoiding signal return 
stack trampolines.

 OTOH `clock_gettime' can still see benefit with its coarse modes, 
although I believe they are not as frequently used.

> >  Meanwhile your proposal may be indeed the way to go, or perhaps we
> > could use a substitution rule like:
> > 
> > 	$(patsubst -march=%,-mfp32,$(filter -march=r3%,$(KBUILD_CFLAGS)))
> > 
> > -- see the change below, it seems to work for me and the option is
> > indeed passed with a `-march=r3000' build (as would with a `-
> > march=r3900' build) and suppressed otherwise (such as with a `-
> > march=mips32r2' build).
> 
> Does the kernel build both hard and soft float variants of the vDSO? When
> originally discussing the design for it I don't think it was supposed to.
> 
> I believe the .MIPS.abiflags section for the vDSO is overwritten to
> claim it is an 'any' FP ABI so that it is compatible with all possible
> userland variants so it better not contain any floating point instructions.
> 
> I'd therefore suggest using -msoft-float unconditionally is the way to go
> when building the vDSO even if it gets disabled for MIPS I completely as
> well.

 Indeed, the linker script generated from arch/mips/vdso/vdso.lds.S and 
used to link the embedded image of the vDSO strips any original input 
`.MIPS.abiflags' sections produced by GAS with the object files and then 
code in arch/mips/vdso/genvdso.c postprocesses the image generated, 
substituting hardcoded data from arch/mips/vdso/elf.S as the ultimate 
contents of `.MIPS.abiflags'.  So whether we use `-msoft-float' or any 
other FP ABI selection option in compilation, it will ultimately be 
substituted with what `-mno-float' would produce.  I wasn't aware of this 
arrangement, so thanks for the mention of it.

 Also I've looked through startup code of the dynamic loader and static 
libc, and it appears to me the vDSO is accepted as it is by the generic 
`setup_vdso' handler in elf/setup-vdso.h, based solely on the presence of 
an auxiliary vector's SYSINFO_EHDR entry and no further machine-specific 
checks, indeed as I previously suspected.

> >  I have tried building `arch/mips/vdso/gettimeofday.s' to see how the
> > module settings are chosen by the compiler in my successful build, and
> > that produced an unexpected result in that the rule for .s targets is
> > evidently broken for VDSO as different compiler flags were used from
> > ones used for .o targets -- essentially the regular flags rather than
> > the special VDSO ones (no `-fPIC', etc.).  So that looks like a bug to
> > me to be fixed too.
> > 
> >  So instead I just checked the ABI annotation of a good .o object with
> > `readelf':
> > 
> > $ readelf -A arch/mips/vdso/gettimeofday.o Attribute Section: gnu File
> > Attributes
> >   Tag_GNU_MIPS_ABI_FP: Hard float (double precision)
> > 
> > MIPS ABI Flags Version: 0
> > 
> > ISA: MIPS1
> > GPR size: 32
> > CPR1 size: 32
> > CPR2 size: 0
> > FP ABI: Hard float (double precision)
> > ISA Extension: None
> > ASEs:
> > 	None
> > FLAGS 1: 00000000
> > FLAGS 2: 00000000
> > $
> > 
> > and I think this would be good to keep.  Obviously this will prevent `-
> > mfp64' executables or DSOs from being loaded together with VDSO, but
> > they are incompatible with the 32-bit FPU MIPS I processors have anyway,
> > so no change in the semantics there.
> > 
> >  On the other hand there's still the issue what the compiler default
> > will be for o32 in a non-r3k build -- which could be any of `-mfp32', `-
> > mfpxx'
> > or `-mfp64'.  Requesting `-mfpxx' should allow the greatest flexibility,
> > but may not be supported as older compilers did not have it, so this
> > would have to be added conditionally only, letting those older compilers
> > retain their long-established `-mfp32' default.  I have an idea how to
> > implement this part if we agree this is indeed the right direction.
> 
> As above, unless absolutely critical to have floating point code then
> the vDSO should just avoid all FP related issues and build soft-float.

 Using `-msoft-float' though does not prevent code from including FP 
arithmetic inadvertently, possibly using an incompatible ABI.  What would 
indeed prevent FP code from being produced is the `-mno-float' option I 
mentioned before, which regrettably is not universally enabled across MIPS 
GCC targets though.

 Therefore based on the observations made here and previously I recommend 
using `$(call cc-option,-mno-float,-msoft-float)' rather than plain 
`-msoft-float' so that we don't have to fiddle with this piece again in 
the future, and we need to enable `-mno-float' for `mips*-*-linux*' and 
maybe also other MIPS targets in GCC.  I think the patch description needs 
to state both why we want `-mno-float' (see above) and why `-msoft-float' 
is an acceptable fallback (see further above).

 I think we want to prefer `-mno-float' for the kernel proper as well, as 
the last we want to have in the kernel is soft-float code, even though it 
is indeed FPU user context compatible.  That I think qualifies for a 
separate patch though.

  Maciej
