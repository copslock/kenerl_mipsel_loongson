Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA43815 for <linux-archive@neteng.engr.sgi.com>; Sun, 19 Jul 1998 02:12:48 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA36153
	for linux-list;
	Sun, 19 Jul 1998 02:12:01 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA48545
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 19 Jul 1998 02:11:58 -0700 (PDT)
	mail_from (sgi.sgi.com!rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from rachael.franken.de (rachael.franken.de [193.175.24.38]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA24913
	for <linux@cthulhu.engr.sgi.com>; Sun, 19 Jul 1998 02:11:56 -0700 (PDT)
	mail_from (rachael.franken.de!hub-fue!alpha.franken.de!tsbogend)
Received: from hub-fue by rachael.franken.de
	via rmail with uucp
	id <m0yxpVa-0027qTC@rachael.franken.de>
	for cthulhu.engr.sgi.com!linux; Sun, 19 Jul 1998 11:11:54 +0200 (MET DST)
	(Smail-3.2 1996-Jul-4 #4 built DST-Sep-8)
Received: by hub-fue.franken.de (Smail3.1.29.1 #35)
	id m0yxpVS-002OmBC; Sun, 19 Jul 98 11:11 MET DST
Received: (from tsbogend@localhost)
	by alpha.franken.de (8.8.7/8.8.5) id LAA00785;
	Sun, 19 Jul 1998 11:00:32 +0200
Message-ID: <19980719110032.00526@alpha.franken.de>
Date: Sun, 19 Jul 1998 11:00:32 +0200
From: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
To: ralf@uni-koblenz.de
Cc: Michael Engel <engel@numerik.math.uni-siegen.de>, linux-mips@fnet.fr,
        linux@cthulhu.engr.sgi.com
Subject: Re: ext2fs corruptions and other things ...
References: <199807182253.AAA10366@jordan.numerik> <19980719023421.A489@uni-koblenz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85
In-Reply-To: <19980719023421.A489@uni-koblenz.de>; from ralf@uni-koblenz.de on Sun, Jul 19, 1998 at 02:34:21AM +0200
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Sun, Jul 19, 1998 at 02:34:21AM +0200, ralf@uni-koblenz.de wrote:
> On Sun, Jul 19, 1998 at 12:53:14AM +0200, Michael Engel wrote:
> Quite some time Thomas commited a patch to arch/mips/kernel/irc.c which was
> actually supposed to fix the probing problem, maybe he can comment.

I couldn't even remember, that I did something in that area:-) I've looked
up in CVS, what I did there, and as far as I remeber it fixed autoprobing
for me (my NE2000 gets the interrupt via autoprobing). Maybe it's time
to check whether it still works.

> We actually had more reports about problems with filesystems on /dev/sdx
> on Indys.  There seems to be a clear pattern of a bug, but for now I
> classify that one as lower priority.

I've never got any filesystem corruption on my Olli. And I've crashed it
pretty often, when doing the XF68_FBDev stuff.

Thomas.

-- 
See, you not only have to be a good coder to create a system like Linux,
you have to be a sneaky bastard too ;-)
                   [Linus Torvalds in <4rikft$7g5@linux.cs.Helsinki.FI>]
