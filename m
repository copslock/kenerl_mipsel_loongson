Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA18343; Fri, 30 May 1997 00:16:06 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA18312 for linux-list; Fri, 30 May 1997 00:15:16 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA18307 for <linux@cthulhu.engr.sgi.com>; Fri, 30 May 1997 00:15:13 -0700
Received: from sgiger.munich.sgi.com (sgiger.munich.sgi.com [144.253.192.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA18477 for <linux@yon.engr.sgi.com>; Fri, 30 May 1997 00:15:05 -0700
Received: from knobi.munich.sgi.com by sgiger.munich.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/940406.SGI)
	 id JAA13127; Fri, 30 May 1997 09:14:56 +0200
Received: from knobi (localhost [127.0.0.1]) by knobi.munich.sgi.com (950413.SGI.8.6.12/951220.SGI.AUTOCF.knobi) via SMTP id JAA08230; Fri, 30 May 1997 09:14:51 +0200
Message-ID: <338E7E6A.167E@munich.sgi.com>
Date: Fri, 30 May 1997 09:14:50 +0200
From: Martin Knoblauch <knobi@munich.sgi.com>
Organization: Silicon Graphics GmbH, Am-Hochacker 3, D-85630 Grasbrunn
X-Mailer: Mozilla 3.01SC-SGI (X11; I; IRIX 6.3 IP22)
MIME-Version: 1.0
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
CC: shaver@neon.ingenia.ca, ariel@sgi.com, linux@yon.engr.sgi.com
Subject: Re: hardware independent hinv
References: <199705281742.MAA24940@athena.nuclecu.unam.mx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza wrote:
> 
> 
> There was this lovely tool that showed the memory map, with the
> details on the usage.  You could click on say, Emacs, and get a map of
> where Emacs pages were, and it seemed like it could read the symbol
> table information from the process as well (it showed: "No symbols for
> this page").
> 

 That would be "gmemusage" (in a former life "bloatview", with
some really cool desktop icons. Maybe for Linux, we could replace
the pigs with a real fat penguin :-).

> I also saw some printed slides on some program that seemed to let you
> move related functions together in the binary to avoid page faults.
> Can not really tell, as they were flipping trough them really quick.
> 

 That tool is "cord". It uses feedback from prof/pixie experiments.

Martin
-- 
Check out the DevForum 97  !!!! (http://www.sgi.com/Forum97/)
  If you miss it, you'll never forgive yourself. Neither will I :-)
+---------------------------------+-----------------------------------+
|Martin Knoblauch                 | Silicon Graphics GmbH             |
|Manager Technical Marketing      | Am Hochacker 3 - Technopark       |
|Silicon Graphics Computer Systems| D-85630 Grasbrunn-Neukeferloh, FRG|
|---------------------------------| Phone: (+int) 89 46108-179 or -0  |
|http://reality.sgi.com/knobi     | Fax:   (+int) 89 46107-179        |
+---------------------------------+-----------------------------------+
|e-mail: <knobi@munich.sgi.com>   | VM: 6-333-8197 | M/S: IDE-3150    |
+---------------------------------------------------------------------+
