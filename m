Received: with ECARTIS (v1.0.0; list linux-mips); Tue, 01 Jul 2008 21:22:56 +0100 (BST)
Received: from NaN.false.org ([208.75.86.248]:48332 "EHLO nan.false.org")
	by ftp.linux-mips.org with ESMTP id S32713250AbYGAUWr (ORCPT
	<rfc822;linux-mips@linux-mips.org>); Tue, 1 Jul 2008 21:22:47 +0100
Received: from nan.false.org (localhost [127.0.0.1])
	by nan.false.org (Postfix) with ESMTP id 1F02198243;
	Tue,  1 Jul 2008 20:22:43 +0000 (GMT)
Received: from caradoc.them.org (22.svnf5.xdsl.nauticom.net [209.195.183.55])
	by nan.false.org (Postfix) with ESMTP id 0D6CF9809F;
	Tue,  1 Jul 2008 20:22:41 +0000 (GMT)
Received: from drow by caradoc.them.org with local (Exim 4.69)
	(envelope-from <drow@caradoc.them.org>)
	id 1KDmN5-0006pV-UM; Tue, 01 Jul 2008 16:22:40 -0400
Date:	Tue, 1 Jul 2008 16:22:37 -0400
From:	Daniel Jacobowitz <dan@debian.org>
To:	binutils@sourceware.org, gcc@gcc.gnu.org,
	linux-mips@linux-mips.org, rdsandiford@googlemail.com
Subject: Re: RFC: Adding non-PIC executable support to MIPS
Message-ID: <20080701202236.GA1534@caradoc.them.org>
Mail-Followup-To: binutils@sourceware.org, gcc@gcc.gnu.org,
	linux-mips@linux-mips.org, rdsandiford@googlemail.com
References: <87y74pxwyl.fsf@firetop.home>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="vtzGhvizbBRQ85DL"
Content-Disposition: inline
In-Reply-To: <87y74pxwyl.fsf@firetop.home>
User-Agent: Mutt/1.5.17 (2008-05-11)
Return-Path: <drow@false.org>
X-Envelope-To: <"|/home/ecartis/ecartis -s linux-mips"> (uid 0)
X-Orcpt: rfc822;linux-mips@linux-mips.org
Original-Recipient: rfc822;linux-mips@linux-mips.org
X-archive-position: 19683
X-ecartis-version: Ecartis v1.0.0
Sender: linux-mips-bounce@linux-mips.org
Errors-to: linux-mips-bounce@linux-mips.org
X-original-sender: dan@debian.org
Precedence: bulk
X-list: linux-mips


--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Jun 28, 2008 at 06:58:58PM +0100, Richard Sandiford wrote:
> used on GNU/Linux.  At the same time, CodeSourcery implemented it for
> Sourcery G++.  I only found out about CS's version recently, after
> finishing the Specifix one, and I think the same is true in reverse.
> Oh well!

Yes, that's right - first I heard about this was last week :-(

> I suppose the good news is that we can pick the best bits of each
> implementation as the official one.  I'll describe my implementation
> below, then compare it to what I understand CS's version to be.
> CS folks: please correct me if I'm wrong.  Dan said that he'd be
> submitting CS's version too.

Indeed, and here it is.  I have attached patches for gcc, binutils,
gdb, glibc (EGLIBC trunk but likely to apply fine to FSF GLIBC also),
and glibc-ports (ditto).  There's also a build fix for EGLIBC after
Richard's recent change to the "h" constraint (similar to the one in
Richard's eglibc quilt).  I have also included the ABI writeup we
used.  Changelogs are missing for the binutils/gcc patches.

The patches were written by Mark Shinwell, Catherine Moore, and
myself.  The ABI document was originally written by Nigel Stephens of
MIPS Technologies, Inc., who sponsored this project; I've updated it
as we went along.  Richard, Nigel, and I discussed a version of this
document in 2007; it has changed slightly.  I've had to do some
last minute updates to it today to match the implementation,
so I sincerely hope I got them right.

Most descripions of Richard's implementation also apply to ours.
It is compatible with both existing ET_REL objects and existing
ET_EXEC/ET_DYN modules.  Old binaries continue to work with a
patched C library, existing static libraries can still be used by the
new linker, et cetera.

> Comparison with the CS implementation
> -------------------------------------

Some similarities first: R_MIPS_COPY / R_MIPS_JUMP_SLOT, STO_MIPS_PLT,
EF_MIPS_CPIC, use of .option pic0, the need for linker errors on
non-PIC, the grotty glibc hack to make it check STO_MIPS_PLT
(Richard's duplicates more code, but is considerably less grotty; had
we realized we'd be stuck with a copy of dl-lookup.c I would likely
not have written the awful preprocessor trick you'll see in the
ports patch).

> I think the main differences with CS's implemention are:
> 
> - CS treat .got.plt is part of .got.  See above for why I think it
>   should be separate.  Note that the PLT header is the same size for
>   both implementations, so the extra parameters don't cost much.

No, we don't - they're on opposite sides of .data.  We reserve two
words at the start of the PLT GOT in addition to the two at the
beginning of the GOT.  The PLT header loads the start of .got.plt
and passes that to _dl_runtime_pltresolve in $gp.  The return
address is passed in $t9 and the index in $t8.

> - CS PLT entries pass a PLT index rather than a .got.plt address.
>   This makes no difference for most objects, but a longer stub
>   is needed if there are more than 0x10000 PLT entries.

Yes, this was chosen in order to support MIPS I while still fitting
the PLT entries on a single cache line.

> - I couldn't see any specific support for ld -r in the CS version.

That's right, we do not support this.  I've no complaint about gaining
support :-)  Given the requirement, STO_MIPS_PIC seems sensible.

> - The CS version always uses separate "la $25" trampolines,
>   rather than adding instructions to the beginning of a function.
>   This is an implementation rather than an ABI detail though.

Right.

> - CS support MIPS I, at the cost of using the start of the next
>   PLT entry as a delay slot instruction.

FWIW it also adds one instruction to the header; that's why the delay
slot of the branch is empty.

> - STO_MIPS_PLT is separate from STO_MIPS16.

Right.

> This comparison is based on 4.2-129 and I've probably got it wrong.
> 
> I'm not sure if CS's version supports n32 and n64, but adding
> it wouldn't be a big issue.

Right - it's not there, but we figured we'd add it at some
not-too-future date.

Also:

  - We reserve two words at the start of the PLT GOT rather than
  pass another argument to the resolver.  One of them points to
  the PLT resolver, and the other to the link map (from which
  the dynamic linker can look up whatever it needs).

  - One of the new dynamic tags, DT_MIPS_PLTGOT, exists solely to
  let the dynamic linker fill in those two reserved entries.  So
  this tag is required.

  - The other dynamic tag, DT_MIPS_RWPLT, is for a specified but
  unimplmented optimization a la PowerPC-32 - rewriting resolved
  PLT entries to a direct jump.

OK, that's the ABI comparison.  These are what I'm concerned about for
integrating the two versions; all implementation differences I know we
can decide case-by-case.  And because both Richard's and our versions
apply this behavior by default based on a configure option, I'm not
concerned with the command line options or spelling of configure
options either.

We've shipped our version.  Richard's version has presumably also
shipped.  We did negotiate the ABI changes with MTI; this is not quite
as good as doing it in full view, but it was the best we could manage
and MTI is as close to a central authority for the MIPS psABI as
exists today.

Richard, what are your thoughts on reconciling the differences?  You
can surely guess that I want to avoid changing our ABI now, even for
relatively significant technical reasons - I'm all ears if there's a
major reason, but in the comparisons I do not see one.

If necessary, one of us can end up with a compatibility layer at
runtime thanks to DT_MIPS_RWPLT :-(

Comments welcome from all.

-- 
Daniel Jacobowitz
CodeSourcery

--vtzGhvizbBRQ85DL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="nonpic.txt"

====
MIPS non-PIC ABI specification
====

Introduction
----

This document describes the specification of the new MIPS ABI to provide
absolute (non-PIC) addressing as used for Linux applications on most
architectures.  MIPS currently uses the existing psABI that mandates
compilation of applications as position-independent code.

The intention is that this extension to the ABI will be a strict
superset of the existing MIPS o32 psABI for non-PIC executables, and will
not break compatibility with legacy PIC object files, allowing
interlinking of new-model and legacy object files both statically and
dynamically (apart from ld.so, of course).

This document does not cover n32 and n64 ABIs; they are expected to be
a straightforward extension of the same design.

At this time we do not propose any change to the position-independent
addressing conventions used by shared objects. Similarly,
position-independent executables compiled with '-fpie' -- as required
for address space randomisation in "hardened" Linux distributions --
shall continue to use the existing psABI addressing and calling
mechanisms.

Identification of Object Files
----

Object files which use this new ABI extension will need to be
identifiable. They will have EF_MIPS_CPIC set and EF_MIPS_PIC
clear in the ELF header's e_flags field. The dynamic linker can
identify new-model executables which use the PLT mechanism by the
existence of DT_JMPREL tag in the dynamic table. It is also suggested
that the EI_ABIVERSION entry in the ELF header ident be incremented
from 0 to 1 for such executables, so that existing dynamic linkers
will refuse to link them, and display a "helpful" error message rather
than linking them incorrectly and having the application crash.

[Ed. note: this does not actually work with glibc's ld.so for
executables; it does not check the ABI version of the executable, or
checks it too late.]

Procedure Linkage Table
----

The Procedure Linkage Table (PLT) consists of a set of stubs generated
by the static linker to stand in for external functions that are in a
shared object. They can be called using an absolute JAL instuction and
then redirect the call from the executable to the actual function via
a pointer in the PLT GOT (the .got.plt section which holds 32-bit
function pointers only).

The PLT is output to the .plt section, which section should be aligned
to a 32 byte boundary so that all PLT entries occupy no more than one
cache line.

The PLT GOT holds function addresses used by the PLT stubs, and the
PLT GOT entries shall be initialised by the static linker to point to
the PLT header (i.e. the base of the .plt section).  In this way the
first call to an external function will invoke the dynamic linker to
resolve the symbol and update the corresponding PLT GOT entry; the
next call will then jump from the PLT straight to the function,
avoiding the dynamic linker.

In the existing version of the ABI, as implemented by glibc,
the first two GOT entries are reserved:

  GOT[0]
	Pointer to dynamic linker's GOT resolver which takes a dynamic
	symbol index argument.

  GOT[1]
	Pointer to this object's link map

In this ABI, the GOT layout will remain the same.  The first two entries
in the PLT GOT will be reserved as follows:

  PLTGOT[0]
	Pointer to dynamic linker's PLT resolver (which takes a PLT
	index argument instead of the dynamic symbol index used by the
	GOT resolver).

  PLTGOT[1]
	Pointer to this object's link map.

Since PLT entries use absolute addresses to access the PLT GOT, the
PLT GOT does not need to be located within 32K of the _gp symbol.
Indeed it would be better to prevent the PLT GOT from occupying this
scarce resource in the address map.  There is no requirement for the
PLT GOT and GOT to be consecutive.

For each PLT entry a R_MIPS_JUMP_SLOT relocation entry shall be output
to the dynamic .rel.plt section: the relocation entry's dynamic symbol
index specifies the symbol to which the PLT entry refers, and the
offset field holds the address of the PLT entry. An addend is never
required (so we remain with REL relocs).  The PLT index passed
by the PLT to the dynamic linker is both an index into the array of
jump slot relocations, and can be transformed into
an index into the PLT GOT by adding two (corresponding to the
reserved PLT resolver and link map slots at PLTGOT[0] and
PLTGOT[1]).  Dynamic
symbol table entries referenced only by jump slot or copy relocations
shall precede the "GOT mapped" symbols whose first index is specified
by the DT_MIPS_GOTSYM dynamic table entry.

PLT Header
----

The first entry in the PLT handles the first call to a PLT only, and
is 32 bytes in size::

  PLT0:	lui	gp, %hi(.got.plt)		# linker needs address of 
  	addiu	gp, %lo(.got.plt)		#  .got.plt to find link map
  	lw	t9, 0(gp)			# PLTGOT[0] == &_dl_runtime_pltresolve()
  	move	t7,ra				# linker needs caller's address
  	jalr	t9				# call _dl_runtime_pltresolve()
  	nop					# bdslot
   	nop					# spare
  	nop					# spare

PLT Type A
''''

If the maximum PLT index is less than or equal to 65535, then a
minimum length PLT of 16 bytes can be generated::

  PLT1:	lui	t7, %hi(%pltgot(name1))	# high PLT GOT pointer
  	lw	t9, %lo(%pltgot(name1))(t7)	# load func pointer from PLT GOT
  	ori	t8, $0, index1			# load plt index (ldslot)
  	jr	t9				# jump to func
  PLT2:	lui	t7, %hi(%pltgot(name2)		# (bdslot)
  	lw	t9, %lo(%pltgot(name2))(t7)
  	ori	t8, $0, index2
  	jr	t9
  PLT3:	...
  PLTn:	nop; nop; nop; nop

(Note that this is effectively pseudocode; the assembler does not need
modifying to understand "%pltgot(...)" since these instructions will
be directly written out by the linker.)

PLT Type B
''''

When the maximum PLT index is greater than 65535, a large PLT is
required, rounded up to 32 bytes in length::

  PLT1:	lui	t7, %hi(%pltgot(name1))		# high PLT GOT pointer
  	lw	t9, %lo(%pltgot(name1))(t7)	# load func pointer from PLT GOT
  	lui	t8, index1>>16			# load hi plt index (ldslot)
  	jr	t9				# jump to func
  	ori	 t8, t8, index1&0xffff		# load lo plt index (bdslot)
  	nop
  	nop
  	nop

Writable PLT Fixup
----

PLT Type C
''''

After resolving the symbol and updating the PLT GOT, then if the PLT
is in a writable section, the dynamic linker shall patch the PLT to use
the absolute address of the function, thereby avoiding the PLT GOT
reference, as follows. The dynamic linker can detect a writable PLT by
the existence of a non-null DT_MIPS_RWPLT entry in the dynamic table::

  PLT1:	lui	t9, %hi(name1)
  	addiu	t9, %lo(name1)
  	jr	t9
  	nop

PLT Type D
''''

Furthermore if the address at which the function is loaded lies within
the same 256MB segment as the PLT entry, then it can avoid the
indirect jump also::

  PLT1:	lui	t9, %hi(name1)
  	j	name1
  	addiu	t9, %lo(name1)
  	nop

Note that the base MIPS32 and MIPS64 MMU does not provide a
"no-execute" bit, and therefore cannot support the "least privilege"
page protection model required by "Hardened" Linux features such as
Exec Shield and PAX. [Actually the SmartMIPS ASE specifies the
execute-inhibit (XI) bit, but that's only available in the 4KSd core.]
However the static linker should be capable of generating a
non-writable (secure) PLT and GOT to conform with SELinux
restrictions, and on a SmartMIPS core this could be used to prevent
writable data areas from becoming executable. This would be at the
cost of some loss of performance for external function calls.

Function addresses
----

To allow comparison of function addresses to work as expected, it is
necessary for the executable and all shared objects to see the same
function address. If the executable takes the address of an external
function it will generate a PLT entry for that function, and that PLT
entry must then be the canonical address for the function throughout
the program.

Taking the address of an external function in a non-PIC executable
will result in a symbol table entry with type STT_FUNC and section
index of SHN_UNDEF, but with a non-zero st_value field that holds the
address of the function's PLT entry; furthermore the new STO_MIPS_PLT
bit shall be set in the symbol's st_other field. If the function's
address is not referenced (i.e. the function is only ever called by
the executable), then the symbol's st_value field will be zero and the
STO_MIPS_PLT bit clear.

The dynamic linker will use an undefined function symbol table entry
with STO_MIPS_PLT set to resolve all references to that symbol in
preference to the actual definition of that symbol, except when
resolving an R_MIPS_JUMP_SLOT relocation.

Note that this is the opposite behaviour to the legacy MIPS psABI
where an undefined function symbol table entry with a zero st_value
field indicates that there is an address reference to the function and
the dynamic linker must resolve the symbol immediately upon loading;
and where undefined function entries are always ignored when searching
for a symbol definition.

Dynamic Section
----

Dynamic section entries give information to the dynamic linker. Some
of the information is processor-specific, including the interpretation
of some entries in the dynamic structure. The following new or changed
dynamic table entries are required by the extended ABI:

  DT_JMPREL (23)
	Previously unused for MIPS, now points to the first jump-slot
	relocation in the dynamic relocation table (i.e. the base of
	.rel.plt).

  DT_PLTREL (20)
	Previously unused for MIPS, now with a value of DT_REL indicating
	that DT_JMPREL points to REL relocations.

  DT_PLTRELSZ (2)
	Previously unused for MIPS, now holding the size of .rel.plt in
	bytes.

  DT_MIPS_PLTGOT (0x70000032)
	(New) Points to the base of the PLT GOT (.got.plt section),
	since it may not be contiguous with the traditional GOT (.got
	section). The standard DT_PLTGOT entry points to the base of
	the GOT.

  DT_MIPS_RWPLT (0x70000034)
	(New) Points to the base of the PLT when the PLT is writable;
	for a non-writable PLT it is omitted or has a zero value.

The dynamic symbol table may have undefined function entries with the
following bit set in the st_other field:

  STO_MIPS_PLT (0x8)
	 (New) Symbol value is the address of a PLT entry.

The dynamic relocation table may now contain two new relocation types
generated by the static linker:

  R_MIPS_COPY (126)
	 A data copy relocation.

  R_MIPS_JUMP_SLOT (127)
	 A PLT relocation.

External Data
----

If a non-PIC executable contains a reference to a data symbol in a
shared object, then the static linker shall allocate space for that
symbol in the executable's writable .dynbss (or .dynsbss) section, and
output an R_MIPS_COPY relocation entry to the dynamic relocation
section.  The offset field of the relocation entry gives the address
of the data in the .dynbss section. During execution the dynamic
linker will copy any initial data associated with the shared object's
symbol to the location specified by the offset, and point all GOT
entries that refer to that symbol to the executable's copy.

Large Code Size
----

The 26-bit offset of a MIPS absolute JAL and J instruction would limit
the executable's code (including the PLT) to fit in a single 256MB
address segment. That's sufficient for most embedded applications, but
could be exceeded by some larger "server" applications. This may be
handled by explicitly compiling large applications with '-mlongcalls'.

A more elegant solution would be for the linker to automatically
insert trampolines when a call site and the function (or its PLT) are
not within the same 256MB segment, similar to the mechanism used for
the PPC32 architecture.  This may be implemented at a later date and
has no ABI implications.

Small Data
----

An optimisation available to statically-linked "bare iron"
applications is to place data with size no greater than some threshold
(default 8 bytes) in a small data section, where it can be referenced
using short offsets from the $gp register. In Dhrystone the lack of
small data addressing accounts for approximately one eighth of the 30%
performance differential between bare-iron and Linux.

Enabling small data addressing for non-PIC executables will enable
some but not all of this performance to be regained, particularly in
functions which reference many small global variables. Because shared
libraries use the $gp register to hold their GOT pointer, the register
will not be constant throughout the application, so the compiler must
reload the small data pointer whenever required by a function. Note
that "small" external data must be allocated in the executable's
.dynsbss section, instead of the .dynbss section.

Since this is a local optimisation the compiler may use an arbitrary
register to hold the small data pointer: it could be any call-clobbered
register, or a call-saved register if its use crosses a function
call. 

The compiler might choose not to use a small data pointer register if
it can determine that there is only one reference to small data in a
function, in which case it will be faster to use an absolute
address. 

For non-PIC executables the compiler may now consider $gp to be a
call-clobbered register that it is free to allocate for any purpose.

Legacy psABI support
----

While new-model code will use the PLT to reference external functions,
any legacy PIC code with which it is statically linked should continue
to use the linker-generated call stubs in the .MIPS.stubs section,
rather than referencing the new-model PLT. This is to avoid the
penalty of a double indirection when calling the function:
i.e. calling indirectly via the GOT to the PLT, and then the PLT
calling the actual function via the PLT GOT.

The exception to this is if the non-PIC code references the same
function, in which case the PIC code must generate a local GOT entry
which points to the associated PLT entry. [A possible optimisation, if
we are willing to have both a PLT GOT and GOT entry referencing the
same function, is to only point the GOT to the PLT only if there are
relocations other than R_MIPS_26, R_MIPS_CALL16 or R_MIPS_GOT16
referencing the function, and otherwise use a global GOT entry
pointing directly to the function.]

Similarly for access to external data, if the non-PIC code generates
an R_MIPS_COPY relocation for a symbol, then PIC code referencing the
same symbol must allocate a local GOT entry pointing to the
executable's copy of the data in .dynbss or .dynsbss. Otherwise a
global GOT entry shall be allocated to point to the symbol.

Finally, if the non-PIC executable references a function in the
statically-linked PIC code, then it will be necessary for the linker
to allocate a call stub which first loads the $t9 register with the
function's address, for use by non-PIC caller.  The call stub would
look like PLT style C or D above, and could be allocated in the PLT or
.MIPS.stubs section, or any other part of the text section. If the
function is globally binding, and is referenced by a non-PIC, non-call
relocation, then its symbol table entry must point to the call stub,
so that the stub is the canonical address of the function.

--vtzGhvizbBRQ85DL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="gcc-nonpic.diff"

Index: gcc/configure
===================================================================
--- gcc/configure	(revision 137143)
+++ gcc/configure	(working copy)
@@ -1048,6 +1048,7 @@ Optional Features:
                           arrange to use setjmp/longjmp exception handling
   --enable-secureplt      enable -msecure-plt by default for PowerPC
   --enable-cld            enable -mcld by default for 32bit x86
+  --enable-mips-nonpic    enable non-PIC ABI by default for MIPS GNU/Linux o32
   --disable-win32-registry
                           disable lookup of installation paths in the
                           Registry on Windows hosts
@@ -13779,6 +13780,12 @@ else
   enable_cld=no
 fi;
 
+# Check whether --enable-mips-nonpic or --disable-mips-nonpic was given.
+if test "${enable_mips_nonpic+set}" = set; then
+  enableval="$enable_mips_nonpic"
+
+fi;
+
 # Windows32 Registry support for specifying GCC installation paths.
 # Check whether --enable-win32-registry or --disable-win32-registry was given.
 if test "${enable_win32_registry+set}" = set; then
Index: gcc/testsuite/gcc.target/mips/lazy-binding-1.c
===================================================================
--- gcc/testsuite/gcc.target/mips/lazy-binding-1.c	(revision 137143)
+++ gcc/testsuite/gcc.target/mips/lazy-binding-1.c	(working copy)
@@ -1,5 +1,5 @@
 /* { dg-do compile { target nomips16 } } */
-/* { dg-mips-options "-mabicalls -mshared -mexplicit-relocs -O2 -fno-delayed-branch" } */
+/* { dg-mips-options "-mabicalls -mshared -fpic -mexplicit-relocs -O2 -fno-delayed-branch" } */
 
 void bar (void);
 
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-addr.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-addr.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-addr.c	(revision 0)
@@ -0,0 +1,9 @@
+extern void nonpic_nothing (void);
+extern int hit_nonpic_addr;
+void
+nonpic_addr ()
+{
+  nonpic_receive_fn_addr (&nonpic_nothing);
+  hit_nonpic_addr++;
+  return;
+}
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-call.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-call.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-call.c	(revision 0)
@@ -0,0 +1,10 @@
+extern void pic_nothing (void);
+extern void pic_addr (void);
+extern int hit_nonpic_call;
+void
+nonpic_call ()
+{
+ pic_nothing ();
+ pic_addr ();
+ hit_nonpic_call++;
+}
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/pic-receive-fn-addr.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/pic-receive-fn-addr.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/pic-receive-fn-addr.c	(revision 0)
@@ -0,0 +1,9 @@
+extern void pic_nothing (void);
+extern void abort (void);
+void
+pic_receive_fn_addr (void *x)
+{
+  if (x != &pic_nothing)
+    abort ();
+  return;
+}
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-10.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-10.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-10.c	(revision 0)
@@ -0,0 +1,25 @@
+/* { dg-options "nonpic-call.o pic-addr.o pic-receive-fn-addr.o nonpic-nothing.o pic-nothing.o" } */
+
+extern void nonpic_call ();
+extern void pic_addr();
+int hit_nonpic_call = 0;
+int hit_pic_addr = 0;
+int hit_pic_nothing = 0;
+int hit_nonpic_nothing = 0;
+extern void exit (int);
+extern void abort (void);
+
+main ()
+{
+  nonpic_call ();
+  pic_addr ();
+
+  if (hit_nonpic_call != 1)
+    abort ();
+
+  if (hit_pic_addr != 2)
+    abort ();
+
+  exit (0);
+
+} 
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-11.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-11.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-11.c	(revision 0)
@@ -0,0 +1,23 @@
+/* { dg-options "nonpic-addr.o pic-addr.o nonpic-receive-fn-addr.o pic-receive-fn-addr.o nonpic-nothing.o pic-nothing.o" } */
+
+extern void nonpic_addr ();
+extern void pic_addr();
+extern void exit (int);
+extern void abort (void);
+int hit_nonpic_addr = 0;
+int hit_pic_addr = 0;
+int hit_pic_nothing = 0;
+int hit_nonpic_nothing = 0;
+main ()
+{
+  nonpic_addr ();
+  pic_addr ();
+
+  if (hit_nonpic_addr != 1)
+    abort ();
+
+  if (hit_pic_addr != 1)
+    abort ();
+
+  exit (0);
+} 
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-12.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-12.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-12.c	(revision 0)
@@ -0,0 +1,23 @@
+/* { dg-options "nonpic-addr-call.o pic-addr.o pic-receive-fn-addr.o nonpic-nothing.o pic-nothing.o" } */
+
+int hit_nonpic_addr_call = 0;
+int hit_pic_addr = 0;
+int hit_nonpic_nothing = 0;
+int hit_pic_nothing = 0;
+extern void nonpic_addr_call ();
+extern void pic_addr();
+extern void abort (void);
+extern void exit (int);
+main ()
+{
+  nonpic_addr_call ();
+  pic_addr ();
+
+  if (hit_nonpic_addr_call != 1)
+    abort ();
+
+  if (hit_pic_addr != 1)
+    abort ();
+
+  exit (0);
+} 
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/mips-nonpic.exp
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/mips-nonpic.exp	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/mips-nonpic.exp	(revision 0)
@@ -0,0 +1,45 @@
+#   Copyright (C) 2008 Free Software Foundation, Inc.
+
+# This program is free software; you can redistribute it and/or modify
+# it under the terms of the GNU General Public License as published by
+# the Free Software Foundation; either version 3 of the License, or
+# (at your option) any later version.
+# 
+# This program is distributed in the hope that it will be useful,
+# but WITHOUT ANY WARRANTY; without even the implied warranty of
+# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+# GNU General Public License for more details.
+# 
+# You should have received a copy of the GNU General Public License
+# along with GCC; see the file COPYING3.  If not see
+# <http://www.gnu.org/licenses/>.
+
+# GCC testsuite that uses the `dg.exp' driver.
+
+# Exit immediately if this isn't a MIPS target.
+if ![istarget mips*-*-*] {
+  return
+}
+
+load_lib gcc-dg.exp
+
+dg-init
+
+set old-dg-do-what-default "${dg-do-what-default}"
+set dg-do-what-default "assemble"
+
+foreach testcase [lsort [glob -nocomplain $srcdir/$subdir/pic-*.c]] {
+    verbose "Compiling [file tail [file dirname $testcase]]/[file tail $testcase]"
+    dg-test -keep-output $testcase "-fpic" ""
+}
+
+foreach testcase [lsort [glob -nocomplain $srcdir/$subdir/nonpic-\[a-z\]*.c]] {
+    verbose "Compiling [file tail [file dirname $testcase]]/[file tail $testcase]"
+    dg-test -keep-output $testcase "-fno-pic" ""
+}
+
+set dg-do-what-default "run"
+dg-runtest [lsort [glob -nocomplain $srcdir/$subdir/nonpic-\[0-9\]*.c]] "-fno-pic" ""
+
+set dg-do-what-default "${old-dg-do-what-default}"
+dg-finish
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-addr-call.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-addr-call.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-addr-call.c	(revision 0)
@@ -0,0 +1,10 @@
+extern int hit_nonpic_addr_call;
+extern void pic_nothing (void);
+extern void pic_receive_fn_addr (void *);
+void
+nonpic_addr_call (void)
+{
+  hit_nonpic_addr_call++;
+  pic_receive_fn_addr (&pic_nothing);
+  return;
+}
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-13.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-13.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-13.c	(revision 0)
@@ -0,0 +1,21 @@
+/* { dg-options "pic-addr-call.o nonpic-receive-fn-addr.o nonpic-nothing.o" } */
+
+int hit_pic_addr_call = 0;
+int hit_nonpic_nothing = 0;
+extern void nonpic_nothing ();
+extern void pic_addr_call();
+extern void exit (int);
+extern void abort (void);
+main ()
+{
+  nonpic_nothing ();
+  pic_addr_call ();
+
+  if (hit_nonpic_nothing != 1)
+    abort ();
+
+  if (hit_pic_addr_call != 1)
+    abort ();
+
+  exit (0);
+} 
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-14.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-14.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-14.c	(revision 0)
@@ -0,0 +1,24 @@
+/* { dg-options "nonpic-call.o pic-addr.o pic-receive-fn-addr.o pic-addr-call.o nonpic-receive-fn-addr.o nonpic-nothing.o pic-nothing.o" } */
+
+int hit_pic_addr_call = 0;
+int hit_nonpic_call = 0;
+int hit_pic_addr = 0;
+int hit_nonpic_nothing = 0;
+int hit_pic_nothing = 0;
+extern void nonpic_call ();
+extern void pic_addr_call();
+extern void abort (void);
+extern void exit (int);
+main ()
+{
+  nonpic_call ();
+  pic_addr_call ();
+
+  if (hit_nonpic_call != 1)
+    abort ();
+
+  if (hit_pic_addr_call != 1)
+    abort ();
+
+  exit (0);
+} 
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-15.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-15.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-15.c	(revision 0)
@@ -0,0 +1,23 @@
+/* { dg-options "nonpic-addr.o pic-receive-fn-addr.o pic-addr-call.o nonpic-receive-fn-addr.o nonpic-nothing.o pic-nothing.o" } */
+
+int hit_pic_addr_call = 0;
+int hit_nonpic_addr = 0;
+int hit_nonpic_nothing = 0;
+int hit_pic_nothing = 0;
+extern void nonpic_addr ();
+extern void pic_addr_call();
+extern void abort (void);
+extern void exit (int);
+main ()
+{
+  nonpic_addr ();
+  pic_addr_call ();
+
+  if (hit_nonpic_addr != 1)
+    abort ();
+
+  if (hit_pic_addr_call != 1)
+    abort ();
+
+  exit (0);
+} 
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-16.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-16.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-16.c	(revision 0)
@@ -0,0 +1,21 @@
+/* { dg-options "nonpic-addr-call.o pic-receive-fn-addr.o pic-addr-call.o nonpic-receive-fn-addr.o pic-nothing.o nonpic-nothing.o" } */
+
+extern void abort (void);
+extern void exit (int);
+extern void nonpic_addr_call ();
+extern void pic_addr_call();
+int hit_nonpic_addr_call = 0;
+int hit_pic_addr_call = 0;
+int hit_nonpic_nothing = 0;
+int hit_pic_nothing = 0;
+main ()
+{
+  nonpic_addr_call ();
+  pic_addr_call ();
+
+  if (hit_nonpic_addr_call != 1)
+    abort ();
+  if (hit_pic_addr_call != 1)
+    abort ();
+  exit (0);
+}
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-receive-fn-addr.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-receive-fn-addr.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-receive-fn-addr.c	(revision 0)
@@ -0,0 +1,8 @@
+extern void nonpic_nothing (void);
+extern void abort (void);
+void
+nonpic_receive_fn_addr (void *x)
+{
+  if (x != &nonpic_nothing)
+    abort ();
+}
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/pic-nothing.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/pic-nothing.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/pic-nothing.c	(revision 0)
@@ -0,0 +1,7 @@
+extern int hit_pic_nothing;
+void
+pic_nothing ()
+{
+  hit_pic_nothing++;
+  return;
+}
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/pic-addr.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/pic-addr.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/pic-addr.c	(revision 0)
@@ -0,0 +1,9 @@
+extern int hit_pic_addr;
+extern void pic_nothing (void);
+void
+pic_addr ()
+{
+  pic_receive_fn_addr (&pic_nothing);
+  hit_pic_addr++;
+  return;
+}
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/pic-call.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/pic-call.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/pic-call.c	(revision 0)
@@ -0,0 +1,10 @@
+extern int hit_pic_call;
+extern void nonpic_nothing (void);
+extern void nonpic_addr (void);
+void
+pic_call ()
+{
+ nonpic_nothing ();
+ nonpic_addr ();
+ hit_pic_call++;
+}
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-1.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-1.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-1.c	(revision 0)
@@ -0,0 +1,21 @@
+/* { dg-options "pic-nothing.o nonpic-nothing.o" } */
+
+extern void nonpic_nothing ();
+extern void pic_nothing ();
+int hit_pic_nothing = 0;
+int hit_nonpic_nothing = 0;
+extern void exit (int);
+extern void abort (void);
+main ()
+{
+  nonpic_nothing ();
+  pic_nothing ();
+
+  if (hit_nonpic_nothing != 1)
+    abort ();
+
+  if (hit_pic_nothing != 1)
+    abort ();
+
+  exit (0);
+} 
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-2.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-2.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-2.c	(revision 0)
@@ -0,0 +1,23 @@
+/* { dg-options "pic-addr.o nonpic-call.o pic-receive-fn-addr.o nonpic-nothing.o pic-nothing.o" } */
+
+extern void nonpic_call ();
+extern void pic_nothing ();
+extern void abort (void);
+extern void exit (int);
+int hit_nonpic_call = 0;
+int hit_pic_nothing = 0;
+int hit_pic_addr = 0;
+int hit_nonpic_nothing = 0;
+main ()
+{
+  nonpic_call ();
+  pic_nothing ();
+
+  if (hit_nonpic_call != 1)
+    abort ();
+
+  if (hit_pic_nothing != 2)
+    abort ();
+
+  exit (0);
+} 
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-3.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-3.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-3.c	(revision 0)
@@ -0,0 +1,22 @@
+/* { dg-options "nonpic-addr.o nonpic-receive-fn-addr.o nonpic-nothing.o pic-nothing.o" } */
+
+extern void nonpic_addr ();
+extern void pic_nothing ();
+extern void abort (void);
+extern void exit (int);
+int hit_nonpic_addr = 0;
+int hit_pic_nothing = 0;
+int hit_nonpic_nothing = 0;
+main ()
+{
+  nonpic_addr ();
+  pic_nothing ();
+
+  if (hit_nonpic_addr != 1)
+    abort ();
+
+  if (hit_pic_nothing != 1)
+    abort ();
+
+  exit (0);
+} 
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-4.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-4.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-4.c	(revision 0)
@@ -0,0 +1,24 @@
+/* { dg-options "pic-addr.o pic-receive-fn-addr.o nonpic-addr-call.o nonpic-nothing.o pic-nothing.o" } */
+
+int hit_nonpic_addr_call = 0;
+int hit_pic_nothing = 0;
+int hit_nonpic_nothing = 0;
+int hit_pic_addr = 0;
+int hit_nonpic_addr = 0;
+extern void nonpic_addr_call ();
+extern void pic_nothing ();
+extern void exit (int);
+extern void abort (void);
+main ()
+{
+  nonpic_addr_call ();
+  pic_nothing ();
+
+  if (hit_nonpic_addr_call != 1)
+    abort ();
+
+  if (hit_pic_nothing != 1)
+    abort ();
+
+  exit (0);
+} 
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-5.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-5.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-5.c	(revision 0)
@@ -0,0 +1,24 @@
+/* { dg-options "pic-addr.o pic-call.o nonpic-addr.o pic-receive-fn-addr.o nonpic-receive-fn-addr.o nonpic-nothing.o pic-nothing.o" } */
+
+extern void nonpic_nothing ();
+extern void pic_call ();
+extern void exit (int);
+extern void abort (void);
+int hit_nonpic_nothing = 0;
+int hit_pic_call = 0;
+int hit_nonpic_addr = 0;
+int hit_pic_nothing = 0;
+int hit_pic_addr = 0;
+main ()
+{
+  nonpic_nothing ();
+  pic_call ();
+
+  if (hit_nonpic_nothing != 2)
+    abort ();
+
+  if (hit_pic_call != 1)
+    abort ();
+
+  exit (0);
+} 
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-6.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-6.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-6.c	(revision 0)
@@ -0,0 +1,26 @@
+/* { dg-options "pic-call.o nonpic-call.o nonpic-addr.o pic-addr.o nonpic-receive-fn-addr.o pic-receive-fn-addr.o nonpic-nothing.o pic-nothing.o" } */
+
+extern void nonpic_call ();
+extern void pic_call ();
+extern void exit (int);
+extern void abort (void);
+int hit_pic_call = 0;
+int hit_nonpic_call = 0;
+int hit_pic_nothing = 0;
+int hit_nonpic_nothing = 0;
+int hit_nonpic_addr = 0;
+int hit_pic_addr = 0;
+
+main ()
+{
+  pic_call ();
+  nonpic_call ();
+
+  if (hit_pic_call != 1)
+    abort ();
+
+  if (hit_nonpic_call != 1)
+    abort ();
+
+  exit (0);
+} 
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-7.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-7.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-7.c	(revision 0)
@@ -0,0 +1,23 @@
+/* { dg-options "pic-call.o nonpic-addr.o nonpic-receive-fn-addr.o nonpic-nothing.o pic-nothing.o" } */
+
+int hit_pic_call = 0;
+int hit_nonpic_addr = 0;
+int hit_nonpic_nothing = 0;
+int hit_pic_nothing = 0;
+extern void nonpic_addr ();
+extern void pic_call ();
+extern void exit (int);
+extern void abort (void);
+main ()
+{
+  pic_call ();
+  nonpic_addr ();
+
+  if (hit_pic_call != 1)
+    abort ();
+
+  if (hit_nonpic_addr != 2)
+    abort ();
+
+  exit (0);
+} 
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-nothing.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-nothing.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-nothing.c	(revision 0)
@@ -0,0 +1,7 @@
+extern int hit_nonpic_nothing;
+void
+nonpic_nothing ()
+{
+  hit_nonpic_nothing++;
+  return;
+}
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-8.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-8.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-8.c	(revision 0)
@@ -0,0 +1,24 @@
+/* { dg-options "pic-call.o nonpic-addr-call.o nonpic-addr.o nonpic-receive-fn-addr.o pic-receive-fn-addr.o nonpic-nothing.o pic-nothing.o" } */
+
+int hit_nonpic_addr_call = 0;
+int hit_pic_call = 0;
+int hit_pic_nothing = 0;
+int hit_nonpic_nothing = 0;
+int hit_nonpic_addr = 0;
+extern void exit (int);
+extern void abort (void);
+extern void nonpic_addr_call ();
+extern void pic_call ();
+main ()
+{
+  pic_call ();
+  nonpic_addr_call ();
+
+  if (hit_pic_call != 1)
+    abort ();
+
+  if (hit_nonpic_addr_call != 1)
+    abort ();
+
+  exit (0);
+} 
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-9.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-9.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/nonpic-9.c	(revision 0)
@@ -0,0 +1,15 @@
+/* { dg-options "pic-addr.o pic-receive-fn-addr.o nonpic-nothing.o pic-nothing.o" } */
+
+extern void nonpic_nothing ();
+extern void pic_addr();
+extern void exit (int);
+extern void abort (void);
+int hit_pic_addr = 0;
+int hit_nonpic_nothing = 0;
+int hit_pic_nothing = 0;
+int hit_pic_receive_fn_addr = 0;
+main ()
+{
+  pic_addr ();
+  nonpic_nothing ();
+} 
Index: gcc/testsuite/gcc.target/mips/mips-nonpic/pic-addr-call.c
===================================================================
--- gcc/testsuite/gcc.target/mips/mips-nonpic/pic-addr-call.c	(revision 0)
+++ gcc/testsuite/gcc.target/mips/mips-nonpic/pic-addr-call.c	(revision 0)
@@ -0,0 +1,10 @@
+extern int hit_pic_addr_call;
+extern void nonpic_nothing (void);
+extern void nonpic_receive_fn_addr (void *);
+void
+pic_addr_call (void)
+{
+  hit_pic_addr_call++;
+  nonpic_receive_fn_addr (&nonpic_nothing);
+  return;
+}
Index: gcc/configure.ac
===================================================================
--- gcc/configure.ac	(revision 137143)
+++ gcc/configure.ac	(working copy)
@@ -1537,6 +1537,10 @@ AC_ARG_ENABLE(cld,
 [  --enable-cld            enable -mcld by default for 32bit x86], [],
 [enable_cld=no])
 
+AC_ARG_ENABLE(mips-nonpic,
+[  --enable-mips-nonpic    enable non-PIC ABI by default for MIPS GNU/Linux o32],
+[], [])
+
 # Windows32 Registry support for specifying GCC installation paths.
 AC_ARG_ENABLE(win32-registry,
 [  --disable-win32-registry
Index: gcc/config.gcc
===================================================================
--- gcc/config.gcc	(revision 137143)
+++ gcc/config.gcc	(working copy)
@@ -1489,7 +1489,7 @@ mcore-*-pe*)
 mips-sgi-irix[56]*)
 	tm_file="elfos.h ${tm_file} mips/iris.h"
 	tmake_file="mips/t-iris mips/t-slibgcc-irix"
-	target_cpu_default="MASK_ABICALLS"
+	tm_defines="${tm_defines} TARGET_ABICALLS_DEFAULT=1"
 	case ${target} in
 	*-*-irix5*)
 		tm_file="${tm_file} mips/iris5.h"
