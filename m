Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA21733; Tue, 17 Jun 1997 11:32:23 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA23732 for linux-list; Tue, 17 Jun 1997 11:31:59 -0700
Received: from morgaine.engr.sgi.com (morgaine.engr.sgi.com [130.62.16.64]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA23618 for <linux@cthulhu.engr.sgi.com>; Tue, 17 Jun 1997 11:31:26 -0700
Received: from sgiger.munich.sgi.com (sgiger.munich.sgi.com [144.253.192.2]) by morgaine.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA15361 for <linux@morgaine.engr.sgi.com>; Tue, 17 Jun 1997 11:30:43 -0700
Received: from knobi.munich.sgi.com by sgiger.munich.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/940406.SGI)
	 id UAA24535; Tue, 17 Jun 1997 20:30:39 +0200
Received: from knobi (localhost [127.0.0.1]) by knobi.munich.sgi.com (950413.SGI.8.6.12/951220.SGI.AUTOCF.knobi) via SMTP id UAA05954; Tue, 17 Jun 1997 20:30:36 +0200
Message-ID: <33A6D7CB.4DAA@munich.sgi.com>
Date: Tue, 17 Jun 1997 20:30:36 +0200
From: Martin Knoblauch <knobi@munich.sgi.com>
Organization: Silicon Graphics GmbH, Am-Hochacker 3, D-85630 Grasbrunn
X-Mailer: Mozilla 3.01SC-SGI (X11; I; IRIX 6.3 IP22)
MIME-Version: 1.0
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
CC: offer@sgi.com, linux@morgaine.engr.sgi.com
Subject: Re: Good news: no more begging for HW
References: <199706171800.NAA15810@athena.nuclecu.unam.mx>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza wrote:
> 
> 
> What does "multiple GE" stand for?
> 

 GE == Geometry engine. The part of the OpenGL pipeline that
does the 3D transformations, lighting and other FPU intensive
stuff.

 Some of our GFX "card" do this stuff on the CPU (your Indy,
O2, some Indigo2), but most adaptors have separate GEs. In
all cases (except O2), you have no direct mapping from virtual
memory into the frame buffer.

> 
> So OpenGL applications can run without an X server, or they have code
> to bypass the X server if they need to?
>

 The apps use the Xserver to create the windows and do the
window and event managment. On fast, HW accellerated adapters,
they bypass the server when drawing. But they also can draw through
the server (as in the remote display case).

> 
> Sorry, but what does DSO stand for?
> 

 Dynamic Shared Object. Basically our term for Dynamic Shared
Library.

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
