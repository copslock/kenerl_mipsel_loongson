Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA15462; Wed, 4 Jun 1997 07:11:04 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id HAA09254 for linux-list; Wed, 4 Jun 1997 07:09:30 -0700
Received: from sgitpa.tampa.sgi.com (sgitpa.tampa.sgi.com [169.238.151.130]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id HAA09241 for <linux@cthulhu.engr.sgi.com>; Wed, 4 Jun 1997 07:09:27 -0700
Received: from akira.tampa.sgi.com by sgitpa.tampa.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/930416.SGI)
	 id KAA04429; Wed, 4 Jun 1997 10:05:02 -0400
Received: by akira.tampa.sgi.com (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id KAA02606; Wed, 4 Jun 1997 10:04:56 -0400
From: "Liam Irish" <irish@akira.tampa.sgi.com>
Message-Id: <9706041004.ZM2604@akira.tampa.sgi.com>
Date: Wed, 4 Jun 1997 10:04:56 -0400
In-Reply-To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
        "Re: The Plan For Userland(tm)" (Jun  3,  8:23pm)
References: <199706031823.UAA01401@informatik.uni-koblenz.de>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Subject: Re: The Plan For Userland(tm)
Cc: linux@cthulhu.engr.sgi.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Jun 3,  8:23pm, Ralf Baechle wrote:
> Subject: Re: The Plan For Userland(tm)
>
> Yeah, and if there won't be xfs for linux I'd really like to see ext2
> support for IRIX ...

>   Ralf
>-- End of excerpt from Ralf Baechle


I'd like to do that.  I've already been talking to some engineers about it.  I
was trying to determine if it already been done.  Guess not.  I think it'd be
easier to put ext2 on irix than xfs on linux, esp considering the other options
involved with xfs.  Would it be 32-bit xfs?

Anyway.  They both interface a VFS, so it should be _too_ bad.  Unfortunately,
I haven't seen to much documentation for VFS on irix.  Well, see if the Mtn
View engineers will help out in that regard.

-- 
Liam Irish
System Engineer					Tampa, FL
Silicon Graphics, Inc.				(813)281-4620
						irish@tampa.sgi.com
