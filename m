Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA84303 for <linux-archive@neteng.engr.sgi.com>; Wed, 3 Feb 1999 09:11:40 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA25410
	for linux-list;
	Wed, 3 Feb 1999 09:10:23 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id JAA44012
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 3 Feb 1999 09:10:21 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id JAA07058
	for <linux@cthulhu.engr.sgi.com>; Wed, 3 Feb 1999 09:10:19 -0800 (PST)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id MAA30672;
	Wed, 3 Feb 1999 12:12:48 -0500
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Wed, 3 Feb 1999 12:12:47 -0500 (EST)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Richard Hartensveld <richard@infopact.nl>
cc: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: Re: Compilation errors
In-Reply-To: <36B85DD8.CCF82EDE@infopact.nl>
Message-ID: <Pine.LNX.3.96.990203121206.16014B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Wed, 3 Feb 1999, Richard Hartensveld wrote:

>                  from init/main.c:15:
> /usr/src/linux/include/linux/sched.h:528: `current' undeclared (first
> use this function)
> /usr/src/linux/include/linux/sched.h:528: (Each undeclared identifier is
> reported only once
> /usr/src/linux/include/linux/sched.h:528: for each function it appears

Use egcs and you will have no problems.  You'll be a better person, too.

- Alex
