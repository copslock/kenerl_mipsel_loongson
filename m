Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA18984; Thu, 16 May 1996 03:10:12 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id KAA03443 for linux-list; Thu, 16 May 1996 10:08:46 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA03438 for <linux@cthulhu.engr.sgi.com>; Thu, 16 May 1996 03:08:44 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA18931 for <lmlinux@neteng.engr.sgi.com>; Thu, 16 May 1996 03:08:42 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA03430 for <lmlinux@neteng.engr.sgi.com>; Thu, 16 May 1996 03:08:41 -0700
Received: from porsta.cs.Helsinki.FI by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id DAA22956; Thu, 16 May 1996 03:08:39 -0700
Received: from linux.cs.Helsinki.FI (linux.cs.Helsinki.FI [128.214.48.39]) by porsta.cs.Helsinki.FI (8.6.10/8.6.9) with SMTP id NAA19285; Thu, 16 May 1996 13:08:28 +0300
Date: Thu, 16 May 1996 13:08:04 +0300 (EET DST)
From: Linus Torvalds <torvalds@cs.Helsinki.FI>
To: Alan Cox <alan@cymru.net>
cc: "David S. Miller" <davem@caip.rutgers.edu>, lmlinux@neteng.engr.sgi.com,
        sparclinux-cvs@caipfs.rutgers.edu
Subject: Re: lmbench with new checksum code...
In-Reply-To: <199605160935.KAA09812@snowcrash.cymru.net>
Message-ID: <Pine.LNX.3.91.960516124452.6325L-100000@linux.cs.Helsinki.FI>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk



On Thu, 16 May 1996, Alan Cox wrote:
> 
> What makes you think the Solaris loopback is even doing checksums or a memcpy
> via kernel space ? They only way you'll beat solaris at the loopback network
> game is to cheat as they do. Make tcp_connect spot a localhost connection
> change the socket method to something akin to af_unix but streamlined a bit
> (only special case is urgent data).

One day we might actually want to do something like that. No, I'm not
suggesting special-casing loopback (we don't need it any more, we're getting
good enough performance as-is), but I would suggest that at some point we
integrate the networking code a bit tighter in the VFS model of open/close. 

One problem with the networking code right now is that we can't short-circuit
some of the decisions, so we're doing unnecessary run-time checks. This is
not really much of a performance problem, I consider it more of a beaty wart
right now. 

For example, when we open a normal pipe (be it unnamed or named), we 
never go through the filesystem code for that pipe any more - we just 
make the file operations point directly to the pipe code, and when we 
read/write to that pipe we don't have any filesystem overhead.

In contrast, when we open a network connection, we always go through the 
network layer, even at run-time. Admittedly there are some reasons for 
this, but most of them aren't really valid any more.

For example, sockets used to really be totally separate entities from 
inodes, so we couldn't consider sockets to be part of the VFS layer. But 
that isn't true any more (and hasn't been for a long whole): sockets 
really _are_ implemented as a part of the inode these days. So a "socket" 
is really just the network-specific part of an inode (the same way the 
"normal" filesystems have their own private parts - look at the inode "u" 
union to see what I mean.

However, due to historical reasons, the internal socket routines do not 
use the VFS "inode" abstraction, but instead they use only the socket 
sub-part. Sometime in the future I would really like to get rid of that, 
and make the low-level socket code use the "inode" the same way everybody 
else does.

This is _definitely_ not a huge issue - as I said it's more cleanlyness 
and encapsulation than performance. It will require making the 
socket-specific IO operations (recvmsg etc) be first-class members in the 
VFS layer etc, and in general it requires a lot of minor modifications. 
Nothing terribly hard (and some things get cleaner thanks to it), but 
it's a lot of code that has to be worked out.

Merging the sockets more tightly into the VFS layer gets rid of the current
"struct socket" that we don't really need (as opposed to the "struct sock",
which is a different beast altogether) and at least partly the "struct
proto_ops" (which would just be part of the "struct file_operations").  We'd
get rid of one (slightly confusing) layer of abstraction, and some cases
could be streamlined a bit. 

Finally, let me say again that I don't think we should short-circuit loopback
TCP like Solaris does. I used to think it was a nifty feature, but I got
better. When I talk about streamlining above, I'm thinking of similar
short-circuiting, but on a much smaller scale (getting rid of run-time checks
that can be done when the state of the thing changes instead). 

For an example of what I'm talking about, look at how the tty layer uses the
operations pointers to handle hangup etc. It just changes the file operations
pointer, which automagically means that the files start behaving differently
once they've been hung up (without having the actual routines do any extra
"am I hung up" checking).  That's the kind of thing that the network layer
could do too if it was better integrated with the VFS layer. 

[ Alan has heard some of this before - I've been talking about these changes
  for a long time. I've never felt they have been important enough to really
  do something radical about it, but I still think it's the right thing to do
  eventually ]

		Linus
