Received: from pneumatic-tube.sgi.com (pneumatic-tube.sgi.com [204.94.214.22])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id XAA31065
	for <pstadt@stud.fh-heilbronn.de>; Fri, 1 Oct 1999 23:24:44 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by pneumatic-tube.sgi.com (980327.SGI.8.8.8-aspam/980310.SGI-aspam) via ESMTP id OAA05140; Fri, 1 Oct 1999 14:21:50 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA97806
	for linux-list;
	Fri, 1 Oct 1999 14:10:55 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from oz.engr.sgi.com (oz.engr.sgi.com [150.166.42.13])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA03404
	for <linux@engr.sgi.com>;
	Fri, 1 Oct 1999 14:10:53 -0700 (PDT)
	mail_from (ariel@oz.engr.sgi.com)
Received: (from ariel@localhost) by oz.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) id OAA12471 for linux@engr.sgi.com; Fri, 1 Oct 1999 14:10:53 -0700 (PDT)
From: ariel@oz.engr.sgi.com (Ariel Faigon)
Message-Id: <199910012110.OAA12471@oz.engr.sgi.com>
Subject: Re: (offtopic) sgi hard drive problem
To: linux@cthulhu.engr.sgi.com (SGI/Linux mailing list)
Date: Fri, 1 Oct 1999 14:10:52 -0700 (PDT)
Reply-To: ariel@cthulhu.engr.sgi.com (Ariel Faigon)
Organization: Silicon Graphics Inc.
X-Mailer: ELM [version 2.4 PL25]
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit


[Just trying to help: forwarding this bounce from Alex Kozlov, thanks Alex]

:Subject: Re: sgi hard drive problem.
:In-Reply-To: <Pine.GSO.3.96.991001142618.11A-100000@yacht.ee.fit.edu> from Can Altineller at "Oct 1, 99 03:25:36 pm"
:To: altine@yacht.ee.fit.edu (Can Altineller)
:Date: Fri, 1 Oct 1999 13:14:43 -0700 (PDT)
:Cc: linux@cthulhu.engr.sgi.com
:WWW-page: http://robotics.stanford.edu/~alexvk
:From: alexvk@sgi.com
:MIME-Version: 1.0
:Content-Type: text/plain; charset=US-ASCII
:Content-Transfer-Encoding: 7bit
:
:You need to make a new IRIX boot disk (by using some other SGI
:computer):
:
:- boot up a system to single user mode
:
:- do fx to partition the second disk as a root disk
:
:- make file system on the second disk and mount the file system
:
:- copy sash to the new disk
:
:# fx "dksc(0,2)"
:# mkfs /dev/rdsk/dks0d2s0
:# mount /dev/dsk/dks0d2s0 /mnt
:# /sbin/dvhtool -v g sash sash; /sbin/dvhtool -v c sash sash /dev/rdsk/dks0d2vh
:# rm sash
:
:The problem obviously is that Linux erased your IRIX boot record and
:partitions.
:
:--
:Alexander V. Kozlov | alexvk@engr.sgi.com | (650) 933-8493
:


-- 
Peace, Ariel
