Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA02522; Mon, 14 Apr 1997 23:26:42 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id XAA01749 for linux-list; Mon, 14 Apr 1997 23:25:51 -0700
Received: from sgiger.munich.sgi.com (sgiger.munich.sgi.com [144.253.192.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id XAA01728 for <linux@cthulhu.engr.sgi.com>; Mon, 14 Apr 1997 23:25:42 -0700
Received: from knobi.munich.sgi.com by sgiger.munich.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/940406.SGI)
	 id IAA07304; Tue, 15 Apr 1997 08:25:35 +0200
Received: from knobi (localhost [127.0.0.1]) by knobi.munich.sgi.com (950413.SGI.8.6.12/951220.SGI.AUTOCF.knobi) via SMTP id IAA01433; Tue, 15 Apr 1997 08:25:32 +0200
Message-ID: <33531F5C.167E@munich.sgi.com>
Date: Tue, 15 Apr 1997 08:25:32 +0200
From: Martin Knoblauch <knobi@munich.sgi.com>
Organization: Silicon Graphics GmbH, Am-Hochacker 3, D-85630 Grasbrunn
X-Mailer: Mozilla 3.01SGoldC-SGI (X11; I; IRIX 6.3 IP22)
MIME-Version: 1.0
To: Larry McVoy <lm@neteng.engr.sgi.com>
CC: Steve Alexander <sca@refugee.engr.sgi.com>,
        "Christopher W. Carlson" <carlson@heaven.newport.sgi.com>,
        linux@cthulhu.engr.sgi.com
Subject: Re: EFS and XFS file systems support
References: <199704142047.NAA22932@neteng.engr.sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Larry McVoy wrote:
> 
> : I thought that there was a program available for Linux that
> : would read EFS file systems, although I can't for the life
> : of me remember the name.
> 
> Nope.
>

 Isn't there something calles "efslook"? I found it mentioned
somewhere in the SGI FAQs. Probably does not really "mount"
the EFS volumes, but you should be able to read them.

 
> : >My biggest reason for wanting them supported is to access
> : SGI CD ROMs.
> :
> : I think the better question is when will we start distributing
> : CDs in a standard format...  Yeah, yeah, backward compatibility,
> : I know ;->
> 
> I agree with Steve.  Switch to iso9660.

  Definitely. Do away with EFS as soon as manageable.

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
