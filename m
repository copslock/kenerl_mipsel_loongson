Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA06642
	for <pstadt@stud.fh-heilbronn.de>; Sun, 1 Aug 1999 01:32:05 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA14533; Sat, 31 Jul 1999 16:28:10 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA22112
	for linux-list;
	Sat, 31 Jul 1999 16:23:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA05574
	for <linux@engr.sgi.com>;
	Sat, 31 Jul 1999 16:22:59 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA00185
	for <linux@engr.sgi.com>; Sat, 31 Jul 1999 16:22:57 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-10.uni-koblenz.de [141.26.131.10])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA17901
	for <linux@engr.sgi.com>; Sun, 1 Aug 1999 01:22:53 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id BAA20450;
	Sun, 1 Aug 1999 01:22:04 +0200
Date: Sun, 1 Aug 1999 01:22:03 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Mark Mitchell <mark@codesourcery.com>
Cc: ralf@gnu.org, binutils@sourceware.cygnus.com, thockin@cobaltnet.com,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: MIPS/ELF linker
Message-ID: <19990801012203.U12249@uni-koblenz.de>
References: <19990731233150.Q12249@uni-koblenz.de> <19990731152842N.mitchell@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <19990731152842N.mitchell@codesourcery.com>; from Mark Mitchell on Sat, Jul 31, 1999 at 03:28:42PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Jul 31, 1999 at 03:28:42PM -0700, Mark Mitchell wrote:

> Thanks for trying the MIPS backend out.  I'm eager to shake out the
> bugs.  It seems pretty solid on IRIX6, now, but I'm sure there are
> issues remaining on other platforms.
> 
>   +  /* Assume no jalx is required  */
>   +  *require_jalxp = false;
>   +
> 
> REQUIRE_JALXP is set unconditionally a few lines down.  Why doesn't
> that do the trick?  The caller should not be looking at the value of
> require_jalx unless calculate_relocation returns a successful error
> code.

So the caller _bfd_mips_elf_relocate_section does not behave appropriately
when mips_elf_calculate_relocation returns bfd_reloc_undefined.  Search
for bfd_reloc_undefined in mips_elf_calculate_relocation; it's being
returned before an actual value gets assigned to *require_jalxp.

>   /usr/bin/mips-linux-ld: not enough GOT space for local GOT entries
> 
> Probably some relocation is requiring a local GOT entry, but we're not
> allocating it.  Look for this code in check_relocs:
> 
>       if (!h && (r_type == R_MIPS_CALL_LO16
> 		 || r_type == R_MIPS_GOT_LO16
> 		 || r_type == R_MIPS_GOT_DISP))
> 	{
> 	  /* We may need a local GOT entry for this relocation.  We
> 	     don't count R_MIPS_HI16 or R_MIPS_GOT16 relocations
> 	     because they are always followed by a R_MIPS_LO16
> 	     relocation for the value.  We don't R_MIPS_GOT_PAGE
> 	     because we can estimate the maximum number of pages
> 	     needed by looking at the size of the segment.
> 
> 	     This estimation is very conservative since we can merge
> 	     duplicate entries in the GOT.  In order to be less
> 	     conservative, we could actually build the GOT here,
> 	     rather than in relocate_section.  */
> 	  g->local_gotno++;
> 	  sgot->_raw_size += MIPS_ELF_GOT_SIZE (dynobj);
> 	}
> 
> Probably this code is not firing in some case where it should be
> firing.  Therefore, we're not adding enough GOT space.  That might
> help track down the bug.  
> 
> If not, feel free to send me the files on your link-line in a giant
> tar-ball, together with how your configuring binutils, and I'll try to
> duplicate and fix your problem.

I'll send you a non-giant tarball of 73kb which will demonstrate the
problem.  Just run the Makefile in the archive.  The linker has been
configured for the target mips-linux which is a standard MIPS/ELF target.

  Ralf
