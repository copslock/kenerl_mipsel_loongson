Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA367854 for <linux-archive@neteng.engr.sgi.com>; Fri, 26 Sep 1997 11:59:10 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA13897 for linux-list; Fri, 26 Sep 1997 11:58:52 -0700
Received: from dragon.engr.sgi.com (dragon.engr.sgi.com [150.166.63.33]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA13889 for <linux@cthulhu.engr.sgi.com>; Fri, 26 Sep 1997 11:58:51 -0700
Received: (from sr@localhost) by dragon.engr.sgi.com (970321.SGI.8.8.5/970502.SGI.AUTOCF) id LAA67409 for linux@engr.sgi.com; Fri, 26 Sep 1997 11:58:50 -0700 (PDT)
From: sr@dragon.engr.sgi.com (Steve Rikli)
Message-Id: <199709261858.LAA67409@dragon.engr.sgi.com>
Subject: Re: R3000 SGI machines
To: linux@cthulhu.engr.sgi.com
Date: Fri, 26 Sep 1997 11:58:50 -0700 (PDT)
In-Reply-To: <199709261556.IAA10936@fir.engr.sgi.com> from "William J. Earl" at Sep 26, 97 08:56:09 am
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

William J. Earl wrote:
> LetherGlov@aol.com writes:
>>
>> You know I was just thinking about that this morning. I was more leaning
>> towards the personal iris, and the crimson with the video adapter that is not
>> supported in 6.2(the name isn't coming to me right now, GTX?). I was
>> wondering how we got the specs from the ethernet, bus, and serial controllers
>> from SGI. And the chip specs from mips. If I understand SGI history
>> correctly, there was a change in the CPU after revision 3, and we are going
>> to need to see if this is going to cause problems. another thing we need to
>> do(I'll do it) is call ID Software and get the code for DOOM so It can be
>> compiled for Linux.
> 
>      The MIPS processor specifications are public, and available as printed
> books.  Also, many of them are online at http://www.sgi.com/MIPS/.  
> 
>      With the approval of the appropriate division general manager, I 
> supplied the people doing the Indy port of linux with copies of the
> Indy hardware documentation.
> 
>      Since the Personal IRIX and Crimson use mostly VME controllers. those
> drivers should carry over from other VME ports.  I don't know if I can
> arrange to provide documentation for the graphics controllers.

This may not be exactly the kind of thing some of y'all are looking
for, but since we're talking about doc & info sources for old SGI
hardware I felt I should point this one out:

	http://www.geocities.com/SiliconValley/Pines/2258/4dfaq.html

Several handfulls of general notes about the 4D and/or other R3K 
platforms.

Hope someone finds it useful.

cheers,
sr.
-- 
|| Steve Rikli <sr@sgi.com> ||| Any sufficiently advanced technology is ||
|| Systems Administrator    ||| indistinguishable from a rigged demo.   ||
|| NSD, EIS Infrastructure  |||                                         ||
|| Silicon Graphics, Inc.   |||               - Andy Finkel             ||
