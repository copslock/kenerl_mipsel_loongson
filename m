Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id KAA874063 for <linux-archive@neteng.engr.sgi.com>; Wed, 1 Oct 1997 10:21:22 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA24384 for linux-list; Wed, 1 Oct 1997 10:20:58 -0700
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA24353 for <linux@cthulhu.engr.sgi.com>; Wed, 1 Oct 1997 10:20:57 -0700
Received: (from ariel@localhost) by oz.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) id KAA13138; Wed, 1 Oct 1997 10:20:39 -0700 (PDT)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199710011720.KAA13138@oz.engr.sgi.com>
Subject: Re: IRIX ELF docs
To: carlson@heaven.newport.sgi.com (Christopher W. Carlson)
Date: Wed, 1 Oct 1997 10:20:38 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <9710010856.ZM13076@heaven.newport.sgi.com> from "Christopher W. Carlson" at Oct 1, 97 08:56:30 am
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Chris wrote:
:
:I recently went to the local technical bookstore and found that AT&T
:no longer publishes the ABI books (the blue covered books describing
:the ELF format).  The bookstore was, thus, unable to even order them
:for me.
:
:Does anybody know where to buy these books?
:

Not specifically on the ABI, but a search for "MIPS" on www.amazon.com
gives only 4 hits, two of which are out-of-print/hard-to-find and
probably irrelevant, and two that on the architecture only:

	Mips R4000 User's Manual
	Joseph Heinrich / Paperback / Published 1993 
	Our Price: $44.00 

	Mips Risc Architecture ~ Ships in 2-3 days
	Gerry Kane, Joe Heinrich / Paperback / Published 1991 
	Our Price: $46.00 
	Read more about this title... 

	Mips-X Risc Microprocessor (Kluwer International Series in
	Engineering and Computer Science) 
	Paul Chow / Hardcover / Published 1989 
	(Publisher Out Of Stock)

	Mips Risc Architecture 
	Published 1991 
	(Hard to Find)

The canonical place to look for MIPS ABI stuff is:
	www.mipsabi.org

The SGI specific quickstart stuff and whatever is not published
on www.mipsabi.org is probably not publicly documented and
I suspect not even documented much beyond the (rld etc.) source itself.
I'll be glad to be proven wrong on this.
-- 
Peace, Ariel
