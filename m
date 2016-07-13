Received: with ECARTIS (v1.0.0; list linux-mips); Thu, 14 Jul 2016 01:16:40 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:3941 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23995219AbcGMXQeM04vm (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Thu, 14 Jul 2016 01:16:34 +0200
Received: from HHMAIL01.hh.imgtec.org (unknown [10.100.10.19])
        by Forcepoint Email with ESMTPS id AFFA0904DEFCC;
        Thu, 14 Jul 2016 00:16:12 +0100 (IST)
Received: from [10.20.78.59] (10.20.78.59) by HHMAIL01.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.294.0; Thu, 14 Jul 2016
 00:16:16 +0100
Date:   Thu, 14 Jul 2016 00:16:06 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     Matthew Fortune <Matthew.Fortune@imgtec.com>,
        Joseph Myers <joseph@codesourcery.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "binutils@sourceware.org" <binutils@sourceware.org>,
        "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
Subject: RE: [RFC v2] MIPS ABI Extension for IEEE Std 754 Non-Compliant
 Interlinking
In-Reply-To: <6D39441BF12EF246A7ABCE6654B023537E40C27F@hhmail02.hh.imgtec.org>
Message-ID: <alpine.DEB.2.00.1607121323050.4076@tp.orcam.me.uk>
References: <alpine.DEB.2.00.1605141043120.6794@tp.orcam.me.uk> <6D39441BF12EF246A7ABCE6654B023537E40C27F@hhmail02.hh.imgtec.org>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.59]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 54328
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

Hi Matthew,

 I'm back to this effort now, thanks for patience.

> Thanks for the update.  I've read through the whole proposal again and
> it looks good.  I'd like to discuss legacy objects a bit more though...

 Thanks for your review.

> > 3.4 Relocatable Object Generation
> > 
> >  Tools that produce relocatable objects such as the assembler shall
> > always produce a SHT_MIPS_ABIFLAGS section according to the IEEE Std 754
> > compliance mode selected.  In the absence of any explicit user
> > instructions the `strict' mode shall be assumed.  No new `legacy'
> > objects shall be produced.
> 
> Is it necessary to say that no new legacy objects can be created?

 It is of course not necessary in the sense that we are free to make a 
decision here rather than being constrained by hardware or another 
technical requirement.

 However I think only supporting the two explicit `strict' and `relaxed' 
modes makes the solution proposed consistent, and has indeed been the 
basis of my design.

 The principle I have followed here has been that it's the author of 
software who knows exactly what his code requires for correct operation, 
and sets the correct flags in the Makefile or whatever build system he 
uses.  Joseph's earlier proposal to have a generic `-fieee' option rather 
than a target one fits here very well in that the author can stick it in 
the build system without the exact knowledge of what target-specific 
constraints may be.  Such an option would preferably be placed such that 
it is not accidentally lost e.g. with an OS distribution packager's CFLAGS 
override, which is typically made in a system-wide automated way when a 
distribution is build.

 Still a distribution packager or another person building their piece of 
software of interest, perhaps individually, has control here, being able 
to change build options one way or another, at least by patching Makefiles 
if necessary.  So they can choose `strict' or `relaxed' as needed.

 Finally the system administrator configuring a system or the individual 
user running software has the least knowledge of the low-level 
requirements of individual pieces of software.

 So ideally we'd not even have these kernel override modes and 
unconditionally treat `legacy' binaries as `strict', under the principle 
of the least surprise.  Realistically however that would make the 
transition to R5/R6 very painful for people, requiring them to rebuild all 
software previously built for the legacy NaN encoding, even though only a 
small subset of software actually relies on the semantics of signalling 
NaNs.

 And this is exactly where the idea of a user-selectable kernel acceptance 
