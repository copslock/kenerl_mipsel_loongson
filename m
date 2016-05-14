Received: with ECARTIS (v1.0.0; list linux-mips); Sat, 14 May 2016 19:11:06 +0200 (CEST)
Received: from mailapp01.imgtec.com ([195.59.15.196]:32520 "EHLO
        mailapp01.imgtec.com" rhost-flags-OK-OK-OK-OK) by eddie.linux-mips.org
        with ESMTP id S27027548AbcENRLDu8TaS (ORCPT
        <rfc822;linux-mips@linux-mips.org>); Sat, 14 May 2016 19:11:03 +0200
Received: from hhmail02.hh.imgtec.org (unknown [10.100.10.20])
        by Websense Email with ESMTPS id 3D1E835CE9963;
        Sat, 14 May 2016 18:10:52 +0100 (IST)
Received: from [10.20.78.186] (10.20.78.186) by hhmail02.hh.imgtec.org
 (10.100.10.21) with Microsoft SMTP Server id 14.3.266.1; Sat, 14 May 2016
 18:10:55 +0100
Date:   Sat, 14 May 2016 18:10:44 +0100
From:   "Maciej W. Rozycki" <macro@imgtec.com>
To:     <linux-mips@linux-mips.org>, <libc-alpha@sourceware.org>,
        <binutils@sourceware.org>, <gcc@gcc.gnu.org>
CC:     Joseph Myers <joseph@codesourcery.com>,
        Matthew Fortune <Matthew.Fortune@imgtec.com>
Subject: [RFC v2] MIPS ABI Extension for IEEE Std 754 Non-Compliant
 Interlinking
Message-ID: <alpine.DEB.2.00.1605141043120.6794@tp.orcam.me.uk>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
X-Originating-IP: [10.20.78.186]
Return-Path: <Maciej.Rozycki@imgtec.com>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 53448
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

Dear fellow developers,

 Here is the second revision of the ABI extension specification previously 
posted, incorporating feedback received for the first revision.  Changes 
have been made to Section 4 "Implementation Notes", the remaining parts
have stayed the same.  The master copy of this document is available at:

<https://dmz-portal.mips.com/wiki/MIPS_ABI_-_NaN_Interlinking>

 Please let me know if you have any questions, comments or concerns about 
this updated version.  Otherwise I will wait a short while and then follow 
up with an updated implementation.

 Thanks to all of you who took time to read the first revision and comment 
on it, and especially Joseph Myers.

  Maciej

-------------------------------------------------------------------------- 
MIPS ABI Extension for IEEE Std 754 Non-Compliant Interlinking

1. Introduction

 The MIPS architecture has supported IEEE Std 754 floating-point
arithmetic since its beginning in 1985.  Naturally as initial support was
for the original 1985 revision of the standard then particular choices
were made for the architecture where freedom was given by that revision.
This was the case with not-a-number (NaN) symbolic data and the bit
patterns chosen to represent them.  Later on this choice turned out to be
different from ones used by all other IEEE Std 754 implementers.  Hardware
implementing this original MIPS architecture definition and corresponding
software and ABIs will be referred across this document as legacy-NaN
hardware, software and ABIs respectively, and the NaN patterns themselves
as legacy NaN patterns.

 The patterns originally chosen had their advantage in the MIPS
architecture, however an updated revision of IEEE Std 754 released in 2008
made the NaN patterns chosen by other implementers preferred.  MIPS
architecture overseers decided to follow the recommendation and update the
architecture definition accordingly.  Consequently a set of amended ABIs
has been created to provide for software execution on hardware
implementing the updated architecture.  Such hardware, software and ABIs
will be referred across this document to as 2008-NaN hardware, software
and ABIs respectively, and the NaN patterns themselves as to 2008 NaN
patterns.

 The legacy and 2008 NaN patterns are not compatible with each other and
therefore the respective ABIs and software binaries are not.  To keep all
software compliant to IEEE Std 754 a decision was made to disallow mixing
legacy-NaN and 2008-NaN software modules in static linking and dynamic
loading, and at the OS level disallow execution of 2008-NaN software on
legacy-NaN hardware and vice versa.

2. Statement of the Problem

 The decisions made so far about the MIPS architecture and ABIs have led
to a situation where the large existing base of software binaries cannot
execute on current hardware.  And this applies regardless of whether it
relies on the use of NaN data or IEEE Std 754 arithmetic in the first
place.  Rebuilding all of the existing software for 2008-NaN hardware is
infeasible and additionally such software, rebuilt or new, will not run on
legacy-NaN hardware that is widely deployed, so maintaining two binary
versions of the same piece of software would often be required.

3. Solution

 The solution described here has been prepared with the Linux environment
in mind, although where applicable individual changes are also appropriate
for bare-metal environments.

 A number of changes are made at different levels to make the transition
to 2008-NaN hardware easier as well as long-term support for legacy-NaN
hardware that is undoubtedly going to stay around for a while.  They are
detailed from the hardware level up in the following sections.

3.1 Hardware and Operating System Interface

 The operating system tells legacy-NaN and 2008-NaN software apart by
examining the state of the EF_MIPS_NAN2008 flag in the ELF file header of
individual binaries requested for execution with the execve(2) system
call.  The value of `0' of the flag denotes legacy-NaN software and the
value of `1' denotes 2008-NaN software.

3.1.1 Floating-Point Emulation

 Where possible both legacy-NaN and 2008-NaN software will be supported.
The MIPS architecture itself makes it possible and therefore the FPU
emulator used on hardware that does not implement an FPU will set itself
to the right mode individually for every legacy-NaN or 2008-NaN program
executed.

 On Linux the FPU emulator can also be enabled unconditionally even on
hardware that does implement an FPU, with the use of the `nofpu' kernel
option.  In this case both legacy-NaN and 2008-NaN software will be
automatically supported, although at a performance loss compared to FPU
hardware.

3.1.2 Global IEEE Std 754 Compliance Mode

 A new `ieee754=' kernel option is provided for cases where strict IEEE
Std 754 compliance is not required.  This makes it possible to use
binaries from existing Linux distributions on new 2008-NaN hardware making
the transition easier.  At least two values are accepted on the right hand
side of this option, `strict' and `relaxed', to select between IEEE Std
754 compliance modes.  These modes shall only affect software that does
not make an explicit mode selection as noted in Section 3.1.3 below.

 In the `strict' mode, which is the default in the absence of an explicit
`ieee754=' option, only software compatible with the NaN patterns handled
by FPU hardware shall be accepted for execution, that is legacy-NaN
software on legacy-NaN hardware and 2008-NaN software on 2008-NaN
hardware.

 In the `relaxed' mode any software shall be accepted for execution,
regardless of whether it is compatible with FPU hardware.  Additionally,
in the `relaxed' mode, even if enabled with the FCSR.Enables.V bit, any
IEEE Std 754 Invalid Operation exceptions triggered with an sNaN
instruction operand shall not result in a SIGFPE signal being issued to
the originating process and a qNaN (encoded according to the current mode
set in the floating-point environment) shall be substituted and propagated
through the arithmetic operation requested as with a qNaN operand.

 Additionally, to make the dynamic loader aware that the `relaxed' IEEE
Std 754 compliance mode is in effect, bit #25 shall be set in the `a_val'
member of the AT_FLAGS entry of the auxiliary vector created by the
kernel on program execution for any program accepted for this mode.  This
bit is in the part of the flag word reserved for system semantic by the
MIPS psABI[1].  This bit shall be set to `0' in the `strict' mode and `1'
in the `relaxed' mode.

 Additional values may be accepted with the kernel option and consequently
modes provided now or in the future, but they are beyond the scope of this
document.

3.1.3 Per Program Individual IEEE Std 754 Compliance Mode

 Individual programs can select their required IEEE Std 754 compliance
mode regardless of the global mode.  Individual selection takes precedence
over the global selection.  Programs that select their individual mode
shall have a PT_MIPS_ABIFLAGS segment and shall have bit #1 set in its
`flags1' member.  The specific mode selected is then determined by the
value of bit #1 in this segment's `flags2' member, `0' for the `strict'
mode and `1' for the `relaxed' mode.

 The semantics of such individually selected IEEE Std 754 compliance
mode is the same as that of the corresponding global mode.  See Section
3.1.2 above for further details.

3.1.4 Dynamic IEEE Std 754 Compliance Mode Control

 A new request is provided via the prctl(2) system call to let a process
switch its own IEEE Std 754 compliance mode.  This is for example to let
a dynamic loader invoked manually set the compliance mode for an
executable requested as if the executable was run directly and its
compliance mode preset by the kernel.  The request shall be made as
follows:

  int result;
  result = prctl(PR_SET_IEEE754_MODE, mode, what);

 In this request `mode' shall be set to one of the following:

* PR_IEEE754_MODE_LEGACY -- to set the compliance mode used with programs
  which do not make an individual IEEE Std 754 compliance mode selection,

* PR_IEEE754_MODE_STRICT -- to set the `strict' compliance mode,

* PR_IEEE754_MODE_RELAXED -- to set the `relaxed' compliance mode,

and `what' shall be set to either of:

* PR_IEEE754_MODE_NAN_LEGACY -- to select the legacy-NaN encoding mode,

* PR_IEEE754_MODE_NAN_2008 -- to select the 2008-NaN encoding mode.

The kernel shall execute the request according to the rules set out in
Subsection 3.1.2 and Subsection 3.1.3 for the ELF file flag settings
corresponding to the respective IEEE Std 754 compliance and NaN encoding
modes requested.

 If the request is successful a non-negative value shall be assigned to
`result', in which bits 7:0 are set to a pattern that would be placed in
bits 31:24, in the same bit order, of the `a_val' member of the AT_FLAGS
entry of the auxiliary vector created by the kernel on program execution
for the mode selected.

3.2 Dynamic Loading

 The dynamic loader shall recognise IEEE Std 754 compliance modes and
resolve main executable's dependencies according to rules set below.  For
the purpose of these rules a main executable is the binary named in an
execve(2) call to the operating system, and a dependency is any dynamic
shared object additionally loaded, via any means including but not
necessarily limited to a DT_NEEDED dynamic segment entry, an LD_PRELOAD
environment variable or a dlopen(3) library call.

3.2.1 IEEE Std 754 Compliance Mode Selection

 Both executables and dynamic shared objects can select their required
IEEE Std 754 compliance mode.  A binary requiring a specific compliance
mode shall have a PT_MIPS_ABIFLAGS segment and shall have its contents
set according to rules set out in Section 3.1.3.  Such a binary will
be referred to as `strict' or `relaxed'.  Binaries that have no
PT_MIPS_ABIFLAGS segment or have one that does not request a specific
compliance mode will be referred to as `legacy'.

3.2.2 Dynamic Dependency Acceptance Rules

 The IEEE Std 754 compliance mode requested is determined by the main
executable.  Any dynamic shared objects loaded in addition shall respect
the mode according to the rules set below.

 For `strict' executables all the dynamic shared objects shall follow the
same legacy-NaN or 2008-NaN ABI, as denoted by the EF_MIPS_NAN2008 flag
described in Section 3.1.  The value of the flag shall be the same across
the executable and all the dynamic shared objects loaded together.  Both
`strict' and `legacy' dynamic shared objects shall be accepted, however
`relaxed' ones shall be rejected regardless of the value of their
EF_MIPS_NAN2008 flag.

 For `relaxed' executables any dynamic shared objects shall be accepted,
`strict', `relaxed' and `legacy' alike, regardless of the value of their
EF_MIPS_NAN2008 flag.

 For `legacy' executables the compliance mode is determined by the value
of bit #25 in the `a_val' member of the AT_FLAGS entry of the auxiliary
vector received from the kernel.  The value of `0' shall make the dynamic
loader follow the rules for `strict' executables.  The value of `1' shall
make the dynamic loader follow the rules for `relaxed' executables.

3.2.3 Dynamic Loading Compatibility Considerations

 The encoding for the PT_MIPS_ABIFLAGS segment has been selected such that
old versions of the dynamic loader will reject `relaxed' binaries because
of an unknown `flags2' bit set.  This is to prevent execution in an
environment that does not follow the rules set out in this specification
and to signify the need to upgrade.  Both `strict' and `legacy' binaries
will run correctly as they follow the rules defined for old versions of
the dynamic loader.

 Older versions of the dynamic loader will not process a PT_MIPS_ABIFLAGS
segment and will only examine the EF_MIPS_NAN2008 flag.  Very old versions
of the dynamic loader will not even process the flag.  It is therefore not
possible to guarantee that the rules set out here will be followed or an
error triggered with older systems.

3.3 Static Linking

 The static linker shall recognise IEEE Std 754 compliance modes and
enforce the rules set below for all static links, both final ones that
produce an executable or a dynamic shared object and incremental ones
that produce a relocatable object.

3.3.1 IEEE Std 754 Compliance Mode Selection

 All relocatable objects can select their required IEEE Std 754 compliance
mode.  An object requiring a specific compliance mode shall have an
SHT_MIPS_ABIFLAGS section called `.MIPS.abiflags' and shall have its
contents set according to rules set out for the PT_MIPS_ABIFLAGS segment
in Section 3.1.3.  Such an object will be referred to as `strict' or
`relaxed'.  Objects that have no SHT_MIPS_ABIFLAGS section or have one
that does not request a specific compliance mode will be referred to as
`legacy'.  On making an executable or a dynamic shared object the linker  
shall map an SHT_MIPS_ABIFLAGS section to a PT_MIPS_ABIFLAGS segment.

3.3.2 Static Linking Object Acceptance Rules

 The static linker shall follow the user selection as to the linking mode
used, either of `strict' and `relaxed'.  The selection will be made
according to the usual way assumed for the environment used, which may be
a command-line option, a property setting, etc.

 In the `strict' linking mode both `strict' and `legacy' objects can be
linked together.  All shall follow the same legacy-NaN or 2008-NaN ABI, as
denoted by the EF_MIPS_NAN2008 flag described in Section 3.1.  The value
of the flag shall be the same across all the objects linked together.  The
output of a link involving any `strict' objects shall be marked as
`strict'.  No `relaxed' objects shall be allowed in the same link.

 In the `relaxed' linking mode any `strict', `relaxed' and `legacy'
objects can be linked together, regardless of the value of their
EF_MIPS_NAN2008 flag.  If the flag has the same value across all objects
linked, then the value shall be propagated to the binary produced.  The
output shall be marked as `relaxed'.  It is recommended that the linker
provides a way to warn the user whenever a `relaxed' link is made of
`strict' and `legacy' objects only.

3.3.3 Static Linking Compliance Mode Warnings

A flag shall be defined in bit #0 of the `flags2' member of the
PT_MIPS_ABIFLAGS section, determining the warning mode for IEEE Std 754
compliance in static linking.  This bit shall be set to `0' to enable
the warning mode (`warn' mode) and `1' to disable it (`nowarn' mode).  The
bit shall propagate through an incremental static link in an
implementation-defined manner, however it shall be set to `0' in a final
static link.

3.3.4 Static Linking Compatibility Considerations

 The encoding for the SHT_MIPS_ABIFLAGS section has been selected such
that old versions of the static linker will reject `relaxed' binaries
because of an unknown `flags2' bit set.  This is to prevent incorrectly
annotated objects from being produced that would not guarantee IEEE Std
754 compliance.

 The encoding has also been selected such that old versions of the static
linker will merge the `flags1' bit used to tell `legacy' objects and
`strict'/`relaxed' ones apart, automatically marking the output of links
involving any `strict' objects as `strict' as well.

 Older versions of the static linker will not process an SHT_MIPS_ABIFLAGS
section and will only examine the EF_MIPS_NAN2008 flag.  Consequently they
may allow `relaxed' objects in a single link with `strict' and `legacy'
ones.

3.4 Relocatable Object Generation

 Tools that produce relocatable objects such as the assembler shall always
produce a SHT_MIPS_ABIFLAGS section according to the IEEE Std 754
compliance mode selected.  In the absence of any explicit user
instructions the `strict' mode shall be assumed.  No new `legacy' objects
shall be produced.

3.5 No-float Modules

 Certain modules used in dynamic loading or static linking may be marked
as containing no floating-point code, in a way defined by a separate
specification.  Such modules shall always be accepted for dynamic loading
and static linking, and for the purpose of IEEE Std 754 compliance checks
treated as if absent.

3.6 Definitions

 The following macros shall be defined for the flags introduced by this
document:

/* `flags1' member of the PT_MIPS_ABIFLAGS/SHT_MIPS_ABIFLAGS structure.  */
#define MIPS_AFL_FLAGS1_IEEE    2       /* IEEE Std 754 mode defined.  */

/* `flags2' members of the PT_MIPS_ABIFLAGS/SHT_MIPS_ABIFLAGS structure.  */
#define MIPS_AFL_FLAGS2_NOWARN  1       /* Suppress IEEE Std 754 warnings.  */
#define MIPS_AFL_FLAGS2_RELAXED 2       /* Relaxed IEEE Std 754 mode.  */

/* `a_val' member of the AT_FLAGS entry.  */
#define AV_FLAGS_MIPS_RELAXED   (1 << 25) /* Relaxed IEEE Std 754 mode.  */

It is unspecified at this time whether the bits referred to with
MIPS_AFL_FLAGS2_RELAXED and AV_FLAGS_MIPS_RELAXED are single-bit bitfields
or the least significant bits of a larger enumeration, to be defined
later.

 The following macros shall be defined for the prctl(2) interface
introduced by this document:

/* Control MIPS IEEE 754 compliance modes.  */
#define PR_SET_IEEE754_MODE             TBA

#define PR_IEEE754_MODE_LEGACY          0       /* Legacy mode.  */
#define PR_IEEE754_MODE_STRICT          1       /* Strict mode.  */
#define PR_IEEE754_MODE_RELAXED         2       /* Relaxed mode.  */

#define PR_IEEE754_MODE_NAN_LEGACY      0       /* Set legacy NaN encoding.  */
#define PR_IEEE754_MODE_NAN_2008        1       /* Set 2008 NaN encoding.  */

4. Implementation Notes

 For the GNU linker the command-line options to select between the
`strict' and the `relaxed' IEEE Std 754 compliance modes will be
`--ieee=strict' and `--ieee=relaxed', respectively.  The latter will issue
a compliance warning in the case where all input objects were either
`strict' and `warn' or `legacy' mode, unless a `--ieee=nowarn' option has
also been used.  There will be a `--ieee=warn' option as well to revert
the effect of the former option.

 For the GNU assembler the directives to select between the `strict' and
the `relaxed' IEEE Std 754 compliance modes will be `.ieee strict' and
`.ieee relaxed', respectively.  Equivalent command-line options will be
present, `-mieee=strict' and `-mieee=relaxed', respectively.  There will
be `.ieee nowarn' and `.ieee warn' directives as well to set and clear
the IEEE Std 754 warning flag respectively in the SHT_MIPS_ABIFLAGS
section.  Their corresponding command-line options will be `-mieee=nowarn'
and `-mieee=warn' respectively.

 For the GNU Compiler Collection (GCC) the following target-specific
command-line options will be accepted:

* `-mieee=strict', making the toolchain produce `strict' binaries,

* `-mieee=relaxed-exec', making the toolchain produce `strict' shared
  libraries and `relaxed' executables,

* `-mieee=relaxed', making the toolchain produce `relaxed' binaries,

* `-mieee=force-relaxed', making the toolchain produce `relaxed' binaries,
  while suppressing IEEE Std 754 static linking warnings.

Any or all of these options may have target-specific effects beyond
propagating the IEEE Std 754 compliance mode down to the assembler and the
linker.

 It is expected that `-mieee=strict' and `-mieee=relaxed-exec' options
will be set by appropriate generic `-fieee' options, to be defined, which
will be also available for selection as configuration defaults at the GCC
build time.  It is also expected that along `-mieee=strict' the relevant
`-fieee' option and its corresponding configuration default will set the
compiler into a mode in which it will produce strictly compliant code,
which in the context of this specification is defined as: following IEEE
Std 754 as closely as the programming language binding to the standard
(defined in the relevant language standard), the compiler implementation
and target hardware permit.  This means that the use of `-fieee' options
may affect code produced in ways beyond NaN representation only.

 There may be further GCC options to control IEEE Std 754 compliance, to
be defined.

5. Future Considerations

 While at the time of this writing the `strict' and `relaxed' IEEE Std 754
compliance modes only apply to NaN representation patterns, it is possible
that in the future other IEEE Std 754 compliance matters may require
communicating through linking and loading down to the operating system
kernel.  Therefore a decision has been made to use generic names for the
modes, macros, directives and option names defined here.  If such a need
arises in the future, then the meaning of these names may be extended to
cover other compliance aspects and further modes can be added that are
intermediate between `strict' and `relaxed', to be used with the `.ieee'
directive and the `-mieee=' command-line options.

References:

[1] "SYSTEM V APPLICATION BINARY INTERFACE, MIPS RISC Processor
    Supplement, 3rd Edition", Section "Process Stack", pp. 3-33, 3-34
