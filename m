Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id MAA45233 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Feb 1999 12:52:08 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id MAA84550
	for linux-list;
	Wed, 3 Feb 1999 12:51:17 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id MAA24966
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 3 Feb 1999 12:51:15 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: from calypso.saturn (dialup252-1-156.swipnet.se [130.244.252.156]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id MAA04556
	for <linux@cthulhu.engr.sgi.com>; Wed, 3 Feb 1999 12:51:11 -0800 (PST)
	mail_from (ulfc@bun.falkenberg.se)
Received: by bun.falkenberg.se
	via sendmail from stdin
	id <m10898w-0015A9C@calypso.saturn> (Debian Smail3.2.0.102)
	for linux@cthulhu.engr.sgi.com; Wed, 3 Feb 1999 21:43:26 +0100 (CET) 
Date: Wed, 3 Feb 1999 21:43:26 +0100
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: Richard Hartensveld <richard@infopact.nl>,
        "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: Compilation errors
Message-ID: <19990203214326.A3430@bun.falkenberg.se>
Mail-Followup-To: Alex deVries <adevries@engsoc.carleton.ca>,
	Richard Hartensveld <richard@infopact.nl>,
	"linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
References: <36B85DD8.CCF82EDE@infopact.nl> <Pine.LNX.3.96.990203121206.16014B-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.1i
In-Reply-To: <Pine.LNX.3.96.990203121206.16014B-100000@lager.engsoc.carleton.ca>; from Alex deVries on Wed, Feb 03, 1999 at 12:12:47PM -0500
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, Feb 03, 1999 at 12:12:47PM -0500, Alex deVries wrote:
> On Wed, 3 Feb 1999, Richard Hartensveld wrote:
> 
> >                  from init/main.c:15:
> > /usr/src/linux/include/linux/sched.h:528: `current' undeclared (first
> > use this function)
> > /usr/src/linux/include/linux/sched.h:528: (Each undeclared identifier is
> > reported only once
> > /usr/src/linux/include/linux/sched.h:528: for each function it appears
> 
> Use egcs and you will have no problems.  You'll be a better person, too.

You may update the specs file instead if you want, and gcc will work. Ask me and
I'll send you the updated specs file.

- Ulf
