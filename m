Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA15968; Thu, 16 May 1996 15:28:23 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id WAA29295 for linux-list; Thu, 16 May 1996 22:26:59 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA29290 for <linux@cthulhu.engr.sgi.com>; Thu, 16 May 1996 15:26:58 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA15928 for <linux@neteng.engr.sgi.com>; Thu, 16 May 1996 15:26:57 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA29283 for <linux@neteng.engr.sgi.com>; Thu, 16 May 1996 15:26:56 -0700
Received: from snowcrash.cymru.net by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <linux@neteng.engr.sgi.com> id PAA21745; Thu, 16 May 1996 15:26:49 -0700
Received: from lxorguk.ukuu.org.uk (Ulxorguk@localhost) by snowcrash.cymru.net (8.7.1/8.7.1) with UUCP id XAA01905 for neteng.engr.sgi.com!linux; Thu, 16 May 1996 23:11:50 +0100
Received: by lightning.swansea.linux.org.uk (Smail3.1.29.1 #2)
	id m0uK6ho-0005FbC; Thu, 16 May 96 18:19 BST
Message-Id: <m0uK6ho-0005FbC@lightning.swansea.linux.org.uk>
From: alan@lxorguk.ukuu.org.uk (Alan Cox)
Subject: Re: mpp kernel interface
To: Andrew.Tridgell@anu.edu.au
Date: Thu, 16 May 1996 18:19:16 +0100 (BST)
Cc: lm@gate1-neteng.engr.sgi.com, linux-mc@arvidsjaur.anu.edu.au,
        Linus.Torvalds@cs.Helsinki.FI, linux@neteng.engr.sgi.com,
        alan@cymru.net
In-Reply-To: <199605161420.AAA24100@arvidsjaur.anu.edu.au> from "Andrew Tridgell" at May 17, 96 00:20:34 am
Content-Type: text
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> We use sockets to implement the stdin/stdout/stderr of parallel
> processes. The paralleld that launches parallel programs on each cell
> first creates 3 sockets back to the launching program, setting them up
> as file desciptors 0, 1 and 2. When it then does a fork()/exec() the
> parallel program inherits them.

Two things strike me here. Firstly if you are doing that kind of output
redirection across 192 cells you are going to need 192 logical connections
however you do it. Secondly you really want your node end library to be
a bit smarter and pass a tty check across the link so you can use tty/pty
pairs if the real descriptor is a tty.

> parallel programs. If we had a remote fork() and/or remote exec()
> and also had a way for the file descriptors of remote forked processes
> to feed back into the parent cpu then it would be much better. 

MOSIX does this by trapping them at the VFS layer. Effectively each inode
and file handle has a host field and if the operation is remote you RPC.

> We'd probably also need to use a tree structure to feed the file
> descriptors (and paging for that matter) back up into the parent
> process. 1000 children all writing to one parent would not be pretty. 

It would be an interesting application of multicast groups to allow the parent
to roam as well. With 1000 children thats an even bigger scaling problem, and
for sending stuff to a large number of nodes (eg a loosely synchronized SIMD
job) its going to be needed.

> The problem is really latency. Ethernet type systems have latencies
> which aren't much lower than the system clock tick interval. This
> means it often makes sense to do things is quite different ways to
> what we have to do.

Yes. The latency also means that attacking from two other angles is interesting
Firstly 10Mbit ethernet - latency is no worse really just we have to be more
reluctant to bulk copy data, and also combining it with something like the
TTL PAPERS device for the fast sync stuff (its a $60 to build parallel port
synchronization system with about a 3uS overhead). Very limited but might
solve some of our problems on ethernet linked boxes.

Alan
