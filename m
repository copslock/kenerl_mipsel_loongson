Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id QAA19809 for <linux-archive@neteng.engr.sgi.com>; Tue, 23 Sep 1997 16:35:48 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA08468 for linux-list; Tue, 23 Sep 1997 16:35:17 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA08463; Tue, 23 Sep 1997 16:35:15 -0700
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id QAA10410; Tue, 23 Sep 1997 16:35:12 -0700
	env-from (ralf@informatik.uni-koblenz.de)
Received: from erbse (ralf@erbse.uni-koblenz.de [141.26.5.44]) by informatik.uni-koblenz.de (8.8.7/8.6.9) with SMTP id BAA03833; Wed, 24 Sep 1997 01:34:53 +0200 (MEST)
From: Ralf Baechle <ralf@mailhost.uni-koblenz.de>
Message-Id: <199709232334.BAA03833@informatik.uni-koblenz.de>
Received: by erbse (SMI-8.6/KO-2.0)
	id BAA04268; Wed, 24 Sep 1997 01:34:50 +0200
Subject: Re: Task list --preliminary list
To: marks@sun470.sun470.rd.qms.com (Mark Salter)
Date: Wed, 24 Sep 1997 01:34:50 +0200 (MET DST)
Cc: miguel@nuclecu.unam.mx, ariel@cthulhu.engr.sgi.com,
        linux@cthulhu.engr.sgi.com, linux-mips@fnet.fr
In-Reply-To: <199709231837.NAA20145@speedy.rd.qms.com> from "Mark Salter" at Sep 23, 97 01:37:28 pm
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

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

The R4400 versions of the Indy have the "real" second level cache and
use a SC CPU version.  Opposed to that the  L2 cache of the R4600 and
R5000 Indies is controlled by external circuitry which needs special code.

Actually since we have the same problem on a couple of other machines,
SNI RM family one of them,  what should be done is to break out all the
#ifugly'ed SGI bits and provide some hooks for them.  You L2 less
machine would simply plug an empty function into these hooks.

Using r4k_flush_page_to_ram_d32i32 was definately wrong, the R4600
cache is two way set associative and flush_page_to_ram needs to take
care of that for all the R4600 and R5000 relatives.

  Ralf
