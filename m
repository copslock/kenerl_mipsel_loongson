Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA16449; Wed, 13 Aug 1997 13:23:25 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA16708 for linux-list; Wed, 13 Aug 1997 13:23:02 -0700
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA16700 for <linux@cthulhu.engr.sgi.com>; Wed, 13 Aug 1997 13:23:00 -0700
Received: (from ariel@localhost) by oz.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA27369 for linux@engr.sgi.com; Wed, 13 Aug 1997 13:22:59 -0700
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199708132022.NAA27369@oz.engr.sgi.com>
Subject: linus accessible from within SGI
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Wed, 13 Aug 1997 13:22:59 -0700 (PDT)
Reply-To: ariel@sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Good news:

Looks like the routing problem that prevented many outside .engr
to access linus is now fixed.

guest@sgigate 3% traceroute linus.linux.sgi.com
traceroute to linus.linux.sgi.com (192.48.153.197), 30 hops max, 40 byte packets
 1  purgatory.SGI.COM (204.94.209.2)  2 ms  5 ms  3 ms
 2  forbidden (204.94.211.38)  4 ms  14 ms  7 ms
 3  paloalto-cr6.bbnplanet.net (131.119.26.57)  90 ms  105 ms  63 ms
 4  paloalto-cr4.bbnplanet.net (131.119.0.148)  684 ms  113 ms  75 ms
 5  paloalto-cr34.bbnplanet.net (131.119.0.109)  11 ms  15 ms  22 ms
 6  sgi.bbnplanet.net (131.119.16.6)  27 ms  16 ms  24 ms
 7  linus.linux.sgi.com (192.48.153.197)  16 ms  18 ms  18 ms

Roundabout, but working.

-- 
Peace, Ariel
