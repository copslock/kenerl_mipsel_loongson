Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA05717; Mon, 16 Jun 1997 00:31:02 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA27803 for linux-list; Mon, 16 Jun 1997 00:30:39 -0700
Received: from sgiger.munich.sgi.com (sgiger.munich.sgi.com [144.253.192.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA27792 for <linux@cthulhu.engr.sgi.com>; Mon, 16 Jun 1997 00:30:36 -0700
Received: from knobi.munich.sgi.com by sgiger.munich.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/940406.SGI)
	 id JAA20094; Mon, 16 Jun 1997 09:30:33 +0200
Received: from knobi (localhost [127.0.0.1]) by knobi.munich.sgi.com (950413.SGI.8.6.12/951220.SGI.AUTOCF.knobi) via SMTP id JAA00979; Mon, 16 Jun 1997 09:30:23 +0200
Message-ID: <33A4EB8F.237C@munich.sgi.com>
Date: Mon, 16 Jun 1997 09:30:23 +0200
From: Martin Knoblauch <knobi@munich.sgi.com>
Organization: Silicon Graphics GmbH, Am-Hochacker 3, D-85630 Grasbrunn
X-Mailer: Mozilla 3.01SC-SGI (X11; I; IRIX 6.3 IP22)
MIME-Version: 1.0
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: gcc for Irix.
References: <199706131455.JAA11578@athena.nuclecu.unam.mx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza wrote:
> 
> Hello guys,
> 
>    I am running into a little problem.  The binary gcc that is
> available on the free software collection is for Irix 5.3 and the
> include files that are packaged with it are not quite ok for Irix 6.2
> 
>    I do not have a native cc, so this is kind of problematic :-)
> 
> Miguel.
Miguel,

 if you took the stuff from Ariels home page, don't worry
about the "5.3" stuff. It is basically the only way to build
an "official" gcc for 6.x. Otherwise, the stuff is binary
compatible. As for the header files, what is the problem?
Errors, or incompleteness?

Martin
-- 
+---------------------------------+-----------------------------------+
|Martin Knoblauch                 | Silicon Graphics GmbH             |
|Manager Technical Marketing      | Am Hochacker 3 - Technopark       |
|Silicon Graphics Computer Systems| D-85630 Grasbrunn-Neukeferloh, FRG|
|---------------------------------| Phone: (+int) 89 46108-179 or -0  |
|http://reality.sgi.com/knobi     | Fax:   (+int) 89 46107-179        |
+---------------------------------+-----------------------------------+
|e-mail: <knobi@munich.sgi.com>   | VM: 6-333-8197 | M/S: IDE-3150    |
+---------------------------------------------------------------------+
