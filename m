Received: from deliverator.sgi.com (deliverator.sgi.com [204.94.214.10])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA04274
	for <pstadt@stud.fh-heilbronn.de>; Sun, 22 Aug 1999 00:10:23 +0200
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by deliverator.sgi.com (980309.SGI.8.8.8-aspam-6.2/980310.SGI-aspam) via ESMTP id PAA01834; Sat, 21 Aug 1999 15:06:53 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA43363
	for linux-list;
	Sat, 21 Aug 1999 15:02:40 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA41265
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 21 Aug 1999 15:02:34 -0700 (PDT)
	mail_from (brett@madhouse.org)
Received: from caligula.madhouse.org ([216.160.90.69]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via SMTP id PAA09586
	for <linux@cthulhu.engr.sgi.com>; Sat, 21 Aug 1999 15:02:33 -0700 (PDT)
	mail_from (brett@madhouse.org)
Received: (qmail 20175 invoked by uid 509); 21 Aug 1999 22:09:26 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Aug 1999 22:09:26 -0000
Date: Sat, 21 Aug 1999 15:09:26 -0700 (PDT)
From: brett <brett@madhouse.org>
To: "Todd M. Shrider" <tshrider@kascope.com>
cc: William Holmes <palsoft@earthlink.net>, Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: Root Password
In-Reply-To: <Pine.LNX.4.10.9908211617010.1110-100000@vertigo.gndn.org>
Message-ID: <Pine.LNX.3.96.990821150833.20173A-100000@caligula.madhouse.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

not having a system cd for an old Indigo I went over to rootshell.com and
got a root exploit for the system.

b



On Sat, 21 Aug 1999, Todd M. Shrider wrote:

> 
> You'll need the system cd's, or at least the first cd, to reset the root
> passwd. When the system starts, press escape to go into the maintenance
> menu and then choose install system software. (Were not actually going to
> install the system software). At the meno choose Administration (opetion
> 13 I believe) and then type chroot
> 
> This will put you at a prompt so you can type passwd and give a new root
> passwd. As far as I know this is the only way to change things...
> 
> 
> --
> Todd M. Shrider			Coder Emeritus
> Kaleidoscope Inc.		The Diner Inc.
> tshrider@kascope.com		(317)581-6378
> 
>        I degaussed my girlfriend and I'm 
>        just not attracted to her anymore. 
> 
> On Sat, 21 Aug 1999, William Holmes wrote:
> 
> > I just got a O2 system and the root password is set and I have no idea what it is. System runnig fine with IRIX 6.3 but no CD'S. I know this doesn't have any thing to do with LINUX but can some one help?
> > 
> > Thanks In Advance
> > 
> > William Holmes
> > 
> 
> 
