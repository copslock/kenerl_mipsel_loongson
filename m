Received: from cthulhu.engr.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	 id OAA20552; Tue, 19 Mar 1996 14:34:20 -0800
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: by cthulhu.engr.sgi.com (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for linux-list id OAA24122; Tue, 19 Mar 1996 14:34:15 -0800
Received: from neteng.engr.sgi.com by cthulhu.engr.sgi.com via ESMTP (950511.SGI.8.6.12.PATCH526/911001.SGI)
	for <linux@cthulhu.engr.sgi.com> id OAA24117; Tue, 19 Mar 1996 14:34:14 -0800
Received: from deliverator.sgi.com by neteng.engr.sgi.com via ESMTP (950413.SGI.8.6.12/940406.SGI.AUTO)
	for <lmlinux@neteng.engr.sgi.com> id OAA20513; Tue, 19 Mar 1996 14:34:13 -0800
Received: from caipfs.rutgers.edu by deliverator.sgi.com via ESMTP (951211.SGI.8.6.12.PATCH1042/951211.SGI.AUTO)
	for <lmlinux@neteng.engr.sgi.com> id OAA23098; Tue, 19 Mar 1996 14:12:16 -0800
Received: from huahaga.rutgers.edu (huahaga.rutgers.edu [128.6.155.53]) by caipfs.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) with ESMTP id QAA01124; Tue, 19 Mar 1996 16:22:28 -0500
Received: (davem@localhost) by huahaga.rutgers.edu (8.6.9+bestmx+oldruq+newsunq+grosshack/8.6.9) id QAA02688; Tue, 19 Mar 1996 16:22:27 -0500
Date: Tue, 19 Mar 1996 16:22:27 -0500
Message-Id: <199603192122.QAA02688@huahaga.rutgers.edu>
From: "David S. Miller" <davem@caip.rutgers.edu>
To: torvalds@cs.helsinki.fi
CC: lmlinux@neteng.engr.sgi.com
Subject: holy shit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


I just found a major bug which could have been massively affecting
performance on the sun4m.  New bench numbers soon hopefully.

Later,
David S. Miller
davem@caip.rutgers.edu
