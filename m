Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA01389
	for <pstadt@stud.fh-heilbronn.de>; Fri, 30 Jul 1999 23:28:56 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id OAA24475; Fri, 30 Jul 1999 14:24:36 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA33602
	for linux-list;
	Fri, 30 Jul 1999 14:19:04 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA85008
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 30 Jul 1999 14:19:00 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA09343
	for <linux@cthulhu.engr.sgi.com>; Fri, 30 Jul 1999 14:18:56 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-22.uni-koblenz.de [141.26.131.22])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA21474
	for <linux@cthulhu.engr.sgi.com>; Fri, 30 Jul 1999 23:18:43 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id XAA20214;
	Fri, 30 Jul 1999 23:01:27 +0200
Date: Fri, 30 Jul 1999 23:01:27 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Tim Hockin <thockin@cobaltnet.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: an ld problem? - possibly fixed..
Message-ID: <19990730230127.J12249@uni-koblenz.de>
References: <379FBBFE.FB8C1734@cobaltnet.com> <19990729153427.E4730@uni-koblenz.de> <37A137F7.91B5AC4A@cobaltnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <37A137F7.91B5AC4A@cobaltnet.com>; from Tim Hockin on Thu, Jul 29, 1999 at 10:28:23PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Jul 29, 1999 at 10:28:23PM -0700, Tim Hockin wrote:

> Ralf Baechle wrote:
> 
> > just in case if you manage to fix this one please drop me a note.
> 
> I'm calling in for help on the solution now.
> 
> The problem occurs when a segment is found that is not a known name, libbfd
> abort()s in mips_elf_relocate_section().  In the case of the egcs libstdc++
> link the segments in question are : ".dtors" and ".gcc_except_table".  I assume
> since .dtors is trouble, so will .ctors be.
> 
> If I add .dtors and .gcc_except_table to mips_elf_dynsym_sec_names[] in
> ${binutils_src_path}/bfd/elf32-mips.c and rebuild libbfd - ld no longer gets an
> abort() when compiling the file in question.  I'm pretty sure this is NOT the
> right solution.  There is also a table of sections in
> ${binutils_src_path}/bfd/syms.c.  What is the "right" solution, and what other
> sections can exist that bfd doesn't know about?
> 
> Someone with a bit more experience inside libbfd - please help? :)

I think that already having a list of section names for that purpose is
an error.  Current libbfd doesn't rely on it anymore.  Guess it's time
to bite the bullet and try to rebuild the entire system just using
binutils-current from Cygnus CVS.  Binutils, born to be fixed ...

There is another bug in libbfd where section->owner is NULL which makes
the linker do the segv boogy.  It's being trigger by the linker options
``-lm -lieee'' when linking arbitrary code using the native linker.  I
didn't research that case further because I got detracted into GDB
debugging when GDB started crashing while I was investigating that case ...

  Ralf
