Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA18508; Mon, 16 Jun 1997 17:34:30 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA24131 for linux-list; Mon, 16 Jun 1997 17:33:09 -0700
Received: from titian.engr.sgi.com (titian.engr.sgi.com [150.166.240.38]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA24126; Mon, 16 Jun 1997 17:33:07 -0700
Received: from localhost by titian.engr.sgi.com via SMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id RAA10832; Mon, 16 Jun 1997 17:33:07 -0700
Message-Id: <199706170033.RAA10832@titian.engr.sgi.com>
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: A pointed question about endianness... 
In-reply-to: Your message of "Mon, 16 Jun 1997 23:18:40 +0200."
             <199706162118.XAA08006@informatik.uni-koblenz.de> 
Date: Mon, 16 Jun 1997 17:32:56 -0700
From: Mike McDonald <mikemac@titian.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


>From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
>Subject: Re: A pointed question about endianness...
>To: wje@fir (William J. Earl)
>Date: Mon, 16 Jun 1997 23:18:40 +0200 (MET DST)
>
>>      You probably can't agree on one, unless you can agree on one set
>> of systems.  Most MIPS architecture systems, including all SGI
>> systems, are big-endian, but all DEC systems and all MIPS Magnum 4000
>> systems configured to run NT are little-endian.  (All other MIPS
>> systems are big-endian.)
>
>It's worse than that.  SNI RM series is configurable, Algorithmics eval
>boards are configurable.  
>
>  Ralf

  Is anyone working on the Algorithmics boards? We have 5 of them over
here currently being used with VxWorks (which isn't officially
supported on these boards). I could cause lots of trouble over here if
Linux did work on them. :-)

  Mike McDonald
  mikemac@engr.sgi.com
