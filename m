Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 04 Nov 2016 14:42:57 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:56960 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23993066AbcKDNmucTqNt convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 4 Nov 2016 14:42:50 +0100
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id 9C94F8C118532;
        Fri,  4 Nov 2016 13:42:38 +0000 (GMT)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 4 Nov 2016 13:42:41 +0000
Received: from HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3]) by
 HHMAIL-X.hh.imgtec.org ([fe80::3509:b0ce:371:2b%18]) with mapi id
 14.03.0294.000; Fri, 4 Nov 2016 13:42:40 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Maciej Rozycki <Maciej.Rozycki@imgtec.com>,
        Guenter Roeck <linux@roeck-us.net>
CC:     Ralf Baechle <ralf@linux-mips.org>,
        Alex Smith <Alex.Smith@imgtec.com>,
        "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        James Hogan <James.Hogan@imgtec.com>
Subject: RE: [PATCH] MIPS: VDSO: Always select -msoft-float
Thread-Topic: [PATCH] MIPS: VDSO: Always select -msoft-float
Thread-Index: AQHSNpqpZSKpsmkzvECGzdemX2t3KKDIyilQ
Date:   Fri, 4 Nov 2016 13:42:40 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235380AB79B7@HHMAIL01.hh.imgtec.org>
References: <1477843551-21813-1-git-send-email-linux@roeck-us.net>
 <alpine.DEB.2.00.1611012208400.24498@tp.orcam.me.uk>
 <20161101233038.GA25472@roeck-us.net>
 <alpine.DEB.2.00.1611022043010.24498@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.00.1611022043010.24498@tp.orcam.me.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [192.168.152.105]
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
Return-Path: <Matthew.Fortune@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 55670
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: Matthew.Fortune@imgtec.com
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

Maciej Rozycki <Maciej.Rozycki@imgtec.com> writes:
> On Tue, 1 Nov 2016, Guenter Roeck wrote:
> 
> > > > Some toolchains fail to build mips images with the following build
> error.
> > > >
> > > > arch/mips/vdso/gettimeofday.c:1:0: error: '-march=r3000' requires
> '-mfp32'
> > > >
> > > > This is seen, for example, with the 'mipsel-linux-gnu-gcc (Debian
> > > > 6.1.1-9)
> > > > 6.1.1 20160705' toolchain as used by the 0Day build robot when
> > > > building decstation_defconfig.
> > > >
> > > > Comparison of compile flags suggests that the major difference is
> > > > a missing '-soft-float', which is otherwise defined
> unconditionally.
> > > >
> > > > Reported-by: kbuild test robot <fengguang.wu@intel.com>
> > > > Cc: James Hogan <james.hogan@imgtec.com>
> > > > Fixes: ebb5e78cc634 ("MIPS: Initial implementation of a VDSO")
> > > > Signed-off-by: Guenter Roeck <linux@roeck-us.net>
> > > > ---
> [...]
> > >  If you send me the generated assembly, i.e. `gettimeofday.s', that
> > > is causing you trouble, then I'll see if I can figure out what is
> > > going on here.  We may decide to paper a particularly nasty
> > > toolchain bug over from
> >
> > The problem is seen in 0Day builds, with the toolchain mentioned
> above.
> 
>  That does not tell me anything -- I have no idea how each of the
> toolchains out there has been configured.  I can only assess information
> provided by the bug/patch submitter, and otherwise try guessing.
> 
> > I don't think that generated assembly is going to help, though, since
> > the compiler fails to compile the code in the first place because, as
> > it says, it doesn't like '-march=r3000' without '-mfp32'.
> 
>  Indeed I got that confused, even though there is supposed to be a
> mention in the compiler's diagnostics if a warning or error has
> originated from an external tool invoked.  Sorry about that.  The
> message itself could well have come from the assembler though as the
> same options are accepted by that tool.
> 
>  And indeed I have just guessed what the cause might be, that is the
> compiler must have been configured with an explicit `--with-fp-32=xx' or
> `--with-fp-32=64' option.

This is almost certainly using --with-fp-32=xx

>  Here's quite an extensive analysis of what these options do and why:
> <https://dmz-portal.mips.com/wiki/MIPS_O32_ABI_-
> _FR0_and_FR1_Interlinking>
> and I note that there is a mention of a setup which would have avoided
> the situation we have now:
> 
> "Ideally any MIPS I arch/core will default to -mfp32 Any MIPS II ->
> MIPS32r2 arch/core will default to -mfpxx. However, this should be
> controlled via a configure time option to adjust the default ABI from
> O32
> FP32 to O32 FPXX (or O32 FP64 as needed). The new configure time option
> is --with-fp-32=[32|xx|64] and this affects the FP mode only when
> targetting the O32 ABI."
> 
> however this ideal arrangement, which I would expect a configuration
> option like `--with-fp-32=from-isa' (and a corresponding `-mfp=from-isa'
> compiler option) would handle, got lost/forgotten in the works somehow.

