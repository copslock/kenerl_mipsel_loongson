Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA79011 for <linux-archive@neteng.engr.sgi.com>; Fri, 27 Nov 1998 15:02:23 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA98006
	for linux-list;
	Fri, 27 Nov 1998 15:01:25 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA98022;
	Fri, 27 Nov 1998 15:01:21 -0800 (PST)
	mail_from (Olivier.Galibert@loria.fr)
Received: from lorraine.loria.fr (lorraine.loria.fr [152.81.1.17]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA04761; Fri, 27 Nov 1998 15:01:19 -0800 (PST)
	mail_from (Olivier.Galibert@loria.fr)
Received: from renaissance.loria.fr (renaissance.loria.fr [152.81.4.102])
	by lorraine.loria.fr (8.8.7/8.8.7/8.8.7/JCG) with ESMTP id XAA26206;
	Fri, 27 Nov 1998 23:59:20 +0100 (MET)
Received: (from galibert@localhost) by renaissance.loria.fr (8.8.2/8.8.2) id XAA20211; Fri, 27 Nov 1998 23:59:18 +0100 (MET)
Message-ID: <19981127235918.A20200@loria.fr>
Date: Fri, 27 Nov 1998 23:59:18 +0100
From: Olivier Galibert <galibert@pobox.com>
To: ralf@uni-koblenz.de, Ariel Faigon <ariel@oz.engr.sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: help offered
Mail-Followup-To: ralf@uni-koblenz.de, Ariel Faigon <ariel@oz.engr.sgi.com>,
	linux@cthulhu.engr.sgi.com
References: <19981125204900.A4692@loria.fr> <199811252037.MAA37649@oz.engr.sgi.com> <19981126062837.A1134@uni-koblenz.de> <19981126085407.A2201@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1i
In-Reply-To: <19981126085407.A2201@uni-koblenz.de>; from ralf@uni-koblenz.de on Thu, Nov 26, 1998 at 08:54:07AM -0600
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Nov 26, 1998 at 08:54:07AM -0600, ralf@uni-koblenz.de wrote:
> On Thu, Nov 26, 1998 at 06:28:37AM -0600, ralf@uni-koblenz.de wrote:
> 
> > The big ones which still need a lot of work are
> > 
> >  - VFS and lower layers are protected by the big kernel lock.
> 
> Talked with Stephen Tweedie about this, it's considered a tough job to
> multithread that right.

Afaik, the main problem is avoiding deadlocks.  Tough job.

  OG.
