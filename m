Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA07790; Thu, 1 Aug 1996 13:48:04 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id UAA21059 for linux-list; Thu, 1 Aug 1996 20:47:57 GMT
Received: from yon.engr.sgi.com (yon.engr.sgi.com [150.166.61.32]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA21054 for <linux@cthulhu.engr.sgi.com>; Thu, 1 Aug 1996 13:47:55 -0700
Received: (from ariel@localhost) by yon.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA11583 for linux; Thu, 1 Aug 1996 13:46:21 -0700
From: ariel@yon.engr.sgi.com (Ariel Faigon)
Message-Id: <199608012046.NAA11583@yon.engr.sgi.com>
Subject: Those FreeBSD guys...
To: linux@yon.engr.sgi.com
Date: Thu, 1 Aug 1996 13:46:21 -0700 (PDT)
Reply-To: ariel@cthulhu.engr.sgi.com
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Yesterday, I went to the MindSource monthly meeting (Michael's
at Shoreline) where three FreeBSD people gave a talk.
Jordan Hubbard (he is on a visit from Ireland), Sameer Parekh (sp?),
and Matt Dillon.


Of course there were persistent questions from the audience
to the tune of "I have this other system at home that starts
with L..., why should I switch to FreeBSD?"

Here are some of the answers given (from memory):

"Our impression of the Linux community is that they are
a bunch of Cowboys, they don't even use a source-control system
to coordinate and split the work. We have these great development
control tools: cvsup and sup ... we work really well together.
all the core team has write permission to the source tree"
There are 47 people doing major contributions. 14 of them
are core.

"Linux might give you the "feeling" it is faster, but it is because
we gave a lot of thought in the design to scalability and SMP,
when you load Linux the great performance suddenly drops down
sharply while BSD scales nicely."

"If you want a single user Unix to play at home, Linux is fine
but if you are a commercial entity or ISP and you count on reliability
and solid network performance, complex routing etc. use FreeBSD"

"Linux is just a kernel, when you go to a full distribution
things are much more complex, there are too many Linux distributions
there's only one FreeBSD source base and it is complete with all
utilities"

"They try to run on too many architectures and the code is not clean
We (FreeBSD as opposed to NetBSD) focus on Intel only, do it cleanly
and make sure it works well"

"They have the momentum and we don't underestimate this... we learned
that we need to be nicer towards newbie questions to establish
a larger user base"

The future of FreeBSD is really promising: Clustering & Log filesystems
are coming. SMP is already here (although it is not exactly symmetrical)"

Sounds like these guys haven't seen linux since 0.99...
Interesting nevertheless.
-- 
Peace, Ariel
