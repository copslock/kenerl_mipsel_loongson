Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id PAA36566 for <linux-archive@neteng.engr.sgi.com>; Thu, 24 Sep 1998 15:39:04 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA65436
	for linux-list;
	Thu, 24 Sep 1998 15:37:22 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA07452;
	Thu, 24 Sep 1998 15:37:06 -0700 (PDT)
	mail_from (richardh@infopact.nl)
Received: from bronx.bizarre.nl (9dyn101.breda.casema.net [195.96.116.101]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA08477; Thu, 24 Sep 1998 15:37:01 -0700 (PDT)
	mail_from (richardh@infopact.nl)
Received: from infopact.nl (root@localhost [127.0.0.1])
	by bronx.bizarre.nl (8.9.0/8.9.0) with ESMTP id AAA03397;
	Fri, 25 Sep 1998 00:42:21 +0200
Message-ID: <360ACACD.5533F8CA@infopact.nl>
Date: Fri, 25 Sep 1998 00:42:21 +0200
From: Richard Hartensveld <richardh@infopact.nl>
X-Mailer: Mozilla 4.05 [en] (X11; I; Linux 2.0.35 i686)
MIME-Version: 1.0
To: "William J. Earl" <wje@fir.engr.sgi.com>
CC: Alex deVries <adevries@engsoc.carleton.ca>,
        Jeremy John Welling <jwelling@engin.umich.edu>,
        linux@cthulhu.engr.sgi.com
Subject: Re: challenge s boots linux
References: <Pine.SOL.4.02.9809240031070.6032-100000@azure.engin.umich.edu>
		<Pine.LNX.3.96.980924123140.20033F-100000@lager.engsoc.carleton.ca> <199809241644.JAA13188@fir.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

William J. Earl wrote:

> Alex deVries writes:
> ...
>  > But, i've been thinking for awhile that an Indigo2 port would be the next
>  > box to target... i suppose there's no harm in looking at both machines
>  > concurrently.
>  >
>  > Getting docs on the Indigo2 would be quite important for a successful
>  > port, though.  That would require SGI's help, and I can see them being a
>  > lot more open to it if we got the Indy completely supported first.
> ...
>
>      Except for the EISA slots, Indigo2 is pretty close to Indy.  They run
> the same IRIX kernel binary.  The graphics are more of an issue, since most
> Indigo2 systems use something other than Newport ("XL") graphics.  It might
> be possible for Linux to get by using the very basic microcode downloaded by
> the PROM for XZ and other microcoded graphics cards, but I have not had time
> to research the interface presented.
>

If i'll get my indigo2 with extreme gfx back to work, i'll see how far i can
come with a kernel that usesa serial terminal for it's output. (no gfx card
needed there).

But first get my crosscompiler to work properly ;]

Richard
