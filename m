Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id EAA89984 for <linux-archive@neteng.engr.sgi.com>; Thu, 17 Dec 1998 04:21:05 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id EAA67118
	for linux-list;
	Thu, 17 Dec 1998 04:20:26 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id EAA67101
	for <linux@cthulhu.engr.sgi.com>;
	Thu, 17 Dec 1998 04:20:24 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from smtp2.casema.net (ns1.casema.net [195.96.96.33]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id EAA08322
	for <linux@cthulhu.engr.sgi.com>; Thu, 17 Dec 1998 04:20:22 -0800 (PST)
	mail_from (richard@infopact.nl)
Received: from infopact.nl (9dyn214.breda.casema.net [195.96.116.214]) by smtp2.casema.net (8.9.1/CASEMA) with ESMTP id NAA17710 for <linux@cthulhu.engr.sgi.com>; Thu, 17 Dec 1998 13:20:10 +0100
Posted-Date: Thu, 17 Dec 1998 13:20:10 +0100
Message-ID: <3678F801.C399874F@infopact.nl>
Date: Thu, 17 Dec 1998 04:24:34 -0800
From: Richard Hartensveld <richard@infopact.nl>
X-Mailer: Mozilla 4.05C-SGI [en] (X11; I; IRIX 6.5 IP22)
MIME-Version: 1.0
To: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: console on serial
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Hi,


Is it possible to get a console on the serial port with the hardhat
package ?.

I'm trying to get linux installed on a challenge S, which has no video
board, all goes pretty
well until i get into userland and the kernel wants to open
/dev/console, which i would
like to be a terminal on the serial port, is this possible?


Regards,

Richard Hartensveld
