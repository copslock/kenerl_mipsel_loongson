Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id DAA482822; Tue, 19 Aug 1997 03:41:03 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id DAA28690 for linux-list; Tue, 19 Aug 1997 03:39:08 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id DAA28670 for <linux@cthulhu.engr.sgi.com>; Tue, 19 Aug 1997 03:39:01 -0700
Received: from aec.at (web.aec.at [193.170.192.5]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id DAA22299
	for <linux@cthulhu.engr.sgi.com>; Tue, 19 Aug 1997 03:38:57 -0700
	env-from (oliver@aec.at)
Received: (from oliver@localhost) by aec.at (8.8.3/8.7) id MAA07720; Tue, 19 Aug 1997 12:38:27 +0200
Date: Tue, 19 Aug 1997 12:38:27 +0200 (MET DST)
From: Oliver Frommel <oliver@aec.at>
To: Mike Shaver <shaver@neon.ingenia.ca>
cc: linux@cthulhu.engr.sgi.com
Subject: Re: boot linux - wish
In-Reply-To: <199708152053.QAA24515@neon.ingenia.ca>
Message-ID: <Pine.LNX.3.91.970819123304.7569A-100000@web.aec.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

> 
> Oliver is working on fdisk, I believe.
> Last I heard, he was working on the geometry-query issue.  Oliver?
>

yes. i've started to work on fdisk and tried to figure out
why fdisk returned "wrong" disk parameters (this was an issue on kernel-dev a 
 while ago) and digged through the low and mid level block device drivers.
unfortunately the indy i was using is now being used for some other project
until mid september :(

oliver
