Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id GAA689899 for <linux-archive@neteng.engr.sgi.com>; Fri, 30 Jan 1998 06:11:09 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA06201 for linux-list; Fri, 30 Jan 1998 06:08:46 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA06191 for <linux@cthulhu.engr.sgi.com>; Fri, 30 Jan 1998 06:08:36 -0800
Received: from Kitten.mcs.com (Kitten.mcs.com [192.160.127.90]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id GAA14669
	for <linux@cthulhu.engr.sgi.com>; Fri, 30 Jan 1998 06:08:35 -0800
	env-from (adyer@Mercury.mcs.net)
Received: from Mercury.mcs.net (adyer@Mercury.mcs.net [192.160.127.80]) by Kitten.mcs.com (8.8.7/8.8.2) with ESMTP id IAA16879; Fri, 30 Jan 1998 08:08:34 -0600 (CST)
Received: from localhost (adyer@localhost) by Mercury.mcs.net (8.8.7/8.8.2) with SMTP id IAA29749; Fri, 30 Jan 1998 08:08:32 -0600 (CST)
Date: Fri, 30 Jan 1998 08:08:31 -0600 (CST)
From: Andrew Dyer <adyer@Mcs.Net>
To: linux-mips@fnet.fr
cc: linux@cthulhu.engr.sgi.com
Subject: Re: strange problem with my oli M700
In-Reply-To: <19980129212705.29618@alpha.franken.de>
Message-ID: <Pine.BSF.3.95.980130080557.29181A-100000@Mercury.mcs.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, 29 Jan 1998, Thomas Bogendoerfer wrote:

> Hi,
> 
> I'm trying to read the firmware prom of my Olivetti M700 (Magnum 4000 clone).
> When access the address 0x9fc00000 (which is the KSEG0 address of the prom)
> the box freezes immidiately. Does anybody know why ? And how could I access
> the prom otherwise ?
> 

Accesses through kseg0 generate burst reads on the CPU bus.  If the memory
controller doesn't support it for that region of memory, the system could
hang.  Since the system reset vector is in kseg1 (ie 0xbfc00000), accesses
through that region have to work, or the machine wouldn't boot. 

| Andrew Dyer                       <adyer@midway.com> or <adyer@mcs.net>     |
| Sr. Design Engineer               (773) 961-1751                            |
| Midway Games, Inc.                (773) 961-1890 (fax)                      |
| 2727 W. Roscoe Ave., Chicago, IL 60618                                      |
