Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA20209; Mon, 16 Jun 1997 17:54:27 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA29968 for linux-list; Mon, 16 Jun 1997 17:53:51 -0700
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA29951 for <linux@cthulhu.engr.sgi.com>; Mon, 16 Jun 1997 17:53:49 -0700
Received: (from ariel@localhost) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA19808; Mon, 16 Jun 1997 17:53:48 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199706170053.RAA19808@yon.engr.sgi.com>
Subject: Re: ARC question
To: ralf@mailhost.uni-koblenz.de (Ralf Baechle)
Date: Mon, 16 Jun 1997 17:53:47 -0700 (PDT)
Cc: linux@yon.engr.sgi.com
In-Reply-To: <199706170012.CAA12560@informatik.uni-koblenz.de> from "Ralf Baechle" at Jun 17, 97 02:12:29 am
Reply-To: ariel@sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:Hi,
:
:I've got a question about the ARCS firmware as implemented on SGI.  Is
:there some documentation available for it?  I've got a documentation of
:the ARC standard v1.0 from the ACE consortium (the document is marked
:"Microsoft Confidential") as well as the "Portable Bootloader Specification"
:which again ist M$ confidential.  These documents however don't seem to
:fit SGI's machines to well as they're refering to EISA slots, little
:endian byteorder and NT as OS and generally looked a bit outdated even
:when I got them two years ago.
:
:So I suppose there is documention that is more authoritative for the SGI
:firmware?
:
:  Ralf
:

The documentation that comes with the Indy includes all
the PROM commands.  I gave my hard-copy "system administration"
book to Mike when he was visiting here, but it should also be on
every IRIX CD in "Insight" (SGI old help) format.  Clicking on "Help"
in the desktop toolchest should lead you to the docs.

But, it gets even better (I hope).
All our docs are online on the web outside the firewall.

	http://www.sgi.com/techpubs/dynaweb_docs/0630/SGIindex/bks.html

Or more specifically (on the ARC PROM):

	http://www.sgi.com/cgi-bin/infosrch.cgi?cmd=getdoc&db=bks&fname=/SGI_Admin/IA_ConfigOps/10117

And also, please check "man prom"

Let me know if you need more than what's in there.

-- 
Peace, Ariel
