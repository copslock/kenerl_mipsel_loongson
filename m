Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id BAA10677
	for <pstadt@stud.fh-heilbronn.de>; Wed, 4 Aug 1999 01:10:16 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id QAA29329; Tue, 3 Aug 1999 16:05:37 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA48829
	for linux-list;
	Tue, 3 Aug 1999 16:02:22 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA24398
	for <linux@engr.sgi.com>;
	Tue, 3 Aug 1999 16:02:18 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA04202
	for <linux@engr.sgi.com>; Tue, 3 Aug 1999 16:02:12 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-9.uni-koblenz.de [141.26.131.9])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA13003
	for <linux@engr.sgi.com>; Wed, 4 Aug 1999 01:02:09 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id BAA07865;
	Wed, 4 Aug 1999 01:01:01 +0200
Date: Wed, 4 Aug 1999 01:01:00 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: Mark Mitchell <mark@codesourcery.com>
Cc: binutils@sourceware.cygnus.com, linux@cthulhu.engr.sgi.com,
        linux-mips@fnet.fr, linux-mips@vger.rutgers.edu
Subject: Re: HI16 / LO16 relocations.
Message-ID: <19990804010100.C7145@uni-koblenz.de>
References: <19990804000908.A7145@uni-koblenz.de> <19990803154236N.mitchell@codesourcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <19990803154236N.mitchell@codesourcery.com>; from Mark Mitchell on Tue, Aug 03, 1999 at 03:42:36PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Aug 03, 1999 at 03:42:36PM -0700, Mark Mitchell wrote:

> As soon as you get a test-case, I'll take a look at this.  It's fine
> even it's big, as long as you can point at the exact place that goes
> wrong; I'd really like to get this work behind me, and get everything
> back to a more stable state.  've compiled *millions* of lines of code
> on IRIX6 with the new linker without a problem; obviously the
> relocation patterns are very different from the N32/N64 ABI to the
> older ABIs.

I think the core differences are probably that I tried to compile non-pic
code and code which tries to use GNU extensions.  I intend to recompile
the entire Linux distribution with this new linker which probably will
trigger a few more bugs according to my past experience.  Finally the
Linux/MIPS64 kernel will exercise non-PIC 64-bit code - hopefully
without triggering any new bugs ...

  Ralf
