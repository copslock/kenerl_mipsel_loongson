Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id PAA15508 for <linux-archive@neteng.engr.sgi.com>; Wed, 14 Jan 1998 15:56:07 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA07701 for linux-list; Wed, 14 Jan 1998 15:55:31 -0800
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA07693; Wed, 14 Jan 1998 15:55:29 -0800
Received: (from ariel@localhost) by oz.engr.sgi.com (971110.SGI.8.8.8/970903.SGI.AUTOCF) id PAA09106; Wed, 14 Jan 1998 15:55:29 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199801142355.PAA09106@oz.engr.sgi.com>
Subject: Re: boot problem
To: bellis@cerf.net (William Ellis)
Date: Wed, 14 Jan 1998 15:55:29 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com
In-Reply-To: <34BD4F3E.7F86@cerf.net> from "William Ellis" at Jan 14, 98 03:50:22 pm
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

:
:I'm working with a Challenge S, R5000 (Allegedly the same
:hardware as an Indy without a graphics card)
:
:Initially booting via tftp with various errors, I am
:now trying to just get the sash boot -f to work.
:I have tried several of the applicable precompiled kernels 
:at ftp.linux.sgi.com/pub/test all with similar errors:
:
:Standalone Shell SGI Version 6.2 ARCS   Mar  9, 1996 (32 Bit)
:sash: boot -f /vmlinux root=/dev/sda1
:1278928+236160 entry: 0x8800250c
:newport_probe: read back wrong value ;-(
:
:What is the newport_probe?  The only non-stock thing about
:the machine is it has a fddi card in it, (which I do not
:need to get going for linux).  Could this error be an effect
:of the fddi card being present, or that there is no graphics
:card present?  Or am I missing something else all together?
:Thanks in Advance, Bill
:
Newport == Indy graphics

So I guess the code should be changed so it doesn't assume
there's a newport hardware.

-- 
Peace, Ariel
