Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id RAA356209 for <linux-archive@neteng.engr.sgi.com>; Tue, 2 Sep 1997 17:06:51 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA05086 for linux-list; Tue, 2 Sep 1997 17:05:57 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA05001 for <linux@cthulhu.engr.sgi.com>; Tue, 2 Sep 1997 17:05:42 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id RAA28778
	for <linux@cthulhu.engr.sgi.com>; Tue, 2 Sep 1997 17:05:40 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id SAA19505;
	Tue, 2 Sep 1997 18:58:22 -0500
Date: Tue, 2 Sep 1997 18:58:22 -0500
Message-Id: <199709022358.SAA19505@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: adevries@engsoc.carleton.ca
CC: marks@sun470.sun470.rd.qms.com, linux@cthulhu.engr.sgi.com
In-reply-to: 
	<Pine.LNX.3.95.970902180957.5212B-100000@lager.engsoc.carleton.ca>
	(message from Alex deVries on Tue, 2 Sep 1997 19:45:59 -0400 (EDT))
Subject: Re: Booting off of sdb1...
X-Mexico: Este es un pais de orates, un pais amateur.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


> <snip>
> 
> Well, I would try that patch, but I am unable to compile kernels because I
> _always_ get this:

Probably you missed my post and Ralf's post on this issue. 

> I'm using the gcc that's up on ftp.linux.sgi.com, and I'm using binutils
> 2.8.1, which is the latest I believe.

You need to get the binutils tar file as it was made available on
ftp.linux.sgi.com, not the cross-compiler kit, nor the 2.8.1 release
from the FSF.  

> _PLEASE_ can someone who is able to succesfully cross compile kernels post
> here what versions they are using, and where I can get them from. Not
> sorting this out brings my development efforts to a complete stop. 

berenice-origin32$ mips-linux-as --version
GNU assembler version 2.7 (mips-linux), using BFD version 2.7

berenice-origin32$ mycc --version
2.7.2

But then, those versions are not really the stock GNU versions, they
are the ones available in ftp.linux.sgi.com

Cheers,
Miguel.
