Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id SAA06718 for <linux-archive@neteng.engr.sgi.com>; Fri, 27 Nov 1998 18:46:38 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id SAA31504
	for linux-list;
	Fri, 27 Nov 1998 18:45:23 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id SAA10592;
	Fri, 27 Nov 1998 18:45:18 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: from lappi.waldorf-gmbh.de (cs9-11.modems.unam.mx [132.248.134.50]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id SAA06658; Fri, 27 Nov 1998 18:45:11 -0800 (PST)
	mail_from (ralf@lappi.waldorf-gmbh.de)
Received: (from ralf@localhost)
	by lappi.waldorf-gmbh.de (8.8.7/8.8.7) id UAA01089;
	Fri, 27 Nov 1998 20:45:08 -0600
Message-ID: <19981127204507.E690@uni-koblenz.de>
Date: Fri, 27 Nov 1998 20:45:07 -0600
From: ralf@uni-koblenz.de
To: Ariel Faigon <ariel@oz.engr.sgi.com>, linux@cthulhu.engr.sgi.com
Subject: Re: help offered
References: <19981125204900.A4692@loria.fr> <199811252037.MAA37649@oz.engr.sgi.com> <19981126062837.A1134@uni-koblenz.de> <19981126085407.A2201@uni-koblenz.de> <19981127235918.A20200@loria.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <19981127235918.A20200@loria.fr>; from Olivier Galibert on Fri, Nov 27, 1998 at 11:59:18PM +0100
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Fri, Nov 27, 1998 at 11:59:18PM +0100, Olivier Galibert wrote:

> On Thu, Nov 26, 1998 at 08:54:07AM -0600, ralf@uni-koblenz.de wrote:
> > On Thu, Nov 26, 1998 at 06:28:37AM -0600, ralf@uni-koblenz.de wrote:
> > 
> > > The big ones which still need a lot of work are
> > > 
> > >  - VFS and lower layers are protected by the big kernel lock.
> > 
> > Talked with Stephen Tweedie about this, it's considered a tough job to
> > multithread that right.
> 
> Afaik, the main problem is avoiding deadlocks.  Tough job.

Not only, it has to be efficient and Linus has to like it.  As things are
right now only some of Stephen's work in that area was done with MT in
mind.

  Ralf
