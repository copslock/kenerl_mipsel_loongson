Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) by neteng.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF) via ESMTP id DAA97618 for <linux-archive@neteng.engr.sgi.com>; Sat, 27 Feb 1999 03:08:21 -0800 (PST)
Return-Path: <owner-linux@cthulhu.engr.sgi.com>
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id DAA31359
	for linux-list;
	Sat, 27 Feb 1999 03:07:40 -0800 (PST)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id DAA20347
	for <linux@engr.sgi.com>;
	Sat, 27 Feb 1999 03:07:37 -0800 (PST)
	mail_from (milos@insync.net)
Received: from insync.net (vellocet.insync.net [204.253.208.10]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id DAA01537
	for <linux@engr.sgi.com>; Sat, 27 Feb 1999 03:07:37 -0800 (PST)
	mail_from (milos@insync.net)
Received: from insync.net (miloshm@209-113-28-46.insync.net [209.113.28.46]) by insync.net (8.9.3/8.7.1) with ESMTP id FAA05733 for <linux@engr.sgi.com>; Sat, 27 Feb 1999 05:07:35 -0600 (CST)
Message-ID: <36D7D1F6.506C5421@insync.net>
Date: Sat, 27 Feb 1999 11:07:34 +0000
From: Miles Lott <milos@insync.net>
Reply-To: milos@insync.net
Organization: KPRC
X-Mailer: Mozilla 4.5 [en] (X11; U; Linux 2.2.1 i586)
X-Accept-Language: en, ex-MX
MIME-Version: 1.0
To: "linux@cthulhu.engr.sgi.com" <linux@cthulhu.engr.sgi.com>
Subject: new to list - boot problem
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk

I have an Indy R5000, so says the case anyway.  I was able to setup
bootp/tftp/nfs.  I can mount the nfs dir from within IRIX.  I tried
booting from the nfs partition using bootp, and during the boot
message it seems to identify the machine and hardware ok.  Then I get
the "unable to open initial console" message( read: hang ).

I'm sure you have seen this before.  Have I buggered the unpacking
of HardHat?

TIA
