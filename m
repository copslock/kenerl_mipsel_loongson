Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA19252
	for <pstadt@stud.fh-heilbronn.de>; Fri, 17 Sep 1999 23:19:32 +0200
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA00177; Fri, 17 Sep 1999 14:13:57 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA56980
	for linux-list;
	Fri, 17 Sep 1999 14:04:31 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA14258;
	Fri, 17 Sep 1999 14:04:22 -0700 (PDT)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id OAA58099; Fri, 17 Sep 1999 14:04:21 -0700 (PDT)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199909172104.OAA58099@oz.engr.sgi.com>
Subject: Re: about the O2..
To: roryh@dcs.ed.ac.uk (Rory Hunter)
Date: Fri, 17 Sep 1999 14:04:21 -0700 (PDT)
Cc: linux@cthulhu.engr.sgi.com
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
In-Reply-To: <37E29EBF.FA10420D@dcs.ed.ac.uk> from "Rory Hunter" at Sep 17, 99 09:04:15 pm
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Rory Hunter mused:
:
:Hi,
:
:Here's something to amuse you in the meantime:-
:
:Being an IRIX newbie, more used to RH linux, upon encountering an
:install of IRIX 6.3 (and a decidedly stale one at that), I naturally
:went about trying to impose order opon the chaos and tried to make the
:filesystem layout etc. more like the linux server's.
:
Big mistake :-)

Anyway, just so you (and others) know in case you don't...
You can get a more Linux/FreeBSD friendly env on IRIX by simply
installing all the mandatory GNU utils and other popular free
software stuff for IRIX.  This can be done using some cliking
(install via the web) on the site:

	http://freeware.sgi.com/

and finally putting /usr/freeware/bin first in your path.
There's a 'fixpath' script that does this and more for you.
Pretty clean, doesn't interfere with IRIX apps and work
pretty well for thousands of SGI customers.

:
:Happy hacking,
:
Cheers.

-- 
Peace, Ariel
