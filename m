Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id IAA35613 for <linux-archive@neteng.engr.sgi.com>; Wed, 17 Jun 1998 08:43:42 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id IAA33725
	for linux-list;
	Wed, 17 Jun 1998 08:43:13 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id IAA74834
	for <linux@cthulhu.engr.sgi.com>;
	Wed, 17 Jun 1998 08:43:11 -0700 (PDT)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id IAA95711 for linux@engr.sgi.com; Wed, 17 Jun 1998 08:43:11 -0700 (PDT)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199806171543.IAA95711@oz.engr.sgi.com>
Subject: (fwd) linux SEGV details
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Wed, 17 Jun 1998 08:43:11 -0700 (PDT)
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL24 ME5a]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

[forwarding bounced message from non subscriber]

----- Forwarded message from owner-linux@cthulhu -----
To: adelton@informatics.muni.cz (Honza Pazdziora)
Date: Wed, 17 Jun 1998 09:18:17 +0200 (MET DST)
Cc: adevries@engsoc.carleton.ca, adelton@informatics.muni.cz,
        linux@cthulhu.engr.sgi.com
X-Mailer: ELM [version 2.4ME+ PL39 (25)]

Honza Pazdziora wrote:
> > Do you mean that mkswap segfaulted during install, or after?  I'll have a
> > closer look.  The util-linux we're using is a little old.

It segfault during install _and_ after install when we tried to set up
swap space manualy.

> 
> I'm not sure what happened during install -- I just wanted to have it
> done to see the real prompt ;-) But when I tried mkswap /dev/sdb2 on
> the prompt, it said something about freeing free buffer? (or whatever)
> and then gave register dump. Sorry, I'm at home and can't get to the
> machine because sshd isn't running there yet, so I will send the exact
> output tomorrow.

Honza is not yet here, so there is the output:

#mkswap /dev/sdb2
Segmentation fault
#

and on console (there is no syslogd :( ) is:

#dmesg
[...skipped...]
VFS: brelse: Trying to free free buffer
Unable to handle kernel paging request at virtual address 00050040,
epc == 88041e7c, ra == 880464e0
Oops: 0000
$0 : 00000000 88140000 00000028 00000009
$4 : 00050028 00000001 bf0f0000 00000000
$8 : 00000720 00000000 00000000 00000000
$12: 00000008 000003e2 8836e59c 7ffffcf0
$16: 00050028 894c7c88 894c7d80 00000001
$20: 00000000 00000000 894c7c80 00000000
$24: 00000001 7ffffcf1
$28: 894c6000 894c7c58 00000000 880464e0
epc   : 88041e7c
Status: 3000fc03
Cause : 00000008


[and just another attempt to mkswap...]
VFS: brelse: Trying to free free buffer
Unable to handle kernel paging request at virtual address 00050040,
epc == 88041e7c, ra == 880464e0
Oops: 0000
$0 : 00000000 88140000 00000028 00000009
$4 : 00050028 00000001 bf0f0000 00000000
$8 : 00000720 00000000 00000000 00000000
$12: 00000008 000003e2 8836e59c 7ffffcf0
$16: 00050028 894c7c88 894c7d80 00000001
$20: 00000000 00000000 894c7c80 00000000
$24: 00000001 7ffffcf1
$28: 894c6000 894c7c58 00000000 880464e0
epc   : 88041e7c
Status: 3000fc03
Cause : 00000008

The same with recompiled mkswap.

Hope it helps.

I tried to compile our (international) ssh, but it ends with "not
enough memory" :( This indy has 32MB ram, maybe I will shut down our
web server and boot linux there, it has little bit more RAM and is
faster...
No, that's not goot idea :-(

david kostal (kron@fi.muni.cz)
----+
----- End of forwarded message from owner-linux@cthulhu -----

-- 
Peace, Ariel
