Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA48636 for <linux-archive@neteng.engr.sgi.com>; Sun, 18 Oct 1998 17:16:32 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA28762
	for linux-list;
	Sun, 18 Oct 1998 17:16:30 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id RAA38990;
	Sun, 18 Oct 1998 17:16:28 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id RAA15191; Sun, 18 Oct 1998 17:15:43 -0700
Date: Sun, 18 Oct 1998 17:15:43 -0700
Message-Id: <199810190015.RAA15191@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Ulf Carlsson <grim@zigzegv.ml.org>
Cc: ralf@uni-koblenz.de, Jeff Coffin <jcoffin@sv.usweb.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: Partial Success Report
In-Reply-To: <19981018020954.A3868@zigzegv.ml.org>
References: <m3ww618s88.fsf@lil.sv.usweb.com>
	<19981016001717.B2072@zigzegv.ml.org>
	<m3pvbt8k2y.fsf@lil.sv.usweb.com>
	<19981016214659.A2754@zigzegv.ml.org>
	<19981017040148.C4768@uni-koblenz.de>
	<19981018020954.A3868@zigzegv.ml.org>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ulf Carlsson writes:
 > On Sat, Oct 17, 1998 at 04:01:48AM +0200, ralf@uni-koblenz.de wrote:
 > > On Fri, Oct 16, 1998 at 09:46:59PM +0200, Ulf Carlsson wrote:
 > > 
 > > bootp() is just a ARC filename which is either interpreted by the PROM
 > > command interpreter or by sash where sash afaik is nothing other than the
 > > PROMs compiled with special flags.
 > 
 > The command 'boot bootp():' requires a harddrive, but I can run 'bootp():'
 > diskless. Does the 'boot' part of the command tell the PROM to use sash?

      Try

	boot -f bootp():

This avoids trying to load sash.
