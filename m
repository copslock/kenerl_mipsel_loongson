Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA06062
	for <pstadt@stud.fh-heilbronn.de>; Sun, 22 Aug 1999 00:36:00 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA03843; Sat, 21 Aug 1999 15:32:17 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA70486
	for linux-list;
	Sat, 21 Aug 1999 15:27:15 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA62988
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 21 Aug 1999 15:27:11 -0700 (PDT)
	mail_from (tshrider@kascope.com)
Received: from vertigo.gndn.org ([216.50.90.66]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA01152
	for <linux@cthulhu.engr.sgi.com>; Sat, 21 Aug 1999 15:27:09 -0700 (PDT)
	mail_from (tshrider@kascope.com)
Received: from localhost (tshrider@localhost)
	by vertigo.gndn.org (8.9.3/8.9.3) with ESMTP id MAA00581;
	Sat, 21 Aug 1999 12:27:44 -0500
X-Authentication-Warning: vertigo.gndn.org: tshrider owned process doing -bs
Date: Sat, 21 Aug 1999 12:27:44 -0500 (EST)
From: "Todd M. Shrider" <tshrider@kascope.com>
X-Sender: tshrider@vertigo.gndn.org
To: brett <brett@madhouse.org>
cc: William Holmes <palsoft@earthlink.net>, Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Root Password
In-Reply-To: <Pine.LNX.3.96.990821150833.20173A-100000@caligula.madhouse.org>
Message-ID: <Pine.LNX.4.10.9908211227300.579-100000@vertigo.gndn.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


hehe... well, that will work to, I guess... :-)


--
Todd M. Shrider			Coder Emeritus
Kaleidoscope Inc.		The Diner Inc.
tshrider@kascope.com		(317)581-6378

       I degaussed my girlfriend and I'm 
       just not attracted to her anymore. 

On Sat, 21 Aug 1999, brett wrote:

> not having a system cd for an old Indigo I went over to rootshell.com and
> got a root exploit for the system.
> 
> b
> 
> 
> 
> On Sat, 21 Aug 1999, Todd M. Shrider wrote:
> 
> > 
> > You'll need the system cd's, or at least the first cd, to reset the root
> > passwd. When the system starts, press escape to go into the maintenance
> > menu and then choose install system software. (Were not actually going to
> > install the system software). At the meno choose Administration (opetion
> > 13 I believe) and then type chroot
> > 
> > This will put you at a prompt so you can type passwd and give a new root
> > passwd. As far as I know this is the only way to change things...
> > 
> > 
> > --
> > Todd M. Shrider			Coder Emeritus
> > Kaleidoscope Inc.		The Diner Inc.
> > tshrider@kascope.com		(317)581-6378
> > 
> >        I degaussed my girlfriend and I'm 
> >        just not attracted to her anymore. 
> > 
> > On Sat, 21 Aug 1999, William Holmes wrote:
> > 
> > > I just got a O2 system and the root password is set and I have no idea what it is. System runnig fine with IRIX 6.3 but no CD'S. I know this doesn't have any thing to do with LINUX but can some one help?
> > > 
> > > Thanks In Advance
> > > 
> > > William Holmes
> > > 
> > 
> > 
> 