@@ -1515,12 +1515,16 @@ mips-sgi-irix[56]*)
 	use_fixproto=yes
 	;;
 mips*-*-netbsd*)			# NetBSD/mips, either endian.
-	target_cpu_default="MASK_ABICALLS"
+	tm_defines="${tm_defines} TARGET_ABICALLS_DEFAULT=1"
 	tm_file="elfos.h ${tm_file} mips/elf.h netbsd.h netbsd-elf.h mips/netbsd.h"
 	;;
 mips64*-*-linux*)
 	tm_file="dbxelf.h elfos.h svr4.h linux.h ${tm_file} mips/linux.h mips/linux64.h"
 	tmake_file="${tmake_file} mips/t-linux64"
+	tm_defines="${tm_defines} TARGET_ABICALLS_DEFAULT=1"
+	if test x${enable_mips_nonpic}; then
+		tm_defines="${tm_defines} TARGET_ABICALLS_NONPIC=1"
+	fi
 	tm_defines="${tm_defines} MIPS_ABI_DEFAULT=ABI_N32"
 	case ${target} in
 		mips64el-st-linux-gnu)
@@ -1533,7 +1537,11 @@ mips64*-*-linux*)
 	test x$with_llsc != x || with_llsc=yes
 	;;
 mips*-*-linux*)				# Linux MIPS, either endian.
-        tm_file="dbxelf.h elfos.h svr4.h linux.h ${tm_file} mips/linux.h"
+	tm_file="dbxelf.h elfos.h svr4.h linux.h ${tm_file} mips/linux.h"
+	tm_defines="${tm_defines} TARGET_ABICALLS_DEFAULT=1"
+	if test x${enable_mips_nonpic}; then
+		tm_defines="${tm_defines} TARGET_ABICALLS_NONPIC=1"
+	fi
 	case ${target} in
         mipsisa32r2*)
 		tm_defines="${tm_defines} MIPS_ISA_DEFAULT=33"
@@ -1545,7 +1553,7 @@ mips*-*-linux*)				# Linux MIPS, either 
 	;;
 mips*-*-openbsd*)
 	tm_defines="${tm_defines} OBSD_HAS_DECLARE_FUNCTION_NAME OBSD_HAS_DECLARE_OBJECT OBSD_HAS_CORRECT_SPECS"
-	target_cpu_default="MASK_ABICALLS"
+	tm_defines="${tm_defines} TARGET_ABICALLS_DEFAULT=1"
 	tm_file="mips/mips.h openbsd.h mips/openbsd.h mips/sdb.h"
 	case ${target} in
 	mips*el-*-openbsd*)
Index: gcc/config/mips/linux.h
===================================================================
--- gcc/config/mips/linux.h	(revision 137143)
+++ gcc/config/mips/linux.h	(working copy)
@@ -37,10 +37,6 @@ along with GCC; see the file COPYING3.  
 #undef MD_EXEC_PREFIX
 #undef MD_STARTFILE_PREFIX
 
-/* If we don't set MASK_ABICALLS, we can't default to PIC.  */
-#undef TARGET_DEFAULT
-#define TARGET_DEFAULT MASK_ABICALLS
-
 #define TARGET_OS_CPP_BUILTINS()				\
   do {								\
     LINUX_TARGET_OS_CPP_BUILTINS();				\
@@ -79,7 +75,8 @@ along with GCC; see the file COPYING3.  
         %{static:-static}}}"
 
 #undef SUBTARGET_ASM_SPEC
-#define SUBTARGET_ASM_SPEC "%{mabi=64: -64} %{!mno-abicalls:-KPIC}"
+#define SUBTARGET_ASM_SPEC \
+ "%{mabi=64: -64} %{mabicalls:%{fpic|fPIC:-KPIC;:-mnon-pic-abicalls}}"
 
 /* The MIPS assembler has different syntax for .set. We set it to
    .dummy to trap any errors.  */
@@ -163,7 +160,8 @@ extern const char *host_detect_local_cpu
 # define MARCH_MTUNE_NATIVE_SPECS ""
 #endif
 
-#define BASE_DRIVER_SELF_SPECS \
+#define LINUX_DRIVER_SELF_SPECS \
   NO_SHARED_SPECS \
   MARCH_MTUNE_NATIVE_SPECS
-#define DRIVER_SELF_SPECS BASE_DRIVER_SELF_SPECS
+#undef SUBTARGET_SELF_SPECS
+#define SUBTARGET_SELF_SPECS LINUX_DRIVER_SELF_SPECS
Index: gcc/config/mips/elfoabi.h
===================================================================
--- gcc/config/mips/elfoabi.h	(revision 137143)
+++ gcc/config/mips/elfoabi.h	(working copy)
@@ -19,7 +19,8 @@ You should have received a copy of the G
 along with GCC; see the file COPYING3.  If not see
 <http://www.gnu.org/licenses/>.  */
 
-#define DRIVER_SELF_SPECS						\
+#undef SUBTARGET_SELF_SPECS
+#define SUBTARGET_SELF_SPECS						\
   /* Make sure a -mips option is present.  This helps us to pick	\
      the right multilib, and also makes the later specs easier		\
      to write.  */							\
Index: gcc/config/mips/linux64.h
===================================================================
--- gcc/config/mips/linux64.h	(revision 137143)
+++ gcc/config/mips/linux64.h	(working copy)
@@ -20,9 +20,9 @@ along with GCC; see the file COPYING3.  
 
 /* Force the default endianness and ABI flags onto the command line
    in order to make the other specs easier to write.  */
-#undef DRIVER_SELF_SPECS
-#define DRIVER_SELF_SPECS \
-BASE_DRIVER_SELF_SPECS \
+#undef SUBTARGET_SELF_SPECS
+#define SUBTARGET_SELF_SPECS \
+LINUX_DRIVER_SELF_SPECS \
 " %{!EB:%{!EL:%(endian_spec)}}" \
 " %{!mabi=*: -mabi=n32}"
 
Index: gcc/config/mips/sde.h
===================================================================
--- gcc/config/mips/sde.h	(revision 137143)
+++ gcc/config/mips/sde.h	(working copy)
@@ -19,7 +19,8 @@ You should have received a copy of the G
 along with GCC; see the file COPYING3.  If not see
 <http://www.gnu.org/licenses/>.  */
 
-#define DRIVER_SELF_SPECS						\
+#undef SUBTARGET_SELF_SPECS
+#define SUBTARGET_SELF_SPECS						\
   /* Make sure a -mips option is present.  This helps us to pick	\
      the right multilib, and also makes the later specs easier		\
      to write.  */							\
Index: gcc/config/mips/mips.md
===================================================================
--- gcc/config/mips/mips.md	(revision 137143)
+++ gcc/config/mips/mips.md	(working copy)
@@ -4462,6 +4462,22 @@
   [(set (match_operand:P 0 "register_operand" "=d")
 	(const:P (unspec:P [(const_int 0)] UNSPEC_GP)))])
 
+;; Move the constant value of __gnu_local_gp (operand 1) into
+;; operand 0, for non-PIC abicalls code.  All uses of the result
+;; are explicit, so there's no need for unspec_volatile here.
+(define_insn_and_split "loadgp_nonpic_<mode>"
+  [(set (match_operand:P 0 "register_operand" "=d")
+	(const:P (unspec:P [(match_operand 1 "" "")] UNSPEC_LOADGP)))]
+  "TARGET_NONPIC_ABICALLS"
+  "#"
+  ""
+  [(const_int 0)]
+{
+  mips_emit_move (operands[0], operands[1]);
+  DONE;
+}
+  [(set_attr "length" "8")])
+
 ;; Insn to initialize $gp for n32/n64 abicalls.  Operand 0 is the offset
 ;; of _gp from the start of this function.  Operand 1 is the incoming
 ;; function address.
@@ -5827,11 +5843,12 @@
 
 ;; Restore the gp that we saved above.  Despite the earlier comment, it seems
 ;; that older code did recalculate the gp from $25.  Continue to jump through
