Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id LAA38381 for <linux-archive@neteng.engr.sgi.com>; Tue, 23 Sep 1997 11:39:32 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id LAA29947 for linux-list; Tue, 23 Sep 1997 11:39:01 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA29701; Tue, 23 Sep 1997 11:37:54 -0700
Received: from gatekeeper.qms.com (gatekeeper.qms.com [161.33.3.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id LAA07105; Tue, 23 Sep 1997 11:37:52 -0700
	env-from (marks@sun470.sun470.rd.qms.com)
Received: from sun470.rd.qms.com (sun470.qms.com) by gatekeeper.qms.com (4.1/SMI-4.1)
	id AA04457; Tue, 23 Sep 97 13:37:31 CDT
Received: from speedy.rd.qms.com by sun470.rd.qms.com (4.1/SMI-4.1)
	id AA26797; Tue, 23 Sep 97 13:37:28 CDT
Received: by speedy.rd.qms.com (8.8.2) id NAA20145; Tue, 23 Sep 1997 13:37:28 -0500
Date: Tue, 23 Sep 1997 13:37:28 -0500
Message-Id: <199709231837.NAA20145@speedy.rd.qms.com>
From: Mark Salter <marks@sun470.sun470.rd.qms.com>
To: miguel@nuclecu.unam.mx
Cc: ariel@cthulhu.engr.sgi.com, linux@cthulhu.engr.sgi.com
In-Reply-To: <199709230335.WAA17103@athena.nuclecu.unam.mx> (message from
	Miguel de Icaza on Mon, 22 Sep 1997 22:35:49 -0500)
Subject: Re: Task list --preliminary list
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


>> [5] Verify that the latest source tree on Llinus compiles and boots
>> (maybe automate this with a daily build that gets tested)

> I checked this yesterday when I commited my code to linus.

Yes, but I bet you didn't check it on an Indy with no scache :-)
I have one of those beasts and the latest code in the cvs tree
crashes early in the boot process.

The code in arch/mips/mm/r4xx0.c which sets up the cache flush
procs now selects r4k_flush_page_to_ram_d32i32_r4600 where
earlier versions of r4xx0.c selected r4k_flush_page_to_ram_d32i32.
I think the current choice is correct in that my Indy has the
R4600 cache bug mentioned in IDT's errata. But the *_r4600 version
also has some inline assembler under an ifdef CONFIG_SGI which
appears to do something to the SGI scache. But since I have
no scache, I get a bus error irq instead.

It seems a bit strange that r4k_flush_page_to_ram_d32i32_r4600
has this bit of SGI specific code, but r4k_flush_page_to_ram_d32i32
does not. ???

--Mark
