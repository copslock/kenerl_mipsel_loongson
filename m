Received: from sgi.com (sgi.SGI.COM [192.48.153.1])
	by lara.stud.fh-heilbronn.de (8.9.1a/8.9.1) with ESMTP id AAA02643
	for <pstadt@stud.fh-heilbronn.de>; Mon, 28 Jun 1999 00:30:45 +0200
Received: from cthulhu.engr.sgi.com (cthulhu.engr.sgi.com [192.26.80.2]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA04187; Sun, 27 Jun 1999 15:28:21 -0700 (PDT)
	mail_from (owner-linux@cthulhu.engr.sgi.com)
Received: (from majordomo-owner@localhost)
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	id PAA21374
	for linux-list;
	Sun, 27 Jun 1999 15:22:16 -0700 (PDT)
	mail_from (owner-linux@relay.engr.sgi.com)
Received: from sgi.com (sgi.engr.sgi.com [192.26.80.37])
	by cthulhu.engr.sgi.com (980427.SGI.8.8.8/970903.SGI.AUTOCF)
	via ESMTP id PAA81770
	for <linux@engr.sgi.com>;
	Sun, 27 Jun 1999 15:22:14 -0700 (PDT)
	mail_from (andy@derfel99.freeserve.co.uk)
Received: from mail3.svr.pol.co.uk (mail3.svr.pol.co.uk [195.92.193.19]) 
	by sgi.com (980327.SGI.8.8.8-aspam/980304.SGI-aspam:
       SGI does not authorize the use of its proprietary
       systems or networks for unsolicited or bulk email
       from the Internet.) 
	via ESMTP id PAA07231
	for <linux@engr.sgi.com>; Sun, 27 Jun 1999 15:22:13 -0700 (PDT)
	mail_from (andy@derfel99.freeserve.co.uk)
Received: from modem-65.thalidomide.dialup.pol.co.uk ([62.136.88.193] helo=snafu)
	by mail3.svr.pol.co.uk with smtp (Exim 2.12 #1)
	id 10yNJT-0007uu-00
	for linux@engr.sgi.com; Sun, 27 Jun 1999 23:22:11 +0100
Message-ID: <001401bec0eb$87774220$0a02030a@snafu>
From: "Andrew Linfoot" <andy@derfel99.freeserve.co.uk>
To: "linux" <linux@cthulhu.engr.sgi.com>
Subject: CVS Woes
Date: Sun, 27 Jun 1999 23:22:21 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2314.1300
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2314.1300
Sender: owner-linux@cthulhu.engr.sgi.com
Precedence: bulk
Content-Transfer-Encoding: 7bit

Hi All,

My situation:

DEC Alpha running NT and Internal modem
samba share on my indy source tree

I can connect to cvs@linus and do a cvs update. The problem is that samba or
cvs appears to be converting the files to the DOS CR/LF format! and then
everything breaks horribly.

How can i get around this?

Anyone got a script or something that will strip this crap out!


Andy
