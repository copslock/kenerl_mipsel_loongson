Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id QAA97558 for <linux-archive@neteng.engr.sgi.com>; Tue, 7 Oct 1997 16:17:25 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id QAA11423 for linux-list; Tue, 7 Oct 1997 16:16:38 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id QAA11407; Tue, 7 Oct 1997 16:16:33 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id QAA22742; Tue, 7 Oct 1997 16:16:32 -0700
Date: Tue, 7 Oct 1997 16:16:32 -0700
Message-Id: <199710072316.QAA22742@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: LetherGlov@aol.com
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Indy Specs
In-Reply-To: <971006201727_-762768341@emout20.mail.aol.com>
References: <971006201727_-762768341@emout20.mail.aol.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

LetherGlov@aol.com writes:
...
 > But for the autopower, all I really want to know is the chip on the
 > motherboard that controls the automatic power on/off. I have no troubles with
 > hunting down the specs for it and figuring it out.
...

      The autopower feature is controlled by the Dallas DS1286 clock/calendar/
battery-backed-RAM part.  This is addressed via the HPC3, and the
physical base address of the register block for the part is 0x1fbe0000.
If the time-of-day alarm on the INTA pin is configured (bit mask 0x40 set
in the command register) and the time of day interrupt is off (bit mask 0x04
turned off in the command register), and the machine is powered off,
it will power on when the alarm goes off.  You must, of course, configure
the time-of-day alarm comparison registers for the time and date when
you want the machine to power on.

      To power off the machine, disable any AC power failure interrupt
handling (just ignore the interrupt), turn off the time-of-day interrupt
in the DS1286, turn off the watchdog interrupt in the DS1286 (bit mask
0x08 in the command register), and turn off the power supply inhibit 
bit (bit mask 0x01) in the HPC3 power management register (physical
address 0x1fbd9850).  

  
