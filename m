Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id PAA122846 for <linux-archive@neteng.engr.sgi.com>; Wed, 24 Sep 1997 15:24:18 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA28554 for linux-list; Wed, 24 Sep 1997 15:23:55 -0700
Received: from fir.engr.sgi.com (fir.engr.sgi.com [150.166.49.183]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA28548; Wed, 24 Sep 1997 15:23:53 -0700
Received: (from wje@localhost) by fir.engr.sgi.com (950413.SGI.8.6.12/950213.SGI.AUTOCF) id PAA24127; Wed, 24 Sep 1997 15:23:52 -0700
Date: Wed, 24 Sep 1997 15:23:52 -0700
Message-Id: <199709242223.PAA24127@fir.engr.sgi.com>
From: "William J. Earl" <wje@fir.engr.sgi.com>
To: clepple@foo.org
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Indy netboot problems
In-Reply-To: <199709242137.RAA00921@mug.foo.org>
References: <199709242137.RAA00921@mug.foo.org>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Charles Lepple writes:
 > Hello all,
 > Sorry to bother you if this is a routine question, but I read the FAQ, and 
 > therein lies my problem.
 > 
 > I'm trying to make an Indy netboot, but I'm not too familiar with the new 
 > monitor (let's just say that I knew sifex much better...Anyone remember the 
 > IRIS 3130s?). I need a way to correct the HW address, since it appears to be 
 > set to '0:0:FF:FF:0:0', and it is complaining about it.
 > 
 > Is there any other way to change nvram settings except through the 
 > setenv/printenv commands?
...

      "setenv -p xxx yyy" will set xxx permanently (in NVRAM) to yyy.  Without
the "-p", it just sets xxx in the environment in memory.  For the hardware
address ("eaddr"), however, you cannot readily change it, as it is the
system serial number as well as the MAC address.  I don't know any easy
way for it have been corrupted; it would normally be fixed by field service.
