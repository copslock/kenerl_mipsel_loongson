Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id AAA04769 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Apr 1999 00:11:02 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id AAA23866
	for linux-list;
	Thu, 15 Apr 1999 00:09:51 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id AAA06873
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 15 Apr 1999 00:09:50 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: from ruvild.bun.falkenberg.se ([194.236.80.7]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id AAA02524
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Apr 1999 00:09:46 -0700 (PDT)
	mail_from (ulfc@bun.falkenberg.se)
Received: by bun.falkenberg.se
	via sendmail from stdin
	id <m10XgIL-002viBC@ruvild.bun.falkenberg.se> (Debian Smail3.2.0.102)
	for linux@cthulhu.engr.sgi.com; Thu, 15 Apr 1999 09:10:41 +0200 (CEST) 
Date: Thu, 15 Apr 1999 09:10:41 +0200
From: Ulf Carlsson <ulfc@bun.falkenberg.se>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: glibc 2.1
Message-ID: <19990415091041.A3402@ruvild.bun.falkenberg.se>
References: <Pine.LNX.3.96.990414213802.29768C-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.95.3i
In-Reply-To: <Pine.LNX.3.96.990414213802.29768C-100000@lager.engsoc.carleton.ca>; from Alex deVries on Wed, Apr 14, 1999 at 09:39:02PM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi Alex,

> Has anyone started work on glibc 2.1 for mips{eb|el}?  I'd like to start
> on a port of Red Hat 6.0 ofor mipseb and mipsel.

I tried to do this some time ago, but I never finished it. I have heard that
Ralf has done some work here, maybe he can share his work with us. I've tried
to persuade him to do this before without any success. I'd like to have these
patches as well so that I may continue working with the D word. :-)

Well, if we can't get these patches I'd like to help you with the porting work
for glibc 2.1.

- Ulf
