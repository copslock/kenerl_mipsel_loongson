Received:  by oss.sgi.com id <S305165AbQAOBFF>;
	Fri, 14 Jan 2000 17:05:05 -0800
Received: from deliverator.sgi.com ([204.94.214.10]:9334 "EHLO
        deliverator.sgi.com") by oss.sgi.com with ESMTP id <S305155AbQAOBE6>;
	Fri, 14 Jan 2000 17:04:58 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id RAA12768; Fri, 14 Jan 2000 17:02:07 -0800 (PST)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA87243
	for linux-list;
	Fri, 14 Jan 2000 16:44:16 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA99167;
	Fri, 14 Jan 2000 16:44:14 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA05189; Fri, 14 Jan 2000 16:44:09 -0800 (PST)
	mail_from (ralf@oss.sgi.com)
Received: from cacc-27.uni-koblenz.de (cacc-27.uni-koblenz.de [141.26.131.27])
	by mailhost.uni-koblenz.de (8.9.3/8.9.3) with ESMTP id BAA21239;
	Sat, 15 Jan 2000 01:43:12 +0100 (MET)
Received:  by lappi.waldorf-gmbh.de id <S407895AbQANMZZ>;
	Fri, 14 Jan 2000 13:25:25 +0100
Date:   Fri, 14 Jan 2000 13:25:25 +0100
From:   Ralf Baechle <ralf@oss.sgi.com>
To:     Vince Weaver <weave@eng.umd.edu>
Cc:     "William J. Earl" <wje@cthulhu.engr.sgi.com>, eak@sgi.com,
        linux@cthulhu.engr.sgi.com
Subject: Re: identifying sgi system type under Linux [patch]
Message-ID: <20000114132525.E4278@uni-koblenz.de>
References: <14462.16504.84215.298070@liveoak.engr.sgi.com> <Pine.GSO.4.21.0001131637260.12920-200000@z.glue.umd.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0pre3us
In-Reply-To: <Pine.GSO.4.21.0001131637260.12920-200000@z.glue.umd.edu>
X-Accept-Language: de,en,fr
Sender: owner-linuxmips@oss.sgi.com
Precedence: bulk
Return-Path: <owner-linuxmips@oss.sgi.com>
X-Orcpt: rfc822;linuxmips-outgoing

On Thu, Jan 13, 2000 at 04:45:41PM -0500, Vince Weaver wrote:

> >       Note that the Linux kernel (like the IRIX kernel) has a way of
> > detecting the difference, since it needs to know which box it is
> > running on, so you could just get the kernel to export the data via
> > /proc somewhere.  The kernel variable "sgi_guiness" is 1 if the system
> > is an Indy ("Guinness") and 0 if the system is an Indigo2
> > ("FullHouse").  Look at the file indy_hpc.c to see how this is detected.
> 
> thanks, this is what I needed!  It works (at least for me!)
> 
> Here is the patch, I'd like someone with and Indy to try and be sure it
> works all around....

It's ``obviously correct''.  However I'd prefer if somebody would rewrite
the bootinfo.h and /proc stuff in a cleaner, more easy to maintain way.
We've got various modules that want to output information via cpuinfo
like the CPU-info, the second level cache handler and about the board
itself.  So what I want is something where various subsystems that want
to contribute to the /proc/cpuinfo content can register their own routines
when then will be called via get_cpuinfo().

  Ralf
