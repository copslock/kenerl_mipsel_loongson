Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id CAA20943
	for <pstadt@stud.fh-heilbronn.de>; Wed, 30 Jun 1999 02:17:05 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id RAA12367; Tue, 29 Jun 1999 17:14:11 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA99161
	for linux-list;
	Tue, 29 Jun 1999 17:09:51 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.40.90])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id RAA68862;
	Tue, 29 Jun 1999 17:09:43 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id RAA09229; Tue, 29 Jun 1999 17:08:31 -0700
Date: Tue, 29 Jun 1999 17:08:31 -0700
Message-Id: <199906300008.RAA09229@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ralf Baechle <ralf@uni-koblenz.de>
Cc: digital convergence <digital_convergence@yahoo.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: IRIX binary compatibility (Was: Re: X VNC server compiled on Hardhat!!)
In-Reply-To: <19990614123809.C14977@uni-koblenz.de>
References: <19990614043723.24062.rocketmail@web502.yahoomail.com>
	<19990614123809.C14977@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle writes:
 > On Sun, Jun 13, 1999 at 09:37:23PM -0700, digital convergence wrote:
 > 
 > > btw, how well is native IRIX binary loading supported? I wish to run a
 > > copy of BMRT on my farm of indy's under linux, but it won't let me
 > > execute any of the binaries (they're R4000 optimised old style linkage
 > > bins)....
 > 
 > Only a limited number of syscalls and other interfaces is supported at
 > all and I haven't received any reports about the IRIX compatibility
 > stuff in ages.  Anybody interested in maintaining this facility?

       IRIX 4.* binaries are COFF binaries, not ELF, and have a very
different ABI from IRIX 5.* binaries.  The present support is really
for IRIX 5 binaries, which are much closer in interface semantics to
Linux native binaries.
