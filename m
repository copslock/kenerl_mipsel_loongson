Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id WAA20453; Thu, 29 Feb 1996 22:40:24 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id WAA28253; Thu, 29 Feb 1996 22:40:01 -0800
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id WAA28248; Thu, 29 Feb 1996 22:40:00 -0800
Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	for <lmlinux@neteng.engr.sgi.com> id WAA20448; Thu, 29 Feb 1996 22:39:58 -0800
Received: from sgi.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <lmlinux@slovax.engr.sgi.com> id WAA28241; Thu, 29 Feb 1996 22:39:50 -0800
Received: from caipfs.rutgers.edu by sgi.sgi.com via ESMTP (950405.SGI.8.6.12/910110.SGI)
	for <lmlinux@slovax.engr.sgi.com> id WAA00361; Thu, 29 Feb 1996 22:39:41 -0800
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id BAA25636 for <lmlinux@slovax.engr.sgi.com>; Fri, 1 Mar 1996 01:39:38 -0500
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id BAA23841; Fri, 1 Mar 1996 01:39:37 -0500
Date: Fri, 1 Mar 1996 01:39:37 -0500
Message-Id: <199603010639.BAA23841@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: lmlinux@neteng.engr.sgi.com
Subject: ./lat_syscall
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I was bored and got the benchmark down to 2 microseconds on the
SparcClassic 50mhz cpus... pushing the envelope a bit I guess, I'll
optimize other things now ;-)

Later,
David S. Miller
davem@caip.rutgers.edu
