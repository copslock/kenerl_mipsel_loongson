Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA12236; Wed, 18 Jun 1997 01:22:51 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA28351 for linux-list; Wed, 18 Jun 1997 01:22:29 -0700
Received: from morgaine.engr.sgi.com (morgaine.engr.sgi.com [130.62.16.64]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA28341 for <linux@cthulhu.engr.sgi.com>; Wed, 18 Jun 1997 01:22:27 -0700
Received: from sgiger.munich.sgi.com (sgiger.munich.sgi.com [144.253.192.2]) by morgaine.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA16059 for <linux@morgaine.engr.sgi.com>; Wed, 18 Jun 1997 01:21:33 -0700
Received: from knobi.munich.sgi.com by sgiger.munich.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/940406.SGI)
	 id KAA20664; Wed, 18 Jun 1997 10:21:31 +0200
Received: from knobi (localhost [127.0.0.1]) by knobi.munich.sgi.com (950413.SGI.8.6.12/951220.SGI.AUTOCF.knobi) via SMTP id KAA12442; Wed, 18 Jun 1997 10:21:29 +0200
Message-ID: <33A79A89.1CFB@munich.sgi.com>
Date: Wed, 18 Jun 1997 10:21:29 +0200
From: Martin Knoblauch <knobi@munich.sgi.com>
Organization: Silicon Graphics GmbH, Am-Hochacker 3, D-85630 Grasbrunn
X-Mailer: Mozilla 3.01SC-SGI (X11; I; IRIX 6.3 IP22)
MIME-Version: 1.0
To: Larry McVoy <lm@neteng.engr.sgi.com>
CC: John Wiederhirn <jwiede@blammo.engr.sgi.com>, linux@morgaine.engr.sgi.com
Subject: Getting X on Linux/SGI (2)
References: <199706180637.XAA09017@neteng.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

[also changeing the subject]

Larry McVoy wrote:
> 
> : There are some very serious issues which come up even getting
> : Xfree to a moderate level of acceleration.
> 
> How about to a simple level of working?  Without any acceleration?
> For most people, just having xterms and netscape working is enough.
> 
> I'm not a graphics or X person.  Could someone who knows SGI's gfx
> devices tell us how hard it would be to make the basics work?
> 

  Probably not that hard if we gave away the documentation
(do we have *documentation*) on the GFX cards low level interfaces.
The major problem to me seems that each different architecture
(XL, XZ/Elan/Extreme, IMPACT, CRM) has different interfaces.
I am not sure that you can find a minimal subset of calls
to make a very simple Xserver work (is Peter Daifuku on this
list ? Mark Kilgard?).

  Personally I think that we don't loose anything if we give away
the stuff for the older boards (Newport, Express). I am not
sure, what we loose if we do the same for IMPACT/IR (OK, IR
is probably not such a big deal :-)


 Questions:

- How much HW dependent stuff is in Xsgi itself?
- Which of the DSOs in /usr/lib/X11/dyDDX are minimally
  needed to bring up an non-GLX Xserver?
- How much efforts would it cost to compile the dyDDX
  stuff for Linux and distribute the binaries only
  (assuming that there is not to much HW stuff in Xsgi itself)?


 And of course, we probably have to provide the microcode and
loader for the different GFX cards.

 I definitely agree with Ariel, that this is the most important
topic once we have Linux running stable.

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
