Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA17152; Thu, 16 May 1996 02:21:25 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA01804 for linux-list; Thu, 16 May 1996 09:20:00 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA01794 for <linux@cthulhu.engr.sgi.com>; Thu, 16 May 1996 02:19:57 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA17105 for <linux@neteng.engr.sgi.com>; Thu, 16 May 1996 02:19:57 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA01784; Thu, 16 May 1996 02:19:54 -0700
Received: from snowcrash.cymru.net by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	 id CAA21099; Thu, 16 May 1996 02:19:50 -0700
Received: (from alan@localhost) by snowcrash.cymru.net (8.7.1/8.7.1) id KAA08950; Thu, 16 May 1996 10:09:19 +0100
From: Alan Cox <alan@cymru.net>
Message-Id: <199605160909.KAA08950@snowcrash.cymru.net>
Subject: Re: mpp kernel interface
To: lm@gate1-neteng.engr.sgi.com (Larry McVoy)
Date: Thu, 16 May 1996 10:09:17 +0100 (BST)
Cc: tridge@cs.anu.edu.au, linux-mc@arvidsjaur.anu.edu.au,
        Linus.Torvalds@cs.Helsinki.FI, linux@neteng.engr.sgi.com,
        alan@cymru.net
In-Reply-To: <199605152243.PAA19394@neteng.engr.sgi.com> from "Larry McVoy" at May 15, 96 03:43:19 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> : With 30 people now on this list there must be someone else who wants
> : to say something ...

I've not actually seen anything from the list (should be going to ukuu)

> 	SMP vs cluster?

Why vs, why not AND. An SMP box is just a couple of well connected nodes.

> The hard one is sockets.  I've never seen a good solution to that.
> I'll come back to that.  First, I want to go through the other ones and
> offer suggestions.

There are several approaches to this. One is to treat it like a device so
you open a socket on a given machine and it like the device doesnt walk. The
other is to bend IP mobile to the needs. That would probably want something
like an old 486 as a network FEP.

> do remote processes.  For the PID name space, make pid_t a 32 bit int,
> make the top 16 bits the host part, and the bottom 16 bits the pid part.
> (We need to come back to the host part when we discuss process migration.)
> A host part of "0" means "this host".  So a "kill -HUP 1" will always
> restart init.

We can also do this for devices so you can mknod a printer on a different 
node.

> Devices I sort of punt on.  For device access, I would just use the 
> remote mag tape protocol (or something very, very similar) so that all
> of the locking, etc., still works - since you ship all the requests to
> the system w/ the device, that kernel can implement the locks.  Any
> issues here?

The vfs issues fairly controlled requests to the FS layer, and the device
layer also is fairly clean. The MOSIX project intercepted stuff at this
level --- so a remote device turns the request into a message. The system
also accounted messages so a process like a find would migrate across cpus
as it changed the disk it was searching.

> we have the talent right here on this list to do it.  So I'll bow out of
> commenting on it, other than to say make sure mmap works right.

mmap is foul. SYS5 shared memory is just as bad too. 

> Sockets.  This is a hard problem.  Some people think that a socket
> should stick around after the CPU that created the socket has crashed.

If you are having a single apparent IP address this is true for TCP, you can
on spotting a down host just send an RST and go into TIME_WAIT to preserve
the corruption protection properties of TCP.

> is a big performance win.  Coming from a network cluster, you'll get that
> without having to work for it - the other way frequently is harder.

It also means more people can play
