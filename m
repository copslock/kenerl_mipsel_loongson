Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA06125; Tue, 11 Jun 1996 10:48:11 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id RAA13132 for linux-list; Tue, 11 Jun 1996 17:48:01 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id KAA13124 for <linux@cthulhu.engr.sgi.com>; Tue, 11 Jun 1996 10:47:59 -0700
Received: from localhost (lm@localhost) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via SMTP id KAA06117; Tue, 11 Jun 1996 10:47:59 -0700
Message-Id: <199606111747.KAA06117@neteng.engr.sgi.com>
To: linux@neteng.engr.sgi.com
Cc: jmy@neteng.engr.sgi.com
From: lm@gate1-neteng.engr.sgi.com (Larry McVoy)
Subject: Re: Is this a silly idea? 
Date: Tue, 11 Jun 1996 10:47:59 -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

: I planned on hacking xfs _and_ efs implementations into Linux.

We will shoot that plan in the head right away.  EFS is dead technology
and XFS is family jewels.  If we start putting XFS into Linux, there will
be hell to pay.  Besides, XFS is 45K lines of code (probably more now)
and it is really non trivial.  Porting that to Linux would take quite 
a while.

I would like to have an XFS port eventually, but we need to figure out a
way to keep it SGI source.  Last I checked, there was noise that doing 
stuff as a loadable module was not enough.  Any news on that?


I think porting ext2fs to IRIX is a much better idea.

: Also, I wouldn't mind seeing an ext2 implementation in IRIX, I could
: probably hack up an initial read-only kernel module implementation in
: a very short amount of time.

Please.  I have some file system notes somewhere that talk about the
data structures needed to do this.  James is a good resource, he did
cachefs.  He's a busy, but nice, guy and he sits near you.

--lm
