Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA26548 for <linux-archive@neteng.engr.sgi.com>; Thu, 20 Aug 1998 18:56:43 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA50426
	for linux-list;
	Thu, 20 Aug 1998 18:55:54 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA68406
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 20 Aug 1998 18:55:52 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA19949
	for <linux@cthulhu.engr.sgi.com>; Thu, 20 Aug 1998 18:55:33 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id VAA31599;
	Thu, 20 Aug 1998 21:55:52 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Thu, 20 Aug 1998 21:55:52 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: "Jan F. Chadima" <jfch@ruzenka.prf.cuni.cz>
cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Installing indy - help please
In-Reply-To: <199808210003.CAA12849@ruzenka.prf.cuni.cz>
Message-ID: <Pine.LNX.3.96.980820215244.21191A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Jan,

First, ther are some problems with the installer's partitioner; to avoid
this, make your disk an 'option' disk under Irix.  This will set up one
big partition to install onto. Just skip partitioning altogether in the
installer, then.


I expect you can fix your bootp problems by debugging it by using tcpdump
or another packet sniffer on the network. However, forcing it like you are
is just fine too.

- Alex

-- 
Alex deVries, puffin on LinuxNet.
http://www.engsoc.carleton.ca/~adevries/ .



On Fri, 21 Aug 1998, Jan F. Chadima wrote:

> Date: Fri, 21 Aug 1998 02:03:53 +0200 (MET DST)
> From: "Jan F. Chadima" <jfch@ruzenka.prf.cuni.cz>
> To: adevries@engsoc.carleton.ca
> Subject: Installing indy - help please
> 
> Hi
> 
> I've tried to install linux on indy (hardhat 5.1), I got some problems
> 
> 1) I can't see screen 158 x 62 as is proclamated, but only 127 x 47 upper left corner
> 
> 2) I can't boot by bootp, it does nothing (return to monitor)
> 
> 3) If booted vmlinux from irix with nfsroot=... I get install, then I can select packages,
> 	format the partition, but just after that install dies with signal 11
> 
> 
> 	Can You Help me?
> 
> 				J. F. Chadima 	(jfch@sunsite.mff.cuni.cz)
> 
> 
