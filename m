Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id JAA99397 for <linux-archive@neteng.engr.sgi.com>; Thu, 24 Sep 1998 09:46:37 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id JAA25998
	for linux-list;
	Thu, 24 Sep 1998 09:45:08 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id JAA97917;
	Thu, 24 Sep 1998 09:45:04 -0700 (PDT)
	mail_from (wje@fir.engr.sgi.com)
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA13188; Thu, 24 Sep 1998 09:44:53 -0700
Date: Thu, 24 Sep 1998 09:44:53 -0700
Message-Id: <199809241644.JAA13188@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Alex deVries <adevries@engsoc.carleton.ca>
Cc: Jeremy John Welling <jwelling@engin.umich.edu>, linux@cthulhu.engr.sgi.com
Subject: Re: challenge s boots linux
In-Reply-To: <Pine.LNX.3.96.980924123140.20033F-100000@lager.engsoc.carleton.ca>
References: <Pine.SOL.4.02.9809240031070.6032-100000@azure.engin.umich.edu>
	<Pine.LNX.3.96.980924123140.20033F-100000@lager.engsoc.carleton.ca>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries writes:
...
 > But, i've been thinking for awhile that an Indigo2 port would be the next
 > box to target... i suppose there's no harm in looking at both machines
 > concurrently.
 > 
 > Getting docs on the Indigo2 would be quite important for a successful
 > port, though.  That would require SGI's help, and I can see them being a
 > lot more open to it if we got the Indy completely supported first.
...

     Except for the EISA slots, Indigo2 is pretty close to Indy.  They run
the same IRIX kernel binary.  The graphics are more of an issue, since most
Indigo2 systems use something other than Newport ("XL") graphics.  It might
be possible for Linux to get by using the very basic microcode downloaded by
the PROM for XZ and other microcoded graphics cards, but I have not had time
to research the interface presented.  

     There is general willingness to release information, although releasing
Indigo2-specific information would require a new authorization.  The main
problem is finding it in a form useful to people outside SGI.  (That is not
true for all hardware, but it is for quite a few of our older systems.)
The easiest path would be if someone inside SGI cobbled up basic sample
drivers for the various graphics cards, but so far there are no volunteers.
(The reason it would be the easiest path is that SGI employees can use the
IRIX source as a guide.)
