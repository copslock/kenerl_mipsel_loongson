Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id QAA78338 for <linux-archive@neteng.engr.sgi.com>; Sat, 17 Oct 1998 16:57:25 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id QAA39627
	for linux-list;
	Sat, 17 Oct 1998 16:56:42 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id QAA72407
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 17 Oct 1998 16:56:39 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from mailhost.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.64.1]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id QAA08763
	for <linux@cthulhu.engr.sgi.com>; Sat, 17 Oct 1998 16:56:35 -0700 (PDT)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (pmport-15.uni-koblenz.de [141.26.249.15])
	by mailhost.uni-koblenz.de (8.9.1/8.9.1) with ESMTP id BAA14354
	for <linux@cthulhu.engr.sgi.com>; Sun, 18 Oct 1998 01:56:30 +0200 (MET DST)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id EAA05275;
	Sat, 17 Oct 1998 04:01:48 +0200
Message-ID: <19981017040148.C4768@uni-koblenz.de>
Date: Sat, 17 Oct 1998 04:01:48 +0200
From: ralf@uni-koblenz.de
To: Ulf Carlsson <grim@zigzegv.ml.org>, Jeff Coffin <jcoffin@sv.usweb.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: Partial Success Report
References: <m3ww618s88.fsf@lil.sv.usweb.com> <19981016001717.B2072@zigzegv.ml.org> <m3pvbt8k2y.fsf@lil.sv.usweb.com> <19981016214659.A2754@zigzegv.ml.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <19981016214659.A2754@zigzegv.ml.org>; from Ulf Carlsson on Fri, Oct 16, 1998 at 09:46:59PM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Oct 16, 1998 at 09:46:59PM +0200, Ulf Carlsson wrote:

> I thought the bootp command was loaded from the IRIX partition, because it
> didn't work when I removed the IRIX harddrive, atleast it didn't with my old
> PROM.  It claimed that it couldn't find the bootp() command - maybe I'm out of
> my mind, I'll check next time I remove the cover...

bootp() is just a ARC filename which is either interpreted by the PROM
command interpreter or by sash where sash afaik is nothing other than the
PROMs compiled with special flags.

  Ralf
