Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA08947; Thu, 30 May 1996 11:21:35 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id SAA14111 for linux-list; Thu, 30 May 1996 18:21:30 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA14094 for <linux@cthulhu.engr.sgi.com>; Thu, 30 May 1996 11:21:27 -0700
Received: from refugee.engr.sgi.com (refugee.engr.sgi.com [150.166.61.22]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id LAA08942; Thu, 30 May 1996 11:21:27 -0700
Received: from refugee.engr.sgi.com by refugee.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id LAA13683; Thu, 30 May 1996 11:17:21 -0700
Message-Id: <199605301817.LAA13683@refugee.engr.sgi.com>
X-Mailer: exmh version 1.6.7 5/3/96
To: Alan Cox <alan@cymru.net>
Cc: lm@gate1-neteng.engr.sgi.com (Larry McVoy), dm@neteng.engr.sgi.com,
        nn@lanta.engr.sgi.com, torvalds@cs.helsinki.fi,
        sparclinux-cvs@caipfs.rutgers.edu, lmlinux@neteng.engr.sgi.com
Subject: Re: linux needs bsd networking stack 
In-reply-to: Message from alan@cymru.net of 30 May 1996 11:06:25 BST
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 30 May 1996 11:17:21 -0700
From: Steve Alexander <sca@refugee.engr.sgi.com>
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Alan Cox <alan@cymru.net> writes:
>We can't steal it outright. 4.4BSD has abominable problems as is. The FreeBSD 
>people
>have the worst of them fixed but don't have stuff like Vegas and have all the 
>horrible spoofing problems caused by bad timers.

I'm not sure I understand what that means, but I'm pretty sure that Vegas is
not universally agreed to be a good idea, unless I've missed a meeting.

Just to set the record straight, there are people at SGI who don't like either
the BSD or Linux stacks ;->.

The one thing that I will say about the Linux stack is that it is evolving much
more rapidly than any of the public BSD versions are (I spent some time porting
aliases forward from one version to another for a friend, and the improvements
between versions were amazing), so at some point it will probably win on
functionality.

-- Steve
