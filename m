Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA50941 for <linux-archive@neteng.engr.sgi.com>; Mon, 14 Jun 1999 04:19:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA21360
	for linux-list;
	Mon, 14 Jun 1999 04:18:10 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA41508
	for <linux@engr.sgi.com>;
	Mon, 14 Jun 1999 04:18:04 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA00271
	for <linux@engr.sgi.com>; Mon, 14 Jun 1999 04:17:59 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-15.uni-koblenz.de [141.26.131.15])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id NAA25580
	for <linux@engr.sgi.com>; Mon, 14 Jun 1999 13:17:34 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.9.3/8.9.3) id MAA15267;
	Mon, 14 Jun 1999 12:38:10 +0200
Date: Mon, 14 Jun 1999 12:38:09 +0200
From: Ralf Baechle <ralf@uni-koblenz.de>
To: digital convergence <digital_convergence@yahoo.com>
Cc: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr,
        linux-mips@vger.rutgers.edu
Subject: IRIX binary compatibility (Was: Re: X VNC server compiled on Hardhat!!)
Message-ID: <19990614123809.C14977@uni-koblenz.de>
References: <19990614043723.24062.rocketmail@web502.yahoomail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.4us
In-Reply-To: <19990614043723.24062.rocketmail@web502.yahoomail.com>; from digital convergence on Sun, Jun 13, 1999 at 09:37:23PM -0700
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jun 13, 1999 at 09:37:23PM -0700, digital convergence wrote:

> btw, how well is native IRIX binary loading supported? I wish to run a
> copy of BMRT on my farm of indy's under linux, but it won't let me
> execute any of the binaries (they're R4000 optimised old style linkage
> bins)....

Only a limited number of syscalls and other interfaces is supported at
all and I haven't received any reports about the IRIX compatibility
stuff in ages.  Anybody interested in maintaining this facility?

  Ralf
