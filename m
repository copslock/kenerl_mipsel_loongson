Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA71069 for <linux-archive@neteng.engr.sgi.com>; Fri, 28 Aug 1998 15:23:56 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA05579
	for linux-list;
	Fri, 28 Aug 1998 15:23:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA01911
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 28 Aug 1998 15:23:19 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA14473
	for <linux@cthulhu.engr.sgi.com>; Fri, 28 Aug 1998 15:23:20 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-12.uni-koblenz.de [141.26.249.12])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA06813
	for <linux@cthulhu.engr.sgi.com>; Sat, 29 Aug 1998 00:23:17 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id BAA01424;
	Fri, 28 Aug 1998 01:25:04 +0200
Message-ID: <19980828012504.C1381@uni-koblenz.de>
Date: Fri, 28 Aug 1998 01:25:04 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>,
        Arnaud Le Neel <Arnaud.Le.Neel@cyceron.fr>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: boot problem for Indy
References: <35E59FBA.96A1900C@cyceron.fr> <Pine.LNX.3.96.980827131327.10299B-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.96.980827131327.10299B-100000@lager.engsoc.carleton.ca>; from Alex deVries on Thu, Aug 27, 1998 at 01:16:44PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Aug 27, 1998 at 01:16:44PM -0400, Alex deVries wrote:

> On Thu, 27 Aug 1998, Arnaud Le Neel wrote:
> > >> boot -f bootp()linux.cyceron.fr:vmlinux
> > Setting $netaddr to 192.93.44.35 (for server server.cyceron.fr)
> > Obtaining vmlinux from server.cyceron.fr
> > Cannot reload bootp()server.cyceron.fr:vmlinux
> > Illegal f_magik number 0x7f45, expected MIPSELMAGIC or MIPSEBMAGIC
> > Unable to load bootp()server.cyceron.fr:vmlinux: execute format error
> > PS: Here is the description of the Indy i want to boot Linux:
> > 	IP22 100MHz R4000 with FPU
> 
> Hm.  Sounds to me like a processor thing.  Could that be, Ralf?  I'm not
> sure I've seen anyone try on an R4000 before, and if so, wha the
> implications of are for its cache.

No, _this_ is not a processor thing.  However some 100MHz R4000 have a
processor bug (the count/compare thing) which we don't handle yet.  The
bug shouldn't be lethal it might just result in temporary lockup of the
machine for about 86s during which no more timer interrupt are being
delivered.  The fix is known; it just needs to be implemented.

  Ralf
