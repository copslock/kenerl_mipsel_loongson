Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA18633; Tue, 17 Jun 1997 09:48:03 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA26633 for linux-list; Tue, 17 Jun 1997 09:47:21 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA26615 for <linux@cthulhu.engr.sgi.com>; Tue, 17 Jun 1997 09:47:19 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA22648 for <linux@yon.engr.sgi.com>; Tue, 17 Jun 1997 09:46:52 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA26493 for <linux@yon.engr.sgi.com>; Tue, 17 Jun 1997 09:46:51 -0700
Received: from athena.nuclecu.unam.mx (athena.nuclecu.unam.mx [132.248.29.9]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id JAA14797
	for <linux@yon.engr.sgi.com>; Tue, 17 Jun 1997 09:46:33 -0700
	env-from (miguel@athena.nuclecu.unam.mx)
Received: (from miguel@localhost)
	by athena.nuclecu.unam.mx (8.8.5/8.8.5) id LAA14702;
	Tue, 17 Jun 1997 11:18:07 -0500
Date: Tue, 17 Jun 1997 11:18:07 -0500
Message-Id: <199706171618.LAA14702@athena.nuclecu.unam.mx>
From: Miguel de Icaza <miguel@nuclecu.unam.mx>
To: knobi@munich.sgi.com
CC: ariel@sgi.com, linux@yon.engr.sgi.com
In-reply-to: <33A647A1.2781@munich.sgi.com> (message from Martin Knoblauch on
	Tue, 17 Jun 1997 10:15:29 +0200)
Subject: Re: Good news: no more begging for HW
X-Unix: is friendly, it is just selective about who its friends are.
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Talking about userland nice applications, two extra ideas:

>  so let me chime in. There are the people with the KDE desktop
> (http://www.kde.org/) environment. They gave a presentation at
> the Linux Konference in Wuerzburg. If we want to do some non-kernel
> stuff, they might be a good choice. Maybe even for IRIX :-)

GNUstep:

There are a couple of extra free software projects that may benefit.
One of them is the GNUstep project (do not pay attention to the web
pages for the project the maintainer updates them once every six
months).  

They have similar goals to the KDE project, but they are going for an
OpenStep compliant API.  

scottc@net-community.com is the person who is doing the GUI code for
Unix. 

The GIMP:

There are a couple of students at UC Berkeley that wrote the GIMP (the
GNU Image Manipulation Program), which is a PhotoShop on steroids.

They cloned most of the functionality of Photoshop: plugins, ability
to handle large images, layers, channels.  And on top of that they
embedded a scheme interpreter, so you can create complex graphic art
by just fillling a form.  The Scheme scripts take care of the rest.

You can check their web page at: http://scam.xcf.berkeley.edu/~gimp

Miguel.
