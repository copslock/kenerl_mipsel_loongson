Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id UAA348319 for <linux-archive@neteng.engr.sgi.com>; Wed, 10 Sep 1997 20:12:29 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA23475 for linux-list; Wed, 10 Sep 1997 20:11:49 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA23465 for <linux@cthulhu.engr.sgi.com>; Wed, 10 Sep 1997 20:11:46 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) via ESMTP id UAA26928 for <linux@fir.engr.sgi.com>; Wed, 10 Sep 1997 20:11:44 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id UAA23448 for <linux@fir.engr.sgi.com>; Wed, 10 Sep 1997 20:11:39 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id UAA27989
	for <linux@fir.engr.sgi.com>; Wed, 10 Sep 1997 20:11:37 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id WAA25810;
	Wed, 10 Sep 1997 22:03:09 -0500
Date: Wed, 10 Sep 1997 22:03:09 -0500
Message-Id: <199709110303.WAA25810@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: linux@fir.engr.sgi.com
Subject: Linux/SGI: Xsgi Shmiq/Qcntl
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Hello guys,

    Ok, 120 system calls after the last one, I need some more help.
If somebody can quickly look up the IRIX X sources, I would appreciate
if you could tell me how a little routine works.

    The source code should be in a directory called:
xc/programs/Xserver/hw/sgi 

    The code does an open on /dev/shmiq and then opens: sprintf (buf,
"/dev/qcntl%d", mistery_variable) I want to know how it computes
mistery_variable.  I am obviously screwing something in the shmiq
emulation code. 

Cheers,
Miguel.
