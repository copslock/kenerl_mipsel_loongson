Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id HAA43251 for <linux-archive@neteng.engr.sgi.com>; Tue, 22 Dec 1998 07:37:33 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id HAA79480
	for linux-list;
	Tue, 22 Dec 1998 07:36:41 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id HAA03517
	for <linux@cthulhu.engr.sgi.com>;
	Tue, 22 Dec 1998 07:36:39 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from smtp2.casema.net (ns1.casema.net [195.96.96.33]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id HAA02591
	for <linux@cthulhu.engr.sgi.com>; Tue, 22 Dec 1998 07:36:37 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from infopact.nl (9dyn123.breda.casema.net [195.96.116.123]) by smtp2.casema.net (8.9.1/CASEMA) with ESMTP id QAA04979 for <linux@cthulhu.engr.sgi.com>; Tue, 22 Dec 1998 16:36:32 +0100
Posted-Date: Tue, 22 Dec 1998 16:36:32 +0100
Message-ID: <367FBD86.BEC2F68F@infopact.nl>
Date: Tue, 22 Dec 1998 07:40:54 -0800
From: Richard Hartensveld <richard@infopact.nl>
X-Mailer: Mozilla 4.05C-SGI [en] (X11; I; IRIX 6.5 IP22)
MIME-Version: 1.0
To: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: crosscompiling for r5k.
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

I'm having problems crosscompiling a kernel for my challenge s (180mhz
R5000).

I had this problem before but lost the solution during a harddisk
crash.

Is it normal that when you configure for a r5k, gcc uses the
'-mcpu=r8000' option?.
When i compile, i get a kernel, only it won't boot.

i am compiling on i386.

Some of you have come up with a fix the last time, only i haven't got it
anymore, anyone that
could help ?

Richard
