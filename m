Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id CAA90538 for <linux-archive@neteng.engr.sgi.com>; Sun, 27 Dec 1998 02:05:45 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id CAA98568
	for linux-list;
	Sun, 27 Dec 1998 02:05:02 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id CAA14433
	for <linux@cthulhu.engr.sgi.com>;
	Sun, 27 Dec 1998 02:05:00 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from smtp1.casema.net (sun4000.casema.net [195.96.96.97]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id CAA08652
	for <linux@cthulhu.engr.sgi.com>; Sun, 27 Dec 1998 02:04:55 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from infopact.nl (9dyn196.breda.casema.net [195.96.116.196]) by smtp1.casema.net (8.9.1/CASEMA) with ESMTP id LAA13042 for <linux@cthulhu.engr.sgi.com>; Sun, 27 Dec 1998 11:04:53 +0100 (MET)
Posted-Date: Sun, 27 Dec 1998 11:04:53 +0100 (MET)
Message-ID: <36860751.B3725CD@infopact.nl>
Date: Sun, 27 Dec 1998 02:09:21 -0800
From: Richard Hartensveld <richard@infopact.nl>
X-Mailer: Mozilla 4.05C-SGI [en] (X11; I; IRIX 6.5 IP22)
MIME-Version: 1.0
To: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: return of the console on serial
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,

Compilation is all going well now, and when i boot my new kernel, it
says:

'console is ttyS0' (or ttyS1, that depends on the boot option)

But doesn't do anything with it it seems.

i'm still getting the 'unable to open initial console', which should be
the terminal on the serial port. Is this not supported yet??

Cheers,

Richard
