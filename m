Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id f9VMm4u23056
	for linux-mips-outgoing; Wed, 31 Oct 2001 14:48:04 -0800
Received: from nevyn.them.org (mail@NEVYN.RES.CMU.EDU [128.2.145.6])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id f9VMlq023052
	for <linux-mips@oss.sgi.com>; Wed, 31 Oct 2001 14:47:52 -0800
Received: from drow by nevyn.them.org with local (Exim 3.32 #1 (Debian))
	id 15z49F-0000Oh-00; Wed, 31 Oct 2001 17:47:49 -0500
Date: Wed, 31 Oct 2001 17:47:49 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Andrew Cagney <ac131313@cygnus.com>
Cc: "Steven J. Hill" <sjhill@cotw.com>, gdb@sources.redhat.com,
   linux-mips@oss.sgi.com
Subject: Stabs and discarded functions (was Re: Old bug with 'gdb/dbxread.c' and screwed up MIPS symbolic debugging...)
Message-ID: <20011031174749.A28985@nevyn.them.org>
Mail-Followup-To: Andrew Cagney <ac131313@cygnus.com>,
	"Steven J. Hill" <sjhill@cotw.com>, gdb@sources.redhat.com,
	linux-mips@oss.sgi.com
References: <3BDF7F79.6050205@cygnus.com> <3BE02E31.3B2CA5FC@cotw.com> <20011031113208.A1882@nevyn.them.org> <3BE03ECD.5060904@cygnus.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3BE03ECD.5060904@cygnus.com>
User-Agent: Mutt/1.3.23i
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Wed, Oct 31, 2001 at 01:11:25PM -0500, Andrew Cagney wrote:
> >
> >Well, the change in objdump output is purely cosmetic.  For 32bit
> >object formats we just truncate the display now.
> 
> As an aside, is there an option to turn this truncation off?  The vr5432 
> as and ld will still pass around 64 bit addresses.

It shouldn't happen in that case, I think.  The vr5432 is configured as
a mips64 target, isn't it?

> >If you back it out, I believe we just give up in confusion  [:)] This is
> >int the reading of stabs info.  breakinst has no stabs info, so it's
> >getting its line info somewhere else.
> 
> It might - assembler debugging ...

I don't think it does, at least...

> >Please point me at a copy of your kernel binary with debug info, and
> >I'll look into it.
> 
> Yes, you want to look for a version of breakinst that isn't sign 
> extended.  Since pulling the above patch helped it won't be in .stabs so 
> the symbol table?

It's not that breakinst isn't sign extended.  This is very much like
the address ranges issue that came up with -ffunction-sections or
linkonce sections.

I'm writing this as I debug.  Excuse the flow of consciousness (or skip
down to the end!).

Here's our bug:
(top-gdb) p/x *b
$21 = {startaddr = 0x34, endaddr = 0xffffffff80215314, function = 0x0,
  superblock = 0x0, gcc_compile_flag = 0x2, nsyms = 0x6,
  sym = {0x8755bbc}}

The startaddr is obviously wrong.  This is the first symtab listed for
kernel.  So where does that startaddr come from?

(By the way, our debugging of long longs is abysmal.  I already filed a
PR about this I think.  It makes tracking 64bit CORE_ADDRs a real
pain; they're printed with the upper half garbage.)

The answer is that the startaddr comes from the psymtab.  During psymbol
reading:

Hardware watchpoint 24: *$139

Old value = 18446744069414584372
New value = 52

at:

630                         && (CUR_SYMBOL_VALUE
631                             != ANOFFSET (objfile->section_offsets,
632                                          SECT_OFF_TEXT (objfile))))))
633               {
634                 TEXTLOW (pst) = CUR_SYMBOL_VALUE;
635                 textlow_not_set = 0;
636               }
637     #endif /* DBXREAD_ONLY */
638             add_psymbol_to_list (namestring, p - namestring,
639                                  VAR_NAMESPACE, LOC_BLOCK,

Here's the offending stabs entry:
317176 FUN    0      1870   0000000000000034 1689303 packet_exit:f(0,20)

i.e. it has value 0x34 (52).  That's bad.

Now, there's two things wrong here.  One of them is the bad value.  I
think that I've already seen this problem, and that it has something to
do with the way stabs are and used to be emitted.  packet_exit is
presumably in the .text.exit section, which is presumably the problem. 
Before linking, the stab looked like:

2971   FUN    0      1870   0000000000000000 159366 packet_exit:f(0,20)

and had a relocation:
0000000000008b58 R_MIPS_32         .text.exit
unless I miss my guess.

So it looks like binutils did not relocate the stabs for .text.exit properly.

Why?  It's pretty simple; there was nothing to relocate it to.  From the
kernel's linker script:

  /* Sections to be discarded */
  /DISCARD/ :
  {
        *(.text.exit)
        *(.data.exit)
        *(.exitcall.exit)
  }

So instead of the subtle error we get in objfiles containing multiple
sections, which we'll still need to deal with for the kernel for
.text.init, we have a completely bogus result.

We need to discard the stabs records for discarded symbols.  Of course,
we're just reading the psymtab in when we get here.  We don't have
symbols yet.  We could do this by a second pass after reading, instead
of the hack with textlow, but that's gross.

This makes it impossible to debug at least MIPS kernels with stabs and
gdb, so I very much want to fix it.  I'm not sure how this works on
x86, but I'd guess it had to do with differences in relocation types. 
Anyone have an example handy?

Meanwhile, Steven, as a quick hack - try removing the /DISCARD/ bit
from your linker script and relinking.  What happens?  Does everything
else seem to work?

-- 
Daniel Jacobowitz                           Carnegie Mellon University
MontaVista Software                         Debian GNU/Linux Developer
