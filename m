Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id GAA17082; Mon, 18 Mar 1996 06:08:15 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id GAA02804; Mon, 18 Mar 1996 06:08:10 -0800
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id GAA02799; Mon, 18 Mar 1996 06:08:09 -0800
Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	for <lmlinux@neteng.engr.sgi.com> id GAA17076; Mon, 18 Mar 1996 06:08:08 -0800
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <lmlinux@neteng.engr.sgi.com> id GAA02793; Mon, 18 Mar 1996 06:08:07 -0800
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id GAA19354; Mon, 18 Mar 1996 06:08:05 -0800
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id JAA18628; Mon, 18 Mar 1996 09:08:03 -0500
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id JAA03959; Mon, 18 Mar 1996 09:08:02 -0500
Date: Mon, 18 Mar 1996 09:08:02 -0500
Message-Id: <199603181408.JAA03959@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: torvalds@cs.helsinki.fi
CC: lmlinux@neteng.engr.sgi.com, adrian@remus.rutgers.edu
Subject: ccpenguin
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Not too bad at all.  Pretty spiffy machine I guess.  Although no match
for Linus's ev5 running Linux.  But when I get the port done on this
thing I'll have comparable numbers ;-)

Remember, no forwarding of this stuff.


                    L M B E N C H  1 . 0   S U M M A R Y
                    ------------------------------------

            Processor, Processes - times in microseconds
            --------------------------------------------
Host                 OS  Mhz    Null    Null  Simple /bin/sh Mmap 2-proc 8-proc
                             Syscall Process Process Process  lat  ctxsw  ctxsw
--------- ------------- ---- ------- ------- ------- ------- ---- ------ ------
ccpenguin   SunOS 5.5.1  167       5    3.4K   19.5K     37K  184     13     19

            *Local* Communication latencies in microseconds
            -----------------------------------------------
Host                 OS  Pipe       UDP    RPC/     TCP    RPC/
                                            UDP             TCP
--------- ------------- ------- ------- ------- ------- -------
ccpenguin   SunOS 5.5.1      54     197     273     163     330

            *Local* Communication bandwidths in megabytes/second
            ----------------------------------------------------
Host                 OS Pipe  TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                                  reread reread (libc) (hand) read write
--------- ------------- ---- ---- ------ ------ ------ ------ ---- -----
ccpenguin   SunOS 5.5.1   61 50.8  138.6   96.1    171     66  115   156

	    Memory latencies in nanoseconds
            (WARNING - may not be correct, check graphs)
            --------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    TLB    Guesses
--------- -------------   ---  ----   ----    --------    ---    -------
ccpenguin   SunOS 5.5.1   167     6     41         265    492
