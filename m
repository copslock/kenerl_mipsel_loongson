Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id CAA1172537 for <linux-archive@neteng.engr.sgi.com>; Thu, 2 Oct 1997 02:39:16 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id CAA28393 for linux-list; Thu, 2 Oct 1997 02:38:17 -0700
Received: from sgiger.munich.sgi.com (sgiger.munich.sgi.com [144.253.192.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA28389; Thu, 2 Oct 1997 02:38:13 -0700
Received: from knobi.munich.sgi.com by sgiger.munich.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/940406.SGI)
	 id LAA07348; Thu, 2 Oct 1997 11:38:05 +0200
Received: from munich.sgi.com (localhost [127.0.0.1]) by knobi.munich.sgi.com (950413.SGI.8.6.12/951220.SGI.AUTOCF.knobi) via ESMTP id LAA06377; Thu, 2 Oct 1997 11:38:01 +0200
Message-ID: <34336B79.C800020F@munich.sgi.com>
Date: Thu, 02 Oct 1997 11:38:01 +0200
From: Martin Knoblauch <knobi@munich.sgi.com>
Organization: Silicon Graphics GmbH, Am-Hochacker 3, D-85630 Grasbrunn
X-Mailer: Mozilla 4.03C-SGI [en] (X11; I; IRIX 6.3 IP22)
MIME-Version: 1.0
To: Ralf Baechle <ralf@cobaltmicro.com>
CC: ariel@cthulhu.engr.sgi.com, carlson@heaven.newport.sgi.com,
        linux@cthulhu.engr.sgi.com
Subject: Re: IRIX ELF docs
References: <199710012328.QAA17090@dull.cobaltmicro.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Ralf Baechle wrote:
> 
> 
> Apropos quickstart, I recently had a discussion with someone about
> quickstart & performance.  Does anybody have hard numbers about how
> much the speedup by quickstart is?
> 
>   Ralf
Ralf,

 one of these typical "it depends" questions :-) If your application
has only a short list of DSOs to load and if it runs for hours,
the effect of quickstart is pretty low. If your app loads a
lot of DSOs, which may in turn load other DSOs, the effect on
the startup time maybe pretty big (50%). And if the ratio between
startup-time and real-work-time is in favour of startup, you
better put some effort in quickstarting your DSOs.

 The major problem is, that the more DSOs you have, the more
difficult it is to get all of the quickstarting. So a lot of
people never do the work.

Martin
-- 
+---------------------------------+-----------------------------------+
|Martin Knoblauch                 | Silicon Graphics GmbH             |
|Manager Technical Marketing      | Am Hochacker 3 - Technopark       |
|Silicon Graphics Computer Systems| D-85630 Grasbrunn-Neukeferloh, FRG|
|---------------------------------| Phone: (+int) 89 46108-179 or -0  |
|http://reality.sgi.com/knobi     | Fax:   (+int) 89 46107-179        |
+---------------------------------+-----------------------------------+
|e-mail: <knobi@munich.sgi.com>   | VM: 6-333-8179 | M/S: IDE-3150    |
+---------------------------------------------------------------------+
