Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id LAA56866 for <linux-archive@neteng.engr.sgi.com>; Mon, 9 Nov 1998 11:26:03 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id LAA26405
	for linux-list;
	Mon, 9 Nov 1998 11:25:46 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from morgaine.engr.sgi.com (morgaine.engr.sgi.com [130.62.16.64])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA36207
	for <linux@cthulhu.engr.sgi.com>;
	Mon, 9 Nov 1998 11:25:44 -0800 (PST)
	mail_from (owner-linux@morgaine.engr.sgi.com)
Received: from cthulhu.engr.sgi.com (gate3-relay.engr.sgi.com [130.62.1.234]) by morgaine.engr.sgi.com (980427.SGI.8.8.8/960327.SGI.AUTOCF) via ESMTP id LAA16646 for <linux@morgaine.engr.sgi.com>; Mon, 9 Nov 1998 11:25:40 -0800 (PST)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id LAA33861
	for <linux@morgaine.engr.sgi.com>;
	Mon, 9 Nov 1998 11:25:39 -0800 (PST)
	mail_from (pattejam@webadept.com)
Received: from hankey.webadept.com (milhouse.webadept.com [199.77.41.169] (may be forged)) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id LAA09181
	for <linux@morgaine.engr.sgi.com>; Mon, 9 Nov 1998 11:25:38 -0800 (PST)
	mail_from (pattejam@webadept.com)
Received: from webadept.com (IDENT:pattejam@www.webadept.com [199.77.41.5])
	by hankey.webadept.com (8.9.0/8.8.7) with SMTP id MAA03413;
	Mon, 9 Nov 1998 12:23:40 -0500
Date: Mon, 9 Nov 1998 14:27:34 -0500 (EST)
From: Cory Patterson <pattejam@webadept.com>
To: 4819 <rmk@shell.mdc.net>
cc: linux@morgaine.engr.sgi.com
Subject: Re: Mouse Support.
In-Reply-To: <Pine.BSI.3.96.981109140907.12651A-100000@shell.mdc.net>
Message-ID: <Pine.LNX.3.96.981109141817.18435A-100000@webadept.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk


Tried that...

[pattejam@ike /dev]$ ls -al mouse
lrwxrwxrwx   1 root     root           10 Nov  6 15:06 mouse -> /dev/psaux

when i retart gpm, I get:

[pattejam@ike /dev]$ sudo /etc/rc.d/init.d/gpm start
Starting gpm mouse services: gpm gpm: /dev/mouse: Operation not supported
by device

here is a copy of my /etc/sysconfig/mouse file:

MOUSETYPE="ps/2"
XEMU3=yes


----------------------------------
Cory Patterson
   pattejam@webadept.com


On Mon, 9 Nov 1998, 4819 wrote:

> the regular PSAUX mouse support should work fine. works on my indy, no
> problem. it's a ps/2 mouse, it just looks funky. :-)
> 
> rob
> 
