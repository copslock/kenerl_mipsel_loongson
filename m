Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA12841 for <linux-archive@neteng.engr.sgi.com>; Sun, 28 Jun 1998 11:59:26 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA77250
	for linux-list;
	Sun, 28 Jun 1998 11:58:57 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA53001
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 28 Jun 1998 11:58:55 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA20641
	for <linux@cthulhu.engr.sgi.com>; Sun, 28 Jun 1998 11:58:54 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id OAA12544;
	Sun, 28 Jun 1998 14:58:20 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sun, 28 Jun 1998 14:58:20 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: "Francis M. J. Hsieh" <mjhsieh@life.nthu.edu.tw>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: hmmmm.... nice job!!
In-Reply-To: <19980629205224.A1023@life.nthu.edu.tw>
Message-ID: <Pine.LNX.3.95.980628145721.10146B-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Mon, 29 Jun 1998, Francis M. J. Hsieh wrote:
> I just installed this nice/impressive OS in our indy, the network speed
> is faster than it is on irix6.2. And it had a huge screen :-)

Good!

> I have setup a ftp service and one www service on this linux, it works
> fine. :-)
> 
> here are some small problems :-)
>  - Sometimes after closing telnet connection, it shows
> 	bpti [/home/mjhsieh] -mjhsieh- logout
> 	tput: tgetent failure: No such file or directory
> 	tput: tgetent failure: No such file or directory
> 	Connection closed by foreign host."

Hm.  That's new to me.  I look at it.

>  - possible no sound support (beep ?)

No, no sound support yet.

>  - (sometimes) a strange garbage image, about 1 character size in the
>    lowerleft corner of the screen

Yup, that's a console bug, I get that too.

- Alex
