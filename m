Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA14750 for <linux-archive@neteng.engr.sgi.com>; Tue, 23 Sep 1997 15:41:07 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA26361 for linux-list; Tue, 23 Sep 1997 15:40:48 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA26342; Tue, 23 Sep 1997 15:40:43 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA09768; Tue, 23 Sep 1997 15:40:35 -0700
Date: Tue, 23 Sep 1997 15:40:35 -0700
Message-Id: <199709232240.PAA09768@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Mark Salter <marks@sun470.sun470.rd.qms.com>
Cc: miguel@nuclecu.unam.mx, ariel@cthulhu.engr.sgi.com,
        linux@cthulhu.engr.sgi.com
Subject: Re: Task list --preliminary list
In-Reply-To: <199709231837.NAA20145@speedy.rd.qms.com>
References: <199709230335.WAA17103@athena.nuclecu.unam.mx>
	<199709231837.NAA20145@speedy.rd.qms.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Mark Salter writes:
 > 
 > >> [5] Verify that the latest source tree on Llinus compiles and boots
 > >> (maybe automate this with a daily build that gets tested)
 > 
 > > I checked this yesterday when I commited my code to linus.
 > 
 > Yes, but I bet you didn't check it on an Indy with no scache :-)
 > I have one of those beasts and the latest code in the cvs tree
 > crashes early in the boot process.
 > 
 > The code in arch/mips/mm/r4xx0.c which sets up the cache flush
 > procs now selects r4k_flush_page_to_ram_d32i32_r4600 where
 > earlier versions of r4xx0.c selected r4k_flush_page_to_ram_d32i32.
 > I think the current choice is correct in that my Indy has the
 > R4600 cache bug mentioned in IDT's errata. But the *_r4600 version
 > also has some inline assembler under an ifdef CONFIG_SGI which
 > appears to do something to the SGI scache. But since I have
 > no scache, I get a bus error irq instead.
 > 
 > It seems a bit strange that r4k_flush_page_to_ram_d32i32_r4600
 > has this bit of SGI specific code, but r4k_flush_page_to_ram_d32i32
 > does not. ???

     I have not looked at the source, but the problem is probably that
there needs to be two cases, one with and one without Indy R4600 scache.
This is determined by reading out the EEPROM on the CPU board, and looking
at the appropriate bits for "scache present" and "scache size".  The 
processor will get a bus error trying to reference the control registers
of the scache controller (via uncached memory references) if the secondary
cache is not present.