The intention of these comments was about vendor tool configurations that
often do more option inference than standard tools. We could do a
--with-fp-32=from-isa but that would not be used by debian anyway as it
does not meet the goal of reliably generating FP compatible code. There are
also subjective answers to the 'from-isa' question as mips32r1 could be
fp32 or fpxx depending on what the toolchain owner wanted to achieve.

>  Matthew has been the expert in this area and might be able to add some
> more -- Matthew?  Also shall we call it a compiler defect?  We seem to
> be getting more and more toolchain configurations which break the
> existing setups in a way requiring them to add more and more compiler
> options to Makefiles for preexisting targets even though the Makefiles
> were previously already prepared to choose the right compiler options
> for the target.  This seems the wrong way to go to me as it's causing
> people burden when upgrading their toolchains while it's supposed to be
> seamless (it's one aspect of maintaining backwards compatibility).

I agree we don't want to take decisions lightly that end up breaking
builds but we should not shy away from them.

In this specific case a kernel for a MIPS I arch is being built from a
toolchain in a distribution that requires MIPS II as a minimum and is
moving towards requiring MIPS32R2 as a minimum. The decisions made when
configuring this toolchain are there to support the intended users so
as we move forward there will be some things that stop working as
before (by default).

Given that then I think this is reasonable fall-out. The options are:
Build this configuration of the kernel using an older distribution,
Build a custom toolchain, Update the kernel to cope with this new
configuration.

In general I think it is reasonable for people to request continued
support for architectures or configurations that are older and have a
smaller user-base but such users may have to invest a little more effort
in configuring as focus is moved to support the wider used variants.

We are also talking about a relatively new feature in the kernel and I
would go so far as to say this is a great example of why trying to
support every MIPS variant is futile; even those with the greatest
knowledge of the architecture, toolchain and history cannot make it
work in every case.

An even simpler solution to this, and better for long term support, is
to disable the vDSO feature for architectures older than 'x' where we
could choose MIPS II or even MIPS32R2 depending on how much simpler
we would like life to be.

>  Meanwhile your proposal may be indeed the way to go, or perhaps we
> could use a substitution rule like:
> 
> 	$(patsubst -march=%,-mfp32,$(filter -march=r3%,$(KBUILD_CFLAGS)))
> 
> -- see the change below, it seems to work for me and the option is
> indeed passed with a `-march=r3000' build (as would with a `-
> march=r3900' build) and suppressed otherwise (such as with a `-
> march=mips32r2' build).

Does the kernel build both hard and soft float variants of the vDSO? When
originally discussing the design for it I don't think it was supposed to.

I believe the .MIPS.abiflags section for the vDSO is overwritten to
claim it is an 'any' FP ABI so that it is compatible with all possible
userland variants so it better not contain any floating point instructions.

I'd therefore suggest using -msoft-float unconditionally is the way to go
when building the vDSO even if it gets disabled for MIPS I completely as
well.

>  I have tried building `arch/mips/vdso/gettimeofday.s' to see how the
> module settings are chosen by the compiler in my successful build, and
> that produced an unexpected result in that the rule for .s targets is
> evidently broken for VDSO as different compiler flags were used from
> ones used for .o targets -- essentially the regular flags rather than
> the special VDSO ones (no `-fPIC', etc.).  So that looks like a bug to
> me to be fixed too.
> 
>  So instead I just checked the ABI annotation of a good .o object with
> `readelf':
> 
> $ readelf -A arch/mips/vdso/gettimeofday.o Attribute Section: gnu File
> Attributes
>   Tag_GNU_MIPS_ABI_FP: Hard float (double precision)
> 
> MIPS ABI Flags Version: 0
> 
> ISA: MIPS1
> GPR size: 32
> CPR1 size: 32
> CPR2 size: 0
> FP ABI: Hard float (double precision)
> ISA Extension: None
> ASEs:
> 	None
> FLAGS 1: 00000000
> FLAGS 2: 00000000
> $
> 
> and I think this would be good to keep.  Obviously this will prevent `-
> mfp64' executables or DSOs from being loaded together with VDSO, but
> they are incompatible with the 32-bit FPU MIPS I processors have anyway,
> so no change in the semantics there.
> 
>  On the other hand there's still the issue what the compiler default
> will be for o32 in a non-r3k build -- which could be any of `-mfp32', `-
> mfpxx'
> or `-mfp64'.  Requesting `-mfpxx' should allow the greatest flexibility,
> but may not be supported as older compilers did not have it, so this
> would have to be added conditionally only, letting those older compilers
> retain their long-established `-mfp32' default.  I have an idea how to
> implement this part if we agree this is indeed the right direction.

As above, unless absolutely critical to have floating point code then
the vDSO should just avoid all FP related issues and build soft-float.

Thanks,
Matthew

>  For the record: `-mfp32' has been there since forever, my little
> research indicating this commit:
> 
> Wed Jan 15 06:22:34 1992  Michael Meissner  (meissner at osf.org)
> 
> 	* mips.h (MIPS_VERSION): Bump Meissner version # to 8.
> 	(fcmp_op): Add function declaration.
> 	(TARGET_FLOAT64): Support for -mfp64 switch to support the R4000 FR
> 	psw bit, which doubles the number of floating point registers.
> 	(TARGET_SWITCHES): Likewise.
> 	(HARD_REGNO_NREGS): Likewise.
> 	(CLASS_FCMP_OP): New bit for classifing floating point compares.
> 	(PREDICATE_CODES): Add cmp2_op and fcmp_op support.
> [...]
> 
> which corresponds to GCC 2.0 released roughly a month afterwards,
> although the exact diff seems to have been lost in the mist of history.
> The oldest version of `mips.h' in the modern GCC repository dates back
> to r297 from
> 11 Feb 1992 where it already contains `-mfp32' support; obviously a sign
> of an inaccurate import of those old changes.  Anyway the option is
> surely always safe to use nowadays.
> 
>   Maciej
> 
> linux-mips-r3k-vdso-fp32.diff
> Index: linux-sfr-decstation/arch/mips/vdso/Makefile
> ===================================================================
> --- linux-sfr-decstation.orig/arch/mips/vdso/Makefile	2016-10-23
> 06:15:11.000000000 +0100
> +++ linux-sfr-decstation/arch/mips/vdso/Makefile	2016-11-03
> 22:44:31.752065000 +0000
> @@ -6,7 +6,8 @@ ccflags-vdso := \
>  	$(filter -I%,$(KBUILD_CFLAGS)) \
>  	$(filter -E%,$(KBUILD_CFLAGS)) \
>  	$(filter -mmicromips,$(KBUILD_CFLAGS)) \
> -	$(filter -march=%,$(KBUILD_CFLAGS))
> +	$(filter -march=%,$(KBUILD_CFLAGS)) \
> +	$(patsubst -march=%,-mfp32,$(filter -march=r3%,$(KBUILD_CFLAGS)))
>  cflags-vdso := $(ccflags-vdso) \
>  	$(filter -W%,$(filter-out -Wa$(comma)%,$(KBUILD_CFLAGS))) \
>  	-O2 -g -fPIC -fno-strict-aliasing -fno-common -fno-builtin -G 0 \
