Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.3/8.11.3) id f570CnT02763
	for linux-mips-outgoing; Wed, 6 Jun 2001 17:12:49 -0700
Received: from foghorn.airs.com (IDENT:qmailr@foghorn.airs.com [63.201.54.26])
	by oss.sgi.com (8.11.3/8.11.3) with SMTP id f570Ckh02747
	for <linux-mips@oss.sgi.com>; Wed, 6 Jun 2001 17:12:46 -0700
Received: (qmail 13071 invoked by uid 10); 7 Jun 2001 00:12:46 -0000
Received: (qmail 19602 invoked by uid 269); 7 Jun 2001 00:12:43 -0000
Mail-Followup-To: geoffk@redhat.com,
  binutils@sourceware.cygnus.com,
  linux-mips@oss.sgi.com,
  hjl@lucon.org
From: Ian Lance Taylor <ian@zembu.com>
To: "H . J . Lu" <hjl@lucon.org>
Cc: Geoff Keating <geoffk@redhat.com>, binutils@sourceware.cygnus.com,
   linux-mips@oss.sgi.com
Subject: Re: mips gas is horribly broken
References: <20010606091846.A21652@lucon.org>
	<200106061932.MAA01399@geoffk.org> <20010606131551.A25655@lucon.org>
	<200106062159.OAA01491@geoffk.org> <20010606170221.A30487@lucon.org>
Date: 06 Jun 2001 17:12:43 -0700
In-Reply-To: <20010606170221.A30487@lucon.org>
Message-ID: <siofs1f8qs.fsf@daffy.airs.com>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

"H . J . Lu" <hjl@lucon.org> writes:

> On Wed, Jun 06, 2001 at 02:59:19PM -0700, Geoff Keating wrote:
> > 
> > First, redesign bfd_install_relocation so that it does the right thing
> > (there are other cases where the bfd backends have to work around
> > it).  Then, change all the users to match.  Then, test all the
> > supported platforms.
> 
> Could you please tell me what you meant by "the right thing" and what
> exactly is wrong with the current design? On mips, it is addend
> which is handled incorrectly. Is this the only problem with
> bfd_install_relocation?

Here is the comment from bfd_install_relocation:

#if 1
/* For m68k-coff, the addend was being subtracted twice during
   relocation with -r.  Removing the line below this comment
   fixes that problem; see PR 2953.

However, Ian wrote the following, regarding removing the line below,
which explains why it is still enabled:  --djm

If you put a patch like that into BFD you need to check all the COFF
linkers.  I am fairly certain that patch will break coff-i386 (e.g.,
SCO); see coff_i386_reloc in coff-i386.c where I worked around the
problem in a different way.  There may very well be a reason that the
code works as it does.

Hmmm.  The first obvious point is that bfd_install_relocation should
not have any tests that depend upon the flavour.  It's seem like
entirely the wrong place for such a thing.  The second obvious point
is that the current code ignores the reloc addend when producing
relocateable output for COFF.  That's peculiar.  In fact, I really
have no idea what the point of the line you want to remove is.

A typical COFF reloc subtracts the old value of the symbol and adds in
the new value to the location in the object file (if it's a pc
relative reloc it adds the difference between the symbol value and the
location).  When relocating we need to preserve that property.

BFD handles this by setting the addend to the negative of the old
value of the symbol.  Unfortunately it handles common symbols in a
non-standard way (it doesn't subtract the old value) but that's a
different story (we can't change it without losing backward
compatibility with old object files) (coff-i386 does subtract the old
value, to be compatible with existing coff-i386 targets, like SCO).

So everything works fine when not producing relocateable output.  When
we are producing relocateable output, logically we should do exactly
what we do when not producing relocateable output.  Therefore, your
patch is correct.  In fact, it should probably always just set
reloc_entry->addend to 0 for all cases, since it is, in fact, going to
add the value into the object file.  This won't hurt the COFF code,
which doesn't use the addend; I'm not sure what it will do to other
formats (the thing to check for would be whether any formats both use
the addend and set partial_inplace).

When I wanted to make coff-i386 produce relocateable output, I ran
into the problem that you are running into: I wanted to remove that
line.  Rather than risk it, I made the coff-i386 relocs use a special
function; it's coff_i386_reloc in coff-i386.c.  The function
specifically adds the addend field into the object file, knowing that
bfd_install_relocation is not going to.  If you remove that line, then
coff-i386.c will wind up adding the addend field in twice.  It's
trivial to fix; it just needs to be done.

The problem with removing the line is just that it may break some
working code.  With BFD it's hard to be sure of anything.  The right
way to deal with this is simply to build and test at least all the
supported COFF targets.  It should be straightforward if time and disk
space consuming.  For each target:
    1) build the linker
    2) generate some executable, and link it using -r (I would
       probably use paranoia.o and link against newlib/libc.a, which
       for all the supported targets would be available in
       /usr/cygnus/progressive/H-host/target/lib/libc.a).
    3) make the change to reloc.c
    4) rebuild the linker
    5) repeat step 2
    6) if the resulting object files are the same, you have at least
       made it no worse
    7) if they are different you have to figure out which version is
       right
*/


Here are the comments I wrote in bfd/doc/bfdint.texi:

The assembler used @samp{bfd_perform_relocation} for a while.  This
turned out to be the wrong thing to do, since
@samp{bfd_perform_relocation} was written to handle relocations on an
existing object file, while the assembler needed to create relocations
in a new object file.  The assembler was changed to use the new function
@samp{bfd_install_relocation} instead, and @samp{bfd_install_relocation}
was created as a copy of @samp{bfd_perform_relocation}.

Unfortunately, the work did not progress any farther, so
@samp{bfd_install_relocation} remains a simple copy of
@samp{bfd_perform_relocation}, with all the odd special cases and
confusing code.  This again is difficult to change, because again any
change can affect any assembler target, and so is difficult to test.

Ian
