Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id IAA363922 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Sep 1997 08:56:23 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id IAA06197 for linux-list; Fri, 26 Sep 1997 08:56:12 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id IAA06182; Fri, 26 Sep 1997 08:56:10 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id IAA10936; Fri, 26 Sep 1997 08:56:09 -0700
Date: Fri, 26 Sep 1997 08:56:09 -0700
Message-Id: <199709261556.IAA10936@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: LetherGlov@aol.com
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: R3000 SGI machines
In-Reply-To: <970926072404_1332144893@emout08.mail.aol.com>
References: <970926072404_1332144893@emout08.mail.aol.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

LetherGlov@aol.com writes:
 > You know I was just thinking about that this morning. I was more leaning
 > towards the personal iris, and the crimson with the video adapter that is not
 > supported in 6.2(the name isn't coming to me right now, GTX?). I was
 > wondering how we got the specs from the ethernet, bus, and serial controllers
 > from SGI. And the chip specs from mips. If I understand SGI history
 > correctly, there was a change in the CPU after revision 3, and we are going
 > to need to see if this is going to cause problems. another thing we need to
 > do(I'll do it) is call ID Software and get the code for DOOM so It can be
 > compiled for Linux.

     The MIPS processor specifications are public, and available as printed
books.  Also, many of them are online at http://www.sgi.com/MIPS/.  

     With the approval of the appropriate division general manager, I 
supplied the people doing the Indy port of linux with copies of the
Indy hardware documentation.

     Since the Personal IRIX and Crimson use mostly VME controllers. those
drivers should carry over from other VME ports.  I don't know if I can
arrange to provide documentation for the graphics controllers.
