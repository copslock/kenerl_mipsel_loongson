Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA35826 for <linux-archive@neteng.engr.sgi.com>; Fri, 17 Jul 1998 10:47:34 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA19730
	for linux-list;
	Fri, 17 Jul 1998 10:47:11 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from xtp.engr.sgi.com (xtp.engr.sgi.com [150.166.75.34])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via SMTP id KAA82271
	for <linux@cthulhu.engr.sgi.com>;
	Fri, 17 Jul 1998 10:47:09 -0700 (PDT)
	mail_from (greg@xtp.engr.sgi.com)
Received: by xtp.engr.sgi.com (950413.SGI.8.6.12/911001.SGI)
	 id KAA18722; Fri, 17 Jul 1998 10:47:02 -0700
From: "Greg Chesson" <greg@xtp.engr.sgi.com>
Message-Id: <9807171047.ZM18720@xtp.engr.sgi.com>
Date: Fri, 17 Jul 1998 10:47:02 -0700
In-Reply-To: "William J. Earl" <wje@fir>
        "Re: What about..." (Jul 17,  7:11am)
References: <Pine.LNX.3.95.980717012356.5792A-100000@lager.engsoc.carleton.ca> 
	<adevries@engsoc.carleton.ca> 
	<9807162230.ZM17359@xtp.engr.sgi.com> 
	<199807171411.HAA11412@fir.engr.sgi.com>
X-Mailer: Z-Mail (3.2.3 08feb96 MediaMail)
To: "William J. Earl" <wje@fir.engr.sgi.com>,
        Alex deVries <adevries@engsoc.carleton.ca>,
        Igor Loncarevic <anubis@BanjaLuka.NET>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: What about...
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Bill is, of course, quite correct.
In addition to the observations about the scale of the system,
realize also that a ccNUMA machine has a memory system for each
cpu node in the system.  The physical base addresses of these blocks
of memory are aligned on multi-gigabyte boundaries.  The high-order
bits of the address designate the cpu node, the rest address the physical
memory, etc etc.  What this means is that physical memory space has
many "holes"...  The idea of a simple buddy-system allocator as is
ingrained in the Linux kernel falls apart completely in the face of
this kind of architecture.   I suppose you could run a copy of Linux
on every node, but I consider that an excuse rather than a solution.

g



-- 
Greg Chesson
