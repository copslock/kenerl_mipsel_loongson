Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA17955; Thu, 16 May 1996 02:45:50 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from daemon@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id JAA02565 for linux-list; Thu, 16 May 1996 09:44:21 GMT
Received: from neteng.engr.sgi.com (neteng.engr.sgi.com [192.26.80.10]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA02560 for <linux@cthulhu.engr.sgi.com>; Thu, 16 May 1996 02:44:19 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA17903 for <lmlinux@neteng.engr.sgi.com>; Thu, 16 May 1996 02:44:18 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [150.166.76.30]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id CAA02551 for <lmlinux@neteng.engr.sgi.com>; Thu, 16 May 1996 02:44:17 -0700
Received: from snowcrash.cymru.net by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id CAA22098; Thu, 16 May 1996 02:44:14 -0700
Received: (from alan@localhost) by snowcrash.cymru.net (8.7.1/8.7.1) id KAA09812; Thu, 16 May 1996 10:35:05 +0100
From: Alan Cox <alan@cymru.net>
Message-Id: <199605160935.KAA09812@snowcrash.cymru.net>
Subject: Re: lmbench with new checksum code...
To: davem@caip.rutgers.edu (David S. Miller)
Date: Thu, 16 May 1996 10:35:04 +0100 (BST)
Cc: lmlinux@neteng.engr.sgi.com, torvalds@cs.helsinki.fi,
        sparclinux-cvs@caipfs.rutgers.edu, alan@cymru.net
In-Reply-To: <199605160653.CAA12098@huahaga.rutgers.edu> from "David S. Miller" at May 16, 96 02:53:50 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> I doubt I can get 2mb/s more out of my code to beat solaris, sigh,
> where the heck could all this overhead possibly be???

What makes you think the Solaris loopback is even doing checksums or a memcpy
via kernel space ? They only way you'll beat solaris at the loopback network
game is to cheat as they do. Make tcp_connect spot a localhost connection
change the socket method to something akin to af_unix but streamlined a bit
(only special case is urgent data).

Alan
