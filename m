Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id NAA1304745 for <linux-archive@neteng.engr.sgi.com>; Fri, 5 Sep 1997 13:38:55 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA11702 for linux-list; Fri, 5 Sep 1997 13:36:19 -0700
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.61.27]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA11685 for <linux@cthulhu.engr.sgi.com>; Fri, 5 Sep 1997 13:36:15 -0700
Received: (from ariel@localhost) by oz.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA29563 for linux@engr.sgi.com; Fri, 5 Sep 1997 13:36:13 -0700
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199709052036.NAA29563@oz.engr.sgi.com>
Subject: 2.1.53 (from Linus)
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Fri, 5 Sep 1997 13:36:12 -0700 (PDT)
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Just thought this would be of relevance to some:

Subject: Linux-2.1.53..
From: Linus Torvalds <torvalds@transmeta.com>
Date: Thu, 4 Sep 1997 17:10:27 -0700
Message-ID: <Pine.LNX.3.95.970904170831.428J-100000@penguin.transmeta.com>
Newsgroups: .mlist. linux-kernel linux-kernel@vger.rutgers.edu


I released a 2.1.53, which fixes two major bugs in the 2.1.x series. Ingo
Molnar found one (and hopefully _the_) reason for dcache corruption in
d_move(), and David Miller found and fixed a TCP-related crash-inducer. 

In short, I hope 2.1.53 will finally be stable for people,

                        Linus



-- 
Peace, Ariel
