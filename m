Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA27565
	for <pstadt@stud.fh-heilbronn.de>; Tue, 6 Jul 1999 00:11:29 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA4577333; Mon, 5 Jul 1999 15:07:39 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA41648
	for linux-list;
	Mon, 5 Jul 1999 15:01:49 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA18147;
	Mon, 5 Jul 1999 15:00:02 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA00318; Mon, 5 Jul 1999 14:58:44 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-24.uni-koblenz.de [141.26.131.24])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id XAA08326;
	Mon, 5 Jul 1999 23:58:40 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id OAA05468;
	Mon, 5 Jul 1999 14:28:37 +0200
Date: Mon, 5 Jul 1999 14:28:37 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: "William J. Earl" <wje@fir.engr.sgi.com>
Cc: digital convergence <digital_convergence@yahoo.com>,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: Re: IRIX binary compatibility (Was: Re: X VNC server compiled on Hardhat!!)
Message-ID: <19990705142836.B5432@uni-koblenz.de>
References: <19990614043723.24062.rocketmail@web502.yahoomail.com> <19990614123809.C14977@uni-koblenz.de> <199906300008.RAA09229@fir.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <199906300008.RAA09229@fir.engr.sgi.com>; from William J. Earl on Tue, Jun 29, 1999 at 05:08:31PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Tue, Jun 29, 1999 at 05:08:31PM -0700, William J. Earl wrote:

> Ralf Baechle writes:
>  > On Sun, Jun 13, 1999 at 09:37:23PM -0700, digital convergence wrote:
>  > 
>  > > btw, how well is native IRIX binary loading supported? I wish to run a
>  > > copy of BMRT on my farm of indy's under linux, but it won't let me
>  > > execute any of the binaries (they're R4000 optimised old style linkage
>  > > bins)....
>  > 
>  > Only a limited number of syscalls and other interfaces is supported at
>  > all and I haven't received any reports about the IRIX compatibility
>  > stuff in ages.  Anybody interested in maintaining this facility?
> 
>        IRIX 4.* binaries are COFF binaries, not ELF, and have a very
> different ABI from IRIX 5.* binaries.  The present support is really
> for IRIX 5 binaries, which are much closer in interface semantics to
> Linux native binaries.

So far not a single person has asked for binary compatibility with
IRIX < 5.0, so ECOFF support isn't exactly something I'm worried about ...

  Ralf
