Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) via SMTP id NAA44760 for <linux-archive@neteng.engr.sgi.com>; Wed, 12 Nov 1997 13:48:15 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id NAA26703 for linux-list; Wed, 12 Nov 1997 13:43:22 -0800
Received: from odin.corp.sgi.com (fddi-odin.corp.sgi.com [198.29.75.194]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id NAA26689 for <linux@engr.sgi.com>; Wed, 12 Nov 1997 13:43:21 -0800
Received: from oz.engr.sgi.com by odin.corp.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1502/951211.SGI)
	 id NAA08363; Wed, 12 Nov 1997 13:31:59 -0800
Received: (from ariel@localhost) by oz.engr.sgi.com (970903.SGI.8.8.7/960327.SGI.AUTOCF) id NAA21427; Wed, 12 Nov 1997 13:31:43 -0800 (PST)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199711122131.NAA21427@oz.engr.sgi.com>
Subject: Re: SGI / Linux
To: paulp@netco.com (Paul Prawdiuk)
Date: Wed, 12 Nov 1997 13:31:42 -0800 (PST)
Cc: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
In-Reply-To: <Pine.SGI.3.96.971112144846.4419A-100000@anubis.netco.com> from "Paul Prawdiuk" at Nov 12, 97 02:54:35 pm
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Paul,

[Ccing the Linux mailing list]

Thanks for offering to help. 

If you can get your hands on an experimental Indy and write
a good HOWTO on how to get Linux running on it it'll be
a long way to make what we have usable for many more people.

In order to do that you should:

	1) Subscribe to our mailing list:
		To: majordomo@engr.sgi.com
		Body:
		subscribe linux username@your.domain

	2) Grep the archive for multiple relevant postings
		http://reality.sgi.com/ariel/linux.gz

There are two ways to boot:

	1) Remotely (bootp) all filesystem remote
	   (relatively easy, but slow)

	2) Create local efs or e2fs filesystems and boot
	   from local disk. This is preferred but currently
	   requires some bootstrapping complex steps
	   (and completing the efs linux support by Mike Shaver)

1) Is partly (and possibly inaccurately) documented
2) Is black art, never documented

Ideally we would like to tell people:
"To boot Linux on your Indy all you need is a spare SCSI disk
 (so you can keep all your IRIX stuff) and here's the HOWTO"

In short a dual boot system (IRIX/Linux) that is easy to setup.

www.linux.sgi.com still doesn't have a really easy HOWTO
on how to get there.

Lastly: if your organization is a big SGI customer and is in
interested in seeing Linux work, we'll be happy to hear more
details (e.g why?).

--
Peace, Ariel


:
:*Documentation: complete and easy to understand SGI/Linux HOWTOs
:*A lot more userland porting - get to a bona-fide Red Hat like 
:distribution. 
:
:* Tell a little about yourself, your expertise, and projects you've worked
:on in the past.
:
:Paul Prawdiuk / Network Engineer. I work on networks on a large scale.
:Projects have all been network related.
:
:* What would you like to work on?  
:I am sure I could work on documentation for this project.
:I might also be able to port a few applications. I am not a programmer by
:trade but do have some programming skills.
:
:* How much time can you invest in it (per day/week)? 
:Not sure, it is to be determined.
:
:* How long do you think it would take you to complete? 
:See above.
:
:* What help would you need from us 
:Not much. My company uses a ton of SGI stuff including lots of O2 and Indy
:machines. 
:
:* notes
:I should be able to get an Indy to work on. 
:I would really love to see this for O2 boxes.
:
:PS. Is their plans for the new portable file system?
:


-- 
Peace, Ariel
