Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA19263; Mon, 15 Apr 1996 17:02:18 -0700
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id RAA29502; Mon, 15 Apr 1996 17:02:13 -0700
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id RAA29493; Mon, 15 Apr 1996 17:02:12 -0700
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id RAA19258 for <lmlinux@neteng.engr.sgi.com>; Mon, 15 Apr 1996 17:02:11 -0700
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <lmlinux@neteng.engr.sgi.com> id RAA29487; Mon, 15 Apr 1996 17:02:10 -0700
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@neteng.engr.sgi.com> id RAA07450; Mon, 15 Apr 1996 17:02:09 -0700
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id UAA01922; Mon, 15 Apr 1996 20:02:04 -0400
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id UAA19157; Mon, 15 Apr 1996 20:02:04 -0400
Date: Mon, 15 Apr 1996 20:02:04 -0400
Message-Id: <199604160002.UAA19157@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: lmlinux@neteng.engr.sgi.com
CC: torvalds@cs.helsinki.fi
Subject: HyperSparc UP numbers
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


The MMap lat. looks bogus but the rest is ok.

Larry, if you make another set of results publicly available on your
web page for the next release like you do now I'd like this to be in
there if thats ok.


                    L M B E N C H  1 . 0   S U M M A R Y
                    ------------------------------------

            Processor, Processes - times in microseconds
            --------------------------------------------
Host                 OS  Mhz    Null    Null  Simple /bin/sh Mmap 2-proc 8-proc
                             Syscall Process Process Process  lat  ctxsw  ctxsw
--------- ------------- ---- ------- ------- ------- ------- ---- ------ ------
huahaga    Linux 1.3.83  118       3   12.8K   36.4K     52K 1060     25     43

            *Local* Communication latencies in microseconds
            -----------------------------------------------
Host                 OS  Pipe       UDP    RPC/     TCP    RPC/
                                            UDP             TCP
--------- ------------- ------- ------- ------- ------- -------
huahaga    Linux 1.3.83      75     188     628     404     916

            *Local* Communication bandwidths in megabytes/second
            ----------------------------------------------------
Host                 OS Pipe  TCP  File   Mmap  Bcopy  Bcopy  Mem   Mem
                                  reread reread (libc) (hand) read write
--------- ------------- ---- ---- ------ ------ ------ ------ ---- -----
huahaga    Linux 1.3.83   54  9.7   36.4   30.8     21     22   49    37

	    Memory latencies in nanoseconds
            (WARNING - may not be correct, check graphs)
            --------------------------------------------
Host                 OS   Mhz  L1 $   L2 $    Main mem    TLB    Guesses
--------- -------------   ---  ----   ----    --------    ---    -------
huahaga    Linux 1.3.83   118    11     11         511      0    No L1 cache?
