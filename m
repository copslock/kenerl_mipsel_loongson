Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id PAA16565 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 15:52:16 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA05463 for linux-list; Wed, 14 Jan 1998 15:48:58 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA05382 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 15:48:47 -0800
Received: from smtp2.cerf.net (smtp2.cerf.net [192.102.249.31]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA21211
	for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 15:48:44 -0800
	env-from (bellis@cerf.net)
Received: from maelstrom (maelstrom.cerf.net [198.137.140.16]) by smtp2.cerf.net (8.8.8/8.6.10) with SMTP id PAA19257 for <linux@cthulhu.engr.sgi.com>; Wed, 14 Jan 1998 15:48:42 -0800 (PST)
Message-ID: <34BD4F3E.7F86@cerf.net>
Date: Wed, 14 Jan 1998 15:50:22 -0800
From: William Ellis <bellis@cerf.net>
Organization: TCG - CERFNet
X-Mailer: Mozilla 3.01 (X11; I; SunOS 5.5.1 sun4m)
MIME-Version: 1.0
To: Linux porting team <linux@cthulhu.engr.sgi.com>
Subject: boot problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I'm working with a Challenge S, R5000 (Allegedly the same
hardware as an Indy without a graphics card)

Initially booting via tftp with various errors, I am
now trying to just get the sash boot -f to work.
I have tried several of the applicable precompiled kernels 
at ftp.linux.sgi.com/pub/test all with similar errors:

Standalone Shell SGI Version 6.2 ARCS   Mar  9, 1996 (32 Bit)
sash: boot -f /vmlinux root=/dev/sda1
1278928+236160 entry: 0x8800250c
newport_probe: read back wrong value ;-(

What is the newport_probe?  The only non-stock thing about
the machine is it has a fddi card in it, (which I do not
need to get going for linux).  Could this error be an effect
of the fddi card being present, or that there is no graphics
card present?  Or am I missing something else all together?
Thanks in Advance, Bill