mode came from.  I expect that both existing and new installations on 
legacy-NaN hardware will continue operating with the `strict' conformance 
mode and won't ever have to switch that as any new software built for 
pre-R5 targets and with the 2008-NaN encoding in mind will be built as 
`relaxed' binaries.  Whereas virtually all R5/R6 installations will run in 
the `relaxed' conformance mode, permitting the use of any existing pre-R5 
`legacy' binaries, however with the risk of some of them producing the 
wrong results.

 Consequently allowing new tools to build more `legacy' binaries will just 
let the issue continue where the mode software being run in depends on the 
hardware configuration rather than a conscious choice of the software 
packager.  Whereas support for running `legacy' binaries in the `relaxed' 
mode is really there to help people transition.

> I think there is value in still being able to generate legacy objects because
> of the fact that strict executables leave no room for override at runtime.
> Apart from the fact that strict cannot be disabled there is otherwise no
> difference between legacy and strict compliance modes.

 Can you please be more specific?  Where's the value from letting people 
override the mode of software known to require signalling NaN support?

> I believe the strict option is really intended for conscious use so that
> programmers who know they need it, can use it. Ordinary users still get the
> casual safety they need as legacy objects are just as good as strict until
> overridden. If we lose the ability to override then in some environments we
> will accumulate lots of needlessly strict executables just because of a tools
> upgrade whereas the old tools would have generated executables that were as
> safe but also could be overridden by kernel options. 

 I think the casual safety is an illusion.

 As soon as a user gets an execution error from a legacy-NaN legacy binary 
on 2008-NaN hardware (or vice versa), they'll hit Google or discussion 
list archives for a solution, find the `ieee754=relaxed' kernel option, 
stick it into their bootloader configuration and forget about it, running 
all their software from the on in the `relaxed' mode anyway.

 Eventually distributions will probably do that as well even if they built 
their own packages as `relaxed', to reduce support noise from people 
running `legacy' third-party software built for the opposite NaN encoding.

 Now, assuming that their software is indeed safe for `relaxed' mode 
operation with the binary `strict'/`relaxed' choice available you have 
valuable information carried within binaries themselves -- they tell you 
whether they care about signalling NaN interpretation or not rather than 
maybe/maybe-not.

> Allowing legacy objects to be generated may also allow the linkage rules to
> be tightened.  I.e. Forcing a relaxed mode at link time could simply fail
> if confronted by a strict object instead only allowing legacy objects to
> be relaxed.

 We can still have a mode where a `strict' object is rejected in a static 
link.  Though I'm not sure if there's value in it.  If so, then perhaps we 
need a `never relax' flag instead.  Do you have a specific use case in 
mind?

> A default build of GCC and binutils would therefore still generate legacy
> objects until someone consciously updated the configure options or used
> command line options.
 
 As I've argued above I'm inconvinced that keeping the `legacy' mode 
supported for newly built binaries is a good idea.  If you're concerned 
about software being built as `strict' unnecessarily, then I think we have 
two solutions here:

1. We can default the toolchain configuration to the `relaxed' (or 
   strictly speaking the `relaxed-exec') mode.  This way someone upgrading 
   their OS from sources will not fall into a trap of building their 
   software as `strict' by the lone result of missing the required 
   newly-added configuration option, rather than a conscious decision.  I 
   think this would be a reasonably safe move, as a signalling NaN support
   requirement is I believe relatively uncommon across software.

2. An idea has been proposed to have objects marked by the assembler to 
   indicate whether they include an FP hardware instruction or not.  The 
   latters would automatically become don't-cares as far as NaN encoding
   is concerned and if all the objects were such in a given static link, 
   then the resulting executable would become NaN-encoding agnostic, 
   ignoring any `strict' or `relaxed' modes.  This would exclude a large
   amount of software from the checks discussed in this specification,
   although a question still remains open how shared libraries loaded by 
   such a program would be treated if they for a change did include FP
   hardware instructions.

Does either of the proposals address your concerns?  Is there anything I 
may have missed here?

 I will appreciate input from other people as well, so that it's not a 
discussion just between Matthew and myself.  Joseph, does your experience 
in this area give you any insights?

  Maciej
