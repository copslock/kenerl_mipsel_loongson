Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA71299 for <linux-archive@neteng.engr.sgi.com>; Tue, 16 Jun 1998 11:27:06 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA37169
	for linux-list;
	Tue, 16 Jun 1998 11:26:36 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA72228
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 16 Jun 1998 11:26:34 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from aragorn.ics.muni.cz (aragorn.ics.muni.cz [147.251.4.33]) by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam: SGI does not authorize the use of its proprietary systems or networks for unsolicited or bulk email from the Internet.) via ESMTP id LAA00453
	for <linux@cthulhu.engr.sgi.com>; Tue, 16 Jun 1998 11:26:29 -0700 (PDT)
	mail_from (adelton@informatics.muni.cz)
Received: from anxur.fi.muni.cz (0@anxur.fi.muni.cz [147.251.48.3])
	by aragorn.ics.muni.cz (8.8.5/8.8.5) with ESMTP id UAA20608;
	Tue, 16 Jun 1998 20:25:49 +0200 (MET DST)
Received: from aisa.fi.muni.cz (11635@aisa [147.251.48.1])
	by anxur.fi.muni.cz (8.8.5/8.8.5) with ESMTP id UAA08963;
	Tue, 16 Jun 1998 20:25:47 +0200 (MET DST)
Received: (from adelton@localhost)
	by aisa.fi.muni.cz (8.8.5/8.8.5) id UAA05307;
	Tue, 16 Jun 1998 20:25:48 +0200 (MET DST)
Message-Id: <199806161825.UAA05307@aisa.fi.muni.cz>
Subject: Re: RedHat 5.1 (Manhattan) ALPHA 1 for SGI/Indys
In-Reply-To: <Pine.LNX.3.95.980616120211.26590B-100000@lager.engsoc.carleton.ca> from Alex deVries at "Jun 16, 98 12:07:58 pm"
To: adevries@engsoc.carleton.ca (Alex deVries)
Date: Tue, 16 Jun 1998 20:25:48 +0200 (MET DST)
Cc: adelton@informatics.muni.cz, linux@cthulhu.engr.sgi.com
From: Honza Pazdziora <adelton@informatics.muni.cz>
Phone: 420 (5) 415 12345
X-Mailer: ELM [version 2.4ME+ PL39 (25)]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> > I've set up root password in the menu but it wasn't there after
> > reboot -- not even /etc/passwd -- I had to boot init=/bin/bash.
> 
> Do you mean that /etc/passwd didn't exist at all?

Right. I can repeat the installation from the scratch tomorrow and
have closer look at the other consoles. But neither passwd, nor shadow
existed.

> Do you mean that mkswap segfaulted during install, or after?  I'll have a
> closer look.  The util-linux we're using is a little old.

I'm not sure what happened during install -- I just wanted to have it
done to see the real prompt ;-) But when I tried mkswap /dev/sdb2 on
the prompt, it said something about freeing free buffer? (or whatever)
and then gave register dump. Sorry, I'm at home and can't get to the
machine because sshd isn't running there yet, so I will send the exact
output tomorrow.

> We actually already have ssh on ftp.replay.com, IIRC.  I'm in the US
> (sigh...) so I can't export it.

No problem, I thing we can add mips.rpm to out ssh mirror.

> If you were interested, you could have a look at getting a util-linux RPM
> up to version 2.8.  util-linux is a gross thing.

OK, I'll try.

------------------------------------------------------------------------
 Honza Pazdziora | adelton@fi.muni.cz | http://www.fi.muni.cz/~adelton/
                   I can take or leave it if I please
------------------------------------------------------------------------
