Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA92404 for <linux-archive@neteng.engr.sgi.com>; Tue, 7 Oct 1997 15:56:40 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA01030 for linux-list; Tue, 7 Oct 1997 15:55:31 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA00616 for <linux@cthulhu.engr.sgi.com>; Tue, 7 Oct 1997 15:54:04 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA16614
	for <linux@cthulhu.engr.sgi.com>; Tue, 7 Oct 1997 15:53:15 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id RAA01259;
	Tue, 7 Oct 1997 17:41:38 -0500
Date: Tue, 7 Oct 1997 17:41:38 -0500
Message-Id: <199710072241.RAA01259@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
Subject: More Linux/SGI status
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

   Ralf's fixes to the dynamic linker fixed the Xt applications.  Now,
only the PAM remains to be fixed.

   So, where do we stand now?  So, the only bits missing now are:

	1. me finishing the support for the X server.  just a hack
	   here and there.

	1.b. Getting the other important bits of the RRM code in the
	   kernel. 

	2. me fixing the mouse.

	3. Would it be possible to negotiate with SGI management 
	   the posibility of shipping the IRIX runtime libraries and
	   the X server as found on IRIX with a Linux disrtibution?

	4. A nice, easy-to use install program.  Taking the existing
	   Red Hat/Mustand install program and port it should be
	   pretty easy. 

Cheers,
Miguel.
