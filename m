Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA07761
	for <pstadt@stud.fh-heilbronn.de>; Tue, 3 Aug 1999 00:44:05 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA04075; Mon, 2 Aug 1999 15:40:00 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA31031
	for linux-list;
	Mon, 2 Aug 1999 15:37:05 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA82119
	for <linux@engr.sgi.com>;
	Mon, 2 Aug 1999 15:36:54 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA00455
	for <linux@engr.sgi.com>; Mon, 2 Aug 1999 15:36:52 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-22.uni-koblenz.de [141.26.131.22])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA18463
	for <linux@engr.sgi.com>; Tue, 3 Aug 1999 00:36:48 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id AAA29879;
	Tue, 3 Aug 1999 00:32:06 +0200
Date: Tue, 3 Aug 1999 00:31:31 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "H.J. Lu" <hjl@lucon.org>
Cc: linuxgcc <linux-gcc@vger.rutgers.edu>, egcs@egcs.cygnus.com,
        GNU C Library <libc-hacker@sourceware.cygnus.com>,
        Kenneth Albanowski <kjahds@kjahds.com>,
        Kenneth Osterberg <lmfken@lmf.ericsson.se>,
        Mat Hostetter <mat@lcs.mit.edu>,
        Andy Dougherty <doughera@lafcol.lafayette.edu>,
        Brian Bourgault <brian@mathworks.com>, Warner Losh <imp@village.org>,
        Michael Meissner <meissner@cygnus.com>,
        Ron Guilmette <rfg@monkeys.com>,
        John Polstra <linux-binutils-in@polstra.com>,
        Galen Hazelwood <galenh@micron.net>, Linas Vepstas <linas@linas.org>,
        Feher Janos <aries@hal2000.terra.vein.hu>, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: binutils 2.9.5.0.4 is released.
Message-ID: <19990803003131.D29290@uni-koblenz.de>
References: <19990802185200.00C6C57BA@ocean.lucon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <19990802185200.00C6C57BA@ocean.lucon.org>; from H.J. Lu on Mon, Aug 02, 1999 at 11:52:00AM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Aug 02, 1999 at 11:52:00AM -0700, H.J. Lu wrote:

> This is the beta release of binutils 2.9.5.0.4 for Linux, which is
> based on binutils 1999 0801 plus various changes. It is purely for
> Linux, although it has been tested on Solaris/Sparc and Solaris/x86
> from time to time.
> 
> I merged a MIPS gas patch from binutils 2.9.1.0.25 to the current
> binutils and there are many changes in MIPS/ELF in bfd. I'd like to
> hear reports on Linux/MIPS.

MIPS users should continue to use the latest 2.8.1-based releases
available from ftp.linux.sgi.com.  All newer linker have heavy bugs
which will result in linker crashes, bad kernels and more.  I especially
have to warn about the binutils from Cygnus' anonymous CVS.  At this
time the MIPS support in that binutils versions is undergoing heavy
rewrite in order to support the N32 ABI and as a temporary side effect
they are therefore currently completly unusable for Linux/MIPS.

  Ralf