-;; $25 for compatibility (we lose nothing by doing so).
+;; $25 for compatibility (we lose nothing by doing so).  Similarly restore
+;; $gp if we might be jumping to code which expects that.
 
 (define_expand "builtin_longjmp"
   [(use (match_operand 0 "register_operand"))]
-  "TARGET_USE_GOT"
+  "TARGET_USE_GOT || TARGET_ABICALLS"
 {
   /* The elements of the buffer are, in order:  */
   int W = GET_MODE_SIZE (Pmode);
Index: gcc/config/mips/iris6.h
===================================================================
--- gcc/config/mips/iris6.h	(revision 137143)
+++ gcc/config/mips/iris6.h	(working copy)
@@ -29,7 +29,8 @@ along with GCC; see the file COPYING3.  
 
 /* Force the default ABI onto the command line in order to make the specs
    easier to write.  Default to the mips2 ISA for the O32 ABI.  */
-#define DRIVER_SELF_SPECS \
+#undef SUBTARGET_SELF_SPECS
+#define SUBTARGET_SELF_SPECS \
   "%{!mabi=*: -mabi=n32}", \
   "%{mabi=32: %{!mips*: %{!march*: -mips2}}}"
 
Index: gcc/config/mips/mips.c
===================================================================
--- gcc/config/mips/mips.c	(revision 137143)
+++ gcc/config/mips/mips.c	(working copy)
@@ -1415,7 +1415,7 @@ mips_classify_symbol (const_rtx x, enum 
       if (TARGET_MIPS16_SHORT_JUMP_TABLES)
 	return SYMBOL_PC_RELATIVE;
 
-      if (TARGET_ABICALLS && !TARGET_ABSOLUTE_ABICALLS)
+      if (TARGET_PIC_ABICALLS && !TARGET_ABSOLUTE_ABICALLS)
 	return SYMBOL_GOT_PAGE_OFST;
 
       return SYMBOL_ABSOLUTE;
@@ -1438,14 +1438,15 @@ mips_classify_symbol (const_rtx x, enum 
 	return SYMBOL_GP_RELATIVE;
     }
 
-  /* Do not use small-data accesses for weak symbols; they may end up
-     being zero.  */
+  /* Use a small-data access if appropriate; but do not use small-data
+     accesses for weak symbols; they may end up being zero.  */
   if (TARGET_GPOPT && SYMBOL_REF_SMALL_P (x) && !SYMBOL_REF_WEAK (x))
     return SYMBOL_GP_RELATIVE;
 
-  /* Don't use GOT accesses for locally-binding symbols when -mno-shared
-     is in effect.  */
-  if (TARGET_ABICALLS
+  /* Use GOT accesses for PIC abicalls, except for locally-binding
+     symbols when -mno-shared is in effect - in that case the symbol
+     address is constant.  */
+  if (TARGET_PIC_ABICALLS
       && !(TARGET_ABSOLUTE_ABICALLS && mips_symbol_binds_local_p (x)))
     {
       /* There are three cases to consider:
@@ -2243,6 +2244,21 @@ mips_emit_call_insn (rtx pattern, bool l
   return insn;
 }
 
+/* The __gnu_local_gp symbol.  */
+
+static GTY(()) rtx mips_gnu_local_gp_rtx;
+
+static rtx
+mips_gnu_local_gp (void)
+{
+  if (mips_gnu_local_gp_rtx == NULL)
+    {
+      mips_gnu_local_gp_rtx = gen_rtx_SYMBOL_REF (Pmode, "__gnu_local_gp");
+      SYMBOL_REF_FLAGS (mips_gnu_local_gp_rtx) |= SYMBOL_FLAG_LOCAL;
+    }
+  return mips_gnu_local_gp_rtx;
+}
+
 /* Return an instruction that copies $gp into register REG.  We want
    GCC to treat the register's value as constant, so that its value
    can be rematerialized on demand.  */
@@ -2255,9 +2271,22 @@ gen_load_const_gp (rtx reg)
 	  : gen_load_const_gp_di (reg));
 }
 
+/* Return an instruction that moves the constant value of
+   __gnu_local_gp into register REG.  */
+
+static rtx
+gen_loadgp_nonpic (rtx reg)
+{
+  return (Pmode == SImode
+	  ? gen_loadgp_nonpic_si (reg, mips_gnu_local_gp ())
+	  : gen_loadgp_nonpic_di (reg, mips_gnu_local_gp ()));
+}
+
 /* Return a pseudo register that contains the value of $gp throughout
    the current function.  Such registers are needed by MIPS16 functions,
-   for which $gp itself is not a valid base register or addition operand.  */
+   for which $gp itself is not a valid base register or addition operand.
+   Also hold the GP in a non-PIC abicalls function which refers to TLS
+   data - such functions do not require $28 or even a hard register.  */
 
 static rtx
 mips16_gp_pseudo_reg (void)
@@ -2273,7 +2302,10 @@ mips16_gp_pseudo_reg (void)
     {
       rtx insn, scan, after;
 
-      insn = gen_load_const_gp (cfun->machine->mips16_gp_pseudo_rtx);
+      if (TARGET_NONPIC_ABICALLS)
+	insn = gen_loadgp_nonpic (cfun->machine->mips16_gp_pseudo_rtx);
+      else
+	insn = gen_load_const_gp (cfun->machine->mips16_gp_pseudo_rtx);
 
       push_topmost_sequence ();
       /* We need to emit the initialization after the FUNCTION_BEG
@@ -2415,6 +2447,19 @@ mips_add_offset (rtx temp, rtx reg, HOST
   return plus_constant (reg, offset);
 }
 
+/* Return the RTX to use for explicit GOT accesses.  Uses a pseudo if
+   possible.  */
+
+static rtx
+mips_got_base (void)
+{
+  gcc_assert (can_create_pseudo_p ());
+  if (TARGET_NONPIC_ABICALLS)
+    return mips16_gp_pseudo_reg ();
+  else
+    return pic_offset_table_rtx;
+}
+
 /* The __tls_get_attr symbol.  */
 static GTY(()) rtx mips_tls_symbol;
 
@@ -2438,7 +2483,7 @@ mips_call_tls_get_addr (rtx sym, enum mi
   start_sequence ();
 
   emit_insn (gen_rtx_SET (Pmode, a0,
-			  gen_rtx_LO_SUM (Pmode, pic_offset_table_rtx, loc)));
+			  gen_rtx_LO_SUM (Pmode, mips_got_base (), loc)));
   insn = mips_expand_call (v0, mips_tls_symbol, const0_rtx, const0_rtx, false);
   RTL_CONST_CALL_P (insn) = 1;
   use_reg (&CALL_INSN_FUNCTION_USAGE (insn), a0);
@@ -2504,12 +2549,12 @@ mips_legitimize_tls_address (rtx loc)
       if (Pmode == DImode)
 	{
 	  emit_insn (gen_tls_get_tp_di (v1));
-	  emit_insn (gen_load_gotdi (tmp1, pic_offset_table_rtx, tmp2));
+	  emit_insn (gen_load_gotdi (tmp1, mips_got_base (), tmp2));
 	}
       else
 	{
 	  emit_insn (gen_tls_get_tp_si (v1));
-	  emit_insn (gen_load_gotsi (tmp1, pic_offset_table_rtx, tmp2));
+	  emit_insn (gen_load_gotsi (tmp1, mips_got_base (), tmp2));
 	}
       dest = gen_reg_rtx (Pmode);
       emit_insn (gen_add3_insn (dest, tmp1, v1));
@@ -6835,7 +6880,7 @@ mips_select_rtx_section (enum machine_mo
 
 /* Implement TARGET_ASM_FUNCTION_RODATA_SECTION.
 
-   The complication here is that, with the combination TARGET_ABICALLS
+   The complication here is that, with the combination TARGET_PIC_ABICALLS
    && !TARGET_GPWORD, jump tables will use absolute addresses, and should
    therefore not be included in the read-only part of a DSO.  Handle such
    cases by selecting a normal data section instead of a read-only one.
@@ -6844,7 +6889,7 @@ mips_select_rtx_section (enum machine_mo
 static section *
 mips_function_rodata_section (tree decl)
 {
-  if (!TARGET_ABICALLS || TARGET_GPWORD)
+  if (!TARGET_PIC_ABICALLS || TARGET_GPWORD)
     return default_function_rodata_section (decl);
 
   if (decl && DECL_SECTION_NAME (decl))
@@ -7344,6 +7389,8 @@ mips_file_start (void)
   /* If TARGET_ABICALLS, tell GAS to generate -KPIC code.  */
   if (TARGET_ABICALLS)
     fprintf (asm_out_file, "\t.abicalls\n");
+  if (TARGET_NONPIC_ABICALLS)
+    fprintf (asm_out_file, "\t.option\tpic0\n");
 
   if (flag_verbose_asm)
     fprintf (asm_out_file, "\n%s -G value = %d, Arch = %s, ISA = %d\n",
@@ -7937,7 +7984,7 @@ mips_save_reg_p (unsigned int regno)
 {
   /* We only need to save $gp if TARGET_CALL_SAVED_GP and only then
      if we have not chosen a call-clobbered substitute.  */
-  if (regno == GLOBAL_POINTER_REGNUM)
+  if (regno == GLOBAL_POINTER_REGNUM && fixed_regs[regno])
     return TARGET_CALL_SAVED_GP && cfun->machine->global_pointer == regno;
 
   /* Check call-saved registers.  */
@@ -8161,7 +8208,7 @@ mips_current_loadgp_style (void)
   if (TARGET_RTP_PIC)
     return LOADGP_RTP;
 
-  if (TARGET_ABSOLUTE_ABICALLS)
+  if (TARGET_ABSOLUTE_ABICALLS || !flag_pic)
     return LOADGP_ABSOLUTE;
 
   return TARGET_NEWABI ? LOADGP_NEWABI : LOADGP_OLDABI;
@@ -8276,7 +8323,7 @@ mips_restore_gp (void)
 {
   rtx base, address;
 
-  gcc_assert (TARGET_ABICALLS && TARGET_OLDABI);
+  gcc_assert (TARGET_PIC_ABICALLS && TARGET_OLDABI);
 
   base = frame_pointer_needed ? hard_frame_pointer_rtx : stack_pointer_rtx;
   address = mips_add_offset (pic_offset_table_rtx, base,
@@ -8527,10 +8574,6 @@ mips_save_reg (rtx reg, rtx mem)
     }
 }
 
-/* The __gnu_local_gp symbol.  */
-
-static GTY(()) rtx mips_gnu_local_gp;
-
 /* If we're generating n32 or n64 abicalls, emit instructions
    to set up the global pointer.  */
 
@@ -8543,14 +8586,9 @@ mips_emit_loadgp (void)
   switch (mips_current_loadgp_style ())
     {
     case LOADGP_ABSOLUTE:
-      if (mips_gnu_local_gp == NULL)
-	{
-	  mips_gnu_local_gp = gen_rtx_SYMBOL_REF (Pmode, "__gnu_local_gp");
-	  SYMBOL_REF_FLAGS (mips_gnu_local_gp) |= SYMBOL_FLAG_LOCAL;
-	}
       emit_insn (Pmode == SImode
-		 ? gen_loadgp_absolute_si (pic_reg, mips_gnu_local_gp)
-		 : gen_loadgp_absolute_di (pic_reg, mips_gnu_local_gp));
+		 ? gen_loadgp_absolute_si (pic_reg, mips_gnu_local_gp ())
+		 : gen_loadgp_absolute_di (pic_reg, mips_gnu_local_gp ()));
       break;
 
     case LOADGP_NEWABI:
@@ -12702,6 +12740,10 @@ mips_override_options (void)
 
   /* End of code shared with GAS.  */
 
+  /* The non-PIC ABI may only be used in conjunction with the o32 ABI.  */
+  if (TARGET_NONPIC_ABICALLS && mips_abi != ABI_32)
+    sorry ("non-PIC abicalls may only be used with the o32 ABI");
+
   /* If no -mlong* option was given, infer it from the other options.  */
   if ((target_flags_explicit & MASK_LONG64) == 0)
     {
@@ -12750,24 +12792,14 @@ mips_override_options (void)
       target_flags &= ~MASK_ABICALLS;
     }
 
-  /* MIPS16 cannot generate PIC yet.  */
+  /* MIPS16 cannot generate PIC or abicalls yet.  */
   if (TARGET_MIPS16 && (flag_pic || TARGET_ABICALLS))
     {
-      sorry ("MIPS16 PIC");
+      sorry ("MIPS16 PIC and abicalls are not yet implemented");
       target_flags &= ~MASK_ABICALLS;
       flag_pic = flag_pie = flag_shlib = 0;
     }
 
-  if (TARGET_ABICALLS)
-    /* We need to set flag_pic for executables as well as DSOs
-       because we may reference symbols that are not defined in
-       the final executable.  (MIPS does not use things like
-       copy relocs, for example.)
-
-       Also, there is a body of code that uses __PIC__ to distinguish
-       between -mabicalls and -mno-abicalls code.  */
-    flag_pic = 1;
-
   /* -mvr4130-align is a "speed over size" optimization: it usually produces
      faster code, but at the expense of more nops.  Enable it at -O3 and
      above.  */
@@ -12781,6 +12813,7 @@ mips_override_options (void)
 
   /* If we have a nonzero small-data limit, check that the -mgpopt
      setting is consistent with the other target flags.  */
+
   if (mips_small_data_threshold > 0)
     {
       if (!TARGET_GPOPT)
@@ -13001,6 +13034,14 @@ mips_conditional_register_usage (void)
       for (regno = DSP_ACC_REG_FIRST; regno <= DSP_ACC_REG_LAST; regno += 2)
 	mips_swap_registers (regno);
     }
+  /* In non-PIC abicalls, $gp is completely ordinary; we can use a pseudo
+     for TLS GOT entries.  */
+  if (TARGET_NONPIC_ABICALLS)
+    {
+      call_used_regs[GLOBAL_POINTER_REGNUM] = TARGET_OLDABI;
+      call_really_used_regs[GLOBAL_POINTER_REGNUM] = TARGET_OLDABI;
+      fixed_regs[GLOBAL_POINTER_REGNUM] = 0;
+    }
 }
 
 /* Initialize vector TARGET to VALS.  */
Index: gcc/config/mips/mips.h
===================================================================
--- gcc/config/mips/mips.h	(revision 137143)
+++ gcc/config/mips/mips.h	(working copy)
@@ -163,7 +163,7 @@ enum mips_code_readable_setting {
    accesses are so much shorter.  */
 
 #define TARGET_ABSOLUTE_ABICALLS	\
-  (TARGET_ABICALLS			\
+  (TARGET_PIC_ABICALLS			\
    && !TARGET_SHARED			\
    && TARGET_EXPLICIT_RELOCS		\
    && !ABI_HAS_64BIT_SYMBOLS)
@@ -182,11 +182,19 @@ enum mips_code_readable_setting {
 #define TARGET_SIBCALLS \
   (!TARGET_MIPS16 && (!TARGET_USE_GOT || TARGET_EXPLICIT_RELOCS))
 
-/* True if we need to use a global offset table to access some symbols.  */
-#define TARGET_USE_GOT (TARGET_ABICALLS || TARGET_RTP_PIC)
+/* True if using abicalls, and position-independent (even if
+   -mno-shared).  */
+#define TARGET_PIC_ABICALLS (TARGET_ABICALLS && flag_pic)
+
+/* True if using abicalls, but not ourselves PIC.  */
+#define TARGET_NONPIC_ABICALLS (TARGET_ABICALLS && !flag_pic)
+
+/* True if we need to use a global offset table to access some symbols.
+   Small data and TLS may use the GOT even without this.  */
+#define TARGET_USE_GOT (TARGET_PIC_ABICALLS || TARGET_RTP_PIC)
 
 /* True if TARGET_USE_GOT and if $gp is a call-clobbered register.  */
-#define TARGET_CALL_CLOBBERED_GP (TARGET_ABICALLS && TARGET_OLDABI)
+#define TARGET_CALL_CLOBBERED_GP (TARGET_PIC_ABICALLS && TARGET_OLDABI)
 
 /* True if TARGET_USE_GOT and if $gp is a call-saved register.  */
 #define TARGET_CALL_SAVED_GP (TARGET_USE_GOT && !TARGET_CALL_CLOBBERED_GP)
@@ -200,7 +208,8 @@ enum mips_code_readable_setting {
    Although GAS does understand .gpdword, the SGI linker mishandles
    the relocations GAS generates (R_MIPS_GPREL32 followed by R_MIPS_64).
    We therefore disable GP-relative switch tables for n64 on IRIX targets.  */
-#define TARGET_GPWORD (TARGET_ABICALLS && !(mips_abi == ABI_64 && TARGET_IRIX))
+#define TARGET_GPWORD \
+  (TARGET_PIC_ABICALLS && !(mips_abi == ABI_64 && TARGET_IRIX))
 
 /* Generate mips16 code */
 #define TARGET_MIPS16		((target_flags & MASK_MIPS16) != 0)
@@ -973,6 +982,47 @@ enum mips_code_readable_setting {
 #endif
 
 
+/* Some targets (most of those with dynamic linking, e.g. Irix,
+   GNU/Linux, BSD) default to -mabicalls.  They mostly default to PIC
+   also.  Force the appropriate -mabicalls setting into the command
+   line for the benefit of the -fno-pic spec just below.  */
+#ifdef TARGET_ABICALLS_DEFAULT
+#define ABICALLS_SPEC "%{!mno-abicalls:%{!mabicalls:-mabicalls}}"
+#else
+#define ABICALLS_SPEC "%{!mno-abicalls:%{!mabicalls:-mno-abicalls}}"
+#endif
+
+/* Make -mabicalls imply PIC unless the target supports non-PIC
+   abicalls.  Targets which do not support non-PIC abicalls must set
+   flag_pic for executables as well as DSOs
+   because we may reference symbols that are not defined in
+   the final executable - these targets do not have copy relocs.
+
+   All 64-bit targets are assumed to not support PIC abicalls.
+   CSL NOTE: It would be nice to remove this restriction before
+   contributing upstream; 64-bit support should be a small project.
+
+   Also, there is a body of code that uses __PIC__ to distinguish
+   between -mabicalls and -mno-abicalls code.  For targets with
+   non-PIC abicalls support any such code will have to be corrected.
+   All you need to do if !__PIC__ is use $t9 for indirect calls
+   and be careful about assuming $gp is set up in inline asm.  */
+#ifdef TARGET_ABICALLS_NONPIC
+#define ABICALLS_SELF_SPECS ABICALLS_SPEC, \
+  "%{mabicalls:%{!fno-pic:%{mabi=o64|mabi=64|mabi=n32:-fpic}}}"
+#else
+#define ABICALLS_SELF_SPECS ABICALLS_SPEC, \
+  "%{mabicalls:%{!fno-pic:-fpic}}"
+#endif
+
+/* Any additional self specs defined by the subtarget.  */
+#define SUBTARGET_SELF_SPECS ""
+
+#define DRIVER_SELF_SPECS \
+ SUBTARGET_SELF_SPECS, \
+ ABICALLS_SELF_SPECS
+
+
 #ifndef MIPS_ABI_DEFAULT
 #define MIPS_ABI_DEFAULT ABI_32
 #endif
@@ -1044,7 +1094,7 @@ enum mips_code_readable_setting {
 %{mfix-vr4120} %{mfix-vr4130} \
 %(subtarget_asm_optimizing_spec) \
 %(subtarget_asm_debugging_spec) \
-%{mabi=*} %{!mabi*: %(asm_abi_default_spec)} \
+%{mabi=*} %{!mabi=*: %(asm_abi_default_spec)} \
 %{mgp32} %{mgp64} %{march=*} %{mxgot:-xgot} \
 %{mfp32} %{mfp64} \
 %{mshared} %{mno-shared} \
@@ -2484,7 +2534,7 @@ typedef struct mips_args {
    ? "%*" INSN "\t%" #OPNO "%/"					\
    : REG_P (OPERANDS[OPNO])					\
    ? "%*" INSN "r\t%" #OPNO "%/"				\
-   : TARGET_ABICALLS						\
+   : TARGET_PIC_ABICALLS					\
    ? (".option\tpic0\n\t"					\
       "%*" INSN "\t%" #OPNO "%/\n\t"				\
       ".option\tpic2")						\
Index: gcc/config/mips/vr.h
===================================================================
--- gcc/config/mips/vr.h	(revision 137143)
+++ gcc/config/mips/vr.h	(working copy)
@@ -26,7 +26,8 @@ along with GCC; see the file COPYING3.  
 	  MULTILIB_ABI_DEFAULT,			\
 	  DEFAULT_VR_ARCH }
 
-#define DRIVER_SELF_SPECS \
+#undef SUBTARGET_SELF_SPECS
+#define SUBTARGET_SELF_SPECS \
 	/* Enforce the default architecture.  This is mostly for	\
 	   the assembler's benefit.  */					\
 	"%{!march=*:%{!mfix-vr4120:%{!mfix-vr4130:"			\

--vtzGhvizbBRQ85DL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="gdb-nonpic.patch"

2008-03-07  Daniel Jacobowitz  <dan@codesourcery.com>

	gdb/
	* mips-tdep.c (mips32_scan_prologue): Stop scanning at branches.

2008-03-10  Daniel Jacobowitz  <dan@codesourcery.com>

	gdb/
	* mips-linux-tdep.c (mips_linux_in_dynsym_resolve_code): Update
	comments.
	(mips_linux_skip_resolver): Also use glibc_skip_solib_resolver.
	(mips_linux_init_abi): Do not override skip_trampoline_code.
	* configure.tgt (mips*-*-linux*): Add glibc-tdep.o.
	* mips-tdep.c (mips_stub_frame_sniffer): Use the stub frame sniffer
	for .MIPS.pic_stubs.
	(mips_skip_mips16_trampoline_code): Rename from
	mips_skip_trampoline_code.
	(mips_skip_pic_trampoline_code, mips_skip_trampoline_code): New.
	* infrun.c (handle_inferior_event): Do not check
	IN_SOLIB_DYNSYM_RESOLVE_CODE.  Do not pass zero to
	in_solib_dynsym_resolve_code.
	* Makefile.in (mips-linux-tdep.o): Update.

Index: gdb/Makefile.in
===================================================================
RCS file: /scratch/gcc/repos/src/src/gdb/Makefile.in,v
retrieving revision 1.1027
diff -u -p -r1.1027 Makefile.in
--- gdb/Makefile.in	10 Jun 2008 10:23:53 -0000	1.1027
+++ gdb/Makefile.in	27 Jun 2008 14:28:26 -0000
@@ -2519,7 +2519,7 @@ mips-linux-tdep.o: mips-linux-tdep.c $(d
 	$(gdb_assert_h) $(frame_h) $(regcache_h) $(trad_frame_h) \
 	$(tramp_frame_h) $(gdbtypes_h) $(solib_h) $(symtab_h) \
 	$(mips_linux_tdep_h) $(solist_h) $(solib_svr4_h) \
-	$(target_descriptions_h)
+	$(target_descriptions_h) $(glibc_tdep_h)
 mipsnbsd-nat.o: mipsnbsd-nat.c $(defs_h) $(inferior_h) $(regcache_h) \
 	$(target_h) $(mips_tdep_h) $(mipsnbsd_tdep_h) $(inf_ptrace_h)
 mipsnbsd-tdep.o: mipsnbsd-tdep.c $(defs_h) $(gdbcore_h) $(regcache_h) \
Index: gdb/configure.tgt
===================================================================
RCS file: /scratch/gcc/repos/src/src/gdb/configure.tgt,v
retrieving revision 1.203
diff -u -p -r1.203 configure.tgt
--- gdb/configure.tgt	1 May 2008 23:09:14 -0000	1.203
+++ gdb/configure.tgt	27 Jun 2008 14:28:26 -0000
@@ -297,7 +297,7 @@ mips*-sgi-irix6*)
 	;;
 mips*-*-linux*)
 	# Target: Linux/MIPS
-	gdb_target_obs="mips-tdep.o mips-linux-tdep.o \
+	gdb_target_obs="mips-tdep.o mips-linux-tdep.o glibc-tdep.o \
 			corelow.o solib.o solib-svr4.o symfile-mem.o"
 	gdb_sim=../sim/mips/libsim.a
 	build_gdbserver=yes
Index: gdb/infrun.c
===================================================================
RCS file: /scratch/gcc/repos/src/src/gdb/infrun.c,v
retrieving revision 1.282
diff -u -p -r1.282 infrun.c
--- gdb/infrun.c	24 Jun 2008 19:30:18 -0000	1.282
+++ gdb/infrun.c	27 Jun 2008 14:28:26 -0000
@@ -2863,12 +2863,7 @@ infrun: BPSTAT_WHAT_SET_LONGJMP_RESUME (
      until we exit the run time loader code and reach the callee's
      address.  */
   if (step_over_calls == STEP_OVER_UNDEBUGGABLE
-#ifdef IN_SOLIB_DYNSYM_RESOLVE_CODE
-      && IN_SOLIB_DYNSYM_RESOLVE_CODE (stop_pc)
-#else
-      && in_solib_dynsym_resolve_code (stop_pc)
-#endif
-      )
+      && in_solib_dynsym_resolve_code (stop_pc))
     {
       CORE_ADDR pc_after_resolver =
 	gdbarch_skip_solib_resolver (current_gdbarch, stop_pc);
@@ -2961,13 +2956,7 @@ infrun: BPSTAT_WHAT_SET_LONGJMP_RESUME (
       if (real_stop_pc != 0)
 	ecs->stop_func_start = real_stop_pc;
 
-      if (
-#ifdef IN_SOLIB_DYNSYM_RESOLVE_CODE
-	  IN_SOLIB_DYNSYM_RESOLVE_CODE (ecs->stop_func_start)
-#else
-	  in_solib_dynsym_resolve_code (ecs->stop_func_start)
-#endif
-)
+      if (real_stop_pc != 0 && in_solib_dynsym_resolve_code (real_stop_pc))
 	{
 	  struct symtab_and_line sr_sal;
 	  init_sal (&sr_sal);
Index: gdb/mips-linux-tdep.c
===================================================================
RCS file: /scratch/gcc/repos/src/src/gdb/mips-linux-tdep.c,v
retrieving revision 1.71
diff -u -p -r1.71 mips-linux-tdep.c
--- gdb/mips-linux-tdep.c	30 Apr 2008 21:25:16 -0000	1.71
+++ gdb/mips-linux-tdep.c	27 Jun 2008 14:28:26 -0000
@@ -37,6 +37,7 @@
 #include "symtab.h"
 #include "target-descriptions.h"
 #include "mips-linux-tdep.h"
+#include "glibc-tdep.h"
 
 static struct target_so_ops mips_svr4_so_ops;
 
@@ -666,13 +667,13 @@ mips_linux_in_dynsym_stub (CORE_ADDR pc,
 }
 
 /* Return non-zero iff PC belongs to the dynamic linker resolution
-   code or to a stub.  */
+   code, a PLT entry, or a lazy binding stub.  */
 
 static int
 mips_linux_in_dynsym_resolve_code (CORE_ADDR pc)
 {
   /* Check whether PC is in the dynamic linker.  This also checks
-     whether it is in the .plt section, which MIPS does not use.  */
+     whether it is in the .plt section, used by non-PIC executables.  */
   if (svr4_in_dynsym_resolve_code (pc))
     return 1;
 
@@ -688,8 +689,8 @@ mips_linux_in_dynsym_resolve_code (CORE_
    and glibc_skip_solib_resolver in glibc-tdep.c.  The normal glibc
    implementation of this triggers at "fixup" from the same objfile as
    "_dl_runtime_resolve"; MIPS GNU/Linux can trigger at
-   "__dl_runtime_resolve" directly.  An unresolved PLT entry will
-   point to _dl_runtime_resolve, which will first call
+   "__dl_runtime_resolve" directly.  An unresolved lazy binding
+   stub will point to _dl_runtime_resolve, which will first call
    __dl_runtime_resolve, and then pass control to the resolved
    function.  */
 
@@ -703,7 +704,7 @@ mips_linux_skip_resolver (struct gdbarch
   if (resolver && SYMBOL_VALUE_ADDRESS (resolver) == pc)
     return frame_pc_unwind (get_current_frame ());
 
-  return 0;
+  return glibc_skip_solib_resolver (gdbarch, pc);
 }
 
 /* Signal trampoline support.  There are four supported layouts for a
@@ -1151,7 +1152,6 @@ mips_linux_init_abi (struct gdbarch_info
 	break;
     }
 
-  set_gdbarch_skip_trampoline_code (gdbarch, find_solib_trampoline_target);
   set_gdbarch_skip_solib_resolver (gdbarch, mips_linux_skip_resolver);
 
   set_gdbarch_software_single_step (gdbarch, mips_software_single_step);
Index: gdb/mips-tdep.c
===================================================================
RCS file: /scratch/gcc/repos/src/src/gdb/mips-tdep.c,v
retrieving revision 1.475
diff -u -p -r1.475 mips-tdep.c
--- gdb/mips-tdep.c	3 Jun 2008 10:53:34 -0000	1.475
+++ gdb/mips-tdep.c	27 Jun 2008 14:29:07 -0000
@@ -1928,6 +1928,7 @@ mips32_scan_prologue (CORE_ADDR start_pc
   CORE_ADDR end_prologue_addr = 0;
   int seen_sp_adjust = 0;
   int load_immediate_bytes = 0;
+  int in_delay_slot = 0;
   struct gdbarch *gdbarch = get_frame_arch (this_frame);
   int regsize_is_64_bits = (mips_abi_regsize (gdbarch) == 8);
 
@@ -2085,7 +2086,18 @@ restart:
             instructions?  */
          if (end_prologue_addr == 0)
            end_prologue_addr = cur_pc;
+
+	 /* Check for branches and jumps.  For now, only jump to
+	    register are caught (i.e. returns).  */
+	 if ((itype_op (inst) & 0x07) == 0 && rtype_funct (inst) == 8)
+	   in_delay_slot = 1;
        }
+
+      /* If the previous instruction was a jump, we must have reached
+	 the end of the prologue by now.  Stop scanning so that we do
+	 not go past the function return.  */
+      if (in_delay_slot)
+	break;
     }
 
   if (this_cache != NULL)
@@ -2303,6 +2315,13 @@ mips_stub_frame_sniffer (const struct fr
 		 ".MIPS.stubs") == 0)
     return 1;
 
+  /* Calling a PIC function from a non-PIC function passes through a stub
+     section; binutils calls it ".MIPS.pic_stubs".  */
+  if (s != NULL
+      && strcmp (bfd_get_section_name (s->objfile->obfd, s->the_bfd_section),
+		 ".MIPS.pic_stubs") == 0)
+    return 1;
+
   return 0;
 }
 
@@ -5020,7 +5039,7 @@ mips_breakpoint_from_pc (struct gdbarch 
    gory details.  */
 
 static CORE_ADDR
-mips_skip_trampoline_code (struct frame_info *frame, CORE_ADDR pc)
+mips_skip_mips16_trampoline_code (struct frame_info *frame, CORE_ADDR pc)
 {
   char *name;
   CORE_ADDR start_addr;
@@ -5099,6 +5118,67 @@ mips_skip_trampoline_code (struct frame_
   return 0;			/* not a stub */
 }
 
+/* If the current PC is the start of a non-PIC-to-PIC stub, return the
+   PC of the stub target.  The stub just loads $t9 and jumps to it,
+   so that $t9 has the correct value at function entry.  */
+
+static CORE_ADDR
+mips_skip_pic_trampoline_code (struct frame_info *frame, CORE_ADDR pc)
+{
+  struct obj_section *s;
+  int i;
+  gdb_byte stub_code[16];
+  int32_t stub_words[4];
+
+  s = find_pc_section (pc);
+  if (s == NULL
+      || strcmp (bfd_get_section_name (s->objfile->obfd, s->the_bfd_section),
+		 ".MIPS.pic_stubs") != 0)
+    return 0;
+
+  if (target_read_memory (pc, stub_code, 16) != 0)
+    return 0;
+  for (i = 0; i < 4; i++)
+    stub_words[i] = extract_unsigned_integer (stub_code + i * 4, 4);
+
+  /* A stub contains these instructions:
+     lui	t9, %hi(target)
+     addiu	t9, t9, %lo(target)
+     jr		t9
+      nop
+
+      N64 stubs will require more instructions.  */
+  if ((stub_words[0] & 0xffff0000U) == 0x3c190000
+      && (stub_words[1] & 0xffff0000U) == 0x27390000
+      && stub_words[2] == 0x03200008
+      && stub_words[3] == 0x00000000)
+    return (((stub_words[0] & 0x0000ffff) << 16)
+	    + (stub_words[1] & 0x0000ffff));
+
+  /* Not a recognized stub.  */
+  return 0;
+}
+
+static CORE_ADDR
+mips_skip_trampoline_code (struct frame_info *frame, CORE_ADDR pc)
+{
+  CORE_ADDR target_pc;
+
+  target_pc = mips_skip_mips16_trampoline_code (frame, pc);
+  if (target_pc)
+    return target_pc;
+
+  target_pc = find_solib_trampoline_target (frame, pc);
+  if (target_pc)
+    return target_pc;
+
+  target_pc = mips_skip_pic_trampoline_code (frame, pc);
+  if (target_pc)
+    return target_pc;
+
+  return 0;
+}
+
 /* Convert a dbx stab register number (from `r' declaration) to a GDB
    [1 * gdbarch_num_regs .. 2 * gdbarch_num_regs) REGNUM.  */
 

--vtzGhvizbBRQ85DL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="glibc-longlong.patch"

2008-06-27  Daniel Jacobowitz  <dan@codesourcery.com>

	* longlong.h: Update from GCC.

Index: stdlib/longlong.h
===================================================================
RCS file: /cvs/glibc/libc/stdlib/longlong.h,v
retrieving revision 1.31
diff -u -p -r1.31 longlong.h
--- stdlib/longlong.h	15 May 2006 20:25:33 -0000	1.31
+++ stdlib/longlong.h	27 Jun 2008 13:05:23 -0000
@@ -229,6 +229,19 @@ UDItype __umulsidi3 (USItype, USItype);
 #define UDIV_TIME 100
 #endif /* __arm__ */
 
+#if defined(__arm__)
+/* Let gcc decide how best to implement count_leading_zeros.  */
+#define count_leading_zeros(COUNT,X)	((COUNT) = __builtin_clz (X))
+#define COUNT_LEADING_ZEROS_0 32
+#endif
+
+#if defined (__CRIS__) && __CRIS_arch_version >= 3
+#define count_leading_zeros(COUNT, X) ((COUNT) = __builtin_clz (X))
+#if __CRIS_arch_version >= 8
+#define count_trailing_zeros(COUNT, X) ((COUNT) = __builtin_ctz (X))
+#endif
+#endif /* __CRIS__ */
+
 #if defined (__hppa) && W_TYPE_SIZE == 32
 #define add_ssaaaa(sh, sl, ah, al, bh, bl) \
   __asm__ ("add %4,%5,%1\n\taddc %2,%3,%0"				\
@@ -315,7 +328,7 @@ UDItype __umulsidi3 (USItype, USItype);
 
 #if (defined (__i386__) || defined (__i486__)) && W_TYPE_SIZE == 32
 #define add_ssaaaa(sh, sl, ah, al, bh, bl) \
-  __asm__ ("addl %5,%1\n\tadcl %3,%0"					\
+  __asm__ ("add{l} {%5,%1|%1,%5}\n\tadc{l} {%3,%0|%0,%3}"		\
 	   : "=r" ((USItype) (sh)),					\
 	     "=&r" ((USItype) (sl))					\
 	   : "%0" ((USItype) (ah)),					\
@@ -323,7 +336,7 @@ UDItype __umulsidi3 (USItype, USItype);
 	     "%1" ((USItype) (al)),					\
 	     "g" ((USItype) (bl)))
 #define sub_ddmmss(sh, sl, ah, al, bh, bl) \
-  __asm__ ("subl %5,%1\n\tsbbl %3,%0"					\
+  __asm__ ("sub{l} {%5,%1|%1,%5}\n\tsbb{l} {%3,%0|%0,%3}"		\
 	   : "=r" ((USItype) (sh)),					\
 	     "=&r" ((USItype) (sl))					\
 	   : "0" ((USItype) (ah)),					\
@@ -331,31 +344,60 @@ UDItype __umulsidi3 (USItype, USItype);
 	     "1" ((USItype) (al)),					\
 	     "g" ((USItype) (bl)))
 #define umul_ppmm(w1, w0, u, v) \
-  __asm__ ("mull %3"							\
+  __asm__ ("mul{l} %3"							\
 	   : "=a" ((USItype) (w0)),					\
 	     "=d" ((USItype) (w1))					\
 	   : "%0" ((USItype) (u)),					\
 	     "rm" ((USItype) (v)))
 #define udiv_qrnnd(q, r, n1, n0, dv) \
-  __asm__ ("divl %4"							\
+  __asm__ ("div{l} %4"							\
 	   : "=a" ((USItype) (q)),					\
 	     "=d" ((USItype) (r))					\
 	   : "0" ((USItype) (n0)),					\
 	     "1" ((USItype) (n1)),					\
 	     "rm" ((USItype) (dv)))
-#define count_leading_zeros(count, x) \
-  do {									\
-    USItype __cbtmp;							\
-    __asm__ ("bsrl %1,%0"						\
-	     : "=r" (__cbtmp) : "rm" ((USItype) (x)));			\
-    (count) = __cbtmp ^ 31;						\
-  } while (0)
-#define count_trailing_zeros(count, x) \
-  __asm__ ("bsfl %1,%0" : "=r" (count) : "rm" ((USItype)(x)))
+#define count_leading_zeros(count, x)	((count) = __builtin_clz (x))
+#define count_trailing_zeros(count, x)	((count) = __builtin_ctz (x))
 #define UMUL_TIME 40
 #define UDIV_TIME 40
 #endif /* 80x86 */
 
+#if (defined (__x86_64__) || defined (__i386__)) && W_TYPE_SIZE == 64
+#define add_ssaaaa(sh, sl, ah, al, bh, bl) \
+  __asm__ ("add{q} {%5,%1|%1,%5}\n\tadc{q} {%3,%0|%0,%3}"		\
+	   : "=r" ((UDItype) (sh)),					\
+	     "=&r" ((UDItype) (sl))					\
+	   : "%0" ((UDItype) (ah)),					\
+	     "rme" ((UDItype) (bh)),					\
+	     "%1" ((UDItype) (al)),					\
+	     "rme" ((UDItype) (bl)))
+#define sub_ddmmss(sh, sl, ah, al, bh, bl) \
+  __asm__ ("sub{q} {%5,%1|%1,%5}\n\tsbb{q} {%3,%0|%0,%3}"		\
+	   : "=r" ((UDItype) (sh)),					\
+	     "=&r" ((UDItype) (sl))					\
+	   : "0" ((UDItype) (ah)),					\
+	     "rme" ((UDItype) (bh)),					\
+	     "1" ((UDItype) (al)),					\
+	     "rme" ((UDItype) (bl)))
+#define umul_ppmm(w1, w0, u, v) \
+  __asm__ ("mul{q} %3"							\
+	   : "=a" ((UDItype) (w0)),					\
+	     "=d" ((UDItype) (w1))					\
+	   : "%0" ((UDItype) (u)),					\
+	     "rm" ((UDItype) (v)))
+#define udiv_qrnnd(q, r, n1, n0, dv) \
+  __asm__ ("div{q} %4"							\
+	   : "=a" ((UDItype) (q)),					\
+	     "=d" ((UDItype) (r))					\
+	   : "0" ((UDItype) (n0)),					\
+	     "1" ((UDItype) (n1)),					\
+	     "rm" ((UDItype) (dv)))
+#define count_leading_zeros(count, x)	((count) = __builtin_clzl (x))
+#define count_trailing_zeros(count, x)	((count) = __builtin_ctzl (x))
+#define UMUL_TIME 40
+#define UDIV_TIME 40
+#endif /* x86_64 */
+
 #if defined (__i960__) && W_TYPE_SIZE == 32
 #define umul_ppmm(w1, w0, u, v) \
   ({union {UDItype __ll;						\
@@ -523,6 +565,11 @@ UDItype __umulsidi3 (USItype, USItype);
   __asm__ ("bfffo %1{%b2:%b2},%0"					\
 	   : "=d" ((USItype) (count))					\
 	   : "od" ((USItype) (x)), "n" (0))
+/* Some ColdFire architectures have a ff1 instruction supported via
+   __builtin_clz. */
+#elif defined (__mcfisaaplus__) || defined (__mcfisac__)
+#define count_leading_zeros(count,x) ((count) = __builtin_clz (x))
+#define COUNT_LEADING_ZEROS_0 32
 #endif
 #endif /* mc68000 */
 
@@ -585,14 +632,19 @@ UDItype __umulsidi3 (USItype, USItype);
 #endif /* __m88000__ */
 
 #if defined (__mips__) && W_TYPE_SIZE == 32
-#define umul_ppmm(w1, w0, u, v) \
-  __asm__ ("multu %2,%3"						\
-	   : "=l" ((USItype) (w0)),					\
-	     "=h" ((USItype) (w1))					\
-	   : "d" ((USItype) (u)),					\
-	     "d" ((USItype) (v)))
+#define umul_ppmm(w1, w0, u, v)						\
+  do {									\
+    UDItype __x = (UDItype) (USItype) (u) * (USItype) (v);		\
+    (w1) = (USItype) (__x >> 32);					\
+    (w0) = (USItype) (__x);						\
+  } while (0)
 #define UMUL_TIME 10
 #define UDIV_TIME 100
+
+#if (__mips == 32 || __mips == 64) && ! __mips16
+#define count_leading_zeros(COUNT,X)	((COUNT) = __builtin_clz (X))
+#define COUNT_LEADING_ZEROS_0 32
+#endif
 #endif /* __mips__ */
 
 #if defined (__ns32000__) && W_TYPE_SIZE == 32
@@ -641,7 +693,9 @@ UDItype __umulsidi3 (USItype, USItype);
      || defined (__powerpc__)	/* gcc */				\
      || defined (__POWERPC__)	/* BEOS */				\
      || defined (__ppc__)	/* Darwin */				\
-     || defined (PPC)		/* GNU/Linux, SysV */			\
+     || (defined (PPC) && ! defined (CPU_FAMILY)) /* gcc 2.7.x GNU&SysV */    \
+     || (defined (PPC) && defined (CPU_FAMILY)    /* VxWorks */               \
+         && CPU_FAMILY == PPC)                                                \
      ) && W_TYPE_SIZE == 32
 #define add_ssaaaa(sh, sl, ah, al, bh, bl) \
   do {									\
@@ -679,7 +733,10 @@ UDItype __umulsidi3 (USItype, USItype);
   __asm__ ("{cntlz|cntlzw} %0,%1" : "=r" (count) : "r" (x))
 #define COUNT_LEADING_ZEROS_0 32
 #if defined (_ARCH_PPC) || defined (__powerpc__) || defined (__POWERPC__) \
-  || defined (__ppc__) || defined (PPC)
+  || defined (__ppc__)                                                    \
+  || (defined (PPC) && ! defined (CPU_FAMILY)) /* gcc 2.7.x GNU&SysV */       \
+  || (defined (PPC) && defined (CPU_FAMILY)    /* VxWorks */                  \
+         && CPU_FAMILY == PPC)
 #define umul_ppmm(ph, pl, m0, m1) \
   do {									\
     USItype __m0 = (m0), __m1 = (m1);					\
@@ -828,18 +885,51 @@ UDItype __umulsidi3 (USItype, USItype);
   } while (0)
 #endif
 
-#if defined (__sh2__) && W_TYPE_SIZE == 32
+#if defined(__sh__) && !__SHMEDIA__ && W_TYPE_SIZE == 32
+#ifndef __sh1__
 #define umul_ppmm(w1, w0, u, v) \
   __asm__ (								\
-       "dmulu.l	%2,%3\n\tsts	macl,%1\n\tsts	mach,%0"		\
-	   : "=r" ((USItype)(w1)),					\
-	     "=r" ((USItype)(w0))					\
+       "dmulu.l	%2,%3\n\tsts%M1	macl,%1\n\tsts%M0	mach,%0"	\
+	   : "=r<" ((USItype)(w1)),					\
+	     "=r<" ((USItype)(w0))					\
 	   : "r" ((USItype)(u)),					\
 	     "r" ((USItype)(v))						\
 	   : "macl", "mach")
 #define UMUL_TIME 5
 #endif
 
+/* This is the same algorithm as __udiv_qrnnd_c.  */
+#define UDIV_NEEDS_NORMALIZATION 1
+
+#define udiv_qrnnd(q, r, n1, n0, d) \
+  do {									\
+    extern UWtype __udiv_qrnnd_16 (UWtype, UWtype)			\
+                        __attribute__ ((visibility ("hidden")));	\
+    /* r0: rn r1: qn */ /* r0: n1 r4: n0 r5: d r6: d1 */ /* r2: __m */	\
+    __asm__ (								\
+	"mov%M4 %4,r5\n"						\
+"	swap.w %3,r4\n"							\
+"	swap.w r5,r6\n"							\
+"	jsr @%5\n"							\
+"	shll16 r6\n"							\
+"	swap.w r4,r4\n"							\
+"	jsr @%5\n"							\
+"	swap.w r1,%0\n"							\
+"	or r1,%0"							\
+	: "=r" (q), "=&z" (r)						\
+	: "1" (n1), "r" (n0), "rm" (d), "r" (&__udiv_qrnnd_16)		\
+	: "r1", "r2", "r4", "r5", "r6", "pr");				\
+  } while (0)
+
+#define UDIV_TIME 80
+
+#define sub_ddmmss(sh, sl, ah, al, bh, bl)				\
+  __asm__ ("clrt;subc %5,%1; subc %4,%0"				\
+	   : "=r" (sh), "=r" (sl)					\
+	   : "0" (ah), "1" (al), "r" (bh), "r" (bl))
+
+#endif /* __sh__ */
+
 #if defined (__SH5__) && __SHMEDIA__ && W_TYPE_SIZE == 32
 #define __umulsidi3(u,v) ((UDItype)(USItype)u*(USItype)v)
 #define count_leading_zeros(count, x) \
@@ -1153,6 +1243,23 @@ UDItype __umulsidi3 (USItype, USItype);
   } while (0)
 #endif /* __vax__ */
 
+#if defined (__xtensa__) && W_TYPE_SIZE == 32
+/* This code is not Xtensa-configuration-specific, so rely on the compiler
+   to expand builtin functions depending on what configuration features
+   are available.  This avoids library calls when the operation can be
+   performed in-line.  */
+#define umul_ppmm(w1, w0, u, v)						\
+  do {									\
+    DWunion __w;							\
+    __w.ll = __builtin_umulsidi3 (u, v);				\
+    w1 = __w.s.high;							\
+    w0 = __w.s.low;							\
+  } while (0)
+#define __umulsidi3(u, v)		__builtin_umulsidi3 (u, v)
+#define count_leading_zeros(COUNT, X)	((COUNT) = __builtin_clz (X))
+#define count_trailing_zeros(COUNT, X)	((COUNT) = __builtin_ctz (X))
+#endif /* __xtensa__ */
+
 #if defined (__z8000__) && W_TYPE_SIZE == 16
 #define add_ssaaaa(sh, sl, ah, al, bh, bl) \
   __asm__ ("add	%H1,%H5\n\tadc	%H0,%H3"				\

--vtzGhvizbBRQ85DL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="glibc-ports-nonpic.patch"

2008-03-28  Mark Shinwell  <shinwell@codesourcery.com>
	    Daniel Jacobowitz  <dan@codesourcery.com>

	* sysdeps/mips/dl-lookup.c: New.
	* sysdeps/mips/do-lookup.h: New.
	* sysdeps/mips/dl-machine.h (ELF_MACHINE_NO_PLT): Remove
	definition.
	(ELF_MACHINE_JMP_SLOT): Alter definition and update comment.
	(elf_machine_type_class): Likewise.
	(ELF_MACHINE_PLT_REL): Define.
	(elf_machine_fixup_plt): New.
	(elf_machine_plt_value): New.
	(elf_machine_reloc): Handle jump slot and copy relocations.
	(elf_machine_lazy_rel): Point relocation place at PLT if
	required.
	(elf_machine_runtime_setup): Fill in .got.plt header.
	* sysdeps/mips/dl-trampoline.c: New.
	* sysdeps/mips/bits/linkmap.h (link_map_machine): New.
	* sysdeps/mips/tls-macros.h: Load $gp as required.

	* sysdeps/unix/sysv/linux/mips/mips32/sysdep.h (SYSCALL_ERROR_LABEL):
	Delete definition.
	* sysdeps/unix/sysv/linux/mips/nptl/sysdep-cancel.h (PSEUDO_CPLOAD,
	PSEUDO_ERRJMP, PSEUDO_SAVEGP, PSEUDO_LOADGP): Define.
	(PSEUDO): Use them.  Move outside __PIC__.
	(PSEUDO_JMP): New.
	(CENABLE, CDISABLE): Use it.

Index: sysdeps/unix/sysv/linux/mips/mips32/sysdep.h
===================================================================
--- sysdeps/unix/sysv/linux/mips/mips32/sysdep.h	(revision 213009)
+++ sysdeps/unix/sysv/linux/mips/mips32/sysdep.h	(working copy)
@@ -35,15 +35,7 @@
 # define SYS_ify(syscall_name)	__NR_/**/syscall_name
 #endif
 
-#ifdef __ASSEMBLER__
-
-/* We don't want the label for the error handler to be visible in the symbol
-   table when we define it here.  */
-#ifdef __PIC__
-# define SYSCALL_ERROR_LABEL 99b
-#endif
-
-#else   /* ! __ASSEMBLER__ */
+#ifndef __ASSEMBLER__
 
 /* Define a macro which expands into the inline wrapper code for a system
    call.  */
Index: sysdeps/unix/sysv/linux/mips/nptl/sysdep-cancel.h
===================================================================
--- sysdeps/unix/sysv/linux/mips/nptl/sysdep-cancel.h	(revision 213009)
+++ sysdeps/unix/sysv/linux/mips/nptl/sysdep-cancel.h	(working copy)
@@ -25,28 +25,38 @@
 
 #if !defined NOT_IN_libc || defined IS_IN_libpthread || defined IS_IN_librt
 
-#ifdef __PIC__
+# ifdef __PIC__
+#  define PSEUDO_CPLOAD .cpload t9;
+#  define PSEUDO_ERRJMP la t9, __syscall_error; jr t9;
+#  define PSEUDO_SAVEGP sw gp, 32(sp); cfi_rel_offset (gp, 32);
+#  define PSEUDO_LOADGP lw gp, 32(sp);
+# else
+#  define PSEUDO_CPLOAD
+#  define PSEUDO_ERRJMP j __syscall_error;
+#  define PSEUDO_SAVEGP
+#  define PSEUDO_LOADGP
+# endif
+
 # undef PSEUDO
 # define PSEUDO(name, syscall_name, args)				      \
       .align 2;								      \
   L(pseudo_start):							      \
       cfi_startproc;							      \
-  99: la t9,__syscall_error;						      \
-      jr t9;								      \
+  99: PSEUDO_ERRJMP							      \
   .type __##syscall_name##_nocancel, @function;				      \
   .globl __##syscall_name##_nocancel;					      \
   __##syscall_name##_nocancel:						      \
     .set noreorder;							      \
-    .cpload t9;								      \
+    PSEUDO_CPLOAD							      \
     li v0, SYS_ify(syscall_name);					      \
     syscall;								      \
     .set reorder;							      \
-    bne a3, zero, SYSCALL_ERROR_LABEL;			       		      \
+    bne a3, zero, 99b;					       		      \
     ret;								      \
   .size __##syscall_name##_nocancel,.-__##syscall_name##_nocancel;	      \
   ENTRY (name)								      \
     .set noreorder;							      \
-    .cpload t9;								      \
+    PSEUDO_CPLOAD							      \
     .set reorder;							      \
     SINGLE_THREAD_P(v1);						      \
     bne zero, v1, L(pseudo_cancel);					      \
@@ -54,17 +64,16 @@
     li v0, SYS_ify(syscall_name);					      \
     syscall;								      \
     .set reorder;							      \
-    bne a3, zero, SYSCALL_ERROR_LABEL;			       		      \
+    bne a3, zero, 99b;					       		      \
     ret;								      \
   L(pseudo_cancel):							      \
     SAVESTK_##args;						              \
     sw ra, 28(sp);							      \
     cfi_rel_offset (ra, 28);						      \
-    sw gp, 32(sp);							      \
-    cfi_rel_offset (gp, 32);						      \
+    PSEUDO_SAVEGP							      \
     PUSHARGS_##args;			/* save syscall args */	      	      \
     CENABLE;								      \
-    lw gp, 32(sp);							      \
+    PSEUDO_LOADGP							      \
     sw v0, 44(sp);			/* save mask */			      \
     POPARGS_##args;			/* restore syscall args */	      \
     .set noreorder;							      \
@@ -75,12 +84,12 @@
     sw a3, 40(sp);			/* save syscall error flag */	      \
     lw a0, 44(sp);			/* pass mask as arg1 */		      \
     CDISABLE;								      \
-    lw gp, 32(sp);							      \
+    PSEUDO_LOADGP							      \
     lw v0, 36(sp);			/* restore syscall result */          \
     lw a3, 40(sp);			/* restore syscall error flag */      \
     lw ra, 28(sp);			/* restore return address */	      \
     .set noreorder;							      \
-    bne a3, zero, SYSCALL_ERROR_LABEL;					      \
+    bne a3, zero, 99b;							      \
      RESTORESTK;						              \
   L(pseudo_end):							      \
     .set reorder;
@@ -88,8 +97,6 @@
 # undef PSEUDO_END
 # define PSEUDO_END(sym) cfi_endproc; .end sym; .size sym,.-sym
 
-#endif
-
 # define PUSHARGS_0	/* nothing to do */
 # define PUSHARGS_1	PUSHARGS_0 sw a0, 0(sp); cfi_rel_offset (a0, 0);
 # define PUSHARGS_2	PUSHARGS_1 sw a1, 4(sp); cfi_rel_offset (a1, 4);
@@ -136,19 +143,25 @@
 # define RESTORESTK 	addu sp, STKSPACE; cfi_adjust_cfa_offset(-STKSPACE)
 
 
+# ifdef __PIC__
 /* We use jalr rather than jal.  This means that the assembler will not
    automatically restore $gp (in case libc has multiple GOTs) so we must
    do it manually - which we have to do anyway since we don't use .cprestore.
    It also shuts up the assembler warning about not using .cprestore.  */
+#  define PSEUDO_JMP(sym) la t9, sym; jalr t9;
+# else
+#  define PSEUDO_JMP(sym) jal sym;
+# endif
+
 # ifdef IS_IN_libpthread
-#  define CENABLE	la t9, __pthread_enable_asynccancel; jalr t9;
-#  define CDISABLE	la t9, __pthread_disable_asynccancel; jalr t9;
+#  define CENABLE	PSEUDO_JMP (__pthread_enable_asynccancel)
+#  define CDISABLE	PSEUDO_JMP (__pthread_disable_asynccancel)
 # elif defined IS_IN_librt
-#  define CENABLE	la t9, __librt_enable_asynccancel; jalr t9;
-#  define CDISABLE	la t9, __librt_disable_asynccancel; jalr t9;
+#  define CENABLE	PSEUDO_JMP (__librt_enable_asynccancel)
+#  define CDISABLE	PSEUDO_JMP (__librt_disable_asynccancel)
 # else
-#  define CENABLE	la t9, __libc_enable_asynccancel; jalr t9;
-#  define CDISABLE	la t9, __libc_disable_asynccancel; jalr t9;
+#  define CENABLE	PSEUDO_JMP (__libc_enable_asynccancel)
+#  define CDISABLE	PSEUDO_JMP (__libc_disable_asynccancel)
 # endif
 
 # ifndef __ASSEMBLER__
Index: sysdeps/mips/do-lookup.h
===================================================================
--- sysdeps/mips/do-lookup.h	(revision 0)
+++ sysdeps/mips/do-lookup.h	(revision 0)
@@ -0,0 +1,37 @@
+/* MIPS-specific veneer to GLIBC's do-lookup.h.
+   Copyright (C) 2008 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+/* The semantics of zero/non-zero values of undefined symbols differs
+   depending on whether the non-PIC ABI is in use.  Under the non-PIC ABI,
+   a non-zero value indicates that there is an address reference to the
+   symbol and thus it must always be resolved (except when resolving a jump
+   slot relocation) to the PLT entry whose address is provided as the
+   symbol's value; a zero value indicates that this canonical-address
+   behaviour is not required.  Yet under the classic MIPS psABI, a zero value
+   indicates that there is an address reference to the function and the
+   dynamic linker must resolve the symbol immediately upon loading.  To
+   avoid conflict, symbols for which the dynamic linker must assume the
+   non-PIC ABI semantics are marked with the STO_MIPS_PLT flag.  The
+   following ugly hack causes the code in the platform-independent
+   do-lookup.h file to check this flag correctly.  */
+#define st_value st_shndx == SHN_UNDEF && !(sym->st_other & STO_MIPS_PLT)) \
+		 || (sym->st_value
+#include_next "do-lookup.h"
+#undef st_value
+
Index: sysdeps/mips/tls-macros.h
===================================================================
--- sysdeps/mips/tls-macros.h	(revision 213009)
+++ sysdeps/mips/tls-macros.h	(working copy)
@@ -4,27 +4,27 @@
 
 /* These versions are for o32 and n32.  */
 
-# define TLS_GD(x)					\
-  ({ void *__result;					\
-     extern void *__tls_get_addr (void *);		\
-     asm ("addiu %0, $28, %%tlsgd(" #x ")"		\
-	  : "=r" (__result));				\
-     (int *)__tls_get_addr (__result); })
+#ifndef __PIC__
+# define LOAD_GP "move %[tmp], $28\n\tla $28, __gnu_local_gp\n\t"
+# define UNLOAD_GP "\n\tmove $28, %[tmp]"
 #else
+# define LOAD_GP
+# define UNLOAD_GP
+#endif
+
 # define TLS_GD(x)					\
-  ({ void *__result;					\
+  ({ void *__result, *__tmp;				\
      extern void *__tls_get_addr (void *);		\
-     asm ("daddiu %0, $28, %%tlsgd(" #x ")"		\
-	  : "=r" (__result));				\
+     asm (LOAD_GP "addiu %0, $28, %%tlsgd(" #x ")"	\
+	  UNLOAD_GP					\
+	  : "=r" (__result), [tmp] "=&r" (__tmp));	\
      (int *)__tls_get_addr (__result); })
-#endif
-
-#if _MIPS_SIM != _ABI64
 # define TLS_LD(x)					\
-  ({ void *__result;					\
+  ({ void *__result, *__tmp;				\
      extern void *__tls_get_addr (void *);		\
-     asm ("addiu %0, $28, %%tlsldm(" #x ")"		\
-	  : "=r" (__result));				\
+     asm (LOAD_GP "addiu %0, $28, %%tlsldm(" #x ")"	\
+	  UNLOAD_GP					\
+	  : "=r" (__result), [tmp] "=&r" (__tmp));	\
      __result = __tls_get_addr (__result);		\
      asm ("lui $3,%%dtprel_hi(" #x ")\n\t"		\
 	  "addiu $3,$3,%%dtprel_lo(" #x ")\n\t"		\
@@ -32,13 +32,15 @@
 	  : "+r" (__result) : : "$3");			\
      __result; })
 # define TLS_IE(x)					\
-  ({ void *__result;					\
+  ({ void *__result, *__tmp;				\
      asm (".set push\n\t.set mips32r2\n\t"		\
 	  "rdhwr\t%0,$29\n\t.set pop"			\
 	  : "=v" (__result));				\
-     asm ("lw $3,%%gottprel(" #x ")($28)\n\t"		\
+     asm (LOAD_GP "lw $3,%%gottprel(" #x ")($28)\n\t"	\
 	  "addu %0,%0,$3"				\
-	  : "+r" (__result) : : "$3");			\
+	  UNLOAD_GP					\
+	  : "+r" (__result), [tmp] "=&r" (__tmp)	\
+	  : : "$3");					\
      __result; })
 # define TLS_LE(x)					\
   ({ void *__result;					\
@@ -55,6 +57,12 @@
 
 /* These versions are for n64.  */
 
+# define TLS_GD(x)					\
+  ({ void *__result;					\
+     extern void *__tls_get_addr (void *);		\
+     asm ("daddiu %0, $28, %%tlsgd(" #x ")"		\
+	  : "=r" (__result));				\
+     (int *)__tls_get_addr (__result); })
 # define TLS_LD(x)					\
   ({ void *__result;					\
      extern void *__tls_get_addr (void *);		\
Index: sysdeps/mips/dl-machine.h
===================================================================
--- sysdeps/mips/dl-machine.h	(revision 213009)
+++ sysdeps/mips/dl-machine.h	(working copy)
@@ -25,8 +25,6 @@
 
 #define ELF_MACHINE_NAME "MIPS"
 
-#define ELF_MACHINE_NO_PLT
-
 #include <entry.h>
 
 #ifndef ENTRY_POINT
@@ -56,10 +54,15 @@
 #endif
 
 /* A reloc type used for ld.so cmdline arg lookups to reject PLT entries.
-   This makes no sense on MIPS but we have to define this to R_MIPS_REL32
-   to avoid the asserts in dl-lookup.c from blowing.  */
-#define ELF_MACHINE_JMP_SLOT			R_MIPS_REL32
-#define elf_machine_type_class(type)		ELF_RTYPE_CLASS_PLT
+   This makes no sense on MIPS unless using the non-PIC ABI but we have
+   to define this to avoid the asserts in dl-lookup.c from blowing.
+   We choose the value that makes sense for the non-PIC ABI.  */
+#define ELF_MACHINE_JMP_SLOT			R_MIPS_JUMP_SLOT
+#define elf_machine_type_class(type) \
+  ((((type) == ELF_MACHINE_JMP_SLOT) * ELF_RTYPE_CLASS_PLT)	\
+   | (((type) == R_MIPS_COPY) * ELF_RTYPE_CLASS_COPY))
+
+#define ELF_MACHINE_PLT_REL 1
 
 /* Translate a processor specific dynamic tag to the index
    in l_info array.  */
@@ -73,6 +76,14 @@ do { if ((l)->l_info[DT_MIPS (RLD_MAP)])
        (ElfW(Addr)) (r); \
    } while (0)
 
+/* Allow ABIVERSION == 1, meaning non-PIC abicalls.  */
+#define VALID_ELF_ABIVERSION(ver)	(ver == 0 || ver == 2)
+#define VALID_ELF_OSABI(osabi)		(osabi == ELFOSABI_SYSV)
+#define VALID_ELF_HEADER(hdr,exp,size) \
+  memcmp (hdr,exp,size-2) == 0 \
+  && VALID_ELF_OSABI (hdr[EI_OSABI]) \
+  && VALID_ELF_ABIVERSION (hdr[EI_ABIVERSION])
+
 /* Return nonzero iff ELF header is compatible with the running host.  */
 static inline int __attribute_used__
 elf_machine_matches_host (const ElfW(Ehdr) *ehdr)
@@ -294,6 +305,24 @@ do {									\
 #  define ARCH_LA_PLTEXIT mips_n64_gnu_pltexit
 # endif
 
+/* For a non-writable PLT, rewrite the .got.plt entry at RELOC_ADDR to
+   point at the symbol with address VALUE.  For a writable PLT, rewrite
+   the corresponding PLT entry instead.  */
+static inline Elf32_Addr
+elf_machine_fixup_plt (struct link_map *map, lookup_t t,
+		       const Elf32_Rel *reloc,
+		       Elf32_Addr *reloc_addr, Elf32_Addr value)
+{
+  return *reloc_addr = value;
+}
+
+static inline Elf32_Addr
+elf_machine_plt_value (struct link_map *map, const Elf32_Rel *reloc,
+		       Elf32_Addr value)
+{
+  return value;
+}
+
 #endif /* !dl_machine_h */
 
 #ifdef RESOLVE_MAP
@@ -461,6 +490,60 @@ elf_machine_reloc (struct link_map *map,
 #endif
     case R_MIPS_NONE:		/* Alright, Wilbur.  */
       break;
+
+    case R_MIPS_JUMP_SLOT:
+      {
+	/* Handle a jump slot relocation (only for the non-PIC ABI).  */
+
+	struct link_map *sym_map;
+	Elf32_Addr value;
+
+	/* The addend for a jump slot relocation must always be zero:
+	   calls via the PLT always branch to the symbol's address and
+	   not to the address plus a non-zero offset.  */
+	if (r_addend != 0)
+	  _dl_signal_error (0, map->l_name, NULL,
+			    "found jump slot relocation with non-zero addend");
+
+	sym_map = RESOLVE_MAP (&sym, version, r_type);
+	value = sym_map == NULL ? 0 : sym_map->l_addr + sym->st_value;
+	*addr_field = value;
+
+	break;
+      }
+
+    case R_MIPS_COPY:
+      {
+	/* Handle a copy relocation (only for the non-PIC ABI).  */
+
+	const Elf32_Sym *const refsym = sym;
+	struct link_map *sym_map;
+	Elf32_Addr value;
+
+	/* Calculate the address of the symbol.  */
+	sym_map = RESOLVE_MAP (&sym, version, r_type);
+	value = sym_map == NULL ? 0 : sym_map->l_addr + sym->st_value;
+
+	if (sym == NULL)
+	  /* This can happen in trace mode if an object could not be
+	     found.  */
+	  break;
+	if (sym->st_size > refsym->st_size
+	    || (GLRO(dl_verbose) && sym->st_size < refsym->st_size))
+	  {
+	    const char *strtab;
+
+	    strtab = (const void *) D_PTR (map, l_info[DT_STRTAB]);
+	    _dl_error_printf ("\
+  %s: Symbol `%s' has different size in shared object, consider re-linking\n",
+			      rtld_progname ?: "<program name unknown>",
+			      strtab + refsym->st_name);
+	  }
+	memcpy (reloc_addr, (void *) value,
+	        MIN (sym->st_size, refsym->st_size));
+	break;
+      }
+
 #if _MIPS_SIM == _ABI64
     case R_MIPS_64:
       /* For full compliance with the ELF64 ABI, one must precede the
@@ -505,9 +588,23 @@ elf_machine_rel_relative (ElfW(Addr) l_a
 auto inline void
 __attribute__((always_inline))
 elf_machine_lazy_rel (struct link_map *map,
-		      ElfW(Addr) l_addr, const ElfW(Rela) *reloc)
+		      ElfW(Addr) l_addr, const ElfW(Rel) *reloc)
 {
-  /* Do nothing.  */
+  Elf32_Addr *const reloc_addr = (void *) (l_addr + reloc->r_offset);
+  const unsigned int r_type = ELF32_R_TYPE (reloc->r_info);
+  /* Check for unexpected PLT reloc type.  */
+  if (__builtin_expect (r_type == R_MIPS_JUMP_SLOT, 1))
+    {
+      if (__builtin_expect (map->l_mach.plt, 0) == 0)
+	{
+	  /* Nothing is required here since we only support lazy
+	     relocation in executables.  */
+	}
+      else
+	*reloc_addr = map->l_mach.plt;
+    }
+  else
+    _dl_reloc_bad_type (map, r_type, 1);
 }
 
 auto inline void
@@ -650,6 +747,22 @@ elf_machine_runtime_setup (struct link_m
   /* Relocate global offset table.  */
   elf_machine_got_rel (l, lazy);
 
+  /* If using the non-PIC ABI, fill in the first two entries of
+     .got.plt.  */
+  if (l->l_info[DT_JMPREL] && lazy)
+    {
+      extern void _dl_runtime_pltresolve (void);
+      Elf32_Addr *gotplt;
+      gotplt = (Elf32_Addr *) D_PTR (l, l_info[DT_MIPS (PLTGOT)]);
+      /* If a library is prelinked but we have to relocate anyway,
+	 we have to be able to undo the prelinking of .got.plt.
+	 The prelinker saved the address of .plt for us here.  */
+      if (gotplt[1])
+	l->l_mach.plt = gotplt[1] + l->l_addr;
+      gotplt[0] = (Elf32_Addr) &_dl_runtime_pltresolve;
+      gotplt[1] = (Elf32_Addr) l;
+    }
+
 # endif
   return lazy;
 }
Index: sysdeps/mips/dl-lookup.c
===================================================================
--- sysdeps/mips/dl-lookup.c	(revision 0)
+++ sysdeps/mips/dl-lookup.c	(revision 0)
@@ -0,0 +1,581 @@
+/* Look up a symbol in the loaded objects.
+   MIPS/Linux version - this is identical to the common version, but
+   because it is in sysdeps/mips, it gets sysdeps/mips/do-lookup.h.
+   Using <do-lookup.h> instead of "do-lookup.h" would work too.
+
+   Copyright (C) 1995-2005, 2006, 2007 Free Software Foundation, Inc.
+   This file is part of the GNU C Library.
+
+   The GNU C Library is free software; you can redistribute it and/or
+   modify it under the terms of the GNU Lesser General Public
+   License as published by the Free Software Foundation; either
+   version 2.1 of the License, or (at your option) any later version.
+
+   The GNU C Library is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
+   Lesser General Public License for more details.
+
+   You should have received a copy of the GNU Lesser General Public
+   License along with the GNU C Library; if not, write to the Free
+   Software Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA
+   02111-1307 USA.  */
+
+#include <alloca.h>
+#include <libintl.h>
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <ldsodefs.h>
+#include <dl-hash.h>
+#include <dl-machine.h>
+#include <sysdep-cancel.h>
+#include <bits/libc-lock.h>
+#include <tls.h>
+
+#include <assert.h>
+
+#define VERSTAG(tag)	(DT_NUM + DT_THISPROCNUM + DT_VERSIONTAGIDX (tag))
+
+/* We need this string more than once.  */
+static const char undefined_msg[] = "undefined symbol: ";
+
+
+struct sym_val
+  {
+    const ElfW(Sym) *s;
+    struct link_map *m;
+  };
+
+
+#define make_string(string, rest...) \
+  ({									      \
+    const char *all[] = { string, ## rest };				      \
+    size_t len, cnt;							      \
+    char *result, *cp;							      \
+									      \
+    len = 1;								      \
+    for (cnt = 0; cnt < sizeof (all) / sizeof (all[0]); ++cnt)		      \
+      len += strlen (all[cnt]);						      \
+									      \
+    cp = result = alloca (len);						      \
+    for (cnt = 0; cnt < sizeof (all) / sizeof (all[0]); ++cnt)		      \
+      cp = __stpcpy (cp, all[cnt]);					      \
+									      \
+    result;								      \
+  })
+
+/* Statistics function.  */
+#ifdef SHARED
+# define bump_num_relocations() ++GL(dl_num_relocations)
+#else
+# define bump_num_relocations() ((void) 0)
+#endif
+
+
+/* The actual lookup code.  */
+#include "do-lookup.h"
+
+
+static uint_fast32_t
+dl_new_hash (const char *s)
+{
+  uint_fast32_t h = 5381;
+  for (unsigned char c = *s; c != '\0'; c = *++s)
+    h = h * 33 + c;
+  return h & 0xffffffff;
+}
+
+
+/* Add extra dependency on MAP to UNDEF_MAP.  */
+static int
+internal_function
+add_dependency (struct link_map *undef_map, struct link_map *map, int flags)
+{
+  struct link_map *runp;
+  unsigned int i;
+  int result = 0;
+
+  /* Avoid self-references and references to objects which cannot be
+     unloaded anyway.  */
+  if (undef_map == map)
+    return 0;
+
+  /* Avoid references to objects which cannot be unloaded anyway.  */
+  assert (map->l_type == lt_loaded);
+  if ((map->l_flags_1 & DF_1_NODELETE) != 0)
+    return 0;
+
+  struct link_map_reldeps *l_reldeps
+    = atomic_forced_read (undef_map->l_reldeps);
+
+  /* Make sure l_reldeps is read before l_initfini.  */
+  atomic_read_barrier ();
+
+  /* Determine whether UNDEF_MAP already has a reference to MAP.  First
+     look in the normal dependencies.  */
+  struct link_map **l_initfini = atomic_forced_read (undef_map->l_initfini);
+  if (l_initfini != NULL)
+    {
+      for (i = 0; l_initfini[i] != NULL; ++i)
+	if (l_initfini[i] == map)
+	  return 0;
+    }
+
+  /* No normal dependency.  See whether we already had to add it
+     to the special list of dynamic dependencies.  */
+  unsigned int l_reldepsact = 0;
+  if (l_reldeps != NULL)
+    {
+      struct link_map **list = &l_reldeps->list[0];
+      l_reldepsact = l_reldeps->act;
+      for (i = 0; i < l_reldepsact; ++i)
+	if (list[i] == map)
+	  return 0;
+    }
+
+  /* Save serial number of the target MAP.  */
+  unsigned long long serial = map->l_serial;
+
+  /* Make sure nobody can unload the object while we are at it.  */
+  if (__builtin_expect (flags & DL_LOOKUP_GSCOPE_LOCK, 0))
+    {
+      /* We can't just call __rtld_lock_lock_recursive (GL(dl_load_lock))
+	 here, that can result in ABBA deadlock.  */
+      THREAD_GSCOPE_RESET_FLAG ();
+      __rtld_lock_lock_recursive (GL(dl_load_lock));
+      /* While MAP value won't change, after THREAD_GSCOPE_RESET_FLAG ()
+	 it can e.g. point to unallocated memory.  So avoid the optimizer
+	 treating the above read from MAP->l_serial as ensurance it
+	 can safely dereference it.  */
+      map = atomic_forced_read (map);
+
+      /* From this point on it is unsafe to dereference MAP, until it
+	 has been found in one of the lists.  */
+
+      /* Redo the l_initfini check in case undef_map's l_initfini
+	 changed in the mean time.  */
+      if (undef_map->l_initfini != l_initfini
+	  && undef_map->l_initfini != NULL)
+	{
+	  l_initfini = undef_map->l_initfini;
+	  for (i = 0; l_initfini[i] != NULL; ++i)
+	    if (l_initfini[i] == map)
+	      goto out_check;
+	}
+
+      /* Redo the l_reldeps check if undef_map's l_reldeps changed in
+	 the mean time.  */
+      if (undef_map->l_reldeps != NULL)
+	{
+	  if (undef_map->l_reldeps != l_reldeps)
+	    {
+	      struct link_map **list = &undef_map->l_reldeps->list[0];
+	      l_reldepsact = undef_map->l_reldeps->act;
+	      for (i = 0; i < l_reldepsact; ++i)
+		if (list[i] == map)
+		  goto out_check;
+	    }
+	  else if (undef_map->l_reldeps->act > l_reldepsact)
+	    {
+	      struct link_map **list
+		= &undef_map->l_reldeps->list[0];
+	      i = l_reldepsact;
+	      l_reldepsact = undef_map->l_reldeps->act;
+	      for (; i < l_reldepsact; ++i)
+		if (list[i] == map)
+		  goto out_check;
+	    }
+	}
+    }
+  else
+    __rtld_lock_lock_recursive (GL(dl_load_lock));
+
+  /* The object is not yet in the dependency list.  Before we add
+     it make sure just one more time the object we are about to
+     reference is still available.  There is a brief period in
+     which the object could have been removed since we found the
+     definition.  */
+  runp = GL(dl_ns)[undef_map->l_ns]._ns_loaded;
+  while (runp != NULL && runp != map)
+    runp = runp->l_next;
+
+  if (runp != NULL)
+    {
+      /* The object is still available.  */
+
+      /* MAP could have been dlclosed, freed and then some other dlopened
+	 library could have the same link_map pointer.  */
+      if (map->l_serial != serial)
+	goto out_check;
+
+      /* Redo the NODELETE check, as when dl_load_lock wasn't held
+	 yet this could have changed.  */
+      if ((map->l_flags_1 & DF_1_NODELETE) != 0)
+	goto out;
+
+      /* If the object with the undefined reference cannot be removed ever
+	 just make sure the same is true for the object which contains the
+	 definition.  */
+      if (undef_map->l_type != lt_loaded
+	  || (undef_map->l_flags_1 & DF_1_NODELETE) != 0)
+	{
+	  map->l_flags_1 |= DF_1_NODELETE;
+	  goto out;
+	}
+
+      /* Add the reference now.  */
+      if (__builtin_expect (l_reldepsact >= undef_map->l_reldepsmax, 0))
+	{
+	  /* Allocate more memory for the dependency list.  Since this
+	     can never happen during the startup phase we can use
+	     `realloc'.  */
+	  struct link_map_reldeps *newp;
+	  unsigned int max
+	    = undef_map->l_reldepsmax ? undef_map->l_reldepsmax * 2 : 10;
+
+	  newp = malloc (sizeof (*newp) + max * sizeof (struct link_map *));
+	  if (newp == NULL)
+	    {
+	      /* If we didn't manage to allocate memory for the list this is
+		 no fatal problem.  We simply make sure the referenced object
+		 cannot be unloaded.  This is semantically the correct
+		 behavior.  */
+	      map->l_flags_1 |= DF_1_NODELETE;
+	      goto out;
+	    }
+	  else
+	    {
+	      if (l_reldepsact)
+		memcpy (&newp->list[0], &undef_map->l_reldeps->list[0],
+			l_reldepsact * sizeof (struct link_map *));
+	      newp->list[l_reldepsact] = map;
+	      newp->act = l_reldepsact + 1;
+	      atomic_write_barrier ();
+	      void *old = undef_map->l_reldeps;
+	      undef_map->l_reldeps = newp;
+	      undef_map->l_reldepsmax = max;
+	      if (old)
+		_dl_scope_free (old);
+	    }
+	}
+      else
+	{
+	  undef_map->l_reldeps->list[l_reldepsact] = map;
+	  atomic_write_barrier ();
+	  undef_map->l_reldeps->act = l_reldepsact + 1;
+	}
+
+      /* Display information if we are debugging.  */
+      if (__builtin_expect (GLRO(dl_debug_mask) & DL_DEBUG_FILES, 0))
+	_dl_debug_printf ("\
+\nfile=%s [%lu];  needed by %s [%lu] (relocation dependency)\n\n",
+			  map->l_name[0] ? map->l_name : rtld_progname,
+			  map->l_ns,
+			  undef_map->l_name[0]
+			  ? undef_map->l_name : rtld_progname,
+			  undef_map->l_ns);
+    }
+  else
+    /* Whoa, that was bad luck.  We have to search again.  */
+    result = -1;
+
+ out:
+  /* Release the lock.  */
+  __rtld_lock_unlock_recursive (GL(dl_load_lock));
+
+  if (__builtin_expect (flags & DL_LOOKUP_GSCOPE_LOCK, 0))
+    THREAD_GSCOPE_SET_FLAG ();
+
+  return result;
+
+ out_check:
+  if (map->l_serial != serial)
+    result = -1;
+  goto out;
+}
+
+static void
+internal_function
+_dl_debug_bindings (const char *undef_name, struct link_map *undef_map,
+		    const ElfW(Sym) **ref, struct sym_val *value,
+		    const struct r_found_version *version, int type_class,
+		    int protected);
+
+
+/* Search loaded objects' symbol tables for a definition of the symbol
+   UNDEF_NAME, perhaps with a requested version for the symbol.
+
+   We must never have calls to the audit functions inside this function
+   or in any function which gets called.  If this would happen the audit
+   code might create a thread which can throw off all the scope locking.  */
+lookup_t
+internal_function
+_dl_lookup_symbol_x (const char *undef_name, struct link_map *undef_map,
+		     const ElfW(Sym) **ref,
+		     struct r_scope_elem *symbol_scope[],
+		     const struct r_found_version *version,
+		     int type_class, int flags, struct link_map *skip_map)
+{
+  const uint_fast32_t new_hash = dl_new_hash (undef_name);
+  unsigned long int old_hash = 0xffffffff;
+  struct sym_val current_value = { NULL, NULL };
+  struct r_scope_elem **scope = symbol_scope;
+
+  bump_num_relocations ();
+
+  /* No other flag than DL_LOOKUP_ADD_DEPENDENCY or DL_LOOKUP_GSCOPE_LOCK
+     is allowed if we look up a versioned symbol.  */
+  assert (version == NULL
+	  || (flags & ~(DL_LOOKUP_ADD_DEPENDENCY | DL_LOOKUP_GSCOPE_LOCK))
+	     == 0);
+
+  size_t i = 0;
+  if (__builtin_expect (skip_map != NULL, 0))
+    /* Search the relevant loaded objects for a definition.  */
+    while ((*scope)->r_list[i] != skip_map)
+      ++i;
+
+  /* Search the relevant loaded objects for a definition.  */
+  for (size_t start = i; *scope != NULL; start = 0, ++scope)
+    {
+      int res = do_lookup_x (undef_name, new_hash, &old_hash, *ref,
+			     &current_value, *scope, start, version, flags,
+			     skip_map, type_class);
+      if (res > 0)
+	break;
+
+      if (__builtin_expect (res, 0) < 0 && skip_map == NULL)
+	{
+	  /* Oh, oh.  The file named in the relocation entry does not
+	     contain the needed symbol.  This code is never reached
+	     for unversioned lookups.  */
+	  assert (version != NULL);
+	  const char *reference_name = undef_map ? undef_map->l_name : NULL;
+
+	  /* XXX We cannot translate the message.  */
+	  _dl_signal_cerror (0, (reference_name[0]
+				 ? reference_name
+				 : (rtld_progname ?: "<main program>")),
+			     N_("relocation error"),
+			     make_string ("symbol ", undef_name, ", version ",
+					  version->name,
+					  " not defined in file ",
+					  version->filename,
+					  " with link time reference",
+					  res == -2
+					  ? " (no version symbols)" : ""));
+	  *ref = NULL;
+	  return 0;
+	}
+    }
+
+  if (__builtin_expect (current_value.s == NULL, 0))
+    {
+      if ((*ref == NULL || ELFW(ST_BIND) ((*ref)->st_info) != STB_WEAK)
+	  && skip_map == NULL)
+	{
+	  /* We could find no value for a strong reference.  */
+	  const char *reference_name = undef_map ? undef_map->l_name : "";
+	  const char *versionstr = version ? ", version " : "";
+	  const char *versionname = (version && version->name
+				     ? version->name : "");
+
+	  /* XXX We cannot translate the message.  */
+	  _dl_signal_cerror (0, (reference_name[0]
+				 ? reference_name
+				 : (rtld_progname ?: "<main program>")),
+			     N_("symbol lookup error"),
+			     make_string (undefined_msg, undef_name,
+					  versionstr, versionname));
+	}
+      *ref = NULL;
+      return 0;
+    }
+
+  int protected = (*ref
+		   && ELFW(ST_VISIBILITY) ((*ref)->st_other) == STV_PROTECTED);
+  if (__builtin_expect (protected != 0, 0))
+    {
+      /* It is very tricky.  We need to figure out what value to
+         return for the protected symbol.  */
+      if (type_class == ELF_RTYPE_CLASS_PLT)
+	{
+	  if (current_value.s != NULL && current_value.m != undef_map)
+	    {
+	      current_value.s = *ref;
+	      current_value.m = undef_map;
+	    }
+	}
+      else
+	{
+	  struct sym_val protected_value = { NULL, NULL };
+
+	  for (scope = symbol_scope; *scope != NULL; i = 0, ++scope)
+	    if (do_lookup_x (undef_name, new_hash, &old_hash, *ref,
+			     &protected_value, *scope, i, version, flags,
+			     skip_map, ELF_RTYPE_CLASS_PLT) != 0)
+	      break;
+
+	  if (protected_value.s != NULL && protected_value.m != undef_map)
+	    {
+	      current_value.s = *ref;
+	      current_value.m = undef_map;
+	    }
+	}
+    }
+
+  /* We have to check whether this would bind UNDEF_MAP to an object
+     in the global scope which was dynamically loaded.  In this case
+     we have to prevent the latter from being unloaded unless the
+     UNDEF_MAP object is also unloaded.  */
+  if (__builtin_expect (current_value.m->l_type == lt_loaded, 0)
+      /* Don't do this for explicit lookups as opposed to implicit
+	 runtime lookups.  */
+      && (flags & DL_LOOKUP_ADD_DEPENDENCY) != 0
+      /* Add UNDEF_MAP to the dependencies.  */
+      && add_dependency (undef_map, current_value.m, flags) < 0)
+      /* Something went wrong.  Perhaps the object we tried to reference
+	 was just removed.  Try finding another definition.  */
+      return _dl_lookup_symbol_x (undef_name, undef_map, ref,
+				  (flags & DL_LOOKUP_GSCOPE_LOCK)
+				  ? undef_map->l_scope : symbol_scope,
+				  version, type_class, flags, skip_map);
+
+  /* The object is used.  */
+  current_value.m->l_used = 1;
+
+  if (__builtin_expect (GLRO(dl_debug_mask)
+			& (DL_DEBUG_BINDINGS|DL_DEBUG_PRELINK), 0))
+    _dl_debug_bindings (undef_name, undef_map, ref,
+			&current_value, version, type_class, protected);
+
+  *ref = current_value.s;
+  return LOOKUP_VALUE (current_value.m);
+}
+
+
+/* Cache the location of MAP's hash table.  */
+
+void
+internal_function
+_dl_setup_hash (struct link_map *map)
+{
+  Elf_Symndx *hash;
+  Elf_Symndx nchain;
+
+  if (__builtin_expect (map->l_info[DT_ADDRTAGIDX (DT_GNU_HASH) + DT_NUM
+  				    + DT_THISPROCNUM + DT_VERSIONTAGNUM
+				    + DT_EXTRANUM + DT_VALNUM] != NULL, 1))
+    {
+      Elf32_Word *hash32
+	= (void *) D_PTR (map, l_info[DT_ADDRTAGIDX (DT_GNU_HASH) + DT_NUM
+				      + DT_THISPROCNUM + DT_VERSIONTAGNUM
+				      + DT_EXTRANUM + DT_VALNUM]);
+      map->l_nbuckets = *hash32++;
+      Elf32_Word symbias = *hash32++;
+      Elf32_Word bitmask_nwords = *hash32++;
+      /* Must be a power of two.  */
+      assert ((bitmask_nwords & (bitmask_nwords - 1)) == 0);
+      map->l_gnu_bitmask_idxbits = bitmask_nwords - 1;
+      map->l_gnu_shift = *hash32++;
+
+      map->l_gnu_bitmask = (ElfW(Addr) *) hash32;
+      hash32 += __ELF_NATIVE_CLASS / 32 * bitmask_nwords;
+
+      map->l_gnu_buckets = hash32;
+      hash32 += map->l_nbuckets;
+      map->l_gnu_chain_zero = hash32 - symbias;
+      return;
+    }
+
+  if (!map->l_info[DT_HASH])
+    return;
+  hash = (void *) D_PTR (map, l_info[DT_HASH]);
+
+  map->l_nbuckets = *hash++;
+  nchain = *hash++;
+  map->l_buckets = hash;
+  hash += map->l_nbuckets;
+  map->l_chain = hash;
+}
+
+
+static void
+internal_function
+_dl_debug_bindings (const char *undef_name, struct link_map *undef_map,
+		    const ElfW(Sym) **ref, struct sym_val *value,
+		    const struct r_found_version *version, int type_class,
+		    int protected)
+{
+  const char *reference_name = undef_map->l_name;
+
+  if (GLRO(dl_debug_mask) & DL_DEBUG_BINDINGS)
+    {
+      _dl_debug_printf ("binding file %s [%lu] to %s [%lu]: %s symbol `%s'",
+			(reference_name[0]
+			 ? reference_name
+			 : (rtld_progname ?: "<main program>")),
+			undef_map->l_ns,
+			value->m->l_name[0] ? value->m->l_name : rtld_progname,
+			value->m->l_ns,
+			protected ? "protected" : "normal", undef_name);
+      if (version)
+	_dl_debug_printf_c (" [%s]\n", version->name);
+      else
+	_dl_debug_printf_c ("\n");
+    }
+#ifdef SHARED
+  if (GLRO(dl_debug_mask) & DL_DEBUG_PRELINK)
+    {
+      int conflict = 0;
+      struct sym_val val = { NULL, NULL };
+
+      if ((GLRO(dl_trace_prelink_map) == NULL
+	   || GLRO(dl_trace_prelink_map) == GL(dl_ns)[LM_ID_BASE]._ns_loaded)
+	  && undef_map != GL(dl_ns)[LM_ID_BASE]._ns_loaded)
+	{
+	  const uint_fast32_t new_hash = dl_new_hash (undef_name);
+	  unsigned long int old_hash = 0xffffffff;
+
+	  do_lookup_x (undef_name, new_hash, &old_hash, *ref, &val,
+		       undef_map->l_local_scope[0], 0, version, 0, NULL,
+		       type_class);
+
+	  if (val.s != value->s || val.m != value->m)
+	    conflict = 1;
+	}
+
+      if (value->s
+	  && (__builtin_expect (ELFW(ST_TYPE) (value->s->st_info)
+				== STT_TLS, 0)))
+	type_class = 4;
+
+      if (conflict
+	  || GLRO(dl_trace_prelink_map) == undef_map
+	  || GLRO(dl_trace_prelink_map) == NULL
+	  || type_class == 4)
+	{
+	  _dl_printf ("%s 0x%0*Zx 0x%0*Zx -> 0x%0*Zx 0x%0*Zx ",
+		      conflict ? "conflict" : "lookup",
+		      (int) sizeof (ElfW(Addr)) * 2,
+		      (size_t) undef_map->l_map_start,
+		      (int) sizeof (ElfW(Addr)) * 2,
+		      (size_t) (((ElfW(Addr)) *ref) - undef_map->l_map_start),
+		      (int) sizeof (ElfW(Addr)) * 2,
+		      (size_t) (value->s ? value->m->l_map_start : 0),
+		      (int) sizeof (ElfW(Addr)) * 2,
+		      (size_t) (value->s ? value->s->st_value : 0));
+
+	  if (conflict)
+	    _dl_printf ("x 0x%0*Zx 0x%0*Zx ",
+			(int) sizeof (ElfW(Addr)) * 2,
+			(size_t) (val.s ? val.m->l_map_start : 0),
+			(int) sizeof (ElfW(Addr)) * 2,
+			(size_t) (val.s ? val.s->st_value : 0));
+
+	  _dl_printf ("/%x %s\n", type_class, undef_name);
+	}
+    }
+#endif
+}
Index: sysdeps/mips/dl-trampoline.c
===================================================================
--- sysdeps/mips/dl-trampoline.c	(revision 213009)
+++ sysdeps/mips/dl-trampoline.c	(working copy)
@@ -270,3 +270,44 @@ _dl_runtime_resolve:\n\
 	.end	_dl_runtime_resolve\n\
 	.previous\n\
 ");
+
+/* Assembler veneer called from the PLT header code when using the
+   non-PIC ABI.
+
+   Code in each PLT entry puts the caller's return address into t7 ($15),
+   the PLT entry index into t8 ($24), the address of _dl_runtime_pltresolve
+   into t9 ($25) and the address of .got.plt into gp ($28).  _dl_fixup
+   needs a0 ($4) to hold the link map and a1 ($5) to hold the index into
+   .rel.plt (== PLT entry index * 4).  */
+
+asm ("\n\
+	.text\n\
+	.align	2\n\
+	.globl	_dl_runtime_pltresolve\n\
+	.type	_dl_runtime_pltresolve,@function\n\
+	.ent	_dl_runtime_pltresolve\n\
+_dl_runtime_pltresolve:\n\
+	.frame	$29, " STRINGXP(ELF_DL_FRAME_SIZE) ", $31\n\
+	.set noreorder\n\
+	# Save arguments and sp value in stack.\n\
+	" STRINGXP(PTR_SUBIU) "  $29, " STRINGXP(ELF_DL_FRAME_SIZE) "\n\
+        lw      $10, 4($28)\n\
+	# Modify t9 ($25) so as to point .cpload instruction.\n\
+	" IFABIO32(STRINGXP(PTR_ADDIU) "	$25, 12\n") "\
+	# Compute GP.\n\
+	" STRINGXP(SETUP_GP) "\n\
+	" STRINGXV(SETUP_GP64 (0, _dl_runtime_pltresolve)) "\n\
+	.set reorder\n\
+	" ELF_DL_SAVE_ARG_REGS "\
+	move	$4, $10\n\
+        sll     $5, $24, 3\n\
+	jal	_dl_fixup\n\
+	" ELF_DL_RESTORE_ARG_REGS "\
+	" STRINGXP(RESTORE_GP64) "\n\
+	" STRINGXP(PTR_ADDIU) "	$29, " STRINGXP(ELF_DL_FRAME_SIZE) "\n\
+	move	$25, $2\n\
+	jr	$25\n\
+	.end	_dl_runtime_pltresolve\n\
+	.previous\n\
+");
+
Index: sysdeps/mips/bits/linkmap.h
===================================================================
--- sysdeps/mips/bits/linkmap.h	(revision 0)
+++ sysdeps/mips/bits/linkmap.h	(revision 0)
@@ -0,0 +1,4 @@
+struct link_map_machine
+  {
+    Elf32_Addr plt; /* Address of .plt */
+  };

--vtzGhvizbBRQ85DL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="glibc-relocs.patch"

2008-03-14  Mark Shinwell  <shinwell@codesourcery.com>

	* elf/elf.h (STO_MIPS_PLT): New.
	(R_MIPS_COPY): New.
	(R_MIPS_JUMP_SLOT): New.
	(R_MIPS_NUM): Redefine to 128.
	(DT_MIPS_PLTGOT): New.
	(DT_MIPS_RWPLT): New.
	(DT_MIPS_NUM): Redefine to 0x35.

Index: elf/elf.h
===================================================================
--- elf/elf.h	(revision 213009)
+++ elf/elf.h	(working copy)
@@ -1395,6 +1395,7 @@ typedef struct
 #define STO_MIPS_INTERNAL		0x1
 #define STO_MIPS_HIDDEN			0x2
 #define STO_MIPS_PROTECTED		0x3
+#define STO_MIPS_PLT			0x8
 #define STO_MIPS_SC_ALIGN_UNUSED	0xff
 
 /* MIPS specific values for `st_info'.  */
@@ -1541,8 +1542,10 @@ typedef struct
 #define R_MIPS_TLS_TPREL_HI16	49	/* TP-relative offset, high 16 bits */
 #define R_MIPS_TLS_TPREL_LO16	50	/* TP-relative offset, low 16 bits */
 #define R_MIPS_GLOB_DAT		51
+#define R_MIPS_COPY		126
+#define R_MIPS_JUMP_SLOT        127
 /* Keep this the last entry.  */
-#define R_MIPS_NUM		52
+#define R_MIPS_NUM		128
 
 /* Legal values for p_type field of Elf32_Phdr.  */
 
@@ -1608,7 +1611,13 @@ typedef struct
 #define DT_MIPS_COMPACT_SIZE 0x7000002f /* (O32)Size of compact rel section. */
 #define DT_MIPS_GP_VALUE     0x70000030 /* GP value for aux GOTs.  */
 #define DT_MIPS_AUX_DYNAMIC  0x70000031 /* Address of aux .dynamic.  */
-#define DT_MIPS_NUM	     0x32
+/* The address of .got.plt in an executable using the new non-PIC ABI.  */
+#define DT_MIPS_PLTGOT	     0x70000032
+/* The base of the PLT in an executable using the new non-PIC ABI if that
+   PLT is writable.  For a non-writable PLT, this is omitted or has a zero
+   value.  */
+#define DT_MIPS_RWPLT        0x70000034
+#define DT_MIPS_NUM	     0x35
 
 /* Legal values for DT_MIPS_FLAGS Elf32_Dyn entry.  */
 

--vtzGhvizbBRQ85DL
Content-Type: text/x-diff; charset=us-ascii
Content-Disposition: attachment; filename="binutils-nonpic.diff"

? changelog-diffs
Index: bfd/bfd-in2.h
===================================================================
RCS file: /cvs/src/src/bfd/bfd-in2.h,v
retrieving revision 1.446
diff -u -p -r1.446 bfd-in2.h
--- bfd/bfd-in2.h	21 May 2008 12:01:36 -0000	1.446
+++ bfd/bfd-in2.h	1 Jul 2008 16:08:49 -0000
@@ -2661,7 +2661,7 @@ to compensate for the borrow when the lo
   BFD_RELOC_MIPS_TLS_TPREL_LO16,
 
 
-/* MIPS ELF relocations (VxWorks extensions).  */
+/* MIPS ELF relocations (VxWorks and nonpic extensions).  */
   BFD_RELOC_MIPS_COPY,
   BFD_RELOC_MIPS_JUMP_SLOT,
 
Index: bfd/elf32-mips.c
===================================================================
RCS file: /cvs/src/src/bfd/elf32-mips.c,v
retrieving revision 1.197
diff -u -p -r1.197 elf32-mips.c
--- bfd/elf32-mips.c	27 Feb 2008 17:06:06 -0000	1.197
+++ bfd/elf32-mips.c	1 Jul 2008 16:08:49 -0000
@@ -875,6 +875,36 @@ static reloc_howto_type elf_mips_gnu_vte
 	 0,			/* dst_mask */
 	 FALSE);		/* pcrel_offset */
 
+static reloc_howto_type elf_mips_copy_howto =
+  HOWTO (R_MIPS_COPY,		/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 FALSE,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_MIPS_COPY",		/* name */
+	 FALSE,			/* partial_inplace */
+	 0x0,         		/* src_mask */
+	 0x0,		        /* dst_mask */
+	 FALSE);		/* pcrel_offset */
+
+static reloc_howto_type elf_mips_jump_slot_howto =
+  HOWTO (R_MIPS_JUMP_SLOT,	/* type */
+	 0,			/* rightshift */
+	 2,			/* size (0 = byte, 1 = short, 2 = long) */
+	 32,			/* bitsize */
+	 FALSE,			/* pc_relative */
+	 0,			/* bitpos */
+	 complain_overflow_bitfield, /* complain_on_overflow */
+	 bfd_elf_generic_reloc,	/* special_function */
+	 "R_MIPS_JUMP_SLOT",	/* name */
+	 FALSE,			/* partial_inplace */
+	 0x0,         		/* src_mask */
+	 0x0,		        /* dst_mask */
+	 FALSE);		/* pcrel_offset */
+
 /* Set the GP value for OUTPUT_BFD.  Returns FALSE if this is a
    dangerous relocation.  */
 
@@ -1273,6 +1303,10 @@ bfd_elf32_bfd_reloc_type_lookup (bfd *ab
       return &elf_mips_gnu_vtentry_howto;
     case BFD_RELOC_32_PCREL:
       return &elf_mips_gnu_pcrel32;
+    case BFD_RELOC_MIPS_COPY:
+      return &elf_mips_copy_howto;
+    case BFD_RELOC_MIPS_JUMP_SLOT:
+      return &elf_mips_jump_slot_howto;
     }
 }
 
@@ -1306,6 +1340,10 @@ bfd_elf32_bfd_reloc_name_lookup (bfd *ab
     return &elf_mips_gnu_vtinherit_howto;
   if (strcasecmp (elf_mips_gnu_vtentry_howto.name, r_name) == 0)
     return &elf_mips_gnu_vtentry_howto;
+  if (strcasecmp (elf_mips_copy_howto.name, r_name) == 0)
+    return &elf_mips_copy_howto;
+  if (strcasecmp (elf_mips_jump_slot_howto.name, r_name) == 0)
+    return &elf_mips_jump_slot_howto;
 
   return NULL;
 }
@@ -1326,6 +1364,10 @@ mips_elf32_rtype_to_howto (unsigned int 
       return &elf_mips_gnu_rel16_s2;
     case R_MIPS_PC32:
       return &elf_mips_gnu_pcrel32;
+    case R_MIPS_COPY:
+      return &elf_mips_copy_howto;
+    case R_MIPS_JUMP_SLOT:
+      return &elf_mips_jump_slot_howto;
     default:
       if (r_type >= R_MIPS16_min && r_type < R_MIPS16_max)
         return &elf_mips16_howto_table_rel[r_type - R_MIPS16_min];
@@ -1591,9 +1633,19 @@ static const struct ecoff_debug_swap mip
 #define elf_backend_default_use_rela_p	0
 #define elf_backend_sign_extend_vma	TRUE
 
+/* Most MIPS ELF files do not contain a traditional PLT; only VxWorks
+   and non-PIC dynamic executables do.  These settings only affect
+   _bfd_elf_create_dynamic_sections, which is only called when we
+   do want a traditional PLT.  */
+#undef elf_backend_want_plt_sym
+#define elf_backend_want_plt_sym		1
+#undef elf_backend_plt_readonly
+#define elf_backend_plt_readonly		1
+
 #define elf_backend_discard_info	_bfd_mips_elf_discard_info
 #define elf_backend_ignore_discarded_relocs \
 					_bfd_mips_elf_ignore_discarded_relocs
+#define elf_backend_write_section	_bfd_mips_elf_write_section
 #define elf_backend_mips_irix_compat	elf32_mips_irix_compat
 #define elf_backend_mips_rtype_to_howto	mips_elf32_rtype_to_howto
 #define bfd_elf32_bfd_is_local_label_name \
@@ -1613,6 +1665,8 @@ static const struct ecoff_debug_swap mip
 #define bfd_elf32_bfd_print_private_bfd_data \
 					_bfd_mips_elf_print_private_bfd_data
 
+#define elf_backend_plt_sym_val		_bfd_mips_elf_plt_sym_val
+
 /* Support for SGI-ish mips targets.  */
 #define TARGET_LITTLE_SYM		bfd_elf32_littlemips_vec
 #define TARGET_LITTLE_NAME		"elf32-littlemips"
@@ -1652,82 +1706,6 @@ static const struct ecoff_debug_swap mip
 /* Include the target file again for this target.  */
 #include "elf32-target.h"
 
-
-/* Specific to VxWorks.  */
-static reloc_howto_type mips_vxworks_copy_howto_rela =
-  HOWTO (R_MIPS_COPY,		/* type */
-	 0,			/* rightshift */
-	 2,			/* size (0 = byte, 1 = short, 2 = long) */
-	 32,			/* bitsize */
-	 FALSE,			/* pc_relative */
-	 0,			/* bitpos */
-	 complain_overflow_bitfield, /* complain_on_overflow */
-	 bfd_elf_generic_reloc,	/* special_function */
-	 "R_MIPS_COPY",		/* name */
-	 FALSE,			/* partial_inplace */
-	 0x0,         		/* src_mask */
-	 0x0,		        /* dst_mask */
-	 FALSE);		/* pcrel_offset */
-
-/* Specific to VxWorks.  */
-static reloc_howto_type mips_vxworks_jump_slot_howto_rela =
-  HOWTO (R_MIPS_JUMP_SLOT,	/* type */
-	 0,			/* rightshift */
-	 2,			/* size (0 = byte, 1 = short, 2 = long) */
-	 32,			/* bitsize */
-	 FALSE,			/* pc_relative */
-	 0,			/* bitpos */
-	 complain_overflow_bitfield, /* complain_on_overflow */
-	 bfd_elf_generic_reloc,	/* special_function */
-	 "R_MIPS_JUMP_SLOT",	/* name */
-	 FALSE,			/* partial_inplace */
-	 0x0,         		/* src_mask */
-	 0x0,		        /* dst_mask */
-	 FALSE);		/* pcrel_offset */
-
-/* Implement elf_backend_bfd_reloc_type_lookup for VxWorks.  */
-
-static reloc_howto_type *
-mips_vxworks_bfd_reloc_type_lookup (bfd *abfd, bfd_reloc_code_real_type code)
-{
-  switch (code)
-    {
-    case BFD_RELOC_MIPS_COPY:
-      return &mips_vxworks_copy_howto_rela;
-    case BFD_RELOC_MIPS_JUMP_SLOT:
-      return &mips_vxworks_jump_slot_howto_rela;
-    default:
-      return bfd_elf32_bfd_reloc_type_lookup (abfd, code);
-    }
-}
-
-static reloc_howto_type *
-mips_vxworks_bfd_reloc_name_lookup (bfd *abfd, const char *r_name)
-{
-  if (strcasecmp (mips_vxworks_copy_howto_rela.name, r_name) == 0)
-    return &mips_vxworks_copy_howto_rela;
-  if (strcasecmp (mips_vxworks_jump_slot_howto_rela.name, r_name) == 0)
-    return &mips_vxworks_jump_slot_howto_rela;
-
-  return bfd_elf32_bfd_reloc_name_lookup (abfd, r_name);
-}
-
-/* Implement elf_backend_mips_rtype_to_lookup for VxWorks.  */
-
-static reloc_howto_type *
-mips_vxworks_rtype_to_howto (unsigned int r_type, bfd_boolean rela_p)
-{
-  switch (r_type)
-    {
-    case R_MIPS_COPY:
-      return &mips_vxworks_copy_howto_rela;
-    case R_MIPS_JUMP_SLOT:
-      return &mips_vxworks_jump_slot_howto_rela;
-    default:
-      return mips_elf32_rtype_to_howto (r_type, rela_p);
-    }
-}
-
 /* Implement elf_backend_final_write_processing for VxWorks.  */
 
 static void
@@ -1758,12 +1736,6 @@ mips_vxworks_final_write_processing (bfd
 
 #undef elf_backend_want_got_plt
 #define elf_backend_want_got_plt		1
-#undef elf_backend_want_plt_sym
-#define elf_backend_want_plt_sym		1
-#undef elf_backend_got_symbol_offset
-#define elf_backend_got_symbol_offset		0
-#undef elf_backend_want_dynbss
-#define elf_backend_want_dynbss			1
 #undef elf_backend_may_use_rel_p
 #define elf_backend_may_use_rel_p		0
 #undef elf_backend_may_use_rela_p
@@ -1772,21 +1744,10 @@ mips_vxworks_final_write_processing (bfd
 #define elf_backend_default_use_rela_p		1
 #undef elf_backend_got_header_size
 #define elf_backend_got_header_size		(4 * 3)
-#undef elf_backend_plt_readonly
-#define elf_backend_plt_readonly		1
 
-#undef bfd_elf32_bfd_reloc_type_lookup
-#define bfd_elf32_bfd_reloc_type_lookup \
-  mips_vxworks_bfd_reloc_type_lookup
-#undef bfd_elf32_bfd_reloc_name_lookup
-#define bfd_elf32_bfd_reloc_name_lookup \
-  mips_vxworks_bfd_reloc_name_lookup
-#undef elf_backend_mips_rtype_to_howto
-#define elf_backend_mips_rtype_to_howto	\
-  mips_vxworks_rtype_to_howto
 #undef elf_backend_adjust_dynamic_symbol
 #define elf_backend_adjust_dynamic_symbol \
-  _bfd_mips_vxworks_adjust_dynamic_symbol
+  _bfd_mips_plt_adjust_dynamic_symbol
 #undef elf_backend_finish_dynamic_symbol
 #define elf_backend_finish_dynamic_symbol \
   _bfd_mips_vxworks_finish_dynamic_symbol
@@ -1809,6 +1770,7 @@ mips_vxworks_final_write_processing (bfd
 #undef elf_backend_additional_program_headers
 #undef elf_backend_modify_segment_map
 #undef elf_backend_symbol_processing
+#undef elf_backend_plt_sym_val
 /* NOTE: elf_backend_rela_normal is not defined for MIPS.  */
 
 #include "elf32-target.h"
Index: bfd/elflink.c
===================================================================
RCS file: /cvs/src/src/bfd/elflink.c,v
retrieving revision 1.304
diff -u -p -r1.304 elflink.c
--- bfd/elflink.c	29 Apr 2008 11:53:45 -0000	1.304
+++ bfd/elflink.c	1 Jul 2008 16:08:49 -0000
@@ -1178,7 +1178,7 @@ _bfd_elf_merge_symbol (bfd *abfd,
   if (olddef && newdyn)
     oldweak = FALSE;
 
-  /* Allow changes between different types of funciton symbol.  */
+  /* Allow changes between different types of function symbol.  */
   if (bed->is_function_type (ELF_ST_TYPE (sym->st_info))
       && bed->is_function_type (h->type))
     *type_change_ok = TRUE;
Index: bfd/elfxx-mips.c
===================================================================
RCS file: /cvs/src/src/bfd/elfxx-mips.c,v
retrieving revision 1.230
diff -u -p -r1.230 elfxx-mips.c
--- bfd/elfxx-mips.c	21 Apr 2008 17:54:24 -0000	1.230
+++ bfd/elfxx-mips.c	1 Jul 2008 16:08:50 -0000
@@ -306,9 +306,6 @@ struct mips_elf_link_hash_entry
      the initial global GOT entry to a local GOT entry.  */
   bfd_boolean forced_local;
 
-  /* Are we referenced by some kind of relocation?  */
-  bfd_boolean is_relocation_target;
-
   /* Are we referenced by branch relocations?  */
   bfd_boolean is_branch_target;
 
@@ -326,6 +323,18 @@ struct mips_elf_link_hash_entry
      possible to use root.got.offset instead, but that field is
      overloaded already.  */
   bfd_vma tls_got_offset;
+
+  /* Offset of any corresponding PLT entry from the start of .plt
+     when using the non-PIC ABI, unless has_non_pic_to_pic_stub is
+     set, in which case it is the offset of the stub from the start
+     of the stubs section.  */
+  bfd_vma plt_entry_offset;
+
+  /* Set if this symbol has a non-PIC -> PIC call stub associated
+     with it.  If set, the PLT offset field specifies the offset into
+     the PLT section where the stub lies.  All calls from non-PIC code
+     to the symbol must go via that stub.  */
+  bfd_boolean has_non_pic_to_pic_stub;
 };
 
 /* MIPS ELF linker hash table.  */
@@ -353,6 +362,10 @@ struct mips_elf_link_hash_table
   bfd_boolean computed_got_sizes;
   /* True if we're generating code for VxWorks.  */
   bfd_boolean is_vxworks;
+  /* True if we're generating code for the non-PIC ABI.  */
+  bfd_boolean is_non_pic;
+  /* A non-PIC input BFD with relocations, to attach stubs to.  */
+  bfd *non_pic_bfd;
   /* True if we already reported the small-data section overflow.  */
   bfd_boolean small_data_overflow_reported;
   /* Shortcuts to some dynamic sections, or NULL if they are not
@@ -363,10 +376,13 @@ struct mips_elf_link_hash_table
   asection *srelplt2;
   asection *sgotplt;
   asection *splt;
-  /* The size of the PLT header in bytes (VxWorks only).  */
+  asection *snonpictopic;
+  /* The size of the PLT header in bytes (VxWorks and non-PIC ABI only).  */
   bfd_vma plt_header_size;
-  /* The size of a PLT entry in bytes (VxWorks only).  */
+  /* The size of a PLT entry in bytes (VxWorks and non-PIC ABI only).  */
   bfd_vma plt_entry_size;
+  /* The size of a large PLT entry in bytes (non-PIC ABI only).  */
+  bfd_vma large_plt_entry_size;
   /* The size of a function stub entry in bytes.  */
   bfd_vma function_stub_size;
 };
@@ -552,6 +568,11 @@ static bfd *reldyn_sorting_bfd;
 /* Nonzero if ABFD is using NewABI conventions.  */
 #define NEWABI_P(abfd) (ABI_N32_P (abfd) || ABI_64_P (abfd))
 
+/* Nonzero if ABFD is a non-PIC object.  */
+#define NON_PIC_P(abfd) \
+  (((elf_elfheader (abfd)->e_flags & EF_MIPS_PIC) == 0) \
+   && ((elf_elfheader (abfd)->e_flags & EF_MIPS_CPIC) == EF_MIPS_CPIC))
+
 /* The IRIX compatibility level we are striving for.  */
 #define IRIX_COMPAT(abfd) \
   (get_elf_backend_data (abfd)->elf_backend_mips_irix_compat (abfd))
@@ -564,6 +585,9 @@ static bfd *reldyn_sorting_bfd;
 #define MIPS_ELF_OPTIONS_SECTION_NAME(abfd) \
   (NEWABI_P (abfd) ? ".MIPS.options" : ".options")
 
+/* The name of the section holding non-PIC to PIC call stubs.  */
+#define NON_PIC_TO_PIC_STUB_SECTION_NAME ".MIPS.pic_stubs"
+
 /* True if NAME is the recognized name of any SHT_MIPS_OPTIONS section.
    Some IRIX system files do not use MIPS_ELF_OPTIONS_SECTION_NAME.  */
 #define MIPS_ELF_OPTIONS_SECTION_NAME_P(NAME) \
@@ -752,6 +776,56 @@ static bfd *reldyn_sorting_bfd;
 #define CALL_STUB_P(name) CONST_STRNEQ (name, CALL_STUB)
 #define CALL_FP_STUB_P(name) CONST_STRNEQ (name, CALL_FP_STUB)
 
+#define MIPS_NONPIC_LARGE_PLT_THRESHOLD		65536
+
+/* The format of the first PLT entry in a non-PIC ABI executable.
+   This branches to the dynamic linker to resolve a symbol.
+   This first PLT entry is called via one of the other PLT entries,
+   which will have initialised t8 to the PLT entry index.  */
+static const bfd_vma mips_non_pic_exec_plt0_entry[] = {
+  0x3c1c0000,   /* lui     $gp, <high part of .got.plt address> */
+  0x279c0000,   /* addiu   $gp, <low part of .got.plt address> */
+  0x8f990000,   /* lw      $t9, 0($gp)       */
+  0x03e07821,   /* move    $t7, $ra          */
+  0x0320f809,   /* jalr    $t9               */
+  0x00000000,   /* nop                       */
+  0x00000000,   /* nop                       */
+  0x00000000    /* nop                       */
+};
+
+/* The format of subsequent PLT entries in a non-PIC ABI executable
+   whose (0-based) PLT indexes are less than
+   MIPS_NONPIC_LARGE_PLT_THRESHOLD.  (One PLT may contain both entries
+   in this format and in the format of mips_non_pic_large_exec_plt_entry.)  */
+static const bfd_vma mips_non_pic_exec_plt_entry[] = {
+  0x3c0f0000,   /* lui $t7, <high part of .got.plt slot address>     */
+  0x8df90000,   /* lw  $t9, <low part of .got.plt slot address>($t7) */
+  0x34180000,   /* ori $t8, $0, <PLT entry index> */
+  0x03200008    /* jr  $t9 */
+};
+
+/* The format of subsequent PLT entries in a non-PIC ABI executable
+   whose (0-based) PLT indexes are greater than or equal to
+   MIPS_NONPIC_LARGE_PLT_THRESHOLD.  */
+static const bfd_vma mips_non_pic_large_exec_plt_entry[] = {
+  0x3c0f0000,   /* lui $t7, <high part of .got.plt slot address>     */
+  0x8df90000,   /* lw  $t9, <low part of .got.plt slot address>($t7) */
+  0x3c180000,   /* lui $t8, <high part of PLT index> */
+  0x03200008,   /* jr $t9 */
+  0x37180000,   /* ori $t8, $t8, <low part of PLT index> */
+  0x00000000,   /* nop */
+  0x00000000,   /* nop */
+  0x00000000    /* nop */
+};
+
+/* The format of a stub used to call PIC code from non-PIC code.  */
+static const bfd_vma mips_non_pic_to_pic_stub[] = {
+  0x3c190000,	/* lui   $t9, <high part of PIC code's address> */
+  0x27390000,	/* addiu $t9, $t9, <low part of PIC code's address> */
+  0x03200008,	/* jr    $t9 */
+  0x00000000	/* nop */
+};
+
 /* The format of the first PLT entry in a VxWorks executable.  */
 static const bfd_vma mips_vxworks_exec_plt0_entry[] = {
   0x3c190000,	/* lui t9, %hi(_GLOBAL_OFFSET_TABLE_)		*/
@@ -870,8 +944,9 @@ mips_elf_link_hash_newfunc (struct bfd_h
       ret->call_fp_stub = NULL;
       ret->forced_local = FALSE;
       ret->is_branch_target = FALSE;
-      ret->is_relocation_target = FALSE;
       ret->tls_type = GOT_NORMAL;
+      ret->has_non_pic_to_pic_stub = FALSE;
+      ret->plt_entry_offset = (bfd_vma) -1;
     }
 
   return (struct bfd_hash_entry *) ret;
@@ -4041,17 +4116,6 @@ mips_elf_create_got_section (bfd *abfd, 
   mips_elf_section_data (s)->elf.this_hdr.sh_flags
     |= SHF_ALLOC | SHF_WRITE | SHF_MIPS_GPREL;
 
-  /* VxWorks also needs a .got.plt section.  */
-  if (htab->is_vxworks)
-    {
-      s = bfd_make_section_with_flags (abfd, ".got.plt",
-				       SEC_ALLOC | SEC_LOAD | SEC_HAS_CONTENTS
-				       | SEC_IN_MEMORY | SEC_LINKER_CREATED);
-      if (s == NULL || !bfd_set_section_alignment (abfd, s, 4))
-	return FALSE;
-
-      htab->sgotplt = s;
-    }
   return TRUE;
 }
 
@@ -4293,8 +4357,16 @@ mips_elf_calculate_relocation (bfd *abfd
 
   /* If this is a 32- or 64-bit call to a 16-bit function with a stub, we
      need to redirect the call to the stub, unless we're already *in*
-     a stub.  */
-  if (r_type != R_MIPS16_26 && !info->relocatable
+     a stub.  Likewise for non-PIC to PIC call stubs.  (Note that
+     these latter varieties of stubs never contain any relocations, so
+     we don't need to check if we're within a stub section here.)  */
+  if (h != NULL && htab->is_non_pic
+      && (r_type == R_MIPS_26 || r_type == R_MIPS_PC16)
+      && h->has_non_pic_to_pic_stub)
+    symbol = htab->snonpictopic->output_section->vma
+      + htab->snonpictopic->output_section->output_offset
+      + h->plt_entry_offset;
+  else if (r_type != R_MIPS16_26 && !info->relocatable
       && ((h != NULL && h->fn_stub != NULL)
 	  || (local_p
 	      && elf_tdata (input_bfd)->local_stubs != NULL
@@ -4357,6 +4429,17 @@ mips_elf_calculate_relocation (bfd *abfd
       BFD_ASSERT (sec->size > 0);
       symbol = sec->output_section->vma + sec->output_offset;
     }
+  else if (htab->is_non_pic && h != NULL
+	   && !h->has_non_pic_to_pic_stub
+	   && h->plt_entry_offset != (bfd_vma) -1)
+    {
+      BFD_ASSERT (!local_p);
+      BFD_ASSERT (r_type == R_MIPS_PC16 || addend == 0);
+      sec = htab->splt;
+      BFD_ASSERT (sec != NULL);
+      symbol = sec->output_section->vma + sec->output_offset
+               + h->plt_entry_offset;
+    }
 
   /* Calls from 16-bit code to 32-bit code and vice versa require the
      special jalx instruction.  */
@@ -4516,8 +4599,9 @@ mips_elf_calculate_relocation (bfd *abfd
     case R_MIPS_64:
       if ((info->shared
 	   || (!htab->is_vxworks
-	       && htab->root.dynamic_sections_created
+	       && !htab->is_non_pic
 	       && h != NULL
+	       && htab->root.dynamic_sections_created
 	       && h->root.def_dynamic
 	       && !h->root.def_regular))
 	  && r_symndx != 0
@@ -4531,7 +4615,8 @@ mips_elf_calculate_relocation (bfd *abfd
 
 	     In VxWorks executables, references to external symbols
 	     are handled using copy relocs or PLT stubs, so there's
-	     no need to add a dynamic relocation here.  */
+	     no need to add a dynamic relocation here.  Likewise for
+	     the non-PIC ABI.  */
 	  value = addend;
 	  if (!mips_elf_create_dynamic_relocation (abfd,
 						   info,
@@ -6150,6 +6235,56 @@ _bfd_mips_elf_link_output_symbol_hook
 
 /* Functions for the dynamic linker.  */
 
+static bfd_boolean
+_bfd_mips_elf_create_nonpic_dynamic_sections (bfd *abfd,
+					      struct bfd_link_info *info)
+{
+  flagword flags;
+  asection *s;
+  struct mips_elf_link_hash_table *htab;
+
+  htab = mips_elf_hash_table (info);
+  flags = (SEC_ALLOC | SEC_LOAD | SEC_HAS_CONTENTS | SEC_IN_MEMORY
+	   | SEC_LINKER_CREATED | SEC_READONLY);
+
+  BFD_ASSERT (!info->shared);
+
+  s = bfd_make_section_with_flags (abfd, ".got.plt",
+				   SEC_ALLOC | SEC_LOAD | SEC_HAS_CONTENTS
+				   | SEC_IN_MEMORY | SEC_LINKER_CREATED);
+  if (s == NULL || !bfd_set_section_alignment (abfd, s, 4))
+    return FALSE;
+  htab->sgotplt = s;
+
+  /* Create the .plt, .rel.plt, .dynbss and .rel.bss sections.  */
+  if (!_bfd_elf_create_dynamic_sections (abfd, info))
+    return FALSE;
+
+  /* Cache the sections created above.  */
+  htab->sdynbss = bfd_get_section_by_name (abfd, ".dynbss");
+  htab->srelbss = bfd_get_section_by_name (abfd, ".rel.bss");
+  htab->srelplt = bfd_get_section_by_name (abfd, ".rel.plt");
+  htab->splt = bfd_get_section_by_name (abfd, ".plt");
+  if (!htab->sdynbss
+      || !htab->srelbss
+      || !htab->srelplt
+      || !htab->splt)
+    abort ();
+
+  /* Align .plt to 32 bytes, so that no PLT entry crosses a
+     cache line.  */
+  if (! bfd_set_section_alignment (abfd, htab->splt, 5))
+    return FALSE;
+
+  /* Work out the PLT sizes.  */
+  htab->plt_header_size = 4 * ARRAY_SIZE (mips_non_pic_exec_plt0_entry);
+  htab->plt_entry_size = 4 * ARRAY_SIZE (mips_non_pic_exec_plt_entry);
+  htab->large_plt_entry_size =
+    4 * ARRAY_SIZE (mips_non_pic_large_exec_plt_entry);
+
+  return TRUE;
+}
+
 /* Create dynamic sections when linking against a dynamic object.  */
 
 bfd_boolean
@@ -6182,6 +6317,18 @@ _bfd_mips_elf_create_dynamic_sections (b
   if (! mips_elf_create_got_section (abfd, info, FALSE))
     return FALSE;
 
+  /* VxWorks and non-PIC ABI code also need a .got.plt section.  */
+  if (htab->is_vxworks)
+    {
+      s = bfd_make_section_with_flags (abfd, ".got.plt",
+				       SEC_ALLOC | SEC_LOAD | SEC_HAS_CONTENTS
+				       | SEC_IN_MEMORY | SEC_LINKER_CREATED);
+      if (s == NULL || !bfd_set_section_alignment (abfd, s, 4))
+	return FALSE;
+
+      htab->sgotplt = s;
+    }
+
   if (! mips_elf_rel_dyn_section (info, TRUE))
     return FALSE;
 
@@ -6342,6 +6489,12 @@ _bfd_mips_elf_create_dynamic_sections (b
 	}
     }
 
+  /* If creating a (non-shared) object using the non-PIC ABI,
+     we also need a PLT etc.  */
+  if (htab->is_non_pic
+      && !_bfd_mips_elf_create_nonpic_dynamic_sections (abfd, info))
+    return FALSE;
+
   return TRUE;
 }
 
@@ -6498,6 +6651,24 @@ _bfd_mips_elf_check_relocs (bfd *abfd, s
   sym_hashes = elf_sym_hashes (abfd);
   extsymoff = (elf_bad_symtab (abfd)) ? 0 : symtab_hdr->sh_info;
 
+  /* Check if this is the first non-PIC file encountered during an
+     executable link.  We have to check the input file's flags,
+     since merge_private_data is not called until later.  */
+  if (!htab->is_non_pic && !info->shared)
+    {
+      flagword flags;
+
+      flags = elf_elfheader (abfd)->e_flags;
+      if ((flags & (EF_MIPS_PIC | EF_MIPS_CPIC)) == EF_MIPS_CPIC)
+	{
+	  htab->is_non_pic = TRUE;
+	  htab->non_pic_bfd = abfd;
+	  if (elf_hash_table (info)->dynamic_sections_created)
+	    if (!_bfd_mips_elf_create_nonpic_dynamic_sections (dynobj, info))
+	      return FALSE;
+	}
+    }
+
   /* Check for the mips16 stub sections.  */
 
   name = bfd_get_section_name (abfd, sec);
@@ -6823,7 +6994,8 @@ _bfd_mips_elf_check_relocs (bfd *abfd, s
 		 are handled using copy relocs or PLT stubs, so there's
 		 no need to add a dynamic relocation here.  */
 	      if (dynobj == NULL
-		  && (info->shared || (h != NULL && !htab->is_vxworks))
+		  && (info->shared
+		      || (h != NULL && !htab->is_vxworks && !htab->is_non_pic))
 		  && (sec->flags & SEC_ALLOC) != 0)
 		elf_hash_table (info)->dynobj = dynobj = abfd;
 	      break;
@@ -6835,8 +7007,6 @@ _bfd_mips_elf_check_relocs (bfd *abfd, s
 
       if (h)
 	{
-	  ((struct mips_elf_link_hash_entry *) h)->is_relocation_target = TRUE;
-
 	  /* Relocations against the special VxWorks __GOTT_BASE__ and
 	     __GOTT_INDEX__ symbols must be left to the loader.  Allocate
 	     room for them in .rela.dyn.  */
@@ -6890,7 +7060,7 @@ _bfd_mips_elf_check_relocs (bfd *abfd, s
 	case R_MIPS_CALL_LO16:
 	  if (h != NULL)
 	    {
-	      /* VxWorks call relocations point the function's .got.plt
+	      /* VxWorks call relocations point at the function's .got.plt
 		 entry, which will be allocated by adjust_dynamic_symbol.
 		 Otherwise, this symbol requires a global GOT entry.  */
 	      if ((!htab->is_vxworks || h->forced_local)
@@ -6899,7 +7069,9 @@ _bfd_mips_elf_check_relocs (bfd *abfd, s
 
 	      /* We need a stub, not a plt entry for the undefined
 		 function.  But we record it as if it needs plt.  See
-		 _bfd_elf_adjust_dynamic_symbol.  */
+		 _bfd_elf_adjust_dynamic_symbol.  Note that these relocations
+		 are always used for PIC calls, even when using the new
+		 non-PIC ABI.  */
 	      h->needs_plt = 1;
 	      h->type = STT_FUNC;
 	    }
@@ -7006,10 +7178,15 @@ _bfd_mips_elf_check_relocs (bfd *abfd, s
 	case R_MIPS_32:
 	case R_MIPS_REL32:
 	case R_MIPS_64:
+	  if (h != NULL)
+	    h->non_got_ref = TRUE;
 	  /* In VxWorks executables, references to external symbols
 	     are handled using copy relocs or PLT stubs, so there's
-	     no need to add a .rela.dyn entry for this relocation.  */
-	  if ((info->shared || (h != NULL && !htab->is_vxworks))
+	     no need to add a .rela.dyn entry for this relocation.
+	     Likewise for the non-PIC ABI, if we already know that
+	     we are using it.  */
+	  if ((info->shared
+	       || (h != NULL && !htab->is_vxworks && !htab->is_non_pic))
 	      && (sec->flags & SEC_ALLOC) != 0)
 	    {
 	      if (sreloc == NULL)
@@ -7034,7 +7211,9 @@ _bfd_mips_elf_check_relocs (bfd *abfd, s
 		  struct mips_elf_link_hash_entry *hmips;
 
 		  /* We only need to copy this reloc if the symbol is
-                     defined in a dynamic object.  */
+                     defined in a dynamic object.  We do not need to
+		     do so at all if we find a non-PIC file later in
+		     the link.  */
 		  hmips = (struct mips_elf_link_hash_entry *) h;
 		  ++hmips->possibly_dynamic_relocs;
 		  if (MIPS_ELF_READONLY_SECTION (sec))
@@ -7048,7 +7227,11 @@ _bfd_mips_elf_check_relocs (bfd *abfd, s
 		 table index greater that DT_MIPS_GOTSYM if there are
 		 dynamic relocations against it.  This does not apply
 		 to VxWorks, which does not have the usual coupling
-		 between global GOT entries and .dynsym entries.  */
+		 between global GOT entries and .dynsym entries.
+		 If this link turns out to be a non-PIC one (i.e. we
+		 have only seen PIC files so far, but find a non-PIC
+		 one later), then this will not have been necessary;
+	         but it is harmless in that case.  */
 	      if (h != NULL && !htab->is_vxworks)
 		{
 		  if (dynobj == NULL)
@@ -7079,11 +7262,21 @@ _bfd_mips_elf_check_relocs (bfd *abfd, s
 	case R_MIPS_GPREL16:
 	case R_MIPS_LITERAL:
 	case R_MIPS_GPREL32:
+	  if (h != NULL
+	      && (r_type == R_MIPS_GPREL16 || r_type == R_MIPS_GPREL32))
+	    h->non_got_ref = TRUE;
+
 	  if (SGI_COMPAT (abfd))
 	    mips_elf_hash_table (info)->compact_rel_size +=
 	      sizeof (Elf32_External_crinfo);
 	  break;
 
+	case R_MIPS_HI16:
+	case R_MIPS_LO16:
+	  if (h != NULL && strcmp (h->root.root.string, "_gp_disp") != 0)
+	    h->non_got_ref = TRUE;
+	  break;
+
 	  /* This relocation describes the C++ object vtable hierarchy.
 	     Reconstruct it for later use during GC.  */
 	case R_MIPS_GNU_VTINHERIT:
@@ -7106,19 +7299,19 @@ _bfd_mips_elf_check_relocs (bfd *abfd, s
 
       /* We must not create a stub for a symbol that has relocations
 	 related to taking the function's address.  This doesn't apply to
-	 VxWorks, where CALL relocs refer to a .got.plt entry instead of
-	 a normal .got entry.  */
+	 VxWorks or the non-PIC ABI, where CALL relocs refer to a
+	 .got.plt entry instead of a normal .got entry.  */
       if (!htab->is_vxworks && h != NULL)
 	switch (r_type)
 	  {
-	  default:
-	    ((struct mips_elf_link_hash_entry *) h)->no_fn_stub = TRUE;
-	    break;
 	  case R_MIPS_CALL16:
 	  case R_MIPS_CALL_HI16:
 	  case R_MIPS_CALL_LO16:
 	  case R_MIPS_JALR:
 	    break;
+	  default:
+	    ((struct mips_elf_link_hash_entry *) h)->no_fn_stub = TRUE;
+	    break;
 	  }
 
       /* If this reloc is not a 16 bit call, and it has a global
@@ -7133,6 +7326,36 @@ _bfd_mips_elf_check_relocs (bfd *abfd, s
 	  mh = (struct mips_elf_link_hash_entry *) h;
 	  mh->need_fn_stub = TRUE;
 	}
+
+      /* Refuse invalid relocations when creating a shared library.  Do
+	 not refuse R_MIPS_32 / R_MIPS_64; they're not PIC, but we'll set
+         TEXTREL and the result will be fine.  */
+      if (info->shared
+	  && (sec->flags & SEC_ALLOC) != 0
+	  && (sec->flags & SEC_READONLY) != 0)
+	{
+	  switch (r_type)
+	    {
+	    case R_MIPS_HI16:
+	      /* Don't refuse R_MIPS_HI16 relocation if it's a part of
+		 compound relocation or against _gp_disp.  */
+	      if (NEWABI_P (dynobj)
+		  || (h != NULL
+		      && strcmp (h->root.root.string, "_gp_disp") == 0))
+		break;
+	      /* FALLTHROUGH */
+	    case R_MIPS_26:
+	      howto = MIPS_ELF_RTYPE_TO_HOWTO (abfd, r_type, FALSE);
+	      (*_bfd_error_handler)
+		(_("%B: relocation %s against `%s' can not be used when making a shared object; recompile with -fPIC"),
+		 abfd, howto->name,
+		 (h) ? h->root.root.string : "a local symbol");
+	      bfd_set_error (bfd_error_bad_value);
+	      return FALSE;
+	    default:
+	      break;
+	    }
+	}
     }
 
   return TRUE;
@@ -7299,6 +7522,61 @@ _bfd_mips_relax_section (bfd *abfd, asec
   return FALSE;
 }
 
+/* Return the size in bytes that the next PLT entry to be added to
+   htab->splt will require.  */
+static bfd_vma
+mips_elf_next_plt_entry_size (struct mips_elf_link_hash_table *htab)
+{
+  /* If we have fewer than MIPS_NONPIC_LARGE_PLT_THRESHOLD entries
+     currently in the PLT, the next entry to be added will be a normal
+     "small" PLT entry; otherwise it must be a large PLT entry.  */
+  if (htab->splt->size - htab->plt_header_size
+      >= htab->plt_entry_size * MIPS_NONPIC_LARGE_PLT_THRESHOLD)
+    return htab->large_plt_entry_size;
+  else
+    return htab->plt_entry_size;
+}
+
+/* Create an old-style .MIPS.stubs entry for a symbol not defined in a
+   regular file.  The symbol's value is pointed at the .MIPS.stubs entry
+   to provide a canonical function address.  */
+
+static bfd_boolean
+mips_elf_create_old_style_stub (struct bfd_link_info *info,
+				struct elf_link_hash_entry *h)
+{
+  bfd *dynobj = elf_hash_table (info)->dynobj;
+  struct mips_elf_link_hash_table *htab = mips_elf_hash_table (info);
+  asection *s;
+
+  BFD_ASSERT (dynobj != NULL);
+  BFD_ASSERT (htab != NULL);
+  BFD_ASSERT (elf_hash_table (info) != NULL);
+  BFD_ASSERT (!((struct mips_elf_link_hash_entry *) h)->no_fn_stub
+              && h->needs_plt
+	      && !h->def_regular);
+
+  if (!elf_hash_table (info)->dynamic_sections_created)
+    return TRUE;
+
+  /* Find the .stub section.  */
+  s = bfd_get_section_by_name (dynobj,
+			       MIPS_ELF_STUB_SECTION_NAME (dynobj));
+  BFD_ASSERT (s != NULL);
+
+  h->root.u.def.section = s;
+  h->root.u.def.value = s->size;
+
+  h->plt.offset = s->size;
+
+  /* Make room for this stub code.  */
+  s->size += htab->function_stub_size;
+
+  /* The last half word of the stub will be filled with the index
+     of this symbol in .dynsym section.  */
+  return TRUE;
+}
+
 /* Adjust a symbol defined by a dynamic object and referenced by a
    regular object.  The current definition is in some section of the
    dynamic object, but we're not including those sections.  We have to
@@ -7311,11 +7589,15 @@ _bfd_mips_elf_adjust_dynamic_symbol (str
 {
   bfd *dynobj;
   struct mips_elf_link_hash_entry *hmips;
-  asection *s;
   struct mips_elf_link_hash_table *htab;
 
   htab = mips_elf_hash_table (info);
   dynobj = elf_hash_table (info)->dynobj;
+  hmips = (struct mips_elf_link_hash_entry *) h;
+
+  /* VxWorks and the non-PIC ABI are handled elsewhere.  */
+  if (htab->is_vxworks || htab->is_non_pic)
+    return _bfd_mips_plt_adjust_dynamic_symbol (info, h);
 
   /* Make sure we know what is going on here.  */
   BFD_ASSERT (dynobj != NULL
@@ -7328,7 +7610,6 @@ _bfd_mips_elf_adjust_dynamic_symbol (str
   /* If this symbol is defined in a dynamic object, we need to copy
      any R_MIPS_32 or R_MIPS_REL32 relocs against it into the output
      file.  */
-  hmips = (struct mips_elf_link_hash_entry *) h;
   if (! info->relocatable
       && hmips->possibly_dynamic_relocs != 0
       && (h->root.type == bfd_link_hash_defweak
@@ -7343,39 +7624,9 @@ _bfd_mips_elf_adjust_dynamic_symbol (str
     }
 
   /* For a function, create a stub, if allowed.  */
-  if (! hmips->no_fn_stub
-      && h->needs_plt)
-    {
-      if (! elf_hash_table (info)->dynamic_sections_created)
-	return TRUE;
-
-      /* If this symbol is not defined in a regular file, then set
-	 the symbol to the stub location.  This is required to make
-	 function pointers compare as equal between the normal
-	 executable and the shared library.  */
-      if (!h->def_regular)
-	{
-	  /* We need .stub section.  */
-	  s = bfd_get_section_by_name (dynobj,
-				       MIPS_ELF_STUB_SECTION_NAME (dynobj));
-	  BFD_ASSERT (s != NULL);
-
-	  h->root.u.def.section = s;
-	  h->root.u.def.value = s->size;
-
-	  /* XXX Write this stub address somewhere.  */
-	  h->plt.offset = s->size;
-
-	  /* Make room for this stub code.  */
-	  s->size += htab->function_stub_size;
-
-	  /* The last half word of the stub will be filled with the index
-	     of this symbol in .dynsym section.  */
-	  return TRUE;
-	}
-    }
-  else if ((h->type == STT_FUNC)
-	   && !h->needs_plt)
+  if (!hmips->no_fn_stub && h->needs_plt && !h->def_regular)
+    return mips_elf_create_old_style_stub (info, h);
+  else if (h->type == STT_FUNC && !h->needs_plt)
     {
       /* This will set the entry for this symbol in the GOT to 0, and
          the dynamic linker will take care of this.  */
@@ -7401,94 +7652,188 @@ _bfd_mips_elf_adjust_dynamic_symbol (str
   return TRUE;
 }
 
-/* Likewise, for VxWorks.  */
+/* Likewise, for ABIs requiring procedure linkage tables (the non-PIC
+   ABI, and that of VxWorks).  */
 
 bfd_boolean
-_bfd_mips_vxworks_adjust_dynamic_symbol (struct bfd_link_info *info,
-					 struct elf_link_hash_entry *h)
+_bfd_mips_plt_adjust_dynamic_symbol (struct bfd_link_info *info,
+				     struct elf_link_hash_entry *h)
 {
+  bfd_boolean needs_plt_entry = FALSE;
   bfd *dynobj;
   struct mips_elf_link_hash_entry *hmips;
   struct mips_elf_link_hash_table *htab;
+  int reloc_size;
 
   htab = mips_elf_hash_table (info);
   dynobj = elf_hash_table (info)->dynobj;
   hmips = (struct mips_elf_link_hash_entry *) h;
 
-  /* Make sure we know what is going on here.  */
+  /* The code below is only for VxWorks or applications using the
+     non-PIC ABI.  */
+  BFD_ASSERT (htab->is_vxworks || htab->is_non_pic);
   BFD_ASSERT (dynobj != NULL
 	      && (h->needs_plt
-		  || h->needs_copy
 		  || h->u.weakdef != NULL
 		  || (h->def_dynamic
 		      && h->ref_regular
 		      && !h->def_regular)));
 
-  /* If the symbol is defined by a dynamic object, we need a PLT stub if
+  /* Note applicable to the non-PIC ABI only.
+     On entry to this function, h->needs_plt is set just when there is
+     a call from PIC code to the symbol under consideration.  Unless the
+     symbol now transpires to be local or have its address taken, this
+     means that an old-style .MIPS.stubs entry is required.  We set
+     needs_plt_entry during this function if we are using the non-PIC ABI
+     and discover that the symbol requires a PLT entry.  Both of these
+     flags may be set together.  On exit from this function, h->needs_plt
+     details whether a .MIPS.stubs entry was created.  */
+
+  /* If the symbol is defined by a dynamic object, we need a PLT entry if
      either (a) we want to branch to the symbol or (b) we're linking an
      executable that needs a canonical function address.  In the latter
-     case, the canonical address will be the address of the executable's
-     load stub.  */
+     case, the canonical address will be that of the PLT entry.  */
   if ((hmips->is_branch_target
        || (!info->shared
 	   && h->type == STT_FUNC
-	   && hmips->is_relocation_target))
+	   && h->non_got_ref))
       && h->def_dynamic
       && h->ref_regular
       && !h->def_regular
       && !h->forced_local)
-    h->needs_plt = 1;
+    {
+      /* This is the only place where we mark a symbol as requiring a
+         PLT entry under the non-PIC ABI.  */
+      if (htab->is_non_pic)
+        needs_plt_entry = TRUE;
 
-  /* Locally-binding symbols do not need a PLT stub; we can refer to
-     the functions directly.  */
+      if (htab->is_vxworks)
+	h->needs_plt = TRUE;
+    }
+  /* Locally-binding symbols do not need a PLT or a .MIPS.stubs entry;
+     we can refer to the functions directly.  */
   else if (h->needs_plt
 	   && (SYMBOL_CALLS_LOCAL (info, h)
 	       || (ELF_ST_VISIBILITY (h->other) != STV_DEFAULT
 		   && h->root.type == bfd_link_hash_undefweak)))
     {
-      h->needs_plt = 0;
+      h->needs_plt = FALSE;
       return TRUE;
     }
 
-  if (h->needs_plt)
+  /* If using the non-PIC ABI, create a .MIPS.stubs entry for this
+     symbol if required.  The symbol must not have had its address
+     taken; it must have been marked as requiring a stub previously;
+     and it must not be defined in a regular file.  */
+  if (htab->is_non_pic && h->needs_plt && !hmips->no_fn_stub)
+    {
+      if (!mips_elf_create_old_style_stub (info, h))
+        return FALSE;
+      /* We continue if the stub was created successfully; as above, we
+         may need a PLT entry too.  */
+    }
+
+  /* Under the non-PIC ABI, symbols marked as requiring non-PIC to PIC
+     call stubs (such symbols being defined in PIC code) should by definition
+     never be undefined in a regular file.  It follows that such symbols
+     should never have PLT entries associated with them, nor copy relocs.  */
+  BFD_ASSERT (!htab->is_non_pic
+              || !hmips->has_non_pic_to_pic_stub
+	      || !needs_plt_entry
+	      || !h->non_got_ref);
+
+  /* Calculate the number of bytes required for a relocation
+     in .rel[a].plt.  */
+  if (htab->is_vxworks)
+    reloc_size = sizeof (Elf32_External_Rela);
+  else
+    reloc_size = sizeof (Elf32_External_Rel);
+
+  if ((htab->is_vxworks && h->needs_plt)
+      || (htab->is_non_pic && needs_plt_entry))
     {
+      /* VxWorks can have PLT entries in shared libraries; but this never
+         happens with the non-PIC ABI.  In the non-PIC case, every symbol
+	 being dealt with here should be undefined in a regular file.  */
+      BFD_ASSERT (htab->is_vxworks || !h->def_regular);
+
       /* If this is the first symbol to need a PLT entry, allocate room
-	 for the header, and for the header's .rela.plt.unloaded entries.  */
+	 for the first PLT (header) entry, and on VxWorks for the header's
+	 .rela.plt.unloaded entries.  For the non-PIC ABI, also allocate
+         room at the start of .got.plt for the PLT resolver and link
+         map pointers.  */
       if (htab->splt->size == 0)
 	{
-	  htab->splt->size += htab->plt_header_size;
-	  if (!info->shared)
-	    htab->srelplt2->size += 2 * sizeof (Elf32_External_Rela);
+	  htab->splt->size = htab->plt_header_size;
+	  if (!info->shared && htab->is_vxworks)
+	    {
+	      BFD_ASSERT (htab->srelplt2->size == 0);
+	      htab->srelplt2->size = 2 * reloc_size;
+	    }
+	  if (htab->is_non_pic)
+	    {
+	      BFD_ASSERT (htab->sgotplt->size == 0);
+	      /* Leave space for the PLT resolver and link map pointers.  */
+	      htab->sgotplt->size = 8;
+	    }
+	  BFD_ASSERT (htab->srelplt->size == 0);
 	}
 
       /* Assign the next .plt entry to this symbol.  */
-      h->plt.offset = htab->splt->size;
-      htab->splt->size += htab->plt_entry_size;
+      if (htab->is_vxworks)
+        h->plt.offset = htab->splt->size;
+      else
+        hmips->plt_entry_offset = htab->splt->size;
+      htab->splt->size += mips_elf_next_plt_entry_size (htab);
 
       /* If the output file has no definition of the symbol, set the
-	 symbol's value to the address of the stub.  Point at the PLT
-	 load stub rather than the lazy resolution stub; this stub
-	 will become the canonical function address.  */
+	 symbol's value to the address of the stub.  Note the
+	 assertion above that h->def_regular will always be false
+	 under the non-PIC ABI.  */
       if (!info->shared && !h->def_regular)
 	{
 	  h->root.u.def.section = htab->splt;
-	  h->root.u.def.value = h->plt.offset;
-	  h->root.u.def.value += 8;
+	  h->root.u.def.value = htab->is_vxworks ?
+	  			h->plt.offset : hmips->plt_entry_offset;
+	  if (htab->is_non_pic)
+	    {
+	      /* Make sure the dynamic linker knows that the symbol's value
+		 points at a PLT entry and not at a .MIPS.stubs entry.  */
+	      h->other = STO_MIPS_PLT;
+	    }
+	  /* On VxWorks, point at the PLT load stub rather than the
+	     lazy resolution stub; this stub will become the canonical
+	     function address.  */
+  	  if (htab->is_vxworks)
+	    h->root.u.def.value += 8;
 	}
 
-      /* Make room for the .got.plt entry and the R_JUMP_SLOT relocation.  */
+      /* Make room for the .got.plt entry, and the R_JUMP_SLOT relocation
+	 in .rel[a].plt.  */
       htab->sgotplt->size += 4;
-      htab->srelplt->size += sizeof (Elf32_External_Rela);
+      htab->srelplt->size += reloc_size;
 
-      /* Make room for the .rela.plt.unloaded relocations.  */
-      if (!info->shared)
-	htab->srelplt2->size += 3 * sizeof (Elf32_External_Rela);
+      /* Make room for the .rela.plt.unloaded relocations on VxWorks.  */
+      if (htab->is_vxworks && !info->shared)
+	htab->srelplt2->size += 3 * reloc_size;
 
       return TRUE;
     }
 
+  /* If we reach this point for non-PIC, then we have created a
+     .MIPS.stubs stub (unless no_fn_stub) but not a PLT entry since one was
+     not required.  We're done.  */
+  BFD_ASSERT (!htab->is_non_pic || !needs_plt_entry);
+  if (htab->is_non_pic && h->needs_plt)
+    return TRUE;
+
+  /* We should never reach this point on VxWorks or the non-PIC ABI if
+     we have created a PLT entry or a .MIPS.stubs-style stub
+     respectively.  */
+  BFD_ASSERT (!h->needs_plt);
+
   /* If a function symbol is defined by a dynamic object, and we do not
-     need a PLT stub for it, the symbol's value should be zero.  */
+     need a PLT entry for it, the symbol's value should be zero.  */
   if (h->type == STT_FUNC
       && h->def_dynamic
       && h->ref_regular
@@ -7510,11 +7855,19 @@ _bfd_mips_vxworks_adjust_dynamic_symbol 
       return TRUE;
     }
 
-  /* This is a reference to a symbol defined by a dynamic object which
+  /* We have a reference to a symbol defined by a dynamic object which
      is not a function.  */
+  BFD_ASSERT (h->ref_regular && h->def_dynamic && !h->def_regular);
+  BFD_ASSERT (h->type != STT_FUNC);
+
+  /* If creating a shared library, we are done.  */
   if (info->shared)
     return TRUE;
 
+  /* If this symbol does not require a copy reloc, we are done.  */
+  if (!h->non_got_ref)
+    return TRUE;
+
   /* We must allocate the symbol in our .dynbss section, which will
      become part of the .bss section of the executable.  There will be
      an entry for this symbol in the .dynsym section.  The dynamic
@@ -7524,10 +7877,14 @@ _bfd_mips_vxworks_adjust_dynamic_symbol 
      determine the address it must put in the global offset table, so
      both the dynamic object and the regular object will refer to the
      same memory location for the variable.  */
-
+  BFD_ASSERT (!h->needs_copy);
   if ((h->root.u.def.section->flags & SEC_ALLOC) != 0)
     {
-      htab->srelbss->size += sizeof (Elf32_External_Rela);
+      if (htab->is_non_pic)
+        mips_elf_allocate_dynamic_relocations (dynobj, info, 1);
+      else
+        htab->srelbss->size += sizeof (Elf32_External_Rela);
+      /* Note that this symbol definitely needs a copy reloc.  */
       h->needs_copy = 1;
     }
 
@@ -7560,6 +7917,35 @@ count_section_dynsyms (bfd *output_bfd, 
   return count;
 }
 
+/* Determine if a symbol requires a non-PIC to PIC call stub to be
+   created for it.  If so, mark it as such and allocate space for the
+   stub code.  */
+
+static int
+mips_elf_maybe_create_non_pic_to_pic_stub (void *h_ptr, void *htab_ptr)
+{
+  struct mips_elf_link_hash_entry *h =
+    (struct mips_elf_link_hash_entry *) h_ptr;
+  struct mips_elf_link_hash_table *htab =
+    (struct mips_elf_link_hash_table *) htab_ptr;
+
+  if (h != NULL
+      && h->root.def_regular
+      && !h->root.def_dynamic
+      && !h->has_non_pic_to_pic_stub
+      && h->is_branch_target
+      && !NON_PIC_P (h->root.root.u.def.section->owner))
+    {
+      BFD_ASSERT (htab->snonpictopic != NULL);
+
+      h->plt_entry_offset = htab->snonpictopic->size;
+      htab->snonpictopic->size += 4 * ARRAY_SIZE (mips_non_pic_to_pic_stub);
+      h->has_non_pic_to_pic_stub = TRUE;
+    }
+
+  return 1;
+}
+
 /* This function is called after all the input files have been read,
    and the input sections have been assigned to output sections.  We
    check for any mips16 stub sections that we can discard.  */
@@ -7702,6 +8088,25 @@ _bfd_mips_elf_always_size_sections (bfd 
     }
   htab->computed_got_sizes = TRUE;
 
+  /* Identify symbols that require non-PIC to PIC call stubs.
+     Allocate space for any such stubs.  */
+  if (htab->is_non_pic)
+    {
+      BFD_ASSERT (htab->snonpictopic != NULL);
+
+      elf_link_hash_traverse (elf_hash_table (info),
+			      mips_elf_maybe_create_non_pic_to_pic_stub, htab);
+      if (htab->snonpictopic->size != 0)
+	{
+	  htab->snonpictopic->contents = bfd_zalloc (output_bfd,
+						     htab->snonpictopic->size);
+	  if (htab->snonpictopic->contents == NULL)
+	    return FALSE;
+	}
+      else
+	htab->snonpictopic->flags |= SEC_EXCLUDE;
+    }
+
   return TRUE;
 }
 
@@ -7887,11 +8292,19 @@ _bfd_mips_elf_size_dynamic_sections (bfd
       else if (SGI_COMPAT (output_bfd)
 	       && CONST_STRNEQ (name, ".compact_rel"))
 	s->size += mips_elf_hash_table (info)->compact_rel_size;
+      else if (s == htab->splt)
+	{
+	  /* If the last PLT entry has a branch delay slot, allocate
+	     room for an extra nop to fill the delay slot.  */
+	  if (s->size - htab->plt_header_size
+	      <= htab->plt_entry_size * MIPS_NONPIC_LARGE_PLT_THRESHOLD)
+	    s->size += 4;
+	}
       else if (! CONST_STRNEQ (name, ".init")
-	       && s != htab->sgotplt
-	       && s != htab->splt)
+	       && s != htab->sgotplt)
 	{
-	  /* It's not one of our sections, so don't allocate space.  */
+	  /* It's not one of our sections, or it's the non-PIC to PIC stubs
+	     section that is allocated elsewhere, so don't allocate space.  */
 	  continue;
 	}
 
@@ -8034,6 +8447,24 @@ _bfd_mips_elf_size_dynamic_sections (bfd
 	  if (! MIPS_ELF_ADD_DYNAMIC_ENTRY (info, DT_MIPS_GOTSYM, 0))
 	    return FALSE;
 
+	  if (htab->is_non_pic && htab->splt->size > 0)
+	    {
+	      if (! MIPS_ELF_ADD_DYNAMIC_ENTRY (info, DT_PLTREL, 0))
+		return FALSE;
+
+	      if (! MIPS_ELF_ADD_DYNAMIC_ENTRY (info, DT_JMPREL, 0))
+		return FALSE;
+
+	      if (! MIPS_ELF_ADD_DYNAMIC_ENTRY (info, DT_PLTRELSZ, 0))
+		return FALSE;
+
+	      if (! MIPS_ELF_ADD_DYNAMIC_ENTRY (info, DT_MIPS_PLTGOT, 0))
+		return FALSE;
+
+	      if (! MIPS_ELF_ADD_DYNAMIC_ENTRY (info, DT_MIPS_RWPLT, 0))
+		return FALSE;
+	    }
+
 	  if (IRIX_COMPAT (dynobj) == ict_irix5
 	      && ! MIPS_ELF_ADD_DYNAMIC_ENTRY (info, DT_MIPS_HIPAGENO, 0))
 	    return FALSE;
@@ -8505,11 +8936,14 @@ _bfd_mips_elf_finish_dynamic_symbol (bfd
   const char *name;
   int idx;
   struct mips_elf_link_hash_table *htab;
+  struct mips_elf_link_hash_entry *hmips;
+
+  hmips = (struct mips_elf_link_hash_entry *) h;
 
   htab = mips_elf_hash_table (info);
   dynobj = elf_hash_table (info)->dynobj;
 
-  if (h->plt.offset != MINUS_ONE)
+  if (h->plt.offset != MINUS_ONE && h->needs_plt)
     {
       asection *s;
       bfd_byte stub[MIPS_FUNCTION_STUB_BIG_SIZE];
@@ -8556,7 +8990,7 @@ _bfd_mips_elf_finish_dynamic_symbol (bfd
         bfd_put_32 (output_bfd, STUB_LI16S (output_bfd, h->dynindx),
 		    stub + idx);
 
-      BFD_ASSERT (h->plt.offset <= s->size);
+      BFD_ASSERT (h->plt.offset <= s->size - htab->function_stub_size);
       memcpy (s->contents + h->plt.offset, stub, htab->function_stub_size);
 
       /* Mark the symbol as undefined.  plt.offset != -1 occurs
@@ -8569,6 +9003,107 @@ _bfd_mips_elf_finish_dynamic_symbol (bfd
       sym->st_value = (s->output_section->vma + s->output_offset
 		       + h->plt.offset);
     }
+  else if (hmips->plt_entry_offset != (bfd_vma) -1
+           && !hmips->has_non_pic_to_pic_stub)
+    {
+      /* Fill in the PLT, .got.plt and .rel.plt entries for this symbol.  */
+
+      bfd_byte *loc;
+      bfd_vma plt_address, plt_index, gotplt_address;
+      Elf_Internal_Rela rel;
+      static const bfd_vma *plt_entry;
+      bfd_vma gotplt_address_high, gotplt_address_low;
+
+      BFD_ASSERT (!info->shared);
+      BFD_ASSERT (h->dynindx != -1);
+      BFD_ASSERT (htab->splt != NULL);
+      BFD_ASSERT (hmips->plt_entry_offset < htab->splt->size);
+
+      /* Calculate the address of the .plt entry.  */
+      plt_address = (htab->splt->output_section->vma
+		     + htab->splt->output_offset
+		     + hmips->plt_entry_offset);
+
+      /* Calculate the (0-based) index, in words, of the .rel.plt entry,
+         taking into account whether this is a large PLT entry or not.
+         The index into .got.plt is this index plus two (to skip over
+         the PLT resolver and link map pointers at the start of the
+         PLT GOT.)  */
+      if (hmips->plt_entry_offset
+          >= htab->plt_header_size
+	     + htab->plt_entry_size * MIPS_NONPIC_LARGE_PLT_THRESHOLD)
+	/* This entry is a large PLT entry.  */
+	plt_index = ((hmips->plt_entry_offset - htab->plt_header_size
+		      - htab->plt_entry_size * MIPS_NONPIC_LARGE_PLT_THRESHOLD)
+		     / htab->large_plt_entry_size
+		     + MIPS_NONPIC_LARGE_PLT_THRESHOLD);
+      else
+        {
+	  /* This entry is a normal PLT entry.  */
+	  plt_index = ((hmips->plt_entry_offset - htab->plt_header_size)
+		       / htab->plt_entry_size);
+	  BFD_ASSERT (plt_index < MIPS_NONPIC_LARGE_PLT_THRESHOLD);
+	}
+
+      /* Calculate the address of the .got.plt entry.  The addition of 8
+         is to allow for the PLT resolver and link map pointers at the
+         start of .got.plt.  */
+      gotplt_address = (htab->sgotplt->output_section->vma
+			+ htab->sgotplt->output_offset
+			+ 8 + plt_index * 4);
+
+      /* Split the address of the .got.plt entry into high and low
+	 parts.  The 0x8000 bias is to compensate for the fact that the addiu
+	 instruction into which the low part will be written accepts a
+	 _signed_ immediate.  */
+      gotplt_address_high = ((gotplt_address + 0x8000) >> 16) & 0xffff;
+      gotplt_address_low = gotplt_address & 0xffff;
+
+      /* Fill in the initial value (the address of the first PLT entry)
+	 of the .got.plt entry.  */
+      bfd_put_32 (output_bfd, plt_address - hmips->plt_entry_offset,
+		  htab->sgotplt->contents + 8 + plt_index * 4);
+
+      /* Find out where the .plt entry should go.
+         Note the use of hmips->plt_entry_offset to save distinguishing between
+	 large and small PLT entries.  */
+      loc = htab->splt->contents + hmips->plt_entry_offset;
+
+      /* Choose the PLT entry template to use and write it, suitably
+         filled, to the output bfd.  */
+      if (plt_index >= MIPS_NONPIC_LARGE_PLT_THRESHOLD)
+        {
+	  /* Large PLT entry.  */
+      	  plt_entry = mips_non_pic_large_exec_plt_entry;
+	  bfd_put_32 (output_bfd, plt_entry[0] | gotplt_address_high, loc);
+	  bfd_put_32 (output_bfd, plt_entry[1] | gotplt_address_low, loc + 4);
+	  bfd_put_32 (output_bfd, plt_entry[2] | (plt_index >> 16), loc + 8);
+	  bfd_put_32 (output_bfd, plt_entry[3], loc + 12);
+	  bfd_put_32 (output_bfd, plt_entry[4] | (plt_index & 0xffff),
+	  	      loc + 16);
+	  bfd_put_32 (output_bfd, plt_entry[5], loc + 20);
+	  bfd_put_32 (output_bfd, plt_entry[6], loc + 24);
+	  bfd_put_32 (output_bfd, plt_entry[7], loc + 28);
+	}
+      else
+      	{
+	  /* Normal PLT entry.  */
+	  plt_entry = mips_non_pic_exec_plt_entry;
+	  bfd_put_32 (output_bfd, plt_entry[0] | gotplt_address_high, loc);
+	  bfd_put_32 (output_bfd, plt_entry[1] | gotplt_address_low, loc + 4);
+	  bfd_put_32 (output_bfd, plt_entry[2] | plt_index, loc + 8);
+	  bfd_put_32 (output_bfd, plt_entry[3], loc + 12);
+	}
+
+      /* Emit an R_MIPS_JUMP_SLOT relocation against the .got.plt entry.  */
+      loc = htab->srelplt->contents + plt_index * sizeof (Elf32_External_Rel);
+      rel.r_offset = gotplt_address;
+      rel.r_info = ELF32_R_INFO (h->dynindx, R_MIPS_JUMP_SLOT);
+      bfd_elf32_swap_reloc_out (output_bfd, &rel, loc);
+
+      /* Mark the symbol as undefined.  */
+      sym->st_shndx = SHN_UNDEF;
+    }
 
   BFD_ASSERT (h->dynindx != -1
 	      || h->forced_local);
@@ -8718,6 +9253,29 @@ _bfd_mips_elf_finish_dynamic_symbol (bfd
 	}
     }
 
+  /* Emit a copy reloc, if needed.  */
+  if (htab->is_non_pic && h->needs_copy)
+    {
+      asection *relsec;
+      Elf_Internal_Rela rel;
+      bfd_byte *reloff;	  /* dyn.rel offset for this copy reloc  */
+
+      relsec = mips_elf_rel_dyn_section (info, FALSE);
+      BFD_ASSERT (relsec != NULL);
+      BFD_ASSERT (h->dynindx != -1);
+
+      reloff = relsec->contents
+                 + (relsec->reloc_count * sizeof (Elf32_External_Rel));
+
+      rel.r_addend = 0;
+      rel.r_info   = ELF_R_INFO (output_bfd, (unsigned long) h->dynindx, R_MIPS_COPY);
+      rel.r_offset = (h->root.u.def.section->output_section->vma
+                      + h->root.u.def.section->output_offset
+                      + h->root.u.def.value);
+      bfd_elf32_swap_reloc_out (output_bfd, &rel, reloff);
+      ++relsec->reloc_count;
+    }
+
   /* If this is a mips16 symbol, force the value to be even.  */
   if (sym->st_other == STO_MIPS16)
     sym->st_value &= ~1;
@@ -8897,6 +9455,41 @@ _bfd_mips_vxworks_finish_dynamic_symbol 
   return TRUE;
 }
 
+/* Install the PLT header for a non-PIC executable.  */
+
+static void
+mips_non_pic_finish_plt (bfd *output_bfd, struct bfd_link_info *info)
+{
+  bfd_byte *loc;
+  bfd_vma plt_address;
+  static const bfd_vma *plt_entry;
+  struct mips_elf_link_hash_table *htab;
+  bfd_vma got_plt, got_plt_high, got_plt_low;
+
+  htab = mips_elf_hash_table (info);
+  plt_entry = mips_non_pic_exec_plt0_entry;
+
+  /* Calculate the address of .got.plt and split it into high and low
+     parts.  The 0x8000 bias is to compensate for the fact that the addiu
+     instruction into which the low part will be written accepts a
+     _signed_ immediate.  */
+  got_plt = htab->sgotplt->output_section->vma + htab->sgotplt->output_offset;
+  got_plt_high = ((got_plt + 0x8000) >> 16) & 0xffff;
+  got_plt_low = got_plt & 0xffff;
+
+  /* Calculate the address of the PLT header.  */
+  plt_address = htab->splt->output_section->vma + htab->splt->output_offset;
+
+  /* Install the PLT header.  */
+  loc = htab->splt->contents;
+  bfd_put_32 (output_bfd, plt_entry[0] | got_plt_high, loc);
+  bfd_put_32 (output_bfd, plt_entry[1] | got_plt_low, loc + 4);
+  bfd_put_32 (output_bfd, plt_entry[2], loc + 8);
+  bfd_put_32 (output_bfd, plt_entry[3], loc + 12);
+  bfd_put_32 (output_bfd, plt_entry[4], loc + 16);
+  bfd_put_32 (output_bfd, plt_entry[5], loc + 20);
+}
+
 /* Install the PLT header for a VxWorks executable and finalize the
    contents of .rela.plt.unloaded.  */
 
@@ -9059,20 +9652,21 @@ _bfd_mips_elf_finish_dynamic_sections (b
 
 	    case DT_PLTGOT:
 	      name = ".got";
-	      if (htab->is_vxworks)
-		{
-		  /* _GLOBAL_OFFSET_TABLE_ is defined to be the beginning
-		     of the ".got" section in DYNOBJ.  */
-		  s = bfd_get_section_by_name (dynobj, name);
-		  BFD_ASSERT (s != NULL);
-		  dyn.d_un.d_ptr = s->output_section->vma + s->output_offset;
-		}
-	      else
-		{
-		  s = bfd_get_section_by_name (output_bfd, name);
-		  BFD_ASSERT (s != NULL);
-		  dyn.d_un.d_ptr = s->vma;
-		}
+	      /* _GLOBAL_OFFSET_TABLE_ is defined to be the beginning
+		 of the ".got" section in DYNOBJ.  */
+	      s = bfd_get_section_by_name (dynobj, name);
+	      BFD_ASSERT (s != NULL);
+	      dyn.d_un.d_ptr = s->output_section->vma + s->output_offset;
+	      break;
+
+	    case DT_MIPS_PLTGOT:
+	      BFD_ASSERT (htab->is_non_pic);
+              dyn.d_un.d_val = (htab->sgotplt->output_section->vma
+                                + htab->sgotplt->output_offset);
+	      break;
+
+	    case DT_MIPS_RWPLT:
+	      BFD_ASSERT (htab->is_non_pic);
 	      break;
 
 	    case DT_MIPS_RLD_VERSION:
@@ -9159,17 +9753,17 @@ _bfd_mips_elf_finish_dynamic_sections (b
 	      break;
 
 	    case DT_PLTREL:
-	      BFD_ASSERT (htab->is_vxworks);
-	      dyn.d_un.d_val = DT_RELA;
+	      BFD_ASSERT (htab->is_vxworks || htab->is_non_pic);
+	      dyn.d_un.d_val = htab->is_vxworks ? DT_RELA : DT_REL;
 	      break;
 
 	    case DT_PLTRELSZ:
-	      BFD_ASSERT (htab->is_vxworks);
+	      BFD_ASSERT (htab->is_vxworks || htab->is_non_pic);
 	      dyn.d_un.d_val = htab->srelplt->size;
 	      break;
 
 	    case DT_JMPREL:
-	      BFD_ASSERT (htab->is_vxworks);
+	      BFD_ASSERT (htab->is_vxworks || htab->is_non_pic);
 	      dyn.d_un.d_val = (htab->srelplt->output_section->vma
 				+ htab->srelplt->output_offset);
 	      break;
@@ -9407,6 +10001,10 @@ _bfd_mips_elf_finish_dynamic_sections (b
       else
 	mips_vxworks_finish_exec_plt (output_bfd, info);
     }
+
+  if (htab->is_non_pic && htab->splt && htab->splt->size > 0)
+    mips_non_pic_finish_plt (output_bfd, info);
+
   return TRUE;
 }
 
@@ -9994,6 +10592,9 @@ _bfd_mips_elf_copy_indirect_symbol (stru
     dirmips->readonly_reloc = TRUE;
   if (indmips->no_fn_stub)
     dirmips->no_fn_stub = TRUE;
+  if (indmips->has_non_pic_to_pic_stub)
+    dirmips->has_non_pic_to_pic_stub = TRUE;
+  dirmips->is_branch_target |= indmips->is_branch_target;
 
   if (dirmips->tls_type == 0)
     dirmips->tls_type = indmips->tls_type;
@@ -10540,6 +11141,7 @@ _bfd_mips_elf_link_hash_table_create (bf
   ret->mips16_stubs_seen = FALSE;
   ret->computed_got_sizes = FALSE;
   ret->is_vxworks = FALSE;
+  ret->is_non_pic = FALSE;
   ret->small_data_overflow_reported = FALSE;
   ret->srelbss = NULL;
   ret->sdynbss = NULL;
@@ -10547,6 +11149,7 @@ _bfd_mips_elf_link_hash_table_create (bf
   ret->srelplt2 = NULL;
   ret->sgotplt = NULL;
   ret->splt = NULL;
+  ret->snonpictopic = NULL;
   ret->plt_header_size = 0;
   ret->plt_entry_size = 0;
   ret->function_stub_size = 0;
@@ -10571,6 +11174,7 @@ _bfd_mips_vxworks_link_hash_table_create
     }
   return ret;
 }
+
 
 /* We need to use a special link routine to handle the .reginfo and
    the .mdebug sections.  We need to merge all instances of these
@@ -11558,12 +12162,6 @@ _bfd_mips_elf_merge_private_bfd_data (bf
   new_flags &= ~EF_MIPS_UCODE;
   old_flags &= ~EF_MIPS_UCODE;
 
-  /* Don't care about the PIC flags from dynamic objects; they are
-     PIC by design.  */
-  if ((new_flags & (EF_MIPS_PIC | EF_MIPS_CPIC)) != 0
-      && (ibfd->flags & DYNAMIC) != 0)
-    new_flags &= ~ (EF_MIPS_PIC | EF_MIPS_CPIC);
-
   if (new_flags == old_flags)
     return TRUE;
 
@@ -11585,19 +12183,18 @@ _bfd_mips_elf_merge_private_bfd_data (bf
 	  break;
 	}
     }
-  if (null_input_bfd)
+  /* Dynamic objects normally have no sections, and do not reach
+     here - but they might if used as DYNOBJ.  */
+  if (null_input_bfd || (ibfd->flags & DYNAMIC) != 0)
     return TRUE;
 
   ok = TRUE;
 
   if (((new_flags & (EF_MIPS_PIC | EF_MIPS_CPIC)) != 0)
       != ((old_flags & (EF_MIPS_PIC | EF_MIPS_CPIC)) != 0))
-    {
-      (*_bfd_error_handler)
-	(_("%B: warning: linking PIC files with non-PIC files"),
-	 ibfd);
-      ok = TRUE;
-    }
+    (*_bfd_error_handler)
+      (_("%B: warning: linking PIC files with non-PIC files"),
+       ibfd);
 
   if (new_flags & (EF_MIPS_PIC | EF_MIPS_CPIC))
     elf_elfheader (obfd)->e_flags |= EF_MIPS_CPIC;
@@ -11805,6 +12402,10 @@ _bfd_mips_elf_get_target_dtag (bfd_vma d
       return "DT_MIPS_GP_VALUE";
     case DT_MIPS_AUX_DYNAMIC:
       return "DT_MIPS_AUX_DYNAMIC";
+    case DT_MIPS_PLTGOT:
+      return "DT_MIPS_PLTGOT";
+    case DT_MIPS_RWPLT:
+      return "DT_MIPS_RWPLT";
     }
 }
 
@@ -11939,3 +12540,133 @@ _bfd_mips_elf_common_definition (Elf_Int
 	  || sym->st_shndx == SHN_MIPS_ACOMMON
 	  || sym->st_shndx == SHN_MIPS_SCOMMON);
 }
+
+/* Return address for Ith PLT stub in section PLT, for relocation REL
+   or (bfd_vma) -1 if it should not be included.  */
+
+bfd_vma
+_bfd_mips_elf_plt_sym_val (bfd_vma i, const asection *plt,
+                           const arelent *rel ATTRIBUTE_UNUSED)
+{
+  if (i > MIPS_NONPIC_LARGE_PLT_THRESHOLD)
+    return (plt->vma + 4 * ARRAY_SIZE (mips_non_pic_exec_plt0_entry)
+	    + (MIPS_NONPIC_LARGE_PLT_THRESHOLD
+	       * 4 * ARRAY_SIZE (mips_non_pic_exec_plt_entry))
+            + ((i - MIPS_NONPIC_LARGE_PLT_THRESHOLD)
+	       * 4 * ARRAY_SIZE (mips_non_pic_large_exec_plt_entry)));
+  else
+    return (plt->vma + 4 * ARRAY_SIZE (mips_non_pic_exec_plt0_entry)
+            + i * 4 * ARRAY_SIZE (mips_non_pic_exec_plt_entry));
+}
+
+/* Generate non-PIC to PIC call stubs for all symbols which need them.  */
+
+static bfd_boolean
+mips_elf_nonpic_stub (struct elf_link_hash_entry *h, void *info)
+{
+  struct bfd_link_info *link_info = info;
+  struct mips_elf_link_hash_table *htab = mips_elf_hash_table (link_info);
+  struct bfd *abfd = htab->non_pic_bfd;
+  struct mips_elf_link_hash_entry *hmips;
+  bfd_vma target_address, target_high, target_low;
+  bfd_byte *loc;
+  asection *sec;
+
+  hmips = (struct mips_elf_link_hash_entry *) h;
+  if (!hmips->has_non_pic_to_pic_stub)
+    return TRUE;
+
+  BFD_ASSERT (!link_info->shared);
+  BFD_ASSERT (h->def_regular);
+  BFD_ASSERT (!h->def_dynamic);
+  BFD_ASSERT (htab->snonpictopic != NULL);
+  BFD_ASSERT (htab->snonpictopic->contents != NULL);
+  BFD_ASSERT (htab->snonpictopic->output_section != NULL);
+  BFD_ASSERT (hmips->plt_entry_offset < htab->snonpictopic->size);
+
+  sec = h->root.u.def.section;
+
+  /* Determine the address (to which the stub will branch) of the
+     symbol, split into two halves as required by the stub
+     instructions.  */
+  if (sec->output_section)
+    target_address = h->root.u.def.value
+      + sec->output_section->vma
+      + sec->output_offset;
+  else
+    target_address = h->root.u.def.value;
+
+  target_high = ((target_address + 0x8000) >> 16) & 0xffff;
+  target_low = target_address & 0xffff;
+
+  /* Fill the stub with instructions.  */
+  loc = htab->snonpictopic->contents + hmips->plt_entry_offset;
+  bfd_put_32 (abfd, mips_non_pic_to_pic_stub[0] | target_high, loc);
+  bfd_put_32 (abfd, mips_non_pic_to_pic_stub[1] | target_low,
+	      loc + 4);
+  bfd_put_32 (abfd, mips_non_pic_to_pic_stub[2], loc + 8);
+  bfd_put_32 (abfd, mips_non_pic_to_pic_stub[3], loc + 12);
+
+  return TRUE;
+}
+
+void
+_bfd_mips_elf_begin_write_processing (bfd *abfd ATTRIBUTE_UNUSED, 
+				      struct bfd_link_info *link_info)
+{
+  struct mips_elf_link_hash_table *htab;
+
+  if (!link_info)
+    return;
+
+  htab = mips_elf_hash_table (link_info);
+  if (htab->snonpictopic == NULL || !htab->is_non_pic)
+    return;
+
+  elf_link_hash_traverse (&htab->root, mips_elf_nonpic_stub, link_info);
+}
+
+/* If performing a non-PIC link, create the section to be used for
+   non-PIC to PIC call stubs.  */
+
+bfd_boolean
+bfd_mips_elf_maybe_create_non_pic_to_pic_stubs_section
+  (struct bfd_link_info *info)
+{
+  struct mips_elf_link_hash_table *htab = mips_elf_hash_table (info);
+  bfd *abfd = htab->non_pic_bfd;
+  flagword flags;
+
+  if (info->relocatable)
+    return TRUE;
+  if (!htab->is_non_pic)
+    return TRUE;
+
+  flags = (SEC_ALLOC | SEC_LOAD | SEC_HAS_CONTENTS | SEC_IN_MEMORY
+	   | SEC_READONLY | SEC_LINKER_CREATED);
+  htab->snonpictopic =
+    bfd_make_section_with_flags (abfd,
+				 NON_PIC_TO_PIC_STUB_SECTION_NAME,
+				 flags | SEC_CODE);
+  if (htab->snonpictopic == NULL
+      || ! bfd_set_section_alignment (abfd, htab->snonpictopic,
+				      MIPS_ELF_LOG_FILE_ALIGN (abfd)))
+    return FALSE;
+
+  return TRUE;
+}
+
+void
+_bfd_mips_post_process_headers (bfd *abfd, struct bfd_link_info *link_info)
+{
+  struct mips_elf_link_hash_table *htab;
+  Elf_Internal_Ehdr *i_ehdrp;
+
+  i_ehdrp = elf_elfheader (abfd);
+  if (link_info)
+    {
+      htab = mips_elf_hash_table (link_info);
+      if (htab->is_non_pic)
+	i_ehdrp->e_ident[EI_ABIVERSION] = 1;
+    }
+}
Index: bfd/elfxx-mips.h
===================================================================
RCS file: /cvs/src/src/bfd/elfxx-mips.h,v
retrieving revision 1.38
diff -u -p -r1.38 elfxx-mips.h
--- bfd/elfxx-mips.h	27 Feb 2008 17:06:06 -0000	1.38
+++ bfd/elfxx-mips.h	1 Jul 2008 16:08:50 -0000
@@ -50,7 +50,7 @@ extern bfd_boolean _bfd_mips_elf_check_r
   (bfd *, struct bfd_link_info *, asection *, const Elf_Internal_Rela *);
 extern bfd_boolean _bfd_mips_elf_adjust_dynamic_symbol
   (struct bfd_link_info *, struct elf_link_hash_entry *);
-extern bfd_boolean _bfd_mips_vxworks_adjust_dynamic_symbol
+extern bfd_boolean _bfd_mips_plt_adjust_dynamic_symbol
   (struct bfd_link_info *, struct elf_link_hash_entry *);
 extern bfd_boolean _bfd_mips_elf_always_size_sections
   (bfd *, struct bfd_link_info *);
@@ -65,6 +65,9 @@ extern bfd_boolean _bfd_mips_elf_finish_
 extern bfd_boolean _bfd_mips_vxworks_finish_dynamic_symbol
   (bfd *, struct bfd_link_info *, struct elf_link_hash_entry *,
    Elf_Internal_Sym *);
+extern bfd_boolean _bfd_mips_nonpic_finish_dynamic_symbol
+  (bfd *, struct bfd_link_info *, struct elf_link_hash_entry *,
+   Elf_Internal_Sym *);
 extern bfd_boolean _bfd_mips_elf_finish_dynamic_sections
   (bfd *, struct bfd_link_info *);
 extern void _bfd_mips_elf_final_write_processing
@@ -146,6 +149,15 @@ extern const struct bfd_elf_special_sect
 
 extern bfd_boolean _bfd_mips_elf_common_definition (Elf_Internal_Sym *);
 
+extern bfd_vma _bfd_mips_elf_plt_sym_val
+  (bfd_vma, const asection *, const arelent *); 
+extern void _bfd_mips_elf_begin_write_processing
+  (bfd *abfd, struct bfd_link_info *link_info);
+extern bfd_boolean bfd_mips_elf_maybe_create_non_pic_to_pic_stubs_section
+  (struct bfd_link_info *);
+extern void _bfd_mips_post_process_headers
+  (bfd *abfd, struct bfd_link_info *link_info);
+
 #define elf_backend_common_definition   _bfd_mips_elf_common_definition
 #define elf_backend_name_local_section_symbols \
   _bfd_mips_elf_name_local_section_symbols
@@ -153,3 +165,5 @@ extern bfd_boolean _bfd_mips_elf_common_
 #define elf_backend_eh_frame_address_size _bfd_mips_elf_eh_frame_address_size
 #define elf_backend_merge_symbol_attribute  _bfd_mips_elf_merge_symbol_attribute
 #define elf_backend_ignore_undef_symbol _bfd_mips_elf_ignore_undef_symbol
+#define elf_backend_post_process_headers _bfd_mips_post_process_headers
+#define elf_backend_begin_write_processing _bfd_mips_elf_begin_write_processing
Index: bfd/reloc.c
===================================================================
RCS file: /cvs/src/src/bfd/reloc.c,v
retrieving revision 1.174
diff -u -p -r1.174 reloc.c
--- bfd/reloc.c	16 Apr 2008 08:51:18 -0000	1.174
+++ bfd/reloc.c	1 Jul 2008 16:08:50 -0000
@@ -2251,7 +2251,7 @@ ENUM
 ENUMX
   BFD_RELOC_MIPS_JUMP_SLOT
 ENUMDOC
-  MIPS ELF relocations (VxWorks extensions).
+  MIPS ELF relocations (VxWorks and non-PIC extensions).
 COMMENT
 
 ENUM
Index: binutils/readelf.c
===================================================================
RCS file: /cvs/src/src/binutils/readelf.c,v
retrieving revision 1.411
diff -u -p -r1.411 readelf.c
--- binutils/readelf.c	18 Jun 2008 10:49:50 -0000	1.411
+++ binutils/readelf.c	1 Jul 2008 16:08:50 -0000
@@ -1495,6 +1495,9 @@ get_mips_dynamic_type (unsigned long typ
     case DT_MIPS_COMPACT_SIZE: return "MIPS_COMPACT_SIZE";
     case DT_MIPS_GP_VALUE: return "MIPS_GP_VALUE";
     case DT_MIPS_AUX_DYNAMIC: return "MIPS_AUX_DYNAMIC";
+    case DT_MIPS_PLTGOT: return "MIPS_PLTGOT";
+    case DT_MIPS_RWPLT: return "MIPS_RWPLT";
+
     default:
       return NULL;
     }
@@ -7145,6 +7148,7 @@ get_mips_symbol_other (unsigned int othe
     {
     case STO_OPTIONAL:  return "OPTIONAL";
     case STO_MIPS16:    return "MIPS16";
+    case STO_MIPS_PLT:  return "MIPS_PLT";
     default:      	return NULL;
     }
 }
Index: gas/config/tc-mips.c
===================================================================
RCS file: /cvs/src/src/gas/config/tc-mips.c,v
retrieving revision 1.388
diff -u -p -r1.388 tc-mips.c
--- gas/config/tc-mips.c	12 Jun 2008 21:44:53 -0000	1.388
+++ gas/config/tc-mips.c	1 Jul 2008 16:08:51 -0000
@@ -1854,6 +1854,12 @@ md_begin (void)
 	as_bad (_("-G may not be used in position-independent code"));
       g_switch_value = 0;
     }
+  else if (mips_abicalls)
+    {
+      if (g_switch_seen && g_switch_value != 0)
+	as_bad (_("-G may not be used with abicalls"));
+      g_switch_value = 0;
+    }
 
   if (! bfd_set_arch_mach (stdoutput, bfd_arch_mips, file_mips_arch))
     as_warn (_("Could not set architecture and machine"));
@@ -11166,6 +11172,8 @@ struct option md_longopts[] =
   {"mno-pdr", no_argument, NULL, OPTION_NO_PDR},
 #define OPTION_MVXWORKS_PIC (OPTION_ELF_BASE + 11)
   {"mvxworks-pic", no_argument, NULL, OPTION_MVXWORKS_PIC},
+#define OPTION_NON_PIC_ABICALLS (OPTION_ELF_BASE + 12)
+  {"mnon-pic-abicalls", no_argument, NULL, OPTION_NON_PIC_ABICALLS},
 #endif /* OBJ_ELF */
 
   {NULL, no_argument, NULL, 0}
@@ -11574,6 +11582,11 @@ md_parse_option (int c, char *arg)
     case OPTION_MVXWORKS_PIC:
       mips_pic = VXWORKS_PIC;
       break;
+
+    case OPTION_NON_PIC_ABICALLS:
+      mips_pic = NO_PIC;
+      mips_abicalls = TRUE;
+      break;
 #endif /* OBJ_ELF */
 
     default:
Index: include/elf/mips.h
===================================================================
RCS file: /cvs/src/src/include/elf/mips.h,v
retrieving revision 1.37
diff -u -p -r1.37 mips.h
--- include/elf/mips.h	11 Mar 2008 23:21:08 -0000	1.37
+++ include/elf/mips.h	1 Jul 2008 16:08:54 -0000
@@ -662,6 +662,13 @@ extern void bfd_mips_elf32_swap_reginfo_
 
 /* Address of auxiliary .dynamic.  */
 #define DT_MIPS_AUX_DYNAMIC	0x70000031
+
+/* Address of the base of the PLTGOT.  */
+#define DT_MIPS_PLTGOT		0x70000032
+
+/* Points to the base of a writable PLT.  */
+#define DT_MIPS_RWPLT		0x70000034
+
 
 /* Flags which may appear in a DT_MIPS_FLAGS entry.  */
 
@@ -723,6 +730,9 @@ extern void bfd_mips_elf32_swap_reginfo_
 #define STO_HIDDEN		STV_HIDDEN
 #define STO_PROTECTED		STV_PROTECTED
 
+/* Symbol value is the address of a PLT entry.  */
+#define STO_MIPS_PLT		0x8
+
 /* This value is used for a mips16 .text symbol.  */
 #define STO_MIPS16		0xf0
 
Index: ld/emulparams/elf32bmip.sh
===================================================================
RCS file: /cvs/src/src/ld/emulparams/elf32bmip.sh,v
retrieving revision 1.16
diff -u -p -r1.16 elf32bmip.sh
--- ld/emulparams/elf32bmip.sh	9 Aug 2007 11:02:24 -0000	1.16
+++ ld/emulparams/elf32bmip.sh	1 Jul 2008 16:08:54 -0000
@@ -35,6 +35,16 @@ OTHER_GOT_SYMBOLS='
   . = .;
   _gp = ALIGN(16) + 0x7ff0;
 '
+# Only non-PIC abicalls binaries (and VxWorks, which overrides these)
+# have .got.plt.  It should not go between the definition of _gp and
+# the start of .got.  It can go in the relro area, because it does not
+# need to be anywhere near _gp or small data.  Do not set SEPARATE_GOTPLT
+# because we might not have a .plt; don't make eight bytes of .data
+# relro.
+GOT=".got          ${RELOCATING-0} : { *(.got) }"
+GOTPLT=".got.plt      ${RELOCATING-0} : { *(.got.plt) }"
+DATA_GOTPLT=
+
 OTHER_SDATA_SECTIONS="
   .lit8         ${RELOCATING-0} : { *(.lit8) }
   .lit4         ${RELOCATING-0} : { *(.lit4) }
Index: ld/emulparams/elf32ebmipvxworks.sh
===================================================================
RCS file: /cvs/src/src/ld/emulparams/elf32ebmipvxworks.sh,v
retrieving revision 1.2
diff -u -p -r1.2 elf32ebmipvxworks.sh
--- ld/emulparams/elf32ebmipvxworks.sh	18 May 2007 09:18:18 -0000	1.2
+++ ld/emulparams/elf32ebmipvxworks.sh	1 Jul 2008 16:08:54 -0000
@@ -13,6 +13,9 @@ OTHER_READWRITE_SECTIONS="
   .rdata ${RELOCATING-0} : ONLY_IF_RW { *(.rdata) }
 "
 unset OTHER_GOT_SYMBOLS
+unset GOT
+unset GOTPLT
+unset DATA_GOTPLT
 SHLIB_TEXT_START_ADDR=0
 unset TEXT_DYNAMIC
 unset DATA_ADDR
Index: ld/emulparams/elf32elmipvxworks.sh
===================================================================
RCS file: /cvs/src/src/ld/emulparams/elf32elmipvxworks.sh,v
retrieving revision 1.1
diff -u -p -r1.1 elf32elmipvxworks.sh
--- ld/emulparams/elf32elmipvxworks.sh	22 Mar 2006 09:28:13 -0000	1.1
+++ ld/emulparams/elf32elmipvxworks.sh	1 Jul 2008 16:08:54 -0000
@@ -4,6 +4,9 @@ OUTPUT_FORMAT="elf32-littlemips-vxworks"
 BIG_OUTPUT_FORMAT="elf32-bigmips-vxworks"
 LITTLE_OUTPUT_FORMAT="elf32-littlemips-vxworks"
 unset OTHER_GOT_SYMBOLS
+unset GOT
+unset GOTPLT
+unset DATA_GOTPLT
 SHLIB_TEXT_START_ADDR=0
 unset TEXT_DYNAMIC
 unset DATA_ADDR
Index: ld/emultempl/mipself.em
===================================================================
RCS file: /cvs/src/src/ld/emultempl/mipself.em,v
retrieving revision 1.9
diff -u -p -r1.9 mipself.em
--- ld/emultempl/mipself.em	19 Jul 2007 19:56:10 -0000	1.9
+++ ld/emultempl/mipself.em	1 Jul 2008 16:08:54 -0000
@@ -19,6 +19,9 @@
 # MA 02110-1301, USA.
 
 fragment <<EOF
+
+#include "elfxx-mips.h"
+
 static void
 mips_after_parse (void)
 {
@@ -33,6 +36,15 @@ mips_after_parse (void)
     }
   after_parse_default ();
 }
+
+static void
+mips_after_open (void)
+{
+  if (!bfd_mips_elf_maybe_create_non_pic_to_pic_stubs_section (&link_info))
+    einfo ("%X%P: failed to create non-PIC to PIC stubs section: %E\n");
+  gld${EMULATION_NAME}_after_open ();
+}
 EOF
 
+LDEMUL_AFTER_OPEN=mips_after_open
 LDEMUL_AFTER_PARSE=mips_after_parse
Index: ld/scripttempl/elf.sc
===================================================================
RCS file: /cvs/src/src/ld/scripttempl/elf.sc,v
retrieving revision 1.85
diff -u -p -r1.85 elf.sc
--- ld/scripttempl/elf.sc	11 Jan 2008 09:11:17 -0000	1.85
+++ ld/scripttempl/elf.sc	1 Jul 2008 16:08:54 -0000
@@ -36,6 +36,9 @@
 #	DATA_PLT - .plt should be in data segment, not text segment.
 #	PLT_BEFORE_GOT - .plt just before .got when .plt is in data segement.
 #	BSS_PLT - .plt should be in bss segment
+#	DATA_GOT - .got should be in data segment, far from small data
+#	DATA_GOTPLT - .got.plt should be in data segment, far from small data
+#	SDATA_GOT - .got should be near small data
 #	TEXT_DYNAMIC - .dynamic in text segment, not data segment.
 #	EMBEDDED - whether this is for an embedded system. 
 #	SHLIB_TEXT_START_ADDR - if set, add to SIZEOF_HEADERS to set
@@ -171,6 +174,9 @@ if test -z "${SDATA_GOT}"; then
     SDATA_GOT=" "
   fi
 fi
+if test -n "${DATA_GOT+set}"; then
+    DATA_GOTPLT=" "
+fi
 test -n "$SEPARATE_GOTPLT" && SEPARATE_GOTPLT=" "
 test "${LARGE_SECTIONS}" = "yes" && REL_LARGE="
   .rel.ldata    ${RELOCATING-0} : { *(.rel.ldata${RELOCATING+ .rel.ldata.* .rel.gnu.linkonce.l.*}) }
@@ -414,11 +420,11 @@ cat <<EOF
   ${OTHER_RELRO_SECTIONS}
   ${TEXT_DYNAMIC-${DYNAMIC}}
   ${DATA_GOT+${RELRO_NOW+${GOT}}}
-  ${DATA_GOT+${RELRO_NOW+${GOTPLT}}}
+  ${DATA_GOTPLT+${RELRO_NOW+${GOTPLT}}}
   ${DATA_GOT+${RELRO_NOW-${SEPARATE_GOTPLT+${GOT}}}}
   ${RELOCATING+${DATA_SEGMENT_RELRO_END}}
   ${DATA_GOT+${RELRO_NOW-${SEPARATE_GOTPLT-${GOT}}}}
-  ${DATA_GOT+${RELRO_NOW-${GOTPLT}}}
+  ${DATA_GOTPLT+${RELRO_NOW-${GOTPLT}}}
 
   ${DATA_PLT+${PLT_BEFORE_GOT-${PLT}}}
 

--vtzGhvizbBRQ85DL--
