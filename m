Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA03325; Tue, 24 Jun 1997 09:54:37 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA08336 for linux-list; Tue, 24 Jun 1997 09:54:20 -0700
Received: from sgiger.munich.sgi.com (sgiger.munich.sgi.com [144.253.192.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA08289 for <linux@cthulhu.engr.sgi.com>; Tue, 24 Jun 1997 09:54:13 -0700
Received: from knobi.munich.sgi.com by sgiger.munich.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/940406.SGI)
	 id SAA07715; Tue, 24 Jun 1997 18:54:06 +0200
Received: from knobi (localhost [127.0.0.1]) by knobi.munich.sgi.com (950413.SGI.8.6.12/951220.SGI.AUTOCF.knobi) via SMTP id SAA07013; Tue, 24 Jun 1997 18:54:05 +0200
Message-ID: <33AFFBAD.773C@munich.sgi.com>
Date: Tue, 24 Jun 1997 18:54:05 +0200
From: Martin Knoblauch <knobi@munich.sgi.com>
Organization: Silicon Graphics GmbH, Am-Hochacker 3, D-85630 Grasbrunn
X-Mailer: Mozilla 3.01SC-SGI (X11; I; IRIX 6.3 IP22)
MIME-Version: 1.0
To: "David S. Miller" <davem@jenolan.rutgers.edu>
CC: adevries@engsoc.carleton.ca, linux@cthulhu.engr.sgi.com
Subject: Re: Some simple hardware questions...
References: <199706241644.MAA25791@jenolan.caipgeneral>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

David S. Miller wrote:
> 
>    Date: Tue, 24 Jun 1997 12:38:39 -0400 (EDT)
>    From: Alex deVries <adevries@engsoc.carleton.ca>
> 
>    1. Do Indy's come equipped with floppy drives?  What are they?
>       Is it possible to boot from them?
> 
> Yes, they are SCSI floppy drives.
>

 As I said: optional. No boot guarantee.
 
>    2. I know O2's have PCI busses with a custom controller.
>       Do Indy's have  this too? What is the name of this
>       controller? It would seem reasonably easy to slap a
>       PCI VGA card in there and port XFree86 to run on it.
> 
> No, but I believe some models were produced with EISA slots
> on the motherboard.
> 

  That is the Indigo2/Challenge-M series. Our first attempt
on open expansion busses.

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
