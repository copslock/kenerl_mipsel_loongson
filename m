Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (970321.SGI.8.8.5/960327.SGI.AUTOCF) via SMTP id GAA22412; Tue, 8 Jul 1997 06:32:17 -0700 (PDT)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo@localhost) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) id GAA02447 for linux-list; Tue, 8 Jul 1997 06:32:07 -0700
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37]) by cthulhu.engr.sgi.com (950413.SGI.8.6.12/960327.SGI.AUTOCF) via ESMTP id GAA02428 for <linux@cthulhu.engr.sgi.com>; Tue, 8 Jul 1997 06:32:04 -0700
Received: from caipfs.rutgers.edu (caipfs.rutgers.edu [128.6.155.100]) by sgi.sgi.com (950413.SGI.8.6.12/970507) via ESMTP id GAA13065
	for <linux@cthulhu.engr.sgi.com>; Tue, 8 Jul 1997 06:32:03 -0700
	env-from (davem@caipfs.rutgers.edu)
Received: from jenolan.caipgeneral (jenolan.rutgers.edu [128.6.111.5])
	by caipfs.rutgers.edu (8.8.5/8.8.5) with SMTP id JAA00491;
	Tue, 8 Jul 1997 09:32:02 -0400 (EDT)
Received: by jenolan.caipgeneral (SMI-8.6/SMI-SVR4)
	id JAA01013; Tue, 8 Jul 1997 09:29:55 -0400
Date: Tue, 8 Jul 1997 09:29:55 -0400
Message-Id: <199707081329.JAA01013@jenolan.caipgeneral>
From: "David S. Miller" <davem@jenolan.rutgers.edu>
To: ralf@mailhost.uni-koblenz.de
CC: ralf@mailhost.uni-koblenz.de, linux@cthulhu.engr.sgi.com
In-reply-to: <199707081017.MAA21226@informatik.uni-koblenz.de> (message from
	Ralf Baechle on Tue, 8 Jul 1997 12:17:11 +0200 (MET DST))
Subject: Re: MIPS Distribution status (Was: Status ...)
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Ok, looks like the mips-*-linux entry never made it into the top level
configure, the rest of the support code is in there though as
indicated by the __linux__ tests in mips.h
