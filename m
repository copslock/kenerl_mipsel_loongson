Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id RAA02213 for <linux-archive@neteng.engr.sgi.com>; Tue, 30 Jun 1998 17:27:18 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id RAA23755
	for linux-list;
	Tue, 30 Jun 1998 17:26:25 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id RAA42254
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 30 Jun 1998 17:26:24 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) 
	by sgi.sgi.com (980309.SGI.8.8.8-aspam-6.2/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id RAA19997
	for <linux@cthulhu.engr.sgi.com>; Tue, 30 Jun 1998 17:26:22 -0700 (PDT)
	mail_from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (root@pmport-27.uni-koblenz.de [141.26.249.27])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id CAA00952
	for <linux@cthulhu.engr.sgi.com>; Wed, 1 Jul 1998 02:26:20 +0200 (MEST)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id GAA04222;
	Tue, 30 Jun 1998 06:56:06 +0200
Message-ID: <19980630065605.A4050@uni-koblenz.de>
Date: Tue, 30 Jun 1998 06:56:05 +0200
To: Alex deVries <adevries@engsoc.carleton.ca>,
        SGI Linux <linux@cthulhu.engr.sgi.com>
Subject: Re: The mouse issue...
References: <Pine.LNX.3.95.980628232855.24323A-100000@lager.engsoc.carleton.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.91.1
In-Reply-To: <Pine.LNX.3.95.980628232855.24323A-100000@lager.engsoc.carleton.ca>; from Alex deVries on Mon, Jun 29, 1998 at 12:08:07AM -0400
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Mon, Jun 29, 1998 at 12:08:07AM -0400, Alex deVries wrote:

> Alright.  So I went through to see if I could locate anywhere in the
> kernel where there might be problems with psaux.  I recompiled, stuck some
> printk's in, and I got: Nothing.  Nadda.  Zip.  The whole machine hangs
> (including num lock).
> 
> When I do a 'cat /dev/psaux', the printk's prove that the open works fine.
> Then in the first read, it attempts to do a schedule().  So far, no
> problem, the system is still up.  But it never comes out of the
> schedule(), and a subsequent mouse input hangs the system (or the
> keyboard, anyway).
> 
> Ideas? 

Mouse interrupts where looping.  Fixed, gpm works now.

There I small uglyness in gpm when using it with certain types of mouse
like PS/2 mice which are available with two or three buttons.  Until
the optional third middle button has been used for the first time gpm
doesn't know that it's using a three button mouse.  So the right button
changes it's meaning when the middle one has been pressed.  Just a
small thing and it affects all architectures anyway.

  Ralf
