Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id VAA28203 for <linux-archive@neteng.engr.sgi.com>; Sat, 1 Aug 1998 21:40:28 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id VAA95695
	for linux-list;
	Sat, 1 Aug 1998 21:39:51 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id VAA13966
	for <linux@cthulhu.engr.sgi.com>;
	Sat, 1 Aug 1998 21:39:49 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from lager.engsoc.carleton.ca (lager.engsoc.carleton.ca [134.117.69.26]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id VAA26793
	for <linux@cthulhu.engr.sgi.com>; Sat, 1 Aug 1998 21:39:48 -0700 (PDT)
	mail_from (adevries@engsoc.carleton.ca)
Received: from localhost (adevries@localhost)
	by lager.engsoc.carleton.ca (8.8.7/8.8.7) with SMTP id AAA18477;
	Sun, 2 Aug 1998 00:39:37 -0400
X-Authentication-Warning: lager.engsoc.carleton.ca: adevries owned process doing -bs
Date: Sun, 2 Aug 1998 00:39:37 -0400 (EDT)
From: Alex deVries <adevries@engsoc.carleton.ca>
To: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: FYI newport abscon
In-Reply-To: <19980802022907.05519@alpha.franken.de>
Message-ID: <Pine.LNX.3.95.980802003721.4859A-100000@lager.engsoc.carleton.ca>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


On Sun, 2 Aug 1998, Thomas Bogendoerfer wrote:
> yesterday I managed to bring up my Indy with the new console code riped
> out from 2.1.109. Today I've implemented new scrolling stuff for newport
> abscon, which will give us a really fast console. 

This is very, very cool, and much needed to go on with 2.1.x kernel
development.  

> My simple test program, 
> which does 1000 printf("\n") in a loop, gives me about 62000 lines/second
> on a 160x64 sized console. I also tried that program on my Dual P-233
> with a Matrox Millenium and got about 260000 lines/s on a 80x25 sized
> console (which is less than 1/5 the size of the Indy console).
> 

Well, this is very cool.  What kind of use is this?  aalib... man, that'll
be neat.  To hell with X when you have aalib.

Huge congratulations on the abscon stuff, Thomas.  

- Alex
