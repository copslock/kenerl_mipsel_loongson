Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA19798
	for <pstadt@stud.fh-heilbronn.de>; Wed, 18 Aug 1999 00:09:11 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id PAA07900; Tue, 17 Aug 1999 15:05:53 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA88538
	for linux-list;
	Tue, 17 Aug 1999 14:55:37 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA08195
	for <linux@engr.sgi.com>;
	Tue, 17 Aug 1999 14:55:20 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1] (may be forged)) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA01251
	for <linux@engr.sgi.com>; Tue, 17 Aug 1999 14:55:16 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-26.uni-koblenz.de [141.26.131.26])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA17754
	for <linux@engr.sgi.com>; Tue, 17 Aug 1999 23:55:03 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id PAA25505;
	Tue, 17 Aug 1999 15:51:24 +0200
Date: Tue, 17 Aug 1999 15:51:24 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: Binutils, once more ...
Message-ID: <19990817155124.A25482@uni-koblenz.de>
References: <19990815235634.A12336@uni-koblenz.de> <19990816021633.A13756@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <19990816021633.A13756@uni-koblenz.de>; from Ralf Baechle on Mon, Aug 16, 1999 at 02:16:33AM +0200
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Aug 16, 1999 at 02:16:33AM +0200, Ralf Baechle wrote:

> > Another binutils status report - as of now I still have two open bugs:
> > 
> >  - ld doesn't fill the .got entries for non-dynamic binaries.
> >  - binutils-current are so extremly wastefull with .got space that we run
> >    out of got space for building relativly simple programs like vim.
> >    There is a workaround for this problem which is using compiling things
> >    with the -Wa,-xgot option.  Not really a good idea because it requires
> >    recompilation of several packages with that option but at least it
> >    works ...
> 
> Add another bug - binutils 2.8.1 had a bug which was compensated by
> another bug in ld.so.  So if we fix either one we break binary
> compatibility.

I now have implemented a workaround for this problem.  The fix consists of
two parts, a patch to binutils which will tag all newly generated binaries
and patch to libc which modifies the dynamic linker to do the right thing
for the old and the new binary flavour.

There are still victims of the problem, all binaries which have been linked
statically against libdl, most important rpm.  Since they incorporate the
old broken dynamic linker which doesn't know how to handle correct ELF
binaries they have to be rebuilt.

For those installing their binaries the recommend upgrade procedure is:

 - upgrade rpm
 - upgrade glibc
 - upgrade binutils, if installed
 - install/upgrade any other binaries you wish to install/upgrade.

The order is important!

Note that I haven't produced any new binary packages yet since the above
mentioned two problems with static linked binaries and the got bloatage
still aren't fixed so this is just to keep you uptodate.

  Ralf
