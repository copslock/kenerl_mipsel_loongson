Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA25747 for <linux-archive@neteng.engr.sgi.com>; Mon, 19 Oct 1998 17:55:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA05793
	for linux-list;
	Mon, 19 Oct 1998 17:54:38 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA60220
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 19 Oct 1998 17:54:36 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA09636
	for <linux@cthulhu.engr.sgi.com>; Mon, 19 Oct 1998 17:54:34 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-23.uni-koblenz.de [141.26.249.23])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id CAA04300
	for <linux@cthulhu.engr.sgi.com>; Tue, 20 Oct 1998 02:54:06 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id MAA02318;
	Mon, 19 Oct 1998 12:18:04 +0200
Message-ID: <19981019121804.F387@uni-koblenz.de>
Date: Mon, 19 Oct 1998 12:18:04 +0200
From: ralf@uni-koblenz.de
To: Harald Koerfgen <harald.koerfgen@netcologne.de>, linux-mips@fnet.fr
Cc: linux@cthulhu.engr.sgi.com, Vladimir Roganov <roganov@niisi.msk.ru>
Subject: Re: get_mmu_context()
References: <Pine.SV4.3.91.981016185136.876A-100000@mech.math.msu.su> <XFMail.981018215318.harald.koerfgen@netcologne.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <XFMail.981018215318.harald.koerfgen@netcologne.de>; from Harald Koerfgen on Sun, Oct 18, 1998 at 09:53:18PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Oct 18, 1998 at 09:53:18PM +0200, Harald Koerfgen wrote:

> > We are going to provide support for building generic kernels in the near 
> > future if somebody who holds r4k will help us and will try our patches 
> > on a r4k box. I think the best time to start is when r3k will be synced 
> > with the main branch. Perhaps, Harald may answer when it might occur.
> 
> Hmmm, I'm not shure about this. If we really want to support generic kernels,
> that'll shurely needs some more work than a little patching in

There is a number of machines, most popular some DECstation, which are
available with both CPU architectures.

> get_mmu_context.  Remember, Vladimir, we needed to make changes in extremely
> performance critical parts of the kernel which Ralf propably won't like to
> have for the R4000 case. Most of them are actually compiled conditionally.

The other location for which patching might be useful are primarily the
differences between the R3000 and R4000 status register, especially the
KU rsp. KSU bits.  What other places do you have in mind?

> To make those changes generic needs either a reasonable amount of hacking or
> avoidable code duplication. In fact, if we really don't care about self
> modifying code we should be able to remove some code duplication, for
> example in the fpu stuff.

People should consider that we'll be able to hide the self modifications
in C code very nicely.  I would not go for anything which I consider a
maintenance problem or major uglyness.

Let me explain how the approach from my recent patch works:

#define ASID_INC(asid)                                         \
 ({ unsigned long __asid = asid;                               \
   __asm__("1:\taddiu\t%0,0\t\t\t\t# patched\n\t"              \
           ".section\t__asid_inc,\"a\"\n\t"                    \
           ".word\t1b\n\t"                                     \
           ".previous"                                         \
           :"=r" (__asid)                                      \
           :"0" (__asid));                                     \
   __asid; })

This macro will be used in a place where the C compiler is known to produce
an addiu instruction.  The trick is now that we collect the instruction's
address in a special section, __asid_inc in that case.  As a special
service the GNU linker will generate the symbols __start_<name> and
__stop_<name> if the section name <name> is a valid C symbol name.  So
after boot we can easily insert the right operands into the instruction:

/* Fixup an immediate instruction  */
static void __i_insn_fixup(unsigned int **start, unsigned int **stop,
                           unsigned int i_const)
{
       unsigned int **p, *ip;

       for (p = start;p < stop; p++) {
               ip = *p;
               *ip = (*ip & 0xffff0000) | i_const;
       }
}

#define i_insn_fixup(section, const)                                     \
do {                                                                     \
       extern unsigned int *__start_ ## section;                         \
       extern unsigned int *__stop_ ## section;                          \
       __i_insn_fixup(&__start_ ## section, &__stop_ ## section, const); \
} while(0)

void __asid_setup(unsigned int inc, unsigned int mask,
                             unsigned int version_mask,
                             unsigned int first_version)
{
       i_insn_fixup(__asid_inc, inc);
[...]

The technique itself can be used in quite a number more of places.  All
variables which are computed at boot time and never again changed later on
are good candidates.  Think for example of the variables dcache_size,
icache_size, scache_size, dcache_lsize, icache_lsize, scache_lsize.

Todo: we don't want a separate section per patched instruction.  Easy to
fix.  We also want to get rid of the special section just like other
initfunc stuff.

The next class of things to patch are the zillion of function calls using
function pointers.  We can insert a jal instruction and patch it's
destination address.  Candidates for that include calls to flush_cache_all,
flush_cache_mm, flush_cache_range, flush_cache_page, flush_cache_sigtramp,
flush_tlb_all, flush_tlb_mm, flush_tlb_range, flush_tlb_page, add_wired_entry,
clear_page, copy_page.

Both parts, patching immediate opperands and function calls can be dealt
with similar to the approach in the userland dynamic linker, that initially
the function called is the dynamic linker's kernel equivalent which will
choose the right thing to do.

Extra goodie for the R3000 fraction: Many functions called via above
mentioned pointers are empty, calls to them may be eleminated by overwriting
the calling jal with nops.  Say goodbye to another hand full of cycles.

  Ralf
