Received: with ECARTIS (v1.0.0; list linux-mips); Fri, 11 Nov 2016 11:23:51 +0100 (CET)
Received: from mailapp01.imgtec.com ([195.59.15.196]:7125 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S23991940AbcKKKXomp0j4 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Fri, 11 Nov 2016 11:23:44 +0100
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Forcepoint Email with ESMTPS id 71A64440F61B0;
        Fri, 11 Nov 2016 10:23:34 +0000 (GMT)
Received: from HHMAIL-X.hh.imgtec.org (10.100.10.113) by
 hhmail02.hh.imgtec.org (10.100.10.20) with Microsoft SMTP Server (TLS) id
 14.3.294.0; Fri, 11 Nov 2016 10:23:37 +0000
Received: from HHMAIL01.hh.imgtec.org ([fe80::710b:f219:72bc:e0b3]) by
 HHMAIL-X.hh.imgtec.org ([fe80::3509:b0ce:371:2b%18]) with mapi id
 14.03.0294.000; Fri, 11 Nov 2016 10:23:36 +0000
From:   Matthew Fortune <Matthew.Fortune@imgtec.com>
To:     Maciej Rozycki <Maciej.Rozycki@imgtec.com>,
        Joseph Myers <joseph@codesourcery.com>
CC:     "linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
        "libc-alpha@sourceware.org" <libc-alpha@sourceware.org>,
        "binutils@sourceware.org" <binutils@sourceware.org>,
        "gcc@gcc.gnu.org" <gcc@gcc.gnu.org>
Subject: RE: [RFC v2] MIPS ABI Extension for IEEE Std 754 Non-Compliant
 Interlinking
Thread-Topic: [RFC v2] MIPS ABI Extension for IEEE Std 754 Non-Compliant
 Interlinking
Thread-Index: AQHRrgOUwaHVYqP+hUemv+Dv8MXdNJ+7lSHwgFu3JACAvC92gA==
Date:   Fri, 11 Nov 2016 10:23:36 +0000
Message-ID: <6D39441BF12EF246A7ABCE6654B0235380AC3E7A@HHMAIL01.hh.imgtec.org>
References: <alpine.DEB.2.00.1605141043120.6794@tp.orcam.me.uk>
 <6D39441BF12EF246A7ABCE6654B023537E40C27F@hhmail02.hh.imgtec.org>
 <alpine.DEB.2.00.1607121323050.4076@tp.orcam.me.uk>
In-Reply-To: <alpine.DEB.2.00.1607121323050.4076@tp.orcam.me.uk>
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
X-archive-position: 55785
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
>  I'm back to this effort now, thanks for patience.

Likewise, this thread got buried in email. At the risk of further delaying
this work I do still have issues with the design.

> > > 3.4 Relocatable Object Generation
> > >
> > >  Tools that produce relocatable objects such as the assembler shall
> > > always produce a SHT_MIPS_ABIFLAGS section according to the IEEE Std
> > > 754 compliance mode selected.  In the absence of any explicit user
> > > instructions the `strict' mode shall be assumed.  No new `legacy'
> > > objects shall be produced.
> >
> > Is it necessary to say that no new legacy objects can be created?
> 
>  It is of course not necessary in the sense that we are free to make a
> decision here rather than being constrained by hardware or another
> technical requirement.
> 
>  However I think only supporting the two explicit `strict' and `relaxed'
> modes makes the solution proposed consistent, and has indeed been the
> basis of my design.

This is the bit I think is actually less consistent than it seems on the
surface. The issue is that we have to punch holes in the design in order
to facilitate those users who don't care about ieee compliance and the
way it is done currently is that we allow the static linker to completely
override the 'strict'ness of an input object when using --ieee=relaxed.

This means that a user consciously creating an object that 'needs' ieee
compliance via use of -fieee=strict or -mieee=strict is thwarted by the
next user who builds the executable. This kind of scenario can occur with
a static library prepared by an expert in floating point and then someone
casually including that into a bigger application. Obviously a similar
issue is present with the rules around executable and shared libraries
where the executable's compliance mode can override a shared library
but at this level we are not losing any information and the executable
has either very specifically been set to 'relaxed' mode or the kernel
has set legacy to mean relaxed. The latter can at least be fixed by
changing the kernel. Losing information in a static link cannot be
fixed.

The assumption in the specification is that a user creating a final
executable is the one who should know about ieee compliance issues but
I am not convinced about this. I think it is at the compilation unit
level that issues of ieee compliance should be decided and that should
be a conscious act of the user (or toolchain packager if they want to
force all software to care). I.e. a strict object is strict without
exception throughout static linkage.

The point about not removing legacy objects is that it is an ideal
container for individual objects that don't care or don't yet know
they care about ieee compliance.

The relaxed variant then only becomes applicable when linking multiple
objects and a user has specifically asked to downgrade legacy to relaxed.
Given a legacy object could already be downgraded to relaxed under the
current spec then this does not affect the behaviour of a legacy object.

What this also means is that we can propagate 'legacy' objects through
relocatable links to still get a legacy object which is consistent with
respect to its nan encoding and only later at final link downgrade,
upgrade or retain the compliance level.

These rules combined also mean that a new toolchain that includes
support for these features will, by default, just continue to behave
as today which is the norm for new features. If a user or toolchain
packager decides to enforce stricter ieee checks then they can and
they can face the complexities of combining old and new software
packages as laid out in this spec.

The static linker rules would be almost the same as now but would
not allow strict to be downgraded to relaxed and the 'default' behaviour
could result in legacy objects if they were the only ones in the link.
The spec is currently a little vague on default linker behaviour when
no --ieee option is given but the rules for combining objects without
an override seem relatively obvious. Any 'relaxed' object leads to
a relaxed executable, any 'strict' object leads to a strict executable,
'strict' and 'relaxed' cannot mix, otherwise 'legacy'. This also
eliminates the need for 'nowarn/warn'.

>  The principle I have followed here has been that it's the author of
> software who knows exactly what his code requires for correct operation,
> and sets the correct flags in the Makefile or whatever build system he
> uses.  Joseph's earlier proposal to have a generic `-fieee' option
> rather than a target one fits here very well in that the author can
> stick it in the build system without the exact knowledge of what target-
> specific constraints may be.  Such an option would preferably be placed
> such that it is not accidentally lost e.g. with an OS distribution
> packager's CFLAGS override, which is typically made in a system-wide
> automated way when a distribution is build.
> 
>  Still a distribution packager or another person building their piece of
> software of interest, perhaps individually, has control here, being able
> to change build options one way or another, at least by patching
> Makefiles if necessary.  So they can choose `strict' or `relaxed' as
> needed.

Agreed but this is a per object issue not per executable hence the
proposal above.
 
>  Finally the system administrator configuring a system or the individual
> user running software has the least knowledge of the low-level
> requirements of individual pieces of software.

As above I believe this includes the person building an executable as
well.

>  So ideally we'd not even have these kernel override modes and
> unconditionally treat `legacy' binaries as `strict', under the principle
> of the least surprise.  Realistically however that would make the
> transition to R5/R6 very painful for people, requiring them to rebuild
> all software previously built for the legacy NaN encoding, even though
> only a small subset of software actually relies on the semantics of
> signalling NaNs.
> 
>  And this is exactly where the idea of a user-selectable kernel
> acceptance mode came from.  I expect that both existing and new
> installations on legacy-NaN hardware will continue operating with the
> `strict' conformance mode and won't ever have to switch that as any new
> software built for
> pre-R5 targets and with the 2008-NaN encoding in mind will be built as
> `relaxed' binaries.  Whereas virtually all R5/R6 installations will run
> in the `relaxed' conformance mode, permitting the use of any existing
> pre-R5 `legacy' binaries, however with the risk of some of them
> producing the wrong results.

I have no objections to any of the kernel level support. I think it safely
covers all the requirements.
 
>  Consequently allowing new tools to build more `legacy' binaries will
> just let the issue continue where the mode software being run in depends
> on the hardware configuration rather than a conscious choice of the
> software packager.  Whereas support for running `legacy' binaries in the
> `relaxed'
> mode is really there to help people transition.

We don't need to make this choice for users though. They can make it
for themselves. It is not end users that will make the initial decision
anyway it is distribution maintainers. If those distro maintainers don't
care then we should not remove the tools to do what they want.
 
> > I think there is value in still being able to generate legacy objects
> > because of the fact that strict executables leave no room for override
> at runtime.
> > Apart from the fact that strict cannot be disabled there is otherwise
> > no difference between legacy and strict compliance modes.
> 
>  Can you please be more specific?  Where's the value from letting people
> override the mode of software known to require signalling NaN support?

As above the spec actually permits overriding software known to require
signalling NaN support currently which is the basis of my concerns. This
is the linker level --ieee=relaxed option which I expect would end up the
default in any general purpose distro.

Ref: section 3.3.2 third paragraph.

> > I believe the strict option is really intended for conscious use so
> > that programmers who know they need it, can use it. Ordinary users
> > still get the casual safety they need as legacy objects are just as
> > good as strict until overridden. If we lose the ability to override
> > then in some environments we will accumulate lots of needlessly strict
> > executables just because of a tools upgrade whereas the old tools
> > would have generated executables that were as safe but also could be
> overridden by kernel options.
> 
>  I think the casual safety is an illusion.
> 
>  As soon as a user gets an execution error from a legacy-NaN legacy
> binary on 2008-NaN hardware (or vice versa), they'll hit Google or
> discussion list archives for a solution, find the `ieee754=relaxed'
> kernel option, stick it into their bootloader configuration and forget
> about it, running all their software from the on in the `relaxed' mode
> anyway.
> 
>  Eventually distributions will probably do that as well even if they
> built their own packages as `relaxed', to reduce support noise from
> people running `legacy' third-party software built for the opposite NaN
> encoding.
> 
>  Now, assuming that their software is indeed safe for `relaxed' mode
> operation with the binary `strict'/`relaxed' choice available you have
> valuable information carried within binaries themselves -- they tell you
> whether they care about signalling NaN interpretation or not rather than
> maybe/maybe-not.

I think you took my comments to suggest I didn't agree with having strict
binaries at all. Quite the opposite, the new 'strict' mode is essential
similarly for relaxed albeit I don't find relaxed quite as important it
plays a part.
 
> > Allowing legacy objects to be generated may also allow the linkage
> > rules to be tightened.  I.e. Forcing a relaxed mode at link time could
> > simply fail if confronted by a strict object instead only allowing
> > legacy objects to be relaxed.
> 
>  We can still have a mode where a `strict' object is rejected in a
> static link.  Though I'm not sure if there's value in it.  If so, then
> perhaps we need a `never relax' flag instead.  Do you have a specific
> use case in mind?

I think I've covered this above. I do not believe we need to complicate
this any further to achieve the goals as legacy objects already have
a suitable definition to handle the case of
'strict-by-default-but-relaxable'
 
> > A default build of GCC and binutils would therefore still generate
> > legacy objects until someone consciously updated the configure options
> > or used command line options.
> 
>  As I've argued above I'm inconvinced that keeping the `legacy' mode
> supported for newly built binaries is a good idea.  If you're concerned
> about software being built as `strict' unnecessarily, then I think we
> have two solutions here:

No that is not my concern. My concern is that at static link time we
can disregard the strict flag.

> 1. We can default the toolchain configuration to the `relaxed' (or
>    strictly speaking the `relaxed-exec') mode.  This way someone
> upgrading
>    their OS from sources will not fall into a trap of building their
>    software as `strict' by the lone result of missing the required
>    newly-added configuration option, rather than a conscious decision.
> I
>    think this would be a reasonably safe move, as a signalling NaN
> support
>    requirement is I believe relatively uncommon across software.

Regardless of the detail of the spec I am absolutely certain that the
default options used for tools in debian and fedora will mean all
executables turn out as relaxed (or legacy) i.e. all compatible with both
HW nan encodings. It would actually be safer if the binaries came out
as legacy like today then relaxed because at least then we would still
know they have a consistent nan encoding and it is only the kernel that
is involved in deciding if they should be accepted on incompatible HW
or not. If we get relaxed by default then nobody can control whether they
are accepted on incompatible hardware.

> 2. An idea has been proposed to have objects marked by the assembler to
>    indicate whether they include an FP hardware instruction or not.  The
>    latters would automatically become don't-cares as far as NaN encoding
>    is concerned and if all the objects were such in a given static link,
>    then the resulting executable would become NaN-encoding agnostic,
>    ignoring any `strict' or `relaxed' modes.  This would exclude a large
>    amount of software from the checks discussed in this specification,
>    although a question still remains open how shared libraries loaded by
>    such a program would be treated if they for a change did include FP
>    hardware instructions.

Definitely need to work on attributing modules that truly don't care about
floating point but this issue does not reduce/increase my concerns about
the spec for the ieee compliance features.

> Does either of the proposals address your concerns?  Is there anything I
> may have missed here?

Sorry for all the proposed changes but I think we have got more complexity
than necessary so need to work through these issues more.

Thanks,
Matthew
