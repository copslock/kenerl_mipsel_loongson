Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA43829 for <linux-archive@neteng.engr.sgi.com>; Sun, 18 Oct 1998 17:14:41 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA21822
	for linux-list;
	Sun, 18 Oct 1998 17:13:58 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id RAA97669;
	Sun, 18 Oct 1998 17:13:55 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id RAA15175; Sun, 18 Oct 1998 17:13:15 -0700
Date: Sun, 18 Oct 1998 17:13:15 -0700
Message-Id: <199810190013.RAA15175@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: ralf@uni-koblenz.de
Cc: Ulf Carlsson <grim@zigzegv.ml.org>, Jeff Coffin <jcoffin@sv.usweb.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: Partial Success Report
In-Reply-To: <19981017040148.C4768@uni-koblenz.de>
References: <m3ww618s88.fsf@lil.sv.usweb.com>
	<19981016001717.B2072@zigzegv.ml.org>
	<m3pvbt8k2y.fsf@lil.sv.usweb.com>
	<19981016214659.A2754@zigzegv.ml.org>
	<19981017040148.C4768@uni-koblenz.de>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de writes:
 > On Fri, Oct 16, 1998 at 09:46:59PM +0200, Ulf Carlsson wrote:
 > 
 > > I thought the bootp command was loaded from the IRIX partition, because it
 > > didn't work when I removed the IRIX harddrive, atleast it didn't with my old
 > > PROM.  It claimed that it couldn't find the bootp() command - maybe I'm out of
 > > my mind, I'll check next time I remove the cover...
 > 
 > bootp() is just a ARC filename which is either interpreted by the PROM
 > command interpreter or by sash where sash afaik is nothing other than the
 > PROMs compiled with special flags.

       That is, bootp() is part of a path.  There is no bootp command.

       sash, unlike most PROMs, has one or more (read-only) disk file
systems bound into it.  On Indy, older sash versions can read efs volumes,
and newer ones can also read xfs volumes.
