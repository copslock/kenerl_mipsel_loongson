Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id GAA08610 for <linux-archive@neteng.engr.sgi.com>; Thu, 16 Jul 1998 06:56:18 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id GAA63349
	for linux-list;
	Thu, 16 Jul 1998 06:55:39 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id GAA85688
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 16 Jul 1998 06:55:37 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id GAA26092
	for <linux@cthulhu.engr.sgi.com>; Thu, 16 Jul 1998 06:55:07 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id PAA27000;
	Thu, 16 Jul 1998 15:54:52 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id PAA10552;
	Thu, 16 Jul 1998 15:54:47 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id PAA09548;
	Thu, 16 Jul 1998 15:54:50 +0200 (MET DST)
Message-Id: <199807161354.PAA09548@aisa.fi.muni.cz>
Subject: Re: The pre-release of Hard Hat Linux for SGI...
In-Reply-To: <Pine.LNX.3.95.980715180435.22020I-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jul 15, 98 06:13:15 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Thu, 16 Jul 1998 15:54:50 +0200 (MET DST)
Cc: adelton@informatics.muni.cz, linux@cthulhu.engr.sgi.com
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Alright, here are the steps I needed to do in order to have machine that
would allow me to log in. To repeat what I stared with, I installed
just the newtorked WS, did not select any aditional packages, did not
remove any from selection, just base and network.

The first problem: Unable to open initial console. Since you are able
to boot Upgrade from network and have the second console available
(do not start the upgrade, just boot it and hit twice Enter to get rid
of those messages about mount failing), you can create the entries
in the dev directory, that are missing and cause the trouble. I did

	cd /dev
	tar cf - * | ( cd /mnt/dev ; tar xvf - )

so you take the devices from the installation root (there are just
about 8 of them, but there is console ther and that's you need).
The install.log shows that the installation of the dev RPM failed,
so that's why we need to create the devices by hand (obviously, when
it says it fails, it really fails in some way ;-) So you have
console but do not have devices for disks, so Linux won't be able
to remount root, etc.

I've found device /tmp/sdb2 still on the second console of Upgrade,
numbers 8/18, so I created /mnt/dev/sdb2 and /mnt/dev/sdb1 with 8/18
and 8/17. You might be installing to different drives, but anyway,
look around and you'll find the numbers.

If you do not have /etc/passwd like I didn't, you can do

	echo 'root::0:0:root:/:/bin/bash' > /mnt/etc/passwd

to be able to log in after you reboot.

I think it's time to reboot, so do sync and reboot.

I had to boot with init=/bin/bash because first I forgot to create the
/etc/passwd, and second, the /bin/login said something about libraries
(it just blinked and returned the prompt but I saw something like .so
so I think that was it). So once you have bash# prompt, do
/sbin/ldconfig.

> > Some of the packages still complain about failing, on console 4 Unable
> > to load interpreter.

P.S.: I maybe did not stressed out that some of the packages failed
_and_ some gave the following message -- I do not know which gave the
message about ldconfig, but certainly not all that failed.

		During the install of 230 packages there were
> > about 20 messages
> > 	ldconfig: Exception at [<88109534>] (8810960c)
> 
> _THAT_ worries me a lot.
> 
> If you have an existing install of linux on your SGI, do this:
> - install the ldconfig rpm that's in the distribution you have

It was installed fine already ...

> - run ldconfig

... so I did run ldconfig ...

> Does that still give the exception?

... and no, no exception, just some messages about some libraries
that I decided are harmless. Anyway, after this, I was able to log in
on prompt and start ncftp to get the dev RPM and install it and install
ssh to get to my mail and send this report.

Do you want the install.log, Alex? I thought you said that the problem
with failing packages was caused by csh and that it was harmless
(just a message). I'm affraid it really means some problem, because
it did not create the /dev entries and did not create the
/etc/passwd.

More later,

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
