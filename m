Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (971110.SGI.8.8.8/960327.SGI.AUTOCF) via SMTP id PAA42176 for <linux-archive@neteng.engr.sgi.com>; Sun, 25 Jan 1998 15:43:37 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id PAA08774 for linux-list; Sun, 25 Jan 1998 15:41:08 -0800
Received: from hollywood.engr.sgi.com (hollywood.engr.sgi.com [150.166.61.38]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA08759 for <linux@cthulhu.engr.sgi.com>; Sun, 25 Jan 1998 15:41:06 -0800
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by hollywood.engr.sgi.com (940816.SGI.8.6.9/960327.SGI.AUTOCF) via ESMTP id PAA02070; Sun, 25 Jan 1998 15:41:01 -0800
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id PAA08723; Sun, 25 Jan 1998 15:40:56 -0800
Received: from informatik.uni-koblenz.de (mailhost.uni-koblenz.de [141.26.4.1]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id PAA15562; Sun, 25 Jan 1998 15:40:54 -0800
	env-from (ralf@uni-koblenz.de)
From: ralf@uni-koblenz.de
Received: from uni-koblenz.de (pmport-18.uni-koblenz.de [141.26.249.18])
	by informatik.uni-koblenz.de (8.8.8/8.8.8) with ESMTP id AAA25477;
	Mon, 26 Jan 1998 00:40:52 +0100 (MET)
Received: (from ralf@localhost)
	by uni-koblenz.de (8.8.7/8.8.7) id TAA03221;
	Sun, 25 Jan 1998 19:14:45 +0100
Message-ID: <19980125191445.00880@uni-koblenz.de>
Date: Sun, 25 Jan 1998 19:14:45 +0100
To: fisher@sgi.com
Cc: Alex deVries <adevries@engsoc.carleton.ca>, alan@lxorguk.ukuu.org.uk,
        linux@hollywood.engr.sgi.com,
        William Fisher <fisher@hollywood.engr.sgi.com>
Subject: Re: wd33c93 errors.
References: <Pine.LNX.3.95.980122175054.21753I-100000@lager.engsoc.carleton.ca> <199801230012.QAA28870@hollywood.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.85e
In-Reply-To: <199801230012.QAA28870@hollywood.engr.sgi.com>; from William Fisher on Thu, Jan 22, 1998 at 04:12:18PM -0800
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Jan 22, 1998 at 04:12:18PM -0800, William Fisher wrote:

> 	I am getting the details but it seems that something is amiss
> 	with the "standard" PC SCSI devices in this area. There is also
> 	some fuzzy-ness going on in the device type they are advertizing
> 	themselves to be. I will have the gory details shortly since we
> 	would like to understand the problem. We have had a couple of
> 	customers complain about this problem.

Certain revisions of the wd33c93 recognicable by the number group 00-04
and the word PROTO printed on them (at least in the DIL case) have a
problem in the microcode that may hang the chip until the next hardware
reset.  Unfortunately tons of these prototype versions have been shipped.
The only way to run these chips reliable is to disable disconnect/reconnect.
By my experience it looks as if not all devices produce that type of
disconnect/reconnect bug.  I never saw it happen for example during
lowlevel formatting a SCSI disk but attempting to use disconnect/reconnect
with QIC tapes was a 100% way for me to hang my system.  No idea about
other types of devices.

  Ralf
