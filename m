Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA08355; Mon, 16 Jun 1997 01:03:32 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id BAA05629 for linux-list; Mon, 16 Jun 1997 01:03:07 -0700
Received: from sgiger.munich.sgi.com (sgiger.munich.sgi.com [144.253.192.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id BAA05610 for <linux@cthulhu.engr.sgi.com>; Mon, 16 Jun 1997 01:03:02 -0700
Received: from knobi.munich.sgi.com by sgiger.munich.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/940406.SGI)
	 id KAA20818; Mon, 16 Jun 1997 10:02:59 +0200
Received: from knobi (localhost [127.0.0.1]) by knobi.munich.sgi.com (950413.SGI.8.6.12/951220.SGI.AUTOCF.knobi) via SMTP id KAA02461; Mon, 16 Jun 1997 10:02:46 +0200
Message-ID: <33A4F325.7DE1@munich.sgi.com>
Date: Mon, 16 Jun 1997 10:02:45 +0200
From: Martin Knoblauch <knobi@munich.sgi.com>
Organization: Silicon Graphics GmbH, Am-Hochacker 3, D-85630 Grasbrunn
X-Mailer: Mozilla 3.01SC-SGI (X11; I; IRIX 6.3 IP22)
MIME-Version: 1.0
To: "David S. Miller" <davem@jenolan.rutgers.edu>
CC: ariel@sgi.com, carlson@heaven.newport.sgi.com, linux@cthulhu.engr.sgi.com
Subject: Re: gcc for Irix.
References: <199706141735.NAA04790@jenolan.caipgeneral>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

David S. Miller wrote:
> 
>    From: ariel@yon.engr.sgi.com (Ariel Faigon)
>    Date: Sat, 14 Jun 1997 10:21:07 -0700 (PDT)
> 
>    And finally there's "fix_headers" - the utility that comes with gcc
>    and fixes headers so they can be used with some gcc conventions and
>    extensions to C.  Combine this with our multi-standard headers
>    which I suspect the designers of "fix_headers" never thought of and
>    you get a pretty cool mess :-)
> 
> Which is why in gcc-2.8.0 a completely new fix_headers.irix will
> exist which handles it all properly...

 This is why we all eagerly wait to see an official release of 2.8 :-)

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
