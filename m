Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA03009; Tue, 24 Jun 1997 09:48:33 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA06312 for linux-list; Tue, 24 Jun 1997 09:48:23 -0700
Received: from sgiger.munich.sgi.com (sgiger.munich.sgi.com [144.253.192.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA06297 for <linux@cthulhu.engr.sgi.com>; Tue, 24 Jun 1997 09:48:19 -0700
Received: from knobi.munich.sgi.com by sgiger.munich.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/940406.SGI)
	 id SAA07484; Tue, 24 Jun 1997 18:48:14 +0200
Received: from knobi (localhost [127.0.0.1]) by knobi.munich.sgi.com (950413.SGI.8.6.12/951220.SGI.AUTOCF.knobi) via SMTP id SAA06986; Tue, 24 Jun 1997 18:48:12 +0200
Message-ID: <33AFFA4C.4DAA@munich.sgi.com>
Date: Tue, 24 Jun 1997 18:48:12 +0200
From: Martin Knoblauch <knobi@munich.sgi.com>
Organization: Silicon Graphics GmbH, Am-Hochacker 3, D-85630 Grasbrunn
X-Mailer: Mozilla 3.01SC-SGI (X11; I; IRIX 6.3 IP22)
MIME-Version: 1.0
To: Alex deVries <adevries@engsoc.carleton.ca>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Some simple hardware questions...
References: <Pine.LNX.3.95.970624123035.406E-100000@lager.engsoc.carleton.ca>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alex deVries wrote:
> 
> I have some ultra simple hardware questions that I couldn't
> find answers to.  Excuse the noviceness of it all, I haven't
> touched SGI hardware in quite some time.
> 
> 1. Do Indy's come equipped with floppy drives?  What are they?
>    Is it possible to boot from them?
>

 Oh no :-) No, Indys don't come usually with floppys. We
offer a 20MB Floptical option (internal), or a normal floppy
option (external). Both are not really popular with our customers.

 You might be able to boot from them, but this was probably never
tested...
 
> 2. I know O2's have PCI busses with a custom controller.
>    Do Indy's have this too? What is the name of this controller?
>    It would seem reasonably easy to slap a PCI VGA card in there
>    and port XFree86 to run on it.
>

 No, Indy comes with our proprietary GIO bus. The GFX cards (8/24)
plug on that.
 
> 3. Do Indy's ship with CDROMs?
>

 More often than with floppies, but it is an option. Not standard.
 
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
