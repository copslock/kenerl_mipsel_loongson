Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id JAA457873 for <linux-archive@neteng.engr.sgi.com>; Tue, 6 Jan 1998 09:52:18 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA03060 for linux-list; Tue, 6 Jan 1998 09:50:29 -0800
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id JAA03018; Tue, 6 Jan 1998 09:50:18 -0800
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id JAA18993; Tue, 6 Jan 1998 09:50:17 -0800
Date: Tue, 6 Jan 1998 09:50:17 -0800
Message-Id: <199801061750.JAA18993@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: Miguel de Icaza <miguel@nuclecu.unam.mx>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Indy power supply problems.
In-Reply-To: <199801061453.IAA19542@athena.nuclecu.unam.mx>
References: <199801061453.IAA19542@athena.nuclecu.unam.mx>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Miguel de Icaza writes:
 > 
 > My Indy is not behaving.
 > 
 > The power supply seems to be damaged: if I turn it on shortly after
 > this the machine will turn itself off.  I need to unplug the machine
 > for a couple of minutes before trying again to turn it again.
 > 
 > It can not even boot completely, it shuts down before. 
 > 
 > Is it possible to change the power supply with the power supply from a
 > PC?  The power supply box does not seem to be openable (or I have not
 > found the screws for it).

      The power supply is unique to the Indy, includes the control switches
(power, reset, volume control) and the speaker.  Normally the field repair
is to replace the power supply.  It is possible, however, that some other
failure is responsible.  In particular, the Dallas clock/calendar chip
includes the autopower control logic, so it would be possible for a failure
there to tell the power supply to turn off.  Perhaps Ariel would know the
repair arrangements for your system.
