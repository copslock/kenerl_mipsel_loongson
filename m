Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id OAA30042 for <linux-archive@neteng.engr.sgi.com>; Thu, 7 Jan 1999 14:08:38 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id OAA83209
	for linux-list;
	Thu, 7 Jan 1999 14:07:08 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id OAA67534
	for <linux@engr.sgi.com>;
	Thu, 7 Jan 1999 14:07:05 -0800 (PST)
	mail_from (billc@netcommunity.com)
Received: from ns1.netcommunity.com (ns1.netcommunity.com [198.212.27.192]) 
	by sgi.sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id OAA04577
	for <linux@engr.sgi.com>; Thu, 7 Jan 1999 14:07:03 -0800 (PST)
	mail_from (billc@netcommunity.com)
Received: from netcommunity.com ([149.174.154.165]) by ns1.netcommunity.com
          (Netscape Messaging Server 3.01)  with ESMTP id AAA26092
          for <linux@engr.sgi.com>; Thu, 7 Jan 1999 17:02:34 -0500
Message-ID: <3695312F.E6260C7A@netcommunity.com>
Date: Thu, 07 Jan 1999 17:11:59 -0500
From: "Bill Chatfield" <billc@netcommunity.com>
Organization: Internet Media Properties
X-Mailer: Mozilla 4.04 [en] (WinNT; I)
MIME-Version: 1.0
To: SGI Linux Mailing List <linux@cthulhu.engr.sgi.com>
Subject: Install Problems
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

Is anyone still working on the SGI/Linux port?

I'm trying to get SGI/Linux (Hard Hat 5.1) working on an Indy.  I've
followed all the instructions very carefully.  The kernel booted and ran
correctly for the install, but when I rebooted after the install, the
system doesn't come up correctly.

I've been through the mailing list archive and couldn't find something
similiar to the problem I'm having.  So, I'm hoping someone can help me
out.

The kernel seems to boot mostly, but I think the console gets stuck and
stops scrolling so I can't see what is happening.  The reason that I
think this is because it just stops printing anything to the console,
but the machine comes up well enough to ping it.  Telet and ftp to the
machine result in a connection refused error.

I've tried to run the install process again so I can get a working
kernel so I can mount my hard disk to see what the problem might be, but
I can't figure out how to get the disk mounted from another virtual
console during the install process.  'mount' is not available.  The
virtual consoles don't seem to work right because they don't scroll, so
you can only see the first screen of text.

I'd really like to get this working.  If I can, I've got two other Indys
and two Challenge S servers that I'd like to try it on.

I'd appreciate anything you can suggest...  Thanks!

-- 
Bill Chatfield
Internet Media Properties
billc@netcommunity.com
