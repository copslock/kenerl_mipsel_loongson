Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA33197 for <linux-archive@neteng.engr.sgi.com>; Sat, 17 Oct 1998 17:09:02 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA71959
	for linux-list;
	Sat, 17 Oct 1998 17:08:27 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA79081
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 17 Oct 1998 17:08:25 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from calypso.saturn (dialup91-1-9.swipnet.se [130.244.91.9]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA09940
	for <linux@cthulhu.engr.sgi.com>; Sat, 17 Oct 1998 17:08:23 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: by zigzegv.ml.org
	via sendmail from stdin
	id <m0zUgPy-000w6YC@calypso.saturn> (Debian Smail3.2.0.101)
	for linux@cthulhu.engr.sgi.com; Sun, 18 Oct 1998 02:09:54 +0200 (CEST) 
Message-ID: <19981018020954.A3868@zigzegv.ml.org>
Date: Sun, 18 Oct 1998 02:09:54 +0200
From: Ulf Carlsson <grim@zigzegv.ml.org>
To: ralf@uni-koblenz.de, Jeff Coffin <jcoffin@sv.usweb.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: Partial Success Report
References: <m3ww618s88.fsf@lil.sv.usweb.com> <19981016001717.B2072@zigzegv.ml.org> <m3pvbt8k2y.fsf@lil.sv.usweb.com> <19981016214659.A2754@zigzegv.ml.org> <19981017040148.C4768@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19981017040148.C4768@uni-koblenz.de>; from ralf@uni-koblenz.de on Sat, Oct 17, 1998 at 04:01:48AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sat, Oct 17, 1998 at 04:01:48AM +0200, ralf@uni-koblenz.de wrote:
> On Fri, Oct 16, 1998 at 09:46:59PM +0200, Ulf Carlsson wrote:
> 
> bootp() is just a ARC filename which is either interpreted by the PROM
> command interpreter or by sash where sash afaik is nothing other than the
> PROMs compiled with special flags.

The command 'boot bootp():' requires a harddrive, but I can run 'bootp():'
diskless. Does the 'boot' part of the command tell the PROM to use sash?

- Ulf
