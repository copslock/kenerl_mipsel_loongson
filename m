Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA80729 for <linux-archive@neteng.engr.sgi.com>; Thu, 18 Mar 1999 15:31:34 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA20376
	for linux-list;
	Thu, 18 Mar 1999 15:29:26 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA20970
	for <linux@engr.sgi.com>;
	Thu, 18 Mar 1999 15:29:19 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA04988
	for <linux@engr.sgi.com>; Thu, 18 Mar 1999 15:29:05 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cacc-16.uni-koblenz.de [141.26.131.16])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id AAA10296
	for <linux@engr.sgi.com>; Fri, 19 Mar 1999 00:08:43 +0100 (MET)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id AAA22650;
	Fri, 19 Mar 1999 00:05:24 +0100
Message-ID: <19990319000524.K19636@uni-koblenz.de>
Date: Fri, 19 Mar 1999 00:05:24 +0100
From: ralf@uni-koblenz.de
To: Karel van Houten <K.H.C.vanHouten@research.kpn.com>, linux-mips@fnet.fr
Cc: linux@cthulhu.engr.sgi.com, linux-mips@vger.rutgers.edu,
        joey@infodrom.north.de, debian-mips@lists.debian.org, RE-Glaue@wiu.edu
Subject: Re: Little Endian - Debian/Linux/MIPS Port
References: <Pine.SOL.3.95.990318104045.26741B-100000@ecom5> <199903181752.SAA25644@sparta.research.kpn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <199903181752.SAA25644@sparta.research.kpn.com>; from Karel van Houten on Thu, Mar 18, 1999 at 06:52:38PM +0100
X-Accept-Language: de,en,fr
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi everybody,

nice that somebody forwarded this thread to one of the relevant MIPS
mailing lists ...  I didn't even know about a Debian project, therefore
currently the Linux/MIPS FAQ says, there is none ...

Anybody wants to write a paragraph about the state, availability etc.?
In SGML-Tools, please.

> >  No Linux Kernel binaries exist for little endian. Whether or not a
> >  working kernel for little endian can even be cross-compiled for the
> >  little endian is dependant upon the current maintenance status of the
> >  Linux kernel source code for linux-mipsel which I do not know.
> >  So the only thing that those interested in running Linux on little endian
> >  can do is either cross their fingers and hope things work out with my
> >  efforts, or help develop a running port of linux on little endian which
> >  might include cross-compiling and/or kernel hacking. The latter is
> >  encouraged.
> >  Also, anyone at all out there who can give me solid information about the
> >  current maintenance status of linux-mipsel in the Linux Source code, or
> >  what not, is appreciated.

This describes the situation very inaccurate.  The kernel binary does not
only depend on the machine's byteorder but also on the very much of the
rest of the system.  So we actually would need to provide several kernel
binaries for big and little endian machines.  We kernel hackers usually
don't because it's alot of work.

Aside, I'm running Linux on several big and little endian machines, no
prob.

  Ralf
