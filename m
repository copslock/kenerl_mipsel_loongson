Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id KAA85881 for <linux-archive@neteng.engr.sgi.com>; Mon, 6 Jul 1998 10:40:14 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id KAA43900
	for linux-list;
	Mon, 6 Jul 1998 10:39:33 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id KAA59270
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 6 Jul 1998 10:39:31 -0700 (PDT)
	mail_from (shaver@netscape.com)
Received: from netscape.com (h-205-217-237-46.netscape.com [205.217.237.46]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id KAA15437
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Jul 1998 10:39:26 -0700 (PDT)
	mail_from (shaver@netscape.com)
Received: from tintin.mcom.com (tintin.mcom.com [205.217.233.42])
	by netscape.com (8.8.5/8.8.5) with ESMTP id KAA27602
	for <linux@cthulhu.engr.sgi.com>; Mon, 6 Jul 1998 10:39:25 -0700 (PDT)
Received: from netscape.com ([205.217.243.67]) by tintin.mcom.com
          (Netscape Messaging Server  4.0b2 )  with ESMTP id 0EVOP1O0.029;
          Mon, 6 Jul 1998 10:39:24 -0700
Message-ID: <35A10B96.9B47C150@netscape.com>
Date: Mon, 06 Jul 1998 13:38:30 -0400
From: Mike Shaver <shaver@netscape.com>
Organization: Mozilla Dot Weenies
X-Mailer: Mozilla 4.5 [en] (X11; I; Linux 2.0.34 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: ralf@uni-koblenz.de
CC: linux@cthulhu.engr.sgi.com
Subject: Re: mozilla on the Indy
References: <359A447B.2D25377D@netscape.com> <19980702041137.I3255@uni-koblenz.de>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

ralf@uni-koblenz.de wrote:
> Now that I've taken myself two minutes to browse your attached sources -
> the patches to the NSPR thread routines look suspicious.  The are
> playing games with the frame pointer which at least on the first look
> don't make sense as gcc automatically enables -fomit-frame-pointer when
> optimizing.

Turns out it's there only to save the FP so that you can use gdb to look
at the NSPR thread stacks during debugging.  So, the fact that gcc
removes it when building optimized isn't a problem.

For the record, NSPR threads aren't clone() threads; they're
setjmp/longjmp things.

Mike

-- 
517588.35 442847.89
