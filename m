Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id WAA18731
	for <pstadt@stud.fh-heilbronn.de>; Sat, 21 Aug 1999 22:37:00 +0200
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id NAA26633; Sat, 21 Aug 1999 13:32:19 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id NAA30136
	for linux-list;
	Sat, 21 Aug 1999 13:27:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id NAA98354
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 21 Aug 1999 13:26:57 -0700 (PDT)
	mail_from (tshrider@kascope.com)
Received: from vertigo.gndn.org ([216.50.90.66]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id NAA00183
	for <linux@cthulhu.engr.sgi.com>; Sat, 21 Aug 1999 13:26:56 -0700 (PDT)
	mail_from (tshrider@kascope.com)
Received: from localhost (tshrider@localhost)
	by vertigo.gndn.org (8.9.3/8.9.3) with ESMTP id QAA01118;
	Sat, 21 Aug 1999 16:19:32 -0500
X-Authentication-Warning: vertigo.gndn.org: tshrider owned process doing -bs
Date: Sat, 21 Aug 1999 16:19:31 -0500 (EST)
From: "Todd M. Shrider" <tshrider@kascope.com>
X-Sender: tshrider@vertigo.gndn.org
To: William Holmes <palsoft@earthlink.net>
cc: Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Root Password
In-Reply-To: <001401beebfc$4eab7ce0$a5fab3d1@billholmes>
Message-ID: <Pine.LNX.4.10.9908211617010.1110-100000@vertigo.gndn.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


You'll need the system cd's, or at least the first cd, to reset the root
passwd. When the system starts, press escape to go into the maintenance
menu and then choose install system software. (Were not actually going to
install the system software). At the meno choose Administration (opetion
13 I believe) and then type chroot

This will put you at a prompt so you can type passwd and give a new root
passwd. As far as I know this is the only way to change things...


--
Todd M. Shrider			Coder Emeritus
Kaleidoscope Inc.		The Diner Inc.
tshrider@kascope.com		(317)581-6378

       I degaussed my girlfriend and I'm 
       just not attracted to her anymore. 

On Sat, 21 Aug 1999, William Holmes wrote:

> I just got a O2 system and the root password is set and I have no idea what it is. System runnig fine with IRIX 6.3 but no CD'S. I know this doesn't have any thing to do with LINUX but can some one help?
> 
> Thanks In Advance
> 
> William Holmes
> 
