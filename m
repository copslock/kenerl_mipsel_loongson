Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id TAA378479 for <linux-archive@neteng.engr.sgi.com>; Wed, 18 Feb 1998 19:47:46 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id TAA23272 for linux-list; Wed, 18 Feb 1998 19:47:05 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id TAA23262 for <linux@cthulhu.engr.sgi.com>; Wed, 18 Feb 1998 19:47:03 -0800
Received: from note.orchestra.cse.unsw.EDU.AU (note.orchestra.cse.unsw.EDU.AU [129.94.242.29]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via SMTP id TAA15676
	for <linux@cthulhu.engr.sgi.com>; Wed, 18 Feb 1998 19:47:01 -0800
	env-from (conradp@cse.unsw.edu.au)
Received: From haydn With LocalMail ; Thu, 19 Feb 98 14:46:30 +1100 
From: "K." <conradp@cse.unsw.edu.au>
To: Brendan Black <ratfink@xtra.co.nz>
Date: Thu, 19 Feb 1998 14:46:30 +1100 (EST)
X-Sender: conradp@haydn.orchestra.cse.unsw.EDU.AU
cc: linux@cthulhu.engr.sgi.com
Subject: Re: L4 microkernel on MIPS R4x00 freely available in source form
In-Reply-To: <34EBA0DD.8A794A6D@xtra.co.nz>
Message-ID: <Pine.GSO.3.95.980219143200.18049F-100000@haydn.orchestra.cse.unsw.EDU.AU>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, 19 Feb 1998, Brendan Black wrote:

> I thought a few people might be interested in this, it is reported to
> run on R4600 Indy and some of you may know that Linux has been ported to
> the Intel version of L4
> 
> see http://www.cse.unsw.edu.au/+AH4-disy/L4/ for the MIPS version info

http://www.cse.unsw.edu.au/~disy/L4/

We (myself and Andrew O'Brien) are working on the Linux port to L4/MIPS. 
We are currently working on a custom 4600 board (not on an Indy, but the
L4 servers are compatible). L4/MIPS is subtly different to L4/Intel
(different system calls) so don't expect the L4/Intel port to work out of
the box.

If anyone is interested in the Linux port, let us know. The L4/MIPS source
(developed by Kevin Elphinstone) is available under GPL at the above
address. 


Conrad Parker  conradp@cse.unsw.edu.au
Andrew O'Brien andrewo@cse.unsw.edu.au
