Received: (from majordomo@localhost)
	by oss.sgi.com (8.11.2/8.11.3) id fA8DCxG01830
	for linux-mips-outgoing; Thu, 8 Nov 2001 05:12:59 -0800
Received: from delta.ds2.pg.gda.pl (delta.ds.pg.gda.pl [213.192.72.1])
	by oss.sgi.com (8.11.2/8.11.3) with SMTP id fA8DAu001718
	for <linux-mips@oss.sgi.com>; Thu, 8 Nov 2001 05:10:57 -0800
Received: from localhost by delta.ds2.pg.gda.pl (8.9.3/8.9.3) with SMTP id OAA08062;
	Thu, 8 Nov 2001 14:06:06 +0100 (MET)
Date: Thu, 8 Nov 2001 14:06:05 +0100 (MET)
From: "Maciej W. Rozycki" <macro@ds2.pg.gda.pl>
To: Dave Airlie <airlied@csn.ul.ie>
cc: linux-vax@mithra.physics.montana.edu, linux-mips@fnet.fr,
   linux-mips@oss.sgi.com
Subject: Re: [LV] FYI: Mopd ELF support
In-Reply-To: <Pine.LNX.4.32.0111062247250.14556-100000@skynet>
Message-ID: <Pine.GSO.3.96.1011108134950.6973C-100000@delta.ds2.pg.gda.pl>
Organization: Technical University of Gdansk
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux-mips@oss.sgi.com
Precedence: bulk

On Tue, 6 Nov 2001, Dave Airlie wrote:

> >  Since I'll be away till Tuesday, expect an update in the middle of the
> > next week.  I'm assuming ELF loading works, right?
> >
> not sure the VAX is handling this too well..
> 
> if I boot the vmlinux ELF file our build system produces it won't boot it
> but I think this is due to our vmlinux file being linked for running with
> VM switched on, and the mop loads it into memory that doesn't exist..

 Do you set segments' p_paddr (physical address) correctly?  The current
version of ELF support uses p_vaddr (virtual address) for simplicity, as
the ELF specification mandates loadable program's segments to be ordered
by an ascending value of their p_vaddr.  I'll fix the program to use
p_paddr instead.  The difference is insignificant for the DECstation since
its firmware uses virtual addresses -- MIPS never exposes physical
addresses to a program (well, almost, but that's irrelevant here).

  Maciej

-- 
+  Maciej W. Rozycki, Technical University of Gdansk, Poland   +
+--------------------------------------------------------------+
+        e-mail: macro@ds2.pg.gda.pl, PGP key available        +
