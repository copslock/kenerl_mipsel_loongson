Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id TAA66317 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Jun 1998 19:58:20 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id TAA33674
	for linux-list;
	Fri, 26 Jun 1998 19:57:43 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id TAA07826
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 26 Jun 1998 19:57:39 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id TAA07593
	for <linux@cthulhu.engr.sgi.com>; Fri, 26 Jun 1998 19:57:36 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id WAA21542;
	Fri, 26 Jun 1998 22:56:08 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Fri, 26 Jun 1998 22:56:08 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: "Francis M.J. Hsieh" <mjhsieh@life.nthu.edu.tw>,
        linux@cthulhu.engr.sgi.com
Subject: Re: possible driver error?
In-Reply-To: <m0ypWIG-000aOoC@the-village.bc.nu>
Message-ID: <Pine.LNX.3.95.980626225235.19185E-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Fri, 26 Jun 1998, Alan Cox wrote:
> >   Here is a possible driver error (but seems harmless, I checked it
> >   using network managerment hardware, no transmission error occured)
> I think someone is shipping old ifconfig tools with Linux/SGI. See if
> "cat /proc/net/dev" makes sense

"someone" in this case is me;  I'm shipping the same net-tools that comes
with RH 5.1.  Of course, that's a 2.0.34 kernel.  I assume there's some
sort of inconsistancy between the /proc interfaces of 2.1.x and 2.0.34.

So, I'll have to stitch that package up.  In some ways, we're very much
skewed from RH 5.1 distribution because of the 2.1 kernel, apart from
other things. 

If someone would like to do that, it'd be appreciated, but I'll fix this
otherwise.

Thanks for the bug report.

- Alex
