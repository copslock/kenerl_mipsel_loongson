Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id AAA369847; Mon, 21 Jul 1997 00:10:52 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id AAA20803 for linux-list; Mon, 21 Jul 1997 00:10:23 -0700
Received: from sgiger.munich.sgi.com (sgiger.munich.sgi.com [144.253.192.2]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id AAA20786 for <linux@cthulhu.engr.sgi.com>; Mon, 21 Jul 1997 00:10:19 -0700
Received: from knobi.munich.sgi.com by sgiger.munich.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/940406.SGI)
	 id JAA24557; Mon, 21 Jul 1997 09:10:14 +0200
Received: from knobi (localhost [127.0.0.1]) by knobi.munich.sgi.com (950413.SGI.8.6.12/951220.SGI.AUTOCF.knobi) via SMTP id JAA04940; Mon, 21 Jul 1997 09:10:13 +0200
Message-ID: <33D30B54.2781@munich.sgi.com>
Date: Mon, 21 Jul 1997 09:10:12 +0200
From: Martin Knoblauch <knobi@munich.sgi.com>
Organization: Silicon Graphics GmbH, Am-Hochacker 3, D-85630 Grasbrunn
X-Mailer: Mozilla 3.01SC-SGI (X11; I; IRIX 6.3 IP22)
MIME-Version: 1.0
To: richard offer <offer@sgi.com>
CC: linux@cthulhu.engr.sgi.com
Subject: Re: Pointers on how to get started
References: <199707181846.OAA20686@neon.ingenia.ca> <9707181200.ZM13791@sgi.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

richard offer wrote:
> 
> * $ from shaver@neon.ingenia.ca at "18-Jul: 2:46pm" | sed "1,$s/^/* /"
> *
> * > 3. Exactly what hardware will this run on?  All I've heard thus far is
> * > work on SGI Indy's.
> *
> * I think that's it.  Whatever Ariel ships you should work, though.
> 
> Does this mean it won't work on an R4k Indigo ?
> 
> Bugger, there goes my idea of sticking a second disk into changeling....
> 
> [ changeling 240 ] hinv
> CPU: MIPS R4000 Processor Chip Revision: 3.0
> FPU: MIPS R4000 Floating Point Coprocessor Revision: 0.0
> 1 100 MHZ IP20 Processor
> Main memory size: 32 Mbytes
> Secondary unified instruction/data cache size: 1 Mbyte on Processor 0
> Instruction cache size: 8 Kbytes
> Data cache size: 8 Kbytes
> Integral SCSI controller 0: Version WD33C93B, revision C
>   Disk drive: unit 1 on SCSI controller 0
> On-board serial ports: 2
> On-board bi-directional parallel port
> Graphics board: GR2-XZ
> Integral Ethernet: ec0, version 1
> 

  Hmm. Can you downgrade to "Starter" GFX? That might be
suffiently compatibel to Newport.

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
