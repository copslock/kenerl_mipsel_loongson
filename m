Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA26041 for <linux-archive@neteng.engr.sgi.com>; Thu, 15 Oct 1998 14:58:03 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA73043
	for linux-list;
	Thu, 15 Oct 1998 14:57:21 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA04884
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 15 Oct 1998 14:57:19 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: from calypso.saturn (dialup148-3-41.swipnet.se [130.244.148.169]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA02196
	for <linux@cthulhu.engr.sgi.com>; Thu, 15 Oct 1998 14:57:17 -0700 (PDT)
	mail_from (grim@zigzegv.ml.org)
Received: by zigzegv.ml.org
	via sendmail from stdin
	id <m0zTvPz-000w6YC@calypso.saturn> (Debian Smail3.2.0.101)
	for linux@cthulhu.engr.sgi.com; Thu, 15 Oct 1998 23:58:47 +0200 (CEST) 
Message-ID: <19981015235847.A2072@zigzegv.ml.org>
Date: Thu, 15 Oct 1998 23:58:47 +0200
From: Ulf Carlsson <grim@zigzegv.ml.org>
To: Kostadis Roussos <kostadis@sgi.com>
Cc: linux@cthulhu.engr.sgi.com
Subject: Re: Looking for mkfs for IRIX to build ext2 disk
References: <001501bdf86f$4c3e6de0$802aa696@wrlkamari.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 0.93.2
In-Reply-To: <001501bdf86f$4c3e6de0$802aa696@wrlkamari.engr.sgi.com>; from Kostadis Roussos on Thu, Oct 15, 1998 at 12:09:13PM -0700
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

On Thu, Oct 15, 1998 at 12:09:13PM -0700, Kostadis Roussos wrote:
> Hi!
> 
> 	Sorry for the newbie question, but does there exist a port to IRIX of the
> tools to build an ext2 partition?

Yep, they were part of the obsolete installer (by Alan Cox?).

Get /pub/mips-linux/GettingStarted/Linux-installer-0.2.tar.gz.

That package is *really* great and it has actually saved my ass quite a few
times (the possibility to open the ext2 partition and create a /dev/console and
is sometimes still needed, when Alex's hardhat installer is out of its mind).

- Ulf
